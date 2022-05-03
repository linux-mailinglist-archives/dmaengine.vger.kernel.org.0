Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80836519214
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiECXFE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbiECXEJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:09 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C17BD764A
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:32 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CC1C9C0D;
        Wed,  4 May 2022 01:52:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru CC1C9C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618332;
        bh=Rn3qRaOQPZj8s+wlKxCUQb+RVz0erO/Tc5KHt3cNz0s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WkD51AEWXM8aWlFZsICk+Db4KR/+PC0GVeXEKfBlHgrB56tRHomlcZh4tdXXzeXob
         LG1wbzcQI/fMFvgOZQ8pUfZtQgipH5mlhqL/Qx9iE+dlbnH74Ek2U+dwMCmN4oFYq+
         ppkXndKNe4V4EIZmSTIQ877X63mmPs2YRd3Fti9I=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 25/26] PCI: dwc: Add generic iATU/eDMA CSRs space detection method
Date:   Wed, 4 May 2022 01:51:03 +0300
Message-ID: <20220503225104.12108-26-Sergey.Semin@baikalelectronics.ru>
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

The iATU and eDMA are accessible over the same AXI/DBI interface and have
the same access mode (viewport-based or unrolled). Due to that it will be
more suitable to perform the iATU and eDMA CSRs space detection in the
same coherent function. Since the iATU CSRs space and access mode
detection procedure is already available in the driver let's move it into
the dedicated method. The eDMA CSRs space detection will be added there in
the next commit. This change is a preparation before adding the eDMA
support to the DW PCIe controller driver.

Note the new dw_pcie_map_detect() method fails if the iATU MMIO region
IO-remapping fails. It should have been done in the first place since the
failed remapping of the detected reg-space is certainly the erroneous
situation.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- This is a new patch added in v2. (@Manivannan)
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +
 .../pci/controller/dwc/pcie-designware-host.c |  4 +
 drivers/pci/controller/dwc/pcie-designware.c  | 76 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 9b0540cfa9e8..6cfcfa34e587 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -717,6 +717,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	dw_pcie_version_detect(pci);
 
+	ret = dw_pcie_map_detect(pci);
+	if (ret)
+		return ret;
+
 	dw_pcie_iatu_detect(pci);
 
 	ep->ib_window_map = devm_kcalloc(dev,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9cb406f5c185..3cd5b096a427 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -409,6 +409,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_version_detect(pci);
 
+	ret = dw_pcie_map_detect(pci);
+	if (ret)
+		goto err_free_msi;
+
 	dw_pcie_iatu_detect(pci);
 
 	ret = dw_pcie_setup_rc(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 33718ed6c511..68bd3fc66fd7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -213,7 +213,7 @@ static inline void __iomem *dw_pcie_select_atu(struct dw_pcie *pci, u32 dir,
 {
 	void __iomem *base = pci->atu_base;
 
-	if (pci->iatu_unroll_enabled)
+	if (pci->iatu_dma_unrolled)
 		base += PCIE_ATU_UNROLL_BASE(dir, index);
 	else
 		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | index);
@@ -579,24 +579,56 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 }
 
-static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
+int dw_pcie_map_detect(struct dw_pcie *pci)
 {
+	struct platform_device *pdev = to_platform_device(pci->dev);
+	struct resource *res;
 	u32 val;
 
 	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
 	if (val == 0xffffffff)
-		return true;
+		pci->iatu_dma_unrolled = true;
+	else
+		pci->iatu_dma_unrolled = false;
+
+	if (!pci->iatu_dma_unrolled) {
+		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
+		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
+
+		dev_info(pci->dev, "iATU/DMA unroll: disabled\n");
+
+		return 0;
+	}
 
-	return false;
+	if (!pci->atu_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+		if (res) {
+			pci->atu_base = devm_ioremap_resource(pci->dev, res);
+			if (IS_ERR(pci->atu_base))
+				return PTR_ERR(pci->atu_base);
+
+			pci->atu_size = resource_size(res);
+		} else {
+			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+		}
+	}
+
+	/* Pick a minimal default, enough for 8 in and 8 out windows */
+	if (!pci->atu_size)
+		pci->atu_size = SZ_4K;
+
+	dev_info(pci->dev, "iATU/DMA unroll: enabled\n");
+
+	return 0;
 }
 
-static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
+void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
 	u32 val, min, dir;
 	u64 max;
 
-	if (pci->iatu_unroll_enabled) {
+	if (pci->iatu_dma_unrolled) {
 		max_region = min((int)pci->atu_size / 512, 256);
 	} else {
 		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
@@ -640,38 +672,6 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	pci->num_ib_windows = ib;
 	pci->region_align = 1 << fls(min);
 	pci->region_limit = (max << 32) | (SZ_4G - 1);
-}
-
-void dw_pcie_iatu_detect(struct dw_pcie *pci)
-{
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-
-	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-	if (pci->iatu_unroll_enabled) {
-		if (!pci->atu_base) {
-			struct resource *res =
-				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
-			if (res) {
-				pci->atu_size = resource_size(res);
-				pci->atu_base = devm_ioremap_resource(dev, res);
-			}
-			if (!pci->atu_base || IS_ERR(pci->atu_base))
-				pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
-		}
-
-		if (!pci->atu_size)
-			/* Pick a minimal default, enough for 8 in and 8 out windows */
-			pci->atu_size = SZ_4K;
-	} else {
-		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
-		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
-	}
-
-	dw_pcie_iatu_detect_regions(pci);
-
-	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
-		"enabled" : "disabled");
 
 	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
 		 pci->num_ob_windows, pci->num_ib_windows,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 765d99d5bfaa..e10647b96c68 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -310,7 +310,7 @@ struct dw_pcie {
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
-	bool			iatu_unroll_enabled: 1;
+	bool			iatu_dma_unrolled: 1;
 	bool			io_cfg_atu_shared: 1;
 };
 
@@ -343,6 +343,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				int type, u64 cpu_addr, u8 bar);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
+int dw_pcie_map_detect(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
-- 
2.35.1

