Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE96DA5A1
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjDFWQU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Apr 2023 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDFWQT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Apr 2023 18:16:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B61BCB;
        Thu,  6 Apr 2023 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680819375; x=1712355375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80l6+MgkueijQ387rocCDjwXhm9Cf/F827lzcFE8Rf4=;
  b=gPJE3Ag0rJBTXHyowNQZrxCuhsi9GSFhF5JwzvNGPz0dJFp5afkM62QG
   6QmtKziIrePGmuiAzwQqxk6sUv0Efi3X1/9eiKqpTJ6JV1bvJh2fTmLHF
   GnhXo0IyyHy5HlytT+Kq/bCScYIPtaBOQux/wBL4uKf+h6yVEvc07Ao5b
   czQqFCqpYcN7cYmojrpv/rRIZ/4sstysgiPAcF1AMpE+isGWq6tm8DnK5
   g1HuBW8w1s4lWd5Ti2DEqiYXgfSnxfbWfDnO/bfdbHnhfyMIS0n7m+ZAS
   z1r5d0sD9p4iEywstfYFTQUPjPyjurF0E06iHQw2YI4Ofy4zs7yGvDZrv
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,323,1673938800"; 
   d="scan'208";a="208526528"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2023 15:16:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 15:16:13 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Apr 2023 15:16:13 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <george.ge@microchip.com>,
        <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver
Date:   Thu, 6 Apr 2023 14:03:23 -0700
Message-ID: <20230406210323.1018163-2-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230406210323.1018163-1-kelvin.cao@microchip.com>
References: <20230406210323.1018163-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some Switchtec Switches can expose DMA engines via extra PCI functions
on the upstream ports. At most one such function can be supported on
each upstream port. Each function can have one or more DMA channels.

Implement core PCI driver skeleton and register DMA engine callbacks.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Co-developed-by: George Ge <george.ge@microchip.com>
Signed-off-by: George Ge <george.ge@microchip.com>
---
 MAINTAINERS                 |    5 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1730 +++++++++++++++++++++++++++++++++++
 4 files changed, 1745 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..5a1283c17d57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20158,6 +20158,11 @@ S:	Supported
 F:	include/net/switchdev.h
 F:	net/switchdev/
 
+SWITCHTEC DMA DRIVER
+M:	Kelvin Cao <kelvin.cao@microchip.com>
+S:	Maintained
+F:	drivers/dma/switchtec_dma.c
+
 SY8106A REGULATOR DRIVER
 M:	Icenowy Zheng <icenowy@aosc.io>
 S:	Maintained
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fb7073fc034f..2c7545a41c49 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -748,6 +748,15 @@ config XILINX_ZYNQMP_DPDMA
 	  driver provides the dmaengine required by the DisplayPort subsystem
 	  display driver.
 
+config SWITCHTEC_DMA
+	tristate "Switchtec PSX/PFX Switch DMA Engine Support"
+	depends on PCI
+	select DMA_ENGINE
+	help
+	  Some Switchtec PSX/PFX PCIe Switches support additional DMA engines.
+	  These are exposed via an extra function on the switch's upstream
+	  port.
+
 # driver files
 source "drivers/dma/bestcomm/Kconfig"
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fd1ce29510..6cea3ceb7dc7 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_SWITCHTEC_DMA) += switchtec_dma.o
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
new file mode 100644
index 000000000000..ab0c87f41e88
--- /dev/null
+++ b/drivers/dma/switchtec_dma.c
@@ -0,0 +1,1730 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Switchtec(tm) DMA Controller Driver
+ * Copyright (c) 2019, Kelvin Cao <kelvin.cao@microchip.com>
+ * Copyright (c) 2019, Microchip Corporation
+ */
+
+#include <linux/circ_buf.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include "dmaengine.h"
+
+MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kelvin Cao");
+
+enum switchtec_reg_offset {
+	SWITCHTEC_DMAC_VERSION_OFFSET = 0,
+	SWITCHTEC_DMAC_CAPABILITY_OFFSET = 0x80,
+	SWITCHTEC_DMAC_STATUS_OFFSET = 0x100,
+	SWITCHTEC_DMAC_CONTROL_OFFSET = 0x180,
+	SWITCHTEC_DMAC_CHAN_CTRL_OFFSET = 0x1000,
+	SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET = 0x160000,
+	SWITCHTEC_DMAC_FABRIC_CMD_OFFSET = 0x164000,
+	SWITCHTEC_DMAC_FABRIC_CTRL_OFFSET = 0x165000,
+};
+
+#define SWITCHTEC_DESC_MAX_SIZE 0x100000
+
+struct dmac_version_regs {
+	u32 fw_ver;
+	u32 dma_prot_ver;
+	u32 hw_dmac_ver;
+} __packed;
+
+struct dmac_capability_regs {
+	u32 cap;
+	u32 chan_cnt;
+	u32 rsvd1;
+	u32 cplt_tmo;
+	u32 tag_limit;
+	u16 chan_sts_vec;
+	u16 rsvd2;
+	u16 se_buf_cnt;
+	u16 se_buf_base;
+} __packed;
+
+struct dmac_status_regs {
+	u32 state;
+	u32 internal_err;
+	u32 chan_halt_sum_lo;
+	u32 chan_halt_sum_hi;
+	u32 rsvd[2];
+	u32 chan_pause_sum_lo;
+	u32 chan_pause_sum_hi;
+} __packed;
+
+#define IER_OB_PF_RD_ERR_I  BIT(14)
+#define IER_OB_TLP_RD_ERR_I BIT(15)
+#define IER_ECC_ER_0_I      BIT(20)
+#define IER_ECC_ER_1_I      BIT(21)
+#define IER_PARITY_ERR_I    BIT(22)
+#define IER_IB_IER_I        BIT(23)
+
+struct dmac_control_regs {
+	u32 reset_halt;
+} __packed;
+
+struct dmac_fabric_cmd_regs {
+	u32 input[256];
+	u32 rsvd1[256];
+	u16 command;
+	u16 rsvd2;
+} __packed;
+
+struct dmac_fabric_control_regs {
+	u16 cmd_vec;
+	u16 rsvd1;
+	u32 cmd_dma_addr_lo;
+	u32 cmd_dma_addr_hi;
+	u16 event_vec;
+	u16 rsvd2;
+	u32 event_dma_addr_lo;
+	u32 event_dma_addr_hi;
+	u32 event_dma_size;
+	u32 event_queue_tail;
+	u32 cmd_event_enable;
+	u16 local_hfid;
+	u16 rsvd3;
+	u32 requestor_id;
+} __packed;
+
+#define SWITCHTEC_CHAN_CTRL_PAUSE     BIT(0)
+#define SWITCHTEC_CHAN_CTRL_HALT      BIT(1)
+#define SWITCHTEC_CHAN_CTRL_RESET     BIT(2)
+#define SWITCHTEC_CHAN_CTRL_ERR_PAUSE BIT(3)
+
+#define SWITCHTEC_CHAN_STS_PAUSED      BIT(9)
+#define SWITCHTEC_CHAN_STS_HALTED      BIT(10)
+#define SWITCHTEC_CHAN_STS_PAUSED_MASK GENMASK(29, 13)
+
+static const char * const channel_status_str[] = {
+	[13] = "received a VDM with length error status",
+	[14] = "received a VDM or Cpl with Unsupported Request error status",
+	[15] = "received a VDM or Cpl with Completion Abort error status",
+	[16] = "received a VDM with ECRC error status",
+	[17] = "received a VDM with EP error status",
+	[18] = "received a VDM with Reserved Cpl error status",
+	[19] = "received only part of split SE CplD",
+	[20] = "the ISP_DMAC detected a Completion Time Out",
+	[21] = "received a Cpl with Unsupported Request status",
+	[22] = "received a Cpl with Completion Abort status",
+	[23] = "received a Cpl with a reserved status",
+	[24] = "received a TLP with ECRC error status in its metadata",
+	[25] = "received a TLP with the EP bit set in the header",
+	[26] = "the ISP_DMAC tried to process a SE with an invalid Connection ID",
+	[27] = "the ISP_DMAC tried to process a SE with an invalid Remote Host interrupt",
+	[28] = "a reserved opcode was detected in an SE",
+	[29] = "received a SE Cpl with error status",
+};
+
+struct chan_hw_regs {
+	u16 cq_head;
+	u16 rsvd1;
+	u16 sq_tail;
+	u16 rsvd2;
+	u8 ctrl;
+	u8 rsvd3[3];
+	u16 status;
+	u16 rsvd4;
+} __packed;
+
+enum {
+	PERF_BURST_SCALE = 0x1,
+	PERF_BURST_SIZE = 0x6,
+	PERF_INTERVAL = 0x0,
+	PERF_MRRS = 0x3,
+	PERF_ARB_WEIGHT = 0x1,
+};
+
+enum {
+	PERF_BURST_SCALE_SHIFT = 2,
+	PERF_BURST_SCALE_MASK = 0x3,
+	PERF_MRRS_SHIFT = 4,
+	PERF_MRRS_MASK = 0x7,
+	PERF_INTERVAL_SHIFT = 8,
+	PERF_INTERVAL_MASK = 0x7,
+	PERF_BURST_SIZE_SHIFT = 12,
+	PERF_BURST_SIZE_MASK = 0x7,
+	PERF_ARB_WEIGHT_SHIFT = 24,
+	PERF_ARB_WEIGHT_MASK = 0xff,
+};
+
+enum {
+	PERF_MIN_INTERVAL = 0,
+	PERF_MAX_INTERVAL = 7,
+	PERF_MIN_BURST_SIZE = 0,
+	PERF_MAX_BURST_SIZE = 7,
+	PERF_MIN_BURST_SCALE = 0,
+	PERF_MAX_BURST_SCALE = 2,
+	PERF_MIN_MRRS = 0,
+	PERF_MAX_MRRS = 7,
+};
+
+enum {
+	SE_BUF_BASE_SHIFT = 2,
+	SE_BUF_BASE_MASK = 0x1ff,
+	SE_BUF_LEN_SHIFT = 12,
+	SE_BUF_LEN_MASK = 0x1ff,
+	SE_THRESH_SHIFT = 23,
+	SE_THRESH_MASK = 0x1ff,
+};
+
+#define SWITCHTEC_CHAN_ENABLE BIT(1)
+
+#define SWITCHTEC_LAT_SE_FETCH   BIT(0)
+#define SWITCHTEC_LAT_VDM        BIT(1)
+#define SWITCHTEC_LAT_RD_IMM     BIT(2)
+#define SWITCHTEC_LAT_SE_PROCESS BIT(4)
+
+struct chan_fw_regs {
+	u32 valid_en_se;
+	u32 cq_base_lo;
+	u32 cq_base_hi;
+	u16 cq_size;
+	u16 rsvd1;
+	u32 sq_base_lo;
+	u32 sq_base_hi;
+	u16 sq_size;
+	u16 rsvd2;
+	u32 int_vec;
+	u32 perf_cfg;
+	u32 rsvd3;
+	u32 perf_latency_selector;
+	u32 perf_fetched_se_cnt_lo;
+	u32 perf_fetched_se_cnt_hi;
+	u32 perf_byte_cnt_lo;
+	u32 perf_byte_cnt_hi;
+	u32 rsvd4;
+	u16 perf_se_pending;
+	u16 perf_se_buf_empty;
+	u32 perf_chan_idle;
+	u32 perf_lat_max;
+	u32 perf_lat_min;
+	u32 perf_lat_last;
+	u16 sq_current;
+	u16 sq_phase;
+	u16 cq_current;
+	u16 cq_phase;
+} __packed;
+
+enum cmd {
+	CMD_GET_HOST_LIST = 1,
+	CMD_REGISTER_BUF = 2,
+	CMD_UNREGISTER_BUF = 3,
+	CMD_GET_BUF_LIST = 4,
+	CMD_GET_OWN_BUF_LIST = 5,
+};
+
+enum cmd_status {
+	CMD_STATUS_IDLE = 0,
+	CMD_STATUS_INPROGRESS = 1,
+	CMD_STATUS_DONE = 2,
+	CMD_STATUS_ERROR = 0xFF,
+};
+
+#define CMD_TIMEOUT_MSECS 200
+
+#define SWITCHTEC_CHAN_INTERVAL 1
+#define SWITCHTEC_CHAN_BURST_SZ 1
+#define SWITCHTEC_CHAN_BURST_SCALE 1
+#define SWITCHTEC_CHAN_MRRS 1
+
+struct switchtec_dma_chan {
+	struct switchtec_dma_dev *swdma_dev;
+	struct dma_chan dma_chan;
+	struct chan_hw_regs __iomem *mmio_chan_hw;
+	struct chan_fw_regs __iomem *mmio_chan_fw;
+	spinlock_t hw_ctrl_lock;
+
+	struct tasklet_struct desc_task;
+	spinlock_t submit_lock;
+	bool ring_active;
+	int cid;
+	spinlock_t complete_lock;
+	bool comp_ring_active;
+
+	/* channel index and irq */
+	int index;
+	int irq;
+
+	/*
+	 * In driver context, head is advanced by producer while
+	 * tail is advanced by consumer.
+	 */
+
+	/* the head and tail for both desc_ring and hw_sq */
+	int head;
+	int tail;
+	int phase_tag;
+	struct switchtec_dma_desc **desc_ring;
+	struct switchtec_dma_hw_se_desc *hw_sq;
+	dma_addr_t dma_addr_sq;
+
+	/* the tail for hw_cq */
+	int cq_tail;
+	struct switchtec_dma_hw_ce *hw_cq;
+	dma_addr_t dma_addr_cq;
+
+	struct list_head list;
+};
+
+struct switchtec_dma_dev {
+	struct dma_device dma_dev;
+	struct pci_dev __rcu *pdev;
+	struct switchtec_dma_chan **swdma_chans;
+	int chan_cnt;
+
+	int chan_status_irq;
+
+	void __iomem *bar;
+	struct dmac_version_regs __iomem *mmio_dmac_ver;
+	struct dmac_capability_regs __iomem *mmio_dmac_cap;
+	struct dmac_status_regs __iomem *mmio_dmac_status;
+	struct dmac_control_regs __iomem *mmio_dmac_ctrl;
+	struct dmac_fabric_cmd_regs __iomem *mmio_fabric_cmd;
+	struct dmac_fabric_control_regs __iomem *mmio_fabric_ctrl;
+	void __iomem *mmio_chan_hw_all;
+	void __iomem *mmio_chan_fw_all;
+
+	struct tasklet_struct chan_status_task;
+};
+
+static struct switchtec_dma_chan *to_switchtec_dma_chan(struct dma_chan *c)
+{
+	return container_of(c, struct switchtec_dma_chan, dma_chan);
+}
+
+static struct device *to_chan_dev(struct switchtec_dma_chan *swdma_chan)
+{
+	return &swdma_chan->dma_chan.dev->device;
+}
+
+enum switchtec_dma_opcode {
+	SWITCHTEC_DMA_OPC_MEMCPY = 0x0,
+	SWITCHTEC_DMA_OPC_RDIMM = 0x1,
+	SWITCHTEC_DMA_OPC_WRIMM = 0x2,
+	SWITCHTEC_DMA_OPC_RHI = 0x6,
+	SWITCHTEC_DMA_OPC_NOP = 0x7,
+};
+
+struct switchtec_dma_hw_se_desc {
+	u8 opc;
+	u8 ctrl;
+	__le16 tlp_setting;
+	__le16 rsvd1;
+	__le16 cid;
+	__le32 byte_cnt;
+	union {
+		__le32 saddr_lo;
+		__le32 widata_lo;
+	};
+	union {
+		__le32 saddr_hi;
+		__le32 widata_hi;
+	};
+	__le32 daddr_lo;
+	__le32 daddr_hi;
+	__le16 dfid;
+	__le16 sfid;
+};
+
+#define SWITCHTEC_SE_DFM                BIT(5)
+#define SWITCHTEC_SE_LIOF               BIT(6)
+#define SWITCHTEC_SE_BRR                BIT(7)
+#define SWITCHTEC_SE_CID_MASK           GENMASK(15, 0)
+
+#define SWITCHTEC_CE_SC_LEN_ERR         BIT(0)
+#define SWITCHTEC_CE_SC_UR              BIT(1)
+#define SWITCHTEC_CE_SC_CA              BIT(2)
+#define SWITCHTEC_CE_SC_RSVD_CPL        BIT(3)
+#define SWITCHTEC_CE_SC_ECRC_ERR        BIT(4)
+#define SWITCHTEC_CE_SC_EP_SET          BIT(5)
+#define SWITCHTEC_CE_SC_D_RD_CTO        BIT(8)
+#define SWITCHTEC_CE_SC_D_RIMM_UR       BIT(9)
+#define SWITCHTEC_CE_SC_D_RIMM_CA       BIT(10)
+#define SWITCHTEC_CE_SC_D_RIMM_RSVD_CPL BIT(11)
+#define SWITCHTEC_CE_SC_D_ECRC          BIT(12)
+#define SWITCHTEC_CE_SC_D_EP_SET        BIT(13)
+#define SWITCHTEC_CE_SC_D_BAD_CONNID    BIT(14)
+#define SWITCHTEC_CE_SC_D_BAD_RHI_ADDR  BIT(15)
+#define SWITCHTEC_CE_SC_D_INVD_CMD      BIT(16)
+#define SWITCHTEC_CE_SC_MASK		GENMASK(16, 0)
+
+struct switchtec_dma_hw_ce {
+	__le32 rdimm_cpl_dw0;
+	__le32 rdimm_cpl_dw1;
+	__le32 rsvd1;
+	__le32 cpl_byte_cnt;
+	__le16 sq_head;
+	__le16 rsvd2;
+	__le32 rsvd3;
+	__le32 sts_code;
+	__le16 cid;
+	__le16 phase_tag;
+};
+
+struct switchtec_dma_desc {
+	struct dma_async_tx_descriptor txd;
+	struct switchtec_dma_hw_se_desc *hw;
+	u32 orig_size;
+	bool completed;
+};
+
+#define HALT_RETRY 100
+static int halt_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	u32 status;
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	int retry = HALT_RETRY;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
+
+	ret = -EIO;
+	do {
+		status = readl(&chan_hw->status);
+
+		if (status & SWITCHTEC_CHAN_STS_HALTED) {
+			ret = 0;
+			break;
+		}
+
+		udelay(1000);
+	} while (retry--);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int unhalt_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	u8 ctrl;
+	u32 status;
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	int retry = HALT_RETRY;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	ctrl = readb(&chan_hw->ctrl);
+	ctrl &= ~SWITCHTEC_CHAN_CTRL_HALT;
+
+	writeb(ctrl, &chan_hw->ctrl);
+
+	ret = -EIO;
+	do {
+		status = readl(&chan_hw->status);
+		if (!(status & SWITCHTEC_CHAN_STS_HALTED)) {
+			ret = 0;
+			break;
+		}
+
+		udelay(1000);
+	} while (retry--);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int reset_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	u8 ctrl;
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	ctrl = SWITCHTEC_CHAN_CTRL_RESET;
+	ctrl |= SWITCHTEC_CHAN_CTRL_ERR_PAUSE;
+	writel(ctrl, &chan_hw->ctrl);
+
+	udelay(1000);
+
+	ctrl = SWITCHTEC_CHAN_CTRL_ERR_PAUSE;
+	writel(ctrl, &chan_hw->ctrl);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+	rcu_read_unlock();
+	return 0;
+}
+
+static int pause_reset_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+	rcu_read_unlock();
+
+	/* wait 60ms to ensure no pending CEs */
+	msleep(60);
+
+	return reset_channel(swdma_chan);
+
+}
+
+#define PAUSE_RESUME_RETRY 100
+static int switchtec_dma_pause(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	u32 status;
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	int retry = PAUSE_RESUME_RETRY;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
+
+	ret = -EIO;
+	do {
+		status = readl(&chan_hw->status);
+
+		if (status & SWITCHTEC_CHAN_STS_PAUSED) {
+			ret = 0;
+			break;
+		}
+
+		udelay(1000);
+	} while (retry--);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int switchtec_dma_resume(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	u32 status;
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	int retry = PAUSE_RESUME_RETRY;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(0, &chan_hw->ctrl);
+
+	ret = -EIO;
+	do {
+		status = readl(&chan_hw->status);
+
+		if (!(status & SWITCHTEC_CHAN_STS_PAUSED)) {
+			ret = 0;
+			break;
+		}
+
+		udelay(1000);
+	} while (retry--);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int enable_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	u32 valid_en_se;
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	struct pci_dev *pdev;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	valid_en_se = readl(&chan_fw->valid_en_se);
+	valid_en_se |= SWITCHTEC_CHAN_ENABLE;
+
+	writel(valid_en_se, &chan_fw->valid_en_se);
+
+	rcu_read_unlock();
+	return 0;
+}
+
+static int disable_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	u32 valid_en_se;
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	struct pci_dev *pdev;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	valid_en_se = readl(&chan_fw->valid_en_se);
+	valid_en_se &= ~SWITCHTEC_CHAN_ENABLE;
+
+	writel(valid_en_se, &chan_fw->valid_en_se);
+
+	rcu_read_unlock();
+	return 0;
+}
+
+#define SWITCHTEC_DMA_SQ_SIZE SZ_32K
+#define SWITCHTEC_DMA_CQ_SIZE SZ_32K
+
+#define SWITCHTEC_DMA_RING_SIZE SWITCHTEC_DMA_SQ_SIZE
+
+static struct switchtec_dma_desc *switchtec_dma_get_desc(
+		struct switchtec_dma_chan *swdma_chan, int i)
+{
+	return swdma_chan->desc_ring[i];
+}
+
+static struct switchtec_dma_hw_ce *switchtec_dma_get_ce(
+		struct switchtec_dma_chan *swdma_chan, int i)
+{
+	return &swdma_chan->hw_cq[i];
+}
+
+static void switchtec_dma_process_desc(struct switchtec_dma_chan *swdma_chan)
+{
+	struct device *chan_dev = to_chan_dev(swdma_chan);
+	struct dmaengine_result res;
+	struct switchtec_dma_desc *desc;
+	struct switchtec_dma_hw_ce *ce;
+	__le16 phase_tag;
+	int tail;
+	int cid;
+	int se_idx;
+	u32 sts_code;
+	int i;
+	int *p;
+
+	do {
+		spin_lock_bh(&swdma_chan->complete_lock);
+		if (!swdma_chan->comp_ring_active) {
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			break;
+		}
+
+		ce = switchtec_dma_get_ce(swdma_chan, swdma_chan->cq_tail);
+
+		/*
+		 * phase_tag is updated by hardware, ensure the value is
+		 * not from the cache
+		 */
+		phase_tag = smp_load_acquire(&ce->phase_tag);
+		if (le16_to_cpu(phase_tag) == swdma_chan->phase_tag) {
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			break;
+		}
+
+		cid = le16_to_cpu(ce->cid);
+		se_idx = cid & (SWITCHTEC_DMA_SQ_SIZE - 1);
+		desc = switchtec_dma_get_desc(swdma_chan, se_idx);
+
+		tail = swdma_chan->tail;
+
+		res.residue = desc->orig_size - le32_to_cpu(ce->cpl_byte_cnt);
+
+		sts_code = le32_to_cpu(ce->sts_code);
+
+		if (!(sts_code & SWITCHTEC_CE_SC_MASK)) {
+			res.result = DMA_TRANS_NOERROR;
+		} else {
+			if (sts_code & SWITCHTEC_CE_SC_D_RD_CTO)
+				res.result = DMA_TRANS_READ_FAILED;
+			else
+				res.result = DMA_TRANS_WRITE_FAILED;
+
+			dev_err(chan_dev, "CID 0x%04x failed, SC 0x%08x\n", cid,
+				(u32)(sts_code & SWITCHTEC_CE_SC_MASK));
+
+			p = (int *)ce;
+			for (i = 0; i < sizeof(*ce)/4; i++) {
+				dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
+					le32_to_cpu((__force __le32)*p));
+				p++;
+			}
+		}
+
+		desc->completed = true;
+
+		swdma_chan->cq_tail++;
+		swdma_chan->cq_tail &= SWITCHTEC_DMA_CQ_SIZE - 1;
+
+		rcu_read_lock();
+		if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+			rcu_read_unlock();
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			return;
+		}
+		writew(swdma_chan->cq_tail, &swdma_chan->mmio_chan_hw->cq_head);
+		rcu_read_unlock();
+
+		if (swdma_chan->cq_tail == 0)
+			swdma_chan->phase_tag = !swdma_chan->phase_tag;
+
+		/*  Out of order CE */
+		if (se_idx != tail) {
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			continue;
+		}
+
+		do {
+			dma_cookie_complete(&desc->txd);
+			dma_descriptor_unmap(&desc->txd);
+			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
+			desc->txd.callback = NULL;
+			desc->txd.callback_result = NULL;
+			desc->completed = false;
+
+			tail++;
+			tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
+
+			/*
+			 * Ensure the desc updates are visible before updating
+			 * the tail index
+			 */
+			smp_store_release(&swdma_chan->tail, tail);
+			desc = switchtec_dma_get_desc(swdma_chan,
+						      swdma_chan->tail);
+			if (!desc->completed)
+				break;
+		} while (CIRC_CNT(READ_ONCE(swdma_chan->head), swdma_chan->tail,
+				  SWITCHTEC_DMA_SQ_SIZE));
+
+		spin_unlock_bh(&swdma_chan->complete_lock);
+	} while (1);
+}
+
+static void switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan,
+		int force)
+{
+	struct dmaengine_result res;
+	struct switchtec_dma_desc *desc;
+
+	if (!force)
+		switchtec_dma_process_desc(swdma_chan);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+
+	while (CIRC_CNT(swdma_chan->head, swdma_chan->tail,
+			SWITCHTEC_DMA_SQ_SIZE) >= 1) {
+		desc = switchtec_dma_get_desc(swdma_chan, swdma_chan->tail);
+
+		res.residue = desc->orig_size;
+		res.result = DMA_TRANS_ABORTED;
+
+		dma_cookie_complete(&desc->txd);
+		dma_descriptor_unmap(&desc->txd);
+		if (!force)
+			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
+		desc->txd.callback = NULL;
+		desc->txd.callback_result = NULL;
+
+		swdma_chan->tail++;
+		swdma_chan->tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
+	}
+
+	spin_unlock_bh(&swdma_chan->complete_lock);
+}
+
+static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
+{
+	int rc;
+
+	rc = halt_channel(swdma_chan);
+	if (rc)
+		return;
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
+	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
+	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
+	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
+
+	rcu_read_unlock();
+}
+
+static int switchtec_dma_terminate_all(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+
+	return pause_reset_channel(swdma_chan);
+}
+
+static void switchtec_dma_synchronize(struct dma_chan *chan)
+{
+	struct pci_dev *pdev;
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	int rc;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (pdev)
+		synchronize_irq(swdma_chan->irq);
+	rcu_read_unlock();
+
+	switchtec_dma_abort_desc(swdma_chan, 1);
+
+	rc = enable_channel(swdma_chan);
+	if (rc)
+		return;
+
+	rc = reset_channel(swdma_chan);
+	if (rc)
+		return;
+
+	rc = unhalt_channel(swdma_chan);
+	if (rc)
+		return;
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->head = 0;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = true;
+	swdma_chan->phase_tag = 0;
+	swdma_chan->tail = 0;
+	swdma_chan->cq_tail = 0;
+	swdma_chan->cid = 0;
+	dma_cookie_init(chan);
+	spin_unlock_bh(&swdma_chan->complete_lock);
+}
+
+static void switchtec_dma_desc_task(unsigned long data)
+{
+	struct switchtec_dma_chan *swdma_chan = (void *)data;
+
+	switchtec_dma_process_desc(swdma_chan);
+}
+
+static void switchtec_dma_chan_status_task(unsigned long data)
+{
+	struct switchtec_dma_dev *swdma_dev = (void *)data;
+	struct dma_device *dma_dev = &swdma_dev->dma_dev;
+	struct dma_chan *chan;
+	struct switchtec_dma_chan *swdma_chan;
+	struct chan_hw_regs __iomem *chan_hw;
+	struct device *chan_dev;
+	u32 chan_status;
+	int bit;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		swdma_chan = to_switchtec_dma_chan(chan);
+		chan_dev = to_chan_dev(swdma_chan);
+		chan_hw = swdma_chan->mmio_chan_hw;
+
+		rcu_read_lock();
+		if (!rcu_dereference(swdma_dev->pdev)) {
+			rcu_read_unlock();
+			return;
+		}
+
+		chan_status = readl(&chan_hw->status);
+		chan_status &= SWITCHTEC_CHAN_STS_PAUSED_MASK;
+		rcu_read_unlock();
+
+		bit = ffs(chan_status);
+		if (!bit)
+			dev_dbg(chan_dev, "No pause bit set.");
+		else
+			dev_err(chan_dev, "Paused, %s\n",
+				channel_status_str[bit - 1]);
+	}
+}
+
+#define SWITCHTEC_INVALID_HFID 0xffff
+
+enum desc_type {
+	MEMCPY,
+	WIMM,
+	UNKNOWN_TRANSACTION,
+};
+
+static struct dma_async_tx_descriptor *switchtec_dma_prep_desc(
+		struct dma_chan *c, enum desc_type type, u16 dst_fid,
+		dma_addr_t dma_dst, u16 src_fid, dma_addr_t dma_src, u64 data,
+		size_t len, unsigned long flags)
+	__acquires(swdma_chan->submit_lock)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(c);
+	struct device *chan_dev = to_chan_dev(swdma_chan);
+	struct switchtec_dma_desc *desc;
+	int head;
+	int tail;
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+
+	if (type >= UNKNOWN_TRANSACTION)
+		goto err_unlock;
+
+	if (type == MEMCPY)
+		if (len > SWITCHTEC_DESC_MAX_SIZE)
+			goto err_unlock;
+
+	if ((type == WIMM) && (len == 8))
+		if (dma_dst & ((1 << DMAENGINE_ALIGN_8_BYTES) - 1)) {
+			dev_err(chan_dev,
+				"QW WIMM dst addr 0x%08x_%08x not QW aligned!\n",
+				upper_32_bits(dma_dst), lower_32_bits(dma_dst));
+			goto err_unlock;
+		}
+
+	if (!swdma_chan->ring_active)
+		goto err_unlock;
+
+	tail = READ_ONCE(swdma_chan->tail);
+	head = swdma_chan->head;
+
+	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
+		goto err_unlock;
+
+	desc = switchtec_dma_get_desc(swdma_chan, head);
+
+	if (src_fid != SWITCHTEC_INVALID_HFID &&
+	    dst_fid != SWITCHTEC_INVALID_HFID)
+		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
+
+	if (flags & DMA_PREP_INTERRUPT)
+		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
+
+	if (flags & DMA_PREP_FENCE)
+		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
+
+	desc->txd.flags = flags;
+
+	desc->completed = false;
+	if (type == MEMCPY) {
+		desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
+		desc->hw->saddr_lo = cpu_to_le32(lower_32_bits(dma_src));
+		desc->hw->saddr_hi = cpu_to_le32(upper_32_bits(dma_src));
+	} else {
+		desc->hw->opc = SWITCHTEC_DMA_OPC_WRIMM;
+		desc->hw->widata_lo = cpu_to_le32(lower_32_bits(data));
+		desc->hw->widata_hi = cpu_to_le32(upper_32_bits(data));
+	}
+	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
+	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
+	desc->hw->byte_cnt = cpu_to_le32(len);
+	desc->hw->tlp_setting = 0;
+	desc->hw->dfid = cpu_to_le16(dst_fid);
+	desc->hw->sfid = cpu_to_le16(src_fid);
+	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
+	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
+	desc->orig_size = len;
+
+	head++;
+	head &= SWITCHTEC_DMA_RING_SIZE - 1;
+
+	/*
+	 * Ensure the desc updates are visible before updating the head index
+	 */
+	smp_store_release(&swdma_chan->head, head);
+
+	/* return with the lock held, it will be released in tx_submit */
+
+	return &desc->txd;
+
+err_unlock:
+	/*
+	 * Keep sparse happy by restoring an even lock count on
+	 * this lock.
+	 */
+	__acquire(swdma_chan->submit_lock);
+
+	spin_unlock_bh(&swdma_chan->submit_lock);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *switchtec_dma_prep_memcpy(
+		struct dma_chan *c, dma_addr_t dma_dst, dma_addr_t dma_src,
+		size_t len, unsigned long flags)
+	__acquires(swdma_chan->submit_lock)
+{
+
+	return switchtec_dma_prep_desc(c, MEMCPY, SWITCHTEC_INVALID_HFID,
+				       dma_dst, SWITCHTEC_INVALID_HFID, dma_src,
+				       0, len, flags);
+}
+
+static struct dma_async_tx_descriptor *switchtec_dma_prep_wimm_data(
+		struct dma_chan *c, dma_addr_t dst, u64 data,
+		unsigned long flags)
+	__acquires(swdma_chan->submit_lock)
+{
+	return switchtec_dma_prep_desc(c, WIMM, SWITCHTEC_INVALID_HFID, dst,
+				       SWITCHTEC_INVALID_HFID, 0, data,
+				       sizeof(data), flags);
+}
+
+static dma_cookie_t switchtec_dma_tx_submit(
+		struct dma_async_tx_descriptor *desc)
+	__releases(swdma_chan->submit_lock)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		to_switchtec_dma_chan(desc->chan);
+	dma_cookie_t cookie;
+
+	cookie = dma_cookie_assign(desc);
+
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	return cookie;
+}
+
+static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
+		dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	enum dma_status ret;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	switchtec_dma_process_desc(swdma_chan);
+
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static void switchtec_dma_issue_pending(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+
+	/*
+	 * Ensure the desc updates are visible before starting the
+	 * DMA engine.
+	 */
+	wmb();
+
+	/*
+	 * The sq_tail register is actually for the head of the
+	 * submisssion queue. Chip has the opposite define of head/tail
+	 * to the Linux kernel.
+	 */
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	rcu_read_unlock();
+}
+
+static irqreturn_t switchtec_dma_isr(int irq, void *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = chan;
+
+	if (swdma_chan->comp_ring_active)
+		tasklet_schedule(&swdma_chan->desc_task);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
+{
+	struct switchtec_dma_dev *swdma_dev = dma;
+
+	tasklet_schedule(&swdma_dev->chan_status_task);
+
+	return IRQ_HANDLED;
+}
+
+static void switchtec_dma_free_desc(struct switchtec_dma_chan *swdma_chan)
+{
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+	size_t size;
+	int i;
+
+	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
+	if (swdma_chan->hw_sq)
+		dma_free_coherent(swdma_dev->dma_dev.dev, size,
+				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
+
+	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
+	if (swdma_chan->hw_cq)
+		dma_free_coherent(swdma_dev->dma_dev.dev, size,
+				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
+
+	if (swdma_chan->desc_ring) {
+		for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
+			kfree(swdma_chan->desc_ring[i]);
+
+		kfree(swdma_chan->desc_ring);
+	}
+}
+
+static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
+{
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+	struct pci_dev *pdev;
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	size_t size;
+	struct switchtec_dma_desc *desc;
+	int rc;
+	int i;
+
+	swdma_chan->head = swdma_chan->tail = 0;
+	swdma_chan->cq_tail = 0;
+
+	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
+	swdma_chan->hw_sq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
+					       &swdma_chan->dma_addr_sq,
+					       GFP_KERNEL);
+	if (!swdma_chan->hw_sq) {
+		rc = -ENOMEM;
+		goto free_and_exit;
+	}
+
+	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
+	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
+					       &swdma_chan->dma_addr_cq,
+					       GFP_KERNEL);
+	if (!swdma_chan->hw_cq) {
+		rc = -ENOMEM;
+		goto free_and_exit;
+	}
+
+	/* reset host phase tag */
+	swdma_chan->phase_tag = 0;
+
+	size = sizeof(*swdma_chan->desc_ring);
+	swdma_chan->desc_ring = kcalloc(SWITCHTEC_DMA_RING_SIZE, size,
+					GFP_KERNEL);
+	if (!swdma_chan->desc_ring) {
+		rc = -ENOMEM;
+		goto free_and_exit;
+	}
+
+	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
+		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+		if (!desc) {
+			rc = -ENOMEM;
+			goto free_and_exit;
+		}
+
+		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
+		desc->txd.tx_submit = switchtec_dma_tx_submit;
+		desc->hw = &swdma_chan->hw_sq[i];
+		desc->completed = true;
+
+		swdma_chan->desc_ring[i] = desc;
+	}
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		rc = -ENODEV;
+		goto free_and_exit;
+	}
+
+	/* set sq/cq */
+	writel(lower_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_lo);
+	writel(upper_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_hi);
+	writel(lower_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_lo);
+	writel(upper_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_hi);
+
+	writew((__force u16)cpu_to_le16(SWITCHTEC_DMA_SQ_SIZE),
+	       &swdma_chan->mmio_chan_fw->sq_size);
+	writew((__force u16)cpu_to_le16(SWITCHTEC_DMA_CQ_SIZE),
+	       &swdma_chan->mmio_chan_fw->cq_size);
+
+	rcu_read_unlock();
+	return 0;
+
+free_and_exit:
+	switchtec_dma_free_desc(swdma_chan);
+	return rc;
+}
+
+static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+	u32 perf_cfg;
+	int rc;
+
+	rc = switchtec_dma_alloc_desc(swdma_chan);
+	if (rc)
+		return rc;
+
+	rc = enable_channel(swdma_chan);
+	if (rc)
+		return rc;
+
+	rc = reset_channel(swdma_chan);
+	if (rc)
+		return rc;
+
+	rc = unhalt_channel(swdma_chan);
+	if (rc)
+		return rc;
+
+	swdma_chan->ring_active = true;
+	swdma_chan->comp_ring_active = true;
+	swdma_chan->cid = 0;
+
+	dma_cookie_init(chan);
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
+	rcu_read_unlock();
+
+	dev_dbg(&chan->dev->device, "Burst Size:  0x%x",
+		(perf_cfg >> PERF_BURST_SIZE_SHIFT) & PERF_BURST_SIZE_MASK);
+
+	dev_dbg(&chan->dev->device, "Burst Scale: 0x%x",
+		(perf_cfg >> PERF_BURST_SCALE_SHIFT) & PERF_BURST_SCALE_MASK);
+
+	dev_dbg(&chan->dev->device, "Interval:    0x%x",
+		(perf_cfg >> PERF_INTERVAL_SHIFT) & PERF_INTERVAL_MASK);
+
+	dev_dbg(&chan->dev->device, "Arb Weight:  0x%x",
+		(perf_cfg >> PERF_ARB_WEIGHT_SHIFT) & PERF_ARB_WEIGHT_MASK);
+
+	dev_dbg(&chan->dev->device, "MRRS:        0x%x",
+		(perf_cfg >> PERF_MRRS_SHIFT) & PERF_MRRS_MASK);
+
+	return SWITCHTEC_DMA_SQ_SIZE;
+}
+
+static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
+	struct pci_dev *pdev;
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->ring_active = false;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+
+	switchtec_dma_chan_stop(swdma_chan);
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (pdev)
+		synchronize_irq(swdma_chan->irq);
+	rcu_read_unlock();
+
+	tasklet_kill(&swdma_chan->desc_task);
+
+	switchtec_dma_abort_desc(swdma_chan, 0);
+
+	switchtec_dma_free_desc(swdma_chan);
+
+	disable_channel(swdma_chan);
+}
+
+#define SWITCHTEC_DMA_CHAN_HW_REGS_SIZE 0x1000
+#define SWITCHTEC_DMA_CHAN_FW_REGS_SIZE 0x80
+
+
+static int switchtec_dma_chan_init(struct switchtec_dma_dev *swdma_dev, int i)
+{
+	struct dma_device *dma = &swdma_dev->dma_dev;
+	struct pci_dev *pdev;
+	struct dma_chan *chan;
+	struct switchtec_dma_chan *swdma_chan;
+	struct chan_fw_regs __iomem *chan_fw;
+	struct chan_hw_regs __iomem *chan_hw;
+	u32 perf_cfg;
+	u32 valid_en_se;
+	u32 thresh;
+	int se_buf_len;
+	int irq;
+	int rc;
+	size_t offset;
+
+	swdma_chan = kzalloc(sizeof(*swdma_chan), GFP_KERNEL);
+	if (!swdma_chan)
+		return -ENOMEM;
+
+	swdma_chan->phase_tag = 0;
+	swdma_chan->index = i;
+
+	offset =  i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
+	chan_fw = (struct chan_fw_regs __iomem *)(swdma_dev->mmio_chan_fw_all
+			+ offset);
+
+	offset =  i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;
+	chan_hw = (struct chan_hw_regs __iomem *)(swdma_dev->mmio_chan_hw_all
+			+ offset);
+
+	swdma_dev->swdma_chans[i] = swdma_chan;
+	swdma_chan->mmio_chan_fw = chan_fw;
+	swdma_chan->mmio_chan_hw = chan_hw;
+	swdma_chan->swdma_dev = swdma_dev;
+
+	rc = pause_reset_channel(swdma_chan);
+	if (rc)
+		goto free_and_exit;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_dev->pdev);
+	if (!pdev) {
+		rc = -ENODEV;
+		goto unlock_and_free;
+	}
+
+	perf_cfg = readl(&chan_fw->perf_cfg);
+
+	/* init perf tuner */
+	perf_cfg = PERF_BURST_SCALE << PERF_BURST_SCALE_SHIFT;
+	perf_cfg |= PERF_MRRS << PERF_MRRS_SHIFT;
+	perf_cfg |= PERF_INTERVAL << PERF_INTERVAL_SHIFT;
+	perf_cfg |= PERF_BURST_SIZE << PERF_BURST_SIZE_SHIFT;
+	perf_cfg |= PERF_ARB_WEIGHT << PERF_ARB_WEIGHT_SHIFT;
+
+	writel(perf_cfg, &chan_fw->perf_cfg);
+
+	valid_en_se = readl(&chan_fw->valid_en_se);
+
+	dev_dbg(&pdev->dev, "Channel %d: SE buffer base %d\n",
+		i, (valid_en_se >> SE_BUF_BASE_SHIFT) & SE_BUF_BASE_MASK);
+
+	se_buf_len = (valid_en_se >> SE_BUF_LEN_SHIFT) & SE_BUF_LEN_MASK;
+	dev_dbg(&pdev->dev, "Channel %d: SE buffer count %d\n", i, se_buf_len);
+
+	thresh = se_buf_len / 2;
+	valid_en_se |= (thresh & SE_THRESH_MASK) << SE_THRESH_SHIFT;
+	writel(valid_en_se, &chan_fw->valid_en_se);
+
+	/* request irqs */
+	irq = readl(&chan_fw->int_vec);
+	dev_dbg(&pdev->dev, "Channel %d: CE irq vector %d\n", i, irq);
+
+	irq = pci_irq_vector(pdev, irq);
+	if (irq < 0) {
+		rc = irq;
+		goto unlock_and_free;
+	}
+
+	rcu_read_unlock();
+
+	rc = request_irq(irq, switchtec_dma_isr, 0, KBUILD_MODNAME, swdma_chan);
+	if (rc)
+		goto free_and_exit;
+
+	swdma_chan->irq = irq;
+
+	spin_lock_init(&swdma_chan->hw_ctrl_lock);
+	spin_lock_init(&swdma_chan->submit_lock);
+	spin_lock_init(&swdma_chan->complete_lock);
+	tasklet_init(&swdma_chan->desc_task, switchtec_dma_desc_task,
+		     (unsigned long)swdma_chan);
+
+	chan = &swdma_chan->dma_chan;
+	chan->device = dma;
+	dma_cookie_init(chan);
+
+	list_add_tail(&chan->device_node, &dma->channels);
+
+	return 0;
+
+unlock_and_free:
+	rcu_read_unlock();
+
+free_and_exit:
+	kfree(swdma_chan);
+	return rc;
+}
+
+void switchtec_chan_kobject_del(struct switchtec_dma_chan *swdma_chan);
+
+static int switchtec_dma_chan_free(struct switchtec_dma_chan *swdma_chan)
+{
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->ring_active = false;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+
+	free_irq(swdma_chan->irq, swdma_chan);
+
+	switchtec_dma_chan_stop(swdma_chan);
+
+	return 0;
+}
+
+static int switchtec_dma_chans_release(struct switchtec_dma_dev *swdma_dev)
+{
+	int i;
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		switchtec_dma_chan_free(swdma_dev->swdma_chans[i]);
+
+	return 0;
+}
+
+static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
+					 int chan_cnt)
+{
+	struct dma_device *dma = &swdma_dev->dma_dev;
+	struct pci_dev *pdev;
+	int base;
+	int cnt;
+	int rc;
+	int i;
+
+	swdma_dev->swdma_chans = kcalloc(chan_cnt,
+					 sizeof(*swdma_dev->swdma_chans),
+					 GFP_KERNEL);
+
+	if (!swdma_dev->swdma_chans)
+		return -ENOMEM;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		kfree(swdma_dev->swdma_chans);
+		return -ENODEV;
+	}
+
+	base = readw(&swdma_dev->mmio_dmac_cap->se_buf_base);
+	cnt = readw(&swdma_dev->mmio_dmac_cap->se_buf_cnt);
+
+	rcu_read_unlock();
+
+	dev_dbg(&pdev->dev, "EP SE buffer base %d\n", base);
+	dev_dbg(&pdev->dev, "EP SE buffer count %d\n", cnt);
+
+	INIT_LIST_HEAD(&dma->channels);
+
+	for (i = 0; i < chan_cnt; i++) {
+		rc = switchtec_dma_chan_init(swdma_dev, i);
+		if (rc) {
+			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
+				i);
+			chan_cnt = i;
+			goto err_exit;
+		}
+	}
+
+	return chan_cnt;
+
+err_exit:
+	for (i = 0; i < chan_cnt; i++)
+		switchtec_dma_chan_free(swdma_dev->swdma_chans[i]);
+
+	kfree(swdma_dev->swdma_chans);
+
+	return rc;
+}
+
+static void switchtec_dma_release(struct dma_device *dma_dev)
+{
+	int i;
+	struct switchtec_dma_dev *swdma_dev =
+		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		kfree(swdma_dev->swdma_chans[i]);
+
+	kfree(swdma_dev->swdma_chans);
+
+	put_device(dma_dev->dev);
+	kfree(swdma_dev);
+}
+
+static int switchtec_dma_create(struct pci_dev *pdev)
+{
+	struct switchtec_dma_dev *swdma_dev;
+	struct dma_device *dma;
+	struct dma_chan *chan;
+	void __iomem *bar;
+	int chan_cnt;
+	int nr_vecs;
+	int irq;
+	int rc;
+	int i;
+
+	/*
+	 * Create the switchtec dma device
+	 */
+	swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
+	if (!swdma_dev)
+		return -ENOMEM;
+
+	bar = pcim_iomap_table(pdev)[0];
+	swdma_dev->bar = bar;
+
+	swdma_dev->mmio_dmac_ver = bar + SWITCHTEC_DMAC_VERSION_OFFSET;
+	swdma_dev->mmio_dmac_cap = bar + SWITCHTEC_DMAC_CAPABILITY_OFFSET;
+	swdma_dev->mmio_dmac_status = bar + SWITCHTEC_DMAC_STATUS_OFFSET;
+	swdma_dev->mmio_dmac_ctrl = bar + SWITCHTEC_DMAC_CONTROL_OFFSET;
+	swdma_dev->mmio_chan_hw_all = bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET;
+	swdma_dev->mmio_chan_fw_all = bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET;
+
+	pci_info(pdev, "Switchtec PSX/PFX DMA EP\n");
+
+	RCU_INIT_POINTER(swdma_dev->pdev, pdev);
+
+	nr_vecs = pci_msix_vec_count(pdev);
+	rc = pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
+	if (rc < 0)
+		goto err_exit;
+
+	tasklet_init(&swdma_dev->chan_status_task,
+		     switchtec_dma_chan_status_task,
+		     (unsigned long)swdma_dev);
+
+	irq = readw(&swdma_dev->mmio_dmac_cap->chan_sts_vec);
+	pci_dbg(pdev, "Channel pause irq vector %d\n", irq);
+
+	irq = pci_irq_vector(pdev, irq);
+	if (irq < 0) {
+		rc = irq;
+		goto err_exit;
+	}
+
+	rc = request_irq(irq, switchtec_dma_chan_status_isr, 0,
+			 KBUILD_MODNAME, swdma_dev);
+	if (rc)
+		goto err_exit;
+
+	swdma_dev->chan_status_irq = irq;
+
+	chan_cnt = le32_to_cpu((__force __le32)
+			       readl(&swdma_dev->mmio_dmac_cap->chan_cnt));
+	if (!chan_cnt) {
+		pci_err(pdev, "No channel configured.\n");
+		rc = -ENXIO;
+		goto err_exit;
+	}
+
+	chan_cnt = switchtec_dma_chans_enumerate(swdma_dev, chan_cnt);
+	if (chan_cnt < 0) {
+		pci_err(pdev, "Failed to enumerate dma channels: %d\n",
+			chan_cnt);
+		rc = -ENXIO;
+		goto err_exit;
+	}
+
+	swdma_dev->chan_cnt = chan_cnt;
+
+	dma = &swdma_dev->dma_dev;
+	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
+	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
+	dma->dev = get_device(&pdev->dev);
+
+	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
+	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
+	dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
+	dma->device_prep_dma_imm_data = switchtec_dma_prep_wimm_data;
+	dma->device_issue_pending = switchtec_dma_issue_pending;
+	dma->device_tx_status = switchtec_dma_tx_status;
+	dma->device_pause = switchtec_dma_pause;
+	dma->device_resume = switchtec_dma_resume;
+	dma->device_terminate_all = switchtec_dma_terminate_all;
+	dma->device_synchronize = switchtec_dma_synchronize;
+	dma->device_release = switchtec_dma_release;
+
+	rc = dma_async_device_register(dma);
+	if (rc) {
+		pci_err(pdev, "Failed to register dma device: %d\n", rc);
+		goto err_chans_release_exit;
+	}
+
+	pci_info(pdev, "Channel count: %d\n", chan_cnt);
+
+	i = 0;
+	list_for_each_entry(chan, &dma->channels, device_node)
+		pci_info(pdev, "Channel %d: %s\n", i++, dma_chan_name(chan));
+
+	pci_set_drvdata(pdev, swdma_dev);
+
+	return 0;
+
+err_chans_release_exit:
+	switchtec_dma_chans_release(swdma_dev);
+
+err_exit:
+	if (swdma_dev->chan_status_irq)
+		free_irq(swdma_dev->chan_status_irq, swdma_dev);
+
+	kfree(swdma_dev);
+	return rc;
+}
+
+static int switchtec_dma_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pdev, 1, KBUILD_MODNAME);
+	if (rc)
+		return rc;
+
+	pci_set_master(pdev);
+
+	rc = switchtec_dma_create(pdev);
+	if (rc)
+		goto err_free_irq_vectors;
+
+	pci_info(pdev, "Switchtec DMA Channels Registered\n");
+
+	return 0;
+
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
+	return rc;
+}
+
+static void switchtec_dma_remove(struct pci_dev *pdev)
+{
+	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
+
+	switchtec_dma_chans_release(swdma_dev);
+
+	tasklet_kill(&swdma_dev->chan_status_task);
+
+	rcu_assign_pointer(swdma_dev->pdev, NULL);
+	synchronize_rcu();
+
+	free_irq(swdma_dev->chan_status_irq, swdma_dev);
+
+	pci_free_irq_vectors(pdev);
+
+	dma_async_device_unregister(&swdma_dev->dma_dev);
+
+	pci_info(pdev, "Switchtec DMA Channels Unregistered\n");
+}
+
+#define MICROSEMI_VENDOR_ID 0x11f8
+
+#define SWITCHTEC_PCI_DEVICE(device_id) \
+	{ \
+		.vendor     = MICROSEMI_VENDOR_ID, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
+		.class_mask = 0xFFFFFFFF, \
+	}
+
+static const struct pci_device_id switchtec_dma_pci_tbl[] = {
+	SWITCHTEC_PCI_DEVICE(0x4000),  //PFX 100XG4
+	SWITCHTEC_PCI_DEVICE(0x4084),  //PFX 84XG4
+	SWITCHTEC_PCI_DEVICE(0x4068),  //PFX 68XG4
+	SWITCHTEC_PCI_DEVICE(0x4052),  //PFX 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4036),  //PFX 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4028),  //PFX 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4100),  //PSX 100XG4
+	SWITCHTEC_PCI_DEVICE(0x4184),  //PSX 84XG4
+	SWITCHTEC_PCI_DEVICE(0x4168),  //PSX 68XG4
+	SWITCHTEC_PCI_DEVICE(0x4152),  //PSX 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4136),  //PSX 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4128),  //PSX 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4352),  //PFXA 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4336),  //PFXA 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4328),  //PFXA 28XG4
+	SWITCHTEC_PCI_DEVICE(0x4452),  //PSXA 52XG4
+	SWITCHTEC_PCI_DEVICE(0x4436),  //PSXA 36XG4
+	SWITCHTEC_PCI_DEVICE(0x4428),  //PSXA 28XG4
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);
+
+static struct pci_driver switchtec_dma_pci_driver = {
+	.name           = KBUILD_MODNAME,
+	.id_table       = switchtec_dma_pci_tbl,
+	.probe          = switchtec_dma_probe,
+	.remove		= switchtec_dma_remove,
+};
+module_pci_driver(switchtec_dma_pci_driver);
-- 
2.25.1

