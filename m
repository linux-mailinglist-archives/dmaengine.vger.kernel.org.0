Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88D723D756
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 09:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgHFHbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 03:31:08 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17538 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgHFHah (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 03:30:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2bb1880001>; Thu, 06 Aug 2020 00:30:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 00:30:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Aug 2020 00:30:29 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 07:30:28 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 6 Aug 2020 07:30:28 +0000
Received: from rgumasta-linux.nvidia.com (Not Verified[10.19.66.108]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2bb1900002>; Thu, 06 Aug 2020 00:30:27 -0700
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, <rgumasta@nvidia.com>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
Date:   Thu, 6 Aug 2020 13:00:04 +0530
Message-ID: <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596699016; bh=LFLtl1LFiBfB7hf/rksGIJ0N6eTPQEWVZdmZeYB8LGs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jBel8i1lSzvxBfM9BGEG3IKV1i+sIGT+gK47joRiuT2qFWXq5gsvj4RLtjiZgi3gl
         V+3XAqWIfLeB7XUf50K/wY7hpmyhc3HVeLx2ovmAr3GkaNlVoSxwPkSZGjUJ3R4NlJ
         UjdelcIpdAm91eVSsCKo3ysOAq8eUCp9AVmvEq0vSQzFWy/n7xQomMiHe3SRLUDwqm
         5GeuEWM9OBMg/iszdXECsi4SFBsnExys+OLIJvs8uLdlHSS0ghJERNt/YrpfI5AtF0
         Wl7ftlM/3hwy8Db6RUY/cH/kers+O99V917qah3iKt7nBK4zTJtgfFkzRHIiyQzSsf
         YqW5z+Ma9giTg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
supports dma transfers between memory to memory, IO peripheral to memory
and memory to IO peripheral.

Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
---
 drivers/dma/Kconfig         |   12 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/tegra-gpc-dma.c | 1472 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1485 insertions(+)
 create mode 100644 drivers/dma/tegra-gpc-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e9ed916..84b3a0a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -639,6 +639,18 @@ config TEGRA210_ADMA
 	  peripheral and vice versa. It does not support memory to
 	  memory data transfer.
 
+config TEGRA_GPC_DMA
+	tristate "NVIDIA Tegra GPC DMA support"
+	depends on ARCH_TEGRA_186_SOC || ARCH_TEGRA_194_SOC || COMPILE_TEST
+	select DMA_ENGINE
+	help
+	  Support for the NVIDIA Tegra186 and Tegra194 GPC DMA controller
+	  driver. The DMA controller has multiple DMA channels which can
+	  be configured for different peripherals like UART, SPI, etc
+	  which are on APB bus.
+	  This DMA controller transfers data from memory to peripheral FIFO
+	  or vice versa. It also supports memory to memory data transfer.
+
 config TIMB_DMA
 	tristate "Timberdale FPGA DMA support"
 	depends on MFD_TIMBERDALE || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index e60f813..43e3a6e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
 obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
+obj-$(CONFIG_TEGRA_GPC_DMA) += tegra-gpc-dma.o
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
 obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
 obj-$(CONFIG_UNIPHIER_XDMAC) += uniphier-xdmac.o
diff --git a/drivers/dma/tegra-gpc-dma.c b/drivers/dma/tegra-gpc-dma.c
new file mode 100644
index 0000000..723b352
--- /dev/null
+++ b/drivers/dma/tegra-gpc-dma.c
@@ -0,0 +1,1472 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DMA driver for Nvidia's Tegra186 and Tegra194 GPC DMA controller.
+ *
+ * Copyright (c) 2014-2020, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <dt-bindings/memory/tegra186-mc.h>
+#include "virt-dma.h"
+
+/* CSR register */
+#define TEGRA_GPCDMA_CHAN_CSR			0x00
+#define TEGRA_GPCDMA_CSR_ENB			BIT(31)
+#define TEGRA_GPCDMA_CSR_IE_EOC			BIT(30)
+#define TEGRA_GPCDMA_CSR_ONCE			BIT(27)
+#define TEGRA_GPCDMA_CSR_FC_MODE_NO_MMIO	(0 << 24)
+#define TEGRA_GPCDMA_CSR_FC_MODE_ONE_MMIO	BIT(24)
+#define TEGRA_GPCDMA_CSR_FC_MODE_TWO_MMIO	BIT(25)
+#define TEGRA_GPCDMA_CSR_FC_MODE_FOUR_MMIO	GENMASK(25, 24)
+#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_NO_FC	(0 << 21)
+#define TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC		BIT(21)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_NO_FC	BIT(22)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC		GENMASK(22, 21)
+#define TEGRA_GPCDMA_CSR_DMA_MEM2MEM		BIT(23)
+#define TEGRA_GPCDMA_CSR_DMA_FIXED_PAT		GENMASK(23, 22)
+#define TEGRA_GPCDMA_CSR_REQ_SEL_SHIFT		16
+#define TEGRA_GPCDMA_CSR_REQ_SEL_MASK		GENMASK(20, 16)
+#define TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED	BIT(18)
+#define TEGRA_GPCDMA_CSR_IRQ_MASK		BIT(15)
+#define TEGRA_GPCDMA_CSR_WEIGHT_SHIFT		10
+
+/* STATUS register */
+#define TEGRA_GPCDMA_CHAN_STATUS		0x004
+#define TEGRA_GPCDMA_STATUS_BUSY		BIT(31)
+#define TEGRA_GPCDMA_STATUS_ISE_EOC		BIT(30)
+#define TEGRA_GPCDMA_STATUS_PING_PONG		BIT(28)
+#define TEGRA_GPCDMA_STATUS_DMA_ACTIVITY	BIT(27)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_PAUSE	BIT(26)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_RX		BIT(25)
+#define TEGRA_GPCDMA_STATUS_CHANNEL_TX		BIT(24)
+#define TEGRA_GPCDMA_STATUS_IRQ_INTR_STA	BIT(23)
+#define TEGRA_GPCDMA_STATUS_IRQ_STA		BIT(21)
+#define TEGRA_GPCDMA_STATUS_IRQ_TRIG_STA	BIT(20)
+
+#define TEGRA_GPCDMA_CHAN_CSRE			0x008
+#define TEGRA_GPCDMA_CHAN_CSRE_PAUSE		BIT(31)
+
+/* Source address */
+#define TEGRA_GPCDMA_CHAN_SRC_PTR		0x00C
+
+/* Destination address */
+#define TEGRA_GPCDMA_CHAN_DST_PTR		0x010
+
+/* High address pointer */
+#define TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR	0x014
+#define TEGRA_GPCDMA_HIGH_ADDR_SCR_PTR_SHIFT	0
+#define TEGRA_GPCDMA_HIGH_ADDR_SCR_PTR_MASK	0xFF
+#define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_SHIFT	16
+#define TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_MASK	0xFF
+
+/* MC sequence register */
+#define TEGRA_GPCDMA_CHAN_MCSEQ			0x18
+#define TEGRA_GPCDMA_MCSEQ_DATA_SWAP		BIT(31)
+#define TEGRA_GPCDMA_MCSEQ_REQ_COUNT_SHIFT	25
+#define TEGRA_GPCDMA_MCSEQ_BURST_2		(0 << 23)
+#define TEGRA_GPCDMA_MCSEQ_BURST_16		GENMASK(24, 23)
+#define TEGRA_GPCDMA_MCSEQ_WRAP1_SHIFT		20
+#define TEGRA_GPCDMA_MCSEQ_WRAP0_SHIFT		17
+#define TEGRA_GPCDMA_MCSEQ_WRAP_NONE		0
+#define TEGRA_GPCDMA_MCSEQ_MC_PROT_SHIFT	14
+#define TEGRA_GPCDMA_MCSEQ_STREAM_ID1_SHIFT	7
+#define TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT	0
+#define TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK	0x7F
+
+/* MMIO sequence register */
+#define TEGRA_GPCDMA_CHAN_MMIOSEQ		0x01c
+#define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	(0 << 28)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16	BIT(28)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32	BIT(29)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_64	GENMASK(29, 28)
+#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_128	BIT(30)
+#define TEGRA_GPCDMA_MMIOSEQ_DATA_SWAP		BIT(27)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_1		(0 << 23)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_2		BIT(23)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_4		GENMASK(24, 23)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_8		GENMASK(25, 23)
+#define TEGRA_GPCDMA_MMIOSEQ_BURST_16		GENMASK(26, 23)
+#define TEGRA_GPCDMA_MMIOSEQ_MASTER_ID_SHIFT	19
+#define TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD_SHIFT	16
+#define TEGRA_GPCDMA_MMIOSEQ_MMIO_PROT_SHIFT	7
+
+/* Channel WCOUNT */
+#define TEGRA_GPCDMA_CHAN_WCOUNT		0x20
+
+/* Transfer count */
+#define TEGRA_GPCDMA_CHAN_XFER_COUNT		0x24
+
+/* DMA byte count status */
+#define TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS	0x28
+
+/* Error Status Register */
+#define TEGRA_GPCDMA_CHAN_ERR_STATUS		0x30
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT	(8)
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK	(0xF)
+#define TEGRA_GPCDMA_CHAN_ERR_TYPE(err)	(			\
+		((err) >> TEGRA_GPCDMA_CHAN_ERR_TYPE_SHIFT) &	\
+		TEGRA_GPCDMA_CHAN_ERR_TYPE_MASK)
+#define TEGRA_DMA_BM_FIFO_FULL_ERR		(0xF)
+#define TEGRA_DMA_PERIPH_FIFO_FULL_ERR		(0xE)
+#define TEGRA_DMA_PERIPH_ID_ERR			(0xD)
+#define TEGRA_DMA_STREAM_ID_ERR			(0xC)
+#define TEGRA_DMA_MC_SLAVE_ERR			(0xB)
+#define TEGRA_DMA_MMIO_SLAVE_ERR		(0xA)
+
+/* Fixed Pattern */
+#define TEGRA_GPCDMA_CHAN_FIXED_PATTERN		0x34
+
+#define TEGRA_GPCDMA_CHAN_TZ			0x38
+#define TEGRA_GPCDMA_CHAN_TZ_MMIO_PROT_1	BIT(0)
+#define TEGRA_GPCDMA_CHAN_TZ_MC_PROT_1		BIT(1)
+
+#define TEGRA_GPCDMA_CHAN_SPARE			0x3c
+#define TEGRA_GPCDMA_CHAN_SPARE_EN_LEGACY_FC	BIT(16)
+
+/*
+ * If any burst is in flight and DMA paused then this is the time to complete
+ * on-flight burst and update DMA status register.
+ */
+#define TEGRA_GPCDMA_BURST_COMPLETE_TIME	20
+#define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT	100
+
+/* Channel base address offset from GPCDMA base address */
+#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET	0x10000
+
+struct tegra_dma;
+
+/*
+ * tegra_dma_chip_data Tegra chip specific DMA data
+ * @nr_channels: Number of channels available in the controller.
+ * @channel_reg_size: Channel register size.
+ * @max_dma_count: Maximum DMA transfer count supported by DMA controller.
+ * @hw_support_pause: DMA HW engine support pause of the channel.
+ */
+struct tegra_dma_chip_data {
+	int nr_channels;
+	int channel_reg_size;
+	int max_dma_count;
+	bool hw_support_pause;
+};
+
+/* DMA channel registers */
+struct tegra_dma_channel_regs {
+	unsigned long csr;
+	unsigned long src_ptr;
+	unsigned long dst_ptr;
+	unsigned long high_addr_ptr;
+	unsigned long mc_seq;
+	unsigned long mmio_seq;
+	unsigned long wcount;
+	unsigned long fixed_pattern;
+};
+
+/*
+ * tegra_dma_sg_req: Dma request details to configure hardware. This
+ * contains the details for one transfer to configure DMA hw.
+ * The client's request for data transfer can be broken into multiple
+ * sub-transfer as per requester details and hw support.
+ * This sub transfer get added in the list of transfer and point to Tegra
+ * DMA descriptor which manages the transfer details.
+ */
+struct tegra_dma_sg_req {
+	struct tegra_dma_channel_regs ch_regs;
+	int req_len;
+	bool configured;
+	bool last_sg;
+	struct list_head node;
+	struct tegra_dma_desc *dma_desc;
+};
+
+/*
+ * tegra_dma_desc: Tegra DMA descriptors which uses virt_dma_desc to
+ * manage client request and keep track of transfer status, callbacks
+ * and request counts etc.
+ */
+struct tegra_dma_desc {
+	struct virt_dma_desc vd;
+	int bytes_requested;
+	int bytes_transferred;
+	struct tegra_dma_channel *tdc;
+};
+
+struct tegra_dma_channel;
+
+typedef void (*dma_isr_handler)(struct tegra_dma_channel *tdc,
+				bool to_terminate);
+
+/*
+ * tegra_dma_channel: Channel specific information
+ */
+struct tegra_dma_channel {
+	struct virt_dma_chan vc;
+	struct tegra_dma_desc *dma_desc;
+	struct tegra_dma_desc *pending_dma_desc;
+	char name[30];
+	bool config_init;
+	int id;
+	int irq;
+	unsigned long chan_base_offset;
+	raw_spinlock_t lock;
+	bool busy;
+	bool is_pending;
+	struct tegra_dma *tdma;
+	struct list_head pending_sg_req;
+	dma_isr_handler isr_handler;
+	int slave_id;
+	struct dma_slave_config dma_sconfig;
+	struct tegra_dma_channel_regs channel_reg;
+};
+
+/*
+ * tegra_dma: Tegra DMA specific information
+ */
+struct tegra_dma {
+	struct dma_device dma_dev;
+	struct device *dev;
+	void __iomem *base_addr;
+	const struct tegra_dma_chip_data *chip_data;
+	struct reset_control *rst;
+	struct tegra_dma_channel channels[0];
+};
+
+static inline void tdc_write(struct tegra_dma_channel *tdc,
+			     u32 reg, u32 val)
+{
+	writel_relaxed(val, tdc->tdma->base_addr + tdc->chan_base_offset + reg);
+}
+
+static inline u32 tdc_read(struct tegra_dma_channel *tdc, u32 reg)
+{
+	return readl_relaxed(tdc->tdma->base_addr + tdc->chan_base_offset + reg);
+}
+
+static inline struct tegra_dma_channel *to_tegra_dma_chan(struct dma_chan *dc)
+{
+	return container_of(dc, struct tegra_dma_channel, vc.chan);
+}
+
+static inline struct tegra_dma_desc *vd_to_tegra_dma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct tegra_dma_desc, vd);
+}
+
+static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
+{
+	return tdc->vc.chan.device->dev;
+}
+
+static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
+{
+	pr_info("DMA Channel %d name %s register dump:\n",
+		tdc->id, tdc->name);
+	pr_info("CSR %x STA %x CSRE %x SRC %x DST %x\n",
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSRE),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR)
+	);
+	pr_info("MCSEQ %x IOSEQ %x WCNT %x XFER %x BSTA %x\n",
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT),
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_DMA_BYTE_STATUS)
+	);
+	pr_info("DMA ERR_STA %x\n",
+		tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS));
+}
+
+static void tegra_dma_desc_free(struct virt_dma_desc *vd)
+{
+	struct tegra_dma_desc *dma_desc = vd_to_tegra_dma_desc(vd);
+	struct tegra_dma_channel *tdc = dma_desc->tdc;
+	unsigned long flags;
+
+	if (!dma_desc)
+		return;
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+	kfree(dma_desc);
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+}
+
+static int tegra_dma_slave_config(struct dma_chan *dc,
+				  struct dma_slave_config *sconfig)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	if (!list_empty(&tdc->pending_sg_req)) {
+		dev_err(tdc2dev(tdc), "Configuration not allowed\n");
+		return -EBUSY;
+	}
+
+	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
+	if (tdc->slave_id == -1)
+		tdc->slave_id = sconfig->slave_id;
+	tdc->config_init = true;
+	return 0;
+}
+
+static int tegra_dma_pause(struct tegra_dma_channel *tdc)
+{
+	u32 val;
+	int ret;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, TEGRA_GPCDMA_CHAN_CSRE_PAUSE);
+
+	/* Wait until busy bit is de-asserted */
+	ret = readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+			tdc->chan_base_offset + TEGRA_GPCDMA_CHAN_STATUS,
+			val,
+			!(val & TEGRA_GPCDMA_STATUS_BUSY),
+			TEGRA_GPCDMA_BURST_COMPLETE_TIME,
+			TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT);
+
+	if (ret) {
+		dev_err(tdc2dev(tdc), "DMA pause timed out\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static void tegra_dma_stop(struct tegra_dma_channel *tdc)
+{
+	u32 csr, status;
+
+	csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+
+	/* Disable interrupts */
+	csr &= ~TEGRA_GPCDMA_CSR_IE_EOC;
+
+	/* Disable DMA */
+	csr &= ~TEGRA_GPCDMA_CSR_ENB;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+
+	/* Clear interrupt status if it is there */
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
+		dev_dbg(tdc2dev(tdc), "%s():clearing interrupt\n", __func__);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS, status);
+	}
+	tdc->busy = false;
+}
+
+static void tegra_dma_start(struct tegra_dma_channel *tdc,
+			    struct tegra_dma_sg_req *sg_req)
+{
+	struct tegra_dma_channel_regs *ch_regs = &sg_req->ch_regs;
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_regs->wcount);
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, 0);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_regs->src_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_regs->dst_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR, ch_regs->high_addr_ptr);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_FIXED_PATTERN, ch_regs->fixed_pattern);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_regs->mmio_seq);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_regs->mc_seq);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSRE, 0);
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, ch_regs->csr);
+
+	/* Start DMA */
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
+		  ch_regs->csr | TEGRA_GPCDMA_CSR_ENB);
+}
+
+static void tdc_start_head_req(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma_sg_req *sg_req;
+	struct virt_dma_desc *vdesc;
+
+	if (list_empty(&tdc->pending_sg_req))
+		return;
+
+	if (tdc->is_pending)
+		return;
+
+	vdesc = vchan_next_desc(&tdc->vc);
+	if (!vdesc)
+		return;
+	list_del(&vdesc->node);
+	tdc->dma_desc = vd_to_tegra_dma_desc(vdesc);
+	tdc->is_pending = true;
+	tdc->dma_desc->tdc = tdc;
+	sg_req = list_first_entry(&tdc->pending_sg_req,
+				  typeof(*sg_req), node);
+	tegra_dma_start(tdc, sg_req);
+	sg_req->configured = true;
+	tdc->busy = true;
+}
+
+static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
+{
+	struct tegra_dma_sg_req *sgreq;
+
+	while (!list_empty(&tdc->pending_sg_req)) {
+		sgreq = list_first_entry(&tdc->pending_sg_req,
+					 typeof(*sgreq), node);
+		list_del(&sgreq->node);
+		kfree(sgreq);
+	}
+	tdc->isr_handler = NULL;
+}
+
+static void handle_once_dma_done(struct tegra_dma_channel *tdc,
+				 bool to_terminate)
+{
+	struct tegra_dma_desc *dma_desc;
+	struct tegra_dma_sg_req *sgreq;
+
+	tdc->busy = false;
+	sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq), node);
+	dma_desc = sgreq->dma_desc;
+	dma_desc->bytes_transferred += sgreq->req_len;
+
+	if (sgreq->last_sg) {
+		vchan_cookie_complete(&tdc->dma_desc->vd);
+		tdc->is_pending = false;
+		tdc->dma_desc = NULL;
+	}
+	list_del(&sgreq->node);
+	kfree(sgreq);
+
+	if (to_terminate || list_empty(&tdc->pending_sg_req))
+		return;
+
+	tdc_start_head_req(tdc);
+}
+
+static void tegra_dma_chan_decode_error(struct tegra_dma_channel *tdc,
+					unsigned int err_status)
+{
+	switch (TEGRA_GPCDMA_CHAN_ERR_TYPE(err_status)) {
+	case TEGRA_DMA_BM_FIFO_FULL_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d bm fifo full\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_PERIPH_FIFO_FULL_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d peripheral fifo full\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_PERIPH_ID_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d illegal peripheral id\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_STREAM_ID_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d illegal stream id\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_MC_SLAVE_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d mc slave error\n", tdc->id);
+		break;
+
+	case TEGRA_DMA_MMIO_SLAVE_ERR:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d mmio slave error\n", tdc->id);
+		break;
+
+	default:
+		dev_err(tdc->tdma->dev,
+			"GPCDMA CH%d security violation %x\n", tdc->id,
+			err_status);
+	}
+}
+
+static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
+{
+	struct tegra_dma_channel *tdc = dev_id;
+	unsigned int err_status;
+	unsigned long status;
+
+	raw_spin_lock(&tdc->lock);
+
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	err_status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS);
+
+	if (err_status) {
+		tegra_dma_chan_decode_error(tdc, err_status);
+		tegra_dma_dump_chan_regs(tdc);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_ERR_STATUS, 0xFFFFFFFF);
+	}
+
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_STATUS,
+			  TEGRA_GPCDMA_STATUS_ISE_EOC);
+		if (tdc->isr_handler) {
+			tdc->isr_handler(tdc, false);
+		} else {
+			dev_err(tdc->tdma->dev,
+				"GPCDMA CH%d: status %lx ISR handler absent!\n",
+				tdc->id, status);
+			tegra_dma_dump_chan_regs(tdc);
+		}
+		raw_spin_unlock(&tdc->lock);
+		return IRQ_HANDLED;
+	}
+
+	raw_spin_unlock(&tdc->lock);
+	return IRQ_NONE;
+}
+
+static void tegra_dma_issue_pending(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+	if (list_empty(&tdc->pending_sg_req)) {
+		dev_err(tdc2dev(tdc), "No DMA request\n");
+		goto end;
+	}
+
+	if (!tdc->busy)
+		if (vchan_issue_pending(&tdc->vc))
+			tdc_start_head_req(tdc);
+
+end:
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+}
+
+static void tegra_dma_reset_client(struct tegra_dma_channel *tdc)
+{
+	u32 csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+
+	csr &= ~(TEGRA_GPCDMA_CSR_REQ_SEL_MASK);
+	csr |= TEGRA_GPCDMA_CSR_REQ_SEL_UNUSED;
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR, csr);
+}
+
+static int tegra_dma_terminate_all(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_sg_req *sgreq;
+	unsigned long wcount = 0;
+	unsigned long status;
+	unsigned long flags;
+	bool was_busy;
+	int err;
+
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+	if (list_empty(&tdc->pending_sg_req)) {
+		raw_spin_unlock_irqrestore(&tdc->lock, flags);
+		return 0;
+	}
+
+	if (!tdc->busy)
+		goto skip_dma_stop;
+
+	if (tdc->tdma->chip_data->hw_support_pause) {
+		err = tegra_dma_pause(tdc);
+		if (err) {
+			raw_spin_unlock_irqrestore(&tdc->lock, flags);
+			return err;
+		}
+	} else {
+		/* Before Reading DMA status to figure out number
+		 * of bytes transferred by DMA channel:
+		 * Change the client associated with the DMA channel
+		 * to stop DMA engine from starting any more bursts for
+		 * the given client and wait for in flight bursts to complete
+		 */
+		tegra_dma_reset_client(tdc);
+
+		/* Wait for in flight data transfer to finish */
+		udelay(TEGRA_GPCDMA_BURST_COMPLETE_TIME);
+
+		/* If TX/RX path is still active wait till it becomes
+		 * inactive
+		 */
+
+		if (readl_relaxed_poll_timeout_atomic(tdc->tdma->base_addr +
+				tdc->chan_base_offset +
+				TEGRA_GPCDMA_CHAN_STATUS,
+				status,
+				!(status & (TEGRA_GPCDMA_STATUS_CHANNEL_TX |
+				TEGRA_GPCDMA_STATUS_CHANNEL_RX)),
+				5,
+				TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT)) {
+			dev_err(tdc2dev(tdc), "Timeout waiting for DMA burst completion!\n");
+			tegra_dma_dump_chan_regs(tdc);
+		}
+	}
+
+	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+	wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+	if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
+		dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
+		tdc->isr_handler(tdc, true);
+		status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
+		wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
+	}
+
+	was_busy = tdc->busy;
+	tegra_dma_stop(tdc);
+
+	if (!list_empty(&tdc->pending_sg_req) && was_busy) {
+		sgreq = list_first_entry(&tdc->pending_sg_req,
+					 typeof(*sgreq), node);
+		sgreq->dma_desc->bytes_transferred +=
+			sgreq->req_len - (wcount * 4);
+	}
+
+skip_dma_stop:
+	tegra_dma_abort_all(tdc);
+	vchan_free_chan_resources(&tdc->vc);
+	if (tdc->is_pending) {
+		tdc->pending_dma_desc = tdc->dma_desc;
+		tdc->is_pending = false;
+		tdc->dma_desc = NULL;
+	}
+
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+	return 0;
+}
+
+static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
+					   dma_cookie_t cookie,
+					   struct dma_tx_state *txstate)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_desc *dma_desc;
+	struct tegra_dma_sg_req *sg_req;
+	unsigned int residual;
+	enum dma_status ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+
+	ret = dma_cookie_status(dc, cookie, txstate);
+	if (ret == DMA_COMPLETE) {
+		raw_spin_unlock_irqrestore(&tdc->lock, flags);
+		return ret;
+	}
+
+	/*
+	 * Incase if dma client terminate the request and triggers tx_status
+	 * before the dma completion then free pending dma desc if exist
+	 */
+	if (tdc->pending_dma_desc) {
+		dma_desc = tdc->pending_dma_desc;
+		tdc->pending_dma_desc = NULL;
+		if (dma_desc->vd.tx.cookie == cookie) {
+			residual =  dma_desc->bytes_requested -
+					(dma_desc->bytes_transferred %
+						dma_desc->bytes_requested);
+			dma_set_residue(txstate, residual);
+			kfree(dma_desc);
+			raw_spin_unlock_irqrestore(&tdc->lock, flags);
+			return ret;
+		}
+	}
+
+	/* Check in pending list */
+	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
+		dma_desc = sg_req->dma_desc;
+		if (dma_desc->vd.tx.cookie == cookie) {
+			residual =  dma_desc->bytes_requested -
+					(dma_desc->bytes_transferred %
+						dma_desc->bytes_requested);
+			dma_set_residue(txstate, residual);
+			raw_spin_unlock_irqrestore(&tdc->lock, flags);
+			return ret;
+		}
+	}
+
+	dev_dbg(tdc2dev(tdc), "cookie %d does not found\n", cookie);
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+	return ret;
+}
+
+static inline int get_bus_width(struct tegra_dma_channel *tdc,
+				enum dma_slave_buswidth slave_bw)
+{
+	switch (slave_bw) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32;
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_64;
+	default:
+		dev_warn(tdc2dev(tdc),
+			 "slave bw is not supported, using 32bits\n");
+		return TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32;
+	}
+}
+
+static inline int get_burst_size(struct tegra_dma_channel *tdc,
+				 u32 burst_size,
+				 enum dma_slave_buswidth slave_bw,
+				 int len)
+{
+	int burst_mmio_width;
+	int burst_byte;
+
+	/*
+	 * burst_size from client is in terms of the bus_width.
+	 * convert that into words.
+	 */
+	burst_byte = burst_size * slave_bw;
+	burst_mmio_width = burst_byte / 4;
+
+	/* If burst size is 0 then calculate the burst size based on length */
+	if (!burst_mmio_width) {
+		if (len & 0xF)
+			return TEGRA_GPCDMA_MMIOSEQ_BURST_1;
+		else if ((len >> 3) & 0x1)
+			return TEGRA_GPCDMA_MMIOSEQ_BURST_2;
+		else if ((len >> 4) & 0x1)
+			return TEGRA_GPCDMA_MMIOSEQ_BURST_4;
+		else if ((len >> 5) & 0x1)
+			return TEGRA_GPCDMA_MMIOSEQ_BURST_8;
+		else
+			return TEGRA_GPCDMA_MMIOSEQ_BURST_16;
+	}
+	if (burst_mmio_width < 2)
+		return TEGRA_GPCDMA_MMIOSEQ_BURST_1;
+	else if (burst_mmio_width < 4)
+		return TEGRA_GPCDMA_MMIOSEQ_BURST_2;
+	else if (burst_mmio_width < 8)
+		return TEGRA_GPCDMA_MMIOSEQ_BURST_4;
+	else if (burst_mmio_width < 16)
+		return TEGRA_GPCDMA_MMIOSEQ_BURST_8;
+	else
+		return TEGRA_GPCDMA_MMIOSEQ_BURST_16;
+}
+
+static int get_transfer_param(struct tegra_dma_channel *tdc,
+			      enum dma_transfer_direction direction,
+				  unsigned long *apb_addr,
+			      unsigned long *mmio_seq,
+				  unsigned long *csr,
+			      unsigned int *burst_size,
+			      enum dma_slave_buswidth *slave_bw)
+{
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		*apb_addr = tdc->dma_sconfig.dst_addr;
+		*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.dst_addr_width);
+		*burst_size = tdc->dma_sconfig.dst_maxburst;
+		*slave_bw = tdc->dma_sconfig.dst_addr_width;
+		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2IO_FC;
+		return 0;
+
+	case DMA_DEV_TO_MEM:
+		*apb_addr = tdc->dma_sconfig.src_addr;
+		*mmio_seq = get_bus_width(tdc, tdc->dma_sconfig.src_addr_width);
+		*burst_size = tdc->dma_sconfig.src_maxburst;
+		*slave_bw = tdc->dma_sconfig.src_addr_width;
+		*csr = TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC;
+		return 0;
+	case DMA_MEM_TO_MEM:
+		*burst_size = tdc->dma_sconfig.src_addr_width;
+		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
+		return 0;
+	default:
+		dev_err(tdc2dev(tdc), "Dma direction is not supported\n");
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static struct dma_async_tx_descriptor *tegra_dma_prep_dma_memset(
+	struct dma_chan *dc, dma_addr_t dest, int value, size_t len,
+	unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_sg_req *sg_req = NULL;
+	struct tegra_dma_desc *dma_desc;
+	struct list_head req_list;
+	unsigned long csr, mc_seq;
+
+	INIT_LIST_HEAD(&req_list);
+	/* Set dma mode to fixed pattern */
+	csr = TEGRA_GPCDMA_CSR_DMA_FIXED_PAT;
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Enable the dma interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+	/* Configure default priority weight for the channel */
+	csr |= (1 << TEGRA_GPCDMA_CSR_WEIGHT_SHIFT);
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
+			TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT);
+
+	/* Set the address wrapping */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_WRAP_NONE <<
+			TEGRA_GPCDMA_MCSEQ_WRAP0_SHIFT;
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_WRAP_NONE <<
+			TEGRA_GPCDMA_MCSEQ_WRAP1_SHIFT;
+
+	/* Program outstanding MC requests */
+	mc_seq |= (1 << TEGRA_GPCDMA_MCSEQ_REQ_COUNT_SHIFT);
+	/* Set burst size */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+
+	dma_desc = kzalloc(sizeof(struct tegra_dma_desc), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_requested = 0;
+	dma_desc->bytes_transferred = 0;
+
+	if ((len & 3) || (dest & 3) ||
+	    len > tdc->tdma->chip_data->max_dma_count) {
+		dev_err(tdc2dev(tdc),
+			"Dma length/memory address is not supported\n");
+		kfree(dma_desc);
+		return NULL;
+	}
+
+	sg_req = kzalloc(sizeof(struct tegra_dma_sg_req), GFP_NOWAIT);
+	if (!sg_req) {
+		kfree(dma_desc);
+		return NULL;
+	}
+
+	dma_desc->bytes_requested += len;
+	sg_req->ch_regs.src_ptr = 0;
+	sg_req->ch_regs.dst_ptr = dest;
+	sg_req->ch_regs.high_addr_ptr = ((dest >> 32) &
+			TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_MASK) <<
+			TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_SHIFT;
+	sg_req->ch_regs.fixed_pattern = value;
+	/* Word count reg takes value as (N +1) words */
+	sg_req->ch_regs.wcount = ((len - 4) >> 2);
+	sg_req->ch_regs.csr = csr;
+	sg_req->ch_regs.mmio_seq = 0;
+	sg_req->ch_regs.mc_seq = mc_seq;
+	sg_req->configured = false;
+	sg_req->last_sg = false;
+	sg_req->dma_desc = dma_desc;
+	sg_req->req_len = len;
+	sg_req->last_sg = true;
+
+	list_add_tail(&sg_req->node, &tdc->pending_sg_req);
+
+	if (!tdc->isr_handler)
+		tdc->isr_handler = handle_once_dma_done;
+
+	tdc->pending_dma_desc = NULL;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *tegra_dma_prep_dma_memcpy(
+	struct dma_chan *dc, dma_addr_t dest, dma_addr_t src,	size_t len,
+	unsigned long flags)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct tegra_dma_sg_req *sg_req = NULL;
+	struct tegra_dma_desc *dma_desc;
+	struct list_head req_list;
+	unsigned long csr, mc_seq;
+
+	INIT_LIST_HEAD(&req_list);
+	/* Set dma mode to memory to memory transfer */
+	csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Enable the dma interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+	/* Configure default priority weight for the channel */
+	csr |= (1 << TEGRA_GPCDMA_CSR_WEIGHT_SHIFT);
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= ((TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
+				TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT) |
+			(TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
+			 TEGRA_GPCDMA_MCSEQ_STREAM_ID1_SHIFT));
+
+	/* Set the address wrapping */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_WRAP_NONE <<
+			TEGRA_GPCDMA_MCSEQ_WRAP0_SHIFT;
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_WRAP_NONE <<
+			TEGRA_GPCDMA_MCSEQ_WRAP1_SHIFT;
+
+	/* Program outstanding MC requests */
+	mc_seq |= (1 << TEGRA_GPCDMA_MCSEQ_REQ_COUNT_SHIFT);
+	/* Set burst size */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+
+	dma_desc = kzalloc(sizeof(struct tegra_dma_desc), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_requested = 0;
+	dma_desc->bytes_transferred = 0;
+
+	if ((len & 3) || (src & 3) || (dest & 3) ||
+	    len > tdc->tdma->chip_data->max_dma_count) {
+		dev_err(tdc2dev(tdc),
+			"Dma length/memory address is not supported\n");
+		kfree(dma_desc);
+		return NULL;
+	}
+
+	sg_req = kzalloc(sizeof(struct tegra_dma_sg_req), GFP_NOWAIT);
+	if (!sg_req) {
+		kfree(dma_desc);
+		return NULL;
+	}
+
+	dma_desc->bytes_requested += len;
+	sg_req->ch_regs.src_ptr = src;
+	sg_req->ch_regs.dst_ptr = dest;
+	sg_req->ch_regs.high_addr_ptr = (src >> 32) &
+		TEGRA_GPCDMA_HIGH_ADDR_SCR_PTR_MASK;
+	sg_req->ch_regs.high_addr_ptr |= ((dest >> 32) &
+		TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_MASK) <<
+		TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_SHIFT;
+	/* Word count reg takes value as (N +1) words */
+	sg_req->ch_regs.wcount = ((len - 4) >> 2);
+	sg_req->ch_regs.csr = csr;
+	sg_req->ch_regs.mmio_seq = 0;
+	sg_req->ch_regs.mc_seq = mc_seq;
+	sg_req->configured = false;
+	sg_req->last_sg = false;
+	sg_req->dma_desc = dma_desc;
+	sg_req->req_len = len;
+	sg_req->last_sg = true;
+
+	list_add_tail(&sg_req->node, &tdc->pending_sg_req);
+
+	if (!tdc->isr_handler)
+		tdc->isr_handler = handle_once_dma_done;
+
+	tdc->pending_dma_desc = NULL;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+}
+
+static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
+	struct dma_chan *dc, struct scatterlist *sgl, unsigned int sg_len,
+	enum dma_transfer_direction direction, unsigned long flags,
+	void *context)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	unsigned long csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
+	struct tegra_dma_sg_req *sg_req = NULL;
+	enum dma_slave_buswidth slave_bw;
+	struct tegra_dma_desc *dma_desc;
+	struct list_head req_list;
+	struct scatterlist *sg;
+	u32 burst_size;
+	unsigned int i;
+	int ret;
+
+	if (!tdc->config_init) {
+		dev_err(tdc2dev(tdc), "dma channel is not configured\n");
+		return NULL;
+	}
+	if (sg_len < 1) {
+		dev_err(tdc2dev(tdc), "Invalid segment length %d\n", sg_len);
+		return NULL;
+	}
+
+	ret = get_transfer_param(tdc, direction, &apb_ptr, &mmio_seq, &csr,
+				 &burst_size, &slave_bw);
+	if (ret < 0)
+		return NULL;
+
+	INIT_LIST_HEAD(&req_list);
+
+	/* Enable once or continuous mode */
+	csr |= TEGRA_GPCDMA_CSR_ONCE;
+	/* Program the slave id in requestor select */
+	csr |= tdc->slave_id << TEGRA_GPCDMA_CSR_REQ_SEL_SHIFT;
+	/* Enable IRQ mask */
+	csr |= TEGRA_GPCDMA_CSR_IRQ_MASK;
+	/* Configure default priority weight for the channel*/
+	csr |= (1 << TEGRA_GPCDMA_CSR_WEIGHT_SHIFT);
+
+	/* Enable the dma interrupt */
+	if (flags & DMA_PREP_INTERRUPT)
+		csr |= TEGRA_GPCDMA_CSR_IE_EOC;
+
+	mc_seq =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+	/* retain stream-id and clean rest */
+	mc_seq &= (TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
+			TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT);
+
+	/* Set the address wrapping on both MC and MMIO side */
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_WRAP_NONE <<
+			TEGRA_GPCDMA_MCSEQ_WRAP0_SHIFT;
+	mc_seq |= TEGRA_GPCDMA_MCSEQ_WRAP_NONE <<
+			TEGRA_GPCDMA_MCSEQ_WRAP1_SHIFT;
+	mmio_seq |= (1 << TEGRA_GPCDMA_MMIOSEQ_WRAP_WORD_SHIFT);
+
+	/* Program 2 MC outstanding requests by default. */
+	mc_seq |= (1 << TEGRA_GPCDMA_MCSEQ_REQ_COUNT_SHIFT);
+
+	/* Setting MC burst size depending on MMIO burst size */
+	if (burst_size == 64)
+		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_16;
+	else
+		mc_seq |= TEGRA_GPCDMA_MCSEQ_BURST_2;
+
+	dma_desc = kzalloc(sizeof(struct tegra_dma_desc), GFP_NOWAIT);
+	if (!dma_desc)
+		return NULL;
+
+	dma_desc->bytes_requested = 0;
+	dma_desc->bytes_transferred = 0;
+
+	/* Make transfer requests */
+	for_each_sg(sgl, sg, sg_len, i) {
+		u32 len;
+		dma_addr_t mem;
+
+		mem = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+
+		if ((len & 3) || (mem & 3) ||
+		    len > tdc->tdma->chip_data->max_dma_count) {
+			dev_err(tdc2dev(tdc),
+				"Dma length/memory address is not supported\n");
+			kfree(dma_desc);
+			return NULL;
+		}
+
+		sg_req = kzalloc(sizeof(struct tegra_dma_sg_req), GFP_NOWAIT);
+		if (!sg_req) {
+			kfree(dma_desc);
+			goto sg_alloc_error;
+		}
+
+		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
+		dma_desc->bytes_requested += len;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			sg_req->ch_regs.src_ptr = mem;
+			sg_req->ch_regs.dst_ptr = apb_ptr;
+			sg_req->ch_regs.high_addr_ptr = (mem >> 32) &
+				TEGRA_GPCDMA_HIGH_ADDR_SCR_PTR_MASK;
+		} else if (direction == DMA_DEV_TO_MEM) {
+			sg_req->ch_regs.src_ptr = apb_ptr;
+			sg_req->ch_regs.dst_ptr = mem;
+			sg_req->ch_regs.high_addr_ptr = ((mem >> 32) &
+				TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_MASK) <<
+				TEGRA_GPCDMA_HIGH_ADDR_DST_PTR_SHIFT;
+		}
+
+		/*
+		 * Word count register takes input in words. Writing a value
+		 * of N into word count register means a req of (N+1) words.
+		 */
+		sg_req->ch_regs.wcount = ((len - 4) >> 2);
+		sg_req->ch_regs.csr = csr;
+		sg_req->ch_regs.mmio_seq = mmio_seq;
+		sg_req->ch_regs.mc_seq = mc_seq;
+		sg_req->configured = false;
+		sg_req->last_sg = false;
+		sg_req->dma_desc = dma_desc;
+		sg_req->req_len = len;
+		list_add_tail(&sg_req->node, &tdc->pending_sg_req);
+	}
+	sg_req->last_sg = true;
+
+	/*
+	 * Make sure that mode should not be conflicting with currently
+	 * configured mode.
+	 */
+	if (!tdc->isr_handler)
+		tdc->isr_handler = handle_once_dma_done;
+
+	tdc->pending_dma_desc = NULL;
+
+	return vchan_tx_prep(&tdc->vc, &dma_desc->vd, flags);
+
+sg_alloc_error:
+	while (!list_empty(&tdc->pending_sg_req)) {
+		sg_req = list_first_entry(&tdc->pending_sg_req,
+					  typeof(*sg_req), node);
+		list_del(&sg_req->node);
+		kfree(sg_req);
+	}
+	return NULL;
+}
+
+static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	dma_cookie_init(&tdc->vc.chan);
+	tdc->config_init = false;
+	return 0;
+}
+
+static void tegra_dma_free_chan_resources(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+	struct list_head sg_req_list;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&sg_req_list);
+
+	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
+
+	if (tdc->busy)
+		tegra_dma_terminate_all(dc);
+
+	tasklet_kill(&tdc->vc.task);
+	raw_spin_lock_irqsave(&tdc->lock, flags);
+	tdc->pending_dma_desc = NULL;
+	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
+	tdc->config_init = false;
+	tdc->isr_handler = NULL;
+	tdc->slave_id = -1;
+	raw_spin_unlock_irqrestore(&tdc->lock, flags);
+}
+
+static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
+					   struct of_dma *ofdma)
+{
+	struct tegra_dma *tdma = ofdma->of_dma_data;
+	struct tegra_dma_channel *tdc;
+	struct dma_chan *chan;
+
+	chan = dma_get_any_slave_channel(&tdma->dma_dev);
+	if (!chan)
+		return NULL;
+
+	tdc = to_tegra_dma_chan(chan);
+	tdc->slave_id = dma_spec->args[0];
+
+	return chan;
+}
+
+static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
+	.nr_channels = 32,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = false,
+};
+
+static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
+	.nr_channels = 32,
+	.channel_reg_size = SZ_64K,
+	.max_dma_count = SZ_1G,
+	.hw_support_pause = true,
+};
+
+static const struct of_device_id tegra_dma_of_match[] = {
+	{
+		.compatible = "nvidia,tegra186-gpcdma",
+		.data = &tegra186_dma_chip_data,
+	}, {
+		.compatible = "nvidia,tegra194-gpcdma",
+		.data = &tegra194_dma_chip_data,
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
+
+static int tegra_dma_program_sid(struct tegra_dma_channel *tdc,
+				 int chan, int stream_id)
+{
+	unsigned int reg_val =  tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+
+	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
+					TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT);
+	reg_val &= ~(TEGRA_GPCDMA_MCSEQ_STREAM_ID_MASK <<
+					TEGRA_GPCDMA_MCSEQ_STREAM_ID1_SHIFT);
+
+	reg_val |= (stream_id << TEGRA_GPCDMA_MCSEQ_STREAM_ID0_SHIFT);
+	reg_val |= (stream_id << TEGRA_GPCDMA_MCSEQ_STREAM_ID1_SHIFT);
+
+	tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, reg_val);
+	return 0;
+}
+
+static int tegra_dma_probe(struct platform_device *pdev)
+{
+	const struct tegra_dma_chip_data *cdata = NULL;
+	struct tegra_dma_chip_data *chip_data = NULL;
+	unsigned int nr_chans, stream_id;
+	unsigned int start_chan_idx = 0;
+	struct tegra_dma *tdma;
+	struct resource	*res;
+	unsigned int i;
+	int ret;
+
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_device(of_match_ptr(tegra_dma_of_match),
+					&pdev->dev);
+		if (!match) {
+			dev_err(&pdev->dev, "Error: No device match found\n");
+			return -ENODEV;
+		}
+		cdata = match->data;
+
+		ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
+					   &nr_chans);
+		if (!ret) {
+			/* Allocate chip data and update number of channels */
+			chip_data =
+				devm_kzalloc(&pdev->dev,
+					     sizeof(struct tegra_dma_chip_data),
+								GFP_KERNEL);
+			if (!chip_data) {
+				dev_err(&pdev->dev, "Error: memory allocation failed\n");
+				return -ENOMEM;
+			}
+			memcpy(chip_data, cdata,
+			       sizeof(struct tegra_dma_chip_data));
+			chip_data->nr_channels = nr_chans;
+			cdata = chip_data;
+		}
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "nvidia,start-dma-channel-index",
+						&start_chan_idx);
+		if (ret)
+			start_chan_idx = 0;
+
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "nvidia,stream-id", &stream_id);
+		if (ret)
+			stream_id = TEGRA186_SID_GPCDMA_0;
+
+	} else {
+		/* If no device tree then fallback to chip data */
+		cdata =
+		    (struct tegra_dma_chip_data *)pdev->id_entry->driver_data;
+		stream_id = TEGRA186_SID_GPCDMA_0;
+	}
+
+	tdma = devm_kzalloc(&pdev->dev, sizeof(*tdma) + cdata->nr_channels *
+			sizeof(struct tegra_dma_channel), GFP_KERNEL);
+	if (!tdma)
+		return -ENOMEM;
+
+	tdma->dev = &pdev->dev;
+	tdma->chip_data = cdata;
+	platform_set_drvdata(pdev, tdma);
+
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tdma->base_addr))
+		return PTR_ERR(tdma->base_addr);
+
+	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
+	if (IS_ERR(tdma->rst)) {
+		if (!(PTR_ERR(tdma->rst) == -EPROBE_DEFER))
+			dev_err(&pdev->dev, "Missing controller reset\n");
+		return PTR_ERR(tdma->rst);
+	}
+	reset_control_reset(tdma->rst);
+
+	tdma->dma_dev.dev = &pdev->dev;
+
+	INIT_LIST_HEAD(&tdma->dma_dev.channels);
+	for (i = 0; i < cdata->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
+				start_chan_idx * cdata->channel_reg_size +
+					i * cdata->channel_reg_size;
+		res = platform_get_resource(pdev, IORESOURCE_IRQ,
+					    start_chan_idx + i);
+		if (!res) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
+			goto err_irq;
+		}
+		tdc->irq = res->start;
+		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
+
+		tdc->tdma = tdma;
+		tdc->id = i;
+		tdc->slave_id = -1;
+
+		vchan_init(&tdc->vc, &tdma->dma_dev);
+		tdc->vc.desc_free = tegra_dma_desc_free;
+		raw_spin_lock_init(&tdc->lock);
+
+		INIT_LIST_HEAD(&tdc->pending_sg_req);
+		tdc->pending_dma_desc = NULL;
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, i, stream_id);
+	}
+
+	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMSET, tdma->dma_dev.cap_mask);
+
+	/*
+	 * Only word aligned transfers are supported. Set the copy
+	 * alignment shift.
+	 */
+	tdma->dma_dev.copy_align = 2;
+	tdma->dma_dev.fill_align = 2;
+	tdma->dma_dev.device_alloc_chan_resources =
+					tegra_dma_alloc_chan_resources;
+	tdma->dma_dev.device_free_chan_resources =
+					tegra_dma_free_chan_resources;
+	tdma->dma_dev.device_prep_slave_sg = tegra_dma_prep_slave_sg;
+	tdma->dma_dev.device_prep_dma_memcpy = tegra_dma_prep_dma_memcpy;
+	tdma->dma_dev.device_prep_dma_memset = tegra_dma_prep_dma_memset;
+	tdma->dma_dev.device_config = tegra_dma_slave_config;
+	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
+	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
+	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
+	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	/* Register DMA channel interrupt handlers after everything is setup */
+	for (i = 0; i < cdata->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+
+		ret = devm_request_irq(&pdev->dev, tdc->irq,
+				       tegra_dma_isr, 0, tdc->name, tdc);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"request_irq failed with err %d channel %d\n",
+				i, ret);
+			goto err_irq;
+		}
+	}
+
+	ret = dma_async_device_register(&tdma->dma_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"GPC DMA driver registration failed %d\n", ret);
+		goto err_irq;
+	}
+
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 tegra_dma_of_xlate, tdma);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"GPC DMA OF registration failed %d\n", ret);
+		goto err_unregister_dma_dev;
+	}
+
+	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
+		 cdata->nr_channels);
+	return 0;
+
+err_unregister_dma_dev:
+	dma_async_device_unregister(&tdma->dma_dev);
+err_irq:
+	return ret;
+}
+
+static int tegra_dma_remove(struct platform_device *pdev)
+{
+	struct tegra_dma *tdma = platform_get_drvdata(pdev);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&tdma->dma_dev);
+
+	return 0;
+}
+
+/*
+ * Save and restore csr and channel register on pm_suspend
+ * and pm_resume respectively
+ */
+static int __maybe_unused tegra_dma_pm_suspend(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
+
+		ch_reg->csr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_CSR);
+		ch_reg->src_ptr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR);
+		ch_reg->dst_ptr = tdc_read(tdc, TEGRA_GPCDMA_CHAN_DST_PTR);
+		ch_reg->high_addr_ptr = tdc_read(tdc,
+						 TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR);
+		ch_reg->mc_seq = tdc_read(tdc, TEGRA_GPCDMA_CHAN_MCSEQ);
+		ch_reg->mmio_seq = tdc_read(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ);
+		ch_reg->wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_WCOUNT);
+	}
+	return 0;
+}
+
+static int __maybe_unused tegra_dma_pm_resume(struct device *dev)
+{
+	struct tegra_dma *tdma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < tdma->chip_data->nr_channels; i++) {
+		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		struct tegra_dma_channel_regs *ch_reg = &tdc->channel_reg;
+
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_WCOUNT, ch_reg->wcount);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_DST_PTR, ch_reg->dst_ptr);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_SRC_PTR, ch_reg->src_ptr);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_HIGH_ADDR_PTR,
+			  ch_reg->high_addr_ptr);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_MMIOSEQ, ch_reg->mmio_seq);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_MCSEQ, ch_reg->mc_seq);
+		tdc_write(tdc, TEGRA_GPCDMA_CHAN_CSR,
+			  (ch_reg->csr & ~TEGRA_GPCDMA_CSR_ENB));
+	}
+	return 0;
+}
+
+static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend, tegra_dma_pm_resume)
+};
+
+static struct platform_driver tegra_dmac_driver = {
+	.driver = {
+		.name	= "tegra-gpcdma",
+		.owner = THIS_MODULE,
+		.pm	= &tegra_dma_dev_pm_ops,
+		.of_match_table = tegra_dma_of_match,
+	},
+	.probe		= tegra_dma_probe,
+	.remove		= tegra_dma_remove,
+};
+
+module_platform_driver(tegra_dmac_driver);
+
+MODULE_ALIAS("platform:tegra-gpc-dma");
+MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
+MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
+MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

