Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D35F2515
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 03:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfKGCOV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 21:14:21 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47160 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCOU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 21:14:20 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A1D6AB2B;
        Thu,  7 Nov 2019 03:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1573092855;
        bh=YG6jH5plN0NeOp43G5vIhcE+LeWeZnAazUvyR3OzNx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oh2MggHRiupRRJdqtKUiTztCCl5NcXNNRIiTEUnbGO5iDsudpq6O0JP0TOpW4gzlk
         M5pzJ/2A+pdr2daIFCiytbWr/3EORuIA6dQ4Uwy0rZZ2bUjQKz6uyosQUQfIHGrVwx
         uROUtTZEMQaIaJSZbu5jLnOGEgCl2Vb4FV9okYcM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver
Date:   Thu,  7 Nov 2019 04:13:58 +0200
Message-Id: <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Hyun Kwon <hyun.kwon@xilinx.com>

The ZynqMP DisplayPort subsystem includes a DMA engine called DPDMA with
6 DMa channels (4 for display and 2 for audio). This driver exposes the
DPDMA through the dmaengine API, to be used by audio (ALSA) and display
(DRM) drivers for the DisplayPort subsystem.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Tejas Upadhyay <tejasu@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v1:

- Remove unneeded #include
- Drop enum xilinx_dpdma_chan_id
- Update compatible string
- Drop DT subnodes
- Replace XILINX_DPDMA_NUM_CHAN with ARRAY_SIZE(xdev->chan)
- Disable IRQ at remove() time
- Use devm_platform_ioremap_resource()
- Don't inline functions manually
- Add section headers
- Merge DMA engine implementation in their wrappers
- Rename xilinx_dpdma_sw_desc::phys to dma_addr
- Use GENMASK()
- Use FIELD_PREP/FIELD_GET
- Fix MSB handling in xilinx_dpdma_sw_desc_addr_64()
- Fix logic in xilinx_dpdma_chan_prep_slave_sg()
- Document why xilinx_dpdma_config() doesn't need to check most
  parameters
- Remove debugfs support
- Rechedule errored descriptor
- Align the line size with 128bit
- SPDX header formatting
---
 MAINTAINERS                       |    1 +
 drivers/dma/Kconfig               |    9 +
 drivers/dma/xilinx/Makefile       |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c | 2066 +++++++++++++++++++++++++++++
 4 files changed, 2077 insertions(+)
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 457b39bc2320..368bb127edf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17904,6 +17904,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
+F:	drivers/dma/xilinx/xilinx_dpdma.c
 F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
 
 XILLYBUS DRIVER
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7af874b69ffb..3d6085dab4e6 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -636,6 +636,15 @@ config XILINX_DMA
 	  AXI DMA engine provides high-bandwidth one dimensional direct
 	  memory access between memory and AXI4-Stream target peripherals.
 
+config XILINX_DPDMA
+	tristate "Xilinx DPDMA Engine"
+	select DMA_ENGINE
+	help
+	  Enable support for Xilinx ZynqMP DisplayPort DMA. Choose this option
+	  if you have a Xilinx ZynqMP SoC with a DisplayPort subsystem. The
+	  driver provides the dmaengine required by the DisplayPort subsystem
+	  display driver.
+
 config XILINX_ZYNQMP_DMA
 	tristate "Xilinx ZynqMP DMA Engine"
 	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
index e921de575b55..f76f5ea4be20 100644
--- a/drivers/dma/xilinx/Makefile
+++ b/drivers/dma/xilinx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
+obj-$(CONFIG_XILINX_DPDMA) += xilinx_dpdma.o
 obj-$(CONFIG_XILINX_ZYNQMP_DMA) += zynqmp_dma.o
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
new file mode 100644
index 000000000000..a8420b485ebc
--- /dev/null
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -0,0 +1,2066 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZynqMP DPDMA Engine driver
+ *
+ * Copyright (C) 2015 - 2019 Xilinx, Inc.
+ *
+ * Author: Hyun Woo Kwon <hyun.kwon@xilinx.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dmapool.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
+
+#include "../dmaengine.h"
+
+/* DPDMA registers */
+#define XILINX_DPDMA_ERR_CTRL				0x000
+#define XILINX_DPDMA_ISR				0x004
+#define XILINX_DPDMA_IMR				0x008
+#define XILINX_DPDMA_IEN				0x00c
+#define XILINX_DPDMA_IDS				0x010
+#define XILINX_DPDMA_INTR_DESC_DONE(n)			BIT((n) + 0)
+#define XILINX_DPDMA_INTR_DESC_DONE_MASK		GENMASK(5, 0)
+#define XILINX_DPDMA_INTR_NO_OSTAND(n)			BIT((n) + 6)
+#define XILINX_DPDMA_INTR_NO_OSTAND_MASK		GENMASK(11, 6)
+#define XILINX_DPDMA_INTR_AXI_ERR(n)			BIT((n) + 12)
+#define XILINX_DPDMA_INTR_AXI_ERR_MASK			GENMASK(17, 12)
+#define XILINX_DPDMA_INTR_DESC_ERR(n)			BIT((n) + 16)
+#define XILINX_DPDMA_INTR_DESC_ERR_MASK			GENMASK(23, 18)
+#define XILINX_DPDMA_INTR_WR_CMD_FIFO_FULL		BIT(24)
+#define XILINX_DPDMA_INTR_WR_DATA_FIFO_FULL		BIT(25)
+#define XILINX_DPDMA_INTR_AXI_4K_CROSS			BIT(26)
+#define XILINX_DPDMA_INTR_VSYNC				BIT(27)
+#define XILINX_DPDMA_INTR_CHAN_ERR_MASK			0x00041000
+#define XILINX_DPDMA_INTR_CHAN_ERR			0x00fff000
+#define XILINX_DPDMA_INTR_GLOBAL_ERR			0x07000000
+#define XILINX_DPDMA_INTR_ERR_ALL			0x07fff000
+#define XILINX_DPDMA_INTR_CHAN_MASK			0x00041041
+#define XILINX_DPDMA_INTR_GLOBAL_MASK			0x0f000000
+#define XILINX_DPDMA_INTR_ALL				0x0fffffff
+#define XILINX_DPDMA_EISR				0x014
+#define XILINX_DPDMA_EIMR				0x018
+#define XILINX_DPDMA_EIEN				0x01c
+#define XILINX_DPDMA_EIDS				0x020
+#define XILINX_DPDMA_EINTR_INV_APB			BIT(0)
+#define XILINX_DPDMA_EINTR_RD_AXI_ERR(n)		BIT((n) + 1)
+#define XILINX_DPDMA_EINTR_RD_AXI_ERR_MASK		GENMASK(6, 1)
+#define XILINX_DPDMA_EINTR_PRE_ERR(n)			BIT((n) + 7)
+#define XILINX_DPDMA_EINTR_PRE_ERR_MASK			GENMASK(12, 7)
+#define XILINX_DPDMA_EINTR_CRC_ERR(n)			BIT((n) + 13)
+#define XILINX_DPDMA_EINTR_CRC_ERR_MASK			GENMASK(18, 13)
+#define XILINX_DPDMA_EINTR_WR_AXI_ERR(n)		BIT((n) + 19)
+#define XILINX_DPDMA_EINTR_WR_AXI_ERR_MASK		GENMASK(24, 19)
+#define XILINX_DPDMA_EINTR_DESC_DONE_ERR(n)		BIT((n) + 25)
+#define XILINX_DPDMA_EINTR_DESC_DONE_ERR_MASK		GENMASK(30, 25)
+#define XILINX_DPDMA_EINTR_RD_CMD_FIFO_FULL		BIT(32)
+#define XILINX_DPDMA_EINTR_CHAN_ERR_MASK		0x02082082
+#define XILINX_DPDMA_EINTR_CHAN_ERR			0x7ffffffe
+#define XILINX_DPDMA_EINTR_GLOBAL_ERR			0x80000001
+#define XILINX_DPDMA_EINTR_ALL				0xffffffff
+#define XILINX_DPDMA_CNTL				0x100
+#define XILINX_DPDMA_GBL				0x104
+#define XILINX_DPDMA_GBL_TRIG_MASK(n)			((n) << 0)
+#define XILINX_DPDMA_GBL_RETRIG_MASK(n)			((n) << 6)
+#define XILINX_DPDMA_ALC0_CNTL				0x108
+#define XILINX_DPDMA_ALC0_STATUS			0x10c
+#define XILINX_DPDMA_ALC0_MAX				0x110
+#define XILINX_DPDMA_ALC0_MIN				0x114
+#define XILINX_DPDMA_ALC0_ACC				0x118
+#define XILINX_DPDMA_ALC0_ACC_TRAN			0x11c
+#define XILINX_DPDMA_ALC1_CNTL				0x120
+#define XILINX_DPDMA_ALC1_STATUS			0x124
+#define XILINX_DPDMA_ALC1_MAX				0x128
+#define XILINX_DPDMA_ALC1_MIN				0x12c
+#define XILINX_DPDMA_ALC1_ACC				0x130
+#define XILINX_DPDMA_ALC1_ACC_TRAN			0x134
+
+/* Channel register */
+#define XILINX_DPDMA_CH_BASE				0x200
+#define XILINX_DPDMA_CH_OFFSET				0x100
+#define XILINX_DPDMA_CH_DESC_START_ADDRE		0x000
+#define XILINX_DPDMA_CH_DESC_START_ADDRE_MASK		GENMASK(15, 0)
+#define XILINX_DPDMA_CH_DESC_START_ADDR			0x004
+#define XILINX_DPDMA_CH_DESC_NEXT_ADDRE			0x008
+#define XILINX_DPDMA_CH_DESC_NEXT_ADDR			0x00c
+#define XILINX_DPDMA_CH_PYLD_CUR_ADDRE			0x010
+#define XILINX_DPDMA_CH_PYLD_CUR_ADDR			0x014
+#define XILINX_DPDMA_CH_CNTL				0x018
+#define XILINX_DPDMA_CH_CNTL_ENABLE			BIT(0)
+#define XILINX_DPDMA_CH_CNTL_PAUSE			BIT(1)
+#define XILINX_DPDMA_CH_CNTL_QOS_DSCR_WR_MASK		GENMASK(5, 2)
+#define XILINX_DPDMA_CH_CNTL_QOS_DSCR_RD_MASK		GENMASK(9, 6)
+#define XILINX_DPDMA_CH_CNTL_QOS_DATA_RD_MASK		GENMASK(13, 10)
+#define XILINX_DPDMA_CH_CNTL_QOS_VID_CLASS		11
+#define XILINX_DPDMA_CH_STATUS				0x01c
+#define XILINX_DPDMA_CH_STATUS_OTRAN_CNT_MASK		GENMASK(24, 21)
+#define XILINX_DPDMA_CH_VDO				0x020
+#define XILINX_DPDMA_CH_PYLD_SZ				0x024
+#define XILINX_DPDMA_CH_DESC_ID				0x028
+
+/* DPDMA descriptor fields */
+#define XILINX_DPDMA_DESC_CONTROL_PREEMBLE		0xa5
+#define XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR		BIT(8)
+#define XILINX_DPDMA_DESC_CONTROL_DESC_UPDATE		BIT(9)
+#define XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE		BIT(10)
+#define XILINX_DPDMA_DESC_CONTROL_FRAG_MODE		BIT(18)
+#define XILINX_DPDMA_DESC_CONTROL_LAST			BIT(19)
+#define XILINX_DPDMA_DESC_CONTROL_ENABLE_CRC		BIT(20)
+#define XILINX_DPDMA_DESC_CONTROL_LAST_OF_FRAME		BIT(21)
+#define XILINX_DPDMA_DESC_ID_MASK			GENMASK(15, 0)
+#define XILINX_DPDMA_DESC_HSIZE_STRIDE_HSIZE_MASK	GENMASK(17, 0)
+#define XILINX_DPDMA_DESC_HSIZE_STRIDE_STRIDE_MASK	GENMASK(31, 18)
+#define XILINX_DPDMA_DESC_ADDR_EXT_NEXT_ADDR_MASK	GENMASK(15, 0)
+#define XILINX_DPDMA_DESC_ADDR_EXT_SRC_ADDR_MASK	GENMASK(31, 16)
+
+#define XILINX_DPDMA_ALIGN_BYTES			256
+#define XILINX_DPDMA_LINESIZE_ALIGN_BITS		128
+
+#define XILINX_DPDMA_NUM_CHAN				6
+
+/**
+ * struct xilinx_dpdma_hw_desc - DPDMA hardware descriptor
+ * @control: control configuration field
+ * @desc_id: descriptor ID
+ * @xfer_size: transfer size
+ * @hsize_stride: horizontal size and stride
+ * @timestamp_lsb: LSB of time stamp
+ * @timestamp_msb: MSB of time stamp
+ * @addr_ext: upper 16 bit of 48 bit address (next_desc and src_addr)
+ * @next_desc: next descriptor 32 bit address
+ * @src_addr: payload source address (1st page, 32 LSB)
+ * @addr_ext_23: payload source address (3nd and 3rd pages, 16 LSBs)
+ * @addr_ext_45: payload source address (4th and 5th pages, 16 LSBs)
+ * @src_addr2: payload source address (2nd page, 32 LSB)
+ * @src_addr3: payload source address (3rd page, 32 LSB)
+ * @src_addr4: payload source address (4th page, 32 LSB)
+ * @src_addr5: payload source address (5th page, 32 LSB)
+ * @crc: descriptor CRC
+ */
+struct xilinx_dpdma_hw_desc {
+	u32 control;
+	u32 desc_id;
+	u32 xfer_size;
+	u32 hsize_stride;
+	u32 timestamp_lsb;
+	u32 timestamp_msb;
+	u32 addr_ext;
+	u32 next_desc;
+	u32 src_addr;
+	u32 addr_ext_23;
+	u32 addr_ext_45;
+	u32 src_addr2;
+	u32 src_addr3;
+	u32 src_addr4;
+	u32 src_addr5;
+	u32 crc;
+} __aligned(XILINX_DPDMA_ALIGN_BYTES);
+
+/**
+ * struct xilinx_dpdma_sw_desc - DPDMA software descriptor
+ * @hw: DPDMA hardware descriptor
+ * @node: list node for software descriptors
+ * @dma_addr: DMA address of the software descriptor
+ */
+struct xilinx_dpdma_sw_desc {
+	struct xilinx_dpdma_hw_desc hw;
+	struct list_head node;
+	dma_addr_t dma_addr;
+};
+
+/**
+ * enum xilinx_dpdma_tx_desc_status - DPDMA tx descriptor status
+ * @PREPARED: descriptor is prepared for transaction
+ * @ACTIVE: transaction is (being) done successfully
+ * @ERRORED: descriptor generates some errors
+ */
+enum xilinx_dpdma_tx_desc_status {
+	PREPARED,
+	ACTIVE,
+	ERRORED
+};
+
+/**
+ * struct xilinx_dpdma_tx_desc - DPDMA transaction descriptor
+ * @async_tx: DMA async transaction descriptor
+ * @descriptors: list of software descriptors
+ * @node: list node for transaction descriptors
+ * @status: tx descriptor status
+ * @done_cnt: number of complete notification to deliver
+ */
+struct xilinx_dpdma_tx_desc {
+	struct dma_async_tx_descriptor async_tx;
+	struct list_head descriptors;
+	struct list_head node;
+	enum xilinx_dpdma_tx_desc_status status;
+	unsigned int done_cnt;
+};
+
+#define to_dpdma_tx_desc(tx) \
+	container_of(tx, struct xilinx_dpdma_tx_desc, async_tx)
+
+/**
+ * enum xilinx_dpdma_chan_status - DPDMA channel status
+ * @IDLE: idle state
+ * @STREAMING: actively streaming state
+ */
+enum xilinx_dpdma_chan_status {
+	IDLE,
+	STREAMING
+};
+
+/*
+ * DPDMA descriptor placement
+ * --------------------------
+ * DPDMA descritpor life time is described with following placements:
+ *
+ * allocated_desc -> submitted_desc -> pending_desc -> active_desc -> done_list
+ *
+ * Transition is triggered as following:
+ *
+ * -> allocated_desc : a descriptor allocation
+ * allocated_desc -> submitted_desc: a descriptor submission
+ * submitted_desc -> pending_desc: request to issue pending a descriptor
+ * pending_desc -> active_desc: VSYNC intr when a desc is scheduled to DPDMA
+ * active_desc -> done_list: VSYNC intr when DPDMA switches to a new desc
+ */
+
+/**
+ * struct xilinx_dpdma_chan - DPDMA channel
+ * @common: generic dma channel structure
+ * @reg: register base address
+ * @id: channel ID
+ * @wait_to_stop: queue to wait for outstanding transacitons before stopping
+ * @status: channel status
+ * @first_frame: flag for the first frame of stream
+ * @video_group: flag if multi-channel operation is needed for video channels
+ * @lock: lock to access struct xilinx_dpdma_chan
+ * @desc_pool: descriptor allocation pool
+ * @done_task: done IRQ bottom half handler
+ * @err_task: error IRQ bottom half handler
+ * @allocated_desc: allocated descriptor
+ * @submitted_desc: submitted descriptor
+ * @pending_desc: pending descriptor to be scheduled in next period
+ * @active_desc: descriptor that the DPDMA channel is active on
+ * @done_list: done descriptor list
+ * @xdev: DPDMA device
+ */
+struct xilinx_dpdma_chan {
+	struct dma_chan common;
+	void __iomem *reg;
+	unsigned int id;
+
+	wait_queue_head_t wait_to_stop;
+	enum xilinx_dpdma_chan_status status;
+	bool first_frame;
+	bool video_group;
+
+	spinlock_t lock; /* lock to access struct xilinx_dpdma_chan */
+	struct dma_pool *desc_pool;
+	struct tasklet_struct done_task;
+	struct tasklet_struct err_task;
+
+	struct xilinx_dpdma_tx_desc *allocated_desc;
+	struct xilinx_dpdma_tx_desc *submitted_desc;
+	struct xilinx_dpdma_tx_desc *pending_desc;
+	struct xilinx_dpdma_tx_desc *active_desc;
+	struct list_head done_list;
+
+	struct xilinx_dpdma_device *xdev;
+};
+
+#define to_xilinx_chan(chan) \
+	container_of(chan, struct xilinx_dpdma_chan, common)
+
+/**
+ * struct xilinx_dpdma_device - DPDMA device
+ * @common: generic dma device structure
+ * @reg: register base address
+ * @dev: generic device structure
+ * @irq: the interrupt number
+ * @axi_clk: axi clock
+ * @chan: DPDMA channels
+ * @ext_addr: flag for 64 bit system (48 bit addressing)
+ * @desc_addr: descriptor addressing callback (32 bit vs 64 bit)
+ */
+struct xilinx_dpdma_device {
+	struct dma_device common;
+	void __iomem *reg;
+	struct device *dev;
+	int irq;
+
+	struct clk *axi_clk;
+	struct xilinx_dpdma_chan *chan[XILINX_DPDMA_NUM_CHAN];
+
+	bool ext_addr;
+	void (*desc_addr)(struct xilinx_dpdma_sw_desc *sw_desc,
+			  struct xilinx_dpdma_sw_desc *prev,
+			  dma_addr_t dma_addr[], unsigned int num_src_addr);
+};
+
+/* -----------------------------------------------------------------------------
+ * I/O Accessors
+ */
+
+static inline u32 dpdma_read(void __iomem *base, u32 offset)
+{
+	return ioread32(base + offset);
+}
+
+static inline void dpdma_write(void __iomem *base, u32 offset, u32 val)
+{
+	iowrite32(val, base + offset);
+}
+
+static inline void dpdma_clr(void __iomem *base, u32 offset, u32 clr)
+{
+	dpdma_write(base, offset, dpdma_read(base, offset) & ~clr);
+}
+
+static inline void dpdma_set(void __iomem *base, u32 offset, u32 set)
+{
+	dpdma_write(base, offset, dpdma_read(base, offset) | set);
+}
+
+/* -----------------------------------------------------------------------------
+ * Descriptor Operations
+ */
+
+/**
+ * xilinx_dpdma_sw_desc_next_32 - Set 32 bit address of a next sw descriptor
+ * @sw_desc: current software descriptor
+ * @next: next descriptor
+ *
+ * Update the current sw descriptor @sw_desc with 32 bit address of the next
+ * descriptor @next.
+ */
+static void xilinx_dpdma_sw_desc_next_32(struct xilinx_dpdma_sw_desc *sw_desc,
+					 struct xilinx_dpdma_sw_desc *next)
+{
+	sw_desc->hw.next_desc = next->dma_addr;
+}
+
+/**
+ * xilinx_dpdma_sw_desc_addr_32 - Update the sw descriptor with 32 bit address
+ * @sw_desc: software descriptor
+ * @prev: previous descriptor
+ * @dma_addr: array of dma addresses
+ * @num_src_addr: number of addresses in @dma_addr
+ *
+ * Update the descriptor @sw_desc with 32 bit address.
+ */
+static void xilinx_dpdma_sw_desc_addr_32(struct xilinx_dpdma_sw_desc *sw_desc,
+					 struct xilinx_dpdma_sw_desc *prev,
+					 dma_addr_t dma_addr[],
+					 unsigned int num_src_addr)
+{
+	struct xilinx_dpdma_hw_desc *hw_desc = &sw_desc->hw;
+	unsigned int i;
+
+	hw_desc->src_addr = dma_addr[0];
+
+	if (prev)
+		xilinx_dpdma_sw_desc_next_32(prev, sw_desc);
+
+	for (i = 1; i < num_src_addr; i++) {
+		u32 *addr = &hw_desc->src_addr2;
+		u32 frag_addr;
+
+		frag_addr = dma_addr[i];
+		addr[i - 1] = frag_addr;
+	}
+}
+
+/**
+ * xilinx_dpdma_sw_desc_next_64 - Set 64 bit address of a next sw descriptor
+ * @sw_desc: current software descriptor
+ * @next: next descriptor
+ *
+ * Update the current sw descriptor @sw_desc with 64 bit address of the next
+ * descriptor @next.
+ */
+static void xilinx_dpdma_sw_desc_next_64(struct xilinx_dpdma_sw_desc *sw_desc,
+					 struct xilinx_dpdma_sw_desc *next)
+{
+	sw_desc->hw.next_desc = lower_32_bits(next->dma_addr);
+	sw_desc->hw.addr_ext |=
+		FIELD_PREP(XILINX_DPDMA_DESC_ADDR_EXT_NEXT_ADDR_MASK,
+			   upper_32_bits(next->dma_addr));
+}
+
+/**
+ * xilinx_dpdma_sw_desc_addr_64 - Update the sw descriptor with 64 bit address
+ * @sw_desc: software descriptor
+ * @prev: previous descriptor
+ * @dma_addr: array of dma addresses
+ * @num_src_addr: number of addresses in @dma_addr
+ *
+ * Update the descriptor @sw_desc with 64 bit address.
+ */
+static void xilinx_dpdma_sw_desc_addr_64(struct xilinx_dpdma_sw_desc *sw_desc,
+					 struct xilinx_dpdma_sw_desc *prev,
+					 dma_addr_t dma_addr[],
+					 unsigned int num_src_addr)
+{
+	struct xilinx_dpdma_hw_desc *hw_desc = &sw_desc->hw;
+	unsigned int i;
+
+	hw_desc->src_addr = lower_32_bits(dma_addr[0]);
+	hw_desc->addr_ext |=
+		FIELD_PREP(XILINX_DPDMA_DESC_ADDR_EXT_SRC_ADDR_MASK,
+			   upper_32_bits(dma_addr[0]));
+
+	if (prev)
+		xilinx_dpdma_sw_desc_next_64(prev, sw_desc);
+
+	for (i = 1; i < num_src_addr; i++) {
+		u32 *addr = &hw_desc->src_addr2;
+		u32 *addr_ext = &hw_desc->addr_ext_23;
+		u32 addr_msb;
+
+		addr[i] = lower_32_bits(dma_addr[i]);
+
+		addr_msb = upper_32_bits(dma_addr[i]) & GENMASK(15, 0);
+		addr_msb <<= 16 * ((i - 1) % 2);
+		addr_ext[(i - 1) / 2] |= addr_msb;
+	}
+}
+
+/**
+ * xilinx_dpdma_chan_alloc_sw_desc - Allocate a software descriptor
+ * @chan: DPDMA channel
+ *
+ * Allocate a software descriptor from the channel's descriptor pool.
+ *
+ * Return: a software descriptor or NULL.
+ */
+static struct xilinx_dpdma_sw_desc *
+xilinx_dpdma_chan_alloc_sw_desc(struct xilinx_dpdma_chan *chan)
+{
+	struct xilinx_dpdma_sw_desc *sw_desc;
+	dma_addr_t dma_addr;
+
+	sw_desc = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &dma_addr);
+	if (!sw_desc)
+		return NULL;
+
+	sw_desc->dma_addr = dma_addr;
+
+	return sw_desc;
+}
+
+/**
+ * xilinx_dpdma_chan_free_sw_desc - Free a software descriptor
+ * @chan: DPDMA channel
+ * @sw_desc: software descriptor to free
+ *
+ * Free a software descriptor from the channel's descriptor pool.
+ */
+static void
+xilinx_dpdma_chan_free_sw_desc(struct xilinx_dpdma_chan *chan,
+			       struct xilinx_dpdma_sw_desc *sw_desc)
+{
+	dma_pool_free(chan->desc_pool, sw_desc, sw_desc->dma_addr);
+}
+
+/**
+ * xilinx_dpdma_chan_dump_tx_desc - Dump a tx descriptor
+ * @chan: DPDMA channel
+ * @tx_desc: tx descriptor to dump
+ *
+ * Dump contents of a tx descriptor
+ */
+static void xilinx_dpdma_chan_dump_tx_desc(struct xilinx_dpdma_chan *chan,
+					   struct xilinx_dpdma_tx_desc *tx_desc)
+{
+	struct xilinx_dpdma_sw_desc *sw_desc;
+	struct device *dev = chan->xdev->dev;
+	unsigned int i = 0;
+
+	dev_dbg(dev, "------- TX descriptor dump start -------\n");
+	dev_dbg(dev, "------- channel ID = %d -------\n", chan->id);
+
+	list_for_each_entry(sw_desc, &tx_desc->descriptors, node) {
+		struct xilinx_dpdma_hw_desc *hw_desc = &sw_desc->hw;
+
+		dev_dbg(dev, "------- HW descriptor %d -------\n", i++);
+		dev_dbg(dev, "descriptor DMA addr: %pad\n", &sw_desc->dma_addr);
+		dev_dbg(dev, "control: 0x%08x\n", hw_desc->control);
+		dev_dbg(dev, "desc_id: 0x%08x\n", hw_desc->desc_id);
+		dev_dbg(dev, "xfer_size: 0x%08x\n", hw_desc->xfer_size);
+		dev_dbg(dev, "hsize_stride: 0x%08x\n", hw_desc->hsize_stride);
+		dev_dbg(dev, "timestamp_lsb: 0x%08x\n", hw_desc->timestamp_lsb);
+		dev_dbg(dev, "timestamp_msb: 0x%08x\n", hw_desc->timestamp_msb);
+		dev_dbg(dev, "addr_ext: 0x%08x\n", hw_desc->addr_ext);
+		dev_dbg(dev, "next_desc: 0x%08x\n", hw_desc->next_desc);
+		dev_dbg(dev, "src_addr: 0x%08x\n", hw_desc->src_addr);
+		dev_dbg(dev, "addr_ext_23: 0x%08x\n", hw_desc->addr_ext_23);
+		dev_dbg(dev, "addr_ext_45: 0x%08x\n", hw_desc->addr_ext_45);
+		dev_dbg(dev, "src_addr2: 0x%08x\n", hw_desc->src_addr2);
+		dev_dbg(dev, "src_addr3: 0x%08x\n", hw_desc->src_addr3);
+		dev_dbg(dev, "src_addr4: 0x%08x\n", hw_desc->src_addr4);
+		dev_dbg(dev, "src_addr5: 0x%08x\n", hw_desc->src_addr5);
+		dev_dbg(dev, "crc: 0x%08x\n", hw_desc->crc);
+	}
+
+	dev_dbg(dev, "------- TX descriptor dump end -------\n");
+}
+
+/**
+ * xilinx_dpdma_chan_alloc_tx_desc - Allocate a transaction descriptor
+ * @chan: DPDMA channel
+ *
+ * Allocate a tx descriptor.
+ *
+ * Return: a tx descriptor or NULL.
+ */
+static struct xilinx_dpdma_tx_desc *
+xilinx_dpdma_chan_alloc_tx_desc(struct xilinx_dpdma_chan *chan)
+{
+	struct xilinx_dpdma_tx_desc *tx_desc;
+
+	tx_desc = kzalloc(sizeof(*tx_desc), GFP_KERNEL);
+	if (!tx_desc)
+		return NULL;
+
+	INIT_LIST_HEAD(&tx_desc->descriptors);
+	tx_desc->status = PREPARED;
+
+	return tx_desc;
+}
+
+/**
+ * xilinx_dpdma_chan_free_tx_desc - Free a transaction descriptor
+ * @chan: DPDMA channel
+ * @tx_desc: tx descriptor
+ *
+ * Free the tx descriptor @tx_desc including its software descriptors.
+ */
+static void
+xilinx_dpdma_chan_free_tx_desc(struct xilinx_dpdma_chan *chan,
+			       struct xilinx_dpdma_tx_desc *tx_desc)
+{
+	struct xilinx_dpdma_sw_desc *sw_desc, *next;
+
+	if (!tx_desc)
+		return;
+
+	list_for_each_entry_safe(sw_desc, next, &tx_desc->descriptors, node) {
+		list_del(&sw_desc->node);
+		xilinx_dpdma_chan_free_sw_desc(chan, sw_desc);
+	}
+
+	kfree(tx_desc);
+}
+
+/**
+ * xilinx_dpdma_chan_free_desc_list - Free a descriptor list
+ * @chan: DPDMA channel
+ * @list: tx descriptor list
+ *
+ * Free tx descriptors in the list @list.
+ */
+static void xilinx_dpdma_chan_free_desc_list(struct xilinx_dpdma_chan *chan,
+					     struct list_head *list)
+{
+	struct xilinx_dpdma_tx_desc *tx_desc, *next;
+
+	list_for_each_entry_safe(tx_desc, next, list, node) {
+		list_del(&tx_desc->node);
+		xilinx_dpdma_chan_free_tx_desc(chan, tx_desc);
+	}
+}
+
+/**
+ * xilinx_dpdma_chan_free_all_desc - Free all descriptors of the channel
+ * @chan: DPDMA channel
+ *
+ * Free all descriptors associated with the channel. The channel should be
+ * disabled before this function is called, otherwise, this function may
+ * result in misbehavior of the system due to remaining outstanding
+ * transactions.
+ */
+static void xilinx_dpdma_chan_free_all_desc(struct xilinx_dpdma_chan *chan)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	dev_dbg(chan->xdev->dev, "chan->status = %s\n",
+		chan->status == STREAMING ? "STREAMING" : "IDLE");
+
+	xilinx_dpdma_chan_free_tx_desc(chan, chan->allocated_desc);
+	chan->allocated_desc = NULL;
+	xilinx_dpdma_chan_free_tx_desc(chan, chan->submitted_desc);
+	chan->submitted_desc = NULL;
+	xilinx_dpdma_chan_free_tx_desc(chan, chan->pending_desc);
+	chan->pending_desc = NULL;
+	xilinx_dpdma_chan_free_tx_desc(chan, chan->active_desc);
+	chan->active_desc = NULL;
+	xilinx_dpdma_chan_free_desc_list(chan, &chan->done_list);
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/**
+ * xilinx_dpdma_chan_cleanup_desc - Clean up descriptors
+ * @chan: DPDMA channel
+ *
+ * Trigger the complete callbacks of descriptors with finished transactions.
+ * Free descriptors which are no longer in use.
+ */
+static void xilinx_dpdma_chan_cleanup_desc(struct xilinx_dpdma_chan *chan)
+{
+	struct xilinx_dpdma_tx_desc *desc;
+	dma_async_tx_callback callback;
+	void *callback_param;
+	unsigned long flags;
+	unsigned int cnt, i;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	while (!list_empty(&chan->done_list)) {
+		desc = list_first_entry(&chan->done_list,
+					struct xilinx_dpdma_tx_desc, node);
+		list_del(&desc->node);
+
+		cnt = desc->done_cnt;
+		desc->done_cnt = 0;
+		callback = desc->async_tx.callback;
+		callback_param = desc->async_tx.callback_param;
+		if (callback) {
+			spin_unlock_irqrestore(&chan->lock, flags);
+			for (i = 0; i < cnt; i++)
+				callback(callback_param);
+			spin_lock_irqsave(&chan->lock, flags);
+		}
+
+		xilinx_dpdma_chan_free_tx_desc(chan, desc);
+	}
+
+	if (chan->active_desc) {
+		cnt = chan->active_desc->done_cnt;
+		chan->active_desc->done_cnt = 0;
+		callback = chan->active_desc->async_tx.callback;
+		callback_param = chan->active_desc->async_tx.callback_param;
+		if (callback) {
+			spin_unlock_irqrestore(&chan->lock, flags);
+			for (i = 0; i < cnt; i++)
+				callback(callback_param);
+			spin_lock_irqsave(&chan->lock, flags);
+		}
+	}
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/**
+ * xilinx_dpdma_chan_desc_active - Set the descriptor as active
+ * @chan: DPDMA channel
+ *
+ * Make the pending descriptor @chan->pending_desc as active. This function
+ * should be called when the channel starts operating on the pending descriptor.
+ */
+static void xilinx_dpdma_chan_desc_active(struct xilinx_dpdma_chan *chan)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	if (!chan->pending_desc)
+		goto out_unlock;
+
+	if (chan->active_desc)
+		list_add_tail(&chan->active_desc->node, &chan->done_list);
+
+	chan->active_desc = chan->pending_desc;
+	chan->pending_desc = NULL;
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/**
+ * xilinx_dpdma_chan_desc_done_intr - Mark the current descriptor as 'done'
+ * @chan: DPDMA channel
+ *
+ * Mark the current active descriptor @chan->active_desc as 'done'. This
+ * function should be called to mark completion of the currently active
+ * descriptor.
+ */
+static void xilinx_dpdma_chan_desc_done_intr(struct xilinx_dpdma_chan *chan)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	if (!chan->active_desc) {
+		dev_dbg(chan->xdev->dev, "done intr with no active desc\n");
+		goto out_unlock;
+	}
+
+	chan->active_desc->done_cnt++;
+	if (chan->active_desc->status ==  PREPARED) {
+		dma_cookie_complete(&chan->active_desc->async_tx);
+		chan->active_desc->status = ACTIVE;
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->lock, flags);
+	tasklet_schedule(&chan->done_task);
+}
+
+/**
+ * xilinx_dpdma_chan_prep_slave_sg - Prepare a scatter-gather dma descriptor
+ * @chan: DPDMA channel
+ * @sgl: scatter-gather list
+ *
+ * Prepare a tx descriptor including internal software/hardware descriptors
+ * for the given scatter-gather transaction.
+ *
+ * The hardware supports transferring up to 5 4096-bytes pages per descriptor.
+ * This is meant to transfer an image with one descriptor per line, without
+ * requiring each line to be contiguous in memory. The number of bytes
+ * transferred for each page is calculated automatically from the total line
+ * size: the first page contains data from the beginning of the line to the next
+ * 4K page boundary (lines thus don't need to be aligned on a page boundary, but
+ * must still be aligned on a 256 bytes boundary), and all subsequent pages but
+ * the last one are exactly 4KB long. The last page can have any size.
+ *
+ * Return: A dma async tx descriptor on success, or NULL.
+ */
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_chan_prep_slave_sg(struct xilinx_dpdma_chan *chan,
+				struct scatterlist *sgl)
+{
+	struct xilinx_dpdma_tx_desc *tx_desc;
+	struct xilinx_dpdma_sw_desc *sw_desc, *last = NULL;
+
+	if (chan->allocated_desc)
+		return &chan->allocated_desc->async_tx;
+
+	tx_desc = xilinx_dpdma_chan_alloc_tx_desc(chan);
+	if (!tx_desc)
+		return NULL;
+
+	while (sgl) {
+		struct xilinx_dpdma_hw_desc *hw_desc;
+		dma_addr_t dma_addrs[5];
+		unsigned int num_pages = 0;
+		u32 line_size = 0;
+
+		while (!sg_is_chain(sgl)) {
+			dma_addr_t dma_addr = sg_dma_address(sgl);
+			unsigned int length = sg_dma_len(sgl);
+			bool invalid_size = false;
+
+			if (num_pages >= ARRAY_SIZE(dma_addrs)) {
+				dev_err(chan->xdev->dev,
+					"maximum %lu pages per line\n",
+					ARRAY_SIZE(dma_addrs));
+				goto error;
+			}
+
+			if (!IS_ALIGNED(dma_addr, XILINX_DPDMA_ALIGN_BYTES)) {
+				dev_err(chan->xdev->dev,
+					"buffer must be aligned to %u bytes\n",
+					XILINX_DPDMA_ALIGN_BYTES);
+				goto error;
+			}
+
+			/* Validate the page length. */
+			if (sg_is_last(sgl)) {
+				/*
+				 * The last page can have any size up to 4096
+				 * bytes.
+				 */
+				if (length > 4096)
+					invalid_size = true;
+			} else if (num_pages > 0) {
+				/*
+				 * Intermediate pages must be 4096 bytes long
+				 * exactly.
+				 */
+				if (length != 4096)
+					invalid_size = true;
+			} else {
+				/*
+				 * The first (and not last) page must end at the
+				 * next 4096 bytes boundary.
+				 */
+				if ((dma_addr & 4095) + length != 4096)
+					invalid_size = true;
+			}
+
+			if (invalid_size) {
+				dev_err(chan->xdev->dev,
+					"invalid page %u size: %u bytes\n",
+					num_pages, length);
+				goto error;
+			}
+
+			dma_addrs[num_pages++] = dma_addr;
+			line_size += length;
+
+			if (sg_is_last(sgl))
+				break;
+
+			sgl++;
+		}
+
+		sw_desc = xilinx_dpdma_chan_alloc_sw_desc(chan);
+		if (!sw_desc)
+			goto error;
+
+		chan->xdev->desc_addr(sw_desc, last, dma_addrs, num_pages);
+		hw_desc = &sw_desc->hw;
+		hw_desc->xfer_size = line_size;
+		hw_desc->hsize_stride =
+			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_HSIZE_MASK,
+				   line_size);
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_PREEMBLE;
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_FRAG_MODE;
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE;
+
+		list_add_tail(&sw_desc->node, &tx_desc->descriptors);
+		last = sw_desc;
+
+		if (sg_is_last(sgl))
+			break;
+
+		sgl = sg_chain_ptr(sgl);
+	}
+
+	sw_desc = list_first_entry(&tx_desc->descriptors,
+				   struct xilinx_dpdma_sw_desc, node);
+	if (chan->xdev->ext_addr)
+		xilinx_dpdma_sw_desc_next_64(last, sw_desc);
+	else
+		xilinx_dpdma_sw_desc_next_32(last, sw_desc);
+	last->hw.control |= XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR;
+	last->hw.control |= XILINX_DPDMA_DESC_CONTROL_LAST_OF_FRAME;
+
+	chan->allocated_desc = tx_desc;
+
+	return &tx_desc->async_tx;
+
+error:
+	xilinx_dpdma_chan_free_tx_desc(chan, tx_desc);
+
+	return NULL;
+}
+
+/**
+ * xilinx_dpdma_chan_prep_cyclic - Prepare a cyclic dma descriptor
+ * @chan: DPDMA channel
+ * @buf_addr: buffer address
+ * @buf_len: buffer length
+ * @period_len: number of periods
+ *
+ * Prepare a tx descriptor incudling internal software/hardware descriptors
+ * for the given cyclic transaction.
+ *
+ * Return: A dma async tx descriptor on success, or NULL.
+ */
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_chan_prep_cyclic(struct xilinx_dpdma_chan *chan,
+			      dma_addr_t buf_addr, size_t buf_len,
+			      size_t period_len)
+{
+	struct xilinx_dpdma_tx_desc *tx_desc;
+	struct xilinx_dpdma_sw_desc *sw_desc, *last = NULL;
+	unsigned int periods = buf_len / period_len;
+	unsigned int i;
+
+	if (chan->allocated_desc)
+		return &chan->allocated_desc->async_tx;
+
+	tx_desc = xilinx_dpdma_chan_alloc_tx_desc(chan);
+	if (!tx_desc)
+		return NULL;
+
+	for (i = 0; i < periods; i++) {
+		struct xilinx_dpdma_hw_desc *hw_desc;
+
+		if (!IS_ALIGNED(buf_addr, XILINX_DPDMA_ALIGN_BYTES)) {
+			dev_err(chan->xdev->dev,
+				"buffer should be aligned at %d B\n",
+				XILINX_DPDMA_ALIGN_BYTES);
+			goto error;
+		}
+
+		sw_desc = xilinx_dpdma_chan_alloc_sw_desc(chan);
+		if (!sw_desc)
+			goto error;
+
+		chan->xdev->desc_addr(sw_desc, last, &buf_addr, 1);
+		hw_desc = &sw_desc->hw;
+		hw_desc->xfer_size = period_len;
+		hw_desc->hsize_stride =
+			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_HSIZE_MASK,
+				   period_len) |
+			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_STRIDE_MASK,
+				   period_len);
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_PREEMBLE;
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE;
+		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR;
+
+		list_add_tail(&sw_desc->node, &tx_desc->descriptors);
+
+		buf_addr += period_len;
+		last = sw_desc;
+	}
+
+	sw_desc = list_first_entry(&tx_desc->descriptors,
+				   struct xilinx_dpdma_sw_desc, node);
+	if (chan->xdev->ext_addr)
+		xilinx_dpdma_sw_desc_next_64(last, sw_desc);
+	else
+		xilinx_dpdma_sw_desc_next_32(last, sw_desc);
+	last->hw.control |= XILINX_DPDMA_DESC_CONTROL_LAST_OF_FRAME;
+
+	chan->allocated_desc = tx_desc;
+
+	return &tx_desc->async_tx;
+
+error:
+	xilinx_dpdma_chan_free_tx_desc(chan, tx_desc);
+
+	return NULL;
+}
+
+/**
+ * xilinx_dpdma_chan_prep_interleaved - Prepare a interleaved dma descriptor
+ * @chan: DPDMA channel
+ * @xt: dma interleaved template
+ *
+ * Prepare a tx descriptor incudling internal software/hardware descriptors
+ * based on @xt.
+ *
+ * Return: A dma async tx descriptor on success, or NULL.
+ */
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_chan_prep_interleaved(struct xilinx_dpdma_chan *chan,
+				   struct dma_interleaved_template *xt)
+{
+	struct xilinx_dpdma_tx_desc *tx_desc;
+	struct xilinx_dpdma_sw_desc *sw_desc;
+	struct xilinx_dpdma_hw_desc *hw_desc;
+	size_t hsize = xt->sgl[0].size;
+	size_t stride = hsize + xt->sgl[0].icg;
+
+	if (!IS_ALIGNED(xt->src_start, XILINX_DPDMA_ALIGN_BYTES)) {
+		dev_err(chan->xdev->dev, "buffer should be aligned at %d B\n",
+			XILINX_DPDMA_ALIGN_BYTES);
+		return NULL;
+	}
+
+	if (chan->allocated_desc)
+		return &chan->allocated_desc->async_tx;
+
+	tx_desc = xilinx_dpdma_chan_alloc_tx_desc(chan);
+	if (!tx_desc)
+		return NULL;
+
+	sw_desc = xilinx_dpdma_chan_alloc_sw_desc(chan);
+	if (!sw_desc)
+		goto error;
+
+	chan->xdev->desc_addr(sw_desc, sw_desc, &xt->src_start, 1);
+	hw_desc = &sw_desc->hw;
+	hsize = ALIGN(hsize, XILINX_DPDMA_LINESIZE_ALIGN_BITS / 8);
+	hw_desc->xfer_size = hsize * xt->numf;
+	hw_desc->hsize_stride =
+		FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_HSIZE_MASK, hsize) |
+		FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_STRIDE_MASK,
+			   stride / 16);
+	hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_PREEMBLE;
+	hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR;
+	hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE;
+	hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_LAST_OF_FRAME;
+
+	list_add_tail(&sw_desc->node, &tx_desc->descriptors);
+	chan->allocated_desc = tx_desc;
+
+	return &tx_desc->async_tx;
+
+error:
+	xilinx_dpdma_chan_free_tx_desc(chan, tx_desc);
+
+	return NULL;
+}
+
+/* -----------------------------------------------------------------------------
+ * DPDMA Channel Operations
+ */
+
+/**
+ * xilinx_dpdma_chan_enable - Enable the channel
+ * @chan: DPDMA channel
+ *
+ * Enable the channel and its interrupts. Set the QoS values for video class.
+ */
+static void xilinx_dpdma_chan_enable(struct xilinx_dpdma_chan *chan)
+{
+	u32 reg;
+
+	reg = (XILINX_DPDMA_INTR_CHAN_MASK << chan->id)
+	    | XILINX_DPDMA_INTR_GLOBAL_MASK;
+	dpdma_write(chan->xdev->reg, XILINX_DPDMA_IEN, reg);
+	reg = (XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id)
+	    | XILINX_DPDMA_INTR_GLOBAL_ERR;
+	dpdma_write(chan->xdev->reg, XILINX_DPDMA_EIEN, reg);
+
+	reg = XILINX_DPDMA_CH_CNTL_ENABLE
+	    | FIELD_PREP(XILINX_DPDMA_CH_CNTL_QOS_DSCR_WR_MASK,
+			 XILINX_DPDMA_CH_CNTL_QOS_VID_CLASS)
+	    | FIELD_PREP(XILINX_DPDMA_CH_CNTL_QOS_DSCR_RD_MASK,
+			 XILINX_DPDMA_CH_CNTL_QOS_VID_CLASS)
+	    | FIELD_PREP(XILINX_DPDMA_CH_CNTL_QOS_DATA_RD_MASK,
+			 XILINX_DPDMA_CH_CNTL_QOS_VID_CLASS);
+	dpdma_set(chan->reg, XILINX_DPDMA_CH_CNTL, reg);
+}
+
+/**
+ * xilinx_dpdma_chan_disable - Disable the channel
+ * @chan: DPDMA channel
+ *
+ * Disable the channel and its interrupts.
+ */
+static void xilinx_dpdma_chan_disable(struct xilinx_dpdma_chan *chan)
+{
+	u32 reg;
+
+	reg = XILINX_DPDMA_INTR_CHAN_MASK << chan->id;
+	dpdma_write(chan->xdev->reg, XILINX_DPDMA_IEN, reg);
+	reg = XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id;
+	dpdma_write(chan->xdev->reg, XILINX_DPDMA_EIEN, reg);
+
+	dpdma_clr(chan->reg, XILINX_DPDMA_CH_CNTL, XILINX_DPDMA_CH_CNTL_ENABLE);
+}
+
+/**
+ * xilinx_dpdma_chan_pause - Pause the channel
+ * @chan: DPDMA channel
+ *
+ * Pause the channel.
+ */
+static void xilinx_dpdma_chan_pause(struct xilinx_dpdma_chan *chan)
+{
+	dpdma_set(chan->reg, XILINX_DPDMA_CH_CNTL, XILINX_DPDMA_CH_CNTL_PAUSE);
+}
+
+/**
+ * xilinx_dpdma_chan_unpause - Unpause the channel
+ * @chan: DPDMA channel
+ *
+ * Unpause the channel.
+ */
+static void xilinx_dpdma_chan_unpause(struct xilinx_dpdma_chan *chan)
+{
+	dpdma_clr(chan->reg, XILINX_DPDMA_CH_CNTL, XILINX_DPDMA_CH_CNTL_PAUSE);
+}
+
+static u32 xilinx_dpdma_chan_video_group_ready(struct xilinx_dpdma_chan *chan)
+{
+	struct xilinx_dpdma_device *xdev = chan->xdev;
+	u32 i = 0, ret = 0;
+
+	for (i = ZYNQMP_DPDMA_VIDEO0; i < ZYNQMP_DPDMA_GRAPHICS; i++) {
+		if (xdev->chan[i]->video_group &&
+		    xdev->chan[i]->status != STREAMING)
+			return 0;
+
+		if (xdev->chan[i]->video_group)
+			ret |= BIT(i);
+	}
+
+	return ret;
+}
+
+/**
+ * xilinx_dpdma_chan_issue_pending - Issue the pending descriptor
+ * @chan: DPDMA channel
+ *
+ * Issue the first pending descriptor from @chan->submitted_desc. If the channel
+ * is already streaming, the channel is re-triggered with the pending
+ * descriptor.
+ */
+static void xilinx_dpdma_chan_issue_pending(struct xilinx_dpdma_chan *chan)
+{
+	struct xilinx_dpdma_device *xdev = chan->xdev;
+	struct xilinx_dpdma_sw_desc *sw_desc;
+	unsigned long flags;
+	u32 reg, channels;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	if (!chan->submitted_desc || chan->pending_desc)
+		goto out_unlock;
+
+	chan->pending_desc = chan->submitted_desc;
+	chan->submitted_desc = NULL;
+
+	sw_desc = list_first_entry(&chan->pending_desc->descriptors,
+				   struct xilinx_dpdma_sw_desc, node);
+	dpdma_write(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDR,
+		    (u32)sw_desc->dma_addr);
+	if (xdev->ext_addr)
+		dpdma_write(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDRE,
+			    FIELD_PREP(XILINX_DPDMA_CH_DESC_START_ADDRE_MASK,
+				       (u64)sw_desc->dma_addr >> 32));
+
+	if (chan->first_frame) {
+		chan->first_frame = false;
+		if (chan->video_group) {
+			channels = xilinx_dpdma_chan_video_group_ready(chan);
+			if (!channels)
+				goto out_unlock;
+			reg = XILINX_DPDMA_GBL_TRIG_MASK(channels);
+		} else {
+			reg = XILINX_DPDMA_GBL_TRIG_MASK(BIT(chan->id));
+		}
+	} else {
+		if (chan->video_group) {
+			channels = xilinx_dpdma_chan_video_group_ready(chan);
+			if (!channels)
+				goto out_unlock;
+			reg = XILINX_DPDMA_GBL_RETRIG_MASK(channels);
+		} else {
+			reg = XILINX_DPDMA_GBL_RETRIG_MASK(BIT(chan->id));
+		}
+	}
+
+	dpdma_write(xdev->reg, XILINX_DPDMA_GBL, reg);
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/**
+ * xilinx_dpdma_chan_start - Start the channel
+ * @chan: DPDMA channel
+ *
+ * Start the channel by enabling interrupts and triggering the channel.
+ * If the channel is enabled already or there's no pending descriptor, this
+ * function won't do anything on the channel.
+ */
+static void xilinx_dpdma_chan_start(struct xilinx_dpdma_chan *chan)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	if (!chan->submitted_desc || chan->status == STREAMING)
+		goto out_unlock;
+
+	xilinx_dpdma_chan_unpause(chan);
+	xilinx_dpdma_chan_enable(chan);
+	chan->first_frame = true;
+	chan->status = STREAMING;
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/**
+ * xilinx_dpdma_chan_ostand - Number of outstanding transactions
+ * @chan: DPDMA channel
+ *
+ * Read and return the number of outstanding transactions from register.
+ *
+ * Return: Number of outstanding transactions from the status register.
+ */
+static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
+{
+	return FIELD_GET(XILINX_DPDMA_CH_STATUS_OTRAN_CNT_MASK,
+			 dpdma_read(chan->reg, XILINX_DPDMA_CH_STATUS));
+}
+
+/**
+ * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
+ * @chan: DPDMA channel
+ *
+ * Notify waiters for no outstanding event, so waiters can stop the channel
+ * safely. This function is supposed to be called when 'no outstanding'
+ * interrupt is generated. The 'no outstanding' interrupt is disabled and
+ * should be re-enabled when this event is handled. If the channel status
+ * register still shows some number of outstanding transactions, the interrupt
+ * remains enabled.
+ *
+ * Return: 0 on success. On failure, -EWOULDBLOCK if there's still outstanding
+ * transaction(s).
+ */
+static int xilinx_dpdma_chan_notify_no_ostand(struct xilinx_dpdma_chan *chan)
+{
+	u32 cnt;
+
+	cnt = xilinx_dpdma_chan_ostand(chan);
+	if (cnt) {
+		dev_dbg(chan->xdev->dev, "%d outstanding transactions\n", cnt);
+		return -EWOULDBLOCK;
+	}
+
+	/* Disable 'no outstanding' interrupt */
+	dpdma_write(chan->xdev->reg, XILINX_DPDMA_IDS,
+		    XILINX_DPDMA_INTR_NO_OSTAND(chan->id));
+	wake_up(&chan->wait_to_stop);
+
+	return 0;
+}
+
+/**
+ * xilinx_dpdma_chan_wait_no_ostand - Wait for the no outstanding intr
+ * @chan: DPDMA channel
+ *
+ * Wait for the no outstanding transaction interrupt. This functions can sleep
+ * for 50ms.
+ *
+ * Return: 0 on success. On failure, -ETIMEOUT for time out, or the error code
+ * from wait_event_interruptible_timeout().
+ */
+static int xilinx_dpdma_chan_wait_no_ostand(struct xilinx_dpdma_chan *chan)
+{
+	int ret;
+
+	/* Wait for a no outstanding transaction interrupt upto 50msec */
+	ret = wait_event_interruptible_timeout(chan->wait_to_stop,
+					       !xilinx_dpdma_chan_ostand(chan),
+					       msecs_to_jiffies(50));
+	if (ret > 0) {
+		dpdma_write(chan->xdev->reg, XILINX_DPDMA_IEN,
+			    XILINX_DPDMA_INTR_NO_OSTAND(chan->id));
+		return 0;
+	}
+
+	dev_err(chan->xdev->dev, "not ready to stop: %d trans\n",
+		xilinx_dpdma_chan_ostand(chan));
+
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	return ret;
+}
+
+/**
+ * xilinx_dpdma_chan_poll_no_ostand - Poll the outstanding transaction status
+ * @chan: DPDMA channel
+ *
+ * Poll the outstanding transaction status, and return when there's no
+ * outstanding transaction. This functions can be used in the interrupt context
+ * or where the atomicity is required. Calling thread may wait more than 50ms.
+ *
+ * Return: 0 on success, or -ETIMEDOUT.
+ */
+static int xilinx_dpdma_chan_poll_no_ostand(struct xilinx_dpdma_chan *chan)
+{
+	u32 cnt, loop = 50000;
+
+	/* Poll at least for 50ms (20 fps). */
+	do {
+		cnt = xilinx_dpdma_chan_ostand(chan);
+		udelay(1);
+	} while (loop-- > 0 && cnt);
+
+	if (loop) {
+		dpdma_write(chan->xdev->reg, XILINX_DPDMA_IEN,
+			    XILINX_DPDMA_INTR_NO_OSTAND(chan->id));
+		return 0;
+	}
+
+	dev_err(chan->xdev->dev, "not ready to stop: %d trans\n",
+		xilinx_dpdma_chan_ostand(chan));
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * xilinx_dpdma_chan_stop - Stop the channel
+ * @chan: DPDMA channel
+ * @poll: flag whether to poll or wait
+ *
+ * Stop the channel with the following sequence: 1. Pause, 2. Wait (sleep) for
+ * no outstanding transaction interrupt, 3. Disable the channel.
+ *
+ * If the channel is part of a video group, all channels from the group are
+ * paused.
+ *
+ * Return: 0 on success, or -ETIMEDOUT if the channel failed to stop.
+ */
+static int xilinx_dpdma_chan_stop(struct xilinx_dpdma_chan *chan, bool poll)
+{
+	struct xilinx_dpdma_device *xdev = chan->xdev;
+	unsigned long flags;
+	unsigned int i;
+	int ret;
+
+	if (chan->video_group) {
+		for (i = ZYNQMP_DPDMA_VIDEO0; i < ZYNQMP_DPDMA_GRAPHICS; i++) {
+			if (xdev->chan[i]->video_group &&
+			    xdev->chan[i]->status == STREAMING) {
+				xilinx_dpdma_chan_pause(xdev->chan[i]);
+				xdev->chan[i]->video_group = false;
+			}
+		}
+	}
+
+	xilinx_dpdma_chan_pause(chan);
+
+	if (poll)
+		ret = xilinx_dpdma_chan_poll_no_ostand(chan);
+	else
+		ret = xilinx_dpdma_chan_wait_no_ostand(chan);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	xilinx_dpdma_chan_disable(chan);
+	chan->status = IDLE;
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return 0;
+}
+
+/**
+ * xilinx_dpdma_chan_err - Detect any channel error
+ * @chan: DPDMA channel
+ * @isr: masked Interrupt Status Register
+ * @eisr: Error Interrupt Status Register
+ *
+ * Return: true if any channel error occurs, or false otherwise.
+ */
+static bool
+xilinx_dpdma_chan_err(struct xilinx_dpdma_chan *chan, u32 isr, u32 eisr)
+{
+	if (!chan)
+		return false;
+
+	if (chan->status == STREAMING &&
+	    ((isr & (XILINX_DPDMA_INTR_CHAN_ERR_MASK << chan->id)) ||
+	    (eisr & (XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id))))
+		return true;
+
+	return false;
+}
+
+/**
+ * xilinx_dpdma_chan_handle_err - DPDMA channel error handling
+ * @chan: DPDMA channel
+ *
+ * This function is called when any channel error or any global error occurs.
+ * The function disables the paused channel by errors and determines
+ * if the current active descriptor can be rescheduled depending on
+ * the descriptor status.
+ */
+static void xilinx_dpdma_chan_handle_err(struct xilinx_dpdma_chan *chan)
+{
+	struct xilinx_dpdma_device *xdev = chan->xdev;
+	struct device *dev = xdev->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	dev_dbg(dev, "cur desc addr = 0x%04x%08x\n",
+		dpdma_read(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDRE),
+		dpdma_read(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDR));
+	dev_dbg(dev, "cur payload addr = 0x%04x%08x\n",
+		dpdma_read(chan->reg, XILINX_DPDMA_CH_PYLD_CUR_ADDRE),
+		dpdma_read(chan->reg, XILINX_DPDMA_CH_PYLD_CUR_ADDR));
+
+	xilinx_dpdma_chan_disable(chan);
+	chan->status = IDLE;
+
+	if (!chan->active_desc)
+		goto out_unlock;
+
+	xilinx_dpdma_chan_dump_tx_desc(chan, chan->active_desc);
+
+	switch (chan->active_desc->status) {
+	case ERRORED:
+		dev_dbg(dev, "repeated error on desc\n");
+	case ACTIVE:
+	case PREPARED:
+		/* Reschedule if there's no new descriptor */
+		if (!chan->pending_desc && !chan->submitted_desc) {
+			chan->active_desc->status = ERRORED;
+			chan->submitted_desc = chan->active_desc;
+		} else {
+			xilinx_dpdma_chan_free_tx_desc(chan, chan->active_desc);
+		}
+		break;
+	}
+	chan->active_desc = NULL;
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+/* -----------------------------------------------------------------------------
+ * DMA Engine Operations
+ */
+
+/**
+ * xilinx_dpdma_tx_submit - Submit a transaction descriptor
+ * @tx: TX descriptor
+ *
+ * Submit the TX descriptor @tx.
+ *
+ * Return: a cookie assigned to the tx descriptor
+ */
+static dma_cookie_t xilinx_dpdma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(tx->chan);
+	struct xilinx_dpdma_tx_desc *tx_desc = to_dpdma_tx_desc(tx);
+	struct xilinx_dpdma_sw_desc *sw_desc;
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+
+	if (chan->submitted_desc) {
+		cookie = chan->submitted_desc->async_tx.cookie;
+		goto out_unlock;
+	}
+
+	cookie = dma_cookie_assign(&tx_desc->async_tx);
+
+	/*
+	 * Assign the cookie to descriptors in this transaction. Only 16 bit
+	 * will be used, but it should be enough.
+	 */
+	list_for_each_entry(sw_desc, &tx_desc->descriptors, node)
+		sw_desc->hw.desc_id = cookie;
+
+	if (tx_desc != chan->allocated_desc)
+		dev_err(chan->xdev->dev, "desc != allocated_desc\n");
+	else
+		chan->allocated_desc = NULL;
+	chan->submitted_desc = tx_desc;
+
+	if (chan->id == ZYNQMP_DPDMA_VIDEO1 ||
+	    chan->id == ZYNQMP_DPDMA_VIDEO2) {
+		chan->video_group = true;
+		chan->xdev->chan[ZYNQMP_DPDMA_VIDEO0]->video_group = true;
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return cookie;
+}
+
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			   unsigned int sg_len,
+			   enum dma_transfer_direction direction,
+			   unsigned long flags, void *context)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	struct dma_async_tx_descriptor *async_tx;
+
+	if (direction != DMA_MEM_TO_DEV)
+		return NULL;
+
+	if (!sgl || sg_len < 2)
+		return NULL;
+
+	async_tx = xilinx_dpdma_chan_prep_slave_sg(chan, sgl);
+	if (!async_tx)
+		return NULL;
+
+	dma_async_tx_descriptor_init(async_tx, dchan);
+	async_tx->tx_submit = xilinx_dpdma_tx_submit;
+	async_tx->flags = flags;
+	async_tx_ack(async_tx);
+
+	return async_tx;
+}
+
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
+			     size_t buf_len, size_t period_len,
+			     enum dma_transfer_direction direction,
+			     unsigned long flags)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	struct dma_async_tx_descriptor *async_tx;
+
+	if (direction != DMA_MEM_TO_DEV)
+		return NULL;
+
+	if (buf_len % period_len)
+		return NULL;
+
+	async_tx = xilinx_dpdma_chan_prep_cyclic(chan, buf_addr, buf_len,
+						 period_len);
+	if (!async_tx)
+		return NULL;
+
+	dma_async_tx_descriptor_init(async_tx, dchan);
+	async_tx->tx_submit = xilinx_dpdma_tx_submit;
+	async_tx->flags = flags;
+	async_tx_ack(async_tx);
+
+	return async_tx;
+}
+
+static struct dma_async_tx_descriptor *
+xilinx_dpdma_prep_interleaved_dma(struct dma_chan *dchan,
+				  struct dma_interleaved_template *xt,
+				  unsigned long flags)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	struct dma_async_tx_descriptor *async_tx;
+
+	if (xt->dir != DMA_MEM_TO_DEV)
+		return NULL;
+
+	if (!xt->numf || !xt->sgl[0].size)
+		return NULL;
+
+	async_tx = xilinx_dpdma_chan_prep_interleaved(chan, xt);
+	if (!async_tx)
+		return NULL;
+
+	dma_async_tx_descriptor_init(async_tx, dchan);
+	async_tx->tx_submit = xilinx_dpdma_tx_submit;
+	async_tx->flags = flags;
+	async_tx_ack(async_tx);
+
+	return async_tx;
+}
+
+/**
+ * xilinx_dpdma_alloc_chan_resources - Allocate resources for the channel
+ * @dchan: DMA channel
+ *
+ * Allocate a descriptor pool for the channel.
+ *
+ * Return: 0 on success, or -ENOMEM if failed to allocate a pool.
+ */
+static int xilinx_dpdma_alloc_chan_resources(struct dma_chan *dchan)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	size_t align = __alignof__(struct xilinx_dpdma_sw_desc);
+
+	dma_cookie_init(dchan);
+
+	chan->desc_pool = dma_pool_create(dev_name(chan->xdev->dev),
+					  chan->xdev->dev,
+					  sizeof(struct xilinx_dpdma_sw_desc),
+					  align, 0);
+	if (!chan->desc_pool) {
+		dev_err(chan->xdev->dev,
+			"failed to allocate a descriptor pool\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * xilinx_dpdma_free_chan_resources - Free all resources for the channel
+ * @dchan: DMA channel
+ *
+ * Free all descriptors and the descriptor pool for the channel.
+ */
+static void xilinx_dpdma_free_chan_resources(struct dma_chan *dchan)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+
+	xilinx_dpdma_chan_free_all_desc(chan);
+	dma_pool_destroy(chan->desc_pool);
+	chan->desc_pool = NULL;
+}
+
+static enum dma_status xilinx_dpdma_tx_status(struct dma_chan *dchan,
+					      dma_cookie_t cookie,
+					      struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(dchan, cookie, txstate);
+}
+
+static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+
+	xilinx_dpdma_chan_start(chan);
+	xilinx_dpdma_chan_issue_pending(chan);
+}
+
+static int xilinx_dpdma_config(struct dma_chan *dchan,
+			       struct dma_slave_config *config)
+{
+	if (config->direction != DMA_MEM_TO_DEV)
+		return -EINVAL;
+
+	/*
+	 * The destination address doesn't need to be specified as the DPDMA is
+	 * hardwired to the destination (the DP controller). The transfer
+	 * width, burst size and port window size are thus meaningless, they're
+	 * fixed both on the DPDMA side and on the DP controller side.
+	 */
+
+	return 0;
+}
+
+static int xilinx_dpdma_pause(struct dma_chan *dchan)
+{
+	xilinx_dpdma_chan_pause(to_xilinx_chan(dchan));
+
+	return 0;
+}
+
+static int xilinx_dpdma_resume(struct dma_chan *dchan)
+{
+	xilinx_dpdma_chan_unpause(to_xilinx_chan(dchan));
+
+	return 0;
+}
+
+/**
+ * xilinx_dpdma_terminate_all - Terminate the channel and descriptors
+ * @dchan: DMA channel
+ *
+ * Stop the channel and free all associated descriptors. Poll the no outstanding
+ * transaction interrupt as this can be called from an atomic context.
+ *
+ * Return: 0 on success, or -ETIMEDOUT if the channel failed to stop.
+ */
+static int xilinx_dpdma_terminate_all(struct dma_chan *dchan)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	int ret;
+
+	ret = xilinx_dpdma_chan_stop(chan, true);
+	if (ret)
+		return ret;
+
+	xilinx_dpdma_chan_free_all_desc(chan);
+
+	return 0;
+}
+
+/**
+ * xilinx_dpdma_synchronize - Synchronize all outgoing transfer
+ * @dchan: DMA channel
+ *
+ * Stop the channel and free all associated descriptors. As this can't be
+ * called in an atomic context, sleep-wait for no outstanding transaction
+ * interrupt. Then kill all related tasklets.
+ *
+ * Return: 0 on success, or -ETIMEDOUT if the channel failed to stop.
+ */
+static void xilinx_dpdma_synchronize(struct dma_chan *dchan)
+{
+	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
+	int ret;
+
+	ret = xilinx_dpdma_chan_stop(chan, false);
+	if (ret)
+		return;
+
+	tasklet_kill(&chan->err_task);
+	tasklet_kill(&chan->done_task);
+	xilinx_dpdma_chan_free_all_desc(chan);
+}
+
+/* -----------------------------------------------------------------------------
+ * Interrupt and Tasklet Handling
+ */
+
+/**
+ * xilinx_dpdma_err - Detect any global error
+ * @isr: Interrupt Status Register
+ * @eisr: Error Interrupt Status Register
+ *
+ * Return: True if any global error occurs, or false otherwise.
+ */
+static bool xilinx_dpdma_err(u32 isr, u32 eisr)
+{
+	if ((isr & XILINX_DPDMA_INTR_GLOBAL_ERR ||
+	     eisr & XILINX_DPDMA_EINTR_GLOBAL_ERR))
+		return true;
+
+	return false;
+}
+
+/**
+ * xilinx_dpdma_handle_err_intr - Handle DPDMA error interrupt
+ * @xdev: DPDMA device
+ * @isr: masked Interrupt Status Register
+ * @eisr: Error Interrupt Status Register
+ *
+ * Handle if any error occurs based on @isr and @eisr. This function disables
+ * corresponding error interrupts, and those should be re-enabled once handling
+ * is done.
+ */
+static void xilinx_dpdma_handle_err_intr(struct xilinx_dpdma_device *xdev,
+					 u32 isr, u32 eisr)
+{
+	bool err = xilinx_dpdma_err(isr, eisr);
+	unsigned int i;
+
+	dev_dbg_ratelimited(xdev->dev,
+			    "error intr: isr = 0x%08x, eisr = 0x%08x\n",
+			    isr, eisr);
+
+	/* Disable channel error interrupts until errors are handled. */
+	dpdma_write(xdev->reg, XILINX_DPDMA_IDS,
+		    isr & ~XILINX_DPDMA_INTR_GLOBAL_ERR);
+	dpdma_write(xdev->reg, XILINX_DPDMA_EIDS,
+		    eisr & ~XILINX_DPDMA_EINTR_GLOBAL_ERR);
+
+	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
+		if (err || xilinx_dpdma_chan_err(xdev->chan[i], isr, eisr))
+			tasklet_schedule(&xdev->chan[i]->err_task);
+}
+
+/**
+ * xilinx_dpdma_handle_vsync_intr - Handle the VSYNC interrupt
+ * @xdev: DPDMA device
+ *
+ * Handle the VSYNC event. At this point, the current frame becomes active,
+ * which means the DPDMA actually starts fetching, and the next frame can be
+ * scheduled.
+ */
+static void xilinx_dpdma_handle_vsync_intr(struct xilinx_dpdma_device *xdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++) {
+		if (xdev->chan[i] &&
+		    xdev->chan[i]->status == STREAMING) {
+			xilinx_dpdma_chan_desc_active(xdev->chan[i]);
+			xilinx_dpdma_chan_issue_pending(xdev->chan[i]);
+		}
+	}
+}
+
+/**
+ * xilinx_dpdma_enable_intr - Enable interrupts
+ * @xdev: DPDMA device
+ *
+ * Enable interrupts.
+ */
+static void xilinx_dpdma_enable_intr(struct xilinx_dpdma_device *xdev)
+{
+	dpdma_write(xdev->reg, XILINX_DPDMA_IEN, XILINX_DPDMA_INTR_ALL);
+	dpdma_write(xdev->reg, XILINX_DPDMA_EIEN, XILINX_DPDMA_EINTR_ALL);
+}
+
+/**
+ * xilinx_dpdma_disable_intr - Disable interrupts
+ * @xdev: DPDMA device
+ *
+ * Disable interrupts.
+ */
+static void xilinx_dpdma_disable_intr(struct xilinx_dpdma_device *xdev)
+{
+	dpdma_write(xdev->reg, XILINX_DPDMA_IDS, XILINX_DPDMA_INTR_ERR_ALL);
+	dpdma_write(xdev->reg, XILINX_DPDMA_EIDS, XILINX_DPDMA_EINTR_ALL);
+}
+
+/**
+ * xilinx_dpdma_chan_err_task - Per channel tasklet for error handling
+ * @data: tasklet data to be casted to DPDMA channel structure
+ *
+ * Per channel error handling tasklet. This function waits for the outstanding
+ * transaction to complete and triggers error handling. After error handling,
+ * re-enable channel error interrupts, and restart the channel if needed.
+ */
+static void xilinx_dpdma_chan_err_task(unsigned long data)
+{
+	struct xilinx_dpdma_chan *chan = (struct xilinx_dpdma_chan *)data;
+	struct xilinx_dpdma_device *xdev = chan->xdev;
+
+	/* Proceed error handling even when polling fails. */
+	xilinx_dpdma_chan_poll_no_ostand(chan);
+
+	xilinx_dpdma_chan_handle_err(chan);
+
+	dpdma_write(xdev->reg, XILINX_DPDMA_IEN,
+		    XILINX_DPDMA_INTR_CHAN_ERR_MASK << chan->id);
+	dpdma_write(xdev->reg, XILINX_DPDMA_EIEN,
+		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
+
+	xilinx_dpdma_chan_start(chan);
+	xilinx_dpdma_chan_issue_pending(chan);
+}
+
+/**
+ * xilinx_dpdma_chan_done_task - Per channel tasklet for done interrupt handling
+ * @data: tasklet data to be casted to DPDMA channel structure
+ *
+ * Per channel done interrupt handling tasklet.
+ */
+static void xilinx_dpdma_chan_done_task(unsigned long data)
+{
+	struct xilinx_dpdma_chan *chan = (struct xilinx_dpdma_chan *)data;
+
+	xilinx_dpdma_chan_cleanup_desc(chan);
+}
+
+static irqreturn_t xilinx_dpdma_irq_handler(int irq, void *data)
+{
+	struct xilinx_dpdma_device *xdev = data;
+	u32 status, error, i;
+	unsigned long masked;
+
+	status = dpdma_read(xdev->reg, XILINX_DPDMA_ISR);
+	error = dpdma_read(xdev->reg, XILINX_DPDMA_EISR);
+	if (!status && !error)
+		return IRQ_NONE;
+
+	dpdma_write(xdev->reg, XILINX_DPDMA_ISR, status);
+	dpdma_write(xdev->reg, XILINX_DPDMA_EISR, error);
+
+	if (status & XILINX_DPDMA_INTR_VSYNC)
+		xilinx_dpdma_handle_vsync_intr(xdev);
+
+	masked = FIELD_GET(XILINX_DPDMA_INTR_DESC_DONE_MASK, status);
+	if (masked)
+		for_each_set_bit(i, &masked, ARRAY_SIZE(xdev->chan))
+			xilinx_dpdma_chan_desc_done_intr(xdev->chan[i]);
+
+	masked = FIELD_GET(XILINX_DPDMA_INTR_NO_OSTAND_MASK, status);
+	if (masked)
+		for_each_set_bit(i, &masked, ARRAY_SIZE(xdev->chan))
+			xilinx_dpdma_chan_notify_no_ostand(xdev->chan[i]);
+
+	masked = status & XILINX_DPDMA_INTR_ERR_ALL;
+	if (masked || error)
+		xilinx_dpdma_handle_err_intr(xdev, masked, error);
+
+	return IRQ_HANDLED;
+}
+
+/* -----------------------------------------------------------------------------
+ * Initialization & Cleanup
+ */
+
+static struct xilinx_dpdma_chan *
+xilinx_dpdma_chan_init(struct xilinx_dpdma_device *xdev, unsigned int chan_id)
+{
+	struct xilinx_dpdma_chan *chan;
+
+	chan = devm_kzalloc(xdev->dev, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return ERR_PTR(-ENOMEM);
+
+	chan->id = chan_id;
+	chan->reg = xdev->reg + XILINX_DPDMA_CH_BASE
+		  + XILINX_DPDMA_CH_OFFSET * chan->id;
+	chan->status = IDLE;
+
+	spin_lock_init(&chan->lock);
+	INIT_LIST_HEAD(&chan->done_list);
+	init_waitqueue_head(&chan->wait_to_stop);
+
+	tasklet_init(&chan->done_task, xilinx_dpdma_chan_done_task,
+		     (unsigned long)chan);
+	tasklet_init(&chan->err_task, xilinx_dpdma_chan_err_task,
+		     (unsigned long)chan);
+
+	chan->common.device = &xdev->common;
+	chan->xdev = xdev;
+
+	list_add_tail(&chan->common.device_node, &xdev->common.channels);
+	xdev->chan[chan->id] = chan;
+
+	return chan;
+}
+
+static void xilinx_dpdma_chan_remove(struct xilinx_dpdma_chan *chan)
+{
+	if (!chan)
+		return;
+
+	tasklet_kill(&chan->err_task);
+	tasklet_kill(&chan->done_task);
+	list_del(&chan->common.device_node);
+}
+
+static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
+					    struct of_dma *ofdma)
+{
+	struct xilinx_dpdma_device *xdev = ofdma->of_dma_data;
+	uint32_t chan_id = dma_spec->args[0];
+
+	if (chan_id >= ARRAY_SIZE(xdev->chan))
+		return NULL;
+
+	if (!xdev->chan[chan_id])
+		return NULL;
+
+	return dma_get_slave_channel(&xdev->chan[chan_id]->common);
+}
+
+static int xilinx_dpdma_probe(struct platform_device *pdev)
+{
+	struct xilinx_dpdma_device *xdev;
+	struct xilinx_dpdma_chan *chan;
+	struct dma_device *ddev;
+	unsigned int i;
+	int ret;
+
+	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->dev = &pdev->dev;
+	ddev = &xdev->common;
+	ddev->dev = &pdev->dev;
+
+	xdev->axi_clk = devm_clk_get(xdev->dev, "axi_clk");
+	if (IS_ERR(xdev->axi_clk))
+		return PTR_ERR(xdev->axi_clk);
+
+	xdev->reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xdev->reg))
+		return PTR_ERR(xdev->reg);
+
+	xdev->irq = platform_get_irq(pdev, 0);
+	if (xdev->irq < 0) {
+		dev_err(xdev->dev, "failed to get platform irq\n");
+		return xdev->irq;
+	}
+
+	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
+			  dev_name(xdev->dev), xdev);
+	if (ret) {
+		dev_err(xdev->dev, "failed to request IRQ\n");
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&xdev->common.channels);
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
+	dma_cap_set(DMA_INTERLEAVE, ddev->cap_mask);
+	ddev->copy_align = fls(XILINX_DPDMA_ALIGN_BYTES - 1);
+
+	ddev->device_alloc_chan_resources = xilinx_dpdma_alloc_chan_resources;
+	ddev->device_free_chan_resources = xilinx_dpdma_free_chan_resources;
+	ddev->device_prep_slave_sg = xilinx_dpdma_prep_slave_sg;
+	ddev->device_prep_dma_cyclic = xilinx_dpdma_prep_dma_cyclic;
+	ddev->device_prep_interleaved_dma = xilinx_dpdma_prep_interleaved_dma;
+	ddev->device_tx_status = xilinx_dpdma_tx_status;
+	ddev->device_issue_pending = xilinx_dpdma_issue_pending;
+	ddev->device_config = xilinx_dpdma_config;
+	ddev->device_pause = xilinx_dpdma_pause;
+	ddev->device_resume = xilinx_dpdma_resume;
+	ddev->device_terminate_all = xilinx_dpdma_terminate_all;
+	ddev->device_synchronize = xilinx_dpdma_synchronize;
+	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
+	ddev->directions = BIT(DMA_MEM_TO_DEV);
+	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
+	for (i = 0; i < ARRAY_SIZE(xdev->chan); ++i) {
+		chan = xilinx_dpdma_chan_init(xdev, i);
+		if (IS_ERR(chan)) {
+			dev_err(xdev->dev, "failed to initialize channel %u\n",
+				i);
+			ret = PTR_ERR(chan);
+			goto error;
+		}
+	}
+
+	xdev->ext_addr = sizeof(dma_addr_t) > 4;
+	if (xdev->ext_addr)
+		xdev->desc_addr = xilinx_dpdma_sw_desc_addr_64;
+	else
+		xdev->desc_addr = xilinx_dpdma_sw_desc_addr_32;
+
+	ret = clk_prepare_enable(xdev->axi_clk);
+	if (ret) {
+		dev_err(xdev->dev, "failed to enable the axi clock\n");
+		goto error;
+	}
+
+	ret = dma_async_device_register(ddev);
+	if (ret) {
+		dev_err(xdev->dev, "failed to register the dma device\n");
+		goto error_dma_async;
+	}
+
+	ret = of_dma_controller_register(xdev->dev->of_node,
+					 of_dma_xilinx_xlate, ddev);
+	if (ret) {
+		dev_err(xdev->dev, "failed to register DMA to DT DMA helper\n");
+		goto error_of_dma;
+	}
+
+	xilinx_dpdma_enable_intr(xdev);
+
+	dev_info(&pdev->dev, "Xilinx DPDMA engine is probed\n");
+
+	return 0;
+
+error_of_dma:
+	dma_async_device_unregister(ddev);
+error_dma_async:
+	clk_disable_unprepare(xdev->axi_clk);
+error:
+	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
+		xilinx_dpdma_chan_remove(xdev->chan[i]);
+
+	free_irq(xdev->irq, xdev);
+
+	return ret;
+}
+
+static int xilinx_dpdma_remove(struct platform_device *pdev)
+{
+	struct xilinx_dpdma_device *xdev = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	/* Start by disabling the IRQ to avoid races during cleanup. */
+	free_irq(xdev->irq, xdev);
+
+	xilinx_dpdma_disable_intr(xdev);
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&xdev->common);
+	clk_disable_unprepare(xdev->axi_clk);
+
+	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
+		xilinx_dpdma_chan_remove(xdev->chan[i]);
+
+	return 0;
+}
+
+static const struct of_device_id xilinx_dpdma_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-dpdma",},
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, xilinx_dpdma_of_match);
+
+static struct platform_driver xilinx_dpdma_driver = {
+	.probe			= xilinx_dpdma_probe,
+	.remove			= xilinx_dpdma_remove,
+	.driver			= {
+		.name		= "xilinx-dpdma",
+		.of_match_table	= xilinx_dpdma_of_match,
+	},
+};
+
+module_platform_driver(xilinx_dpdma_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("Xilinx DPDMA driver");
+MODULE_LICENSE("GPL v2");
-- 
Regards,

Laurent Pinchart

