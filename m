Return-Path: <dmaengine+bounces-11226-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLViCBtkI2o+sQEAu9opvQ
	(envelope-from <dmaengine+bounces-11226-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:04:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48EC64BEA1
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=B8+rTFXA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11226-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11226-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E9230247FA
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268718871F;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AF64;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704142; cv=none; b=mFFGAcl34l6vwEo7bKzzwcUxVSm17w2Xi1c7dm4h1t7+lp9M8ilfLYSkSBJU6QYQ5fUlmxQXMaJOzxXNcfCzeNmiNmUhYKVhXjf1esY3ka6zrYBNlqgKMX6MCo1Ji5COpHjZo7gw7lnRnbWEcf8SNbnGH74o2wRHHPXDLfJD/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704142; c=relaxed/simple;
	bh=sOAB8FquBY7jrHJW7M3Or3hi1sUAHq+p1Pl4iW3yR4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWIXLAu2B3jvmc5Ei2exYaRtof/ySTz7QkD34fYLm83nwg1DvW2nAGZ6i4Cw5e3B/SL7m3uvYKHqkL0UORtsP84mCqxN2FzojHKOXbWjO05mTkS9hVuno6iKofWjrTG2stVYm7tKziM8Qj6q4tRCTHYfyRx28PhP/NFVWjX2doU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8+rTFXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 735E2C4AF09;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780704142;
	bh=sOAB8FquBY7jrHJW7M3Or3hi1sUAHq+p1Pl4iW3yR4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B8+rTFXA8oPeHPbMT57VeUqp4/DFXqVL/XvEEHvT5449IOIPu/4Xgc6VERqbmo8Ku
	 JeBX+ISW0hZRW0IoIGOBbSN3lzoohURUa3POADtSwIsfiJuesZ9Gqw0VjrXDJqhkhF
	 TkVqnNCHXwDENuE74+uOv8qG/7hqhcTfU+oL7tmiDS2tzPZMKXIgMmUw8Y9moKQMeD
	 Zr/Xzx0NPeH5c4CGM4OSPq2H3F97kNm46tOBeyAC6S3MFQ/Rez0UvNnfFImGa9GDrL
	 LiYZS/JC+MZT86Qm7V6CWyV4pLAzvBISzM5/jNv5ewSfvBW7hGzADlghbMikqFAaXb
	 6O1Bt5jJ1kXWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D52CD6E7B;
	Sat,  6 Jun 2026 00:02:22 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Jun 2026 19:02:06 -0500
Subject: [PATCH v3 03/23] dmaengine: sdxi: Add PCI initialization
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-sdxi-base-v3-3-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
In-Reply-To: <20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780704140; l=8020;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=BQZvxuDditz9IitbnDyUmKk8ltcT1WRXb6dWdWsUaGw=;
 b=9a5D3vEH+NkB7ShoIgfSvfFWXtouG9i5xbvR2GnjIbyDoNj3PQej2PGz/HEtgZUj9OQ6Ilkyi
 CfV+NkOQIpAABNbpciefnZsYnxeg9ALmsPisoz2BaU8ByyXkvBc14/b
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11226-lists,dmaengine=lfdr.de,nathan.lynch.amd.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:rientjes@google.com,m:John.Kariuki@amd.com,m:jic23@kernel.org,m:kinseyho@google.com,m:mario.limonciello@amd.com,m:PradeepVineshReddy.Kodamati@amd.com,m:shivankg@amd.com,m:Stephen.Bates@amd.com,m:tycho@kernel.org,m:wei.huang2@amd.com,m:weixugc@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nathan.lynch@amd.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[nathan.lynch@amd.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:email,amd.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B48EC64BEA1

From: Nathan Lynch <nathan.lynch@amd.com>

Add enough code to bind a SDXI device via the class code and map its
control registers and doorbell region. All device resources are
managed with devres at this point, so there is no explicit teardown
path.

While the SDXI specification includes a PCIe binding, the standard is
intended to be independent of the underlying I/O interconnect. So the
driver confines PCI-specific code to pci.c, and the rest (such as
device.c, introduced here) is bus-agnostic. Hence there is some
indirection: during probe, the bus code registers any matched device
with the generic SDXI core, supplying the device and a sdxi_bus_ops
vector. After the core associates a new sdxi_dev with the device,
bus-specific initialization proceeds via the sdxi_bus_ops->init()
callback.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/Kconfig       |  2 ++
 drivers/dma/Makefile      |  1 +
 drivers/dma/sdxi/Kconfig  | 28 ++++++++++++++++
 drivers/dma/sdxi/Makefile |  6 ++++
 drivers/dma/sdxi/device.c | 33 +++++++++++++++++++
 drivers/dma/sdxi/pci.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/sdxi.h   | 38 +++++++++++++++++++++
 7 files changed, 192 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ae6a682c9f76..3d89284e7cf8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -762,6 +762,8 @@ source "drivers/dma/lgm/Kconfig"
 
 source "drivers/dma/loongson/Kconfig"
 
+source "drivers/dma/sdxi/Kconfig"
+
 source "drivers/dma/stm32/Kconfig"
 
 # clients
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 14aa086629d5..069bba1d26c7 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 obj-$(CONFIG_INTEL_LDMA) += lgm/
+obj-$(CONFIG_SDXI_CORE) += sdxi/
 
 obj-y += amd/
 obj-y += loongson/
diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
new file mode 100644
index 000000000000..b91b44231a04
--- /dev/null
+++ b/drivers/dma/sdxi/Kconfig
@@ -0,0 +1,28 @@
+config SDXI_CORE
+	tristate "SDXI (Smart Data Accelerator Interface) support"
+	# Doorbell updates require naturally-aligned 64-bit writes, per
+	# SDXI 1.0 9 MMIO Control Registers.
+	depends on 64BIT
+	select DMA_ENGINE
+	help
+	  Enable support for Smart Data Accelerator Interface (SDXI)
+	  Platform Data Mover devices. SDXI is a vendor-neutral
+	  standard for a memory-to-memory data mover and acceleration
+	  interface.
+
+	  This option is automatically selected by the SDXI PCI driver.
+	  Enable it manually if you want to build the SDXI core for unit
+	  testing without enabling the PCI driver.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be named "sdxi-core".
+
+config SDXI_PCI
+	tristate "SDXI (Smart Data Accelerator Interface) PCI driver"
+	depends on PCI_MSI && 64BIT
+	select SDXI_CORE
+	help
+	  Enable support for PCI-hosted SDXI devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be named "sdxi-pci".
diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
new file mode 100644
index 000000000000..0006edf74d86
--- /dev/null
+++ b/drivers/dma/sdxi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SDXI_CORE) += sdxi-core.o
+sdxi-core-y := device.o
+
+obj-$(CONFIG_SDXI_PCI) += sdxi-pci.o
+sdxi-pci-y := pci.o
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
new file mode 100644
index 000000000000..0974a83bb45c
--- /dev/null
+++ b/drivers/dma/sdxi/device.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI hardware device driver
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+
+#include "sdxi.h"
+
+int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
+{
+	struct sdxi_dev *sdxi;
+
+	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
+	if (!sdxi)
+		return -ENOMEM;
+
+	sdxi->dev = dev;
+	sdxi->bus_ops = ops;
+	dev_set_drvdata(dev, sdxi);
+
+	return sdxi->bus_ops->init(sdxi);
+}
+EXPORT_SYMBOL_NS_GPL(sdxi_register, "SDXI");
+
+MODULE_AUTHOR("Wei Huang");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_DESCRIPTION("SDXI core");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
new file mode 100644
index 000000000000..42e8af008b10
--- /dev/null
+++ b/drivers/dma/sdxi/pci.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI PCI device code
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iomap.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "sdxi.h"
+
+enum sdxi_mmio_bars {
+	SDXI_PCI_BAR_CTL_REGS = 0,
+	SDXI_PCI_BAR_DOORBELL = 2,
+};
+
+static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
+{
+	return to_pci_dev(sdxi->dev);
+}
+
+static int sdxi_pci_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable device\n");
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
+					    KBUILD_MODNAME);
+	if (IS_ERR(sdxi->ctrl_regs))
+		return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
+				     "failed to map control registers\n");
+
+	sdxi->dbs = pcim_iomap_region(pdev, SDXI_PCI_BAR_DOORBELL,
+				      KBUILD_MODNAME);
+	if (IS_ERR(sdxi->dbs))
+		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
+				     "failed to map doorbell region\n");
+
+	pci_set_master(pdev);
+	return 0;
+}
+
+static const struct sdxi_bus_ops sdxi_pci_ops = {
+	.init = sdxi_pci_init,
+};
+
+static int sdxi_pci_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	return sdxi_register(&pdev->dev, &sdxi_pci_ops);
+}
+
+static const struct pci_device_id sdxi_id_table[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, sdxi_id_table);
+
+static struct pci_driver sdxi_driver = {
+	.name = "sdxi",
+	.id_table = sdxi_id_table,
+	.probe = sdxi_pci_probe,
+	.sriov_configure = pci_sriov_configure_simple,
+};
+
+MODULE_IMPORT_NS("SDXI");
+MODULE_AUTHOR("Wei Huang");
+MODULE_AUTHOR("Nathan Lynch");
+MODULE_DESCRIPTION("SDXI PCIe interface driver");
+MODULE_LICENSE("GPL");
+module_pci_driver(sdxi_driver);
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
new file mode 100644
index 000000000000..d4c61ca2f875
--- /dev/null
+++ b/drivers/dma/sdxi/sdxi.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SDXI device driver header
+ *
+ * Copyright Advanced Micro Devices, Inc.
+ */
+
+#ifndef DMA_SDXI_H
+#define DMA_SDXI_H
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+struct sdxi_dev;
+
+/**
+ * struct sdxi_bus_ops - Bus-specific methods for SDXI devices.
+ */
+struct sdxi_bus_ops {
+	/**
+	 * @init: Map control registers and doorbell region, allocate
+	 *        IRQ ranges. Invoked before bus-agnostic SDXI
+	 *        function initialization.
+	 */
+	int (*init)(struct sdxi_dev *sdxi);
+};
+
+struct sdxi_dev {
+	struct device *dev;
+	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
+	void __iomem *dbs;		/* virt addr of doorbells */
+
+	const struct sdxi_bus_ops *bus_ops;
+};
+
+int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
+
+#endif /* DMA_SDXI_H */

-- 
2.54.0



