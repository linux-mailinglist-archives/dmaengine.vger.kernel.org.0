Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925EE15DEFC
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbgBNQGl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 11:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbgBNQGk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Feb 2020 11:06:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C97524650;
        Fri, 14 Feb 2020 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696399;
        bh=Aa4LQc/fQ6MQQpm24YQGRNw2rQxRYku0iwSvM44nrAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSckwMlYxEp8aVA6+Fg39/5qxUJpy7s9xJzTaIwHXMedCJr6qWYeAyOaSzo01hjv5
         qnwOmXRyQ6+n8CdEFWBUL6tGj+qOP/5cXlQGOBWbk9iGAcLLGyqul+/PD3F8Q4z0yC
         x8b57o2/4A0jEJJPiZz1A2Lcw/2UnPgwW1WcTofI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 224/459] dmaengine: Store module owner in dma_device struct
Date:   Fri, 14 Feb 2020 10:57:54 -0500
Message-Id: <20200214160149.11681-224-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit dae7a589c18a4d979d5f14b09374e871b995ceb1 ]

dma_chan_to_owner() dereferences the driver from the struct device to
obtain the owner and call module_[get|put](). However, if the backing
device is unbound before the dma_device is unregistered, the driver
will be cleared and this will cause a NULL pointer dereference.

Instead, store a pointer to the owner module in the dma_device struct
so the module reference can be properly put when the channel is put, even
if the backing device was destroyed first.

This change helps to support a safer unbind of DMA engines.
If the dma_device is unregistered in the driver's remove function,
there's no guarantee that there are no existing clients and a users
action may trigger the WARN_ONCE in dma_async_device_unregister()
which is unlikely to leave the system in a consistent state.
Instead, a better approach is to allow the backing driver to go away
and fail any subsequent requests to it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Link: https://lore.kernel.org/r/20191216190120.21374-2-logang@deltatee.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dmaengine.c   | 4 +++-
 include/linux/dmaengine.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 03ac4b96117cd..4b604086b1b3a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -179,7 +179,7 @@ __dma_device_satisfies_mask(struct dma_device *device,
 
 static struct module *dma_chan_to_owner(struct dma_chan *chan)
 {
-	return chan->device->dev->driver->owner;
+	return chan->device->owner;
 }
 
 /**
@@ -919,6 +919,8 @@ int dma_async_device_register(struct dma_device *device)
 		return -EIO;
 	}
 
+	device->owner = device->dev->driver->owner;
+
 	if (dma_has_cap(DMA_MEMCPY, device->cap_mask) && !device->device_prep_dma_memcpy) {
 		dev_err(device->dev,
 			"Device claims capability %s, but op is not defined\n",
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index dad4a68fa0094..8013562751a50 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -674,6 +674,7 @@ struct dma_filter {
  * @fill_align: alignment shift for memset operations
  * @dev_id: unique device ID
  * @dev: struct device reference for dma mapping api
+ * @owner: owner module (automatically set based on the provided dev)
  * @src_addr_widths: bit mask of src addr widths the device supports
  *	Width is specified in bytes, e.g. for a device supporting
  *	a width of 4 the mask should have BIT(4) set.
@@ -737,6 +738,7 @@ struct dma_device {
 
 	int dev_id;
 	struct device *dev;
+	struct module *owner;
 
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
-- 
2.20.1

