Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE704E9C8C
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbiC1QqQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbiC1QqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F44921E2D;
        Mon, 28 Mar 2022 09:44:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 583BA1E495A;
        Thu, 24 Mar 2022 04:48:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 583BA1E495A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086533;
        bh=iq392ifBKJNeXd07OpQlSazUKapg75sZrK0PlOvjOHo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QmjmIg4dvnszJpqrvsQpKe9XCdhnitbukZUqOSIt212Mwr/eZ5j7q3ZQL+7Dhu7nW
         v1s3M6sGrv+7HO47I0Lv8Nx/zpk+XlFBZ5s2wZwbJe9czZuy27jLhxVhz8Icz+YkIl
         VcRvVrp2mJmyZob0iP3ncz8G2sSj7HhKmLivI7pc=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:53 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 21/25] dmaengine: dw-edma: Drop DT-region allocation
Date:   Thu, 24 Mar 2022 04:48:32 +0300
Message-ID: <20220324014836.19149-22-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/dma/dw-edma/dw-edma-core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index bc530f0a2468..dbe1119fd1d2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -744,7 +744,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 static int dw_edma_channel_setup(struct dw_edma_chip *chip, u32 wr_alloc,
 				 u32 rd_alloc)
 {
-	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
 	struct dw_edma *dw = chip->dw;
 	struct dw_edma_chan *chan;
@@ -761,12 +760,6 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, u32 wr_alloc,
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
@@ -814,17 +807,11 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, u32 wr_alloc,
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

