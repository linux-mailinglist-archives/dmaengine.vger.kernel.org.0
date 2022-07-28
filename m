Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEF584188
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiG1OgF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiG1OfL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:11 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81AB22ED56
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:30 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1D7FE5BC3;
        Thu, 28 Jul 2022 17:31:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1D7FE5BC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018677;
        bh=N88OoMZKRV6JXPdySXLm56p1hMlYe/rmzVyzAT1y8Mo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Z+GeM7eZ29dGcJ1SW5ImbUBSmup4WYRV18GlpUvUV9kVl8hzwsKTNE3qAiVcCz/xt
         TSpLtaTwpJNX9+laV5+xdVTslJtu6uYBKJyC/W4Ck0Sfx1OhPMqCkTkexTCcxur/E6
         8XrG94IDOsKC320Gs+jye2xgTAUhsUmM1oPJ4UDs=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:28:52 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v4 08/24] dmaengine: dw-edma: Add PCIe bus address getter to the remote EP glue-driver
Date:   Thu, 28 Jul 2022 17:28:25 +0300
Message-ID: <20220728142841.12305-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>

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

