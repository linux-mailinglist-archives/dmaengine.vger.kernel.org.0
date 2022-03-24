Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A254E9C88
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiC1QqN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbiC1QqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BE5220D8;
        Mon, 28 Mar 2022 09:44:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 80EAE1E4948;
        Thu, 24 Mar 2022 04:48:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 80EAE1E4948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086525;
        bh=3nPjOLjzGYkPTmC45vtG0SxOCnuiuHJKeB2jpwkXC+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rxyCCYq4auhTUcAFE7H/PSIUGJcHizoO/iZhOL5ZLgbHIn3csEt70ME+7gmjyMmdH
         JT1rA4yp19llwItStSCp8HaeHNOL2zCSljGMgMv+WxprkLX7GttyTCtgVimmbPGqf3
         0r49hSlKfhU0+GaTQXTv+mphv8CMwer50WaKKEdY=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:45 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH 10/25] dmaengine: dw-edma: Add PCIe bus address getter to the remote EP glue-driver
Date:   Thu, 24 Mar 2022 04:48:21 +0300
Message-ID: <20220324014836.19149-11-Sergey.Semin@baikalelectronics.ru>
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

In general the Synopsys PCIe EndPoint IP prototype kit can be attached to
a PCIe bus with any PCIe Host controller including to the one with
distinctive from CPU address space. Due to that we need to make sure that
the source and destination addresses of the DMA-slave devices are properly
converted to the PCIe bus address space, otherwise the DMA transaction
will not only work as expected, but may cause the memory corruption with
subsequent system crash. Let's do that by introducing a new
dw_edma_pcie_address() method defined in the dw-edma-pcie.c, which will
perform the denoted translation by using the pcibios_resource_to_bus()
method.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Note this patch depends on the patch "dmaengine: dw-edma: Add CPU to PCIe
bus address translation" from this series.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 04c95cba1244..f530bacfd716 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -95,8 +95,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 	return pci_irq_vector(to_pci_dev(dev), nr);
 }
 
+static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus_region region;
+	struct resource res = {
+		.flags = IORESOURCE_MEM,
+		.start = cpu_addr,
+		.end = cpu_addr,
+	};
+
+	pcibios_resource_to_bus(pdev->bus, &region, &res);
+	return region.start;
+}
+
 static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
+	.pci_address = dw_edma_pcie_address,
 };
 
 static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
-- 
2.35.1

