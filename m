Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2AB1F83C9
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jun 2020 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFMO67 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 13 Jun 2020 10:58:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54568 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFMO67 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 13 Jun 2020 10:58:59 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49kghw20w1z1rqqS;
        Sat, 13 Jun 2020 16:58:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49kghw1Yjdz1qql0;
        Sat, 13 Jun 2020 16:58:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id r8qG_uSTDhDk; Sat, 13 Jun 2020 16:58:55 +0200 (CEST)
X-Auth-Info: KT599NjT1nOTA2TRt2tDZYiWZKN2UTsKf8ZyNWJt27c=
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz [86.49.35.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 13 Jun 2020 16:58:55 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     dmaengine@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] dmaengine: xilinx: Add empty device_config function
Date:   Sat, 13 Jun 2020 16:58:42 +0200
Message-Id: <20200613145842.113671-1-marex@denx.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
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
index 5429497d3560b..058150ff9e0d9 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1637,6 +1637,17 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
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
@@ -3076,6 +3087,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_terminate_all = xilinx_dma_terminate_all;
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
+	xdev->common.device_config = xilinx_dma_device_config;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.26.2

