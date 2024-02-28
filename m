Return-Path: <dmaengine+bounces-1141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84586A510
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 02:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5EE1F255DC
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F33FE1;
	Wed, 28 Feb 2024 01:33:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ingenic.com (mail.ingenic.com [106.37.171.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F515AF;
	Wed, 28 Feb 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.37.171.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083999; cv=none; b=n3wIu+ZXV9NErWgh6Tn+zZKxpw8X/0rohhbJLkuyIZufqxivSDOCMOHU7wRvfVSoGghX+CoqhCpxybzL6pyHnI9lRSFp1FC6nYnHdOxNRUZXR/CkfncJwr8mpAGwPhTIQtoyXIsotEswWpEHq5/Sw1CiRA+5VC+/ug4VF8PzesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083999; c=relaxed/simple;
	bh=JfHBr9SUdfJNhW9nARJzQOPFexGbYWTctt27K/EF9RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ty0R5teafrS0cy3sfPh42DU7lPACq1MIsOWp/kTzkX9PcXIyHFIlQFjkOy93P8arBrkZ2HiqWT/OZPrhe9rKThUN9S3YEP4BIczwvA6c1WyngQdKP3onHlAJWGWv52aG5AFOscxTm2+F6k+akcPmoHAxk8r+vAF6zKluokOeGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com; spf=pass smtp.mailfrom=ingenic.com; arc=none smtp.client-ip=106.37.171.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ingenic.com
Received: from localhost (unknown [60.173.195.77])
	by mail.ingenic.com (Postfix) with ESMTPA id E87BB2700173;
	Wed, 28 Feb 2024 09:24:26 +0800 (CST)
From: "bin.yao" <bin.yao@ingenic.com>
To: vkoul@kernel.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	quic_bjorande@quicinc.com,
	byao <bin.yao@ingenic.com>,
	rick <rick.tyliu@ingenic.com>
Subject: [PATCH 2/2] dma: Add Ingenic PDMA driver support
Date: Wed, 28 Feb 2024 06:24:20 +0500
Message-Id: <20240228012420.4223-2-bin.yao@ingenic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240228012420.4223-1-bin.yao@ingenic.com>
References: <20240228012420.4223-1-bin.yao@ingenic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: byao <bin.yao@ingenic.com>

Add Ingenic PDMA controller support.
This module can be found on ingenic victory soc.

Signed-off-by: byao <bin.yao@ingenic.com>
Signed-off-by: rick <rick.tyliu@ingenic.com>
---
 drivers/dma/Kconfig               |   14 +
 drivers/dma/Makefile              |    1 +
 drivers/dma/ingenic/Makefile      |    1 +
 drivers/dma/ingenic/ingenic_dma.c | 1053 +++++++++++++++++++++++++++++
 drivers/dma/ingenic/ingenic_dma.h |  250 +++++++
 5 files changed, 1319 insertions(+)
 create mode 100644 drivers/dma/ingenic/Makefile
 create mode 100644 drivers/dma/ingenic/ingenic_dma.c
 create mode 100644 drivers/dma/ingenic/ingenic_dma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e928f2ca0f1e..3214c72aef31 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -179,6 +179,20 @@ config DMA_SUN6I
 	help
 	  Support for the DMA engine first found in Allwinner A31 SoCs.
 
+config DMA_JZ4780
+	tristate "Ingenic JZ SoC DMA support"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support the DMA engine found on Ingenic Jz SoCs.
+
+config DMA_INGENIC_SOC
+	tristate "Ingenic SoC DMA support"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support the DMA engine found on Ingenic T41 SoCs.
+
 config DW_AXI_DMAC
 	tristate "Synopsys DesignWare AXI DMA support"
 	depends on OF
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e408..8a56175bbfbb 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_DMA_INGENIC_SOC) += ingenic/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/ingenic/Makefile b/drivers/dma/ingenic/Makefile
new file mode 100644
index 000000000000..2028a6f0b0c8
--- /dev/null
+++ b/drivers/dma/ingenic/Makefile
@@ -0,0 +1 @@
+obj-y += ingenic_dma.o
diff --git a/drivers/dma/ingenic/ingenic_dma.c b/drivers/dma/ingenic/ingenic_dma.c
new file mode 100644
index 000000000000..066325e35a92
--- /dev/null
+++ b/drivers/dma/ingenic/ingenic_dma.c
@@ -0,0 +1,1053 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Ingenic Semiconductor Co., Ltd.
+ * Author: cli <chen.li@ingenic.com>
+ *
+ * Programmable DMA Controller Driver For Ingenic's SOC,
+ * such as X1000, and so on. (kernel.4.4)
+ *
+ *  Author:	cli <chen.li@ingenic.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/dmapool.h>
+#include "ingenic_dma.h"
+
+static void dump_dma(struct ingenic_dma_chan *master)
+{
+	pr_debug("CH_DSA = 0x%08x\n", readl(master->iomem + CH_DSA));
+	pr_debug("CH_DTA = 0x%08x\n", readl(master->iomem + CH_DTA));
+	pr_debug("CH_DTC = 0x%08x\n", readl(master->iomem + CH_DTC));
+	pr_debug("CH_DRT = 0x%08x\n", readl(master->iomem + CH_DRT));
+	pr_debug("CH_DCS = 0x%08x\n", readl(master->iomem + CH_DCS));
+	pr_debug("CH_DCM = 0x%08x\n", readl(master->iomem + CH_DCM));
+	pr_debug("CH_DDA = 0x%08x\n", readl(master->iomem + CH_DDA));
+	pr_debug("CH_DSD = 0x%08x\n", readl(master->iomem + CH_DSD));
+}
+
+static int dump_dma_hdesc(struct hdma_desc *desc, const char *d)
+{
+	int i;
+	unsigned long *p = (unsigned long *)desc;
+
+	pr_debug("%s(): %s\n", __func__, d);
+	for (i = 0; i < 8; i++)
+		pr_debug("\t%08lx\n", (unsigned long)*p++);
+
+	return 0;
+}
+
+void jzdma_dump(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+	dump_dma(dmac);
+}
+EXPORT_SYMBOL_GPL(jzdma_dump);
+
+/*tsz for 1,2,4,8,16,32,64 128bytes */
+static const char dcm_tsz[8] = { 1, 2, 0, 0, 3, 4, 5, 6};
+static inline unsigned int get_current_tsz(unsigned long dcmp)
+{
+	int i;
+	int val = (dcmp & DCM_TSZ_MSK) >> DCM_TSZ_SFT;
+
+	if (val == DCM_TSZ_AUTO)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(dcm_tsz); i++) {
+		if (val == dcm_tsz[i])
+			break;
+	}
+
+	return i;
+}
+
+static inline unsigned char get_max_tsz(unsigned long val, unsigned int *shift)
+{
+	int ord = ffs(val) - 1;
+
+	/*
+	 * 8 byte transfer sizes unsupported so fall back on 4. If it's larger
+	 * than the maximum, just limit it. It is perfectly safe to fall back
+	 * in this way since we won't exceed the maximum burst size supported
+	 * by the device, the only effect is reduced efficiency. This is better
+	 * than refusing to perform the request at all.
+	 */
+	if (ord == 3)
+		ord = 2;
+	else if (ord > 7)
+		ord = 7;
+
+	if (shift)
+		*shift = ord;
+
+	return dcm_tsz[ord];
+}
+
+static const struct of_device_id ingenic_dma_dt_match[];
+
+static struct ingenic_dma_engine *ingenic_dma_parse_dt(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct ingenic_dma_engine *ingenic_dma;
+	u32 nr_chs;
+
+	if (!pdev->dev.of_node)
+		return ERR_PTR(-ENODEV);
+
+	match = of_match_node(ingenic_dma_dt_match, pdev->dev.of_node);
+	if (!match)
+		return ERR_PTR(-ENODEV);
+
+	if (of_property_read_u32(pdev->dev.of_node, "#dma-channels", &nr_chs))
+		nr_chs = 32;
+
+	ingenic_dma = devm_kzalloc(&pdev->dev, sizeof(*ingenic_dma) +
+			sizeof(struct ingenic_dma_chan *) * nr_chs, GFP_KERNEL);
+	if (!ingenic_dma)
+		return ERR_PTR(-ENOMEM);
+
+	ingenic_dma->dev = &pdev->dev;
+	ingenic_dma->nr_chs = nr_chs;
+	ingenic_dma->hwattr = (unsigned long)match->data;
+
+	/* Property is optional, if it doesn't exist the value will remain 0. */
+	of_property_read_u32(pdev->dev.of_node, "ingenic,reserved-chs",
+			&ingenic_dma->chan_reserved);
+
+	if (!of_property_read_u32(pdev->dev.of_node, "ingenic,programed-chs",
+				&ingenic_dma->chan_programed))
+		ingenic_dma->chan_reserved |= ingenic_dma->chan_programed;
+
+	if (HWATTR_SPECIAL_CH01_SUP(ingenic_dma->hwattr) &&
+			of_property_read_bool(pdev->dev.of_node,
+				"ingenic,special-chs")) {
+		ingenic_dma->chan_reserved  |= DMA_SPECAIL_CHS;
+		ingenic_dma->chan_programed |= DMA_SPECAIL_CHS;
+		ingenic_dma->special_ch = true;
+	}
+
+	ingenic_dma->intc_ch = -1;
+	if (HWATTR_INTC_IRQ_SUP(ingenic_dma->hwattr) &&
+			!of_property_read_u32(pdev->dev.of_node,
+				"ingenic,intc-ch", (u32 *)&ingenic_dma->intc_ch)) {
+
+		if (ingenic_dma->intc_ch >= ingenic_dma->nr_chs)
+			ingenic_dma->intc_ch = (ingenic_dma->nr_chs - 1);
+
+		if (BIT(ingenic_dma->intc_ch) & ingenic_dma->chan_reserved)
+			dev_warn(ingenic_dma->dev,
+					"WARN: intc irq channel %d is already reserved\n",
+						ingenic_dma->intc_ch);
+
+		ingenic_dma->chan_reserved |= BIT(ingenic_dma->intc_ch);
+	}
+
+	return ingenic_dma;
+}
+
+static unsigned int build_one_desc(dma_addr_t saddr, dma_addr_t daddr,
+		unsigned int length, struct hdma_desc *desc)
+{
+	unsigned int len = length;
+	unsigned int tsz, transfer_shift;
+
+	if (length < DTC_TC_MSK) {
+		desc->dcm = DCM_DAI | DCM_SAI |
+				(DCM_TSZ_AUTO << DCM_TSZ_SFT) |
+					(DCM_RDIL_MAX << DCM_RDIL_SFT);
+		desc->dtc = len; /* DCM_TSZ_AUTO in bytes */
+	} else {
+		len = ALIGN_DOWN(len, sizeof(uint32_t));
+		tsz = get_max_tsz(len, &transfer_shift);
+		desc->dcm = DCM_DAI | DCM_SAI | tsz << DCM_TSZ_SFT;
+		desc->dtc = len >> transfer_shift; /* in burst unit */
+		barrier();
+		len = desc->dtc << transfer_shift;
+	}
+
+	desc->dsa = saddr;
+	desc->dta = daddr;
+	desc->sd = 0;
+	desc->drt = INGENIC_DMA_REQ_AUTO_TX;
+
+	return len;
+}
+
+static unsigned int build_one_slave_desc(struct ingenic_dma_chan *dmac, dma_addr_t addr,
+		unsigned int length,
+		enum dma_transfer_direction direction,
+		struct hdma_desc *desc)
+{
+	enum dma_transfer_direction dir;
+	unsigned int rdil;
+//	unsigned int tsz, transfer_shift;
+
+	desc->dcm = dmac->dcm;
+	desc->drt = dmac->slave_id;
+	desc->sd = 0;
+
+	if ((direction != DMA_DEV_TO_MEM) && (direction != DMA_MEM_TO_DEV))
+		dir = dmac->direction;
+	else
+		dir = direction;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		desc->dta = addr;
+		desc->dsa = dmac->slave_addr;
+		desc->dcm |= DCM_DAI;
+	} else {
+		desc->dsa = addr;
+		desc->dta = dmac->slave_addr;
+		desc->dcm |= DCM_SAI;
+	}
+
+	rdil = dmac->maxburst * dmac->transfer_width;
+	if (rdil > 4)
+		rdil = min((int)fls(rdil) + 1, (int)DCM_RDIL_MAX);
+
+	WARN_ON(length & (~DTC_TC_MSK));
+	if (WARN_ON(!IS_ALIGNED(length, dmac->transfer_width)))
+		desc->dtc = ALIGN_DOWN((length & DTC_TC_MSK), dmac->transfer_width);
+	else
+		desc->dtc = (length & DTC_TC_MSK);
+	desc->dcm |= DCM_TSZ_MSK | (rdil << DCM_RDIL_SFT);
+
+	return desc->dtc;
+}
+
+static void ingenic_dma_free_swdesc(struct virt_dma_desc *vd)
+{
+	struct ingenic_dma_sdesc *sdesc = to_ingenic_dma_sdesc(vd);
+	struct ingenic_dma_chan *dmac = sdesc->dmac;
+	unsigned long flags;
+	int i;
+
+	WARN_ON(!sdesc->dmac);
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flags);
+
+	if (dmac->hdesc_pool) {
+		for (i = 0; i < sdesc->nb_desc; i++)
+			dma_pool_free(dmac->hdesc_pool, sdesc->hw_desc[i],
+					sdesc->hw_desc_dma[i]);
+		dmac->hdesc_num -= sdesc->nb_desc;
+	}
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
+
+	kfree(sdesc);
+}
+
+static struct ingenic_dma_sdesc *ingenic_dma_alloc_swdesc(struct ingenic_dma_chan *dmac,
+		int num_hdesc)
+{
+	struct ingenic_dma_sdesc *sdesc;
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flags);
+
+	if (num_hdesc > (dmac->hdesc_max - dmac->hdesc_num) || !dmac->hdesc_pool) {
+		spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
+
+		return NULL;
+	}
+
+	sdesc = kzalloc(sizeof(struct ingenic_dma_sdesc) +
+			num_hdesc * (sizeof(void **) + sizeof(dma_addr_t)),
+			GFP_NOWAIT);
+	if (!sdesc) {
+		spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
+
+		return NULL;
+	}
+
+	sdesc->hw_desc = (struct hdma_desc **)(sdesc + 1);
+	sdesc->hw_desc_dma = (dma_addr_t *)(sdesc->hw_desc + num_hdesc);
+	sdesc->dmac = dmac;
+
+	for (i = 0; i < num_hdesc; i++) {
+		sdesc->hw_desc[i] = dma_pool_alloc(dmac->hdesc_pool, GFP_NOWAIT,
+				&sdesc->hw_desc_dma[i]);
+		//pr_debug("sdesc->hw_desc[%d] = %p, sdesc->hw_desc_dma[%d] = 0x%08x\n",
+				//i, sdesc->hw_desc[i],
+				//i, sdesc->hw_desc_dma[i]);
+		if (!sdesc->hw_desc[i]) {
+			dev_err(&dmac->vc.chan.dev->device,
+					"%s(): Couldn't allocate the hw_desc from dma_pool %p\n",
+					__func__, dmac->hdesc_pool);
+			spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
+
+			goto err;
+		}
+		sdesc->nb_desc++;
+	}
+	dmac->hdesc_num += sdesc->nb_desc;
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
+
+	return sdesc;
+
+err:
+	ingenic_dma_free_swdesc(&sdesc->vd);
+
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *ingenic_dma_prep_slave_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *sdesc;
+	int i;
+
+	sdesc = ingenic_dma_alloc_swdesc(dmac, sg_len);
+	if (!sdesc)
+		return NULL;
+
+	for (i = 0; i < sg_len; i++) {
+		sdesc->len += build_one_slave_desc(dmac, sg_dma_address(&sgl[i]),
+				sg_dma_len(&sgl[i]), direction, sdesc->hw_desc[i]);
+		if (i) {
+			sdesc->hw_desc[i - 1]->dcm |= DCM_LINK;
+			sdesc->hw_desc[i - 1]->dtc |= PHY_TO_DESC_DOA(sdesc->hw_desc_dma[i]);
+		}
+	}
+	sdesc->hw_desc[i - 1]->dcm |= DCM_TIE;
+	sdesc->cyclic = false;
+	sdesc->dcs = DCS_DES8;
+
+	return vchan_tx_prep(&dmac->vc, &sdesc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *ingenic_dma_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+		size_t period_len, enum dma_transfer_direction direction,
+		unsigned long flags)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	unsigned int periods = buf_len / period_len;
+	struct ingenic_dma_sdesc *sdesc;
+	int i;
+
+	sdesc = ingenic_dma_alloc_swdesc(dmac, periods);
+	if (!sdesc)
+		return NULL;
+
+	for (i = 0; i < periods; i++) {
+		sdesc->len += build_one_slave_desc(dmac, buf_addr + (i * period_len),
+				period_len, direction, sdesc->hw_desc[i]);
+
+		if (i) {
+			sdesc->hw_desc[i - 1]->dcm |= DCM_LINK | DCM_TIE;
+			sdesc->hw_desc[i - 1]->dtc |= PHY_TO_DESC_DOA(sdesc->hw_desc_dma[i]);
+		}
+
+	}
+
+	sdesc->hw_desc[i - 1]->dcm |= DCM_LINK | DCM_TIE;
+	sdesc->hw_desc[i - 1]->dtc |= PHY_TO_DESC_DOA(sdesc->hw_desc_dma[0]);
+	sdesc->cyclic = true;
+	sdesc->dcs = DCS_DES8;
+
+	return vchan_tx_prep(&dmac->vc, &sdesc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *ingenic_dma_prep_dma_memcpy(
+		struct dma_chan *chan, dma_addr_t dma_dest, dma_addr_t dma_src,
+			size_t len, unsigned long flags)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *sdesc;
+
+	sdesc = ingenic_dma_alloc_swdesc(dmac, 1);
+	if (!sdesc)
+		return NULL;
+
+	sdesc->len = build_one_desc(dma_src, dma_dest, len, sdesc->hw_desc[0]);
+	sdesc->hw_desc[0]->dcm |= DCM_TIE;
+	sdesc->cyclic = false;
+	sdesc->dcs = DCS_DES8;
+
+	return vchan_tx_prep(&dmac->vc, &sdesc->vd, flags);
+}
+
+static size_t ingenic_dma_desc_residue(struct ingenic_dma_chan *dmac,
+		struct ingenic_dma_sdesc *sdesc)
+{
+	unsigned int residue = 0, shift, pass = 0;
+	unsigned int i;
+	bool dsa = false;
+	dma_addr_t start, end, compare;
+
+	if (sdesc->hw_desc[0]->dcm & DCM_SAI) {
+		compare = readl(dmac->iomem + CH_DSA);
+		dsa = true;
+	} else {
+		compare = readl(dmac->iomem + CH_DTA);
+	}
+
+	for (i = 0; i < sdesc->nb_desc; i++) {
+		start = dsa ? sdesc->hw_desc[i]->dsa : sdesc->hw_desc[i]->dta;
+		shift = get_current_tsz(sdesc->hw_desc[i]->dcm);
+		end = start + (sdesc->hw_desc[i]->dtc << shift);
+
+		if (!(start <= compare && end > compare)) {
+			pass += sdesc->hw_desc[i]->dtc << shift;
+		} else {
+			pass += (compare - start);
+			break;
+
+		}
+
+	}
+
+	residue = sdesc->len - pass;
+
+	return residue;
+}
+
+static enum dma_status ingenic_dma_tx_status(struct dma_chan *chan,
+		dma_cookie_t cookie,
+		struct dma_tx_state *txstate)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct virt_dma_desc *vd;
+	enum dma_status status;
+	unsigned long flags;
+
+	status = dma_cookie_status(chan, cookie, txstate);
+	if ((status == DMA_COMPLETE) || (txstate == NULL))
+		return status;
+
+	spin_lock_irqsave(&dmac->vc.lock, flags);
+
+	vd = vchan_find_desc(&dmac->vc, cookie);
+	if (vd)
+		dma_set_residue(txstate, to_ingenic_dma_sdesc(vd)->len);
+	else if (dmac->sdesc && cookie == dmac->sdesc->vd.tx.cookie)
+		dma_set_residue(txstate, ingenic_dma_desc_residue(dmac, dmac->sdesc));
+	else
+		dma_set_residue(txstate, 0);
+
+	spin_unlock_irqrestore(&dmac->vc.lock, flags);
+
+	return status;
+}
+
+static void ingenic_dma_start_trans(struct ingenic_dma_chan *dmac)
+{
+	struct virt_dma_desc *vd = NULL;
+	struct ingenic_dma_sdesc *sdesc;
+	int i, j;
+
+	if (!dmac->sdesc) {
+		vd = vchan_next_desc(&dmac->vc);
+		if (!vd)
+			return;
+
+		list_del(&vd->node);
+
+		sdesc = dmac->sdesc = to_ingenic_dma_sdesc(vd);
+
+		if (dmac->fake_cyclic && sdesc->cyclic && vd->tx.callback) {
+			/*
+			 * The DMA controller doesn't support triggering an interrupt
+			 * after processing each descriptor, only after processing an
+			 * entire terminated list of descriptors.For a cyclic DMA
+			 * setup the list of descriptors is not terminated so we can
+			 * never get an interrupt.
+			 *
+			 * If the user requested a callback for a cyclic DMA setup then
+			 * we workaround this hardware limitation here by degrading to
+			 * a set of unlinked descriptors which we will submit in
+			 * sequence in response to the completion of processing the
+			 * previous descriptor
+			 */
+			for (i = 0; i < sdesc->nb_desc; i++)
+				sdesc->hw_desc[i]->dcm &= ~DCM_LINK;
+		}
+
+		for (i = 0; i < sdesc->nb_desc; i++) {
+			uint32_t *vaddr = (void *)sdesc->hw_desc[i];
+
+			for (j = 0; j < 8; j++)
+				pr_debug("<%d>: &vaddr[0] %p vaddr[0] %x\n", i, &vaddr[j],
+					vaddr[j]);
+
+			//pr_debug("sdesc->hw_desc_dma[0] 0x%08x dmac->iomem %p\n",
+				//sdesc->hw_desc_dma[i], dmac->iomem);
+		}
+
+		sdesc->curr_desc = 0;
+		sdesc->status = STAT_RUNNING;
+	} else {
+		sdesc = dmac->sdesc;
+		WARN_ON_ONCE((!sdesc->cyclic));
+		WARN_ON_ONCE((!vd->tx.callback));
+		WARN_ON_ONCE((!dmac->fake_cyclic));
+		sdesc->status = STAT_RUNNING;
+		sdesc->curr_desc++;
+		sdesc->curr_desc = sdesc->curr_desc % sdesc->nb_desc;
+	}
+
+	dump_dma_hdesc(sdesc->hw_desc[sdesc->curr_desc], __func__);
+	/* dma descriptor address */
+	writel(sdesc->hw_desc_dma[sdesc->curr_desc], dmac->iomem + CH_DDA);
+	/* initiate descriptor fetch */
+	writel(BIT(dmac->id), dmac->engine->iomem + DDRS);
+	/* transfer start */
+	dev_dbg(chan2dev(&dmac->vc.chan), "dcs:%x start transfer\n",
+			readl(dmac->iomem + CH_DCS));
+
+	writel(sdesc->dcs | DCS_CTE, dmac->iomem + CH_DCS);
+}
+
+static void ingenic_dma_issue_pending(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmac->vc.lock, flags);
+
+	if (vchan_issue_pending(&dmac->vc) && !dmac->sdesc)
+		ingenic_dma_start_trans(dmac);
+
+	spin_unlock_irqrestore(&dmac->vc.lock, flags);
+}
+
+static int ingenic_dma_terminate_all(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	unsigned long flags;
+	int ret = 0, i;
+
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&dmac->vc.lock, flags);
+
+	/* the part handler audio driver */
+	if (dmac->slave_id == INGENIC_DMA_REQ_AIC_LOOP_RX ||
+			dmac->slave_id == INGENIC_DMA_REQ_AIC_TX ||
+				dmac->slave_id == INGENIC_DMA_REQ_AIC_F_RX) {
+
+		if (dmac->sdesc) {	/*DMA transfer is running*/
+			if (dmac->sdesc->status != STAT_STOPPED) {
+				dmac->sdesc->status = STAT_STOPPED;
+				writel(0, dmac->iomem + CH_DCS);
+			}
+
+			ingenic_dma_free_swdesc(&dmac->sdesc->vd);
+			dmac->sdesc = NULL;
+		}
+
+		goto done;
+	}
+
+	if (dmac->sdesc) {	/*DMA transfer is running*/
+		ret = -EBUSY;
+
+		if (dmac->sdesc->status != STAT_STOPPED) {
+			dmac->sdesc->status = STAT_STOPPED;
+			reinit_completion(&dmac->completion);
+
+			for (i = 0; i < dmac->sdesc->nb_desc; i++) {
+				dmac->sdesc->hw_desc[i]->dcm |= DCM_TIE;
+				dmac->sdesc->hw_desc[i]->dcm &= ~DCM_LINK;
+			}
+
+			if (HWATTR_DESC_INTER_SUP(dmac->engine->hwattr)) {
+				/*
+				 * The version of controller support descriptor interrupt
+				 * can clear LINK on runtime
+				 */
+				unsigned int dcm = readl(dmac->iomem + CH_DCM);
+
+				if (dcm & DCM_LINK) {
+					dcm &= ~DCM_LINK;
+					writel(dcm, dmac->iomem + CH_DCM);
+				}
+
+			}
+
+		} else if (readl(dmac->iomem + CH_DRT) != INGENIC_DMA_REQ_AUTO_TX) {
+			writel(0, dmac->iomem + CH_DCS);
+			ingenic_dma_free_swdesc(&dmac->sdesc->vd);
+			dmac->sdesc = NULL;
+			complete(&dmac->completion);
+			ret = 0;
+		}
+	} else {
+		writel(0, dmac->iomem + CH_DCS);
+	}
+
+done:
+	vchan_get_all_descriptors(&dmac->vc, &head);
+	spin_unlock_irqrestore(&dmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&dmac->vc, &head);
+
+	return ret;
+}
+
+static int ingenic_dma_wait_terminate_complete(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+	if (dmac->sdesc)
+		wait_for_completion(&dmac->completion);
+
+	return 0;
+}
+
+static int ingenic_dma_config(struct dma_chan *chan,
+		struct dma_slave_config *config)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	enum dma_slave_buswidth transfer_width;
+
+	if (!config)
+		return -EINVAL;
+
+	switch (config->direction) {
+	case DMA_MEM_TO_DEV:
+		if (!config->dst_addr_width || !config->dst_addr)
+			return -EINVAL;
+		if (!config->dst_maxburst)
+			config->dst_maxburst = 1;
+		transfer_width = config->dst_addr_width;
+		dmac->slave_addr = config->dst_addr;
+		dmac->maxburst = config->dst_maxburst;
+		break;
+	case DMA_DEV_TO_MEM:
+		if (!config->src_addr_width || !config->src_addr)
+			return -EINVAL;
+		if (!config->src_maxburst)
+			config->src_maxburst = 1;
+		transfer_width = config->src_addr_width;
+		dmac->slave_addr = config->src_addr;
+		dmac->maxburst = config->src_maxburst;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (transfer_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		dmac->dcm = DCM_PORT_8;
+		dmac->transfer_width = 1;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		dmac->dcm = DCM_PORT_16;
+		dmac->transfer_width = 2;
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		dmac->dcm = DCM_PORT_32;
+		dmac->transfer_width = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* must be delete it */
+	//if (config->slave_id & INGENIC_DMA_TYPE_REQ_MSK)
+	//	dmac->slave_id = config->slave_id & INGENIC_DMA_TYPE_REQ_MSK;
+
+	return 0;
+}
+
+static void pdma_handle_chan_irq(struct ingenic_dma_engine *ingenic_dma, int ch_id)
+{
+	struct ingenic_dma_chan *dmac = ingenic_dma->chan[ch_id];
+	struct ingenic_dma_sdesc *sdesc;
+	unsigned int dcs;
+
+	spin_lock(&dmac->vc.lock);
+
+	dcs = readl(dmac->iomem + CH_DCS);
+	writel(0, dmac->iomem + CH_DCS);
+
+	if (dcs & DCS_AR)
+		dev_warn(&dmac->vc.chan.dev->device,
+				"address error (DCS=0x%x)\n", dcs);
+
+	if (dcs & DCS_HLT)
+		dev_warn(&dmac->vc.chan.dev->device,
+				"channel halt (DCS=0x%x)\n", dcs);
+	sdesc = dmac->sdesc;
+	if (sdesc) {
+		if (sdesc->status == STAT_STOPPED) {
+			dma_cookie_complete(&sdesc->vd.tx);
+			ingenic_dma_free_swdesc(&sdesc->vd);
+			complete(&dmac->completion);
+		} else if (dmac->fake_cyclic && sdesc->cyclic) {
+			vchan_cyclic_callback(&sdesc->vd);
+		} else {
+			vchan_cookie_complete(&sdesc->vd);
+		}
+		dmac->sdesc = NULL;
+		ingenic_dma_start_trans(dmac);
+	} else {
+		dev_warn(&dmac->vc.chan.dev->device,
+			"channel irq with no active transfer, channel stop\n");
+	}
+
+	spin_unlock(&dmac->vc.lock);
+}
+
+static irqreturn_t pdma_int_handler(int irq, void *dev)
+{
+	struct ingenic_dma_engine *ingenic_dma = (struct ingenic_dma_engine *)dev;
+	unsigned long pending, dmac;
+	int i;
+
+	pending = readl(ingenic_dma->iomem + DIRQP);
+	writel(~pending, ingenic_dma->iomem + DIRQP);
+
+	for (i = 0; i < ingenic_dma->nr_chs ; i++) {
+		if (!(pending & (1 << i)))
+			continue;
+		pdma_handle_chan_irq(ingenic_dma, i);
+	}
+
+	dmac = readl(ingenic_dma->iomem + DMAC);
+	dmac &= ~(DMAC_HLT | DMAC_AR);
+	writel(dmac, ingenic_dma->iomem + DMAC);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pdmam_int_handler(int irq, void *dev)
+{
+	/*TODO*/
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pdmad_int_handler(int irq, void *dev)
+{
+	struct ingenic_dma_engine *ingenic_dma = (struct ingenic_dma_engine *)dev;
+	unsigned long pending;
+	int i;
+
+	pending = readl(ingenic_dma->iomem + DIP);
+	writel(readl(ingenic_dma->iomem + DIP) & (~pending), ingenic_dma->iomem + DIC);
+
+	for (i = 0; i < ingenic_dma->nr_chs; i++) {
+		struct ingenic_dma_chan *dmac = ingenic_dma->chan[i];
+		struct ingenic_dma_sdesc *sdesc;
+
+		if (!(pending & (1 << i)))
+			continue;
+		sdesc = dmac->sdesc;
+		if (sdesc && sdesc->cyclic) {
+			spin_lock(&dmac->vc.lock);
+			vchan_cyclic_callback(&sdesc->vd);
+			spin_unlock(&dmac->vc.lock);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ingenic_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+	dmac->hdesc_pool = dma_pool_create(dev_name(&chan->dev->device),
+			chan->device->dev, sizeof(struct hdma_desc), 0, PAGE_SIZE);
+	if (!dmac->hdesc_pool) {
+		dev_err(&chan->dev->device,
+				"failed to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
+
+	dmac->hdesc_max = PAGE_SIZE / sizeof(struct hdma_desc);
+	dmac->hdesc_num = 0;
+
+	return 0;
+}
+
+static void ingenic_dma_synchronize(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+	vchan_synchronize(&dmac->vc);
+}
+
+static void ingenic_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	unsigned long flags;
+
+	ingenic_dma_terminate_all(chan);
+
+	ingenic_dma_wait_terminate_complete(chan);
+
+	dma_pool_destroy(dmac->hdesc_pool);
+	spin_lock_irqsave(&dmac->hdesc_lock, flags);
+	dmac->hdesc_pool = NULL;
+	dmac->hdesc_max = 0;
+	dmac->hdesc_num = 0;
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
+}
+
+static bool ingenic_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	unsigned int private          = *(unsigned int *)param;
+	unsigned long type             = (unsigned long)chan->private;
+	int channel = -1;
+
+	if (private & INGENIC_DMA_TYPE_CH_EN) {
+		channel = (private & INGENIC_DMA_TYPE_CH_MSK) >> INGENIC_DMA_TYPE_CH_SFT;
+		if (dmac->id == channel) {
+			dev_info(&chan->dev->device,
+				"assignment channel is %d\n", channel);
+			return true;
+		}
+		return false;
+	}
+
+	if (dmac->engine->chan_reserved & BIT(dmac->id))
+		return false;
+
+	if ((private & INGENIC_DMA_TYPE_REQ_MSK) != type)
+		return false;
+
+	dmac->slave_id = private & INGENIC_DMA_TYPE_REQ_MSK;
+
+	return true;
+}
+
+static struct of_dma_filter_info of_ingenic_dma_info = {
+	.filter_fn = ingenic_dma_filter_fn,
+};
+
+static int ingenic_dma_chan_init(struct ingenic_dma_engine *dma, int id)
+{
+	struct ingenic_dma_chan *dmac = NULL;
+
+	if ((id < 0) || (id >= INGENIC_DMA_CHAN_CNT))
+		return -EINVAL;
+
+	dmac = devm_kzalloc(dma->dev, sizeof(*dmac), GFP_KERNEL);
+	if (!dmac)
+		return -ENOMEM;
+
+	dmac->id          = id;
+	dmac->iomem       = dma->iomem + dmac->id * DMACH_OFF;
+	dmac->engine      = dma;
+	dmac->fake_cyclic = HWATTR_DESC_INTER_SUP(dma->hwattr) ? false : true;
+
+	spin_lock_init(&dmac->hdesc_lock);
+	init_completion(&dmac->completion);
+
+	vchan_init(&dmac->vc, &dma->dma_device);
+
+	dmac->vc.desc_free    = ingenic_dma_free_swdesc;
+	dmac->vc.chan.private = (void *)pdma_maps[id];
+	dmac->slave_id        = pdma_maps[id] & INGENIC_DMA_TYPE_REQ_MSK;
+	dma->chan[id]         = dmac;
+
+	return 0;
+}
+
+static int __init ingenic_dma_probe(struct platform_device *pdev)
+{
+	struct ingenic_dma_engine *dma = NULL;
+	struct resource *iores;
+	u32 reg_dmac = DMAC_DMAE;
+	int i, ret = 0;
+
+	/* check of first. if of failed, use platform */
+
+	dma = ingenic_dma_parse_dt(pdev);
+	if (IS_ERR(dma))
+		return PTR_ERR(dma);
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dma->iomem = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(dma->iomem))
+		return PTR_ERR(dma->iomem);
+
+	/* PDMA interrupt*/
+	dma->irq_pdma = platform_get_irq_byname(pdev, "pdma");
+	if (dma->irq_pdma < 0)
+		return dma->irq_pdma;
+
+	ret = devm_request_irq(&pdev->dev, dma->irq_pdma, pdma_int_handler,
+			0, "pdma", dma);
+	if (ret)
+		return ret;
+
+	/* PDMA mcu interrupt*/
+	dma->irq_pdmam = platform_get_irq_byname(pdev, "pdmam");
+	if (dma->irq_pdmam >= 0) {
+		ret = devm_request_irq(&pdev->dev, dma->irq_pdmam, pdmam_int_handler,
+				0, "pdmam", dma);
+		if (ret)
+			return ret;
+	}
+
+	/* PDMA descriptor interrupt */
+	if (HWATTR_DESC_INTER_SUP(dma->hwattr)) {
+		dma->irq_pdmad = platform_get_irq_byname(pdev, "pdmad");
+		if (dma->irq_pdmad < 0) {
+			dev_err(&pdev->dev, "unable to get pdmad irq\n");
+			return dma->irq_pdmad;
+		}
+		ret = devm_request_irq(&pdev->dev, dma->irq_pdmad, pdmad_int_handler,
+				0, "pdmad", dma);
+		if (ret)
+			return ret;
+	}
+
+	/* Initialize dma engine */
+	INIT_LIST_HEAD(&dma->dma_device.channels);
+	for (i = 0; i < dma->nr_chs; i++) {
+		/*reserved one channel for intc interrupt*/
+		if (dma->intc_ch == i)
+			continue;
+		ingenic_dma_chan_init(dma, i);
+	}
+
+	dma_cap_set(DMA_MEMCPY, dma->dma_device.cap_mask);
+	dma_cap_set(DMA_SLAVE, dma->dma_device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, dma->dma_device.cap_mask);
+
+	dma->dma_device.dev                         = &pdev->dev;
+	dma->dma_device.device_alloc_chan_resources = ingenic_dma_alloc_chan_resources;
+	dma->dma_device.device_free_chan_resources  = ingenic_dma_free_chan_resources;
+	dma->dma_device.device_tx_status            = ingenic_dma_tx_status;
+	dma->dma_device.device_prep_slave_sg        = ingenic_dma_prep_slave_sg;
+	dma->dma_device.device_prep_dma_cyclic      = ingenic_dma_prep_dma_cyclic;
+	dma->dma_device.device_prep_dma_memcpy      = ingenic_dma_prep_dma_memcpy;
+	dma->dma_device.device_config               = ingenic_dma_config;
+	dma->dma_device.device_terminate_all        = ingenic_dma_terminate_all;
+	dma->dma_device.device_issue_pending        = ingenic_dma_issue_pending;
+	dma->dma_device.device_synchronize          = ingenic_dma_synchronize;
+	dma->dma_device.copy_align                  = DMAENGINE_ALIGN_4_BYTES;
+	dma->dma_device.src_addr_widths             = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+							BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+								BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma->dma_device.dst_addr_widths             = dma->dma_device.src_addr_widths;
+	dma->dma_device.directions                  = BIT(DMA_DEV_TO_MEM) |
+							BIT(DMA_MEM_TO_DEV) |
+								BIT(DMA_MEM_TO_MEM);
+	dma->dma_device.residue_granularity         = DMA_RESIDUE_GRANULARITY_BURST;
+	dma->dma_device.dev->dma_parms              = &dma->dma_parms;
+
+	dma_set_max_seg_size(dma->dma_device.dev, DTC_TC_MSK);	/*At least*/
+
+	dma->gate_clk = devm_clk_get(&pdev->dev, "gate_pdma");
+	if (IS_ERR(dma->gate_clk))
+		return PTR_ERR(dma->gate_clk);
+
+	ret = dma_async_device_register(&dma->dma_device);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register\n");
+		clk_disable(dma->gate_clk);
+		return ret;
+	}
+
+	of_ingenic_dma_info.dma_cap = dma->dma_device.cap_mask;
+	ret = of_dma_controller_register(pdev->dev.of_node,
+			of_dma_simple_xlate, &of_ingenic_dma_info);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register dma to device tree\n");
+		dma_async_device_unregister(&dma->dma_device);
+		clk_disable(dma->gate_clk);
+		return ret;
+	}
+
+
+	platform_set_drvdata(pdev, dma);
+
+	/*enable pdma controller*/
+	clk_prepare_enable(dma->gate_clk);
+
+	if (dma->chan_programed)
+		writel(dma->chan_programed, dma->iomem + DMACP);
+	if (dma->intc_ch >= 0)
+		reg_dmac |= DMAC_INTCE | ((dma->intc_ch << DMAC_INTCC_SFT) & DMAC_INTCC_MSK);
+	if (dma->special_ch)
+		reg_dmac |= DMAC_CH01;
+	writel(reg_dmac, dma->iomem + DMAC);
+
+	dev_info(dma->dev, "INGENIC SoC DMA initialized\n");
+
+	return 0;
+}
+
+static int ingenic_dma_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ingenic_dma_engine *ingenic_dma = platform_get_drvdata(pdev);
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &ingenic_dma->dma_device.channels, device_node) {
+		struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+		if (dmac->sdesc)
+			return -EBUSY;
+	}
+	clk_disable_unprepare(ingenic_dma->gate_clk);
+
+	return 0;
+}
+
+static int ingenic_dma_resume(struct platform_device *pdev)
+{
+	struct ingenic_dma_engine *ingenic_dma = platform_get_drvdata(pdev);
+
+	clk_prepare_enable(ingenic_dma->gate_clk);
+
+	return 0;
+}
+
+static const struct of_device_id ingenic_dma_dt_match[] = {
+	{ .compatible = "ingenic,m200-pdma",  .data = (void *)(HWATTR_SPECIAL_CH01 |
+							HWATTR_INTC_IRQ)},
+	{ .compatible = "ingenic,x1000-pdma", .data = (void *)HWATTR_DESC_INTER },
+	{ .compatible = "ingenic,t40-pdma",   .data = (void *)HWATTR_INTC_IRQ },
+	/*{ .compatible = "ingenic,t41-pdma",   .data = (void *)HWATTR_INTC_IRQ },*/
+	{ .compatible = "ingenic,t33-pdma",   .data = (void *)NULL },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ingenic_dma_dt_match);
+
+static struct platform_driver ingenic_dma_driver = {
+	.driver = {
+		.name           = "ingenic-dma",
+		.owner          = THIS_MODULE,
+		.of_match_table = of_match_ptr(ingenic_dma_dt_match),
+	},
+	.suspend = ingenic_dma_suspend,
+	.resume  = ingenic_dma_resume,
+};
+
+static int __init ingenic_dma_module_init(void)
+{
+	return platform_driver_probe(&ingenic_dma_driver, ingenic_dma_probe);
+}
+
+subsys_initcall(ingenic_dma_module_init);
+MODULE_AUTHOR("Chen.li <chen.li@ingenic.cn>");
+MODULE_DESCRIPTION("Ingenic dma driver");
diff --git a/drivers/dma/ingenic/ingenic_dma.h b/drivers/dma/ingenic/ingenic_dma.h
new file mode 100644
index 000000000000..c78e3ab7b317
--- /dev/null
+++ b/drivers/dma/ingenic/ingenic_dma.h
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2016 Ingenic Semiconductor Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __INGENIC_DMA_H__
+#define __INGENIC_DMA_H__
+#include <dt-bindings/dma/ingenic-pdma.h>
+#include "../virt-dma.h"
+#include "../dmaengine.h"
+#define CH_DSA	0x00
+#define CH_DTA	0x04
+#define CH_DTC	0x08
+#define CH_DRT	0x0C
+#define CH_DCS	0x10
+#define CH_DCM	0x14
+#define CH_DDA	0x18
+#define CH_DSD	0x1C
+
+#define TCSM	0x2000
+
+#define DMAC	0x1000
+#define DIRQP	0x1004
+#define DDR	0x1008
+#define DDRS	0x100C
+#define DIP	0x1010
+#define DIC	0x1014
+#define DMACP	0x101C
+#define DSIRQP	0x1020
+#define DSIRQM	0x1024
+#define DCIRQP	0x1028
+#define DCIRQM	0x102C
+
+#define DMACH_OFF	0x20
+/* DCS */
+#define DCS_NDES	BIT(31)
+#define DCS_DES8	BIT(30)
+#define DCS_CDOA_SFT	8
+#define DCS_CDOA_MSK	(0xff << DCS_CDOA_SFT)
+#define DCS_AR		BIT(4)
+#define DCS_TT		BIT(3)
+#define DCS_HLT		BIT(2)
+#define DCS_CTE		BIT(0)
+
+/* DTC */
+#define DTC_TC_SFT	0
+#define DTC_TC_MSK	0xffffff
+
+/* DCM */
+#define DCM_SAI		BIT(23)
+#define DCM_DAI		BIT(22)
+#define DCM_PORT_MSK	(0xf << 12)
+#define DCM_PORT_8	(0x1 << 14 | 0x1 << 12)
+#define DCM_PORT_16	(0x2 << 14 | 0x2 << 12)
+#define DCM_PORT_32	(0x0 << 14 | 0x0 << 12)
+#define DCM_RDIL_SFT	16
+#define DCM_RDIL_MAX	0x9
+#define DCM_RDIL_MSK	(0xf << DCM_RDIL_SFT)
+#define DCM_TSZ_SFT	8
+#define DCM_TSZ_AUTO	0x7
+#define DCM_TSZ_MSK	(0x7 << DCM_TSZ_SFT)
+#define DCM_STDE	BIT(2)
+#define DCM_TIE		BIT(1)
+#define DCM_LINK	BIT(0)
+
+/* DDA */
+#define DDA_DBA_SFT	12
+#define DDA_DBA_MSK	(0xfffff << DDA_DBA_SFT)
+#define DDA_DOA_SFT	4
+#define DDA_DOA_MSK	(0xff << DDA_DOA_SFT)
+#define PHY_TO_DESC_DOA(dma)	 ((((dma) & DDA_DOA_MSK) >> DDA_DOA_SFT) << 24)
+
+/* DSD */
+#define DSD_TSD_SFT	16
+#define DSD_TSD_MSK	(0xffff << DSD_TSD_SFT)
+#define DSD_SSD_SFT	0
+#define DSD_SSD_MSK	(0xffff << DSD_SSD_SFT)
+
+/* DMAC */
+#define DMAC_FMSC	BIT(31)
+#define DMAC_FSSI	BIT(30)
+#define DMAC_FTSSI	BIT(29)
+#define DMAC_FUART	BIT(28)
+#define DMAC_FAIC	BIT(27)
+#define DMAC_INTCC_SFT	17
+#define DMAC_INTCC_MSK	(0x1f << 17)
+#define DMAC_INTCE	BIT(16)
+#define DMAC_HLT	BIT(3)
+#define DMAC_AR		BIT(2)
+#define DMAC_CH01	BIT(1)
+#define DMAC_DMAE	BIT(0)
+
+/* MCU of PDMA */
+#define DMCS	0x1030
+#define DMNMB	0x1034
+#define DMSMB	0x1038
+#define DMINT	0x103C
+
+/* MCU of PDMA */
+#define DMINT_S_IP      BIT(17)
+#define DMINT_N_IP      BIT(16)
+
+#define DMA_SPECAIL_CHS	0x3		/*Channel 0 & 1*/
+
+/*8-word hardware dma descriptor*/
+struct hdma_desc {
+	unsigned long dcm;
+	dma_addr_t dsa;
+	dma_addr_t dta;
+	unsigned long dtc;
+	unsigned long sd;
+	unsigned long drt;
+	unsigned long reserved[2];
+};
+
+enum sdesc_status {
+	STAT_STOPPED = 0, STAT_RUNNING, STAT_ERROR
+};
+
+struct ingenic_dma_chan;
+struct ingenic_dma_sdesc {
+	struct virt_dma_desc	vd;		/* Virtual descriptor */
+	int			nb_desc;	/* Number of hw. descriptors */
+	size_t			len;		/* Number of bytes xfered */
+	bool			cyclic;
+	struct hdma_desc	**hw_desc;	/* DMA coherent descriptors */
+	dma_addr_t		*hw_desc_dma;	/* DMA address of the Descriptors*/
+	struct ingenic_dma_chan	*dmac;		/* for free*/
+	int			dcs;		/* The DCS initial value */
+	int			curr_desc;
+	enum sdesc_status	status;
+};
+
+struct ingenic_dma_chan {
+	struct virt_dma_chan	vc;		/* Virtual channel */
+	int			id;		/* Channel id*/
+	void __iomem		*iomem;
+	struct ingenic_dma_engine	*engine;
+	bool			fake_cyclic;
+
+	/*dma slave channel config*/
+	unsigned int		slave_id;	/* Request type of the channel */
+	enum dma_transfer_direction direction;
+	dma_addr_t		slave_addr;
+	unsigned int		maxburst;
+	unsigned int		transfer_width;
+	unsigned int		fast_mode;	/* The fast mode bit of dmac*/
+	unsigned int		dcm;		/* The DCM of HW Descriptor initial value*/
+
+
+	/*Descriptors*/
+	struct dma_pool		*hdesc_pool;	/*HW Descriptors pool */
+	spinlock_t		hdesc_lock;	/*HW Descriptor assign lock*/
+	int			hdesc_num;	/*HW Descriptors assigned num*/
+	int			hdesc_max;	/*HW Descriptors maxnum capacity*/
+
+	struct ingenic_dma_sdesc	*sdesc;		/*Current Running Async Tx Desc*/
+
+	/*channel terminated completion*/
+	struct completion completion;
+};
+
+struct ingenic_dma_engine {
+	struct device		*dev;
+	void __iomem		*iomem;
+	struct clk		*gate_clk;
+	struct dma_device		dma_device;
+	struct device_dma_parameters	dma_parms;
+
+	uint32_t		chan_reserved;
+	uint32_t		chan_programed;
+	int			intc_ch;
+	bool			special_ch;
+
+	/*hardware interrupt*/
+	int			irq_pdma;	/* pdma interrupt*/
+	int                     irq_pdmam;	/* pdma mcu interrupt */
+	int			irq_pdmad;	/* pdma per-descriptor interrupt*/
+
+	/*hardware params*/
+#define HWATTR_INTC_IRQ		(1 << 0)
+#define HWATTR_SPECIAL_CH01	(1 << 1)
+#define HWATTR_DESC_INTER	(1 << 2)
+#define HWATTR_INTC_IRQ_SUP(x)		(HWATTR_INTC_IRQ & (x))
+#define	HWATTR_SPECIAL_CH01_SUP(x)	(HWATTR_SPECIAL_CH01 & (x))
+#define HWATTR_DESC_INTER_SUP(x)	(HWATTR_DESC_INTER & (x))
+	unsigned int		hwattr;
+	/*channels*/
+	int			nr_chs;
+	struct ingenic_dma_chan *chan[];
+};
+
+static inline struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+static inline struct ingenic_dma_chan *to_ingenic_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct ingenic_dma_chan, vc.chan);
+}
+
+static inline struct ingenic_dma_sdesc *to_ingenic_dma_sdesc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct ingenic_dma_sdesc, vd);
+}
+
+#define INGENIC_DMA_REQ_AUTO 0xff
+#define INGENIC_DMA_CHAN_CNT 32
+unsigned long pdma_maps[INGENIC_DMA_CHAN_CNT] = {
+	INGENIC_DMA_REQ_AUTO,
+	INGENIC_DMA_REQ_AUTO,
+	INGENIC_DMA_REQ_AIC_LOOP_RX,
+	INGENIC_DMA_REQ_AIC_TX,
+	INGENIC_DMA_REQ_AIC_F_RX,
+	INGENIC_DMA_REQ_AUTO_TX,
+	INGENIC_DMA_REQ_SADC_RX,
+	INGENIC_DMA_REQ_UART5_TX,
+	INGENIC_DMA_REQ_UART5_RX,
+	INGENIC_DMA_REQ_UART4_TX,
+	INGENIC_DMA_REQ_UART4_RX,
+	INGENIC_DMA_REQ_UART3_TX,
+	INGENIC_DMA_REQ_UART3_RX,
+	INGENIC_DMA_REQ_UART2_TX,
+	INGENIC_DMA_REQ_UART2_RX,
+	INGENIC_DMA_REQ_UART1_TX,
+	INGENIC_DMA_REQ_UART1_RX,
+	INGENIC_DMA_REQ_UART0_TX,
+	INGENIC_DMA_REQ_UART0_RX,
+	INGENIC_DMA_REQ_SSI0_TX,
+	INGENIC_DMA_REQ_SSI0_RX,
+	INGENIC_DMA_REQ_SSI1_TX,
+	INGENIC_DMA_REQ_SSI1_RX,
+	INGENIC_DMA_REQ_SLV_TX,
+	INGENIC_DMA_REQ_SLV_RX,
+	INGENIC_DMA_REQ_I2C0_TX,
+	INGENIC_DMA_REQ_I2C0_RX,
+	INGENIC_DMA_REQ_I2C1_TX,
+	INGENIC_DMA_REQ_I2C1_RX,
+	INGENIC_DMA_REQ_DES_TX,
+	INGENIC_DMA_REQ_DES_RX,
+};
+
+void jzdma_dump(struct dma_chan *chan);
+#endif /*__INGENIC_DMA_H__*/
-- 
2.17.1


