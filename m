Return-Path: <dmaengine+bounces-7639-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01CDCBF749
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D381300094F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223313271E2;
	Mon, 15 Dec 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="JwgjwZJC"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCB3271E7
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824057; cv=none; b=e7D9NqB4zgrsiZ1txZnPY2lP3iRym9Q8CAx2ZAaJ6RywpD8byN91WO6C/TtKBYpkJ+3MdD7tJS00wuDCauzvwEaMQdZ5evGhcVAboYCytKTLxU11Hf5TPisTbTdyAWYnq97jr+8xPTMzLmqv5cNRe2FoIzLT9a/WewsLi3mwuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824057; c=relaxed/simple;
	bh=VWAI2Ez0kyZFfTAmr6t37NhaWqm802zVvgi2dBS3UyI=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=bIvQ05nwk9GwZp04Y942SNzxTDdQYIBU0jOwtEpzHUj90aQmVffIqhBq0VFMZcgr/+rHJuvdTxrmXuuy4jvszGVe+CqL7N3uDDZfvAr8k8sEudvaDScTvbwPpGR6M74OTob4+e+QZ4eQ0JMIGkRoMU8ioJ7u4J3Wfd/8hNtrnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=JwgjwZJC; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=aE7wrKnJZ2HI5JjehI1+4tKFa0x6OaH0qb/SH4obmRc=; b=JwgjwZJClN7Ydcq5PF0PJlTc4M
	mwNSiVO2laBVapfQuHG5zO7NpO8CpsnwFhAj44kQgbxVKX1I9q8nlAUCbWxZAtT6lCXvJUONVm6Wq
	mH83v/wqKqXm+thVhinXFypAo7gBQMiMIYoZw7c6zGKssu62SEpkdVcQTEyJ8/zqwFiRQJX8b2sGz
	bkNSyGxITCCV5cZHwx4Gjtksntap9C1PWFgZNXn2F8CZGum62EohuxF6D52Skt+N8wt+SJYJBDU2+
	JaUo2YeOEOVvR6PJFpiiWkGl/ZzEEr/TT5djjbZ5Ajl00dx/3EJHGoxXlw1mspa6ndiv8BYL9CnAX
	/9KeC8Tg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vVD89-00000003Fw2-0rlL;
	Mon, 15 Dec 2025 11:17:10 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vVD7t-000000000gN-0VQX;
	Mon, 15 Dec 2025 11:16:53 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	George Ge <george.ge@microchip.com>,
	Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 15 Dec 2025 11:16:47 -0700
Message-ID: <20251215181649.2605-2-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215181649.2605-1-logang@deltatee.com>
References: <20251215181649.2605-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, hch@infradead.org, christophe.jaillet@wanadoo.fr, kelvin.cao@microchip.com, George.Ge@microchip.com, george.ge@microchip.com, hch@lst.de, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v11 1/3] dmaengine: switchtec-dma: Introduce Switchtec DMA engine skeleton
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

From: Kelvin Cao <kelvin.cao@microchip.com>

Some Switchtec Switches can expose DMA engines via extra PCI functions
on the upstream ports. At most one such function can be supported on
each upstream port. Each function can have one or more DMA channels.

This patch is just the core PCI driver skeleton and dma
engine registration.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Co-developed-by: George Ge <george.ge@microchip.com>
Signed-off-by: George Ge <george.ge@microchip.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS                 |   7 ++
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/switchtec_dma.c | 218 ++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..8653502ae275 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25209,6 +25209,13 @@ S:	Supported
 F:	include/net/switchdev.h
 F:	net/switchdev/
 
+SWITCHTEC DMA DRIVER
+M:	Kelvin Cao <kelvin.cao@microchip.com>
+M:	Logan Gunthorpe <logang@deltatee.com>
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	drivers/dma/switchtec_dma.c
+
 SY8106A REGULATOR DRIVER
 M:	Icenowy Zheng <icenowy@aosc.io>
 S:	Maintained
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8bb0a119ecd4..85296c5cead9 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -610,6 +610,15 @@ config SPRD_DMA
 	help
 	  Enable support for the on-chip DMA controller on Spreadtrum platform.
 
+config SWITCHTEC_DMA
+	tristate "Switchtec PSX/PFX Switch DMA Engine Support"
+	depends on PCI
+	select DMA_ENGINE
+	help
+	  Some Switchtec PSX/PFX PCIe Switches support additional DMA engines.
+	  These are exposed via an extra function on the switch's upstream
+	  port.
+
 config TXX9_DMAC
 	tristate "Toshiba TXx9 SoC DMA support"
 	depends on MACH_TX49XX
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b..df566c4958b6 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SF_PDMA) += sf-pdma/
 obj-$(CONFIG_SOPHGO_CV1800B_DMAMUX) += cv1800b-dmamux.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
+obj-$(CONFIG_SWITCHTEC_DMA) += switchtec_dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
new file mode 100644
index 000000000000..f3c366936684
--- /dev/null
+++ b/drivers/dma/switchtec_dma.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Switchtec(tm) DMA Controller Driver
+ * Copyright (c) 2025, Kelvin Cao <kelvin.cao@microchip.com>
+ * Copyright (c) 2025, Microchip Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/circ_buf.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#include "dmaengine.h"
+
+MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kelvin Cao");
+
+struct switchtec_dma_dev {
+	struct dma_device dma_dev;
+	struct pci_dev __rcu *pdev;
+	void __iomem *bar;
+};
+
+static void switchtec_dma_release(struct dma_device *dma_dev)
+{
+	struct switchtec_dma_dev *swdma_dev =
+		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
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
+	int nr_vecs, rc;
+
+	/*
+	 * Create the switchtec dma device
+	 */
+	swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
+	if (!swdma_dev)
+		return -ENOMEM;
+
+	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
+				 pci_resource_len(pdev, 0));
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
+	dma = &swdma_dev->dma_dev;
+	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
+	dma->dev = get_device(&pdev->dev);
+
+	dma->device_release = switchtec_dma_release;
+
+	rc = dma_async_device_register(dma);
+	if (rc) {
+		pci_err(pdev, "Failed to register dma device: %d\n", rc);
+		goto err_exit;
+	}
+
+	list_for_each_entry(chan, &dma->channels, device_node)
+		pci_info(pdev, "%s\n", dma_chan_name(chan));
+
+	pci_set_drvdata(pdev, swdma_dev);
+
+	return 0;
+
+err_exit:
+	iounmap(swdma_dev->bar);
+	kfree(swdma_dev);
+	return rc;
+}
+
+static int switchtec_dma_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	int rc;
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		goto err_disable;
+
+	rc = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (rc)
+		goto err_disable;
+
+	pci_set_master(pdev);
+
+	rc = switchtec_dma_create(pdev);
+	if (rc)
+		goto err_free;
+
+	pci_info(pdev, "Switchtec DMA Channels Registered\n");
+
+	return 0;
+
+err_free:
+	pci_free_irq_vectors(pdev);
+	pci_release_mem_regions(pdev);
+
+err_disable:
+	pci_disable_device(pdev);
+
+	return rc;
+}
+
+static void switchtec_dma_remove(struct pci_dev *pdev)
+{
+	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
+
+	rcu_assign_pointer(swdma_dev->pdev, NULL);
+	synchronize_rcu();
+
+	pci_free_irq_vectors(pdev);
+
+	dma_async_device_unregister(&swdma_dev->dma_dev);
+
+	iounmap(swdma_dev->bar);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+
+	pci_info(pdev, "Switchtec DMA Channels Unregistered\n");
+}
+
+/*
+ * Also use the class code to identify the devices, as some of the
+ * device IDs are also used for other devices with other classes by
+ * Microsemi.
+ */
+#define SW_ID(vendor_id, device_id) \
+	{ \
+		.vendor     = vendor_id, \
+		.device     = device_id, \
+		.subvendor  = PCI_ANY_ID, \
+		.subdevice  = PCI_ANY_ID, \
+		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
+		.class_mask = 0xffffffff, \
+	}
+
+static const struct pci_device_id switchtec_dma_pci_tbl[] = {
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4000), /* PFX 100XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4084), /* PFX 84XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4068), /* PFX 68XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4052), /* PFX 52XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4036), /* PFX 36XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4028), /* PFX 28XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4100), /* PSX 100XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4184), /* PSX 84XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4168), /* PSX 68XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4152), /* PSX 52XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4136), /* PSX 36XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4128), /* PSX 28XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4352), /* PFXA 52XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4336), /* PFXA 36XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4328), /* PFXA 28XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4452), /* PSXA 52XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4436), /* PSXA 36XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4428), /* PSXA 28XG4 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5000), /* PFX 100XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5084), /* PFX 84XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5068), /* PFX 68XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5052), /* PFX 52XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5036), /* PFX 36XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5028), /* PFX 28XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5100), /* PSX 100XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5184), /* PSX 84XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5168), /* PSX 68XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5152), /* PSX 52XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5136), /* PSX 36XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5128), /* PSX 28XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5300), /* PFXA 100XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5384), /* PFXA 84XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5368), /* PFXA 68XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5352), /* PFXA 52XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5336), /* PFXA 36XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5328), /* PFXA 28XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5400), /* PSXA 100XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5484), /* PSXA 84XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5468), /* PSXA 68XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5452), /* PSXA 52XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5436), /* PSXA 36XG5 */
+	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5428), /* PSXA 28XG5 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1001), /* PCI1001 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1002), /* PCI1002 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1003), /* PCI1003 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
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
2.47.3


