Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C127338934
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfFGLio (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 07:38:44 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:37464 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfFGLin (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 07:38:43 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id Mneg2000b3XaVaC06neggA; Fri, 07 Jun 2019 13:38:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZDCi-0004GK-Pk; Fri, 07 Jun 2019 13:38:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZDCi-00040j-OF; Fri, 07 Jun 2019 13:38:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] dmaengine: Create symlinks from DMA channels to slaves
Date:   Fri,  7 Jun 2019 13:38:35 +0200
Message-Id: <20190607113835.15376-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently it is not easy to find out which DMA channels are in use, and
by which slave devices.

Fix this by creating in sysfs a "slave" symlink from the DMA channel to
the actual slave device when a channel is requested, and removing it
again when the channel is released.

For now this is limited to DT and ACPI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Questions:
  1. Do you think this is useful?
  2. Should backlinks (e.g. "dma:<name>") be created from the slave
     device to the DMA channel?
     This requires storing the name in struct dma_chan, for later
     symlink removal.
  3. Should this be extended to other ways of requesting channels?
     In many cases, no device pointer is available, so a device pointer
     parameter has to be added to all DMA channel request APIs that
     don't have it yet.
---
 drivers/dma/dmaengine.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 03ac4b96117cd8db..c11476f76fc96bcf 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -706,6 +706,10 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 
 	if (chan) {
 		/* Valid channel found or requester needs to be deferred */
+		if (!IS_ERR(chan) &&
+		     sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
+				       "slave"))
+			dev_err(dev, "Cannot create DMA slave symlink\n");
 		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
 			return chan;
 	}
@@ -786,6 +790,7 @@ void dma_release_channel(struct dma_chan *chan)
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
+	sysfs_remove_link(&chan->dev->device.kobj, "slave");
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
-- 
2.17.1

