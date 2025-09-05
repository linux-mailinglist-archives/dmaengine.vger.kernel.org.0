Return-Path: <dmaengine+bounces-6416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75076B462AA
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B49FA61B77
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500428136C;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQk52Nn0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDE27F182;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=EAbN62+1L79o858KKlb2Tzbve1P5llzZ6lNPLZIwR9jExddHWmlBIOlmJFKuh538jNmup9GwXsbpz/qEbh9LLmNh5RB1C1jm8nn3Ra15C0CIzYmLV034pxfXG99VpM25kZxMuGXhV91JTMHh7nQPmdik0J8iMFnzDmwOsjwYLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=VuqyHd/j7amx7qZTFAuuOIay+gRe3rBdR2mbbyet7+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRIQR9KgTG/DhE4G1zQpdTZVxyCWv59NMhkc04Ti2hwqEDKTJUjMq2YjE7yOPD7AqKajUma4KQMp46AZk8dOZ+sZk+gnKVi9vCc1lTbcUFDq/uVY7XvCAk/xOErFZp0RYUNoQ6nm/E5G3fV575jH+zDxZXo5yMC0c2S9impSZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQk52Nn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD72AC4CEFF;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=VuqyHd/j7amx7qZTFAuuOIay+gRe3rBdR2mbbyet7+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vQk52Nn0DaUm3t4oc5jh0zcN9gJIjgHVkIHx6SqJriA2fVIkD0ClOrj1EP2W25uIB
	 9bMrMfkVhJTJeriHCkD/ptuYY7WWUhwPcvifwLJVxpe3XYg2qvOxL+e0Ugp7hrRYxN
	 jsyNxnhQg+w3ef91Y5jZDjX4h8YKys70+v5Gktm5m+OxhgsbVfmhz26AH9G+d3wol3
	 944DfqBdz61DRIRiaYF+XFawBK1Yq11qu3DI3xWEo7aCgarycBB/PbxPcvcHLVjwb+
	 9ZxAEoTcQjznO7dsozi6KWppwHvnY3iZ9EZ27I4aMpIUvFC2rSDmjifd2+dm8hJzC5
	 WbYwpP6wf9zJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA9CAC580;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:33 -0500
Subject: [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=5608;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=m3XoOo9ffzkPrZw4+4jLMw0l82s7JUrIjtnNqA36HbE=;
 b=b+YDt/h2Pw7KLvvDg6sXddSGdT5SqziimKeIAWWCz82Uv+SYamNChMpSav8KAeB4FK8f2DKQK
 XU+8ajrDePhDt5ubwyQbiOmkDvA6NDKTflP4KbsWHewEgo3gvX2eM5L
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add support for binding to PCIe-hosted SDXI devices. SDXI requires
MSI(-X) for PCI implementations, so this code will be gated by
CONFIG_PCI_MSI in the Makefile.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/pci.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
new file mode 100644
index 0000000000000000000000000000000000000000..b7f74555395c605c4affffb198ee359accac8521
--- /dev/null
+++ b/drivers/dma/sdxi/pci.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI PCI device code
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/iomap.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci-ats.h>
+#include <linux/pci.h>
+
+#include "mmio.h"
+#include "sdxi.h"
+
+/*
+ * SDXI devices signal message 0 on error conditions, see "Error
+ * Logging Control and Status Registers".
+ */
+#define ERROR_IRQ_MSG 0
+
+/* MMIO BARs */
+#define MMIO_CTL_REGS_BAR		0x0
+#define MMIO_DOORBELL_BAR		0x2
+
+static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
+{
+	return to_pci_dev(sdxi_to_dev(sdxi));
+}
+
+static int sdxi_pci_irq_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	int msi_count;
+	int ret;
+
+	/* 1st irq for error + 1 for each context */
+	msi_count = sdxi->max_cxts + 1;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, msi_count,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		sdxi_err(sdxi, "alloc MSI/MSI-X vectors failed\n");
+		return ret;
+	}
+
+	sdxi->error_irq = pci_irq_vector(pdev, ERROR_IRQ_MSG);
+
+	sdxi_dbg(sdxi, "allocated %d irq vectors", ret);
+
+	return 0;
+}
+
+static void sdxi_pci_irq_exit(struct sdxi_dev *sdxi)
+{
+	pci_free_irq_vectors(sdxi_to_pci_dev(sdxi));
+}
+
+static int sdxi_pci_map(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	int bars, ret;
+
+	bars = 1 << MMIO_CTL_REGS_BAR | 1 << MMIO_DOORBELL_BAR;
+	ret = pcim_iomap_regions(pdev, bars, SDXI_DRV_NAME);
+	if (ret) {
+		sdxi_err(sdxi, "pcim_iomap_regions failed (%d)\n", ret);
+		return ret;
+	}
+
+	sdxi->dbs_bar = pci_resource_start(pdev, MMIO_DOORBELL_BAR);
+
+	/* FIXME: pcim_iomap_table may return NULL, and it's deprecated. */
+	sdxi->ctrl_regs = pcim_iomap_table(pdev)[MMIO_CTL_REGS_BAR];
+	sdxi->dbs = pcim_iomap_table(pdev)[MMIO_DOORBELL_BAR];
+	if (!sdxi->ctrl_regs || !sdxi->dbs) {
+		sdxi_err(sdxi, "pcim_iomap_table failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void sdxi_pci_unmap(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+
+	pcim_iounmap(pdev, sdxi->ctrl_regs);
+	pcim_iounmap(pdev, sdxi->dbs);
+}
+
+static int sdxi_pci_init(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	struct device *dev = &pdev->dev;
+	int dma_bits = 64;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		sdxi_err(sdxi, "pcim_enbale_device failed\n");
+		return ret;
+	}
+
+	pci_set_master(pdev);
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));
+	if (ret) {
+		sdxi_err(sdxi, "failed to set DMA mask & coherent bits\n");
+		return ret;
+	}
+
+	ret = sdxi_pci_map(sdxi);
+	if (ret) {
+		sdxi_err(sdxi, "failed to map device IO resources\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sdxi_pci_exit(struct sdxi_dev *sdxi)
+{
+	sdxi_pci_unmap(sdxi);
+}
+
+static struct sdxi_dev *sdxi_device_alloc(struct device *dev)
+{
+	struct sdxi_dev *sdxi;
+
+	sdxi = kzalloc(sizeof(*sdxi), GFP_KERNEL);
+	if (!sdxi)
+		return NULL;
+
+	sdxi->dev = dev;
+
+	mutex_init(&sdxi->cxt_lock);
+
+	return sdxi;
+}
+
+static void sdxi_device_free(struct sdxi_dev *sdxi)
+{
+	kfree(sdxi);
+}
+
+static const struct sdxi_dev_ops sdxi_pci_dev_ops = {
+	.irq_init = sdxi_pci_irq_init,
+	.irq_exit = sdxi_pci_irq_exit,
+};
+
+static int sdxi_pci_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct sdxi_dev *sdxi;
+	int err;
+
+	sdxi = sdxi_device_alloc(dev);
+	if (!sdxi)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, sdxi);
+
+	err = sdxi_pci_init(sdxi);
+	if (err)
+		goto free_sdxi;
+
+	err = sdxi_device_init(sdxi, &sdxi_pci_dev_ops);
+	if (err)
+		goto pci_exit;
+
+	return 0;
+
+pci_exit:
+	sdxi_pci_exit(sdxi);
+free_sdxi:
+	sdxi_device_free(sdxi);
+
+	return err;
+}
+
+static void sdxi_pci_remove(struct pci_dev *pdev)
+{
+	struct sdxi_dev *sdxi = pci_get_drvdata(pdev);
+
+	sdxi_device_exit(sdxi);
+	sdxi_pci_exit(sdxi);
+	sdxi_device_free(sdxi);
+}
+
+static const struct pci_device_id sdxi_id_table[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
+	{0, }
+};
+MODULE_DEVICE_TABLE(pci, sdxi_id_table);
+
+static struct pci_driver sdxi_driver = {
+	.name = "sdxi",
+	.id_table = sdxi_id_table,
+	.probe = sdxi_pci_probe,
+	.remove = sdxi_pci_remove,
+	.sriov_configure = pci_sriov_configure_simple,
+};
+
+module_pci_driver(sdxi_driver);

-- 
2.39.5



