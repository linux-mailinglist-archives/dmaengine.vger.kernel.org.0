Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF841FC889
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 10:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQI0p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 04:26:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:54097 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQI0p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 04:26:45 -0400
IronPort-SDR: DPFOic3SarYny8Xcng2K4dBCmW2xcZKsQJJgFF/8G7OxkVY8K6935NW8zXhHkA0Xj3Ayew6ekE
 KBWm9UOwPxug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:26:25 -0700
IronPort-SDR: nAO8WL7rY7hDjqx56kOh49EijfijxAzHG0a0fnQhDgM3NqqaJdBQnEzpIc7Da1rGb6Soc4VLx8
 VkfR+GUKq4Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="352010023"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2020 01:26:22 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, malliamireddy009@gmail.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Subject: [PATCH v2 2/2] Add Intel LGM soc DMA support.
Date:   Wed, 17 Jun 2020 16:24:30 +0800
Message-Id: <d9683495140b4f93df5070eba0a8f3bdd4e762b3.1592381244.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.

The main function of the DMA controller is the transfer of data from/to any
DPlus compliant peripheral to/from the memory. A memory to memory copy
capability can also be configured.

This ldma driver is used for configure the device and channnels for data
and control paths.

Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
---
v1:
- Initial version.

v2:
- Fix device tree bot issues, correspondign driver changes done.
- Fix kerntel test robot warnings.
  --------------------------------------------------------
  >> drivers/dma/lgm/lgm-dma.c:729:5: warning: no previous prototype for function 'intel_dma_chan_desc_cfg' [-Wmissing-prototypes]
  int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
  ^
  drivers/dma/lgm/lgm-dma.c:729:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
  ^
  static
  1 warning generated.

  vim +/intel_dma_chan_desc_cfg +729 drivers/dma/lgm/lgm-dma.c

    728
  > 729 int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
    730                             int desc_num)
    731 {
    732         return ldma_chan_desc_cfg(to_ldma_chan(chan), desc_base, desc_num);
    733 }
    734 EXPORT_SYMBOL_GPL(intel_dma_chan_desc_cfg);
    735

    Reported-by: kernel test robot <lkp@intel.com>
   ---------------------------------------------------------------
---
 drivers/dma/Kconfig         |    2 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/lgm/Kconfig     |    9 +
 drivers/dma/lgm/Makefile    |    2 +
 drivers/dma/lgm/lgm-dma.c   | 1956 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma/lgm_dma.h |   27 +
 6 files changed, 1997 insertions(+)
 create mode 100644 drivers/dma/lgm/Kconfig
 create mode 100644 drivers/dma/lgm/Makefile
 create mode 100644 drivers/dma/lgm/lgm-dma.c
 create mode 100644 include/linux/dma/lgm_dma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de41d7928bff..caeaf12fd524 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -737,6 +737,8 @@ source "drivers/dma/ti/Kconfig"
 
 source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
+source "drivers/dma/lgm/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index e60f81331d4c..0b899b076f4e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
+obj-$(CONFIG_INTEL_LDMA) += lgm/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/lgm/Kconfig b/drivers/dma/lgm/Kconfig
new file mode 100644
index 000000000000..bdb5b0d91afb
--- /dev/null
+++ b/drivers/dma/lgm/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTEL_LDMA
+	bool "Lightning Mountain centralized low speed DMA and high speed DMA controllers"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for intel Lightning Mountain SOC DMA controllers.
+	  These controllers provide DMA capabilities for a variety of on-chip
+	  devices such as SSC, HSNAND and GSWIP.
diff --git a/drivers/dma/lgm/Makefile b/drivers/dma/lgm/Makefile
new file mode 100644
index 000000000000..f318a8eff464
--- /dev/null
+++ b/drivers/dma/lgm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INTEL_LDMA)	+= lgm-dma.o
diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
new file mode 100644
index 000000000000..d7dcb573473e
--- /dev/null
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -0,0 +1,1956 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lightning Mountain centralized low speed and high speed DMA controller driver
+ *
+ * Copyright (c) 2016 ~ 2020 Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/dma/lgm_dma.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+
+#define DRIVER_NAME			"lgm-ldma"
+
+#define DMA_ID				0x0008
+#define DMA_ID_REV			GENMASK(7, 0)
+#define DMA_ID_PNR			GENMASK(19, 16)
+#define DMA_ID_CHNR			GENMASK(26, 20)
+#define DMA_ID_DW_128B			BIT(27)
+#define DMA_ID_AW_36B			BIT(28)
+#define DMA_VER32			0x32
+#define DMA_VER31			0x31
+#define DMA_VER22			0x0A
+
+#define DMA_CTRL			0x0010
+#define DMA_CTRL_RST			BIT(0)
+#define DMA_CTRL_DSRAM_PATH		BIT(1)
+#define DMA_CTRL_DBURST_WR		BIT(3)
+#define DMA_CTRL_VLD_DF_ACK		BIT(4)
+#define DMA_CTRL_CH_FL			BIT(6)
+#define DMA_CTRL_DS_FOD			BIT(7)
+#define DMA_CTRL_DRB			BIT(8)
+#define DMA_CTRL_ENBE			BIT(9)
+#define DMA_CTRL_DESC_TMOUT_CNT_V31	GENMASK(27, 16)
+#define DMA_CTRL_DESC_TMOUT_EN_V31	BIT(30)
+#define DMA_CTRL_PKTARB			BIT(31)
+
+#define DMA_CPOLL			0x0014
+#define DMA_CPOLL_CNT			GENMASK(15, 4)
+#define DMA_CPOLL_EN			BIT(31)
+
+#define DMA_CS				0x0018
+#define DMA_CS_MASK			GENMASK(5, 0)
+
+#define DMA_CCTRL			0x001C
+#define DMA_CCTRL_ON			BIT(0)
+#define DMA_CCTRL_RST			BIT(1)
+#define DMA_CCTRL_CH_POLL_EN		BIT(2)
+#define DMA_CCTRL_CH_ABC		BIT(3) /* Adaptive Burst Chop */
+#define DMA_CDBA_MSB			GENMASK(7, 4)
+#define DMA_CCTRL_DIR_TX		BIT(8)
+#define DMA_CCTRL_CLASS			GENMASK(11, 9)
+#define DMA_CCTRL_CLASSH		GENMASK(19, 18)
+#define DMA_CCTRL_WR_NP_EN		BIT(21)
+#define DMA_CCTRL_PDEN			BIT(23)
+#define DMA_MAX_CLASS			(SZ_32 - 1)
+
+#define DMA_CDBA			0x0020
+#define DMA_CDLEN			0x0024
+#define DMA_CIS				0x0028
+#define DMA_CIE				0x002C
+#define DMA_CI_EOP			BIT(1)
+#define DMA_CI_DUR			BIT(2)
+#define DMA_CI_DESCPT			BIT(3)
+#define DMA_CI_CHOFF			BIT(4)
+#define DMA_CI_RDERR			BIT(5)
+#define DMA_CI_ALL							\
+	(DMA_CI_EOP | DMA_CI_DUR | DMA_CI_DESCPT | DMA_CI_CHOFF | DMA_CI_RDERR)
+
+#define DMA_PS				0x0040
+#define DMA_PCTRL			0x0044
+#define DMA_PCTRL_RXBL16		BIT(0)
+#define DMA_PCTRL_TXBL16		BIT(1)
+#define DMA_PCTRL_RXBL			GENMASK(3, 2)
+#define DMA_PCTRL_RXBL_8		3
+#define DMA_PCTRL_TXBL			GENMASK(5, 4)
+#define DMA_PCTRL_TXBL_8		3
+#define DMA_PCTRL_PDEN			BIT(6)
+#define DMA_PCTRL_RXBL32		BIT(7)
+#define DMA_PCTRL_RXENDI		GENMASK(9, 8)
+#define DMA_PCTRL_TXENDI		GENMASK(11, 10)
+#define DMA_PCTRL_TXBL32		BIT(15)
+#define DMA_PCTRL_MEM_FLUSH		BIT(16)
+
+#define DMA_IRNEN1			0x00E8
+#define DMA_IRNCR1			0x00EC
+#define DMA_IRNEN			0x00F4
+#define DMA_IRNCR			0x00F8
+#define DMA_C_DP_TICK			0x100
+#define DMA_C_DP_TICK_TIKNARB		GENMASK(15, 0)
+#define DMA_C_DP_TICK_TIKARB		GENMASK(31, 16)
+
+#define DMA_C_HDRM			0x110
+/*
+ * If header mode is set in DMA descriptor,
+ *   If bit 30 is disabled, HDR_LEN must be configured according to channel
+ *     requirement.
+ *   If bit 30 is enabled(checksum with heade mode), HDR_LEN has no need to
+ *     be configured. It will enable check sum for switch
+ * If header mode is not set in DMA descriptor,
+ *   This register setting doesn't matter
+ */
+#define DMA_C_HDRM_HDR_SUM		BIT(30)
+
+#define DMA_C_BOFF			0x120
+#define DMA_C_BOFF_BOF_LEN		GENMASK(7, 0)
+#define DMA_C_BOFF_EN			BIT(31)
+
+#define DMA_ORRC			0x190
+#define DMA_ORRC_ORRCNT			GENMASK(8, 4)
+#define DMA_ORRC_EN			BIT(31)
+
+#define DMA_C_ENDIAN			0x200
+#define DMA_C_END_DATAENDI		GENMASK(1, 0)
+#define DMA_C_END_DE_EN			BIT(7)
+#define DMA_C_END_DESENDI		GENMASK(9, 8)
+#define DMA_C_END_DES_EN		BIT(16)
+
+/* DMA controller capability */
+#define DMA_ADDR_36BIT			BIT(0)
+#define DMA_DATA_128BIT			BIT(1)
+#define DMA_CHAN_FLOW_CTL		BIT(2)
+#define DMA_DESC_FTOD			BIT(3)
+#define DMA_DESC_IN_SRAM		BIT(4)
+#define DMA_EN_BYTE_EN			BIT(5)
+#define DMA_DBURST_WR			BIT(6)
+#define DMA_VLD_FETCH_ACK		BIT(7)
+#define DMA_DFT_DRB			BIT(8)
+
+#define DMA_ORRC_MAX_CNT		(SZ_32 - 1)
+#define DMA_DFT_POLL_CNT		SZ_4
+
+#define DMA_DFT_BURST_V22		2
+#define DMA_BURSTL_8DW			8
+#define DMA_BURSTL_16DW			16
+#define DMA_BURSTL_32DW			32
+#define DMA_DFT_BURST			DMA_BURSTL_16DW
+
+#define DMA_MAX_DESC_NUM		(SZ_8K - 1)
+#define DMA_MAX_PKT_SZ			(SZ_16K - 1)
+#define DMA_PKT_SZ_DFT			SZ_2K
+#define DMA_CHAN_BOFF_MAX		(SZ_256 - 1)
+
+#define DMA_DFT_ENDIAN			DMA_ENDIAN_TYPE0
+#define DMA_ENDIAN_MAX			DMA_ENDIAN_TYPE3
+
+#define DMA_DFT_DESC_TCNT		50
+#define DMA_HDR_LEN_MAX			(SZ_16K - 1)
+
+/* DMA flags */
+#define DMA_TX_CH			BIT(0)
+#define DMA_RX_CH			BIT(1)
+#define DEVICE_ALLOC_DESC		BIT(2)
+#define CHAN_IN_USE			BIT(3)
+#define DMA_HW_DESC			BIT(4)
+
+#define DMA_CHAN_RST			1
+#define DMA_TX_PORT_DFT_WGT		1
+#define DMA_DFT_DESC_NUM		1
+#define DMA_MAX_SIZE			(BIT(16) - 1)
+#define MAX_LOWER_CHANS			32
+#define MASK_LOWER_CHANS		GENMASK(4, 0)
+#define DMA_OWN				1
+
+enum ldma_chan_on_off {
+	DMA_CH_OFF = 0,
+	DMA_CH_ON = 1,
+};
+
+enum ldma_pkt_drop {
+	DMA_PKT_DROP_DIS = 0,
+	DMA_PKT_DROP_EN,
+};
+
+enum ldma_endian {
+	DMA_ENDIAN_TYPE0 = 0,
+	DMA_ENDIAN_TYPE1,
+	DMA_ENDIAN_TYPE2,
+	DMA_ENDIAN_TYPE3,
+};
+
+enum {
+	DMA_TYPE_TX = 0,
+	DMA_TYPE_RX,
+	DMA_TYPE_MCPY,
+};
+
+struct ldma_dev;
+struct ldma_port;
+struct ldma_chan {
+	struct ldma_port	*port; /* back pointer */
+	char			name[8]; /* Channel name */
+	struct virt_dma_chan	vchan;
+	int			nr; /* Channel id in hardware */
+	u32			flags; /* central way or channel based way */
+	enum ldma_chan_on_off	onoff;
+	dma_addr_t		desc_phys;
+	void			*desc_base; /* Virtual address */
+	u32			desc_cnt; /* Number of descriptors */
+	int			rst;
+	u32			pkt_sz;
+	u32			nonarb_cnt;
+	u32			arb_cnt;
+	u32			hdrm_len;
+	bool			hdrm_csum;
+	u32			boff_len;
+	u32			data_endian;
+	u32			desc_endian;
+	bool			pden;
+	bool			desc_rx_np;
+	bool			data_endian_en;
+	bool			desc_endian_en;
+	bool			abc_en;
+	bool			desc_init;
+	struct dma_pool		*desc_pool; /* Descriptors pool */
+	u32			desc_num;
+	struct dw2_desc_sw	*ds;
+	struct work_struct	work;
+};
+
+struct ldma_port {
+	struct ldma_dev		*ldev; /* back pointer */
+	const char		*name;
+	u32			portid;
+	u32			rxbl;
+	u32			txbl;
+	u32			chan_start;
+	u32			chan_sz;
+	u32			txwgt;
+	enum ldma_endian	rxendi;
+	enum ldma_endian	txendi;
+	enum ldma_pkt_drop	pkt_drop;
+	int			flush_memcpy;
+	bool			pden;
+};
+
+/* Instance specific data */
+struct ldma_inst_data {
+	struct dma_dev_ops	*ops;
+	const char	*name;
+	u32 type;
+};
+
+struct ldma_dev {
+	struct device		*dev;
+	void __iomem		*base;
+	struct reset_control	*rst;
+	struct clk		*core_clk;
+	struct dma_device	dma_dev;
+	u32			ver;
+	int			irq;
+	struct ldma_port	*ports;
+	struct ldma_chan	*chans; /* channel list on this DMA or port */
+	spinlock_t		dev_lock; /* Controller register execlusive */
+	u32			chan_nrs;
+	u32			port_nrs;
+	u32			flags;
+	u32			pollcnt;
+	u32			orrc; /* Outstanding read count */
+	const struct ldma_inst_data *inst;
+	struct workqueue_struct *wq;
+};
+
+struct dw2_desc {
+	union {
+		struct {
+			u32 len		:16;
+			u32 res0	:7;
+			u32 bofs	:2;
+			u32 res1	:3;
+			u32 eop		:1;
+			u32 sop		:1;
+			u32 c		:1;
+			u32 own		:1;
+		} __packed field;
+		u32 word;
+	} __packed status;
+	u32 addr;
+} __packed __aligned(8);
+
+struct dw2_desc_sw {
+	struct ldma_chan		*chan;
+	struct dma_async_tx_descriptor	async_tx;
+	dma_addr_t			desc_phys;
+	size_t				desc_cnt;
+	size_t				size;
+	struct dw2_desc			*desc_hw;
+};
+
+struct dma_dev_ops {
+	int (*device_alloc_chan_resources)(struct dma_chan *chan);
+	void (*device_free_chan_resources)(struct dma_chan *chan);
+	int (*device_config)(struct dma_chan *chan,
+			     struct dma_slave_config *config);
+	int (*device_pause)(struct dma_chan *chan);
+	int (*device_resume)(struct dma_chan *chan);
+	int (*device_terminate_all)(struct dma_chan *chan);
+	void (*device_synchronize)(struct dma_chan *chan);
+	enum dma_status (*device_tx_status)(struct dma_chan *chan,
+					    dma_cookie_t cookie,
+					    struct dma_tx_state *txstate);
+	struct dma_async_tx_descriptor *(*device_prep_slave_sg)
+		(struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context);
+	void (*device_issue_pending)(struct dma_chan *chan);
+};
+
+static inline void
+ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
+{
+	u32 old_val, new_val;
+
+	old_val = readl(d->base +  ofs);
+	new_val = (old_val & ~mask) | (val & mask);
+
+	if (new_val != old_val)
+		writel(new_val, d->base + ofs);
+}
+
+static inline struct ldma_chan *to_ldma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct ldma_chan, vchan.chan);
+}
+
+static inline struct ldma_dev *to_ldma_dev(struct dma_device *dma_dev)
+{
+	return container_of(dma_dev, struct ldma_dev, dma_dev);
+}
+
+static inline bool ldma_chan_tx(struct ldma_chan *c)
+{
+	return !!(c->flags & DMA_TX_CH);
+}
+
+static inline bool ldma_chan_is_hw_desc(struct ldma_chan *c)
+{
+	return !!(c->flags & DMA_HW_DESC);
+}
+
+static void ldma_dev_reset(struct ldma_dev *d)
+
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CTRL_RST, DMA_CTRL_RST, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_pkt_arb_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask = DMA_CTRL_PKTARB;
+	u32 val = enable ? DMA_CTRL_PKTARB : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_sram_desc_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask = DMA_CTRL_DSRAM_PATH;
+	u32 val = enable ? DMA_CTRL_DSRAM_PATH : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_chan_flow_ctl_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask, val;
+
+	if (d->inst->type != DMA_TYPE_TX)
+		return;
+
+	mask = DMA_CTRL_CH_FL;
+	val = enable ? DMA_CTRL_CH_FL : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_global_polling_enable(struct ldma_dev *d)
+{
+	unsigned long flags;
+	u32 mask = DMA_CPOLL_EN | DMA_CPOLL_CNT;
+	u32 val = DMA_CPOLL_EN;
+
+	val |= FIELD_PREP(DMA_CPOLL_CNT, d->pollcnt);
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CPOLL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_desc_fetch_on_demand_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask, val;
+
+	if (d->inst->type == DMA_TYPE_MCPY)
+		return;
+
+	mask = DMA_CTRL_DS_FOD;
+	val = enable ? DMA_CTRL_DS_FOD : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_byte_enable_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask = DMA_CTRL_ENBE;
+	u32 val = enable ? DMA_CTRL_ENBE : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+/*
+ * orr_cnt >= 16, it will be 16
+ * 4 <= orr_cnt < 16, it ill be orr_cnt
+ * orr_cnt < 4, it will be 3. Minimum 3 orr supported
+ */
+static void ldma_dev_orrc_cfg(struct ldma_dev *d)
+{
+	unsigned long flags;
+	u32 val = 0;
+	u32 mask;
+
+	if (d->inst->type == DMA_TYPE_RX)
+		return;
+
+	mask = DMA_ORRC_EN | DMA_ORRC_ORRCNT;
+	if (d->orrc > 0 && d->orrc <= DMA_ORRC_MAX_CNT)
+		val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->orrc);
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_ORRC);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_df_tout_cfg(struct ldma_dev *d, bool enable, int tcnt)
+{
+	u32 mask = DMA_CTRL_DESC_TMOUT_CNT_V31;
+	unsigned long flags;
+	u32 val;
+
+	if (enable)
+		val = DMA_CTRL_DESC_TMOUT_EN_V31 | FIELD_PREP(DMA_CTRL_DESC_TMOUT_CNT_V31, tcnt);
+	else
+		val = 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_dburst_wr_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask, val;
+
+	if (d->inst->type != DMA_TYPE_RX && d->inst->type != DMA_TYPE_MCPY)
+		return;
+
+	mask = DMA_CTRL_DBURST_WR;
+	val = enable ? DMA_CTRL_DBURST_WR : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_vld_fetch_ack_cfg(struct ldma_dev *d, bool enable)
+{
+	unsigned long flags;
+	u32 mask, val;
+
+	if (d->inst->type != DMA_TYPE_TX)
+		return;
+
+	mask = DMA_CTRL_VLD_DF_ACK;
+	val = enable ? DMA_CTRL_VLD_DF_ACK : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_dev_drb_cfg(struct ldma_dev *d, int enable)
+{
+	unsigned long flags;
+	u32 mask = DMA_CTRL_DRB;
+	u32 val = enable ? DMA_CTRL_DRB : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, mask, val, DMA_CTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static int ldma_dev_cfg(struct ldma_dev *d)
+{
+	bool enable;
+
+	ldma_dev_pkt_arb_cfg(d, true);
+	ldma_dev_global_polling_enable(d);
+
+	enable = !!(d->flags & DMA_DFT_DRB);
+	ldma_dev_drb_cfg(d, enable);
+
+	enable = !!(d->flags & DMA_EN_BYTE_EN);
+	ldma_dev_byte_enable_cfg(d, enable);
+
+	enable = !!(d->flags & DMA_CHAN_FLOW_CTL);
+	ldma_dev_chan_flow_ctl_cfg(d, enable);
+
+	enable = !!(d->flags & DMA_DESC_FTOD);
+	ldma_dev_desc_fetch_on_demand_cfg(d, enable);
+
+	enable = !!(d->flags & DMA_DESC_IN_SRAM);
+	ldma_dev_sram_desc_cfg(d, enable);
+
+	enable = !!(d->flags & DMA_DBURST_WR);
+	ldma_dev_dburst_wr_cfg(d, enable);
+
+	enable = !!(d->flags & DMA_VLD_FETCH_ACK);
+	ldma_dev_vld_fetch_ack_cfg(d, enable);
+
+	if (d->ver > DMA_VER22) {
+		ldma_dev_orrc_cfg(d);
+		ldma_dev_df_tout_cfg(d, true, DMA_DFT_DESC_TCNT);
+	}
+
+	dev_dbg(d->dev, "%s Controller 0x%08x configuration done\n",
+		d->inst->name, readl(d->base + DMA_CTRL));
+
+	return 0;
+}
+
+static int ldma_chan_cctrl_cfg(struct ldma_chan *c, u32 val)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	reg = readl(d->base + DMA_CCTRL);
+	/* Read from hardware */
+	if (reg & DMA_CCTRL_DIR_TX)
+		c->flags |= DMA_TX_CH;
+	else
+		c->flags |= DMA_RX_CH;
+
+	/* Keep the class value unchanged */
+	reg &= DMA_CCTRL_CLASS | DMA_CCTRL_CLASSH;
+	reg |= val;
+	writel(reg, d->base + DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	return 0;
+}
+
+static void ldma_chan_irq_init(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 enofs, crofs;
+	u32 cn_bit;
+
+	if (c->nr < MAX_LOWER_CHANS) {
+		enofs = DMA_IRNEN;
+		crofs = DMA_IRNCR;
+	} else {
+		enofs = DMA_IRNEN1;
+		crofs = DMA_IRNCR1;
+	}
+
+	cn_bit = BIT(c->nr & MASK_LOWER_CHANS);
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+
+	/* Clear all interrupts and disabled it */
+	writel(0, d->base + DMA_CIE);
+	writel(DMA_CI_ALL, d->base + DMA_CIS);
+
+	ldma_update_bits(d, cn_bit, 0, enofs);
+	writel(cn_bit, d->base + crofs);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_set_class(struct ldma_chan *c, u32 val)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 class_val;
+
+	if (d->inst->type == DMA_TYPE_MCPY || val > DMA_MAX_CLASS)
+		return;
+
+	/* 3 bits low */
+	class_val = FIELD_PREP(DMA_CCTRL_CLASS, val & 0x7);
+	/* 2 bits high */
+	class_val |= FIELD_PREP(DMA_CCTRL_CLASSH, (val >> 3) & 0x3);
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, DMA_CCTRL_CLASS | DMA_CCTRL_CLASSH, class_val,
+			 DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static int ldma_chan_on(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+
+	/* If descriptors not configured, not allow to turn on channel */
+	if (WARN_ON(!c->desc_init))
+		return -EINVAL;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, DMA_CCTRL_ON, DMA_CCTRL_ON, DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	c->onoff = DMA_CH_ON;
+
+	return 0;
+}
+
+static int ldma_chan_off(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, DMA_CCTRL_ON, 0, DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	ret = readl_poll_timeout_atomic(d->base + DMA_CCTRL, val,
+					!(val & DMA_CCTRL_ON), 0, 10000);
+	if (ret)
+		return ret;
+
+	c->onoff = DMA_CH_OFF;
+
+	return 0;
+}
+
+static void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
+				  int desc_num)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	writel(lower_32_bits(desc_base), d->base + DMA_CDBA);
+	/* High 4 bits */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		u32 hi = upper_32_bits(desc_base) & 0xF;
+
+		ldma_update_bits(d, DMA_CDBA_MSB,
+				 FIELD_PREP(DMA_CDBA_MSB, hi), DMA_CCTRL);
+	}
+	writel(desc_num, d->base + DMA_CDLEN);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	c->desc_init = true;
+}
+
+/*
+ * Descriptor base address and data pointer must be physical address when
+ * writen to the register.
+ * This API will be used by CBM which configure hardware descriptor.
+ */
+static int ldma_chan_desc_cfg(struct ldma_chan *c, dma_addr_t desc_base,
+			      int desc_num)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+
+	if (!desc_num) {
+		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
+			c->nr);
+		return -EINVAL;
+	}
+
+	if (desc_num > DMA_MAX_DESC_NUM) {
+		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
+			c->nr, desc_num);
+		return -EINVAL;
+	}
+
+	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
+
+	c->flags |= DMA_HW_DESC;
+	c->desc_cnt = desc_num;
+	c->desc_phys = desc_base;
+
+	return 0;
+}
+
+int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
+			    int desc_num)
+{
+	return ldma_chan_desc_cfg(to_ldma_chan(chan), desc_base, desc_num);
+}
+EXPORT_SYMBOL_GPL(intel_dma_chan_desc_cfg);
+
+static int ldma_chan_reset(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	ret = ldma_chan_off(c);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, DMA_CCTRL_RST, DMA_CCTRL_RST, DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	ret = readl_poll_timeout_atomic(d->base + DMA_CCTRL, val,
+					!(val & DMA_CCTRL_RST), 0, 10000);
+	if (ret)
+		return ret;
+
+	c->rst = 1;
+	c->desc_init = false;
+
+	return 0;
+}
+
+static void ldma_chan_polling_cfg(struct ldma_chan *c, u32 nonarb_cnt,
+				  u32 arb_cnt)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 val;
+
+	if (arb_cnt > nonarb_cnt)
+		return;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+
+	if (nonarb_cnt && arb_cnt) {
+		val = FIELD_PREP(DMA_C_DP_TICK_TIKNARB, nonarb_cnt) |
+		      FIELD_PREP(DMA_C_DP_TICK_TIKARB, arb_cnt);
+		writel(val, d->base + DMA_C_DP_TICK);
+		/* Ensure counter ready, then enable it */
+		wmb();
+		ldma_update_bits(d, DMA_CCTRL_CH_POLL_EN,
+				 DMA_CCTRL_CH_POLL_EN, DMA_CCTRL);
+	} else {
+		writel(0, d->base + DMA_C_DP_TICK);
+		/* Ensure counter ready, then enable it */
+		wmb();
+		ldma_update_bits(d, DMA_CCTRL_CH_POLL_EN, 0, DMA_CCTRL);
+	}
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_byte_offset_cfg(struct ldma_chan *c, u32 boff_len)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	u32 mask = DMA_C_BOFF_EN | DMA_C_BOFF_BOF_LEN;
+	unsigned long flags;
+	u32 val;
+
+	if (boff_len > 0 && boff_len <= DMA_CHAN_BOFF_MAX)
+		val = FIELD_PREP(DMA_C_BOFF_BOF_LEN, boff_len) | DMA_C_BOFF_EN;
+	else
+		val = 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, mask, val, DMA_C_BOFF);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_data_endian_cfg(struct ldma_chan *c, bool enable,
+				      u32 endian_type)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	u32 mask = DMA_C_END_DE_EN | DMA_C_END_DATAENDI;
+	unsigned long flags;
+	u32 val;
+
+	if (enable)
+		val = DMA_C_END_DE_EN | FIELD_PREP(DMA_C_END_DATAENDI, endian_type);
+	else
+		val = 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, mask, val, DMA_C_ENDIAN);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_desc_endian_cfg(struct ldma_chan *c, bool enable,
+				      u32 endian_type)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	u32 mask = DMA_C_END_DES_EN | DMA_C_END_DESENDI;
+	unsigned long flags;
+	u32 val;
+
+	if (enable)
+		val = DMA_C_END_DES_EN | FIELD_PREP(DMA_C_END_DESENDI, endian_type);
+	else
+		val = 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, mask, val, DMA_C_ENDIAN);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_hdr_mode_cfg(struct ldma_chan *c, u32 hdr_len, bool csum)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+
+	unsigned long flags;
+	u32 mask, val;
+
+	/* NB, csum disabled, hdr length must be provided */
+	if (!csum && (!hdr_len || hdr_len > DMA_HDR_LEN_MAX))
+		return;
+
+	mask = DMA_C_HDRM_HDR_SUM;
+	val = DMA_C_HDRM_HDR_SUM;
+
+	if (!csum && hdr_len)
+		val = hdr_len;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, mask, val, DMA_C_HDRM);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_rxwr_np_cfg(struct ldma_chan *c, bool enable)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 mask, val;
+
+	/* Only valid for RX channel */
+	if (ldma_chan_tx(c))
+		return;
+
+	mask = DMA_CCTRL_WR_NP_EN;
+	val = enable ? DMA_CCTRL_WR_NP_EN : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, mask, val, DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void ldma_chan_abc_cfg(struct ldma_chan *c, bool enable)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+	u32 mask, val;
+
+	if (d->ver < DMA_VER32 || ldma_chan_tx(c))
+		return;
+
+	mask = DMA_CCTRL_CH_ABC;
+	val = enable ? DMA_CCTRL_CH_ABC : 0;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	ldma_update_bits(d, mask, val, DMA_CCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static int ldma_port_cfg(struct ldma_port *p)
+{
+	unsigned long flags;
+	struct ldma_dev *d;
+	u32 reg;
+
+	d = p->ldev;
+	reg = p->flush_memcpy ? DMA_PCTRL_MEM_FLUSH : 0;
+	reg |= FIELD_PREP(DMA_PCTRL_TXENDI, p->txendi);
+	reg |= FIELD_PREP(DMA_PCTRL_RXENDI, p->rxendi);
+
+	if (d->ver == DMA_VER22) {
+		reg |= FIELD_PREP(DMA_PCTRL_TXBL, p->txbl);
+		reg |= FIELD_PREP(DMA_PCTRL_RXBL, p->rxbl);
+	} else {
+		reg |= FIELD_PREP(DMA_PCTRL_PDEN, p->pkt_drop);
+
+		if (p->txbl == DMA_BURSTL_32DW)
+			reg |= DMA_PCTRL_TXBL32;
+		else if (p->txbl == DMA_BURSTL_16DW)
+			reg |= DMA_PCTRL_TXBL16;
+		else
+			reg |= FIELD_PREP(DMA_PCTRL_TXBL, DMA_PCTRL_TXBL_8);
+
+		if (p->rxbl == DMA_BURSTL_32DW)
+			reg |= DMA_PCTRL_RXBL32;
+		else if (p->rxbl == DMA_BURSTL_16DW)
+			reg |= DMA_PCTRL_RXBL16;
+		else
+			reg |= FIELD_PREP(DMA_PCTRL_RXBL, DMA_PCTRL_RXBL_8);
+	}
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	writel(p->portid, d->base + DMA_PS);
+	writel(reg, d->base + DMA_PCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	dev_dbg(d->dev, "%s Port Control 0x%08x configuration done\n",
+		p->name, readl(d->base + DMA_PCTRL));
+
+	return 0;
+}
+
+static int ldma_chan_cfg(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	u32 reg;
+
+	reg = c->pden ? DMA_CCTRL_PDEN : 0;
+	reg |= c->onoff ? DMA_CCTRL_ON : 0;
+	reg |= c->rst ? DMA_CCTRL_RST : 0;
+
+	ldma_chan_cctrl_cfg(c, reg);
+	ldma_chan_irq_init(c);
+
+	if (d->ver > DMA_VER22) {
+		ldma_chan_set_class(c, c->nr);
+		ldma_chan_polling_cfg(c, c->nonarb_cnt, c->arb_cnt);
+		ldma_chan_byte_offset_cfg(c, c->boff_len);
+		ldma_chan_data_endian_cfg(c, c->data_endian_en, c->data_endian);
+		ldma_chan_desc_endian_cfg(c, c->desc_endian_en, c->desc_endian);
+		ldma_chan_hdr_mode_cfg(c, c->hdrm_len, c->hdrm_csum);
+		ldma_chan_rxwr_np_cfg(c, c->desc_rx_np);
+		ldma_chan_abc_cfg(c, c->abc_en);
+
+		if (ldma_chan_is_hw_desc(c))
+			ldma_chan_desc_hw_cfg(c, c->desc_phys, c->desc_cnt);
+	}
+
+	return 0;
+}
+
+static void ldma_dev_init(struct ldma_dev *d)
+{
+	struct ldma_port *p;
+	struct ldma_chan *c;
+	int i;
+
+	spin_lock_init(&d->dev_lock);
+	ldma_dev_reset(d);
+	ldma_dev_cfg(d);
+
+	/* DMA port initialization */
+	for (i = 0; i < d->port_nrs; i++) {
+		p = &d->ports[i];
+		ldma_port_cfg(p);
+	}
+
+	/* DMA channel initialization */
+	for (i = 0; i < d->chan_nrs; i++) {
+		c = &d->chans[i];
+		ldma_chan_cfg(c);
+	}
+}
+
+/*
+ * The configuration stored in the devicetree matches the configuration
+ * parameters of the peripheral instance and allows the driver to know which
+ * features are implemented and how it should behave. Users only configure
+ * what is necessary. All other setting will fall back to default setting
+ */
+static int dma_parse_chan_dt(struct fwnode_handle *fw_chan, struct ldma_dev *d)
+{
+	struct ldma_port *p;
+	struct ldma_chan *c;
+	u32 v[2], val;
+	int ret;
+
+	ret = fwnode_property_read_u32(fw_chan, "reg", &val);
+	if (ret)
+		return ret;
+
+	/* Sanity check for channel range */
+	if (val >= d->chan_nrs)
+		return -ENODEV;
+
+	c = &d->chans[val];
+
+	ret = fwnode_property_read_u32(fw_chan, "intel,chan-desc_num",
+				       &c->desc_num);
+	if (ret || (!ret && c->desc_num > 255))
+		c->desc_num = DMA_DFT_DESC_NUM;
+
+	/* Default setting has been set before in case of error inputs */
+	if (!fwnode_property_read_u32(fw_chan, "intel,chan-pkt-sz", &val)) {
+		if (val > DMA_MAX_PKT_SZ)
+			return -EINVAL;
+		c->pkt_sz = val;
+	}
+
+	if (!fwnode_property_read_u32(fw_chan, "intel,chan-data-endian",
+				      &val)) {
+		if (val > DMA_ENDIAN_MAX)
+			return -EINVAL;
+		c->data_endian = val;
+	}
+
+	if (!fwnode_property_read_u32(fw_chan, "intel,chan-desc-endian",
+				      &val)) {
+		if (val > DMA_ENDIAN_MAX)
+			return -EINVAL;
+		c->desc_endian = val;
+	}
+
+	if (fwnode_property_read_u32(fw_chan, "intel,chan-byte-offset",
+				     &c->boff_len))
+		c->boff_len = 0;
+
+	if (fwnode_property_read_u32(fw_chan, "chan-non-arb-cnt",
+				     &c->nonarb_cnt))
+		c->nonarb_cnt = 0;
+
+	if (fwnode_property_read_u32(fw_chan, "intel,chan-arb-cnt",
+				     &c->arb_cnt))
+		c->arb_cnt = 0;
+
+	if (c->arb_cnt > c->nonarb_cnt) {
+		dev_err(d->dev, "arb cnt should be less than no arb cnt\n");
+		return -EINVAL;
+	}
+
+	if (!fwnode_property_read_u32_array(fw_chan, "intel,chan-hdr-mode", v,
+					    ARRAY_SIZE(v))) {
+		c->hdrm_csum = !!v[1];
+		if (!c->hdrm_csum) {
+			if (!v[0] || v[0] > DMA_HDR_LEN_MAX)
+				return -EINVAL;
+		}
+		c->hdrm_len = v[0];
+	}
+
+	if (!fwnode_property_read_u32_array(fw_chan, "intel,chan-hw-desc", v,
+					    ARRAY_SIZE(v))) {
+		u32 cnt = v[1];
+
+		if (!cnt) {
+			dev_err(d->dev,
+				"Channel %d must allocate descriptor first\n",
+				c->nr);
+			return -EINVAL;
+		}
+
+		if (cnt > DMA_MAX_DESC_NUM) {
+			dev_err(d->dev,
+				"Channel %d descriptor number out of range %d\n",
+				c->nr, cnt);
+			return -EINVAL;
+		}
+		c->desc_phys = v[0];
+		c->desc_cnt = cnt;
+		c->flags |= DMA_HW_DESC;
+	}
+
+	/* If channel packet drop enabled, port packet drop should be enabled */
+	c->pden = fwnode_property_read_bool(fw_chan, "intel,chan-pkt-drop");
+	if (c->pden) {
+		p = c->port;
+		/* Config once on the dma port packet drop */
+		if (!p->pden) {
+			p->pkt_drop = DMA_PKT_DROP_EN;
+			p->pden = true;
+		}
+	}
+
+	c->desc_rx_np = fwnode_property_read_bool(fw_chan,
+						  "intel,chan-desc-rx-nonpost");
+	c->data_endian_en = fwnode_property_read_bool(fw_chan,
+						      "intel,chan-data-endian-en");
+	c->desc_endian_en = fwnode_property_read_bool(fw_chan,
+						      "intel,chan-data-endian-en");
+
+	return 0;
+}
+
+static unsigned int dma_get_channel_node_count(struct ldma_dev *d)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(d->dev);
+	struct fwnode_handle *fw_chans;
+	struct fwnode_handle *child;
+	unsigned int count = 0;
+
+	fw_chans = fwnode_get_named_child_node(fwnode, "dma-channels");
+	fwnode_for_each_child_node(fw_chans, child)
+		count++;
+
+	return count;
+}
+
+static int dma_parse_port_dt(struct fwnode_handle *fw_port, struct ldma_dev *d)
+{
+	struct ldma_port *p;
+	u32 val, v[2];
+	int ret;
+
+	ret = fwnode_property_read_u32(fw_port, "reg", &val);
+	if (ret)
+		return ret;
+
+	/* Sanit check */
+	if (val >= d->port_nrs)
+		return -ENODEV;
+
+	p = &d->ports[val];
+
+	ret = fwnode_property_read_string(fw_port, "intel,port-name", &p->name);
+	if (ret) {
+		dev_err(d->dev, "Failed to get port name ret=%d\n", ret);
+		return ret;
+	}
+
+	ret = fwnode_property_read_u32_array(fw_port, "intel,port-chans", v,
+					     ARRAY_SIZE(v));
+	if (ret) {
+		dev_err(d->dev, "Failed to get port chan mapping ret=%d\n",
+			ret);
+		return ret;
+	}
+	p->chan_start = v[0];
+	p->chan_sz = v[1];
+
+	if (fwnode_property_read_u32(fw_port, "intel,port-burst", &p->txbl))
+		p->txbl = DMA_DFT_BURST_V22;
+
+	if (p->txbl != 2 && p->txbl != 4 && p->txbl != 8)
+		return -EINVAL;
+
+	/* TX and RX has the same burst length */
+	p->txbl = ilog2(p->txbl);
+	p->rxbl = p->txbl;
+
+	if (fwnode_property_read_u32(fw_port, "intel,port-endian", &p->txendi))
+		p->txendi = DMA_DFT_ENDIAN;
+
+	/* TX and RX has the same endianness */
+	p->rxendi = p->txendi;
+
+	if (fwnode_property_read_u32(fw_port, "intel,port-txwgt", &p->txwgt))
+		p->txwgt = DMA_TX_PORT_DFT_WGT;
+
+	if (!strncmp(p->name, "MEMCPY", 4))
+		p->flush_memcpy = 1;
+
+	/*
+	 * Get max available channels instead of reading from regsiters
+	 */
+	d->chan_nrs = dma_get_channel_node_count(d);
+
+	dev_dbg(d->dev, "Port %s burst %d endian %d txwgt %d\n",
+		p->name, p->rxbl, p->rxendi, p->txwgt);
+
+	return 0;
+}
+
+static int ldma_cfg_init(struct ldma_dev *d)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(d->dev);
+	struct fwnode_handle *fw_chans, *fw_chan;
+	struct fwnode_handle *fw_ports, *fw_port;
+	struct ldma_chan *c;
+	struct ldma_port *p;
+	u32 txendi, rxendi;
+	u32 prop, val;
+	int ret, i;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-chan-fc"))
+		d->flags |= DMA_CHAN_FLOW_CTL;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-desc-fod"))
+		d->flags |= DMA_DESC_FTOD;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-desc-in-sram"))
+		d->flags |= DMA_DESC_IN_SRAM;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-byte-en"))
+		d->flags |= DMA_EN_BYTE_EN;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-dfetch-ack"))
+		d->flags |= DMA_VLD_FETCH_ACK;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-dburst-wr"))
+		d->flags |= DMA_DBURST_WR;
+
+	if (fwnode_property_read_bool(fwnode, "intel,dma-drb"))
+		d->flags |= DMA_DFT_DRB;
+
+	if (fwnode_property_read_u32(fwnode, "intel,dma-polling-cnt",
+				     &d->pollcnt))
+		d->pollcnt = DMA_DFT_POLL_CNT;
+
+	if (!fwnode_property_read_u32(fwnode, "intel,dma-orrc", &val)) {
+		if (val > DMA_ORRC_MAX_CNT)
+			return -EINVAL;
+		d->orrc = val;
+	}
+
+	if (d->ver > DMA_VER22) {
+		if (fwnode_property_read_u32(fwnode, "intel,dma-txendi",
+					     &txendi))
+			txendi = DMA_DFT_ENDIAN;
+
+		if (fwnode_property_read_u32(fwnode, "intel,dma-rxendi",
+					     &rxendi))
+			rxendi = DMA_DFT_ENDIAN;
+
+		if (!d->port_nrs)
+			return -EINVAL;
+
+		for (i = 0; i < d->port_nrs; i++) {
+			p = &d->ports[i];
+			p->rxendi = rxendi;
+			p->txendi = txendi;
+
+			if (!fwnode_property_read_u32(fwnode, "intel,dma-burst",
+						      &prop)) {
+				p->rxbl = prop;
+				p->txbl = prop;
+			} else {
+				p->rxbl = DMA_DFT_BURST;
+				p->txbl = DMA_DFT_BURST;
+			}
+
+			p->pkt_drop = DMA_PKT_DROP_DIS;
+			p->flush_memcpy = 0;
+		}
+	}
+
+	/* Port specific, required for dma0 */
+	fw_ports = fwnode_get_named_child_node(fwnode, "dma-ports");
+	if (!fw_ports && d->ver == DMA_VER22) {
+		dev_err(d->dev, "Failed to get ports settings\n");
+		return -ENODEV;
+	}
+	if (fw_ports) {
+		fwnode_for_each_child_node(fw_ports, fw_port) {
+			ret = dma_parse_port_dt(fw_port, d);
+			if (ret) {
+				fwnode_handle_put(fw_port);
+				fwnode_handle_put(fw_ports);
+				return -EINVAL;
+			}
+		}
+		fwnode_handle_put(fw_ports);
+	}
+
+	d->chans = devm_kcalloc(d->dev, d->chan_nrs, sizeof(*c), GFP_KERNEL);
+	if (!d->chans)
+		return -ENOMEM;
+
+	/* Channel based configuration if available, optional */
+	fw_chans = fwnode_get_named_child_node(fwnode, "dma-channels");
+	if (fw_chans) {
+		fwnode_for_each_child_node(fw_chans, fw_chan) {
+			if (dma_parse_chan_dt(fw_chan, d)) {
+				fwnode_handle_put(fw_chan);
+				fwnode_handle_put(fw_chans);
+				return -EINVAL;
+			}
+		}
+		fwnode_handle_put(fw_chans);
+	}
+
+	return ret;
+}
+
+static void dma_free_desc_resource(struct ldma_chan *c)
+{
+	struct dw2_desc_sw *ds = c->ds;
+
+	dma_pool_free(c->desc_pool, ds->desc_hw, ds->desc_phys);
+	kfree(ds);
+	c->ds = NULL;
+}
+
+static struct dw2_desc_sw *
+dma_alloc_desc_resource(int num, struct ldma_chan *c)
+{
+	struct device *dev = c->vchan.chan.device->dev;
+	struct dw2_desc_sw *ds;
+
+	if (num > c->desc_num) {
+		dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_num);
+		return NULL;
+	}
+
+	ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
+	if (!ds)
+		return NULL;
+
+	ds->chan = c;
+
+	ds->desc_hw = dma_pool_zalloc(c->desc_pool, GFP_ATOMIC,
+				      &ds->desc_phys);
+	if (!ds->desc_hw) {
+		dev_dbg(dev, "out of memory for link descriptor\n");
+		kfree(ds);
+		return NULL;
+	}
+	ds->desc_cnt = num;
+
+	return ds;
+}
+
+static void ldma_chan_irq_en(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	writel(c->nr, d->base + DMA_CS);
+	writel(DMA_CI_EOP, d->base + DMA_CIE);
+	ldma_update_bits(d, 0, BIT(c->nr), DMA_IRNEN);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void dma_issue_pending(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct dw2_desc_sw *ds = c->ds;
+
+	if (d->ver == DMA_VER22) {
+		ldma_chan_desc_hw_cfg(c, ds->desc_phys, ds->desc_cnt);
+		ldma_chan_irq_en(c);
+	}
+	ldma_chan_on(c);
+}
+
+static void dma_synchronize(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+
+	/*
+	 * clear any pending work if any. In that
+	 * case the resource needs to be free here.
+	 */
+	cancel_work_sync(&c->work);
+	if (c->ds)
+		dma_free_desc_resource(c);
+}
+
+static int dma_terminate_all(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+
+	return ldma_chan_reset(c);
+}
+
+static int dma_resume_chan(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+
+	ldma_chan_on(c);
+
+	return 0;
+}
+
+static int dma_pause_chan(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+
+	return ldma_chan_off(c);
+}
+
+static enum dma_status
+dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+	      struct dma_tx_state *txstate)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	enum dma_status status = DMA_COMPLETE;
+
+	if (d->ver == DMA_VER22)
+		status = dma_cookie_status(chan, cookie, txstate);
+
+	return status;
+}
+
+static dma_cookie_t dma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	return dma_cookie_assign(tx);
+}
+
+static void dma_chan_irq(int irq, void *data)
+{
+	struct ldma_chan *c = data;
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	u32 stat;
+
+	/* Disable channel interrupts  */
+	writel(c->nr, d->base + DMA_CS);
+	stat = readl(d->base + DMA_CIS);
+	if (!stat)
+		return;
+
+	ldma_update_bits(d, DMA_CI_ALL, 0, DMA_CIE);
+	writel(stat, d->base + DMA_CIS);
+	queue_work(d->wq, &c->work);
+}
+
+static irqreturn_t dma_interrupt(int irq, void *dev_id)
+{
+	struct ldma_dev *d = dev_id;
+	struct ldma_chan *c;
+	unsigned long irncr;
+	u32 cid;
+
+	irncr = readl(d->base + DMA_IRNCR);
+	if (!irncr) {
+		dev_err(d->dev, "dummy interrupt\n");
+		return IRQ_NONE;
+	}
+
+	for_each_set_bit(cid, &irncr, d->chan_nrs) {
+		/* Mask */
+		ldma_update_bits(d, BIT(cid), 0, DMA_IRNEN);
+		/* Ack */
+		ldma_update_bits(d, 0, BIT(cid), DMA_IRNCR);
+
+		c = &d->chans[cid];
+		dma_chan_irq(irq, c);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct dma_async_tx_descriptor *
+dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		  unsigned int sglen, enum dma_transfer_direction dir,
+		  unsigned long flags, void *context)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+	size_t len, avail, total = 0;
+	struct dw2_desc *hw_ds;
+	struct dw2_desc_sw *ds;
+	struct scatterlist *sg;
+	int num = sglen, i;
+	dma_addr_t addr;
+
+	if (!sgl)
+		return NULL;
+
+	for_each_sg(sgl, sg, sglen, i) {
+		avail = sg_dma_len(sg);
+		if (avail > DMA_MAX_SIZE)
+			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
+	}
+
+	ds = dma_alloc_desc_resource(num, c);
+	if (!ds)
+		return NULL;
+
+	c->ds = ds;
+
+	num = 0;
+	/* sop and eop has to be handled nicely */
+	for_each_sg(sgl, sg, sglen, i) {
+		addr = sg_dma_address(sg);
+		avail = sg_dma_len(sg);
+		total += avail;
+
+		do {
+			len = min_t(size_t, avail, DMA_MAX_SIZE);
+
+			hw_ds = &ds->desc_hw[num];
+			switch (sglen) {
+			case 1:
+				hw_ds->status.field.sop = 1;
+				hw_ds->status.field.eop = 1;
+				break;
+			default:
+				if (num == 0) {
+					hw_ds->status.field.sop = 1;
+					hw_ds->status.field.eop = 0;
+				} else if (num == (sglen - 1)) {
+					hw_ds->status.field.sop = 0;
+					hw_ds->status.field.eop = 1;
+				} else {
+					hw_ds->status.field.sop = 0;
+					hw_ds->status.field.eop = 0;
+				}
+				break;
+			}
+
+			/* Only 32 bit address supported */
+			hw_ds->addr = (u32)addr;
+			hw_ds->status.field.len = len;
+			hw_ds->status.field.c = 0;
+			hw_ds->status.field.bofs = addr & 0x3;
+			/* Ensure data ready before ownership change */
+			wmb();
+			hw_ds->status.field.own = DMA_OWN;
+			/* Ensure ownership changed before moving forward */
+			wmb();
+			num++;
+			addr += len;
+			avail -= len;
+		} while (avail);
+	}
+
+	ds->size = total;
+
+	dma_async_tx_descriptor_init(&ds->async_tx, &c->vchan.chan);
+	ds->async_tx.tx_submit = dma_tx_submit;
+	ds->async_tx.flags = DMA_CTRL_ACK;
+
+	return &ds->async_tx;
+}
+
+static int
+dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_port *p = c->port;
+	unsigned long flags;
+	u32 bl;
+
+	if ((cfg->direction == DMA_DEV_TO_MEM &&
+	     cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
+	    (cfg->direction == DMA_MEM_TO_DEV &&
+	     cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES) ||
+	    !is_slave_direction(cfg->direction))
+		return -EINVAL;
+
+	/* Default setting will be used */
+	if (!cfg->src_maxburst && !cfg->dst_maxburst)
+		return 0;
+
+	/* Must be the same */
+	if (cfg->src_maxburst && cfg->dst_maxburst &&
+	    cfg->src_maxburst != cfg->dst_maxburst)
+		return -EINVAL;
+
+	if (cfg->dst_maxburst)
+		cfg->src_maxburst = cfg->dst_maxburst;
+
+	bl = ilog2(cfg->src_maxburst);
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	writel(p->portid, d->base + DMA_PS);
+	ldma_update_bits(d, DMA_PCTRL_RXBL | DMA_PCTRL_TXBL,
+			 FIELD_PREP(DMA_PCTRL_RXBL, bl) |
+			 FIELD_PREP(DMA_PCTRL_TXBL, bl), DMA_PCTRL);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	return 0;
+}
+
+static int dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct device *dev = c->vchan.chan.device->dev;
+	size_t	desc_sz;
+
+	if (d->ver > DMA_VER22) {
+		c->flags |= CHAN_IN_USE;
+		return 0;
+	}
+
+	if (c->desc_pool)
+		return c->desc_num;
+
+	desc_sz = c->desc_num * sizeof(struct dw2_desc);
+	c->desc_pool = dma_pool_create(c->name, dev, desc_sz,
+				       __alignof__(struct dw2_desc), 0);
+
+	if (!c->desc_pool) {
+		dev_err(dev, "unable to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
+
+	return c->desc_num;
+}
+
+static void dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+
+	if (d->ver == DMA_VER22) {
+		dma_pool_destroy(c->desc_pool);
+		c->desc_pool = NULL;
+		ldma_chan_reset(c);
+	} else {
+		c->flags &= ~CHAN_IN_USE;
+	}
+}
+
+static void dma_work(struct work_struct *work)
+{
+	struct ldma_chan *c = container_of(work, struct ldma_chan, work);
+	struct dma_async_tx_descriptor *tx = &c->ds->async_tx;
+	struct dmaengine_desc_callback cb;
+
+	dmaengine_desc_get_callback(tx, &cb);
+	dma_cookie_complete(tx);
+	dmaengine_desc_callback_invoke(&cb, NULL);
+	dma_free_desc_resource(c);
+}
+
+static struct dma_chan *ldma_xlate(struct of_phandle_args *spec,
+				   struct of_dma *ofdma)
+{
+	struct ldma_dev *d = ofdma->of_dma_data;
+	u32 chan_id =  spec->args[0];
+
+	if (spec->args_count != 1 || chan_id >= d->chan_nrs)
+		return NULL;
+
+	return dma_get_slave_channel(&d->chans[chan_id].vchan.chan);
+}
+
+static void ldma_clk_disable(void *data)
+{
+	struct ldma_dev *d = data;
+
+	clk_disable_unprepare(d->core_clk);
+}
+
+static struct dma_dev_ops dma0_ops = {
+	.device_alloc_chan_resources = dma_alloc_chan_resources,
+	.device_free_chan_resources = dma_free_chan_resources,
+	.device_config = dma_slave_config,
+	.device_prep_slave_sg = dma_prep_slave_sg,
+	.device_tx_status = dma_tx_status,
+	.device_pause = dma_pause_chan,
+	.device_resume = dma_resume_chan,
+	.device_terminate_all = dma_terminate_all,
+	.device_synchronize = dma_synchronize,
+	.device_issue_pending = dma_issue_pending,
+};
+
+static struct dma_dev_ops hdma_ops = {
+	.device_alloc_chan_resources = dma_alloc_chan_resources,
+	.device_free_chan_resources = dma_free_chan_resources,
+	.device_terminate_all = dma_terminate_all,
+	.device_issue_pending = dma_issue_pending,
+	.device_tx_status = dma_tx_status,
+	.device_resume = dma_resume_chan,
+	.device_pause = dma_pause_chan,
+};
+
+static const struct ldma_inst_data dma0 = {
+	.name = "dma0",
+	.ops = &dma0_ops,
+};
+
+static const struct ldma_inst_data dma2tx = {
+	.name = "dma2tx",
+	.type = DMA_TYPE_TX,
+	.ops = &hdma_ops,
+};
+
+static const struct ldma_inst_data dma1rx = {
+	.name = "dma1rx",
+	.type = DMA_TYPE_RX,
+	.ops = &hdma_ops,
+};
+
+static const struct ldma_inst_data dma1tx = {
+	.name = "dma1tx",
+	.type = DMA_TYPE_TX,
+	.ops = &hdma_ops,
+};
+
+static const struct ldma_inst_data dma0tx = {
+	.name = "dma0tx",
+	.type = DMA_TYPE_TX,
+	.ops = &hdma_ops,
+};
+
+static const struct ldma_inst_data dma3 = {
+	.name = "dma3",
+	.type = DMA_TYPE_MCPY,
+	.ops = &hdma_ops,
+};
+
+static const struct ldma_inst_data toe_dma30 = {
+	.name = "toe_dma30",
+	.type = DMA_TYPE_MCPY,
+	.ops = &hdma_ops,
+};
+
+static const struct ldma_inst_data toe_dma31 = {
+	.name = "toe_dma31",
+	.type = DMA_TYPE_MCPY,
+	.ops = &hdma_ops,
+};
+
+static const struct of_device_id intel_ldma_match[] = {
+	{ .compatible = "intel,lgm-cdma", .data = &dma0},
+	{ .compatible = "intel,lgm-dma2tx", .data = &dma2tx},
+	{ .compatible = "intel,lgm-dma1rx", .data = &dma1rx},
+	{ .compatible = "intel,lgm-dma1tx", .data = &dma1tx},
+	{ .compatible = "intel,lgm-dma0tx", .data = &dma0tx},
+	{ .compatible = "intel,lgm-dma3", .data = &dma3},
+	{ .compatible = "intel,lgm-toe_dma30", .data = &toe_dma30},
+	{ .compatible = "intel,lgm-toe_dma31", .data = &toe_dma31},
+	{}
+};
+
+static int intel_ldma_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dma_device *dma_dev;
+	struct ldma_chan *c;
+	struct ldma_port *p;
+	struct ldma_dev *d;
+	u32 id, bitn = 32;
+	int i, j, k, ret;
+
+	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	/* Link controller to platform device */
+	d->dev = &pdev->dev;
+
+	d->inst = device_get_match_data(dev);
+	if (!d->inst) {
+		dev_err(dev, "No device match found\n");
+		return -ENODEV;
+	}
+
+	d->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(d->base))
+		return PTR_ERR(d->base);
+
+	/* Power up and reset the dma engine, some DMAs always on?? */
+	d->core_clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(d->core_clk))
+		return PTR_ERR(d->core_clk);
+	clk_prepare_enable(d->core_clk);
+
+	ret = devm_add_action_or_reset(dev, ldma_clk_disable, d);
+	if (ret) {
+		dev_err(dev, "Failed to devm_add_action_or_reset, %d\n", ret);
+		return ret;
+	}
+
+	d->rst = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(d->rst))
+		return PTR_ERR(d->rst);
+	reset_control_deassert(d->rst);
+
+	id = readl(d->base + DMA_ID);
+	d->chan_nrs = FIELD_GET(DMA_ID_CHNR, id);
+	d->port_nrs = FIELD_GET(DMA_ID_PNR, id);
+	d->ver = FIELD_GET(DMA_ID_REV, id);
+
+	if (id & DMA_ID_AW_36B)
+		d->flags |= DMA_ADDR_36BIT;
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (id & DMA_ID_AW_36B)
+			bitn = 36;
+	}
+
+	if (id & DMA_ID_DW_128B)
+		d->flags |= DMA_DATA_128BIT;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(bitn));
+	if (ret) {
+		dev_err(dev, "No usable DMA configuration\n");
+		return ret;
+	}
+
+	if (d->ver == DMA_VER22) {
+		d->irq = platform_get_irq(pdev, 0);
+		if (d->irq < 0)
+			return d->irq;
+
+		ret = devm_request_irq(&pdev->dev, d->irq, dma_interrupt,
+				       0, DRIVER_NAME, d);
+		if (ret)
+			return ret;
+
+		d->wq = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM |
+						WQ_HIGHPRI);
+		if (!d->wq)
+			return -ENOMEM;
+	}
+
+	dma_dev = &d->dma_dev;
+	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+
+	/* Channel initializations */
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	/* Port Initializations */
+	d->ports = devm_kcalloc(dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
+	if (!d->ports)
+		return -ENOMEM;
+
+	for (i = 0; i < d->port_nrs; i++) {
+		p = &d->ports[i];
+		p->portid = i;
+		p->ldev = d;
+	}
+
+	ret = ldma_cfg_init(d);
+	if (ret)
+		return ret;
+
+	dma_dev->dev = &pdev->dev;
+	/*
+	 * Link channel id to channel index and link to dma channel list
+	 * It also back points to controller and its port
+	 */
+	for (i = 0, k = 0; i < d->port_nrs; i++) {
+		if (d->ver == DMA_VER22) {
+			u32 chan_end;
+
+			p = &d->ports[i];
+			chan_end = p->chan_start + p->chan_sz;
+			for (j = p->chan_start; j < chan_end; j++) {
+				c = &d->chans[k];
+				c->port = p;
+				c->nr = j; /* Real channel number */
+				c->rst = DMA_CHAN_RST;
+				snprintf(c->name, sizeof(c->name), "chan%d",
+					 c->nr);
+				INIT_WORK(&c->work, dma_work);
+				vchan_init(&c->vchan, dma_dev);
+				k++;
+			}
+		} else {
+			p = &d->ports[i];
+			for (i = 0; i < d->chan_nrs; i++) {
+				c = &d->chans[i];
+				c->port = p;
+				c->data_endian = DMA_DFT_ENDIAN;
+				c->desc_endian = DMA_DFT_ENDIAN;
+				c->flags |= DEVICE_ALLOC_DESC;
+				c->pkt_sz = DMA_PKT_SZ_DFT;
+				c->onoff = DMA_CH_OFF;
+				c->rst = DMA_CHAN_RST;
+				c->abc_en = true;
+				c->nr = i;
+				vchan_init(&c->vchan, dma_dev);
+			}
+		}
+	}
+
+	/* Set DMA capabilities */
+	dma_cap_zero(dma_dev->cap_mask);
+
+	dma_dev->device_alloc_chan_resources =
+		d->inst->ops->device_alloc_chan_resources;
+	dma_dev->device_free_chan_resources =
+		d->inst->ops->device_free_chan_resources;
+	dma_dev->device_terminate_all = d->inst->ops->device_terminate_all;
+	dma_dev->device_issue_pending = d->inst->ops->device_issue_pending;
+	dma_dev->device_tx_status = d->inst->ops->device_tx_status;
+	dma_dev->device_resume = d->inst->ops->device_resume;
+	dma_dev->device_pause = d->inst->ops->device_pause;
+	dma_dev->device_config = d->inst->ops->device_config;
+	dma_dev->device_prep_slave_sg = d->inst->ops->device_prep_slave_sg;
+	dma_dev->device_synchronize = d->inst->ops->device_synchronize;
+
+	if (d->ver == DMA_VER22) {
+		dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+		dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+		dma_dev->directions = BIT(DMA_MEM_TO_DEV) |
+				      BIT(DMA_DEV_TO_MEM);
+		dma_dev->residue_granularity =
+					DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	}
+
+	platform_set_drvdata(pdev, d);
+
+	ldma_dev_init(d);
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret) {
+		dev_err(dev, "Failed to register slave DMA engine device\n");
+		return ret;
+	}
+
+	ret = of_dma_controller_register(pdev->dev.of_node, ldma_xlate, d);
+	if (ret) {
+		dev_err(dev, "Failed to register of DMA controller\n");
+		dma_async_device_unregister(dma_dev);
+		return ret;
+	}
+
+	dev_info(dev, "Init done - rev: %x, ports: %d channels: %d\n", d->ver,
+		 d->port_nrs, d->chan_nrs);
+
+	return 0;
+}
+
+static struct platform_driver intel_ldma_driver = {
+	.probe = intel_ldma_probe,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = intel_ldma_match,
+	},
+};
+
+static int __init intel_ldma_init(void)
+{
+	return platform_driver_register(&intel_ldma_driver);
+}
+
+device_initcall(intel_ldma_init);
diff --git a/include/linux/dma/lgm_dma.h b/include/linux/dma/lgm_dma.h
new file mode 100644
index 000000000000..3a2ee6ad0710
--- /dev/null
+++ b/include/linux/dma/lgm_dma.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016 ~ 2019 Intel Corporation.
+ */
+#ifndef LGM_DMA_H
+#define LGM_DMA_H
+
+#include <linux/types.h>
+#include <linux/dmaengine.h>
+
+/*!
+ * \fn int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
+ *                                 int desc_num)
+ * \brief Configure low level channel descriptors
+ * \param[in] chan   pointer to DMA channel that the client is using
+ * \param[in] desc_base   descriptor base physical address
+ * \param[in] desc_num   number of descriptors
+ * \return   0 on success
+ * \return   kernel bug reported on failure
+ *
+ * This function configure the low level channel descriptors. It will be
+ * used by CBM whose descriptor is not DDR, actually some registers.
+ */
+int intel_dma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base,
+			    int desc_num);
+
+#endif /* LGM_DMA_H */
-- 
2.11.0

