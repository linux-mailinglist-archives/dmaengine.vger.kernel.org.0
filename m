Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60134129D96
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2019 06:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfLXFDk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Dec 2019 00:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfLXFDk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Dec 2019 00:03:40 -0500
Received: from localhost.localdomain (unknown [122.167.68.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF1C20718;
        Tue, 24 Dec 2019 05:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577163819;
        bh=b3d3xrkLIusWswr28twHM/07xXqMtj1qpLrIJ3OenVI=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5ugSBcWJsbjNHp9hQmvoT1E8umDRLuwdgWUMrqvrjJK2XM05ukUj4ocqEbe31eTR
         Bohlr1ixgNi9jeqZH8VcV4CvIUPrI0fVGtqFKeo9EKMoMs+GT3R/Uu9t25S2B8RbYP
         1NRxCJsO/d0SXXCisxqxiUiTL6W0Oi1wttoaPb7o=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 1/2] dmaengine: move module_/dma_device_put() after route free
Date:   Tue, 24 Dec 2019 10:33:25 +0530
Message-Id: <20191224050326.3481588-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We call dma_device_put() and module_put() after invoking
.device_free_chan_resources callback, but we should also take care of
router devices and invoke this after .route_free callback. So move it
after .route_free

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dmaengine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e316abe3672d..0505ea5b002f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -427,15 +427,15 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->device->device_free_chan_resources(chan);
 	}
 
-	dma_device_put(chan->device);
-	module_put(dma_chan_to_owner(chan));
-
 	/* If the channel is used via a DMA request router, free the mapping */
 	if (chan->router && chan->router->route_free) {
 		chan->router->route_free(chan->router->dev, chan->route_data);
 		chan->router = NULL;
 		chan->route_data = NULL;
 	}
+
+	dma_device_put(chan->device);
+	module_put(dma_chan_to_owner(chan));
 }
 
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
-- 
2.23.0

