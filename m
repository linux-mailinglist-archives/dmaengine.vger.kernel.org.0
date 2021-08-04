Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6E3E08FE
	for <lists+dmaengine@lfdr.de>; Wed,  4 Aug 2021 21:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhHDTuY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Aug 2021 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhHDTuX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Aug 2021 15:50:23 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D7C0613D5
        for <dmaengine@vger.kernel.org>; Wed,  4 Aug 2021 12:50:10 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3414C82DD4;
        Wed,  4 Aug 2021 21:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1628106608;
        bh=xRhMLRf6O0xB1XOX6QHSauuZQQ4UkaoZuMx4/xgRmgs=;
        h=From:To:Cc:Subject:Date:From;
        b=KIN3TB6d4miJVIY9eIvMBrmkXDMuyuIveWXB48jFryyTU7af9ws6OZMvlPg/LO7jK
         eBhPRbcccGcwMPDqEsrJdk6xe+BT/RUU0qLLfJbqmNKgvv2Cm3lA9PPDLI3a284gBF
         ShHh3KxissxojF+sPavb1UtbmmCKuVTq6R4C3JxrjBuGf8wQazsjJSP4uPjzui0uzl
         rWS55ySPU9b+xWdreCAbU9vrLHXZMTK7dRc2/xJyDxqchMsi8e9hLO+rKJOXLgKKHU
         N5ocD+QekOg332XHuA/ZoBzTrYQ6ymnEdUpmSEuieqlNcrz1VBUFe9IZNpSSfBR8Qv
         UkAv5YH4+kNEA==
From:   Marek Vasut <marex@denx.de>
To:     dmaengine@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH V2] dmaengine: xilinx: Add empty device_config function
Date:   Wed,  4 Aug 2021 21:49:45 +0200
Message-Id: <20210804194945.61172-1-marex@denx.de>
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
V2: Fix copy-paste error in kerneldoc function name
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 213e1a7314b77..97cbde4e0a292 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1657,6 +1657,17 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
+/**
+ * xilinx_dma_device_config - Configure the DMA channel
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
@@ -3095,6 +3106,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_synchronize = xilinx_dma_synchronize;
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
+	xdev->common.device_config = xilinx_dma_device_config;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.30.2

