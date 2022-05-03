Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226BE519206
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiECXEz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244080AbiECXEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:10 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1A059FC2
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:32 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8363FC0A;
        Wed,  4 May 2022 01:52:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8363FC0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618329;
        bh=A74AOGlvbHPrr444scvLK1UIyhkfbqt0k85xNXXjYKs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nwG3+uTTHLwCVbZ5+G8IR/zavjsV7TkhCrShAK2VMmLcYPGKJvUWuqxqrHhOzQfWj
         ev9x9fTv60PFdvzLksh8I3nZE+yRz1pbLs3IHbeaZqsriaeMEg3gE51qlMt1TEQasC
         d0fx72aQYjW+D5tntsIDWEFY2XZWeZEB4uL0Vjgc=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 22/26] dmaengine: dw-edma: Replace chip ID number with device name
Date:   Wed, 4 May 2022 01:51:00 +0300
Message-ID: <20220503225104.12108-23-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Using some abstract number as the DW eDMA chip identifier isn't really
practical. First of all there can be more than one DW eDMA controller on
the platform some of them can be detected as the PCIe end-points, some of
them can be embedded into the DW PCIe Root Port/End-point controllers.
Seeing some abstract number in for instance IRQ handlers list doesn't give
a notion regarding their reference to the particular DMA controller.
Secondly current DW eDMA chip id implementation doesn't provide the
multi-eDMA platforms support for same reason of possibly having eDMA
detected on different system buses. At the same time re-implementing
something ida-based won't give much benefits especially seeing the DW eDMA
chip ID is only used in the IRQ request procedure. So to speak in order to
preserve the code simplicity and get to have the multi-eDMA platforms
support let's just use the parental device name to create the DW eDMA
controller name.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

---

Changelog v2:
- Slightly extend the eDMA name array. (@Manivannan)
---
 drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
 drivers/dma/dw-edma/dw-edma-core.h | 2 +-
 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 98a94a66fb82..6a8282eaebaf 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -979,7 +979,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
+	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
+		 dev_name(chip->dev));
 
 	/* Disable eDMA, only to establish the ideal initial conditions */
 	dw_edma_v0_core_off(dw);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e3ad3e372b55..0ab2b6dba880 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -96,7 +96,7 @@ struct dw_edma_irq {
 };
 
 struct dw_edma {
-	char				name[20];
+	char				name[32];
 
 	struct dma_device		dma;
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index f530bacfd716..3f9dadc73854 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -222,7 +222,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	/* Data structure initialization */
 	chip->dev = dev;
-	chip->id = pdev->devfn;
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 391db06b74b7..346aabf231f1 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -76,7 +76,6 @@ enum dw_edma_chip_flags {
  */
 struct dw_edma_chip {
 	struct device		*dev;
-	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 	u32			flags;
-- 
2.35.1

