Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A03CBBCC
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jul 2021 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhGPSZm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jul 2021 14:25:42 -0400
Received: from phobos.denx.de ([85.214.62.61]:51458 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPSZl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Jul 2021 14:25:41 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 64F6D82BE8;
        Fri, 16 Jul 2021 20:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626459765;
        bh=/7JOK2DOQ1jrCqA8oGoP6+ZDHVle9/SriRJJeSUTQK4=;
        h=From:To:Cc:Subject:Date:From;
        b=shSzfDk75D5ZME4ryi00CVO1Djkeajtuy5kq8QaUn2XvRaJppdHtFQrqQxsIu7w3R
         dmBCUFdn7pleSZqA9YwtzXLaV585eP0n3ggNKWglvKzRYv0iV3GFMi9TXyTUqQPjSY
         9DEJ4tEp1/4EbKSpglkFOxTghr+5p+UDLDw3WHUVRXLfxPNWcHfI3XfIy2KsU1ixGE
         wSvyaXjprXKZSurSVRa/lSeViFrmnSTgWxasbVSBUOLt9NwCcJpno2O5Egv+pU+zKU
         ZAffwehKfp/mZ9e9XNqWosi6WIP7WgHH6Geokdns1whpkj0gqZoaXLkwOgomb9IJ1h
         /koC5egTi54VA==
From:   Marek Vasut <marex@denx.de>
To:     dmaengine@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] dmaengine: xilinx: Add empty device_config function
Date:   Fri, 16 Jul 2021 20:22:41 +0200
Message-Id: <20210716182241.218705-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Various DMA users call the dmaengine_slave_config() and expect it to
succeed, but that can only succeed if .device_config is implemented.
Add empty device_config function rather than patching all the places
which use dmaengine_slave_config().

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 4b9530a7bf65..d6f4bf0d50e8 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1658,6 +1658,17 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
+/**
+ * xilinx_dma_issue_pending - Configure the DMA channel
+ * @dchan: DMA channel
+ * @config: channel configuration
+ */
+static int xilinx_dma_device_config(struct dma_chan *dchan,
+				    struct dma_slave_config *config)
+{
+	return 0;
+}
+
 /**
  * xilinx_dma_complete_descriptor - Mark the active descriptor as complete
  * @chan : xilinx DMA channel
@@ -3096,6 +3107,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_synchronize = xilinx_dma_synchronize;
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
+	xdev->common.device_config = xilinx_dma_device_config;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.30.2

