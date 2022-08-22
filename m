Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6159C78E
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiHVSzP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiHVSyZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 14:54:25 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E506E3B966;
        Mon, 22 Aug 2022 11:54:06 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A3CBADA6;
        Mon, 22 Aug 2022 21:57:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A3CBADA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194636;
        bh=n7/eCBY+3otMjcR2vj/1GqFEVzdZEejjsBhPqaiBFow=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BcxB6oUHv8Yeap19sVZMaI/5SoB11yF75FcRQoRf+LY/CZBNlS4E1OkynRJwgmzUA
         bpcqqHdv008xsYe+e7kcrNT6GiQOc0u6ZZqo/wG4WTQwTEmcYUmcMKn7fHo2F9pstD
         et6BijAPiBhCL3AconN9U9xEddNO+TB7G61jw1Fs=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:54:02 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 20/24] dmaengine: dw-edma: Drop DT-region allocation
Date:   Mon, 22 Aug 2022 21:53:28 +0300
Message-ID: <20220822185332.26149-21-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 7ba3b60c960c..98a94a66fb82 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -744,7 +744,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
-	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
@@ -760,12 +759,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
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
@@ -813,17 +806,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
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
2.35.1

