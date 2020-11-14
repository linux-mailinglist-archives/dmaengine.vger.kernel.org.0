Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA462B1FB7
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 17:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKMQL7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 11:11:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7895 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMQL7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Nov 2020 11:11:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CXk3c10lmz76S1;
        Sat, 14 Nov 2020 00:11:08 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 14 Nov 2020
 00:10:06 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <dan.j.williams@intel.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gengdongjiu@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dmaengine: dma: Add Hiedma Controller v310 Device Driver
Date:   Sat, 14 Nov 2020 00:34:40 +0000
Message-ID: <20201114003440.36458-2-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114003440.36458-1-gengdongjiu@huawei.com>
References: <20201114003440.36458-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hisilicon EDMA Controller(EDMAC) directly transfers data
between a memory and a peripheral, between peripherals, or
between memories. This avoids the CPU intervention and reduces
the interrupt handling overhead of the CPU, this driver enables
this controller.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 drivers/dma/Kconfig       |   14 +
 drivers/dma/Makefile      |    1 +
 drivers/dma/hiedmacv310.c | 1452 +++++++++++++++++++++++++++++++++++++
 drivers/dma/hiedmacv310.h |  136 ++++
 4 files changed, 1603 insertions(+)
 create mode 100644 drivers/dma/hiedmacv310.c
 create mode 100644 drivers/dma/hiedmacv310.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 90284ffda58a..3e5107120ff1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -327,6 +327,20 @@ config K3_DMA
 	  Support the DMA engine for Hisilicon K3 platform
 	  devices.
 
+config HIEDMACV310
+	tristate "Hisilicon EDMAC Controller support"
+	depends on ARCH_HISI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  The Direction Memory Access(EDMA) is a high-speed data transfer
+	  operation. It supports data read/write between peripherals and
+	  memories without using the CPU.
+	  Hisilicon EDMA Controller(EDMAC) directly transfers data between
+	  a memory and a peripheral, between peripherals, or between memories.
+	  This avoids the CPU intervention and reduces the interrupt handling
+	  overhead of the CPU.
+
 config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 948a8da05f8b..28c7298b671e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
+obj-$(CONFIG_HIEDMACV310) += hiedmacv310.o
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/hiedmacv310.c b/drivers/dma/hiedmacv310.c
new file mode 100644
index 000000000000..cd1fe30538ee
--- /dev/null
+++ b/drivers/dma/hiedmacv310.c
@@ -0,0 +1,1452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Hiedma Controller v310 Device Driver for HiSilicon
+ *
+ * Copyright (c) 2019-2020, Huawei Tech. Co., Ltd.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include "hiedmacv310.h"
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+#define DRIVER_NAME "hiedmacv310"
+
+#define MAX_TSFR_LLIS           512
+#define EDMACV300_LLI_WORDS     64
+#define EDMACV300_POOL_ALIGN    64
+#define BITS_PER_HALF_WORD 32
+
+struct hiedmac_lli {
+	u64 next_lli;
+	u32 reserved[5];
+	u32 count;
+	u64 src_addr;
+	u64 dest_addr;
+	u32 config;
+	u32 pad[3];
+};
+
+struct hiedmac_sg {
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
+	size_t len;
+	struct list_head node;
+};
+
+struct transfer_desc {
+	struct virt_dma_desc virt_desc;
+	dma_addr_t llis_busaddr;
+	u64 *llis_vaddr;
+	u32 ccfg;
+	size_t size;
+	bool done;
+	bool cyclic;
+};
+
+enum edmac_dma_chan_state {
+	HIEDMAC_CHAN_IDLE,
+	HIEDMAC_CHAN_RUNNING,
+	HIEDMAC_CHAN_PAUSED,
+	HIEDMAC_CHAN_WAITING,
+};
+
+struct hiedmacv310_dma_chan {
+	bool slave;
+	int signal;
+	int id;
+	struct virt_dma_chan virt_chan;
+	struct hiedmacv310_phy_chan *phychan;
+	struct dma_slave_config cfg;
+	struct transfer_desc *at;
+	struct hiedmacv310_driver_data *host;
+	enum edmac_dma_chan_state state;
+};
+
+struct hiedmacv310_phy_chan {
+	unsigned int id;
+	void __iomem *base;
+	spinlock_t lock;
+	struct hiedmacv310_dma_chan *serving;
+};
+
+struct hiedmacv310_driver_data {
+	struct platform_device *dev;
+	struct dma_device slave;
+	struct dma_device memcpy;
+	void __iomem *base;
+	struct regmap *misc_regmap;
+	void __iomem *crg_ctrl;
+	struct hiedmacv310_phy_chan *phy_chans;
+	struct dma_pool *pool;
+	unsigned int misc_ctrl_base;
+	int irq;
+	unsigned int id;
+	struct clk *clk;
+	struct clk *axi_clk;
+	struct reset_control *rstc;
+	unsigned int channels;
+	unsigned int slave_requests;
+	unsigned int max_transfer_size;
+};
+
+#ifdef DEBUG_HIEDMAC
+void dump_lli(const u64 *llis_vaddr, unsigned int num)
+{
+	struct hiedmac_lli *plli = (struct hiedmac_lli *)llis_vaddr;
+	unsigned int i;
+
+	hiedmacv310_trace(HIEDMACV310_CONFIG_TRACE_LEVEL, "lli num = 0%d", num);
+	for (i = 0; i < num; i++) {
+		hiedmacv310_info("lli%d:lli_L:      0x%llx\n", i,
+			plli[i].next_lli & 0xffffffff);
+		hiedmacv310_info("lli%d:lli_H:      0x%llx\n", i,
+			(plli[i].next_lli >> BITS_PER_HALF_WORD) & 0xffffffff);
+		hiedmacv310_info("lli%d:count:      0x%llx\n", i,
+			plli[i].count);
+		hiedmacv310_info("lli%d:src_addr_L: 0x%llx\n", i,
+			plli[i].src_addr & 0xffffffff);
+		hiedmacv310_info("lli%d:src_addr_H: 0x%llx\n", i,
+			(plli[i].src_addr >> BITS_PER_HALF_WORD) & 0xffffffff);
+		hiedmacv310_info("lli%d:dst_addr_L: 0x%llx\n", i,
+				 plli[i].dest_addr & 0xffffffff);
+		hiedmacv310_info("lli%d:dst_addr_H: 0x%llx\n", i,
+			(plli[i].dest_addr >> BITS_PER_HALF_WORD) & 0xffffffff);
+		hiedmacv310_info("lli%d:CONFIG:	  0x%llx\n", i,
+				 plli[i].config);
+	}
+}
+
+#else
+void dump_lli(u64 *llis_vaddr, unsigned int num)
+{
+}
+#endif
+
+static inline struct hiedmacv310_dma_chan *to_edamc_chan(const struct dma_chan *chan)
+{
+	return container_of(chan, struct hiedmacv310_dma_chan, virt_chan.chan);
+}
+
+static inline struct transfer_desc *to_edmac_transfer_desc(
+	const struct dma_async_tx_descriptor *tx)
+{
+	return container_of(tx, struct transfer_desc, virt_desc.tx);
+}
+
+static struct dma_chan *hiedmac_find_chan_id(
+	const struct hiedmacv310_driver_data *hiedmac,
+	int request_num)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = NULL;
+
+	list_for_each_entry(edmac_dma_chan, &hiedmac->slave.channels,
+			    virt_chan.chan.device_node) {
+		if (edmac_dma_chan->id == request_num)
+			return &edmac_dma_chan->virt_chan.chan;
+	}
+	return NULL;
+}
+
+static struct dma_chan *hiedma_of_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct hiedmacv310_driver_data *hiedmac = ofdma->of_dma_data;
+	struct hiedmacv310_dma_chan *edmac_dma_chan = NULL;
+	struct dma_chan *dma_chan = NULL;
+	struct regmap *misc = NULL;
+	unsigned int signal, request_num;
+	unsigned int reg = 0;
+	unsigned int offset = 0;
+
+	if (!hiedmac)
+		return NULL;
+
+	misc = hiedmac->misc_regmap;
+
+	if (dma_spec->args_count != 2) { /* check num of dts node args */
+		hiedmacv310_error("args count not true!");
+		return NULL;
+	}
+
+	request_num = dma_spec->args[0];
+	signal = dma_spec->args[1];
+
+	hiedmacv310_trace(HIEDMACV310_CONFIG_TRACE_LEVEL,
+			  "host->id = %d,signal = %d, request_num = %d",
+			  hiedmac->id, signal, request_num);
+
+	if (misc != NULL) {
+		offset = hiedmac->misc_ctrl_base + (request_num & (~0x3));
+		regmap_read(misc, offset, &reg);
+		/* set misc for signal line */
+		reg &= ~(0x3f << ((request_num & 0x3) << 3));
+		reg |= signal << ((request_num & 0x3) << 3);
+		regmap_write(misc, offset, reg);
+	}
+
+	hiedmacv310_trace(HIEDMACV310_CONFIG_TRACE_LEVEL,
+			  "offset = 0x%x, reg = 0x%x", offset, reg);
+
+	dma_chan = hiedmac_find_chan_id(hiedmac, request_num);
+	if (!dma_chan) {
+		hiedmacv310_error("DMA slave channel is not found!");
+		return NULL;
+	}
+
+	edmac_dma_chan = to_edamc_chan(dma_chan);
+	edmac_dma_chan->signal = request_num;
+	return dma_get_slave_channel(dma_chan);
+}
+
+static int hiedmacv310_devm_get(struct hiedmacv310_driver_data *hiedmac)
+{
+	struct platform_device *platdev = hiedmac->dev;
+	struct resource *res = NULL;
+
+	hiedmac->clk = devm_clk_get(&(platdev->dev), "apb_pclk");
+	if (IS_ERR(hiedmac->clk))
+		return PTR_ERR(hiedmac->clk);
+
+	hiedmac->axi_clk = devm_clk_get(&(platdev->dev), "axi_aclk");
+	if (IS_ERR(hiedmac->axi_clk))
+		return PTR_ERR(hiedmac->axi_clk);
+
+	hiedmac->irq = platform_get_irq(platdev, 0);
+	if (unlikely(hiedmac->irq < 0))
+		return -ENODEV;
+
+	hiedmac->rstc = devm_reset_control_get(&(platdev->dev), "dma-reset");
+	if (IS_ERR(hiedmac->rstc))
+		return PTR_ERR(hiedmac->rstc);
+
+	res = platform_get_resource(platdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		hiedmacv310_error("no reg resource");
+		return -ENODEV;
+	}
+
+	hiedmac->base = devm_ioremap_resource(&(platdev->dev), res);
+	if (IS_ERR(hiedmac->base))
+		return PTR_ERR(hiedmac->base);
+
+	return 0;
+}
+
+static int hiedmacv310_of_property_read(struct hiedmacv310_driver_data *hiedmac)
+{
+	struct platform_device *platdev = hiedmac->dev;
+	struct device_node *np = platdev->dev.of_node;
+	int ret;
+
+	hiedmac->misc_regmap = syscon_regmap_lookup_by_phandle(np, "misc_regmap");
+	if (IS_ERR(hiedmac->misc_regmap))
+		return PTR_ERR(hiedmac->misc_regmap);
+
+	ret = of_property_read_u32(np, "misc_ctrl_base", &(hiedmac->misc_ctrl_base));
+	if (ret) {
+		hiedmacv310_error("get dma-misc_ctrl_base fail");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(np, "devid", &(hiedmac->id));
+	if (ret) {
+		hiedmacv310_error("get hiedmac id fail");
+		return -ENODEV;
+	}
+	ret = of_property_read_u32(np, "dma-channels", &(hiedmac->channels));
+	if (ret) {
+		hiedmacv310_error("get dma-channels fail");
+		return -ENODEV;
+	}
+	ret = of_property_read_u32(np, "dma-requests", &(hiedmac->slave_requests));
+	if (ret) {
+		hiedmacv310_error("get dma-requests fail");
+		return -ENODEV;
+	}
+	hiedmacv310_trace(HIEDMACV310_REG_TRACE_LEVEL, "dma-channels = %d, dma-requests = %d",
+			  hiedmac->channels, hiedmac->slave_requests);
+	return 0;
+}
+
+static int get_of_probe(struct hiedmacv310_driver_data *hiedmac)
+{
+	struct platform_device *platdev = hiedmac->dev;
+	int ret;
+
+	ret = hiedmacv310_devm_get(hiedmac);
+	if (ret)
+		return ret;
+
+	ret = hiedmacv310_of_property_read(hiedmac);
+	if (ret)
+		return ret;
+
+	return of_dma_controller_register(platdev->dev.of_node,
+					  hiedma_of_xlate, hiedmac);
+}
+
+static void hiedmac_free_chan_resources(struct dma_chan *chan)
+{
+	vchan_free_chan_resources(to_virt_chan(chan));
+}
+
+static size_t read_residue_from_phychan(
+	struct hiedmacv310_dma_chan *edmac_dma_chan,
+	struct transfer_desc *tsf_desc)
+{
+	size_t bytes;
+	u64 next_lli;
+	struct hiedmacv310_phy_chan *phychan = edmac_dma_chan->phychan;
+	unsigned int i, index;
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct hiedmac_lli *plli = NULL;
+
+	next_lli = (hiedmacv310_readl(hiedmac->base + hiedmac_cx_lli_l(phychan->id)) &
+			(~(HIEDMAC_LLI_ALIGN - 1)));
+	next_lli |= ((u64)(hiedmacv310_readl(hiedmac->base + hiedmac_cx_lli_h(
+			phychan->id)) & 0xffffffff) << BITS_PER_HALF_WORD);
+	bytes = hiedmacv310_readl(hiedmac->base + hiedmac_cx_curr_cnt0(
+			phychan->id));
+	if (next_lli != 0) {
+		/* It means lli mode */
+		bytes += tsf_desc->size;
+		index = (next_lli - tsf_desc->llis_busaddr) / sizeof(*plli);
+		plli = (struct hiedmac_lli *)(tsf_desc->llis_vaddr);
+		for (i = 0; i < index; i++)
+			bytes -= plli[i].count;
+	}
+	return bytes;
+}
+
+static enum dma_status hiedmac_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	enum dma_status ret;
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	struct virt_dma_desc *vd = NULL;
+	struct transfer_desc *tsf_desc = NULL;
+	unsigned long flags;
+	size_t bytes;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	if (edmac_dma_chan->state == HIEDMAC_CHAN_PAUSED && ret == DMA_IN_PROGRESS) {
+		ret = DMA_PAUSED;
+		return ret;
+	}
+
+	spin_lock_irqsave(&edmac_dma_chan->virt_chan.lock, flags);
+	vd = vchan_find_desc(&edmac_dma_chan->virt_chan, cookie);
+	if (vd) {
+		/* no been trasfered */
+		tsf_desc = to_edmac_transfer_desc(&vd->tx);
+		bytes = tsf_desc->size;
+	} else {
+		/* trasfering */
+		tsf_desc = edmac_dma_chan->at;
+
+		if (!(edmac_dma_chan->phychan) || !tsf_desc) {
+			spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+			return ret;
+		}
+		bytes = read_residue_from_phychan(edmac_dma_chan, tsf_desc);
+	}
+	spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+	dma_set_residue(txstate, bytes);
+	return ret;
+}
+
+static struct hiedmacv310_phy_chan *hiedmac_get_phy_channel(
+	const struct hiedmacv310_driver_data *hiedmac,
+	struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	struct hiedmacv310_phy_chan *ch = NULL;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < hiedmac->channels; i++) {
+		ch = &hiedmac->phy_chans[i];
+
+		spin_lock_irqsave(&ch->lock, flags);
+
+		if (!ch->serving) {
+			ch->serving = edmac_dma_chan;
+			spin_unlock_irqrestore(&ch->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&ch->lock, flags);
+	}
+
+	if (i == hiedmac->channels)
+		return NULL;
+
+	return ch;
+}
+
+static void hiedmac_write_lli(const struct hiedmacv310_driver_data *hiedmac,
+			      const struct hiedmacv310_phy_chan *phychan,
+			      const struct transfer_desc *tsf_desc)
+{
+	struct hiedmac_lli *plli = (struct hiedmac_lli *)tsf_desc->llis_vaddr;
+
+	if (plli->next_lli != 0x0)
+		hiedmacv310_writel((plli->next_lli & 0xffffffff) | HIEDMAC_LLI_ENABLE,
+				   hiedmac->base + hiedmac_cx_lli_l(phychan->id));
+	else
+		hiedmacv310_writel((plli->next_lli & 0xffffffff),
+				   hiedmac->base + hiedmac_cx_lli_l(phychan->id));
+
+	hiedmacv310_writel(((plli->next_lli >> 32) & 0xffffffff),
+			   hiedmac->base + hiedmac_cx_lli_h(phychan->id));
+	hiedmacv310_writel(plli->count, hiedmac->base + hiedmac_cx_cnt0(phychan->id));
+	hiedmacv310_writel(plli->src_addr & 0xffffffff,
+			   hiedmac->base + hiedmac_cx_src_addr_l(phychan->id));
+	hiedmacv310_writel((plli->src_addr >> 32) & 0xffffffff,
+			   hiedmac->base + hiedmac_cx_src_addr_h(phychan->id));
+	hiedmacv310_writel(plli->dest_addr & 0xffffffff,
+			   hiedmac->base + hiedmac_cx_dest_addr_l(phychan->id));
+	hiedmacv310_writel((plli->dest_addr >> 32) & 0xffffffff,
+			   hiedmac->base + hiedmac_cx_dest_addr_h(phychan->id));
+	hiedmacv310_writel(plli->config,
+			   hiedmac->base + hiedmac_cx_config(phychan->id));
+}
+
+static void hiedmac_start_next_txd(struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct hiedmacv310_phy_chan *phychan = edmac_dma_chan->phychan;
+	struct virt_dma_desc *vd = vchan_next_desc(&edmac_dma_chan->virt_chan);
+	struct transfer_desc *tsf_desc = to_edmac_transfer_desc(&vd->tx);
+	unsigned int val;
+
+	list_del(&tsf_desc->virt_desc.node);
+	edmac_dma_chan->at = tsf_desc;
+	hiedmac_write_lli(hiedmac, phychan, tsf_desc);
+	val = hiedmacv310_readl(hiedmac->base + hiedmac_cx_config(phychan->id));
+	hiedmacv310_trace(HIEDMACV310_REG_TRACE_LEVEL, " HIEDMAC_Cx_CONFIG  = 0x%x", val);
+	hiedmacv310_writel(val | HIEDMAC_CXCONFIG_LLI_START,
+			   hiedmac->base + hiedmac_cx_config(phychan->id));
+}
+
+static void hiedmac_start(struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct hiedmacv310_phy_chan *ch;
+
+	ch = hiedmac_get_phy_channel(hiedmac, edmac_dma_chan);
+	if (!ch) {
+		hiedmacv310_error("no phy channel available !");
+		edmac_dma_chan->state = HIEDMAC_CHAN_WAITING;
+		return;
+	}
+	edmac_dma_chan->phychan = ch;
+	edmac_dma_chan->state = HIEDMAC_CHAN_RUNNING;
+	hiedmac_start_next_txd(edmac_dma_chan);
+}
+
+static void hiedmac_issue_pending(struct dma_chan *chan)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&edmac_dma_chan->virt_chan.lock, flags);
+	if (vchan_issue_pending(&edmac_dma_chan->virt_chan)) {
+		if (!edmac_dma_chan->phychan && edmac_dma_chan->state != HIEDMAC_CHAN_WAITING)
+			hiedmac_start(edmac_dma_chan);
+	}
+	spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+}
+
+static void hiedmac_free_txd_list(struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	LIST_HEAD(head);
+
+	vchan_get_all_descriptors(&edmac_dma_chan->virt_chan, &head);
+	vchan_dma_desc_free_list(&edmac_dma_chan->virt_chan, &head);
+}
+
+static int hiedmac_config(struct dma_chan *chan,
+			  struct dma_slave_config *config)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+
+	if (!edmac_dma_chan->slave) {
+		hiedmacv310_error("slave is null!");
+		return -EINVAL;
+	}
+	edmac_dma_chan->cfg = *config;
+	return 0;
+}
+
+static void hiedmac_pause_phy_chan(const struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct hiedmacv310_phy_chan *phychan = edmac_dma_chan->phychan;
+	unsigned int val;
+	int timeout;
+
+	val = hiedmacv310_readl(hiedmac->base + hiedmac_cx_config(phychan->id));
+	val &= ~CCFG_EN;
+	hiedmacv310_writel(val, hiedmac->base + hiedmac_cx_config(phychan->id));
+	/* Wait for channel inactive */
+	for (timeout = 2000; timeout > 0; timeout--) {
+		if (!((0x1 << phychan->id) & hiedmacv310_readl(hiedmac->base + HIEDMAC_CH_STAT)))
+			break;
+		hiedmacv310_writel(val, hiedmac->base + hiedmac_cx_config(phychan->id));
+		udelay(1);
+	}
+	if (timeout == 0)
+		hiedmacv310_error(":channel%u timeout waiting for pause, timeout:%d",
+				  phychan->id, timeout);
+}
+
+static int hiedmac_pause(struct dma_chan *chan)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&edmac_dma_chan->virt_chan.lock, flags);
+	if (!edmac_dma_chan->phychan) {
+		spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+		return 0;
+	}
+	hiedmac_pause_phy_chan(edmac_dma_chan);
+	edmac_dma_chan->state = HIEDMAC_CHAN_PAUSED;
+	spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+	return 0;
+}
+
+static void hiedmac_resume_phy_chan(const struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct hiedmacv310_phy_chan *phychan = edmac_dma_chan->phychan;
+	unsigned int val;
+
+	val = hiedmacv310_readl(hiedmac->base + hiedmac_cx_config(phychan->id));
+	val |= CCFG_EN;
+	hiedmacv310_writel(val, hiedmac->base + hiedmac_cx_config(phychan->id));
+}
+
+static int hiedmac_resume(struct dma_chan *chan)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&edmac_dma_chan->virt_chan.lock, flags);
+
+	if (!edmac_dma_chan->phychan) {
+		spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+		return 0;
+	}
+
+	hiedmac_resume_phy_chan(edmac_dma_chan);
+	edmac_dma_chan->state = HIEDMAC_CHAN_RUNNING;
+	spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+
+	return 0;
+}
+
+void hiedmac_phy_free(struct hiedmacv310_dma_chan *chan);
+static void hiedmac_desc_free(struct virt_dma_desc *vd);
+static int hiedmac_terminate_all(struct dma_chan *chan)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&edmac_dma_chan->virt_chan.lock, flags);
+	if (!edmac_dma_chan->phychan && !edmac_dma_chan->at) {
+		spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+		return 0;
+	}
+
+	edmac_dma_chan->state = HIEDMAC_CHAN_IDLE;
+
+	if (edmac_dma_chan->phychan)
+		hiedmac_phy_free(edmac_dma_chan);
+	if (edmac_dma_chan->at) {
+		hiedmac_desc_free(&edmac_dma_chan->at->virt_desc);
+		edmac_dma_chan->at = NULL;
+	}
+	hiedmac_free_txd_list(edmac_dma_chan);
+	spin_unlock_irqrestore(&edmac_dma_chan->virt_chan.lock, flags);
+
+	return 0;
+}
+
+static u32 get_width(enum dma_slave_buswidth width)
+{
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		return HIEDMAC_WIDTH_8BIT;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return HIEDMAC_WIDTH_16BIT;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return HIEDMAC_WIDTH_32BIT;
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		return HIEDMAC_WIDTH_64BIT;
+	default:
+		hiedmacv310_error("check here, width warning!");
+		return ~0;
+	}
+}
+
+static unsigned int hiedmac_set_config_value(enum dma_transfer_direction direction,
+					     unsigned int addr_width,
+					     unsigned int burst,
+					     unsigned int signal)
+{
+	unsigned int config, width;
+
+	if (direction == DMA_MEM_TO_DEV)
+		config = HIEDMAC_CONFIG_SRC_INC;
+	else
+		config = HIEDMAC_CONFIG_DST_INC;
+
+	hiedmacv310_trace(HIEDMACV310_CONFIG_TRACE_LEVEL, "addr_width = 0x%x", addr_width);
+	width = get_width(addr_width);
+	hiedmacv310_trace(HIEDMACV310_CONFIG_TRACE_LEVEL, "width = 0x%x", width);
+	config |= width << HIEDMAC_CONFIG_SRC_WIDTH_SHIFT;
+	config |= width << HIEDMAC_CONFIG_DST_WIDTH_SHIFT;
+	hiedmacv310_trace(HIEDMACV310_REG_TRACE_LEVEL, "tsf_desc->ccfg = 0x%x", config);
+	hiedmacv310_trace(HIEDMACV310_CONFIG_TRACE_LEVEL, "burst = 0x%x", burst);
+	config |= burst << HIEDMAC_CONFIG_SRC_BURST_SHIFT;
+	config |= burst << HIEDMAC_CONFIG_DST_BURST_SHIFT;
+	if (signal >= 0) {
+		hiedmacv310_trace(HIEDMACV310_REG_TRACE_LEVEL,
+				  "edmac_dma_chan->signal = %d", signal);
+		config |= (unsigned int)signal << HIEDMAC_CXCONFIG_SIGNAL_SHIFT;
+	}
+	config |= HIEDMAC_CXCONFIG_DEV_MEM_TYPE << HIEDMAC_CXCONFIG_TSF_TYPE_SHIFT;
+	return config;
+}
+
+struct transfer_desc *hiedmac_init_tsf_desc(struct dma_chan *chan,
+	enum dma_transfer_direction direction,
+	dma_addr_t *slave_addr)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	struct transfer_desc *tsf_desc;
+	unsigned int burst = 0;
+	unsigned int addr_width = 0;
+	unsigned int maxburst = 0;
+
+	tsf_desc = kzalloc(sizeof(*tsf_desc), GFP_NOWAIT);
+	if (!tsf_desc)
+		return NULL;
+	if (direction == DMA_MEM_TO_DEV) {
+		*slave_addr = edmac_dma_chan->cfg.dst_addr;
+		addr_width = edmac_dma_chan->cfg.dst_addr_width;
+		maxburst = edmac_dma_chan->cfg.dst_maxburst;
+	} else if (direction == DMA_DEV_TO_MEM) {
+		*slave_addr = edmac_dma_chan->cfg.src_addr;
+		addr_width = edmac_dma_chan->cfg.src_addr_width;
+		maxburst = edmac_dma_chan->cfg.src_maxburst;
+	} else {
+		kfree(tsf_desc);
+		hiedmacv310_error("direction unsupported!");
+		return NULL;
+	}
+
+	if (maxburst > (HIEDMAC_MAX_BURST_WIDTH))
+		burst |= (HIEDMAC_MAX_BURST_WIDTH - 1);
+	else if (maxburst == 0)
+		burst |= HIEDMAC_MIN_BURST_WIDTH;
+	else
+		burst |= (maxburst - 1);
+
+	tsf_desc->ccfg = hiedmac_set_config_value(direction, addr_width,
+				 burst, edmac_dma_chan->signal);
+	hiedmacv310_trace(HIEDMACV310_REG_TRACE_LEVEL, "tsf_desc->ccfg = 0x%x", tsf_desc->ccfg);
+	return tsf_desc;
+}
+
+static int hiedmac_fill_desc(const struct hiedmac_sg *dsg,
+			     struct transfer_desc *tsf_desc,
+			     unsigned int length, unsigned int num)
+{
+	struct hiedmac_lli *plli = NULL;
+
+	if (num >= MAX_TSFR_LLIS) {
+		hiedmacv310_error("lli out of range.");
+		return -ENOMEM;
+	}
+
+	plli = (struct hiedmac_lli *)(tsf_desc->llis_vaddr);
+	memset(&plli[num], 0x0, sizeof(*plli));
+
+	plli[num].src_addr = dsg->src_addr;
+	plli[num].dest_addr = dsg->dst_addr;
+	plli[num].config = tsf_desc->ccfg;
+	plli[num].count = length;
+	tsf_desc->size += length;
+
+	if (num > 0) {
+		plli[num - 1].next_lli = (tsf_desc->llis_busaddr + (num) * sizeof(
+					  *plli)) & (~(HIEDMAC_LLI_ALIGN - 1));
+		plli[num - 1].next_lli |= HIEDMAC_LLI_ENABLE;
+	}
+	return 0;
+}
+
+static void free_dsg(struct list_head *dsg_head)
+{
+	struct hiedmac_sg *dsg = NULL;
+	struct hiedmac_sg *_dsg = NULL;
+
+	list_for_each_entry_safe(dsg, _dsg, dsg_head, node) {
+		list_del(&dsg->node);
+		kfree(dsg);
+	}
+}
+
+static int hiedmac_add_sg(struct list_head *sg_head,
+			  dma_addr_t dst, dma_addr_t src,
+			  size_t len)
+{
+	struct hiedmac_sg *dsg = NULL;
+
+	if (len == 0) {
+		hiedmacv310_error("Transfer length is 0.");
+		return -ENOMEM;
+	}
+
+	dsg = kzalloc(sizeof(*dsg), GFP_NOWAIT);
+	if (!dsg) {
+		free_dsg(sg_head);
+		hiedmacv310_error("alloc memory for dsg fail.");
+		return -ENOMEM;
+	}
+
+	list_add_tail(&dsg->node, sg_head);
+	dsg->src_addr = src;
+	dsg->dst_addr = dst;
+	dsg->len = len;
+	return 0;
+}
+
+static int hiedmac_add_sg_slave(struct list_head *sg_head,
+				dma_addr_t slave_addr, dma_addr_t addr,
+				size_t length,
+				enum dma_transfer_direction direction)
+{
+	dma_addr_t src = 0;
+	dma_addr_t dst = 0;
+
+	if (direction == DMA_MEM_TO_DEV) {
+		src = addr;
+		dst = slave_addr;
+	} else if (direction == DMA_DEV_TO_MEM) {
+		src = slave_addr;
+		dst = addr;
+	} else {
+		hiedmacv310_error("invali dma_transfer_direction.");
+		return -ENOMEM;
+	}
+	return hiedmac_add_sg(sg_head, dst, src, length);
+}
+
+static int hiedmac_fill_sg_for_slave(struct list_head *sg_head,
+				     dma_addr_t slave_addr,
+				     struct scatterlist *sgl,
+				     unsigned int sg_len,
+				     enum dma_transfer_direction direction)
+{
+	struct scatterlist *sg = NULL;
+	int tmp, ret;
+	size_t length;
+	dma_addr_t addr;
+
+	if (sgl == NULL) {
+		hiedmacv310_error("sgl is null!");
+		return -ENOMEM;
+	}
+
+	for_each_sg(sgl, sg, sg_len, tmp) {
+		addr = sg_dma_address(sg);
+		length = sg_dma_len(sg);
+		ret = hiedmac_add_sg_slave(sg_head, slave_addr, addr, length, direction);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static inline int hiedmac_fill_sg_for_memcpy(struct list_head *sg_head,
+					     dma_addr_t dst, dma_addr_t src,
+					     size_t len)
+{
+	return hiedmac_add_sg(sg_head, dst, src, len);
+}
+
+static int hiedmac_fill_sg_for_cyclic(struct list_head *sg_head,
+				      dma_addr_t slave_addr,
+				      dma_addr_t buf_addr, size_t buf_len,
+				      size_t period_len,
+				      enum dma_transfer_direction direction)
+{
+	size_t count_in_sg = 0;
+	size_t trans_bytes;
+	int ret;
+
+	while (count_in_sg < buf_len) {
+		trans_bytes = min(period_len, buf_len - count_in_sg);
+		count_in_sg += trans_bytes;
+		ret = hiedmac_add_sg_slave(sg_head, slave_addr,
+					   buf_addr + count_in_sg,
+					   count_in_sg, direction);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static inline unsigned short get_max_width(dma_addr_t ccfg)
+{
+	unsigned short src_width = (ccfg & HIEDMAC_CONTROL_SRC_WIDTH_MASK) >>
+				    HIEDMAC_CONFIG_SRC_WIDTH_SHIFT;
+	unsigned short dst_width = (ccfg & HIEDMAC_CONTROL_DST_WIDTH_MASK) >>
+				    HIEDMAC_CONFIG_DST_WIDTH_SHIFT;
+
+	return 1 << max(src_width, dst_width); /* to byte */
+}
+
+static int hiedmac_fill_asg_lli_for_desc(struct hiedmac_sg *dsg,
+					 struct transfer_desc *tsf_desc,
+					 unsigned int *lli_count)
+{
+	int ret;
+	unsigned short width = get_max_width(tsf_desc->ccfg);
+
+	while (dsg->len != 0) {
+		size_t lli_len = MAX_TRANSFER_BYTES;
+
+		lli_len = (lli_len / width) * width; /* bus width align */
+		lli_len = min(lli_len, dsg->len);
+		ret = hiedmac_fill_desc(dsg, tsf_desc, lli_len, *lli_count);
+		if (ret)
+			return ret;
+
+		if (tsf_desc->ccfg & HIEDMAC_CONFIG_SRC_INC)
+			dsg->src_addr += lli_len;
+		if (tsf_desc->ccfg & HIEDMAC_CONFIG_DST_INC)
+			dsg->dst_addr += lli_len;
+		dsg->len -= lli_len;
+		(*lli_count)++;
+	}
+	return 0;
+}
+
+static int hiedmac_fill_lli_for_desc(struct list_head *sg_head,
+				     struct transfer_desc *tsf_desc)
+{
+	struct hiedmac_sg *dsg = NULL;
+	struct hiedmac_lli *last_plli = NULL;
+	unsigned int lli_count = 0;
+	int ret;
+
+	list_for_each_entry(dsg, sg_head, node) {
+		ret = hiedmac_fill_asg_lli_for_desc(dsg, tsf_desc, &lli_count);
+		if (ret)
+			return ret;
+	}
+
+	if (tsf_desc->cyclic) {
+		last_plli = (struct hiedmac_lli *)((uintptr_t)tsf_desc->llis_vaddr +
+					    (lli_count - 1) * sizeof(*last_plli));
+		last_plli->next_lli = tsf_desc->llis_busaddr | HIEDMAC_LLI_ENABLE;
+	} else {
+		last_plli = (struct hiedmac_lli *)((uintptr_t)tsf_desc->llis_vaddr +
+					    (lli_count - 1) * sizeof(*last_plli));
+		last_plli->next_lli = 0;
+	}
+	dump_lli(tsf_desc->llis_vaddr, lli_count);
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *hiedmac_prep_slave_sg(
+	struct dma_chan *chan, struct scatterlist *sgl,
+	unsigned int sg_len, enum dma_transfer_direction direction,
+	unsigned long flags, void *context)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct transfer_desc *tsf_desc = NULL;
+	dma_addr_t slave_addr = 0;
+	int ret;
+	LIST_HEAD(sg_head);
+
+	if (sgl == NULL) {
+		hiedmacv310_error("sgl is null!");
+		return NULL;
+	}
+
+	tsf_desc = hiedmac_init_tsf_desc(chan, direction, &slave_addr);
+	if (!tsf_desc)
+		return NULL;
+
+	tsf_desc->llis_vaddr = dma_pool_alloc(hiedmac->pool, GFP_NOWAIT,
+					      &tsf_desc->llis_busaddr);
+	if (!tsf_desc->llis_vaddr) {
+		hiedmacv310_error("malloc memory from pool fail !");
+		goto err_alloc_lli;
+	}
+
+	ret = hiedmac_fill_sg_for_slave(&sg_head, slave_addr, sgl, sg_len, direction);
+	if (ret)
+		goto err_fill_sg;
+	ret = hiedmac_fill_lli_for_desc(&sg_head, tsf_desc);
+	free_dsg(&sg_head);
+	if (ret)
+		goto err_fill_sg;
+	return vchan_tx_prep(&edmac_dma_chan->virt_chan, &tsf_desc->virt_desc, flags);
+
+err_fill_sg:
+	dma_pool_free(hiedmac->pool, tsf_desc->llis_vaddr, tsf_desc->llis_busaddr);
+err_alloc_lli:
+	kfree(tsf_desc);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *hiedmac_prep_dma_memcpy(
+	struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
+	size_t len, unsigned long flags)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct transfer_desc *tsf_desc = NULL;
+	LIST_HEAD(sg_head);
+	u32 config = 0;
+	int ret;
+
+	if (!len)
+		return NULL;
+
+	tsf_desc = kzalloc(sizeof(*tsf_desc), GFP_NOWAIT);
+	if (tsf_desc == NULL) {
+		hiedmacv310_error("get tsf desc fail!");
+		return NULL;
+	}
+
+	tsf_desc->llis_vaddr = dma_pool_alloc(hiedmac->pool, GFP_NOWAIT,
+					      &tsf_desc->llis_busaddr);
+	if (!tsf_desc->llis_vaddr) {
+		hiedmacv310_error("malloc memory from pool fail !");
+		goto err_alloc_lli;
+	}
+
+	config |= HIEDMAC_CONFIG_SRC_INC | HIEDMAC_CONFIG_DST_INC;
+	config |= HIEDMAC_CXCONFIG_MEM_TYPE << HIEDMAC_CXCONFIG_TSF_TYPE_SHIFT;
+	/*  max burst width is 16 ,but reg value set 0xf */
+	config |= (HIEDMAC_MAX_BURST_WIDTH - 1) << HIEDMAC_CONFIG_SRC_BURST_SHIFT;
+	config |= (HIEDMAC_MAX_BURST_WIDTH - 1) << HIEDMAC_CONFIG_DST_BURST_SHIFT;
+	config |= HIEDMAC_MEM_BIT_WIDTH << HIEDMAC_CONFIG_SRC_WIDTH_SHIFT;
+	config |= HIEDMAC_MEM_BIT_WIDTH << HIEDMAC_CONFIG_DST_WIDTH_SHIFT;
+	tsf_desc->ccfg = config;
+	ret = hiedmac_fill_sg_for_memcpy(&sg_head, dst, src, len);
+	if (ret)
+		goto err_fill_sg;
+	ret = hiedmac_fill_lli_for_desc(&sg_head, tsf_desc);
+	free_dsg(&sg_head);
+	if (ret)
+		goto err_fill_sg;
+	return vchan_tx_prep(&edmac_dma_chan->virt_chan, &tsf_desc->virt_desc, flags);
+
+err_fill_sg:
+	dma_pool_free(hiedmac->pool, tsf_desc->llis_vaddr, tsf_desc->llis_busaddr);
+err_alloc_lli:
+	kfree(tsf_desc);
+	return NULL;
+}
+
+
+static struct dma_async_tx_descriptor *hiedmac_prep_dma_cyclic(
+	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+	size_t period_len, enum dma_transfer_direction direction,
+	unsigned long flags)
+{
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(chan);
+	struct hiedmacv310_driver_data *hiedmac = edmac_dma_chan->host;
+	struct transfer_desc *tsf_desc = NULL;
+	dma_addr_t slave_addr = 0;
+	LIST_HEAD(sg_head);
+	int ret;
+
+	tsf_desc = hiedmac_init_tsf_desc(chan, direction, &slave_addr);
+	if (!tsf_desc)
+		return NULL;
+
+	tsf_desc->llis_vaddr = dma_pool_alloc(hiedmac->pool, GFP_NOWAIT,
+			&tsf_desc->llis_busaddr);
+	if (!tsf_desc->llis_vaddr) {
+		hiedmacv310_error("malloc memory from pool fail !");
+		goto err_alloc_lli;
+	}
+
+	tsf_desc->cyclic = true;
+	ret = hiedmac_fill_sg_for_cyclic(&sg_head, slave_addr, buf_addr,
+					 buf_len, period_len, direction);
+	if (ret)
+		goto err_fill_sg;
+	ret = hiedmac_fill_lli_for_desc(&sg_head, tsf_desc);
+	free_dsg(&sg_head);
+	if (ret)
+		goto err_fill_sg;
+	return vchan_tx_prep(&edmac_dma_chan->virt_chan, &tsf_desc->virt_desc, flags);
+
+err_fill_sg:
+	dma_pool_free(hiedmac->pool, tsf_desc->llis_vaddr, tsf_desc->llis_busaddr);
+err_alloc_lli:
+	kfree(tsf_desc);
+	return NULL;
+}
+
+static void hiedmac_phy_reassign(struct hiedmacv310_phy_chan *phy_chan,
+				 struct hiedmacv310_dma_chan *chan)
+{
+	phy_chan->serving = chan;
+	chan->phychan = phy_chan;
+	chan->state = HIEDMAC_CHAN_RUNNING;
+
+	hiedmac_start_next_txd(chan);
+}
+
+static void hiedmac_terminate_phy_chan(struct hiedmacv310_driver_data *hiedmac,
+				       const struct hiedmacv310_dma_chan *edmac_dma_chan)
+{
+	unsigned int val;
+	struct hiedmacv310_phy_chan *phychan = edmac_dma_chan->phychan;
+
+	hiedmac_pause_phy_chan(edmac_dma_chan);
+	val = 0x1 << phychan->id;
+	hiedmacv310_writel(val, hiedmac->base + HIEDMAC_INT_TC1_RAW);
+	hiedmacv310_writel(val, hiedmac->base + HIEDMAC_INT_ERR1_RAW);
+	hiedmacv310_writel(val, hiedmac->base + HIEDMAC_INT_ERR2_RAW);
+}
+
+void hiedmac_phy_free(struct hiedmacv310_dma_chan *chan)
+{
+	struct hiedmacv310_driver_data *hiedmac = chan->host;
+	struct hiedmacv310_dma_chan *p = NULL;
+	struct hiedmacv310_dma_chan *next = NULL;
+
+	list_for_each_entry(p, &hiedmac->memcpy.channels, virt_chan.chan.device_node) {
+		if (p->state == HIEDMAC_CHAN_WAITING) {
+			next = p;
+			break;
+		}
+	}
+
+	if (!next) {
+		list_for_each_entry(p, &hiedmac->slave.channels, virt_chan.chan.device_node) {
+			if (p->state == HIEDMAC_CHAN_WAITING) {
+				next = p;
+				break;
+			}
+		}
+	}
+	hiedmac_terminate_phy_chan(hiedmac, chan);
+
+	if (next) {
+		spin_lock(&next->virt_chan.lock);
+		hiedmac_phy_reassign(chan->phychan, next);
+		spin_unlock(&next->virt_chan.lock);
+	} else {
+		chan->phychan->serving = NULL;
+	}
+
+	chan->phychan = NULL;
+	chan->state = HIEDMAC_CHAN_IDLE;
+}
+
+bool handle_irq(struct hiedmacv310_driver_data *hiedmac, int chan_id)
+{
+	struct hiedmacv310_dma_chan *chan = NULL;
+	struct hiedmacv310_phy_chan *phy_chan = NULL;
+	struct transfer_desc *tsf_desc = NULL;
+	unsigned int channel_tc_status;
+
+	phy_chan = &hiedmac->phy_chans[chan_id];
+	chan = phy_chan->serving;
+	if (!chan) {
+		hiedmacv310_error("error interrupt on chan: %d!", chan_id);
+		return 0;
+	}
+	tsf_desc = chan->at;
+
+	channel_tc_status = hiedmacv310_readl(hiedmac->base + HIEDMAC_INT_TC1_RAW);
+	channel_tc_status = (channel_tc_status >> chan_id) & 0x01;
+	if (channel_tc_status)
+		hiedmacv310_writel(channel_tc_status << chan_id,
+				   hiedmac->base + HIEDMAC_INT_TC1_RAW);
+
+	channel_tc_status = hiedmacv310_readl(hiedmac->base + HIEDMAC_INT_TC2);
+	channel_tc_status = (channel_tc_status >> chan_id) & 0x01;
+	if (channel_tc_status)
+		hiedmacv310_writel(channel_tc_status << chan_id,
+				   hiedmac->base + HIEDMAC_INT_TC2_RAW);
+
+	if ((hiedmacv310_readl(hiedmac->base + HIEDMAC_INT_ERR1) |
+	    hiedmacv310_readl(hiedmac->base + HIEDMAC_INT_ERR2) |
+	    hiedmacv310_readl(hiedmac->base + HIEDMAC_INT_ERR3)) &
+	    (1 << chan_id)) {
+		hiedmacv310_error("Error in hiedmac %d finish!,ERR1 = 0x%x,ERR2 = 0x%x,ERR3 = 0x%x",
+				  i, channel_err_status[0],
+				  channel_err_status[1], channel_err_status[2]);
+		hiedmacv310_writel(1 << chan_id, hiedmac->base + HIEDMAC_INT_ERR1_RAW);
+		hiedmacv310_writel(1 << chan_id, hiedmac->base + HIEDMAC_INT_ERR2_RAW);
+		hiedmacv310_writel(1 << chan_id, hiedmac->base + HIEDMAC_INT_ERR3_RAW);
+	}
+
+	spin_lock(&chan->virt_chan.lock);
+
+	if (tsf_desc->cyclic) {
+		vchan_cyclic_callback(&tsf_desc->virt_desc);
+		spin_unlock(&chan->virt_chan.lock);
+		return 1;
+	}
+	chan->at = NULL;
+	tsf_desc->done = true;
+	vchan_cookie_complete(&tsf_desc->virt_desc);
+
+	if (vchan_next_desc(&chan->virt_chan))
+		hiedmac_start_next_txd(chan);
+	else
+		hiedmac_phy_free(chan);
+	spin_unlock(&chan->virt_chan.lock);
+	return 1;
+}
+
+static irqreturn_t hiemdacv310_irq(int irq, void *dev)
+{
+	struct hiedmacv310_driver_data *hiedmac = (struct hiedmacv310_driver_data *)dev;
+	u32 mask = 0;
+	unsigned int channel_status, temp, i;
+
+	channel_status = hiedmacv310_readl(hiedmac->base + HIEDMAC_INT_STAT);
+	if (!channel_status) {
+		hiedmacv310_error("channel_status = 0x", channel_status);
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < hiedmac->channels; i++) {
+		temp = (channel_status >> i) & 0x1;
+		if (temp)
+			mask |= handle_irq(hiedmac, i) << i;
+	}
+	return mask ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static inline void hiedmac_dma_slave_init(struct hiedmacv310_dma_chan *chan)
+{
+	chan->slave = true;
+}
+
+static void hiedmac_desc_free(struct virt_dma_desc *vd)
+{
+	struct transfer_desc *tsf_desc = to_edmac_transfer_desc(&vd->tx);
+	struct hiedmacv310_dma_chan *edmac_dma_chan = to_edamc_chan(vd->tx.chan);
+
+	dma_descriptor_unmap(&vd->tx);
+	dma_pool_free(edmac_dma_chan->host->pool, tsf_desc->llis_vaddr, tsf_desc->llis_busaddr);
+	kfree(tsf_desc);
+}
+
+static int hiedmac_init_virt_channels(struct hiedmacv310_driver_data *hiedmac,
+				      struct dma_device *dmadev,
+				      unsigned int channels, bool slave)
+{
+	struct hiedmacv310_dma_chan *chan = NULL;
+	int i;
+
+	INIT_LIST_HEAD(&dmadev->channels);
+	for (i = 0; i < channels; i++) {
+		chan = kzalloc(sizeof(struct hiedmacv310_dma_chan), GFP_KERNEL);
+		if (!chan) {
+			hiedmacv310_error("fail to allocate memory for virt channels!");
+			return -1;
+		}
+
+		chan->host = hiedmac;
+		chan->state = HIEDMAC_CHAN_IDLE;
+		chan->signal = -1;
+
+		if (slave) {
+			chan->id = i;
+			hiedmac_dma_slave_init(chan);
+		}
+		chan->virt_chan.desc_free = hiedmac_desc_free;
+		vchan_init(&chan->virt_chan, dmadev);
+	}
+	return 0;
+}
+
+void hiedmac_free_virt_channels(struct dma_device *dmadev)
+{
+	struct hiedmacv310_dma_chan *chan = NULL;
+	struct hiedmacv310_dma_chan *next = NULL;
+
+	list_for_each_entry_safe(chan, next, &dmadev->channels, virt_chan.chan.device_node) {
+		list_del(&chan->virt_chan.chan.device_node);
+		kfree(chan);
+	}
+}
+
+static void hiedmacv310_prep_dma_device(struct platform_device *pdev,
+					struct hiedmacv310_driver_data *hiedmac)
+{
+	dma_cap_set(DMA_MEMCPY, hiedmac->memcpy.cap_mask);
+	hiedmac->memcpy.dev = &pdev->dev;
+	hiedmac->memcpy.device_free_chan_resources = hiedmac_free_chan_resources;
+	hiedmac->memcpy.device_prep_dma_memcpy = hiedmac_prep_dma_memcpy;
+	hiedmac->memcpy.device_tx_status = hiedmac_tx_status;
+	hiedmac->memcpy.device_issue_pending = hiedmac_issue_pending;
+	hiedmac->memcpy.device_config = hiedmac_config;
+	hiedmac->memcpy.device_pause = hiedmac_pause;
+	hiedmac->memcpy.device_resume = hiedmac_resume;
+	hiedmac->memcpy.device_terminate_all = hiedmac_terminate_all;
+	hiedmac->memcpy.directions = BIT(DMA_MEM_TO_MEM);
+	hiedmac->memcpy.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+
+	dma_cap_set(DMA_SLAVE, hiedmac->slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, hiedmac->slave.cap_mask);
+	hiedmac->slave.dev = &pdev->dev;
+	hiedmac->slave.device_free_chan_resources = hiedmac_free_chan_resources;
+	hiedmac->slave.device_tx_status = hiedmac_tx_status;
+	hiedmac->slave.device_issue_pending = hiedmac_issue_pending;
+	hiedmac->slave.device_prep_slave_sg = hiedmac_prep_slave_sg;
+	hiedmac->slave.device_prep_dma_cyclic = hiedmac_prep_dma_cyclic;
+	hiedmac->slave.device_config = hiedmac_config;
+	hiedmac->slave.device_resume = hiedmac_resume;
+	hiedmac->slave.device_pause = hiedmac_pause;
+	hiedmac->slave.device_terminate_all = hiedmac_terminate_all;
+	hiedmac->slave.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	hiedmac->slave.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+}
+
+static int hiedmacv310_init_chan(struct hiedmacv310_driver_data *hiedmac)
+{
+	int i, ret;
+
+	hiedmac->phy_chans = kzalloc((hiedmac->channels * sizeof(
+				     struct hiedmacv310_phy_chan)),
+				     GFP_KERNEL);
+	if (!hiedmac->phy_chans) {
+		hiedmacv310_error("malloc for phy chans fail!");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < hiedmac->channels; i++) {
+		struct hiedmacv310_phy_chan *phy_ch = &hiedmac->phy_chans[i];
+
+		phy_ch->id = i;
+		phy_ch->base = hiedmac->base + hiedmac_cx_base(i);
+		spin_lock_init(&phy_ch->lock);
+		phy_ch->serving = NULL;
+	}
+
+	ret = hiedmac_init_virt_channels(hiedmac, &hiedmac->memcpy, hiedmac->channels,
+					 false);
+	if (ret) {
+		hiedmacv310_error("fail to init memory virt channels!");
+		goto  free_phychans;
+	}
+
+	ret = hiedmac_init_virt_channels(hiedmac, &hiedmac->slave, hiedmac->slave_requests,
+					 true);
+	if (ret) {
+		hiedmacv310_error("fail to init slave virt channels!");
+		goto  free_memory_virt_channels;
+	}
+	return 0;
+
+free_memory_virt_channels:
+	hiedmac_free_virt_channels(&hiedmac->memcpy);
+free_phychans:
+	kfree(hiedmac->phy_chans);
+	return -ENOMEM;
+}
+
+static void hiedmacv310_free_chan(struct hiedmacv310_driver_data *hiedmac)
+{
+	hiedmac_free_virt_channels(&hiedmac->slave);
+	hiedmac_free_virt_channels(&hiedmac->memcpy);
+	kfree(hiedmac->phy_chans);
+}
+
+static void hiedmacv310_prep_phy_device(const struct hiedmacv310_driver_data *hiedmac)
+{
+	clk_prepare_enable(hiedmac->clk);
+	clk_prepare_enable(hiedmac->axi_clk);
+	reset_control_deassert(hiedmac->rstc);
+
+	hiedmacv310_writel(HIEDMAC_ALL_CHAN_CLR, hiedmac->base + HIEDMAC_INT_TC1_RAW);
+	hiedmacv310_writel(HIEDMAC_ALL_CHAN_CLR, hiedmac->base + HIEDMAC_INT_TC2_RAW);
+	hiedmacv310_writel(HIEDMAC_ALL_CHAN_CLR, hiedmac->base + HIEDMAC_INT_ERR1_RAW);
+	hiedmacv310_writel(HIEDMAC_ALL_CHAN_CLR, hiedmac->base + HIEDMAC_INT_ERR2_RAW);
+	hiedmacv310_writel(HIEDMAC_ALL_CHAN_CLR, hiedmac->base + HIEDMAC_INT_ERR3_RAW);
+	hiedmacv310_writel(HIEDMAC_INT_ENABLE_ALL_CHAN,
+			   hiedmac->base + HIEDMAC_INT_TC1_MASK);
+	hiedmacv310_writel(HIEDMAC_INT_ENABLE_ALL_CHAN,
+			   hiedmac->base + HIEDMAC_INT_TC2_MASK);
+	hiedmacv310_writel(HIEDMAC_INT_ENABLE_ALL_CHAN,
+			   hiedmac->base + HIEDMAC_INT_ERR1_MASK);
+	hiedmacv310_writel(HIEDMAC_INT_ENABLE_ALL_CHAN,
+			   hiedmac->base + HIEDMAC_INT_ERR2_MASK);
+	hiedmacv310_writel(HIEDMAC_INT_ENABLE_ALL_CHAN,
+			   hiedmac->base + HIEDMAC_INT_ERR3_MASK);
+}
+
+static struct hiedmacv310_driver_data *hiedmacv310_prep_hiedmac_device(struct platform_device *pdev)
+{
+	int ret;
+	struct hiedmacv310_driver_data *hiedmac = NULL;
+	ssize_t transfer_size;
+
+	ret = dma_set_mask_and_coherent(&(pdev->dev), DMA_BIT_MASK(64));
+	if (ret)
+		return NULL;
+
+	hiedmac = kzalloc(sizeof(*hiedmac), GFP_KERNEL);
+	if (!hiedmac) {
+		hiedmacv310_error("malloc for hiedmac fail!");
+		return NULL;
+	}
+
+	hiedmac->dev = pdev;
+
+	ret = get_of_probe(hiedmac);
+	if (ret) {
+		hiedmacv310_error("get dts info fail!");
+		goto free_hiedmac;
+	}
+
+	hiedmacv310_prep_dma_device(pdev, hiedmac);
+	hiedmac->max_transfer_size = MAX_TRANSFER_BYTES;
+	transfer_size = MAX_TSFR_LLIS * EDMACV300_LLI_WORDS * sizeof(u32);
+
+	hiedmac->pool = dma_pool_create(DRIVER_NAME, &(pdev->dev),
+					transfer_size, EDMACV300_POOL_ALIGN, 0);
+	if (!hiedmac->pool) {
+		hiedmacv310_error("create pool fail!");
+		goto free_hiedmac;
+	}
+
+	ret = hiedmacv310_init_chan(hiedmac);
+	if (ret)
+		goto free_pool;
+
+	return hiedmac;
+
+free_pool:
+	dma_pool_destroy(hiedmac->pool);
+free_hiedmac:
+	kfree(hiedmac);
+	return NULL;
+}
+
+static void free_hiedmac_device(struct hiedmacv310_driver_data *hiedmac)
+{
+	hiedmacv310_free_chan(hiedmac);
+	dma_pool_destroy(hiedmac->pool);
+	kfree(hiedmac);
+}
+
+static int __init hiedmacv310_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct hiedmacv310_driver_data *hiedmac = NULL;
+
+	hiedmac = hiedmacv310_prep_hiedmac_device(pdev);
+	if (hiedmac == NULL)
+		return -ENOMEM;
+
+	ret = request_irq(hiedmac->irq, hiemdacv310_irq, 0, DRIVER_NAME, hiedmac);
+	if (ret) {
+		hiedmacv310_error("fail to request irq");
+		goto free_hiedmac;
+	}
+	hiedmacv310_prep_phy_device(hiedmac);
+	ret = dma_async_device_register(&hiedmac->memcpy);
+	if (ret) {
+		hiedmacv310_error("%s failed to register memcpy as an async device - %d",
+				  __func__, ret);
+		goto free_irq_res;
+	}
+
+	ret = dma_async_device_register(&hiedmac->slave);
+	if (ret) {
+		hiedmacv310_error("%s failed to register slave as an async device - %d",
+				  __func__, ret);
+		goto free_memcpy_device;
+	}
+	return 0;
+
+free_memcpy_device:
+	dma_async_device_unregister(&hiedmac->memcpy);
+free_irq_res:
+	free_irq(hiedmac->irq, hiedmac);
+free_hiedmac:
+	free_hiedmac_device(hiedmac);
+	return -ENOMEM;
+}
+
+static int hiemda_remove(struct platform_device *pdev)
+{
+	int err = 0;
+	return err;
+}
+
+static const struct of_device_id hiedmacv310_match[] = {
+	{ .compatible = "hisilicon,hiedmacv310" },
+	{},
+};
+
+static struct platform_driver hiedmacv310_driver = {
+	.remove = hiemda_remove,
+	.driver = {
+		.name = "hiedmacv310",
+		.of_match_table = hiedmacv310_match,
+	},
+};
+
+static int __init hiedmacv310_init(void)
+{
+	return platform_driver_probe(&hiedmacv310_driver, hiedmacv310_probe);
+}
+subsys_initcall(hiedmacv310_init);
+
+static void __exit hiedmacv310_exit(void)
+{
+	platform_driver_unregister(&hiedmacv310_driver);
+}
+module_exit(hiedmacv310_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hisilicon");
diff --git a/drivers/dma/hiedmacv310.h b/drivers/dma/hiedmacv310.h
new file mode 100644
index 000000000000..99e1720263e3
--- /dev/null
+++ b/drivers/dma/hiedmacv310.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The Hiedma Controller v310 Device Driver for HiSilicon
+ *
+ * Copyright (c) 2019-2020, Huawei Tech. Co., Ltd.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
+ */
+#ifndef __HIEDMACV310_H__
+#define __HIEDMACV310_H__
+
+/* debug control */
+#define HIEDMACV310_CONFIG_TRACE_LEVEL 3
+#define HIEDMACV310_TRACE_LEVEL 0
+#define HIEDMACV310_REG_TRACE_LEVEL 3
+
+#ifdef DEBUG_HIEDMAC
+#define hiedmacv310_trace(level, msg, a...) do { \
+	if ((level) >= HIEDMACV310_TRACE_LEVEL) { \
+		pr_info("%s: %d: " msg,  __func__, __LINE__, ## a); \
+	} \
+} while (0)
+
+#define hiedmacv310_assert(cond) do { \
+	if (!(cond)) { \
+		pr_info("Assert:hiedmacv310:%s:%d\n", \
+				__func__, \
+				__LINE__); \
+		__WARN(); \
+	} \
+} while (0)
+
+#define hiedmacv310_error(s, a...) \
+	pr_err("hiedmacv310:%s:%d: " s, __func__, __LINE__, ## a)
+
+#define hiedmacv310_info(s, a...) \
+	pr_info("hiedmacv310:%s:%d: " s, __func__, __LINE__, ## a)
+
+#else
+
+#define hiedmacv310_trace(level, msg, a...)
+#define hiedmacv310_assert(cond)
+#define hiedmacv310_error(s, a...)
+
+#endif
+
+
+#define hiedmacv310_readl(addr) ((unsigned int)readl((void *)(addr)))
+
+#define hiedmacv310_writel(v, addr) writel(v, (void *)(addr))
+
+
+#define MAX_TRANSFER_BYTES  0xffff
+
+/* reg offset */
+#define HIEDMAC_INT_STAT                  0x0
+#define HIEDMAC_INT_TC1                   0x4
+#define HIEDMAC_INT_TC2                   0x8
+#define HIEDMAC_INT_ERR1                  0xc
+#define HIEDMAC_INT_ERR2                  0x10
+#define HIEDMAC_INT_ERR3                  0x14
+
+#define HIEDMAC_INT_TC1_MASK              0x18
+#define HIEDMAC_INT_TC2_MASK              0x1c
+#define HIEDMAC_INT_ERR1_MASK             0x20
+#define HIEDMAC_INT_ERR2_MASK             0x24
+#define HIEDMAC_INT_ERR3_MASK             0x28
+
+#define HIEDMAC_INT_TC1_RAW               0x600
+#define HIEDMAC_INT_TC2_RAW               0x608
+#define HIEDMAC_INT_ERR1_RAW              0x610
+#define HIEDMAC_INT_ERR2_RAW              0x618
+#define HIEDMAC_INT_ERR3_RAW              0x620
+
+#define hiedmac_cx_curr_cnt0(cn)          (0x404 + (cn) * 0x20)
+#define hiedmac_cx_curr_src_addr_l(cn)    (0x408 + (cn) * 0x20)
+#define hiedmac_cx_curr_src_addr_h(cn)    (0x40c + (cn) * 0x20)
+#define hiedmac_cx_curr_dest_addr_l(cn)    (0x410 + (cn) * 0x20)
+#define hiedmac_cx_curr_dest_addr_h(cn)    (0x414 + (cn) * 0x20)
+
+#define HIEDMAC_CH_PRI                    0x688
+#define HIEDMAC_CH_STAT                   0x690
+#define HIEDMAC_DMA_CTRL                  0x698
+
+#define hiedmac_cx_base(cn)               (0x800 + (cn) * 0x40)
+#define hiedmac_cx_lli_l(cn)              (0x800 + (cn) * 0x40)
+#define hiedmac_cx_lli_h(cn)              (0x804 + (cn) * 0x40)
+#define hiedmac_cx_cnt0(cn)               (0x81c + (cn) * 0x40)
+#define hiedmac_cx_src_addr_l(cn)         (0x820 + (cn) * 0x40)
+#define hiedmac_cx_src_addr_h(cn)         (0x824 + (cn) * 0x40)
+#define hiedmac_cx_dest_addr_l(cn)        (0x828 + (cn) * 0x40)
+#define hiedmac_cx_dest_addr_h(cn)        (0x82c + (cn) * 0x40)
+#define hiedmac_cx_config(cn)             (0x830 + (cn) * 0x40)
+
+#define HIEDMAC_ALL_CHAN_CLR        0xff
+#define HIEDMAC_INT_ENABLE_ALL_CHAN 0xff
+
+
+#define HIEDMAC_CONFIG_SRC_INC          (1 << 31)
+#define HIEDMAC_CONFIG_DST_INC          (1 << 30)
+
+#define HIEDMAC_CONFIG_SRC_WIDTH_SHIFT  16
+#define HIEDMAC_CONFIG_DST_WIDTH_SHIFT  12
+#define HIEDMAC_WIDTH_8BIT              0b0
+#define HIEDMAC_WIDTH_16BIT             0b1
+#define HIEDMAC_WIDTH_32BIT             0b10
+#define HIEDMAC_WIDTH_64BIT             0b11
+#ifdef CONFIG_64BIT
+#define HIEDMAC_MEM_BIT_WIDTH HIEDMAC_WIDTH_64BIT
+#else
+#define HIEDMAC_MEM_BIT_WIDTH HIEDMAC_WIDTH_32BIT
+#endif
+
+#define HIEDMAC_MAX_BURST_WIDTH         16
+#define HIEDMAC_MIN_BURST_WIDTH         1
+#define HIEDMAC_CONFIG_SRC_BURST_SHIFT  24
+#define HIEDMAC_CONFIG_DST_BURST_SHIFT  20
+
+#define HIEDMAC_LLI_ALIGN   0x40
+#define HIEDMAC_LLI_DISABLE 0x0
+#define HIEDMAC_LLI_ENABLE 0x2
+
+#define HIEDMAC_CXCONFIG_SIGNAL_SHIFT   0x4
+#define HIEDMAC_CXCONFIG_MEM_TYPE       0x0
+#define HIEDMAC_CXCONFIG_DEV_MEM_TYPE   0x1
+#define HIEDMAC_CXCONFIG_TSF_TYPE_SHIFT 0x2
+#define HIEDMAC_CXCONFIG_LLI_START      0x1
+
+#define HIEDMAC_CXCONFIG_ITC_EN     0x1
+#define HIEDMAC_CXCONFIG_ITC_EN_SHIFT   0x1
+
+#define CCFG_EN 0x1
+
+#define HIEDMAC_CONTROL_SRC_WIDTH_MASK GENMASK(18, 16)
+#define HIEDMAC_CONTROL_DST_WIDTH_MASK GENMASK(14, 12)
+#endif
-- 
2.17.1

