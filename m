Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49B566A08A
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjAMRYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjAMRXz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:23:55 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7246675D3B;
        Fri, 13 Jan 2023 09:14:43 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 81E82E0F2B;
        Fri, 13 Jan 2023 20:14:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Btdzx/ZX3GdEwT/RTf5wRs+T6GnL6ctqsHDeogwtp1c=; b=E5XKug3bpfiM
        RZuxE2Q2MptXkqt6xsVQ9ivMJW5kN1axcFd8XPMM0KbYs5SHxKPqLxF/SLVcRp3s
        1VlB+lzUDGEBAEjDFXQ90fODRieqyXlJgzGazw62ug95/G742zCu4lYH5ZvqDg0D
        TrfF0+GkTSrIkK8Wku08o0+JNmGhkXE=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 54392E0F13;
        Fri, 13 Jan 2023 20:14:34 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 20/27] dmaengine: dw-edma: Drop DT-region allocation
Date:   Fri, 13 Jan 2023 20:14:02 +0300
Message-ID: <20230113171409.30470-21-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no point in allocating an additional memory for the data target
regions passed then to the client drivers. Just use the already available
structures defined in the dw_edma_chip instance.

Note these regions are unused in normal circumstances since they are
specific to the case of eDMA being embedded into the DW PCIe End-point and
having it's CSRs accessible over a End-point' BAR. This case is only known
to be implemented as a part of the Synopsys PCIe EndPoint IP prototype
kit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 58808bec4148..040a88cfe070 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -738,7 +738,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
-	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
@@ -754,12 +753,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	for (i = 0; i < ch_cnt; i++) {
 		chan = &dw->chan[i];
 
-		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
-		if (!dt_region)
-			return -ENOMEM;
-
-		chan->vc.chan.private = dt_region;
-
 		chan->dw = dw;
 
 		if (i < dw->wr_ch_cnt) {
@@ -807,17 +800,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 			 chan->msi.data);
 
 		chan->vc.desc_free = vchan_free_desc;
-		vchan_init(&chan->vc, dma);
+		chan->vc.chan.private = chan->dir == EDMA_DIR_WRITE ?
+					&dw->chip->dt_region_wr[chan->id] :
+					&dw->chip->dt_region_rd[chan->id];
 
-		if (chan->dir == EDMA_DIR_WRITE) {
-			dt_region->paddr = chip->dt_region_wr[chan->id].paddr;
-			dt_region->vaddr = chip->dt_region_wr[chan->id].vaddr;
-			dt_region->sz = chip->dt_region_wr[chan->id].sz;
-		} else {
-			dt_region->paddr = chip->dt_region_rd[chan->id].paddr;
-			dt_region->vaddr = chip->dt_region_rd[chan->id].vaddr;
-			dt_region->sz = chip->dt_region_rd[chan->id].sz;
-		}
+		vchan_init(&chan->vc, dma);
 
 		dw_edma_v0_core_device_config(chan);
 	}
-- 
2.39.0


