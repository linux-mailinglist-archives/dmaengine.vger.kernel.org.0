Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15F559C79B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiHVSzN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiHVSyZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 14:54:25 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BA6940E15;
        Mon, 22 Aug 2022 11:54:07 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A392CDA3;
        Mon, 22 Aug 2022 21:57:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A392CDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194637;
        bh=HekYV1lBKlai2OBRiEnPOFW81XlcyqdBlYrBwA4qXHk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=EdcXB0yxe1dc+2X8lGuy1UiX8LS7G17Dv7nJBFeHvezaZYmzir6dDEQF6I5pakPPE
         DM9/vJn9bkpc7PZay4MkOaJ7tXQmtvkEW+3SsibzrmqX/YBeTga5biURZPnKot5Hgq
         RLIWUgQTXmGYwwfAB8KJ2ENH7d0EicUwVEEgzubQ=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:54:03 +0300
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
Subject: [PATCH RESEND v5 21/24] dmaengine: dw-edma: Replace chip ID number with device name
Date:   Mon, 22 Aug 2022 21:53:29 +0300
Message-ID: <20220822185332.26149-22-Sergey.Semin@baikalelectronics.ru>
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>

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
index 380a0a3e251f..9d44da4aa59d 100644
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

