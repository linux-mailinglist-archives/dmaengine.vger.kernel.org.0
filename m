Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6594A117C5D
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 01:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLJAYs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 19:24:48 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38066 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfLJAYr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Dec 2019 19:24:47 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieTKS-0002Cw-6g; Mon, 09 Dec 2019 17:24:45 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieTKR-0000lp-9G; Mon, 09 Dec 2019 17:24:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  9 Dec 2019 17:24:35 -0700
Message-Id: <20191210002437.2907-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210002437.2907-1-logang@deltatee.com>
References: <20191210002437.2907-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v2 3/5] dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some PLX Switches can expose DMA engines via extra PCI functions
on the upstream port. Each function will have one DMA channel.

This patch is just the core PCI driver skeleton and dma
engine registration.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS           |   5 ++
 drivers/dma/Kconfig   |   9 ++
 drivers/dma/Makefile  |   1 +
 drivers/dma/plx_dma.c | 197 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/dma/plx_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..76713226f256 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13139,6 +13139,11 @@ S:	Maintained
 F:	drivers/iio/chemical/pms7003.c
 F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
 
+PLX DMA DRIVER
+M:	Logan Gunthorpe <logang@deltatee.com>
+S:	Maintained
+F:	drivers/dma/plx_dma.c
+
 PMBUS HARDWARE MONITORING DRIVERS
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6fa1eba9d477..312a6cc36c78 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -497,6 +497,15 @@ config PXA_DMA
 	  16 to 32 channels for peripheral to memory or memory to memory
 	  transfers.
 
+config PLX_DMA
+	tristate "PLX ExpressLane PEX Switch DMA Engine Support"
+	depends on PCI
+	select DMA_ENGINE
+	help
+	  Some PLX ExpressLane PCI Switches support additional DMA engines.
+	  These are exposed via extra functions on the switch's
+	  upstream port. Each function exposes one DMA channel.
+
 config SIRF_DMA
 	tristate "CSR SiRFprimaII/SiRFmarco DMA support"
 	depends on ARCH_SIRF
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 42d7e2fc64fa..a150d1d792fd 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
 obj-$(CONFIG_OWL_DMA) += owl-dma.o
 obj-$(CONFIG_PCH_DMA) += pch_dma.o
 obj-$(CONFIG_PL330_DMA) += pl330.o
+obj-$(CONFIG_PLX_DMA) += plx_dma.o
 obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
new file mode 100644
index 000000000000..54e13cb92d51
--- /dev/null
+++ b/drivers/dma/plx_dma.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microsemi Switchtec(tm) PCIe Management Driver
+ * Copyright (c) 2019, Logan Gunthorpe <logang@deltatee.com>
+ * Copyright (c) 2019, GigaIO Networks, Inc
+ */
+
+#include "dmaengine.h"
+
+#include <linux/dmaengine.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+MODULE_DESCRIPTION("PLX ExpressLane PEX PCI Switch DMA Engine");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Logan Gunthorpe");
+
+struct plx_dma_dev {
+	struct dma_device dma_dev;
+	struct dma_chan dma_chan;
+	void __iomem *bar;
+
+	struct kref ref;
+	struct work_struct release_work;
+};
+
+static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
+{
+	return container_of(c, struct plx_dma_dev, dma_chan);
+}
+
+static void plx_dma_release_work(struct work_struct *work)
+{
+	struct plx_dma_dev *plxdev = container_of(work, struct plx_dma_dev,
+						  release_work);
+
+	dma_async_device_unregister(&plxdev->dma_dev);
+	put_device(plxdev->dma_dev.dev);
+	kfree(plxdev);
+}
+
+static void plx_dma_release(struct kref *ref)
+{
+	struct plx_dma_dev *plxdev = container_of(ref, struct plx_dma_dev, ref);
+
+	/*
+	 * The dmaengine reference counting and locking is a bit of a
+	 * mess so we have to work around it a bit here. We might put
+	 * the reference while the dmaengine holds the dma_list_mutex
+	 * which means we can't call dma_async_device_unregister() directly
+	 * here and it must be delayed.
+	 */
+	schedule_work(&plxdev->release_work);
+}
+
+static void plx_dma_put(struct plx_dma_dev *plxdev)
+{
+	kref_put(&plxdev->ref, plx_dma_release);
+}
+
+static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
+
+	kref_get(&plxdev->ref);
+
+	return 0;
+}
+
+static void plx_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
+
+	plx_dma_put(plxdev);
+}
+
+static int plx_dma_create(struct pci_dev *pdev)
+{
+	struct plx_dma_dev *plxdev;
+	struct dma_device *dma;
+	struct dma_chan *chan;
+	int rc;
+
+	plxdev = kzalloc(sizeof(*plxdev), GFP_KERNEL);
+	if (!plxdev)
+		return -ENOMEM;
+
+	kref_init(&plxdev->ref);
+	INIT_WORK(&plxdev->release_work, plx_dma_release_work);
+
+	plxdev->bar = pcim_iomap_table(pdev)[0];
+
+	dma = &plxdev->dma_dev;
+	dma->chancnt = 1;
+	INIT_LIST_HEAD(&dma->channels);
+	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
+	dma->dev = get_device(&pdev->dev);
+
+	dma->device_alloc_chan_resources = plx_dma_alloc_chan_resources;
+	dma->device_free_chan_resources = plx_dma_free_chan_resources;
+
+	chan = &plxdev->dma_chan;
+	chan->device = dma;
+	dma_cookie_init(chan);
+	list_add_tail(&chan->device_node, &dma->channels);
+
+	rc = dma_async_device_register(dma);
+	if (rc) {
+		pci_err(pdev, "Failed to register dma device: %d\n", rc);
+		free_irq(pci_irq_vector(pdev, 0),  plxdev);
+		return rc;
+	}
+
+	pci_set_drvdata(pdev, plxdev);
+
+	return 0;
+}
+
+static int plx_dma_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *id)
+{
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (rc)
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (rc)
+		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pdev, 1, KBUILD_MODNAME);
+	if (rc)
+		return rc;
+
+	rc = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (rc <= 0)
+		return rc;
+
+	pci_set_master(pdev);
+
+	rc = plx_dma_create(pdev);
+	if (rc)
+		goto err_free_irq_vectors;
+
+	pci_info(pdev, "PLX DMA Channel Registered\n");
+
+	return 0;
+
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
+	return rc;
+}
+
+static void plx_dma_remove(struct pci_dev *pdev)
+{
+	struct plx_dma_dev *plxdev = pci_get_drvdata(pdev);
+
+	free_irq(pci_irq_vector(pdev, 0),  plxdev);
+
+	plxdev->bar = NULL;
+	plx_dma_put(plxdev);
+
+	pci_free_irq_vectors(pdev);
+}
+
+static const struct pci_device_id plx_dma_pci_tbl[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_PLX,
+		.device		= 0x87D0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_SYSTEM_OTHER << 8,
+		.class_mask	= 0xFFFFFFFF,
+	},
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, plx_dma_pci_tbl);
+
+static struct pci_driver plx_dma_pci_driver = {
+	.name           = KBUILD_MODNAME,
+	.id_table       = plx_dma_pci_tbl,
+	.probe          = plx_dma_probe,
+	.remove		= plx_dma_remove,
+};
+module_pci_driver(plx_dma_pci_driver);
-- 
2.20.1

