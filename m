Return-Path: <dmaengine+bounces-1461-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039B885548
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 09:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE08B21886
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DD59160;
	Thu, 21 Mar 2024 08:10:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ingenic.com (mail.ingenic.cn [106.37.171.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BBA53819;
	Thu, 21 Mar 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.37.171.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008656; cv=none; b=sfXuCOpcvX8xdjFNUrRlXqb7hUQI6zzn2TfwyOFrQndbVtkO+7FHRmcuhq6P97Ie2eYSefDPbL2g0PpzLJoX68Ac8mXMrq5EIvAnGXUQ+OYwUg/PWNu61bIoquT0AzNpcB+Si8E4b3sp/ZYERu8/3baa/fLczepDCYmchDQ2hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008656; c=relaxed/simple;
	bh=ERSBJ2eY3ZnCLqoPsIy58fUL1kb2vO7wn12F9zp0ZjM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Rh8qL0OSY93Kal5gf8WdqxMDhmklvrGTagWsCZvvBSeFIGtUUn2sfkWF89/mOyuFQG1jF2sIaQlW+7tCluFz/6iKIAzJygoqajMAppiarwo34tn/aDTlj8MV5SkDJ+nqdnANRxKAFFxb5tH2nkV4MGwmzNrroQxGM7azzAFFjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com; spf=pass smtp.mailfrom=ingenic.com; arc=none smtp.client-ip=106.37.171.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ingenic.com
Received: from localhost (unknown [60.173.195.77])
	by mail.ingenic.com (Postfix) with ESMTPA id 14C4D27000B8;
	Thu, 21 Mar 2024 16:02:35 +0800 (CST)
From: bin.yao@ingenic.com
To: vkoul@kernel.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	1587636487@qq.com,
	"bin.yao" <bin.yao@ingenic.com>
Subject: [PATCH 1/2] dmaengine: ingenic: add Ingenic PDMA controller support.
Date: Thu, 21 Mar 2024 16:02:27 +0800
Message-Id: <20240321080228.24147-1-bin.yao@ingenic.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

From: "bin.yao" <bin.yao@ingenic.com>

This module can be found on ingenic victory soc.

Signed-off-by: bin.yao <bin.yao@ingenic.com>
---
 drivers/dma/Kconfig        |    6 +
 drivers/dma/Makefile       |    1 +
 drivers/dma/ingenic-pdma.c | 1356 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1363 insertions(+)
 create mode 100644 drivers/dma/ingenic-pdma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e928f2ca0f1e..ac3b35feb784 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -179,6 +179,12 @@ config DMA_SUN6I
 	help
 	  Support for the DMA engine first found in Allwinner A31 SoCs.
 
+config DMA_INGENIC_SOC
+	tristate "Ingenic SoC DMA support"
+	select DMA_ENGINE
+	help
+	  Support the DMA engine found on Ingenic SoCs.
+
 config DW_AXI_DMAC
 	tristate "Synopsys DesignWare AXI DMA support"
 	depends on OF
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e408..c3557c5aff96 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
 obj-$(CONFIG_UNIPHIER_XDMAC) += uniphier-xdmac.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
+obj-$(CONFIG_DMA_INGENIC_SOC) += ingenic-pdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
 
diff --git a/drivers/dma/ingenic-pdma.c b/drivers/dma/ingenic-pdma.c
new file mode 100644
index 000000000000..84c6d810403c
--- /dev/null
+++ b/drivers/dma/ingenic-pdma.c
@@ -0,0 +1,1356 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Ingenic Semiconductor Co., Ltd.
+ * Author: bin.yao <bin.yao@ingenic.com>
+ */
+
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/of_dma.h>
+#include <linux/dmapool.h>
+#include <linux/interrupt.h>
+#include "dmaengine.h"
+
+#include <dt-bindings/dma/ingenic-pdma.h>
+
+#define TCSM					0x2000
+
+#define DMAC					0x1000
+#define DIRQP					0x1004
+#define DDR					0x1008
+#define DDRS					0x100C
+#define DIP					0x1010
+#define DIC					0x1014
+#define DMACP					0x101C
+#define DSIRQP					0x1020
+#define DSIRQM					0x1024
+#define DCIRQP					0x1028
+#define DCIRQM					0x102C
+
+#define DMACH_OFF				0x20
+
+#define CH_DSA					0x00
+#define CH_DTA					0x04
+#define CH_DTC					0x08
+#define CH_DRT					0x0C
+#define CH_DCS					0x10
+#define CH_DCM					0x14
+#define CH_DDA					0x18
+#define CH_DSD					0x1C
+
+/* DCS */
+#define DCS_CDOA_MSK				(0xff << DCS_CDOA_SFT)
+#define DCS_CDOA_SFT				8
+#define DCS_NDES				BIT(31)
+#define DCS_DES8				BIT(30)
+#define DCS_AR					BIT(4)
+#define DCS_TT					BIT(3)
+#define DCS_HLT					BIT(2)
+#define DCS_CTE					BIT(0)
+
+/* DTC */
+#define DTC_TC_MSK				0xffffff
+#define DTC_TC_SFT				0
+
+/* DCM */
+#define DCM_PORT_8				(0x1 << 14 | 0x1 << 12)
+#define DCM_PORT_16				(0x2 << 14 | 0x2 << 12)
+#define DCM_PORT_32				(0x0 << 14 | 0x0 << 12)
+#define DCM_RDIL_MSK				(0xf << DCM_RDIL_SFT)
+#define DCM_TSZ_MSK				(0x7 << DCM_TSZ_SFT)
+#define DCM_PORT_MSK				(0xf << 12)
+#define DCM_SAI					BIT(23)
+#define DCM_DAI					BIT(22)
+#define DCM_STDE				BIT(2)
+#define DCM_TIE					BIT(1)
+#define DCM_LINK				BIT(0)
+#define DCM_RDIL_SFT				16
+#define DCM_RDIL_MAX				9
+#define DCM_TSZ_SFT				8
+#define DCM_TSZ_AUTO				7
+
+/* DDA */
+#define PHY_TO_DESC_DOA(dma)			((((unsigned long)dma & DDA_DOA_MSK) \
+						   >> DDA_DOA_SFT) << 24)
+#define DDA_DBA_MSK				(0xfffff << DDA_DBA_SFT)
+#define DDA_DOA_MSK				(0xff << DDA_DOA_SFT)
+#define DDA_DBA_SFT				12
+#define DDA_DOA_SFT				4
+
+/* DSD */
+#define DSD_TSD_MSK				(0xffff << DSD_TSD_SFT)
+#define DSD_SSD_MSK				(0xffff << DSD_SSD_SFT)
+#define DSD_TSD_SFT				16
+#define DSD_SSD_SFT				0
+
+/* DMAC */
+#define DMAC_INTCC_MSK				(0x1f << 17)
+#define DMAC_INTCC_SFT				17
+#define DMAC_FMSC				BIT(31)
+#define DMAC_FSSI				BIT(30)
+#define DMAC_FTSSI				BIT(29)
+#define DMAC_FUART				BIT(28)
+#define DMAC_FAIC				BIT(27)
+#define DMAC_INTCE				BIT(16)
+#define DMAC_HLT				BIT(3)
+#define DMAC_AR					BIT(2)
+#define DMAC_CH01				BIT(1)
+#define DMAC_DMAE				BIT(0)
+
+#define DMA_SPECAIL_CHS				0x3
+
+/* Hardware params */
+#define HWATTR_INTC_IRQ_SUP(x)			(HWATTR_INTC_IRQ & (x))
+#define HWATTR_SPECIAL_CH01_SUP(x)		(HWATTR_SPECIAL_CH01 & (x))
+#define HWATTR_DESC_INTER_SUP(x)		(HWATTR_DESC_INTER & (x))
+#define HWATTR_INTC_IRQ				(1 << 0)
+#define HWATTR_SPECIAL_CH01			(1 << 1)
+#define HWATTR_DESC_INTER			(1 << 2)
+
+#define DMA_DCM_TSZ_TRANSFER_UINT_128_BYTE	0x6
+#define DMA_DCM_TSZ_TRANSFER_UINT_64_BYTE	0x5
+#define DMA_DCM_TSZ_TRANSFER_UINT_32_BYTE	0x4
+#define DMA_DCM_TSZ_TRANSFER_UINT_16_BYTE	0x3
+#define DMA_DCM_TSZ_TRANSFER_UINT_4_BYTE	0x0
+#define DMA_DCM_TSZ_TRANSFER_UINT_2_BYTE	0x2
+#define DMA_DCM_TSZ_TRANSFER_UINT_1_BYTE	0x1
+
+#define INGENIC_DMA_TYPE_REQ_MSK		0xff
+#define INGENIC_DMA_TYPE_CH_SFT			8
+#define INGENIC_DMA_TYPE_CH_MSK			(0xff << INGENIC_DMA_TYPE_CH_SFT)
+#define INGENIC_DMA_TYPE_CH_EN			(1 << 16)
+#define INGENIC_DMA_TYPE_PROG			(1 << 17)
+
+#define INGENIC_DMA_REQ_AUTO			0xff
+#define INGENIC_DMA_CHAN_CNT			32
+
+#define INGENIC_DMA_CH(ch)	\
+	((((ch) << INGENIC_DMA_TYPE_CH_SFT) & \
+	  INGENIC_DMA_TYPE_CH_MSK) | \
+	 INGENIC_DMA_TYPE_CH_EN)
+
+/* 8-word hardware dma descriptor */
+struct ingenic_dma_hdesc {
+	unsigned long dcm;
+	dma_addr_t dsa;
+	dma_addr_t dta;
+	unsigned long dtc;
+	unsigned long sd;
+	unsigned long drt;
+	unsigned long reserved[2];
+};
+
+/**
+ * struct ingenic_dma_sdesc - Dma software descriptor
+ * @ingenic_dma_sdesc_node: Hardware dma descriptor addr list
+ * @p_hdesc: Dma descriptor physics addr
+ * @v_hdesc: Dma descriptor virtual addr
+ * @desc: Dma async txdescriptor
+ * @in_chan: The channel where the DMA descriptor is located
+ * @attribute: Dma descriptor attribute
+ */
+struct ingenic_dma_sdesc {
+	struct list_head ingenic_dma_sdesc_node;
+	dma_addr_t p_hdesc;
+	struct ingenic_dma_hdesc *v_hdesc;
+
+	struct dma_async_tx_descriptor desc;
+	struct ingenic_dma_chan *in_chan;
+
+#define DESC_HEAD 1
+#define DESC_MIDDLE 2
+#define DESC_TAIL 4
+	unsigned int attribute;
+};
+
+/**
+ * struct ingenic_dma_chan - Dma channel
+ * @id: Channel id
+ * @slave_id: Request type of the channel
+ * @iomem: Dma channel peripheral address
+ * @engine: Dma engine
+ * @chan: Dma chan
+ * @hdesc_pool: HW descriptors pool
+ * @task: tasklet struct
+ * @slave_addr: Slave_addr
+ * @maxburst: Hardware maxburst
+ * @transfer_width: Transfer width
+ * @dcm: The DCM of HW descriptor initial value
+ * @working_sdesc: Current working dma descriptor
+ * @hdesc_lock: Lock
+ * @completion: Channel terminated completion
+ * @ingenic_dma_sdesc_list_submitted: List of all need submitted dma software descriptor
+ * @ingenic_dma_sdesc_list_issued: List of all issued dma software descriptor
+ */
+struct ingenic_dma_chan {
+	int id;
+	unsigned int slave_id;
+	void __iomem *iomem;
+	struct ingenic_dma_engine *engine;
+	struct dma_chan chan;
+	struct dma_pool *hdesc_pool;
+	struct tasklet_struct task;
+
+	dma_addr_t slave_addr;
+	unsigned int maxburst;
+	unsigned int transfer_width;
+	unsigned int dcm;
+	struct ingenic_dma_sdesc *working_sdesc;
+
+	spinlock_t hdesc_lock;
+	struct completion completion;
+	struct list_head ingenic_dma_sdesc_list_submitted;
+	struct list_head ingenic_dma_sdesc_list_issued;
+};
+
+/**
+ * struct ingenic_dma_data - Dma parameter
+ * @nb_channels: Number of DMA channels
+ * @hwattr: DMA channels attribute
+ */
+struct ingenic_dma_data {
+	unsigned int nb_channels;
+	unsigned int hwattr;
+};
+
+/**
+ * struct ingenic_dma_engine - Dma engine
+ * @dev: Device
+ * @iomem: Dma engine peripheral address
+ * @gate_clk: Clock
+ * @dma_device: Dma device
+ * @chan_reserved: Dma reserved channel
+ * @chan_programed: Dma programed channel
+ * @intc_ch: intc channel
+ * @special_ch: special channel
+ * @irq_pdma: pdma interrupt
+ * @irq_pdmad: pdma descriptor interrupt
+ * @dma_data: Dma data
+ * @ingenic_dma_chan: Dma channel pointer array
+ */
+struct ingenic_dma_engine {
+	struct device *dev;
+	void __iomem *iomem;
+	struct clk *gate_clk;
+	struct dma_device dma_device;
+
+	uint32_t chan_reserved;
+	uint32_t chan_programed;
+	uint32_t intc_ch;
+	bool special_ch;
+
+	int irq_pdma;
+	int irq_pdmad;
+
+	struct ingenic_dma_data *dma_data;
+	struct ingenic_dma_chan *chan[INGENIC_DMA_CHAN_CNT];
+};
+
+/* dma hardware request */
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
+static dma_cookie_t ingenic_dma_tx_submit(struct dma_async_tx_descriptor *tx);
+
+static struct ingenic_dma_chan *to_ingenic_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct ingenic_dma_chan, chan);
+}
+
+static struct ingenic_dma_sdesc *to_ingenic_dma_sdesc(struct dma_async_tx_descriptor *desc)
+{
+	return container_of(desc, struct ingenic_dma_sdesc, desc);
+}
+
+static unsigned int ingenic_cal_max_dma_size(unsigned long val,
+					     unsigned int *shift)
+{
+	unsigned int ret;
+	int ord = ffs(val) - 1;
+
+	switch (ord) {
+	case 0:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_1_BYTE;
+		break;
+	case 1:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_2_BYTE;
+		break;
+	case 2:
+	case 3:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_4_BYTE;
+		ord = 2;
+		break;
+	case 4:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_16_BYTE;
+		break;
+	case 5:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_32_BYTE;
+		break;
+	case 6:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_64_BYTE;
+		break;
+	default:
+		ret = DMA_DCM_TSZ_TRANSFER_UINT_128_BYTE;
+		ord = 7;
+		break;
+	}
+
+	if (shift)
+		*shift = ord;
+
+	return ret;
+}
+
+static struct ingenic_dma_sdesc *
+ingenic_dma_alloc_single_sdesc(struct ingenic_dma_chan *dmac)
+{
+	struct ingenic_dma_sdesc *sdesc;
+
+	sdesc = kzalloc(sizeof(struct ingenic_dma_sdesc),
+			GFP_NOWAIT);
+	if (!sdesc)
+		return NULL;
+
+	INIT_LIST_HEAD(&sdesc->ingenic_dma_sdesc_node);
+
+	sdesc->v_hdesc = dma_pool_alloc(dmac->hdesc_pool, GFP_NOWAIT,
+					&sdesc->p_hdesc);
+	if (!sdesc->v_hdesc) {
+		dev_err(dmac->engine->dev,
+			"Couldn't allocate the hw_desc from dma_pool %p\n",
+			dmac->hdesc_pool);
+		kfree(sdesc);
+		return NULL;
+	}
+
+	return sdesc;
+}
+
+static void
+ingenic_dma_free_single_sdesc(struct ingenic_dma_chan *dmac,
+			      struct ingenic_dma_sdesc *sdesc)
+{
+	if (sdesc->v_hdesc)
+		dma_pool_free(dmac->hdesc_pool, sdesc->v_hdesc,
+			      sdesc->p_hdesc);
+
+	kfree(sdesc);
+}
+
+static unsigned int
+ingenic_fill_single_slave_hdesc(struct ingenic_dma_chan *dmac,
+				dma_addr_t addr,
+				unsigned int length,
+				enum dma_transfer_direction direction,
+				struct ingenic_dma_hdesc *desc)
+{
+	unsigned int rdil;
+
+	desc->dcm = dmac->dcm;
+	desc->drt = dmac->slave_id;
+	desc->sd = 0;
+
+	if (direction == DMA_DEV_TO_MEM) {
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
+static struct dma_async_tx_descriptor *
+ingenic_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			  unsigned int sg_len, enum dma_transfer_direction direction,
+			  unsigned long flags, void *context)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *first_sdma_desc = NULL,
+				 *last_sdma_desc = NULL,
+				 *sdesc = NULL;
+	unsigned long flg;
+	int i;
+
+	if (unlikely(!sg_len))
+		return NULL;
+
+	if (unlikely(!is_slave_direction(direction))) {
+		dev_err(dmac->engine->dev,
+			"Direction %d unsupported\n", direction);
+		return NULL;
+	}
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	for (i = 0; i < sg_len; i++) {
+		sdesc = ingenic_dma_alloc_single_sdesc(dmac);
+		if (!sdesc) {
+			dev_warn(dmac->engine->dev,
+				 "Alloc sdesc fail, Stop subsequent transfers\n");
+			if (last_sdma_desc) {
+				last_sdma_desc->v_hdesc->dcm &= ~DCM_LINK;
+				last_sdma_desc->v_hdesc->dcm |= DCM_TIE;
+				last_sdma_desc->attribute |= DESC_TAIL;
+				goto ret;
+			} else {
+				spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+				return NULL;
+			}
+		}
+
+		ingenic_fill_single_slave_hdesc(dmac, sg_dma_address(&sgl[i]),
+						sg_dma_len(&sgl[i]), direction, sdesc->v_hdesc);
+
+		if (i == 0) {
+			first_sdma_desc = sdesc;
+			sdesc->attribute |= DESC_HEAD;
+		} else {
+			last_sdma_desc->v_hdesc->dcm |= DCM_LINK;
+			last_sdma_desc->v_hdesc->dtc |= PHY_TO_DESC_DOA(sdesc->p_hdesc);
+			sdesc->attribute |= DESC_MIDDLE;
+		}
+
+		if (i == (sg_len - 1)) {
+			if (last_sdma_desc) {
+				last_sdma_desc->v_hdesc->dcm |= DCM_LINK;
+				last_sdma_desc->v_hdesc->dtc |= PHY_TO_DESC_DOA(sdesc->p_hdesc);
+			}
+			sdesc->v_hdesc->dcm |= DCM_TIE;
+			sdesc->attribute |= DESC_TAIL;
+		}
+
+		last_sdma_desc = sdesc;
+		list_add_tail(&sdesc->ingenic_dma_sdesc_node,
+			      &dmac->ingenic_dma_sdesc_list_submitted);
+	}
+
+ret:
+	dma_async_tx_descriptor_init(&first_sdma_desc->desc, &dmac->chan);
+	first_sdma_desc->desc.flags = flags;
+	first_sdma_desc->in_chan = dmac;
+	first_sdma_desc->desc.tx_submit = ingenic_dma_tx_submit;
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+
+	return &first_sdma_desc->desc;
+}
+
+static struct dma_async_tx_descriptor *
+ingenic_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			    size_t buf_len, size_t period_len,
+			    enum dma_transfer_direction direction,
+			    unsigned long flags)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *first_sdma_desc = NULL,
+				 *last_sdma_desc = NULL,
+				 *sdesc = NULL;
+	unsigned int periods = buf_len / period_len;
+	unsigned long flg;
+	int i;
+
+	if (unlikely(!buf_len || !period_len)) {
+		dev_err(dmac->engine->dev,
+			"Invalid buffer/period len\n");
+		return NULL;
+	}
+
+	if (unlikely(!is_slave_direction(direction))) {
+		dev_err(dmac->engine->dev,
+			"Direction %d unsupported\n", direction);
+		return NULL;
+	}
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	for (i = 0; i < periods; i++) {
+		sdesc = ingenic_dma_alloc_single_sdesc(dmac);
+		if (!sdesc) {
+			dev_warn(dmac->engine->dev,
+				 "Alloc sdesc fail, Stop subsequent transfers\n");
+			if (last_sdma_desc) {
+				last_sdma_desc->v_hdesc->dcm &= ~DCM_LINK;
+				last_sdma_desc->v_hdesc->dcm |= DCM_TIE;
+				last_sdma_desc->attribute |= DESC_TAIL;
+				goto ret;
+			} else {
+				spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+				return NULL;
+			}
+		}
+
+		ingenic_fill_single_slave_hdesc(dmac, buf_addr + (i * period_len),
+						period_len, direction, sdesc->v_hdesc);
+
+		if (i == 0) {
+			first_sdma_desc = sdesc;
+			sdesc->attribute |= DESC_HEAD;
+		} else {
+			last_sdma_desc->v_hdesc->dcm |= DCM_LINK;
+			last_sdma_desc->v_hdesc->dtc |= PHY_TO_DESC_DOA(sdesc->p_hdesc);
+			sdesc->attribute |= DESC_MIDDLE;
+		}
+		if (i == (periods - 1)) {
+			if (last_sdma_desc) {
+				last_sdma_desc->v_hdesc->dcm |= DCM_LINK;
+				last_sdma_desc->v_hdesc->dtc |= PHY_TO_DESC_DOA(sdesc->p_hdesc);
+			}
+			sdesc->v_hdesc->dcm |= DCM_LINK;
+			sdesc->attribute |= DESC_TAIL;
+			sdesc->v_hdesc->dtc |= PHY_TO_DESC_DOA(first_sdma_desc->p_hdesc);
+		}
+
+		last_sdma_desc = sdesc;
+		list_add_tail(&sdesc->ingenic_dma_sdesc_node,
+			      &dmac->ingenic_dma_sdesc_list_submitted);
+	}
+
+ret:
+	dma_async_tx_descriptor_init(&first_sdma_desc->desc, &dmac->chan);
+	first_sdma_desc->desc.flags = flags;
+	first_sdma_desc->in_chan = dmac;
+	first_sdma_desc->desc.tx_submit = ingenic_dma_tx_submit;
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+
+	return &first_sdma_desc->desc;
+}
+
+static void ingenic_fill_single_hdesc(dma_addr_t saddr, dma_addr_t daddr,
+				      unsigned int length,
+				      struct ingenic_dma_hdesc *desc)
+{
+	unsigned int tsz, transfer_shift, len = length;
+
+	if (length < DTC_TC_MSK) {
+		desc->dcm = DCM_DAI | DCM_SAI |
+			    (DCM_TSZ_AUTO << DCM_TSZ_SFT) |
+			    (DCM_RDIL_MAX << DCM_RDIL_SFT);
+		desc->dtc = len;
+	} else {
+		len = ALIGN_DOWN(len, sizeof(uint32_t));
+		tsz = ingenic_cal_max_dma_size(len, &transfer_shift);
+		desc->dcm = DCM_DAI | DCM_SAI | (tsz << DCM_TSZ_SFT);
+		desc->dtc = len >> transfer_shift;
+	}
+
+	desc->dsa = saddr;
+	desc->dta = daddr;
+	desc->sd = 0;
+	desc->drt = INGENIC_DMA_REQ_AUTO_TX;
+}
+
+static struct dma_async_tx_descriptor *
+ingenic_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dma_dest,
+			     dma_addr_t dma_src, size_t len, unsigned long flags)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *sdesc;
+	unsigned long flg;
+
+	if (unlikely(!len))
+		return NULL;
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	sdesc = ingenic_dma_alloc_single_sdesc(dmac);
+	if (!sdesc) {
+		dev_err(dmac->engine->dev, "Can not alloc sdesc\n");
+		return NULL;
+	}
+
+	ingenic_fill_single_hdesc(dma_src, dma_dest, len, sdesc->v_hdesc);
+	sdesc->v_hdesc->dcm |= DCM_TIE;
+	sdesc->attribute |= DESC_HEAD | DESC_TAIL | DESC_MIDDLE;
+	list_add_tail(&sdesc->ingenic_dma_sdesc_node,
+		      &dmac->ingenic_dma_sdesc_list_submitted);
+
+	dma_async_tx_descriptor_init(&sdesc->desc, &dmac->chan);
+	sdesc->desc.flags = flags;
+	sdesc->in_chan = dmac;
+	sdesc->desc.tx_submit = ingenic_dma_tx_submit;
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+
+	return &sdesc->desc;
+}
+
+static enum dma_status ingenic_dma_tx_status(struct dma_chan *chan,
+					     dma_cookie_t cookie,
+					     struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static dma_cookie_t ingenic_dma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct ingenic_dma_sdesc *sdesc = to_ingenic_dma_sdesc(tx), *tmp;
+	struct ingenic_dma_chan *dmac = sdesc->in_chan;
+	dma_cookie_t cookie;
+	unsigned long flg;
+
+	if (unlikely(!tx))
+		return -EINVAL;
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	if (!list_empty(&dmac->ingenic_dma_sdesc_list_submitted)) {
+		sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_submitted,
+					 struct ingenic_dma_sdesc,
+					 ingenic_dma_sdesc_node);
+		cookie = dma_cookie_assign(&sdesc->desc);
+		if (!(sdesc->attribute & DESC_HEAD)) {
+			spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+			dev_err(dmac->engine->dev,
+				"First submitted list not DESC_HEAD\n");
+			return -EINVAL;
+		}
+	} else {
+		spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+		dev_err(dmac->engine->dev, "Submitted list empty\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * move perpare submitt dma software descriptor to issued list.
+	 */
+	while (!list_empty(&dmac->ingenic_dma_sdesc_list_submitted)) {
+		sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_submitted,
+					 struct ingenic_dma_sdesc,
+					 ingenic_dma_sdesc_node);
+		list_del(&sdesc->ingenic_dma_sdesc_node);
+		list_add_tail(&sdesc->ingenic_dma_sdesc_node,
+			      &dmac->ingenic_dma_sdesc_list_issued);
+		if (sdesc->attribute & DESC_TAIL)
+			break;
+	}
+
+	/*
+	 * If the DMA hardware does not support the DMA descriptor linking mode,
+	 * we must rely on software to simulate the DMA descriptor linking mode.
+	 * This requires that a DMA interrupt be triggered after each DMA descriptor
+	 * completes its transmission. The software then updates the DMA descriptor
+	 * in the DMA interrupt service function.
+	 */
+	if (!HWATTR_DESC_INTER_SUP(dmac->engine->dma_data->hwattr)) {
+		if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+			list_for_each_entry_safe(sdesc, tmp,
+						 &dmac->ingenic_dma_sdesc_list_issued,
+						 ingenic_dma_sdesc_node) {
+				sdesc->v_hdesc->dcm &= ~DCM_LINK;
+				sdesc->v_hdesc->dcm |= DCM_TIE;
+			}
+			dmac->working_sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+							       struct ingenic_dma_sdesc,
+							       ingenic_dma_sdesc_node);
+		} else {
+			spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+			dev_err(dmac->engine->dev, "Issued list empty\n");
+			return -EINVAL;
+		}
+	}
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+
+	return cookie;
+}
+
+static void ingenic_dma_issue_pending(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *sdesc;
+	unsigned long flg;
+	unsigned int dcm;
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+		sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+					 struct ingenic_dma_sdesc,
+					 ingenic_dma_sdesc_node);
+
+		if (HWATTR_DESC_INTER_SUP(dmac->engine->dma_data->hwattr)) {
+			dcm = readl(dmac->iomem + CH_DCM);
+			dcm |= DCM_LINK;
+			writel(dcm, dmac->iomem + CH_DCM);
+		}
+
+		dcm = readl(dmac->iomem + CH_DCM);
+		dcm &= ~DCM_TIE;
+		writel(dcm, dmac->iomem + CH_DCM);
+
+		writel(sdesc->p_hdesc, dmac->iomem + CH_DDA);
+		writel(BIT(dmac->id), dmac->engine->iomem + DDRS);
+		writel(DCS_DES8 | DCS_CTE, dmac->iomem + CH_DCS);
+	} else
+		dev_err(dmac->engine->dev,
+			"Issued list empty, can not submmit\n");
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+}
+
+static int ingenic_dma_terminate_all(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	struct ingenic_dma_sdesc *sdesc;
+	unsigned long flg;
+	unsigned int dcm;
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	reinit_completion(&dmac->completion);
+
+	/*
+	 * If ingenic_dma_sdesc_list_issued list not empty, it means
+	 * that DMA has data being transmitted.
+	 */
+	if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+		list_for_each_entry(sdesc,
+				    &dmac->ingenic_dma_sdesc_list_issued,
+				    ingenic_dma_sdesc_node) {
+			sdesc->v_hdesc->dcm &= ~DCM_LINK;
+			sdesc->v_hdesc->dcm |= DCM_TIE;
+		}
+
+		if (HWATTR_DESC_INTER_SUP(dmac->engine->dma_data->hwattr)) {
+			/*
+			 * The version of controller support descriptor interrupt
+			 * can clear LINK on runtime
+			 */
+			dcm = readl(dmac->iomem + CH_DCM);
+			if (dcm & DCM_LINK) {
+				dcm &= ~DCM_LINK;
+				writel(dcm, dmac->iomem + CH_DCM);
+			}
+		}
+
+		if (readl(dmac->iomem + CH_DCS) & DCS_CTE) {
+			if (!(readl(dmac->iomem + CH_DCS) & DCS_TT))
+				wait_for_completion(&dmac->completion);
+		}
+	}
+
+	writel(0, dmac->iomem + CH_DCS);
+
+	/*
+	 * Clear and free all issued dma descriptor.
+	 */
+	while (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+		sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+					 struct ingenic_dma_sdesc,
+					 ingenic_dma_sdesc_node);
+		list_del(&sdesc->ingenic_dma_sdesc_node);
+		ingenic_dma_free_single_sdesc(dmac, sdesc);
+	}
+
+	/*
+	 * Clear and free all submitted dma descriptor.
+	 */
+	while (!list_empty(&dmac->ingenic_dma_sdesc_list_submitted)) {
+		sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_submitted,
+					 struct ingenic_dma_sdesc,
+					 ingenic_dma_sdesc_node);
+		list_del(&sdesc->ingenic_dma_sdesc_node);
+		ingenic_dma_free_single_sdesc(dmac, sdesc);
+	}
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+
+	return 0;
+}
+
+static void ingenic_dma_complete(unsigned long arg)
+{
+	struct ingenic_dma_chan *dmac = (struct ingenic_dma_chan *)arg;
+	struct ingenic_dma_sdesc *sdesc, *fsdesc;
+	struct dmaengine_desc_callback cb;
+	unsigned long flg;
+
+	spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+	if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+		fsdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+					  struct ingenic_dma_sdesc,
+					  ingenic_dma_sdesc_node);
+
+		dmaengine_desc_get_callback(&fsdesc->desc, &cb);
+		dma_cookie_complete(&fsdesc->desc);
+
+		while (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+			sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+						 struct ingenic_dma_sdesc,
+						 ingenic_dma_sdesc_node);
+			list_del(&sdesc->ingenic_dma_sdesc_node);
+			ingenic_dma_free_single_sdesc(dmac, sdesc);
+		}
+
+		if (dmaengine_desc_callback_valid(&cb))
+			dmaengine_desc_callback_invoke(&cb, NULL);
+
+		complete(&dmac->completion);
+	} else
+		dev_err(dmac->engine->dev, "Issued list empty\n");
+
+	spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+}
+
+static void pdma_handle_chan_irq(struct ingenic_dma_engine *ingenic_dma,
+				 int ch_id)
+{
+	struct ingenic_dma_chan *dmac = ingenic_dma->chan[ch_id];
+	struct ingenic_dma_sdesc *sdesc;
+	unsigned int dcs, dcm;
+	unsigned long flg;
+
+	dcs = readl(dmac->iomem + CH_DCS);
+	writel(0, dmac->iomem + CH_DCS);
+
+	if (dcs & DCS_AR)
+		dev_warn(dmac->engine->dev,
+			 "Address error (DCS=0x%x)\n", dcs);
+
+	if (dcs & DCS_HLT)
+		dev_warn(dmac->engine->dev,
+			 "Channel halt (DCS=0x%x)\n", dcs);
+
+	if (dcs & DCS_TT) {
+		spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+		/*
+		 * If the DMA hardware does not support the DMA descriptor chaining mode,
+		 * we need to update the DMA descriptor in the interrupt service function.
+		 */
+		if ((!HWATTR_DESC_INTER_SUP(dmac->engine->dma_data->hwattr))
+		    && dmac->working_sdesc) {
+			if (!(dmac->working_sdesc->attribute & DESC_TAIL)) {
+				dmac->working_sdesc =
+					list_entry(dmac->working_sdesc->ingenic_dma_sdesc_node.next,
+						   struct ingenic_dma_sdesc,
+						   ingenic_dma_sdesc_node);
+
+				dcm = readl(dmac->iomem + CH_DCM);
+				dcm |= DCM_TIE;
+				writel(dcm, dmac->iomem + CH_DCM);
+
+				writel(dmac->working_sdesc->p_hdesc, dmac->iomem + CH_DDA);
+				writel(BIT(dmac->id), dmac->engine->iomem + DDRS);
+
+				writel(DCS_DES8 | DCS_CTE, dmac->iomem + CH_DCS);
+			} else
+				goto COMPLETE;
+		} else {
+COMPLETE:
+			if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+				sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+							 struct ingenic_dma_sdesc,
+							 ingenic_dma_sdesc_node);
+				tasklet_schedule(&dmac->task);
+			} else
+				dev_err(dmac->engine->dev,
+					 "No element issued but DSC_TT\n");
+		}
+
+		spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+	}
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
+	for (i = 0; i < ingenic_dma->dma_data->nb_channels ; i++) {
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
+
+static irqreturn_t pdmad_int_handler(int irq, void *dev)
+{
+	struct ingenic_dma_engine *ingenic_dma = (struct ingenic_dma_engine *)dev;
+	struct ingenic_dma_sdesc *sdesc;
+	struct ingenic_dma_chan *dmac;
+	unsigned long pending, flg;
+	int i;
+
+	pending = readl(ingenic_dma->iomem + DIP);
+	writel(readl(ingenic_dma->iomem + DIP) & (~pending), ingenic_dma->iomem + DIC);
+
+	for (i = 0; i < ingenic_dma->dma_data->nb_channels; i++) {
+		dmac = ingenic_dma->chan[i];
+
+		if (!(pending & (1 << i)))
+			continue;
+
+		spin_lock_irqsave(&dmac->hdesc_lock, flg);
+
+		if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+			sdesc = list_first_entry(&dmac->ingenic_dma_sdesc_list_issued,
+						 struct ingenic_dma_sdesc,
+						 ingenic_dma_sdesc_node);
+			tasklet_schedule(&dmac->task);
+		} else
+			dev_err(dmac->engine->dev,
+				 "Issued list empty but dma descriptor handler happen\n");
+
+		spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ingenic_dma_config(struct dma_chan *chan,
+			      struct dma_slave_config *config)
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
+		if (!config->src_maxburst)
+			config->src_maxburst = 1;
+		transfer_width = config->src_addr_width;
+		dmac->slave_addr = config->src_addr;
+		dmac->maxburst = config->src_maxburst;
+		break;
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
+		dmac->dcm = DCM_PORT_8;
+		dmac->transfer_width = 1;
+		break;
+	}
+
+	return 0;
+}
+
+static int ingenic_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+	if (dmac->hdesc_pool)
+		return 0;
+
+	dmac->hdesc_pool = dma_pool_create(dev_name(&chan->dev->device),
+					   chan->device->dev,
+					   sizeof(struct ingenic_dma_hdesc),
+					   __alignof__(struct ingenic_dma_hdesc), PAGE_SIZE);
+	if (!dmac->hdesc_pool) {
+		dev_err(dmac->engine->dev,
+			"Failed to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ingenic_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+
+	dma_pool_destroy(dmac->hdesc_pool);
+	dmac->hdesc_pool = NULL;
+}
+
+static bool ingenic_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
+	unsigned int private = *(unsigned int *)param;
+	unsigned long type = (unsigned long)chan->private;
+	int channel = -1;
+
+	if (private & INGENIC_DMA_TYPE_CH_EN) {
+		channel = (private & INGENIC_DMA_TYPE_CH_MSK) >> INGENIC_DMA_TYPE_CH_SFT;
+		if (dmac->id == channel) {
+			dev_info(dmac->engine->dev,
+				 "Assignment channel is %d\n", channel);
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
+	dmac->id = id;
+	dmac->iomem = dma->iomem + dmac->id * DMACH_OFF;
+	dmac->engine = dma;
+
+	spin_lock_init(&dmac->hdesc_lock);
+	init_completion(&dmac->completion);
+
+	dmac->slave_id = pdma_maps[id] & INGENIC_DMA_TYPE_REQ_MSK;
+	dma->chan[id] = dmac;
+	INIT_LIST_HEAD(&dmac->ingenic_dma_sdesc_list_submitted);
+	INIT_LIST_HEAD(&dmac->ingenic_dma_sdesc_list_issued);
+
+	dma_cookie_init(&dmac->chan);
+	dmac->chan.device = &dma->dma_device;
+	dmac->working_sdesc = NULL;
+	list_add_tail(&dmac->chan.device_node, &dma->dma_device.channels);
+	tasklet_init(&dmac->task, ingenic_dma_complete, (unsigned long)dmac);
+
+	return 0;
+}
+
+static int ingenic_dma_probe(struct platform_device *pdev)
+{
+	struct ingenic_dma_engine *ingenic_dma = NULL;
+	unsigned int reg_dmac = DMAC_DMAE;
+	struct device *dev = &pdev->dev;
+	struct resource *iores;
+	int i, ret = 0;
+
+	if (!dev->of_node) {
+		dev_err(dev, "This driver must be probed from devicetree\n");
+		return -EINVAL;
+	}
+
+	ingenic_dma = devm_kzalloc(&pdev->dev, sizeof(struct ingenic_dma_engine),
+				   GFP_KERNEL);
+	if (!ingenic_dma)
+		return -ENOMEM;
+
+	ingenic_dma->dma_data = (struct ingenic_dma_data *)device_get_match_data(dev);
+	if (!ingenic_dma->dma_data)
+		return -EINVAL;
+
+	/*
+	 * Obtaining parameters from the device tree.
+	 */
+	ingenic_dma->dev = dev;
+	if (!of_property_read_u32(pdev->dev.of_node, "programed-chs",
+				  &ingenic_dma->chan_programed))
+		ingenic_dma->chan_reserved |= ingenic_dma->chan_programed;
+
+	if (HWATTR_SPECIAL_CH01_SUP(ingenic_dma->dma_data->hwattr) &&
+	    of_property_read_bool(pdev->dev.of_node, "special-chs")) {
+		ingenic_dma->chan_reserved  |= DMA_SPECAIL_CHS;
+		ingenic_dma->chan_programed |= DMA_SPECAIL_CHS;
+		ingenic_dma->special_ch = true;
+	}
+
+	ingenic_dma->intc_ch = -1;
+	if (HWATTR_INTC_IRQ_SUP(ingenic_dma->dma_data->hwattr) &&
+	    !of_property_read_u32(pdev->dev.of_node, "intc-ch",
+				  &ingenic_dma->intc_ch)) {
+
+		if (BIT(ingenic_dma->intc_ch) & ingenic_dma->chan_reserved)
+			dev_warn(ingenic_dma->dev,
+				 "intc irq channel %d is already reserved\n",
+				 ingenic_dma->intc_ch);
+
+		ingenic_dma->chan_reserved |= BIT(ingenic_dma->intc_ch);
+	}
+
+	/*
+	 * obtaining the base address of the DMA peripheral.
+	 */
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (iores) {
+		ingenic_dma->iomem = devm_ioremap_resource(&pdev->dev, iores);
+		if (IS_ERR(ingenic_dma->iomem))
+			return PTR_ERR(ingenic_dma->iomem);
+	} else {
+		dev_err(dev, "Failed to get I/O memory\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get PDMA interrupt.
+	 */
+	ingenic_dma->irq_pdma = platform_get_irq_byname(pdev, "pdma");
+	if (ingenic_dma->irq_pdma < 0) {
+		dev_err(dev, "Unable to get pdma irq\n");
+		return ingenic_dma->irq_pdma;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ingenic_dma->irq_pdma,
+			       pdma_int_handler, 0, "pdma", ingenic_dma);
+	if (ret) {
+		dev_err(dev, "Failed to request pdma irq\n");
+		return ret;
+	}
+
+	/*
+	 * Get PDMA descriptor interrupt.
+	 */
+	if (HWATTR_DESC_INTER_SUP(ingenic_dma->dma_data->hwattr)) {
+		ingenic_dma->irq_pdmad = platform_get_irq_byname(pdev, "pdmad");
+		if (ingenic_dma->irq_pdmad < 0) {
+			dev_err(&pdev->dev, "Unable to get pdmad irq\n");
+			return ingenic_dma->irq_pdmad;
+		}
+		ret = devm_request_irq(&pdev->dev, ingenic_dma->irq_pdmad,
+				       pdmad_int_handler, 0, "pdmad", ingenic_dma);
+		if (ret) {
+			dev_err(dev, "Failed to request pdmad irq\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * Initialize dma channel.
+	 */
+	INIT_LIST_HEAD(&ingenic_dma->dma_device.channels);
+	for (i = 0; i < ingenic_dma->dma_data->nb_channels; i++) {
+		/*reserved one channel for intc interrupt*/
+		if (ingenic_dma->intc_ch == i)
+			continue;
+		ingenic_dma_chan_init(ingenic_dma, i);
+	}
+
+	dma_cap_set(DMA_MEMCPY, ingenic_dma->dma_device.cap_mask);
+	dma_cap_set(DMA_SLAVE, ingenic_dma->dma_device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, ingenic_dma->dma_device.cap_mask);
+
+	ingenic_dma->dma_device.dev = &pdev->dev;
+	ingenic_dma->dma_device.device_alloc_chan_resources = ingenic_dma_alloc_chan_resources;
+	ingenic_dma->dma_device.device_free_chan_resources = ingenic_dma_free_chan_resources;
+	ingenic_dma->dma_device.device_tx_status = ingenic_dma_tx_status;
+	ingenic_dma->dma_device.device_prep_slave_sg = ingenic_dma_prep_slave_sg;
+	ingenic_dma->dma_device.device_prep_dma_cyclic = ingenic_dma_prep_dma_cyclic;
+	ingenic_dma->dma_device.device_prep_dma_memcpy = ingenic_dma_prep_dma_memcpy;
+	ingenic_dma->dma_device.device_config = ingenic_dma_config;
+	ingenic_dma->dma_device.device_terminate_all = ingenic_dma_terminate_all;
+	ingenic_dma->dma_device.device_issue_pending = ingenic_dma_issue_pending;
+	ingenic_dma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
+	ingenic_dma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ingenic_dma->dma_device.dst_addr_widths = ingenic_dma->dma_device.src_addr_widths;
+	ingenic_dma->dma_device.directions = BIT(DMA_DEV_TO_MEM) |
+					     BIT(DMA_MEM_TO_DEV) |
+					     BIT(DMA_MEM_TO_MEM);
+	ingenic_dma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	dma_set_max_seg_size(ingenic_dma->dma_device.dev, DTC_TC_MSK);
+
+	ingenic_dma->gate_clk = devm_clk_get(&pdev->dev, "gate_pdma");
+	if (IS_ERR(ingenic_dma->gate_clk))
+		return PTR_ERR(ingenic_dma->gate_clk);
+
+	ret = dma_async_device_register(&ingenic_dma->dma_device);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to register dma\n");
+		clk_disable(ingenic_dma->gate_clk);
+		return ret;
+	}
+
+	of_ingenic_dma_info.dma_cap = ingenic_dma->dma_device.cap_mask;
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 of_dma_simple_xlate,
+					 &of_ingenic_dma_info);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to register dma to device tree\n");
+		dma_async_device_unregister(&ingenic_dma->dma_device);
+		clk_disable(ingenic_dma->gate_clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ingenic_dma);
+
+	clk_prepare_enable(ingenic_dma->gate_clk);
+
+	if (ingenic_dma->chan_programed)
+		writel(ingenic_dma->chan_programed, ingenic_dma->iomem + DMACP);
+	if (ingenic_dma->intc_ch >= 0)
+		reg_dmac |= DMAC_INTCE |
+			    ((ingenic_dma->intc_ch << DMAC_INTCC_SFT) & DMAC_INTCC_MSK);
+	if (ingenic_dma->special_ch)
+		reg_dmac |= DMAC_CH01;
+	writel(reg_dmac, ingenic_dma->iomem + DMAC);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_dma_suspend(struct device *dev)
+{
+	struct ingenic_dma_engine *ingenic_dma = dev_get_drvdata(dev);
+	struct ingenic_dma_chan *dmac;
+	unsigned long flg;
+	int i;
+
+	for (i = 0; i < ingenic_dma->dma_data->nb_channels; i++) {
+		dmac = ingenic_dma->chan[i];
+		spin_lock_irqsave(&dmac->hdesc_lock, flg);
+		if (!list_empty(&dmac->ingenic_dma_sdesc_list_submitted)) {
+			spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+			return -EBUSY;
+		}
+		if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
+			spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+			return -EBUSY;
+		}
+		spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
+	}
+	clk_disable_unprepare(ingenic_dma->gate_clk);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_dma_resume(struct device *dev)
+{
+	struct ingenic_dma_engine *ingenic_dma = dev_get_drvdata(dev);
+
+	clk_prepare_enable(ingenic_dma->gate_clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ingenic_dma_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ingenic_dma_suspend, ingenic_dma_resume)
+};
+
+static const struct ingenic_dma_data t33_soc_data = {
+	.nb_channels = 32,
+};
+
+static const struct of_device_id ingenic_dma_dt_match[] = {
+	{ .compatible = "ingenic,t33-pdma",   .data = &t33_soc_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ingenic_dma_dt_match);
+
+static struct platform_driver ingenic_dma_driver = {
+	.probe			= ingenic_dma_probe,
+	.driver = {
+		.name		= "ingenic-dma",
+		.of_match_table = ingenic_dma_dt_match,
+		.pm		= &ingenic_dma_dev_pm_ops,
+	},
+};
+
+static int __init ingenic_dma_init(void)
+{
+	return platform_driver_register(&ingenic_dma_driver);
+}
+subsys_initcall(ingenic_dma_init);
+
+static void __exit ingenic_dma_exit(void)
+{
+	platform_driver_unregister(&ingenic_dma_driver);
+}
+module_exit(ingenic_dma_exit);
+
+MODULE_AUTHOR("bin.yao <bin.yao@ingenic.com>");
+MODULE_DESCRIPTION("Ingenic dma driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


