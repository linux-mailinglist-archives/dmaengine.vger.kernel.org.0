Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C44E9CBD
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiC1Qsb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242791AbiC1QqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:02 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF64921E07;
        Mon, 28 Mar 2022 09:44:15 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 012521E28C1;
        Thu, 24 Mar 2022 04:48:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 012521E28C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086537;
        bh=qzYBz7H8E6U/5witePOjzf4Q2pfPLZU2uG2a8K4iWSs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZBkBX475GRJ2za0btGRtYVt8c0ZMzTici3wSHFXbNXWPP9ez7rpzwMSq2/KBhrpZi
         qcqtQ+9rk6+KSIsafsACRajSM0MEivk2hfYH2pNUWqAQDkdL0iHLI/1ZzlnSc7XkTi
         qsifmGe4Joc0JYkiQdeFf2AsoPImjYJ+zw6lbfzs=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:56 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 25/25] PCI: dwc: Add DW eDMA engine support
Date:   Thu, 24 Mar 2022 04:48:36 +0300
Message-ID: <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
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

Since the DW eDMA driver now supports eDMA controllers embedded into the
locally accessible DW PCIe Root Ports and End-points, we can use the
updated interface to register DW eDMA as DMA engine device if it's
available. In order to successfully do that the DW PCIe core driver need
to perform some preparations first. First of all it needs to find out the
eDMA controller CSRs base address, whether they are accessible over the
Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
the eDMA controller availability and number of it's read/write channels.
If none was found the procedure will just silently halt with no error
returned. Secondly the platform is supposed to provide either combined or
per-channel IRQ signals. If no valid IRQs set is found the procedure will
also halt with no error returned so to be backward compatible with
platforms where DW PCIe controllers have eDMA embedded but lack of the
IRQs defined for them. Finally before actually probing the eDMA device we
need to allocate LLP items buffers. After that the DW eDMA can be
registered. If registration is successful the info-message regarding the
number of detected Read/Write eDMA channels will be printed to the system
log in the same way as it's done for iATU settings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
 .../pci/controller/dwc/pcie-designware-host.c |  13 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  23 ++-
 4 files changed, 225 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 23401f17e8f0..b2840d1a5b9a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -712,6 +712,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	dw_pcie_iatu_detect(pci);
 
+	ret = dw_pcie_edma_detect(pci);
+	if (ret)
+		return ret;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
 		return -EINVAL;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 715a13b90e43..048b452ee4f3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -405,14 +405,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_iatu_detect(pci);
 
-	ret = dw_pcie_setup_rc(pp);
+	ret = dw_pcie_edma_detect(pci);
 	if (ret)
 		goto err_free_msi;
 
+	ret = dw_pcie_setup_rc(pp);
+	if (ret)
+		goto err_edma_remove;
+
 	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
 		if (ret)
-			goto err_free_msi;
+			goto err_edma_remove;
 	}
 
 	/* Ignore errors, the link may come up later */
@@ -430,6 +434,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pci->ops && pci->ops->stop_link)
 		pci->ops->stop_link(pci);
 
+err_edma_remove:
+	dw_pcie_edma_remove(pci);
+
 err_free_msi:
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
@@ -452,6 +459,8 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	if (pci->ops && pci->ops->stop_link)
 		pci->ops->stop_link(pci);
 
+	dw_pcie_edma_remove(pci);
+
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4a95a7b112e9..dbe39a7ecb71 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -11,6 +11,7 @@
 #include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/sizes.h>
@@ -680,6 +681,193 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
 }
 
+static u32 dw_pcie_readl_dma(struct dw_pcie *pci, u32 reg)
+{
+	u32 val = 0;
+	int ret;
+
+	if (pci->ops && pci->ops->read_dbi)
+		return pci->ops->read_dbi(pci, pci->edma.reg_base, reg, 4);
+
+	ret = dw_pcie_read(pci->edma.reg_base + reg, 4, &val);
+	if (ret)
+		dev_err(pci->dev, "Read DMA address failed\n");
+
+	return val;
+}
+
+static bool dw_pcie_edma_unroll_enabled(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
+	if (val == 0xffffffff)
+		return true;
+
+	return false;
+}
+
+static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	char name[6];
+	int ret;
+
+	if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	ret = platform_get_irq_byname_optional(pdev, "dma");
+	if (ret > 0)
+		return ret;
+
+	snprintf(name, sizeof(name), "dma%u", nr);
+
+	return platform_get_irq_byname_optional(pdev, name);
+}
+
+static struct dw_edma_core_ops dw_pcie_edma_ops = {
+	.irq_vector = dw_pcie_edma_irq_vector,
+};
+
+static int dw_pcie_edma_detect_channels(struct dw_pcie *pci)
+{
+	u32 val;
+
+	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+	if (!val || val == 0xffffffff)
+		return 0;
+
+	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+
+	if (pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
+	    pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
+{
+	struct platform_device *pdev = to_platform_device(pci->dev);
+	u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
+	char name[6];
+	int ret;
+
+	if (pci->edma.nr_irqs == 1)
+		return 0;
+	else if (pci->edma.nr_irqs > 1)
+		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
+
+	ret = platform_get_irq_byname_optional(pdev, "dma");
+	if (ret > 0) {
+		pci->edma.nr_irqs = 1;
+		return 0;
+	}
+
+	for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
+		snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
+
+		ret = platform_get_irq_byname_optional(pdev, name);
+		if (ret <= 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dw_pcie_edma_ll_alloc(struct dw_pcie *pci)
+{
+	struct dw_edma_region *ll;
+	dma_addr_t paddr;
+	int i;
+
+	for (i = 0; i < pci->edma.ll_wr_cnt; i++) {
+		ll = &pci->edma.ll_region_wr[i];
+		ll->sz = DMA_LLP_MEM_SIZE;
+		ll->vaddr = dmam_alloc_coherent(pci->dev, ll->sz,
+						&paddr, GFP_KERNEL);
+		if (!ll->vaddr)
+			return -ENOMEM;
+
+		ll->paddr = paddr;
+	}
+
+	for (i = 0; i < pci->edma.ll_rd_cnt; i++) {
+		ll = &pci->edma.ll_region_rd[i];
+		ll->sz = DMA_LLP_MEM_SIZE;
+		ll->vaddr = dmam_alloc_coherent(pci->dev, ll->sz,
+						&paddr, GFP_KERNEL);
+		if (!ll->vaddr)
+			return -ENOMEM;
+
+		ll->paddr = paddr;
+	}
+
+	return 0;
+}
+
+int dw_pcie_edma_detect(struct dw_pcie *pci)
+{
+	int ret;
+
+	pci->edma.dev = pci->dev;
+	if (!pci->edma.ops)
+		pci->edma.ops = &dw_pcie_edma_ops;
+	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+
+	pci->edma_unroll_enabled = dw_pcie_edma_unroll_enabled(pci);
+	if (pci->edma_unroll_enabled && pci->iatu_unroll_enabled) {
+		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
+		if (pci->atu_base != pci->dbi_base + DEFAULT_DBI_ATU_OFFSET)
+			pci->edma.reg_base = pci->atu_base + PCIE_DMA_UNROLL_BASE;
+		else
+			pci->edma.reg_base = pci->dbi_base + DEFAULT_DBI_DMA_OFFSET;
+	} else {
+		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
+		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
+	}
+
+	ret = dw_pcie_edma_detect_channels(pci);
+	if (ret) {
+		dev_err(pci->dev, "Unexpected NoF eDMA channels found\n");
+		return ret;
+	}
+
+	/* Skip any further initialization if no eDMA found */
+	if (!pci->edma.ll_wr_cnt && !pci->edma.ll_rd_cnt)
+		return 0;
+
+	/* Don't return failure here for the backward compatibility */
+	ret = dw_pcie_edma_irq_verify(pci);
+	if (ret) {
+		dev_err(pci->dev, "No valid eDMA IRQs set found\n");
+		return 0;
+	}
+
+	ret = dw_pcie_edma_ll_alloc(pci);
+	if (ret) {
+		dev_err(pci->dev, "Couldn't allocate LLP memory\n");
+		return ret;
+	}
+
+	ret = dw_edma_probe(&pci->edma);
+	if (ret) {
+		dev_err(pci->dev, "Couldn't register eDMA device\n");
+		return ret;
+	}
+
+	dev_info(pci->dev, "eDMA channels: %hu wr, %hu rd\n",
+		 pci->edma.ll_wr_cnt, pci->edma.ll_rd_cnt);
+
+	return 0;
+}
+
+void dw_pcie_edma_remove(struct dw_pcie *pci)
+{
+	dw_edma_remove(&pci->edma);
+}
+
 void dw_pcie_setup(struct dw_pcie *pci)
 {
 	u32 val;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 11c52d2eaf79..9b92f79664f2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/edma.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
@@ -144,6 +145,18 @@
 #define PCIE_MSIX_DOORBELL		0x948
 #define PCIE_MSIX_DOORBELL_PF_SHIFT	24
 
+/*
+ * eDMA CSRs. DW PCIe IP-core v4.70a and older had the eDMA registers accessible
+ * over the Port Logic registers space. Afterwords the unrolled mapping was
+ * introduced so eDMA and iATU could be accessed via a dedicated registers
+ * space.
+ */
+#define PCIE_DMA_VIEWPORT_BASE		0x970
+#define PCIE_DMA_UNROLL_BASE		0x80000
+#define PCIE_DMA_CTRL			0x008
+#define PCIE_DMA_NUM_WR_CHAN		GENMASK(3, 0)
+#define PCIE_DMA_NUM_RD_CHAN		GENMASK(19, 16)
+
 #define PCIE_PL_CHK_REG_CONTROL_STATUS			0xB20
 #define PCIE_PL_CHK_REG_CHK_REG_START			BIT(0)
 #define PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS		BIT(1)
@@ -160,6 +173,7 @@
  * this offset, if atu_base not set.
  */
 #define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
+#define DEFAULT_DBI_DMA_OFFSET (0x7 << 19)
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
@@ -171,6 +185,9 @@
 #define MAX_IATU_IN			256
 #define MAX_IATU_OUT			256
 
+/* Default eDMA LLP memory size */
+#define DMA_LLP_MEM_SIZE		PAGE_SIZE
+
 struct pcie_port;
 struct dw_pcie;
 struct dw_pcie_ep;
@@ -295,7 +312,7 @@ struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
 	void __iomem		*dbi_base2;
-	/* Used when iatu_unroll_enabled is true */
+	/* Used when {iatu,edma}_unroll_enabled is true */
 	void __iomem		*atu_base;
 	size_t			atu_size;
 	u32			num_ib_windows;
@@ -310,7 +327,9 @@ struct dw_pcie {
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
+	struct dw_edma_chip	edma;
 	bool			iatu_unroll_enabled: 1;
+	bool			edma_unroll_enabled: 1;
 	bool			io_cfg_atu_shared: 1;
 };
 
@@ -344,6 +363,8 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
+int dw_pcie_edma_detect(struct dw_pcie *pci);
+void dw_pcie_edma_remove(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.35.1

