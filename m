Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D93C5B8E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jul 2021 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhGLLmI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jul 2021 07:42:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:39511 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234638AbhGLLmH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Jul 2021 07:42:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="210005551"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="210005551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 04:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="412562001"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2021 04:39:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97AF8FF; Mon, 12 Jul 2021 14:39:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 1/1] dmaengine: dw: Program xBAR hardware for Elkhart Lake
Date:   Mon, 12 Jul 2021 14:39:40 +0300
Message-Id: <20210712113940.42753-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Intel Elkhart Lake PSE DMA implementation is integrated with crossbar IP
in order to serve more hardware than there are DMA request lines available.

Due to this, program xBAR hardware to make flexible support of PSE peripheral.

The Device-to-Device has not been tested and it's not supported by DMA Engine,
but it's left in the code for the sake of documenting hardware features.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: converted dead code to comments (Vinod), rebased on top of v5.14-rc1
 drivers/dma/dw/idma32.c              | 138 ++++++++++++++++++++++++++-
 drivers/dma/dw/internal.h            |  16 ++++
 drivers/dma/dw/pci.c                 |   6 +-
 drivers/dma/dw/platform.c            |   6 +-
 include/linux/platform_data/dma-dw.h |   3 +
 5 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index 3ce44de25d33..58f4078d83fe 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -1,15 +1,144 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2013,2018 Intel Corporation
+// Copyright (C) 2013,2018,2020-2021 Intel Corporation
 
 #include <linux/bitops.h>
 #include <linux/dmaengine.h>
 #include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
 #include "internal.h"
 
-static void idma32_initialize_chan(struct dw_dma_chan *dwc)
+#define DMA_CTL_CH(x)			(0x1000 + (x) * 4)
+#define DMA_SRC_ADDR_FILLIN(x)		(0x1100 + (x) * 4)
+#define DMA_DST_ADDR_FILLIN(x)		(0x1200 + (x) * 4)
+#define DMA_XBAR_SEL(x)			(0x1300 + (x) * 4)
+#define DMA_REGACCESS_CHID_CFG		(0x1400)
+
+#define CTL_CH_TRANSFER_MODE_MASK	GENMASK(1, 0)
+#define CTL_CH_TRANSFER_MODE_S2S	0
+#define CTL_CH_TRANSFER_MODE_S2D	1
+#define CTL_CH_TRANSFER_MODE_D2S	2
+#define CTL_CH_TRANSFER_MODE_D2D	3
+#define CTL_CH_RD_RS_MASK		GENMASK(4, 3)
+#define CTL_CH_WR_RS_MASK		GENMASK(6, 5)
+#define CTL_CH_RD_NON_SNOOP_BIT		BIT(8)
+#define CTL_CH_WR_NON_SNOOP_BIT		BIT(9)
+
+#define XBAR_SEL_DEVID_MASK		GENMASK(15, 0)
+#define XBAR_SEL_RX_TX_BIT		BIT(16)
+#define XBAR_SEL_RX_TX_SHIFT		16
+
+#define REGACCESS_CHID_MASK		GENMASK(2, 0)
+
+static unsigned int idma32_get_slave_devfn(struct dw_dma_chan *dwc)
+{
+	struct device *slave = dwc->chan.slave;
+
+	if (!slave || !dev_is_pci(slave))
+		return 0;
+
+	return to_pci_dev(slave)->devfn;
+}
+
+static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
+{
+	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	void __iomem *misc = __dw_regs(dw);
+	u32 cfghi = 0, cfglo = 0;
+	u8 dst_id, src_id;
+	u32 value;
+
+	/* DMA Channel ID Configuration register must be programmed first */
+	value = readl(misc + DMA_REGACCESS_CHID_CFG);
+
+	value &= ~REGACCESS_CHID_MASK;
+	value |= dwc->chan.chan_id;
+
+	writel(value, misc + DMA_REGACCESS_CHID_CFG);
+
+	/* Configure channel attributes */
+	value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));
+
+	value &= ~(CTL_CH_RD_NON_SNOOP_BIT | CTL_CH_WR_NON_SNOOP_BIT);
+	value &= ~(CTL_CH_RD_RS_MASK | CTL_CH_WR_RS_MASK);
+	value &= ~CTL_CH_TRANSFER_MODE_MASK;
+
+	switch (dwc->direction) {
+	case DMA_MEM_TO_DEV:
+		value |= CTL_CH_TRANSFER_MODE_D2S;
+		value |= CTL_CH_WR_NON_SNOOP_BIT;
+		break;
+	case DMA_DEV_TO_MEM:
+		value |= CTL_CH_TRANSFER_MODE_S2D;
+		value |= CTL_CH_RD_NON_SNOOP_BIT;
+		break;
+	default:
+		/*
+		 * Memory-to-Memory and Device-to-Device are ignored for now.
+		 *
+		 * For Memory-to-Memory transfers we would need to set mode
+		 * and disable snooping on both sides.
+		 */
+		return;
+	}
+
+	writel(value, misc + DMA_CTL_CH(dwc->chan.chan_id));
+
+	/* Configure crossbar selection */
+	value = readl(misc + DMA_XBAR_SEL(dwc->chan.chan_id));
+
+	/* DEVFN selection */
+	value &= ~XBAR_SEL_DEVID_MASK;
+	value |= idma32_get_slave_devfn(dwc);
+
+	switch (dwc->direction) {
+	case DMA_MEM_TO_DEV:
+		value |= XBAR_SEL_RX_TX_BIT;
+		break;
+	case DMA_DEV_TO_MEM:
+		value &= ~XBAR_SEL_RX_TX_BIT;
+		break;
+	default:
+		/* Memory-to-Memory and Device-to-Device are ignored for now */
+		return;
+	}
+
+	writel(value, misc + DMA_XBAR_SEL(dwc->chan.chan_id));
+
+	/* Configure DMA channel low and high registers */
+	switch (dwc->direction) {
+	case DMA_MEM_TO_DEV:
+		dst_id = dwc->chan.chan_id;
+		src_id = dwc->dws.src_id;
+		break;
+	case DMA_DEV_TO_MEM:
+		dst_id = dwc->dws.dst_id;
+		src_id = dwc->chan.chan_id;
+		break;
+	default:
+		/* Memory-to-Memory and Device-to-Device are ignored for now */
+		return;
+	}
+
+	/* Set default burst alignment */
+	cfglo |= IDMA32C_CFGL_DST_BURST_ALIGN | IDMA32C_CFGL_SRC_BURST_ALIGN;
+
+	/* Low 4 bits of the request lines */
+	cfghi |= IDMA32C_CFGH_DST_PER(dst_id & 0xf);
+	cfghi |= IDMA32C_CFGH_SRC_PER(src_id & 0xf);
+
+	/* Request line extension (2 bits) */
+	cfghi |= IDMA32C_CFGH_DST_PER_EXT(dst_id >> 4 & 0x3);
+	cfghi |= IDMA32C_CFGH_SRC_PER_EXT(src_id >> 4 & 0x3);
+
+	channel_writel(dwc, CFG_LO, cfglo);
+	channel_writel(dwc, CFG_HI, cfghi);
+}
+
+static void idma32_initialize_chan_generic(struct dw_dma_chan *dwc)
 {
 	u32 cfghi = 0;
 	u32 cfglo = 0;
@@ -134,7 +263,10 @@ int idma32_dma_probe(struct dw_dma_chip *chip)
 		return -ENOMEM;
 
 	/* Channel operations */
-	dw->initialize_chan = idma32_initialize_chan;
+	if (chip->pdata->quirks & DW_DMA_QUIRK_XBAR_PRESENT)
+		dw->initialize_chan = idma32_initialize_chan_xbar;
+	else
+		dw->initialize_chan = idma32_initialize_chan_generic;
 	dw->suspend_chan = idma32_suspend_chan;
 	dw->resume_chan = idma32_resume_chan;
 	dw->prepare_ctllo = idma32_prepare_ctllo;
diff --git a/drivers/dma/dw/internal.h b/drivers/dma/dw/internal.h
index 2e1c52eefdeb..563ce73488db 100644
--- a/drivers/dma/dw/internal.h
+++ b/drivers/dma/dw/internal.h
@@ -74,4 +74,20 @@ static __maybe_unused const struct dw_dma_chip_pdata idma32_chip_pdata = {
 	.remove = idma32_dma_remove,
 };
 
+static const struct dw_dma_platform_data xbar_pdata = {
+	.nr_channels = 8,
+	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
+	.chan_priority = CHAN_PRIORITY_ASCENDING,
+	.block_size = 131071,
+	.nr_masters = 1,
+	.data_width = {4},
+	.quirks = DW_DMA_QUIRK_XBAR_PRESENT,
+};
+
+static __maybe_unused const struct dw_dma_chip_pdata xbar_chip_pdata = {
+	.pdata = &xbar_pdata,
+	.probe = idma32_dma_probe,
+	.remove = idma32_dma_remove,
+};
+
 #endif /* _DMA_DW_INTERNAL_H */
diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index 1142aa6f8c4a..26a3f926da02 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -120,9 +120,9 @@ static const struct pci_device_id dw_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
-	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_chip_pdata },
-	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_chip_pdata },
-	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&xbar_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&xbar_chip_pdata },
+	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&xbar_chip_pdata },
 
 	/* Haswell */
 	{ PCI_VDEVICE(INTEL, 0x9c60), (kernel_ulong_t)&dw_dma_chip_pdata },
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 0585d749d935..246118955877 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -149,9 +149,9 @@ static const struct acpi_device_id dw_dma_acpi_id_table[] = {
 	{ "808622C0", (kernel_ulong_t)&dw_dma_chip_pdata },
 
 	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
-	{ "80864BB4", (kernel_ulong_t)&idma32_chip_pdata },
-	{ "80864BB5", (kernel_ulong_t)&idma32_chip_pdata },
-	{ "80864BB6", (kernel_ulong_t)&idma32_chip_pdata },
+	{ "80864BB4", (kernel_ulong_t)&xbar_chip_pdata },
+	{ "80864BB5", (kernel_ulong_t)&xbar_chip_pdata },
+	{ "80864BB6", (kernel_ulong_t)&xbar_chip_pdata },
 
 	{ }
 };
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index b34a094b2258..b11b0c8bc5da 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -52,6 +52,7 @@ struct dw_dma_slave {
  * @max_burst: Maximum value of burst transaction size supported by hardware
  *	       per channel (in units of CTL.SRC_TR_WIDTH/CTL.DST_TR_WIDTH).
  * @protctl: Protection control signals setting per channel.
+ * @quirks: Optional platform quirks.
  */
 struct dw_dma_platform_data {
 	unsigned int	nr_channels;
@@ -71,6 +72,8 @@ struct dw_dma_platform_data {
 #define CHAN_PROTCTL_CACHEABLE		BIT(2)
 #define CHAN_PROTCTL_MASK		GENMASK(2, 0)
 	unsigned char	protctl;
+#define DW_DMA_QUIRK_XBAR_PRESENT	BIT(0)
+	unsigned int	quirks;
 };
 
 #endif /* _PLATFORM_DATA_DMA_DW_H */
-- 
2.30.2

