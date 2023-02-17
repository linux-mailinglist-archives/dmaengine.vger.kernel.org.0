Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B569A863
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 10:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBQJkR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 04:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBQJkM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 04:40:12 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C05CD62FCD;
        Fri, 17 Feb 2023 01:40:10 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 026F3E0EAA;
        Fri, 17 Feb 2023 12:40:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=FIicy3pH7cZqo+9whkCgeCGgnFpj6U8qA+Ed4bXOKzc=; b=nTv6nDO2ZB06
        jX7EayFya/g4xqsGW7A26OzYUt1RtdlTNhmlZ10+301G243fZEEUCgJBud1AD7yk
        0a0sD7wXFVdJkqodoQW5i2vklo02g4VtpVjZWaJLAtM5lD4NIBvlh+VIAXVlY3rq
        E+gV+AwZM7jRlxYpXgLEmT33EGBR1jo=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id E335CE0E6A;
        Fri, 17 Feb 2023 12:40:09 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 17 Feb 2023 12:40:09 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/11] PCI: visconti: Convert to using generic resources getter
Date:   Fri, 17 Feb 2023 12:39:53 +0300
Message-ID: <20230217093956.27126-9-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
References: <20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The generic resources request infrastructure has been recently added to
the DW PCIe core driver. Since the DT-bindings of the Toshibo Visconti
PCIe Host controller is fully compatible with the generic names set let's
convert the driver to using that infrastructure. It won't take much effort
since the low-level device driver implies the resources request only with
no additional manipulations involving them. So just drop the locally
defined clocks request procedures, activate the generic resources request
capability and make sure the mandatory resources have been requested by
the DW PCIe core driver.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-visconti.c | 37 ++++++++++------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index 71026fefa366..ae1517b52c58 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -29,9 +29,6 @@ struct visconti_pcie {
 	void __iomem *ulreg_base;
 	void __iomem *smu_base;
 	void __iomem *mpu_base;
-	struct clk *refclk;
-	struct clk *coreclk;
-	struct clk *auxclk;
 };
 
 #define PCIE_UL_REG_S_PCIE_MODE		0x00F4
@@ -198,6 +195,21 @@ static int visconti_pcie_host_init(struct dw_pcie_rp *pp)
 	int err;
 	u32 val;
 
+	if (!pcie->pci.core_clks[DW_PCIE_REF_CLK].clk) {
+		dev_err(pci->dev, "Missing ref clock source\n");
+		return -ENOENT;
+	}
+
+	if (!pcie->pci.core_clks[DW_PCIE_CORE_CLK].clk) {
+		dev_err(pci->dev, "Missing core clock source\n");
+		return -ENOENT;
+	}
+
+	if (!pcie->pci.core_clks[DW_PCIE_AUX_CLK].clk) {
+		dev_err(pci->dev, "Missing aux clock source\n");
+		return -ENOENT;
+	}
+
 	visconti_smu_writel(pcie,
 			    PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
 			    PISMU_CKON_PCIE);
@@ -242,8 +254,6 @@ static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
 static int visconti_get_resources(struct platform_device *pdev,
 				  struct visconti_pcie *pcie)
 {
-	struct device *dev = &pdev->dev;
-
 	pcie->ulreg_base = devm_platform_ioremap_resource_byname(pdev, "ulreg");
 	if (IS_ERR(pcie->ulreg_base))
 		return PTR_ERR(pcie->ulreg_base);
@@ -256,21 +266,6 @@ static int visconti_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie->mpu_base))
 		return PTR_ERR(pcie->mpu_base);
 
-	pcie->refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(pcie->refclk))
-		return dev_err_probe(dev, PTR_ERR(pcie->refclk),
-				     "Failed to get ref clock\n");
-
-	pcie->coreclk = devm_clk_get(dev, "core");
-	if (IS_ERR(pcie->coreclk))
-		return dev_err_probe(dev, PTR_ERR(pcie->coreclk),
-				     "Failed to get core clock\n");
-
-	pcie->auxclk = devm_clk_get(dev, "aux");
-	if (IS_ERR(pcie->auxclk))
-		return dev_err_probe(dev, PTR_ERR(pcie->auxclk),
-				     "Failed to get aux clock\n");
-
 	return 0;
 }
 
@@ -304,6 +299,8 @@ static int visconti_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
+	dw_pcie_cap_set(pci, REQ_RES);
+
 	ret = visconti_get_resources(pdev, pcie);
 	if (ret)
 		return ret;
-- 
2.39.0


