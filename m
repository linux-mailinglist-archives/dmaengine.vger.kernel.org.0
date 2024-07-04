Return-Path: <dmaengine+bounces-2622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D4927869
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 16:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A381F24EA6
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B541AC247;
	Thu,  4 Jul 2024 14:31:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651011AEFDD
	for <dmaengine@vger.kernel.org>; Thu,  4 Jul 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103508; cv=none; b=aJs3ViKH1cdQb7XBBIHCi+PdIOZS4k9jEMB9A+Ng5fh65ejENHn25t34dWzNvtlgtlrG49LPN/7expZzdKZ18CuLnU58jj/la6FCG+OlyISqWgLa9PNBYzRAHmHaNtITPaKZCXsj3ZBmUVH40OpylOkpSk8n5Qhdlt8KDL6imrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103508; c=relaxed/simple;
	bh=Z6CLPCnol4r5VVbVgo+QPrexPxgLPYLeP2rxD2vd2YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IPJwGJeQrGYkL0VNpFx0oFzXHKK4Wttx6puzSuHkvSKeesNoj0rnrFcsp4H4LDhzobwqgZU5ncXTOevpi6jeL/Xdhvq4ywE2bJlaL7id351O0p/LnIcp8MHF0mqwdIiX21Gwf2hJWnBg6wy/ASwhELvJ/dTejy6mN561mSReO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sPNUk-00062n-9y; Thu, 04 Jul 2024 16:31:34 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 04 Jul 2024 16:31:28 +0200
Subject: [PATCH] dmaengine: sl-dma: Add Smartlogic HCC DMA IP Core driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-sl-dma-v1-1-a4f3c6644101@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAECyhmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNj3eIc3ZTcRF1TkzTzRBNjY+PEpGQloOKCotS0zAqwQdGxtbUAJ/t
 +QVgAAAA=
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Add a dmaengine driver for the Smartlogic HCC DMA IP Core. This core is
intended to be included in custom FPGA designs. As such, the dmaengine
device expects to be the child of a FPGA design specific MFD PCIe
device. The MFD driver determines the BAR and DMA channel configuration
and creates the functional devices that make use of the DMA channels.

Since the IP core requires to be configured with a transfer buffer size
that can not be changed while the DMA engine is active, the per-channel
configuration in platform data contains the fixed buffer size, as well
as interface and IRQ mapping.

Additional interrupts for user logic, such as frame sync interrupts, or
error signals can be enabled in the configuration structure.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Smartlogic PCI Express High Channel Count (HCC) DMA IP Cores [1] can be
implemented within various FPGAs to provide translation between a PCIe
endpoint and multiple AXI Stream Slave and Master interfaces, as well
as map AXI Master interfaces to BARs.

A downloadable demo design [2], provided by the IP vendor to be flashed
onto a Dream Chip Technologies Arria 10 evaluation board, demonstrates
a multi-channel video capture use case with 8 test pattern generators.
For this configuration, an example MFD driver and a V4L2 capture driver
using the DMA channels are located in the sl-dma-demo branch at [3].

The dmaengine driver supports paired channels that transfer together,
with only a single, shared EOF interrupt. The demo design uses this to
pair video data and metadata channels.

[1] https://www.smartlogic.de/en/produkt/high-channel-count-dma-ip-core
[2] https://www.smartlogic.de/en/knowledge/ -> "Arria 10 Demo Design and Bitstream"
[3] https://git.pengutronix.de/cgit/pza/linux/log/?h=sl-dma-demo
    git://git.pengutronix.de/pza/linux refs/heads/sl-dma-demo
---
 MAINTAINERS                |    7 +
 drivers/dma/Kconfig        |   12 +
 drivers/dma/Makefile       |    2 +
 drivers/dma/sl-dma.c       | 1424 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sl-dma.h       |  109 ++++
 include/linux/dma/sl-dma.h |   88 +++
 6 files changed, 1642 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..def612d0a10c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -857,6 +857,13 @@ M:	Mun Yew Tham <mun.yew.tham@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
+SMARTLOGIC HCC DMA IP CORE DRIVER
+M:	Philipp Zabel <p.zabel@pengutronix.de>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/sl-dma.*
+F:	include/linux/dma/sl-dma.h
+
 ALTERA MSGDMA IP CORE DRIVER
 M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
 R:	Stefan Roese <sr@denx.de>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..7c601413cb88 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -546,6 +546,18 @@ config PLX_DMA
 	  These are exposed via extra functions on the switch's
 	  upstream port. Each function exposes one DMA channel.
 
+config SL_DMA
+	tristate "Smartlogic DMA IP Core support"
+	depends on PCI_MSI || COMPILE_TEST
+	select DMA_ENGINE
+	help
+	  Enable support for the Smartlogic HCC DMA IP Core.
+
+	  This configurable core can be included in custom FPGA designs.
+	  A design specific MFD driver is required to set up BAR and DMA
+	  channel configuration and to instantiate the DMA device and the
+	  functional devices that make use of the DMA channels.
+
 config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
 	depends on ARCH_U8500
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 802ca916f05f..c63c426c258f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -69,6 +69,8 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
+obj-$(CONFIG_SIRF_DMA) += sirf-dma.o
+obj-$(CONFIG_SL_DMA) += sl-dma.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_STM32_DMA) += stm32-dma.o
 obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
diff --git a/drivers/dma/sl-dma.c b/drivers/dma/sl-dma.c
new file mode 100644
index 000000000000..6738d9828619
--- /dev/null
+++ b/drivers/dma/sl-dma.c
@@ -0,0 +1,1424 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Linux DMA Driver for the Smartlogic High Channel Count (HCC) DMA IP Core.
+ *
+ * Copyright (C) 2020 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ *
+ * The DMA IP Core is documented in the Smartlogic "High Channel Count
+ * DMA IP Core for PCI-Express User Guide", February 2020.
+ *
+ * Exemplary initialization and teardown procedures are described in the
+ * Smartlogic "DMA Demo Design for the Arria 10 Demo Board from DreamChip"
+ * specification document, version 1.17, which can be downloaded from
+ * https://www.smartlogic.de/en/knowledge/ in the "Arria 10 Demo Design
+ * and Bitstream" package.
+ */
+
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/dma/sl-dma.h>
+#include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "dmaengine.h"
+#include "sl-dma.h"
+
+#define NUM_MSIX_IRQS	32
+
+/**
+ * struct sl_dma_tx_descriptor - async transaction descriptor
+ * @tx: base async transaction descriptor
+ * @node: list_head for channel pending/active/done lists
+ * @addr: physical address to be written into channel address FIFO
+ * @interrupt: whether this transfer triggers an interrupt
+ */
+struct sl_dma_tx_descriptor {
+	struct dma_async_tx_descriptor tx;
+	struct list_head node;
+	dma_addr_t addr;
+	bool interrupt;
+};
+
+/**
+ * struct sl_dma_chan - per-channel driver data
+ * @chan: base DMA slave channel structure
+ * @direction: DMA transfer direction, specifies write or read channel
+ * @transfer_size: channel specific fixed transfer size
+ * @reset_bit: reset bit in the reset flag register
+ * @num: logical channel number
+ * @pending_list: list of pending transfer descriptors
+ * @num_active: number of entries in active_list
+ * @active_list: list of active (queued in hardware FIFOs) descriptors
+ * @done_list: list of finished transfer descriptors (EOF signalled)
+ * @bh_work: DMA completion handler work item
+ * @leader: leading DMA write channel, always transfers before this channel
+ * @follower: following DMA write channel, always transfers after this channel
+ * @irq: irq signalled by this channel's interface
+ * @interface: this channel's AXI Stream interface
+ * @active: true while the channel is (or should be) running
+ * @fifo_underruns: address FIFO underrun counter
+ */
+struct sl_dma_chan {
+	struct dma_chan chan;
+	enum dma_transfer_direction direction;
+	unsigned int transfer_size;
+	u32 reset_bit;
+	unsigned int num;
+	/** @lock: spinlock protecting descriptor lists and counters */
+	spinlock_t lock;
+	struct list_head pending_list;
+	unsigned int num_active;
+	struct list_head active_list;
+	struct list_head done_list;
+	struct work_struct bh_work;
+	struct sl_dma_chan *leader;
+	struct sl_dma_chan *follower;
+	struct sl_dma_irq *irq;
+	u8 interface;
+	bool active;
+	unsigned long fifo_underruns;
+};
+
+struct sl_dma;
+
+/**
+ * struct sl_dma_irq - per MSI-X irq data
+ * @num: MSI-X irq number
+ * @sl_dma: back pointer to driver data
+ * @ch: logical channel that causes this interrupt
+ */
+struct sl_dma_irq {
+	int num;
+	struct sl_dma *sl_dma;
+	struct sl_dma_chan *ch;
+};
+
+/**
+ * struct sl_dma - DMA IP Core driver data
+ * @dev: device pointer
+ * @dma: base DMA device structure
+ * @bar: memory mapped IO registers
+ * @reset_flags: memory mapped IO register
+ * @year: DMA IP core version year
+ * @mps: PCIe maximum payload size
+ * @mrs: PCIe maximum request size
+ * @num_slave_interfaces: number of AXI Stream slave interfaces
+ * @num_master_interfaces: number of AXI Stream master interfaces
+ * @write_sg_fifo_depth: number of entries in DMA write address FIFO
+ * @read_sg_fifo_depth: number of entries in DMA read address FIFO
+ * @num_write_channels: number of logical DMA write channels
+ * @write_channels: pointer to array of DMA channel structures
+ * @num_read_channels: number of logical DMA read channels
+ * @read_channels: pointer to array of DMA channel structures
+ * @irq: array of per MSI-X irq data
+ */
+struct sl_dma {
+	struct device *dev;
+	struct dma_device dma;
+	void __iomem *bar;
+	void __iomem *reset_flags;
+	/** @lock: spinlock protecting register read-modify-writes */
+	spinlock_t lock;
+	unsigned int year;
+	unsigned int mps;
+	unsigned int mrs;
+	unsigned int num_slave_interfaces;
+	unsigned int num_master_interfaces;
+	unsigned int write_sg_fifo_depth;
+	unsigned int read_sg_fifo_depth;
+	unsigned int num_write_channels;
+	struct sl_dma_chan *write_channels;
+	unsigned int num_read_channels;
+	struct sl_dma_chan *read_channels;
+	struct sl_dma_irq irq[NUM_MSIX_IRQS];
+};
+
+static inline struct sl_dma *to_sl_dma(struct dma_device *dma)
+{
+	return container_of(dma, struct sl_dma, dma);
+}
+
+static inline struct sl_dma_chan *to_sl_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct sl_dma_chan, chan);
+}
+
+/*
+ * -----------------------------------------------------------------------------
+ * Register Access
+ * -----------------------------------------------------------------------------
+ */
+
+static inline u32 sl_dma_readl(struct sl_dma *sl_dma, u32 offset)
+{
+	return readl(sl_dma->bar + offset);
+}
+
+static inline void sl_dma_writel(struct sl_dma *sl_dma, u32 offset, u32 value)
+{
+	writel(value, sl_dma->bar + offset);
+}
+
+static inline void sl_dma_writeq(struct sl_dma *sl_dma, u32 offset, u64 value)
+{
+	writeq(value, sl_dma->bar + offset);
+}
+
+/*
+ * -----------------------------------------------------------------------------
+ * Debug and performance measurement helpers
+ * -----------------------------------------------------------------------------
+ */
+
+#ifdef CONFIG_DEBUG_FS
+static int sl_dma_tx_crc_error_read(struct seq_file *s, void *data)
+{
+	struct device *dev = s->private;
+	struct sl_dma *sl_dma = dev_get_drvdata(dev);
+
+	seq_printf(s, "%u\n", sl_dma_readl(sl_dma, REG_TX_CRC_ERROR));
+
+	return 0;
+}
+
+static int sl_dma_rx_crc_error_read(struct seq_file *s, void *data)
+{
+	struct device *dev = s->private;
+	struct sl_dma *sl_dma = dev_get_drvdata(dev);
+
+	seq_printf(s, "%u\n", sl_dma_readl(sl_dma, REG_RX_CRC_ERROR));
+
+	return 0;
+}
+
+static int sl_dma_stall_time_ns_read(struct seq_file *s, void *data)
+{
+	struct device *dev = s->private;
+	struct sl_dma *sl_dma = dev_get_drvdata(dev);
+
+	seq_printf(s, "%llu\n", 16ULL * sl_dma_readl(sl_dma, REG_STALL_TIME));
+
+	return 0;
+}
+
+static int sl_dma_version_read(struct seq_file *s, void *data)
+{
+	struct device *dev = s->private;
+	struct sl_dma *sl_dma = dev_get_drvdata(dev);
+	u32 version;
+	unsigned int revision, year, month, day;
+
+	version = sl_dma_readl(sl_dma, REG_VERSION);
+	revision = VERSION_CORE_REVISION(version);
+	year = 2000 + bcd2bin(VERSION_YEAR(version));
+	month = bcd2bin(VERSION_MONTH(version));
+	day = bcd2bin(VERSION_DAY(version));
+
+	seq_printf(s, "Revision %u, %04u-%02u-%02u\n", revision, year, month,
+		   day);
+
+	return 0;
+}
+
+static void sl_dma_debugfs_init(struct sl_dma *sl_dma)
+{
+	struct dentry *dbg_dev_root = sl_dma->dma.dbg_dev_root;
+	struct device *dev = sl_dma->dev;
+	struct sl_dma_chan *ch;
+	unsigned int i;
+	char name[32];
+
+	debugfs_create_devm_seqfile(dev, "tx_crc_error", dbg_dev_root,
+				    sl_dma_tx_crc_error_read);
+	debugfs_create_devm_seqfile(dev, "rx_crc_error", dbg_dev_root,
+				    sl_dma_rx_crc_error_read);
+	debugfs_create_devm_seqfile(dev, "stall_time_ns", dbg_dev_root,
+				    sl_dma_stall_time_ns_read);
+	debugfs_create_devm_seqfile(dev, "version", dbg_dev_root,
+				    sl_dma_version_read);
+
+	for (i = 0; i < sl_dma->num_write_channels; i++) {
+		ch = &sl_dma->write_channels[i];
+		snprintf(name, sizeof(name), "rx%u_fifo_underruns", ch->num);
+		debugfs_create_ulong(name, 0444, dbg_dev_root,
+				     &ch->fifo_underruns);
+	}
+
+	for (i = 0; i < sl_dma->num_read_channels; i++) {
+		ch = &sl_dma->read_channels[i];
+		snprintf(name, sizeof(name), "tx%u_fifo_underruns", ch->num);
+		debugfs_create_ulong(name, 0444, dbg_dev_root,
+				     &ch->fifo_underruns);
+	}
+}
+#else
+static inline void sl_dma_debugfs_init(struct sl_dma *sl_dma)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
+/*
+ * -----------------------------------------------------------------------------
+ * DMA IP Core handling
+ * -----------------------------------------------------------------------------
+ */
+
+static int sl_dma_detect(struct sl_dma *sl_dma)
+{
+	struct device *dev = sl_dma->dev;
+	u32 version, pci_status, dma_status, gpi, read_gpi;
+	unsigned int revision, month, day;
+	unsigned int link_speed, link_width;
+	unsigned int num_write_channels;
+	unsigned int length_fifo_depth;
+	bool ext_tag, msi, hcc, bram;
+	struct sl_dma_config *pdata;
+
+	pdata = dev->platform_data;
+	if (!pdata) {
+		dev_err(dev, "Missing platform data.\n");
+		return -EINVAL;
+	}
+
+	version = sl_dma_readl(sl_dma, REG_VERSION);
+	if (version == 0xffffffff) {
+		dev_err(dev, "Failed to read version register.\n");
+		return -EIO;
+	}
+
+	revision = VERSION_CORE_REVISION(version);
+	sl_dma->year = 2000 + bcd2bin(VERSION_YEAR(version));
+	month = bcd2bin(VERSION_MONTH(version));
+	day = bcd2bin(VERSION_DAY(version));
+
+	pci_status = sl_dma_readl(sl_dma, REG_PCI_STATUS);
+	sl_dma->mps = PCI_STATUS_MPS(pci_status);
+	sl_dma->mrs = PCI_STATUS_MRS(pci_status);
+	link_speed = PCI_STATUS_LINK_SPEED(pci_status);
+	link_width = PCI_STATUS_LINK_WIDTH(pci_status);
+	ext_tag = pci_status & PCI_STATUS_EXTENDED_TAG;
+	msi = pci_status & PCI_STATUS_MSI;
+
+	dma_status = sl_dma_readl(sl_dma, REG_DMA_WRITE_STATUS);
+	num_write_channels = DMA_STATUS_NUM_CHANNELS(dma_status);
+	hcc = dma_status & DMA_STATUS_CORE_TYPE;
+
+	gpi = sl_dma_readl(sl_dma, REG_DMA_WRITE_GENERAL_PARAMETER_INFO);
+	sl_dma->num_slave_interfaces = DMA_WRITE_GPI_NUM_INTERFACES(gpi);
+	sl_dma->write_sg_fifo_depth = DMA_WRITE_GPI_SG_FIFO_DEPTH(gpi);
+	bram = gpi & DMA_WRITE_GPI_SG_FIFO_RAM_TYPE;
+
+	read_gpi = sl_dma_readl(sl_dma, REG_DMA_READ_GENERAL_PARAMETER_INFO);
+	sl_dma->num_master_interfaces = DMA_READ_GPI_NUM_INTERFACES(read_gpi);
+	sl_dma->read_sg_fifo_depth = DMA_READ_GPI_SG_FIFO_DEPTH(gpi);
+	length_fifo_depth = DMA_READ_GPI_LENGTH_FIFO_DEPTH(gpi);
+
+	dev_info(dev, "Smartlogic %s DMA IP Core Revision %u, %04u-%02u-%02u\n",
+		 hcc ? "High Channel Count" : "Flex",
+		 revision, sl_dma->year, month, day);
+
+	if (!hcc) {
+		dev_err(dev, "This driver only supports the HCC variant\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "PCI Status = 0x%08x\n", pci_status);
+	dev_dbg(dev, "	Maximum Payload Size = %u Byte\n", sl_dma->mps);
+	/*
+	 * Extended Tags are automatically enabled by the PCI core,
+	 * see pci_configure_extended_tags() in drivers/pci/probe.c
+	 */
+	dev_dbg(dev, "	Extended Tag = %ssupported\n", ext_tag ? "" : "un");
+	dev_dbg(dev, "	Maximum Request Size = %u Byte\n", sl_dma->mrs);
+	dev_dbg(dev, "	Link Speed = Gen%u\n", link_speed);
+	dev_dbg(dev, "	Link Width = X%u\n", link_width);
+	dev_dbg(dev, "	MSI = %sabled\n", msi ? "en" : "dis");
+
+	dev_dbg(dev, "DMA Status = 0x%08x\n", dma_status);
+	dev_dbg(dev, "	Core Type = %s\n", hcc ? "HCC" : "Flex");
+	dev_dbg(dev, "	Number of logical channels = %u\n", num_write_channels);
+
+	dev_dbg(dev, "General Parameter Info (DMA Write) = 0x%08x\n", gpi);
+	dev_dbg(dev, "  Number of used AXIS interfaces = %u\n",
+		sl_dma->num_slave_interfaces);
+	dev_dbg(dev, "  Mode = %s\n",
+		(gpi & DMA_WRITE_GPI_SG_MODE) ? "SG" : "Linear");
+	dev_dbg(dev, "  SG FIFO RAM = %sRAM\n", bram ? "B" : "distributed ");
+	/* Maximum number of address entries */
+	dev_dbg(dev, "  SG FIFO depth = %u\n", sl_dma->write_sg_fifo_depth);
+
+	dev_dbg(dev, "General Parameter Info (DMA Read) = 0x%08x\n", read_gpi);
+	dev_dbg(dev, "  Number of used AXIS interfaces = %u\n",
+		sl_dma->num_master_interfaces);
+	dev_dbg(dev, "  SG FIFO depth = %u\n", sl_dma->read_sg_fifo_depth);
+	if (read_gpi & DMA_READ_GPI_LENGTH_FIFO_PRESENT)
+		dev_dbg(dev, "  Length FIFO depth = %u\n", length_fifo_depth);
+
+	/* As per spec, check that scatter/gather mode is configured */
+	if (!(gpi & DMA_WRITE_GPI_SG_MODE)) {
+		dev_err(dev, "IP core not configured in scatter/gather mode\n");
+		return -EINVAL;
+	}
+
+	if (num_write_channels < pdata->num_write_channels) {
+		dev_err(dev, "Logical write channel number mismatch (FPGA: %u, driver: %u)\n",
+			num_write_channels, pdata->num_write_channels);
+		return -EINVAL;
+	} else if (num_write_channels != pdata->num_write_channels) {
+		dev_dbg(dev, "Logical write channel number mismatch (FPGA: %u, driver: %u)\n",
+			num_write_channels, pdata->num_write_channels);
+	}
+
+	return 0;
+}
+
+static void sl_dma_init(struct sl_dma *sl_dma)
+{
+	u32 dma_config;
+	u32 interrupt_control, interrupt_enable;
+	struct device *dev = sl_dma->dev;
+	struct sl_dma_config *pdata = dev->platform_data;
+	unsigned int channel;
+	unsigned int i;
+
+	/*
+	 * See DMA Demo Design Specification 1.17, Table 6-1 "Programming
+	 * sequence after boot or after modprobe":
+	 */
+
+	/* Deactivate DMA Engines */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_CONTROL, 0x0);
+	sl_dma_writel(sl_dma, REG_DMA_READ_CONTROL, 0x0);
+
+	/* Reset DMA Write Data and Address FIFOs */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_FIFO_RESETS, 0xffffffff);
+	sl_dma_readl(sl_dma, REG_VERSION);
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_FIFO_RESETS, 0x00000000);
+
+	/* Reset DMA Read Data and Address FIFOs */
+	sl_dma_writel(sl_dma, REG_DMA_READ_FIFO_RESETS, 0xffffffff);
+	sl_dma_readl(sl_dma, REG_VERSION);
+	sl_dma_writel(sl_dma, REG_DMA_READ_FIFO_RESETS, 0x00000000);
+
+	/*
+	 * Set 1D Mode for all used DMA Read channels, this needs to be done
+	 * before the Image Format Registers are set.
+	 */
+	sl_dma_writel(sl_dma, REG_DMA_READ_1D_2D_SELECT,
+		      (1 << pdata->num_read_channels) - 1);
+
+	/* Set Reload Budget Registers to Maximum Request Size for DMA Read */
+	for (channel = 0; channel < pdata->num_read_channels; channel++) {
+		sl_dma_writel(sl_dma, REG_DMA_READ_RELOAD_BUDGET(channel),
+			      sl_dma->mrs);
+	}
+
+	/* Use channel specific page size registers for DMA Read */
+	sl_dma_writel(sl_dma, REG_DMA_READ_ALTERNATE_PAGESIZEDEFINITION, 0x1);
+
+	/* Set per-channel page sizes for DMA Read */
+	for (channel = 0; channel < pdata->num_read_channels; channel++) {
+		for (i = 0; i < pdata->num_read_channels; i++) {
+			if (pdata->read_channels[i].channel != channel)
+				continue;
+
+			sl_dma_writel(sl_dma, REG_DMA_READ_LAST_ADDRESS(channel),
+				      pdata->read_channels[i].page_size - 1);
+		}
+	}
+
+	/* Set Image Format Registers for DMA Read */
+	for (channel = 0; channel < pdata->num_read_channels; channel++) {
+		for (i = 0; i < pdata->num_read_channels; i++) {
+			if (pdata->read_channels[i].channel != channel)
+				continue;
+
+			sl_dma_writel(sl_dma, REG_DMA_READ_IMAGE_FORMAT(channel),
+				      pdata->read_channels[i].image_format);
+		}
+	}
+
+	/* Set IncrementLineOffset of all logical write channels to 0x200 */
+	for (channel = 0; channel < pdata->num_write_channels; channel++) {
+		sl_dma_writel(sl_dma,
+			      REG_DMA_WRITE_INCREMENT_LINE_OFFSET(channel),
+			      0x200);
+	}
+
+	/* Set per-channel page size for DMA Write */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_ALTERNATE_PAGESIZEDEFINITION, 0x1);
+	for (channel = 0; channel < pdata->num_write_channels; channel++) {
+		for (i = 0; i < pdata->num_write_channels; i++) {
+			if (pdata->write_channels[i].channel != channel)
+				continue;
+
+			sl_dma_writel(sl_dma, REG_DMA_WRITE_LAST_ADDRESS(channel),
+				      pdata->write_channels[i].page_size - 1);
+		}
+	}
+
+	/* Activate DMA Write engine */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_CONTROL, 0x1);
+
+	/* Activate DMA Read engine */
+	sl_dma_writel(sl_dma, REG_DMA_READ_CONTROL, 0x1);
+
+	/*
+	 * See DMA Demo Design Specification 1.17, Table 6-4 "Programming
+	 * sequence to activate a DMA channel".
+	 * Select Stream Mode for all AXISS interfaces
+	 */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_CONFIG, 0xffff0000);
+
+	/*
+	 * Enable all configured AXI-Stream master interfaces, channel to
+	 * interface mapping is 1:1.
+	 */
+	dma_config = 0;
+	for (i = 0; i < pdata->num_read_channels; i++)
+		dma_config |= BIT(pdata->read_channels[i].channel);
+	sl_dma_writel(sl_dma, REG_DMA_READ_CONFIG, dma_config);
+
+	/*
+	 * See DMA Demo Design Specification 1.17, Table 6-6 "Activating the
+	 * EOF Interrupt".
+	 */
+
+	/* Enable MSI-X EOF interrupts */
+	interrupt_control = 0;
+	for (i = 0; i < pdata->num_write_channels; i++)
+		interrupt_control |= BIT(pdata->write_channels[i].irq);
+	for (i = 0; i < pdata->num_read_channels; i++)
+		interrupt_control |= BIT(pdata->read_channels[i].irq);
+	interrupt_control |= pdata->user_interrupts;
+	sl_dma_writel(sl_dma, REG_INTERRUPT_CONTROL, interrupt_control);
+
+	/*
+	 * It is not necessary to enable the GLOBAL_INTERRUPT_EOF bits.
+	 * Just to be sure, clear them explicitly.
+	 */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_GLOBAL_INTERRUPT_ENABLE, 0x0);
+	sl_dma_writel(sl_dma, REG_DMA_READ_GLOBAL_INTERRUPT_ENABLE, 0x0);
+
+	/*
+	 * Unmask the EOF interrupts for all unpaired or paired,
+	 * interrupt-triggering DMA Write channels
+	 */
+	interrupt_enable = 0;
+	for (i = 0; i < pdata->num_write_channels; i++) {
+		bool paired = false;
+		bool triggering = false;
+		unsigned int j;
+
+		for (j = 0; j < pdata->num_write_channel_pairs; j++) {
+			if (pdata->write_channels[i].channel ==
+			    pdata->write_channel_pairs[j].non_triggering_ch) {
+				paired = true;
+			} else if (pdata->write_channels[i].channel ==
+				   pdata->write_channel_pairs[j].triggering_ch) {
+				paired = true;
+				triggering = true;
+			}
+		}
+		if (!paired || triggering) {
+			/*
+			 * The REG_DMA_WRITE_INTERRUPT_ENABLE_END_OF_FRAME bits
+			 * are per interface on old DMA IP core versions. Since
+			 * 2021, they are per logical write channel.
+			 */
+			if (sl_dma->year < 2021) {
+				interrupt_enable |=
+					BIT(pdata->write_channels[i].interface);
+			} else {
+				interrupt_enable |=
+					BIT(pdata->write_channels[i].channel);
+			}
+		}
+	}
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_INTERRUPT_ENABLE_END_OF_FRAME,
+		      interrupt_enable);
+
+	/* Unmask the EOR interrupts for all configured DMA Read interfaces */
+	interrupt_enable = 0;
+	for (i = 0; i < pdata->num_read_channels; i++)
+		interrupt_enable |= BIT(pdata->read_channels[i].channel);
+	sl_dma_writel(sl_dma, REG_DMA_READ_INTERRUPT_ENABLE_END_OF_REQUEST,
+		      interrupt_enable);
+}
+
+static void sl_dma_queue_base_address(struct sl_dma *sl_dma,
+				      struct sl_dma_chan *ch, dma_addr_t addr)
+{
+	/* Load physical base address into channel address FIFO */
+	sl_dma_writeq(sl_dma, (ch->direction == DMA_DEV_TO_MEM) ?
+		      REG_DMA_WRITE_BASE_ADDRESS(ch->num) :
+		      REG_DMA_READ_BASE_ADDRESS(ch->num), addr);
+}
+
+static unsigned int sl_dma_free_address_fifo_entries(struct sl_dma *sl_dma,
+						     struct sl_dma_chan *ch)
+{
+	/* Return number of free entries in the channel's address FIFO */
+	return sl_dma_readl(sl_dma, (ch->direction == DMA_DEV_TO_MEM) ?
+		      REG_DMA_WRITE_BASE_ADDRESS(ch->num) :
+		      REG_DMA_READ_BASE_ADDRESS(ch->num));
+}
+
+/*
+ * See DMA Demo Design Specification 1.17, Table 6-2 "Programming sequence to
+ * deactivate the IP Core (rmmod or system shutdown)"
+ */
+static void sl_dma_fini(void *data)
+{
+	struct sl_dma *sl_dma = data;
+
+	/* Mask all interrupts */
+	sl_dma_writel(sl_dma, REG_INTERRUPT_CONTROL, 0x0);
+
+	/* Deactivate DMA Engines */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_CONTROL, 0x0);
+	sl_dma_writel(sl_dma, REG_DMA_READ_CONTROL, 0x0);
+
+	/* Disable AXI Stream interfaces */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_CONFIG, 0x0);
+	sl_dma_writel(sl_dma, REG_DMA_READ_CONFIG, 0x0);
+
+	/* Reset DMA Write Data and Address FIFOs */
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_FIFO_RESETS, 0xffffffff);
+	sl_dma_readl(sl_dma, REG_VERSION);
+	sl_dma_writel(sl_dma, REG_DMA_WRITE_FIFO_RESETS, 0x00000000);
+
+	/* Reset DMA Read Data and Address FIFOs */
+	sl_dma_writel(sl_dma, REG_DMA_READ_FIFO_RESETS, 0xffffffff);
+	sl_dma_readl(sl_dma, REG_VERSION);
+	sl_dma_writel(sl_dma, REG_DMA_READ_FIFO_RESETS, 0x00000000);
+
+	/*
+	 * Clear interrupt status and make sure previous writes have reached
+	 * the FPGA
+	 */
+	sl_dma_readl(sl_dma, REG_INTERRUPT_STATUS);
+}
+
+static bool sl_dma_channel_is_leader(struct sl_dma_chan *ch)
+{
+	return ch->follower;
+}
+
+static bool sl_dma_channel_is_follower(struct sl_dma_chan *ch)
+{
+	return ch->leader;
+}
+
+static void sl_dma_reset_flags_update_bits(struct sl_dma *sl_dma, u32 mask, u32 val)
+{
+	struct sl_dma_config *pdata = sl_dma->dev->platform_data;
+	u32 flags;
+
+	if (sl_dma->reset_flags) {
+		flags = readl(sl_dma->reset_flags);
+		flags &= ~mask;
+		flags |= val;
+		writel(flags, sl_dma->reset_flags);
+	} else if (pdata->reset_flag_reg) {
+		flags = sl_dma_readl(sl_dma, pdata->reset_flag_reg);
+		flags &= ~mask;
+		flags |= val;
+		sl_dma_writel(sl_dma, pdata->reset_flag_reg, flags);
+	}
+}
+
+static void sl_dma_channel_reset_address_fifo(struct sl_dma *sl_dma,
+					      struct sl_dma_chan *ch)
+{
+	struct sl_dma_config *pdata = sl_dma->dev->platform_data;
+	u32 data_resets, addr_resets;
+
+	/* FPGA design does not support address FIFO reset */
+	if (!sl_dma->reset_flags && !pdata->reset_flag_reg)
+		return;
+
+	/* Following channels are reset together with their leading channel. */
+	if (sl_dma_channel_is_follower(ch)) {
+		dev_dbg(sl_dma->dev, "Skip address FIFO reset for following channel %u\n",
+			ch->num);
+		return;
+	}
+
+	/* DMA Read channels are not reset at all. */
+	if (ch->direction == DMA_MEM_TO_DEV) {
+		dev_dbg(sl_dma->dev, "Skip address FIFO reset for read channel %u\n",
+			ch->num);
+		return;
+	}
+
+	addr_resets = BIT(ch->num);
+	data_resets = BIT(16 + ch->interface);
+
+	if (sl_dma_channel_is_leader(ch)) {
+		dev_dbg(sl_dma->dev, "Reset address FIFOs for channels %u and %u\n",
+			ch->num, ch->follower->num);
+		addr_resets |= BIT(ch->follower->num);
+		data_resets |= BIT(16 + ch->follower->interface);
+	} else {
+		dev_dbg(sl_dma->dev, "Reset address FIFO for channel %u\n",
+			ch->num);
+	}
+
+	/*
+	 * See DMA Demo Design Specification 1.17, Table 6-7 "Programming
+	 * sequence to reset the address FIFO for DMA Write" and chapter 7
+	 * "Demo Design specific Programming Sequence to activate Loopback or
+	 * the TPGs":
+	 */
+
+	/*
+	 * Set GPO bit to inform FPGA user logic about special reset sequence.
+	 */
+	if (ch->direction == DMA_DEV_TO_MEM) {
+		u32 dma_config;
+
+		guard(spinlock_irqsave)(&sl_dma->lock);
+
+		/* Disable AXI Stream interfaces (data and metadata) */
+		dma_config = sl_dma_readl(sl_dma, REG_DMA_WRITE_CONFIG);
+		if (!(dma_config & BIT(ch->interface)))
+			dev_err(sl_dma->dev, "Disabling already inactive interface\n");
+		dma_config &= ~BIT(ch->interface);
+		if (sl_dma_channel_is_leader(ch))
+			dma_config &= ~BIT(ch->follower->interface);
+		sl_dma_writel(sl_dma, REG_DMA_WRITE_CONFIG, dma_config);
+
+		/* Set reset bit for the data source */
+		sl_dma_reset_flags_update_bits(sl_dma, ch->reset_bit, ch->reset_bit);
+
+		/* Put associated data FIFO and address FIFO into reset */
+		sl_dma_writel(sl_dma, REG_DMA_WRITE_FIFO_RESETS, data_resets |
+			      addr_resets);
+
+		/*
+		 * Dummy read, ensure both channels finished their current
+		 * packet
+		 */
+		sl_dma_readl(sl_dma, REG_VERSION);
+
+		/* Clear data and address reset bits */
+		sl_dma_writel(sl_dma, REG_DMA_WRITE_FIFO_RESETS, 0x00000000);
+
+		/* Clear reset bit for the data source */
+		sl_dma_reset_flags_update_bits(sl_dma, ch->reset_bit, 0);
+	}
+}
+
+static const char *sl_dma_direction_name(struct sl_dma_chan *ch)
+{
+	/*
+	 * DMA Write channels write to memory from the device,
+	 * DMA Read channels read from memory to the device.
+	 */
+	return (ch->direction == DMA_DEV_TO_MEM) ? "write" : "read";
+}
+
+static bool sl_dma_handle_end_of_transfer(struct sl_dma *sl_dma,
+					  struct sl_dma_chan *ch)
+{
+	struct sl_dma_tx_descriptor *desc;
+
+	guard(spinlock_irqsave)(&ch->lock);
+
+	if (list_empty(&ch->active_list)) {
+		dev_err(sl_dma->dev, "No active transfer on %s channel %u\n",
+			sl_dma_direction_name(ch), ch->num);
+		return false;
+	}
+	desc = list_first_entry(&ch->active_list, struct sl_dma_tx_descriptor,
+				node);
+	ch->num_active--;
+	list_move_tail(&desc->node, &ch->done_list);
+	if (ch->direction == DMA_DEV_TO_MEM && ch->num_active < 1) {
+		dev_warn(sl_dma->dev,
+			 "%u active transfers remaining on %s channel %u (%u free FIFO entries)\n",
+			 ch->num_active, sl_dma_direction_name(ch), ch->num,
+			 sl_dma_free_address_fifo_entries(sl_dma, ch));
+	} else {
+		dev_dbg(sl_dma->dev,
+			"%u active transfers remaining on %s channel %u (%u free FIFO entries)\n",
+			ch->num_active, sl_dma_direction_name(ch), ch->num,
+			sl_dma_free_address_fifo_entries(sl_dma, ch));
+	}
+
+	return true;
+}
+
+static irqreturn_t sl_dma_irq_handler(int irq, void *dev_id)
+{
+	struct sl_dma_irq *sl_dma_irq = dev_id;
+	struct sl_dma *sl_dma = sl_dma_irq->sl_dma;
+	struct sl_dma_chan *ch = sl_dma_irq->ch;
+
+	if (ch) {
+		dev_dbg(sl_dma->dev, "IRQ handler %u for %s channel %u\n",
+			sl_dma_irq->num, sl_dma_direction_name(ch), ch->num);
+	} else {
+		dev_dbg(sl_dma->dev, "IRQ handler %u, no channel assigned\n",
+			sl_dma_irq->num);
+		return IRQ_HANDLED;
+	}
+
+	if (sl_dma_channel_is_follower(ch)) {
+		/*
+		 * A transfer on this channel always follows a transfer on the
+		 * assigned leading channel.
+		 */
+		if (!ch->leader->irq || ch->leader->irq->ch != ch->leader) {
+			/*
+			 * Since the leading channel does not have an IRQ
+			 * assigned, mark that channel's transfer as completed
+			 * as well.
+			 */
+			if (sl_dma_handle_end_of_transfer(sl_dma, ch->leader))
+				queue_work(system_bh_wq, &ch->leader->bh_work);
+		}
+	}
+	if (sl_dma_handle_end_of_transfer(sl_dma, ch))
+		queue_work(system_bh_wq, &ch->bh_work);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * -----------------------------------------------------------------------------
+ * Misc
+ * -----------------------------------------------------------------------------
+ */
+
+static void sl_dma_free_descriptors(struct sl_dma_chan *ch)
+{
+	struct sl_dma_tx_descriptor *desc, *next;
+
+	guard(spinlock_irqsave)(&ch->lock);
+
+	list_for_each_entry_safe(desc, next, &ch->pending_list, node) {
+		list_del(&desc->node);
+		kfree(desc);
+	}
+	list_for_each_entry_safe(desc, next, &ch->active_list, node) {
+		list_del(&desc->node);
+		kfree(desc);
+	}
+	ch->num_active = 0;
+	list_for_each_entry_safe(desc, next, &ch->done_list, node) {
+		list_del(&desc->node);
+		kfree(desc);
+	}
+}
+
+static void sl_dma_bh_work(struct work_struct *work)
+{
+	struct sl_dma_chan *ch = from_work(ch, work, bh_work);
+	struct sl_dma *sl_dma = to_sl_dma(ch->chan.device);
+	struct sl_dma_tx_descriptor *desc, *next;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ch->lock, flags);
+	if (list_empty(&ch->done_list)) {
+		dev_err(sl_dma->dev, "%s channel %u done list empty!\n",
+			sl_dma_direction_name(ch), ch->num);
+		goto out;
+	}
+	list_for_each_entry_safe(desc, next, &ch->done_list, node) {
+		struct dmaengine_result result;
+
+		list_del(&desc->node);
+		result.result = DMA_TRANS_NOERROR;
+		result.residue = 0;
+
+		spin_unlock_irqrestore(&ch->lock, flags);
+		dmaengine_desc_get_callback_invoke(&desc->tx, &result);
+		spin_lock_irqsave(&ch->lock, flags);
+
+		dma_run_dependencies(&desc->tx);
+		kfree(desc);
+	}
+out:
+	if (ch->direction == DMA_DEV_TO_MEM &&
+	    list_empty(&ch->pending_list) && list_empty(&ch->active_list)) {
+		dev_warn(sl_dma->dev,
+			 "%s channel %u pending and active lists empty\n",
+			 sl_dma_direction_name(ch), ch->num);
+
+		/*
+		 * If this happens due to a buffer underrun, the address FIFO
+		 * is already empty. Perform an address FIFO reset either way,
+		 * since this also issues a reset signal to the FPGA logic.
+		 */
+		sl_dma_channel_reset_address_fifo(sl_dma, ch);
+
+		ch->active = false;
+	}
+	spin_unlock_irqrestore(&ch->lock, flags);
+}
+
+static int sl_dma_channel_get_irq(struct sl_dma_chan *ch)
+{
+	struct sl_dma *sl_dma = to_sl_dma(ch->chan.device);
+	struct sl_dma_irq *irq = ch->irq;
+
+	if (irq->ch == ch)
+		return 0;
+	if (irq->ch)
+		return -EBUSY;
+
+	dev_dbg(sl_dma->dev, "Assign IRQ %u to %s channel %u\n", irq->num,
+		sl_dma_direction_name(ch), ch->num);
+
+	irq->ch = ch;
+
+	return 0;
+}
+
+static void sl_dma_channel_free_irq(struct sl_dma_chan *ch)
+{
+	struct sl_dma *sl_dma = to_sl_dma(ch->chan.device);
+	struct sl_dma_irq *irq = ch->irq;
+
+	if (irq->ch != ch)
+		return;
+
+	dev_dbg(sl_dma->dev, "Release IRQ %u from %s channel %u\n", irq->num,
+		sl_dma_direction_name(ch), ch->num);
+
+	irq->ch = NULL;
+}
+
+/*
+ * -----------------------------------------------------------------------------
+ * DMA Engine API
+ * -----------------------------------------------------------------------------
+ */
+
+static void sl_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+
+	sl_dma_free_descriptors(ch);
+}
+
+static dma_cookie_t sl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(tx->chan);
+	struct sl_dma *sl_dma = to_sl_dma(tx->chan->device);
+	struct sl_dma_tx_descriptor *desc =
+		container_of(tx, struct sl_dma_tx_descriptor, tx);
+	dma_cookie_t cookie;
+
+	dev_dbg(sl_dma->dev, "Submitting transfer to %s channel %u\n",
+		sl_dma_direction_name(ch), ch->num);
+
+	if (desc->interrupt) {
+		int ret = sl_dma_channel_get_irq(ch);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	guard(spinlock_irqsave)(&ch->lock);
+
+	cookie = dma_cookie_assign(tx);
+	list_add_tail(&desc->node, &ch->pending_list);
+
+	return cookie;
+}
+
+static struct dma_async_tx_descriptor *
+sl_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		     unsigned int sg_len, enum dma_transfer_direction direction,
+		     unsigned long flags, void *context)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+	struct sl_dma *sl_dma = to_sl_dma(chan->device);
+	struct sl_dma_tx_descriptor *desc;
+
+	dev_dbg(sl_dma->dev,
+		"Preparing transfer for %s channel %u, address = 0x%llx, len = %u\n",
+		sl_dma_direction_name(ch), ch->num, sg_dma_address(sgl),
+		sg_dma_len(sgl));
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (!sg_dma_len(sgl))
+		return NULL;
+
+	if (sg_len != 1)
+		return NULL;
+
+	if (sg_dma_len(sgl) != ch->transfer_size) {
+		dev_dbg(sl_dma->dev,
+			"Size %u differs from channel transfer size %u\n",
+			sg_dma_len(sgl), ch->transfer_size);
+	}
+
+	/* Allocate and fill a descriptor */
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->tx, chan);
+	desc->tx.tx_submit = sl_dma_tx_submit;
+	async_tx_ack(&desc->tx);
+
+	desc->addr = sg_dma_address(sgl);
+	desc->interrupt = flags & DMA_PREP_INTERRUPT;
+
+	return &desc->tx;
+}
+
+static struct dma_async_tx_descriptor *
+sl_dma_prep_interleaved_dma(struct dma_chan *chan,
+			    struct dma_interleaved_template *xt,
+			    unsigned long flags)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+	struct sl_dma *sl_dma = to_sl_dma(chan->device);
+	struct sl_dma_tx_descriptor *desc;
+
+	dev_dbg(sl_dma->dev,
+		"Preparing transfer for %s channel %u, %s = 0x%llx, size = %lu\n",
+		sl_dma_direction_name(ch), ch->num,
+		ch->direction == DMA_DEV_TO_MEM ? "dst_start" : "src_start",
+		ch->direction == DMA_DEV_TO_MEM ? xt->dst_start : xt->src_start,
+		xt->numf ? xt->sgl[0].size : 0);
+
+	if (!is_slave_direction(xt->dir))
+		return NULL;
+
+	if (!xt->numf || !xt->sgl[0].size)
+		return NULL;
+
+	if (xt->frame_size != 1)
+		return NULL;
+
+	if (xt->sgl[0].size != ch->transfer_size) {
+		dev_dbg(sl_dma->dev,
+			"Size %lu differs from channel transfer size %u\n",
+			xt->sgl[0].size, ch->transfer_size);
+	}
+
+	/* Allocate and fill a descriptor */
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->tx, chan);
+	desc->tx.tx_submit = sl_dma_tx_submit;
+	async_tx_ack(&desc->tx);
+
+	if (ch->direction == DMA_DEV_TO_MEM)
+		desc->addr = xt->dst_start;
+	else
+		desc->addr = xt->src_start;
+	desc->interrupt = flags & DMA_PREP_INTERRUPT;
+
+	return &desc->tx;
+}
+
+static int sl_dma_terminate_all(struct dma_chan *chan)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+	struct sl_dma *sl_dma = to_sl_dma(chan->device);
+
+	dev_dbg(sl_dma->dev, "Terminate all transfers on %s channel %u\n",
+		sl_dma_direction_name(ch), ch->num);
+
+	sl_dma_channel_free_irq(ch);
+
+	sl_dma_channel_reset_address_fifo(sl_dma, ch);
+
+	return 0;
+}
+
+static void sl_dma_synchronize(struct dma_chan *chan)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+	struct sl_dma *sl_dma = to_sl_dma(chan->device);
+	unsigned int sg_fifo_depth;
+	int ret;
+	u32 val;
+
+	dev_dbg(sl_dma->dev, "Synchronize termination on %s channel %u\n",
+		sl_dma_direction_name(ch), ch->num);
+
+	if (ch->direction == DMA_DEV_TO_MEM)
+		sg_fifo_depth = sl_dma->write_sg_fifo_depth;
+	else
+		sg_fifo_depth = sl_dma->read_sg_fifo_depth;
+
+	if (ch->num_active == 0 &&
+	    sl_dma_free_address_fifo_entries(sl_dma, ch) != sg_fifo_depth) {
+		dev_warn(sl_dma->dev,
+			 "%u active transfers remaining on %s channel %u (%u free FIFO entries)\n",
+			 ch->num_active, sl_dma_direction_name(ch), ch->num,
+			 sl_dma_free_address_fifo_entries(sl_dma, ch));
+	}
+
+	ret = read_poll_timeout(sl_dma_free_address_fifo_entries, val,
+				val == sg_fifo_depth, 1000, 100000, false,
+				sl_dma, ch);
+	if (ret == -ETIMEDOUT) {
+		dev_err(sl_dma->dev, "Timeout waiting on %s channel %u\n",
+			sl_dma_direction_name(ch), ch->num);
+	}
+
+	sl_dma_free_descriptors(ch);
+
+	ch->active = false;
+}
+
+static enum dma_status sl_dma_tx_status(struct dma_chan *chan,
+					dma_cookie_t cookie,
+					struct dma_tx_state *state)
+{
+	enum dma_status ret;
+
+	ret = dma_cookie_status(chan, cookie, state);
+	if (ret == DMA_COMPLETE || !state)
+		return ret;
+
+	/* Residue reporting not supported */
+	dma_set_residue(state, 0);
+
+	return ret;
+}
+
+static void sl_dma_issue_pending(struct dma_chan *chan)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+	struct sl_dma *sl_dma = to_sl_dma(chan->device);
+	struct sl_dma_tx_descriptor *desc, *next;
+
+	dev_dbg(sl_dma->dev, "Issue pending transfers on %s channel %u:\n",
+		sl_dma_direction_name(ch), ch->num);
+
+	guard(spinlock_irqsave)(&ch->lock);
+
+	if (!ch->active && ch->direction == DMA_DEV_TO_MEM &&
+	    !sl_dma_channel_is_follower(ch)) {
+		struct sl_dma_config *pdata = sl_dma->dev->platform_data;
+		u32 dma_config;
+
+		/*
+		 * See DMA Demo Design Specification 1.17, Table 7-2 "Starting
+		 * the TPGs". According to spec, this must be done before the
+		 * AXISS interface is activated.
+		 */
+		if (pdata->prepare_start)
+			pdata->prepare_start(sl_dma->dev->parent, ch->interface);
+
+		/*
+		 * See DMA Demo Design Specification 1.17, Table 6-4
+		 * "Programming sequence to activate a DMA channel"
+		 */
+		/* Enable AXISS interface */
+		guard(spinlock_irqsave)(&sl_dma->lock);
+		dma_config = sl_dma_readl(sl_dma, REG_DMA_WRITE_CONFIG);
+		dma_config |= BIT(ch->interface);
+		if (sl_dma_channel_is_leader(ch))
+			dma_config |= BIT(ch->follower->interface);
+		sl_dma_writel(sl_dma, REG_DMA_WRITE_CONFIG, dma_config);
+	}
+	if (ch->active && sl_dma_free_address_fifo_entries(sl_dma, ch) == 64) {
+		dev_dbg(sl_dma->dev, "Address FIFO underrun\n");
+		ch->fifo_underruns++;
+	}
+	ch->active = true;
+	list_for_each_entry_safe(desc, next, &ch->pending_list, node) {
+		dev_dbg(sl_dma->dev, "Issue transfer on %s channel %u, addr = 0x%llx\n",
+			sl_dma_direction_name(ch), ch->num, desc->addr);
+		/* Load physical base address to address FIFO for the channel */
+		sl_dma_queue_base_address(sl_dma, ch, desc->addr);
+		list_move_tail(&desc->node, &ch->active_list);
+		ch->num_active++;
+	}
+}
+
+/*
+ * -----------------------------------------------------------------------------
+ * Driver probe and removal
+ * -----------------------------------------------------------------------------
+ */
+
+static bool sl_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct sl_dma_chan *ch = to_sl_dma_chan(chan);
+	const char *pattern;
+	const char *name = param;
+	unsigned int num;
+
+	pattern = (ch->direction == DMA_DEV_TO_MEM) ? "rx-%u" : "tx-%u";
+
+	return sscanf(name, pattern, &num) == 1 && num == ch->num;
+}
+
+static inline struct sl_dma_chan *sl_dma_write_channel(struct sl_dma *sl_dma,
+						       unsigned int channel)
+{
+	int i;
+
+	for (i = 0; i < sl_dma->num_write_channels; i++) {
+		if (sl_dma->write_channels[i].num == channel)
+			return &sl_dma->write_channels[i];
+	}
+
+	return NULL;
+}
+
+static void sl_dma_remove_channels(void *data)
+{
+	struct sl_dma *sl_dma = data;
+	unsigned int i;
+
+	for (i = 0; i < sl_dma->num_read_channels; i++) {
+		struct sl_dma_chan *chan = &sl_dma->read_channels[i];
+
+		cancel_work_sync(&chan->bh_work);
+		list_del(&chan->chan.device_node);
+	}
+
+	for (i = 0; i < sl_dma->num_write_channels; i++) {
+		struct sl_dma_chan *chan = &sl_dma->write_channels[i];
+
+		cancel_work_sync(&chan->bh_work);
+		list_del(&chan->chan.device_node);
+	}
+}
+
+static int sl_dma_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sl_dma_config *pdata = dev->platform_data;
+	struct sl_dma *sl_dma;
+	u32 used_irqs;
+	int ret;
+	int i;
+
+	sl_dma = devm_kzalloc(dev, sizeof(*sl_dma), GFP_KERNEL);
+	if (!sl_dma)
+		return -ENOMEM;
+
+	sl_dma->num_read_channels = pdata->num_read_channels;
+	sl_dma->read_channels = devm_kcalloc(dev, sl_dma->num_read_channels,
+					     sizeof(*sl_dma->read_channels),
+					     GFP_KERNEL);
+	if (!sl_dma->read_channels)
+		return -ENOMEM;
+
+	sl_dma->num_write_channels = pdata->num_write_channels;
+	sl_dma->write_channels = devm_kcalloc(dev, sl_dma->num_write_channels,
+					      sizeof(*sl_dma->write_channels),
+					      GFP_KERNEL);
+	if (!sl_dma->write_channels)
+		return -ENOMEM;
+
+	sl_dma->dev = dev;
+	sl_dma->bar = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sl_dma->bar))
+		return PTR_ERR(sl_dma->bar);
+	sl_dma->reset_flags = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(sl_dma->reset_flags))
+		sl_dma->reset_flags = NULL;
+	spin_lock_init(&sl_dma->lock);
+
+	ret = sl_dma_detect(sl_dma);
+	if (ret)
+		return ret;
+
+	sl_dma_init(sl_dma);
+
+	ret = devm_add_action_or_reset(dev, sl_dma_fini, sl_dma);
+	if (ret)
+		return ret;
+
+	used_irqs = 0;
+	for (i = 0; i < pdata->num_write_channels; i++) {
+		if (pdata->write_channels[i].irq)
+			used_irqs |= BIT(pdata->write_channels[i].irq);
+	}
+	for (i = 0; i < pdata->num_read_channels; i++) {
+		if (pdata->read_channels[i].irq)
+			used_irqs |= BIT(pdata->read_channels[i].irq);
+	}
+
+	/* Request all IRQs that are assigned to a channel */
+	for (i = 0; i < NUM_MSIX_IRQS; i++) {
+		int irq = platform_get_irq(pdev, i);
+
+		sl_dma->irq[i].num = i;
+		sl_dma->irq[i].sl_dma = sl_dma;
+
+		if (!(used_irqs & BIT(i)))
+			continue;
+
+		ret = devm_request_irq(dev, irq, sl_dma_irq_handler,
+				       IRQF_SHARED, KBUILD_MODNAME,
+				       &sl_dma->irq[i]);
+		if (ret) {
+			dev_err(dev, "Failed to register irq %d: %pe\n", irq,
+				ERR_PTR(ret));
+			return ret;
+		}
+	}
+
+	/* The channel mapping is design specific */
+	sl_dma->dma.filter.fn = sl_dma_filter_fn;
+	sl_dma->dma.filter.mapcnt = pdata->dma_map_size;
+	sl_dma->dma.filter.map = pdata->dma_map;
+
+	dma_cap_set(DMA_SLAVE, sl_dma->dma.cap_mask);
+	dma_cap_set(DMA_PRIVATE, sl_dma->dma.cap_mask);
+
+	sl_dma->dma.dev = dev;
+	sl_dma->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	sl_dma->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
+	sl_dma->dma.device_free_chan_resources = sl_dma_free_chan_resources;
+	sl_dma->dma.device_prep_slave_sg = sl_dma_prep_slave_sg;
+	sl_dma->dma.device_prep_interleaved_dma = sl_dma_prep_interleaved_dma;
+	sl_dma->dma.device_terminate_all = sl_dma_terminate_all;
+	sl_dma->dma.device_synchronize = sl_dma_synchronize;
+	sl_dma->dma.device_tx_status = sl_dma_tx_status;
+	sl_dma->dma.device_issue_pending = sl_dma_issue_pending;
+
+	INIT_LIST_HEAD(&sl_dma->dma.channels);
+
+	for (i = 0; i < pdata->num_write_channels; i++) {
+		const struct sl_dma_write_channel_config *config;
+		struct sl_dma_chan *ch;
+
+		config = &pdata->write_channels[i];
+		ch = &sl_dma->write_channels[i];
+
+		ch->direction = DMA_DEV_TO_MEM;
+		ch->chan.device = &sl_dma->dma;
+		ch->transfer_size = config->page_size;
+		ch->num = config->channel;
+		if (config->interface >= sl_dma->num_slave_interfaces) {
+			dev_err(dev, "Failed to configure write channel %u with interface %u, hardware only has %u interfaces\n",
+				config->channel, config->interface,
+				sl_dma->num_slave_interfaces);
+			return -EINVAL;
+		}
+		ch->interface = config->interface;
+		if (config->irq >= NUM_MSIX_IRQS)
+			return -EINVAL;
+		ch->irq = &sl_dma->irq[config->irq];
+		ch->reset_bit = config->reset;
+
+		spin_lock_init(&ch->lock);
+		INIT_LIST_HEAD(&ch->pending_list);
+		INIT_LIST_HEAD(&ch->active_list);
+		INIT_LIST_HEAD(&ch->done_list);
+
+		INIT_WORK(&ch->bh_work, sl_dma_bh_work);
+
+		list_add_tail(&ch->chan.device_node, &sl_dma->dma.channels);
+	}
+
+	/* Assign DMA Write channel leader-follower pairs */
+	for (i = 0; i < pdata->num_write_channel_pairs; i++) {
+		const struct sl_dma_write_channel_pair *pair;
+		struct sl_dma_chan *ch[2];
+
+		pair = &pdata->write_channel_pairs[i];
+
+		if (pair->non_triggering_ch >= sl_dma->num_write_channels ||
+		    pair->triggering_ch >= sl_dma->num_write_channels)
+			return -EINVAL;
+
+		ch[0] = sl_dma_write_channel(sl_dma, pair->non_triggering_ch);
+		ch[1] = sl_dma_write_channel(sl_dma, pair->triggering_ch);
+
+		ch[0]->follower = ch[1];
+		ch[1]->leader = ch[0];
+	}
+
+	for (i = 0; i < pdata->num_read_channels; i++) {
+		const struct sl_dma_read_channel_config *config;
+		struct sl_dma_chan *ch;
+
+		config = &pdata->read_channels[i];
+		ch = &sl_dma->read_channels[i];
+
+		ch->direction = DMA_MEM_TO_DEV;
+		ch->chan.device = &sl_dma->dma;
+		ch->transfer_size = config->image_format;
+		ch->num = config->channel;
+		/* DMA Read channel to interface mapping is 1:1 */
+		if (config->channel >= sl_dma->num_master_interfaces) {
+			dev_err(dev, "Failed to configure read channel %u, hardware only has %u interfaces\n",
+				config->channel, sl_dma->num_master_interfaces);
+			return -EINVAL;
+		}
+		ch->interface = config->channel;
+		if (config->irq >= NUM_MSIX_IRQS)
+			return -EINVAL;
+		ch->irq = &sl_dma->irq[config->irq];
+
+		spin_lock_init(&ch->lock);
+		INIT_LIST_HEAD(&ch->pending_list);
+		INIT_LIST_HEAD(&ch->active_list);
+		INIT_LIST_HEAD(&ch->done_list);
+
+		INIT_WORK(&ch->bh_work, sl_dma_bh_work);
+
+		list_add_tail(&ch->chan.device_node, &sl_dma->dma.channels);
+	}
+
+	ret = devm_add_action_or_reset(dev, sl_dma_remove_channels, sl_dma);
+	if (ret)
+		return ret;
+
+	ret = dmaenginem_async_device_register(&sl_dma->dma);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, sl_dma);
+
+	sl_dma_debugfs_init(sl_dma);
+
+	dev_dbg(dev, "probed %s\n", KBUILD_MODNAME);
+
+	return 0;
+}
+
+static const struct platform_device_id sl_dma_platform_ids[] = {
+	{ .name = "sl-dma" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sl_dma_platform_ids);
+
+static struct platform_driver sl_dma_driver = {
+	.probe = sl_dma_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.id_table = sl_dma_platform_ids,
+};
+
+module_platform_driver(sl_dma_driver);
+
+MODULE_AUTHOR("Philipp Zabel");
+MODULE_DESCRIPTION("Smartlogic PCIe DMA IP Core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/sl-dma.h b/drivers/dma/sl-dma.h
new file mode 100644
index 000000000000..d79f392b4af7
--- /dev/null
+++ b/drivers/dma/sl-dma.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Linux DMA Driver for the Smartlogic High Channel Count (HCC) DMA IP Core.
+ *
+ * Copyright (C) 2020 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ */
+#ifndef SL_DMA_H
+#define SL_DMA_H
+
+/*
+ * DMA IP Core registers are described in the Smartlogic "High Channel Count
+ * DMA IP Core for PCI-Express User Guide", June 2020.
+ */
+
+/* Chapters 7.1 Version and PCI Status Register, 7.2 Servicing of Interrupts */
+#define REG_VERSION					0x0
+#define		VERSION_CORE_REVISION(x)		FIELD_GET(GENMASK(7, 0), (x))
+#define		VERSION_YEAR(x)				FIELD_GET(GENMASK(15, 8), (x))
+#define		VERSION_MONTH(x)			FIELD_GET(GENMASK(23, 16), (x))
+#define		VERSION_DAY(x)				FIELD_GET(GENMASK(31, 24), (x))
+#define REG_INTERRUPT_CONTROL				0x4
+#define REG_INTERRUPT_STATUS				0x8
+/*
+ * The test interrupt is documented in chapter 5.3.4 as BIT(20), but the
+ * interrupt mapping is project specific. In the demo design, the test
+ * interrupt is mapped to BIT(3).
+ */
+#define		DMA_WRITE_INTERRUPT_BIT			BIT(0)
+#define		DMA_READ_INTERRUPT_BIT			BIT(1)
+#define		TEST_INTERRUPT_BIT			BIT(3)
+#define REG_INTERRUPT_CONTROL2				0xc
+#define		ISSUE_TEST_INTERRUPT_BIT		BIT(0)
+#define REG_TX_CRC_ERROR				0x10
+#define REG_RX_CRC_ERROR				0x14
+#define REG_PCI_STATUS					0x20
+#define		PCI_STATUS_MPS(x)			(128 << FIELD_GET(GENMASK(7, 5), (x)))
+#define		PCI_STATUS_EXTENDED_TAG			BIT(8)
+#define		PCI_STATUS_MRS(x)			(128 << FIELD_GET(GENMASK(14, 12), (x)))
+#define		PCI_STATUS_LINK_SPEED(x)		FIELD_GET(GENMASK(19, 16), (x))
+#define		PCI_STATUS_LINK_WIDTH(x)		FIELD_GET(GENMASK(25, 20), (x))
+#define		PCI_STATUS_MSI				BIT(31)
+#define REG_STALL_TIME					0x30
+#define REG_LAST_DEADLOCK				0x3c
+#define REG_GPO						0x40
+
+/* Chapter 7.3.1 DMA Write Register Layout */
+#define REG_DMA_WRITE_CONTROL				0x800
+#define REG_DMA_WRITE_CONFIG				0x804
+#define REG_DMA_WRITE_STATUS				0x808
+#define		DMA_STATUS_NUM_CHANNELS(x)		(1 << FIELD_GET(GENMASK(26, 24), (x)))
+#define		DMA_STATUS_CORE_TYPE			BIT(27)
+#define REG_DMA_WRITE_PAGE_SIZE				0x810
+#define REG_DMA_WRITE_FIFO_RESETS			0x828
+#define REG_DMA_WRITE_GLOBAL_INTERRUPT_ENABLE		0x82c
+#define		GLOBAL_INTERRUPT_EOF			BIT(2)
+#define REG_DMA_WRITE_GLOBAL_INTERRUPT_STATUS		0x830
+#define REG_DMA_WRITE_INTERRUPT_ENABLE_END_OF_LINE	0x838
+#define REG_DMA_WRITE_INTERRUPT_ENABLE_END_OF_FRAME	0x83c
+#define REG_DMA_WRITE_INTERRUPT_ENABLE_START_OF_FRAME	0x840
+#define REG_DMA_WRITE_INTERRUPT_ENABLE_SG_FIFO_EMPTY	0x844
+#define REG_DMA_WRITE_INTERRUPT_ENABLE_SG_FIFO_OVFL	0x84c
+#define REG_DMA_WRITE_INTERRUPT_STATUS_END_OF_LINE	0x854
+#define REG_DMA_WRITE_INTERRUPT_STATUS_END_OF_FRAME	0x858
+#define REG_DMA_WRITE_INTERRUPT_STATUS_START_OF_FRAME	0x85c
+#define REG_DMA_WRITE_INTERRUPT_STATUS_SG_FIFO_EMPTY	0x860
+#define REG_DMA_WRITE_INTERRUPT_STATUS_SG_FIFO_OVFL	0x868
+#define REG_DMA_WRITE_ALTERNATE_PAGESIZEDEFINITION	0x880
+#define REG_DMA_WRITE_GENERAL_PARAMETER_INFO		0x884
+#define		DMA_WRITE_GPI_NUM_INTERFACES(x)		FIELD_GET(GENMASK(4, 0), (x))
+#define		DMA_WRITE_GPI_SG_MODE			BIT(5)
+#define		DMA_WRITE_GPI_SG_FIFO_RAM_TYPE		BIT(6)
+#define		DMA_WRITE_GPI_SG_FIFO_DEPTH(x)		(1 << FIELD_GET(GENMASK(14, 7), (x)))
+#define REG_DMA_WRITE_BASE_ADDRESS(channel)		(0x900 + 8 * (channel))
+#define REG_DMA_WRITE_INCREMENT_LINE_OFFSET(channel)	(0xb00 + 4 * (channel))
+#define REG_DMA_WRITE_LAST_ADDRESS(channel)		(0xc00 + 4 * (channel))
+#define REG_DMA_WRITE_CURRENT_BUFFER_POINTER(channel)	(0xd00 + 4 * (channel))
+
+/* Chapter 7.4.1 DMA Read Register Layout */
+#define REG_DMA_READ_CONTROL				0x1000
+#define REG_DMA_READ_CONFIG				0x1004
+#define REG_DMA_READ_STATUS_0				0x1008
+#define REG_DMA_READ_STATUS_1				0x100c
+#define REG_DMA_READ_PAGE_SIZE				0x1010
+#define REG_DMA_READ_1D_2D_SELECT			0x1024
+#define REG_DMA_READ_FIFO_RESETS			0x1028
+#define REG_DMA_READ_GLOBAL_INTERRUPT_ENABLE		0x102c
+#define REG_DMA_READ_GLOBAL_INTERRUPT_STATUS		0x1030
+#define REG_DMA_READ_INTERRUPT_ENABLE_END_OF_REQUEST	0x103c
+#define REG_DMA_READ_INTERRUPT_ENABLE_SG_FIFO_EMPTY	0x1044
+#define REG_DMA_READ_INTERRUPT_ENABLE_SG_FIFO_OVFL	0x104c
+#define REG_DMA_READ_INTERRUPT_STATUS_END_OF_REQUEST	0x1058
+#define REG_DMA_READ_INTERRUPT_STATUS_SG_FIFO_EMPTY	0x1060
+#define REG_DMA_READ_INTERRUPT_STATUS_SG_FIFO_OVFL	0x1068
+#define REG_DMA_READ_ALTERNATE_PAGESIZEDEFINITION	0x1080
+#define REG_DMA_READ_GENERAL_PARAMETER_INFO		0x1084
+#define		DMA_READ_GPI_NUM_INTERFACES(x)		FIELD_GET(GENMASK(4, 0), (x))
+#define		DMA_READ_GPI_SG_MODE			BIT(5)
+#define		DMA_READ_GPI_SG_FIFO_RAM_TYPE		BIT(6)
+#define		DMA_READ_GPI_SG_FIFO_DEPTH(x)		(1 << FIELD_GET(GENMASK(14, 7), (x)))
+#define		DMA_READ_GPI_COMPLETION_TIMEOUT_US(x)	(FIELD_GET(GENMASK(26, 15), (x)) * 100)
+#define		DMA_READ_GPI_LENGTH_FIFO_PRESENT	BIT(27)
+#define		DMA_READ_GPI_LENGTH_FIFO_DEPTH(x)	(1 << FIELD_GET(GENMASK(31, 28), (x)))
+#define REG_DMA_READ_BASE_ADDRESS(channel)		(0x1100 + 8 * (channel))
+#define REG_DMA_READ_RELOAD_BUDGET(interface)		(0x1200 + 4 * (interface))
+#define REG_DMA_READ_LAST_ADDRESS(channel)		(0x1280 + 4 * (channel))
+#define REG_DMA_READ_CURRENT_BUFFER_POINTER(channel)	(0x1300 + 4 * (channel))
+#define REG_DMA_READ_IMAGE_FORMAT(channel)		(0x1380 + 4 * (channel))
+
+#endif /* SL_DMA_H */
diff --git a/include/linux/dma/sl-dma.h b/include/linux/dma/sl-dma.h
new file mode 100644
index 000000000000..21fea5b0be10
--- /dev/null
+++ b/include/linux/dma/sl-dma.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Linux DMA Driver for the Smartlogic High Channel Count (HCC) DMA IP Core.
+ *
+ * Copyright (C) 2020 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ */
+#ifndef _DMA_SL_DMA_H
+#define _DMA_SL_DMA_H
+
+#include <linux/types.h>
+
+#define SL_DMA_MAX_WRITE_CHANNELS	64
+#define SL_DMA_MAX_READ_CHANNELS	16
+#define SL_DMA_MAX_INTERFACES		16
+
+struct device;
+struct dma_slave_map;
+
+/**
+ * struct sl_dma_write_channel_config - per-channel DMA Write configuration
+ * channel: logical write channel number
+ * interface: AXI Stream slave interface that writes to this channel
+ * irq: design specific End of Frame global MSI-X IRQ number
+ * page_size: destination buffer page size
+ * reset: reset bit in the reset flag register, optional
+ */
+struct sl_dma_write_channel_config {
+	u8 channel;
+	u8 interface;
+	u8 irq;
+	u32 page_size;
+	u32 reset;
+};
+
+/**
+ * struct sl_dma_read_channel_config - per-channel DMA Read configuration
+ * channel: logical read channel number
+ * irq: design specific End of Request global MSI-X IRQ number
+ * page_size: source buffer page size
+ * image_format: bytes per transfer
+ */
+struct sl_dma_read_channel_config {
+	u8 channel;
+	u8 irq;
+	u32 page_size;
+	u32 image_format;
+};
+
+/**
+ * struct sl_dma_write_channel_pair - pair channels that transfer together
+ * @non_triggering_ch: the first channel to transfer, does not trigger interrupt
+ * @triggering_ch: the second to transfer, triggers an interrupt
+ */
+struct sl_dma_write_channel_pair {
+	u8 non_triggering_ch;
+	u8 triggering_ch;
+};
+
+/**
+ * struct sl_dma_config - design specific DMA IP Core configuration
+ * @dma_map: array of struct dma_slave_map mappings
+ * @dma_map_size: ARRAY_SIZE of dma_map
+ * @num_write_channels: number of logical DMA write channels
+ * @num_read_channels: number of logical DMA read channels
+ * @num_write_channel_pairs: number of write channel pairs
+ * @write_channels: DMA Write channel configuration array
+ * @read_channels: DMA Read channel configuration array
+ * @write_channel_pairs: array of paired write channels
+ * @prepare_start: called before an AXI Stream slave interface is started
+ * @reset_flag_reg: reset flag register offset. If non-zero, per-interface bits
+ *                  assert during dmaengine_terminate_*() on write channels.
+ * @user_interrupts: bitfield of interrupts issued by user logic.
+ */
+struct sl_dma_config {
+	const struct dma_slave_map *dma_map;
+	unsigned int dma_map_size;
+	unsigned int num_write_channels;
+	unsigned int num_read_channels;
+	unsigned int num_write_channel_pairs;
+	const struct sl_dma_write_channel_config *write_channels;
+	const struct sl_dma_read_channel_config *read_channels;
+	const struct sl_dma_write_channel_pair *write_channel_pairs;
+	void (*prepare_start)(struct device *dev, unsigned int interface);
+	unsigned int reset_flag_reg;
+	u32 user_interrupts;
+};
+
+#endif /* _DMA_SL_DMA_H */

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240703-sl-dma-54f7a4333abc

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


