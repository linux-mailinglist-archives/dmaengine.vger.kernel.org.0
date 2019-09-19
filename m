Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADBAB76D7
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbfISJ70 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 05:59:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbfISJ7W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 05:59:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so3711775wmg.0;
        Thu, 19 Sep 2019 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfuq4hsFUjAwxkhFGSEVf6cth/C6nP54hmb7Z69vTlU=;
        b=Se1QIhDJ/aMmEKO8nKFWQhubpPf+JQobP49Rsol8pjO13/r8QHpgjBg3vRNxPT+Pji
         XgPiQp7+mCNJwl7tkNW3mraNKcyTiD1bEsHQYSP0fIOSwLnvFHiTQ8g5zowbJUGtNm2x
         oRUOa+9DYxJ9FzwPfxi8r4sughdh03M75gPiSWCsP0ZdqBeSBjYxpHEmx086i/GaavJ4
         EC5XB4D18wZ4LrM2zORl1RrUOoC4SsqXyLSf0RienZ9oBrQpw5dayef15piIVZtrhJCS
         6uXZgFXrGsKK3XP2JebdBEhNT4vStyHLbbddnAag3PVfxWArdb0ibv0LwIwgnUnZ3uyH
         sF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfuq4hsFUjAwxkhFGSEVf6cth/C6nP54hmb7Z69vTlU=;
        b=QoKNJ096qyAXkZDCY8XjZFCfzf5t8otiOx4yyfBcf/zSBTnHtucoFvMnwJM7WOGzdJ
         YRCYmMT+KZ8ZuuMNPiP8giUtpx0B3qyRJ+r/1OW1akWtm6puz50/TCJ/dWJAggksZAxQ
         WuL3whtYkbOdt+pbW2BYmAgAge0Mdj8QV0miyHxeSaDRnLqWs23nyLxOtNyqvaxPLw2P
         zv0/359cSIDoyXPy6PFc3QJuFRVlEwLmN12r8+D6QpmCP68+RHBHTf19pFHOgsK3y3/b
         AcsU7RrjKKqc2nxaNcV54VGYMXh+TLAMpYIggTm92J6V0cdBVcTYwTcbg7V5UZ8Ky4Cs
         /d8Q==
X-Gm-Message-State: APjAAAWthXP6JCyzFYcLdT+p73vUinP5P1snfJ2yzDN5ogrWRjgt87vU
        lwDQsATjpZKRA4HQbehKIkwAxJ1f
X-Google-Smtp-Source: APXvYqxC+iddNYFkj4pV2VERJZNVRNoQ1rUzTEZWZGGvzDIU79G8QpXhofx6eNJAarFEnQ4khnZk3g==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr2065933wmf.80.1568887158595;
        Thu, 19 Sep 2019 02:59:18 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.14])
        by smtp.googlemail.com with ESMTPSA id y186sm10037704wmb.41.2019.09.19.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:59:17 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Michael Chen <micchen@altera.com>, devel@driverdev.osuosl.org,
        dmaengine@vger.kernel.org
Subject: [PATCH RFC 2/2] staging: avalon-drv: Avalon DMA driver
Date:   Thu, 19 Sep 2019 11:59:13 +0200
Message-Id: <41c74d13f2555b4fd05c7307a70302e246f8b06c.1568817357.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568817357.git.a.gordeev.box@gmail.com>
References: <cover.1568817357.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is sample implementation of a driver that uses "avalon-dma"
driver interface to perform data transfers between on-chip and
system memory in devices using Avalon-MM DMA Interface for PCIe
design.

Companion user-level tool could be found at
git@github.com:a-gordeev/avalon-drv-tool.git

CC: Michael Chen <micchen@altera.com>
CC: devel@driverdev.osuosl.org
CC: dmaengine@vger.kernel.org

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/staging/Kconfig                       |   2 +
 drivers/staging/Makefile                      |   1 +
 drivers/staging/avalon-drv/Kconfig            |  34 +
 drivers/staging/avalon-drv/Makefile           |  14 +
 drivers/staging/avalon-drv/avalon-drv-dev.c   | 193 ++++++
 drivers/staging/avalon-drv/avalon-drv-ioctl.c | 137 ++++
 drivers/staging/avalon-drv/avalon-drv-ioctl.h |  12 +
 drivers/staging/avalon-drv/avalon-drv-mmap.c  |  93 +++
 drivers/staging/avalon-drv/avalon-drv-mmap.h  |  12 +
 .../staging/avalon-drv/avalon-drv-sg-buf.c    | 132 ++++
 .../staging/avalon-drv/avalon-drv-sg-buf.h    |  26 +
 drivers/staging/avalon-drv/avalon-drv-util.c  |  54 ++
 drivers/staging/avalon-drv/avalon-drv-util.h  |  12 +
 drivers/staging/avalon-drv/avalon-drv-xfer.c  | 655 ++++++++++++++++++
 drivers/staging/avalon-drv/avalon-drv-xfer.h  |  24 +
 drivers/staging/avalon-drv/avalon-drv.h       |  22 +
 include/uapi/linux/avalon-drv-ioctl.h         |  30 +
 17 files changed, 1453 insertions(+)
 create mode 100644 drivers/staging/avalon-drv/Kconfig
 create mode 100644 drivers/staging/avalon-drv/Makefile
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-dev.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-ioctl.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-ioctl.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-mmap.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-mmap.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-sg-buf.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-sg-buf.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-util.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-util.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-xfer.c
 create mode 100644 drivers/staging/avalon-drv/avalon-drv-xfer.h
 create mode 100644 drivers/staging/avalon-drv/avalon-drv.h
 create mode 100644 include/uapi/linux/avalon-drv-ioctl.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 31c732ececd1..6a4e9fdae9f6 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -122,4 +122,6 @@ source "drivers/staging/isdn/Kconfig"
 
 source "drivers/staging/avalon-dma/Kconfig"
 
+source "drivers/staging/avalon-drv/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index eb974cac85d3..e09e1aea1506 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -51,3 +51,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_ISDN_CAPI)		+= isdn/
 obj-$(CONFIG_AVALON_DMA)	+= avalon-dma/
+obj-$(CONFIG_AVALON_DRV)	+= avalon-drv/
diff --git a/drivers/staging/avalon-drv/Kconfig b/drivers/staging/avalon-drv/Kconfig
new file mode 100644
index 000000000000..18c43a65b6f5
--- /dev/null
+++ b/drivers/staging/avalon-drv/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA driver
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+config AVALON_DRV
+	depends on AVALON_DMA
+	tristate "Avalon DMA driver"
+	help
+	  This selects a driver for Avalon DMA
+
+config AVALON_DRV_PCI_VENDOR_ID
+	hex "PCI vendor ID"
+	default "0x1172"
+
+config AVALON_DRV_PCI_DEVICE_ID
+	hex "PCI device ID"
+	default "0xe003"
+
+config AVALON_DRV_PCI_BAR
+	int "PCI device BAR the Avalon DMA controller is mapped to"
+	range 0 5
+	default 0
+
+config AVALON_DRV_PCI_MSI_COUNT_ORDER
+	int "Count of MSIs the PCI device provides (order)"
+	range 0 5
+	default 5
+
+config AVALON_DRV_PCI_MSI_VECTOR
+	int "MSI vector the Avalon DMA controller uses in multi-MSI mode"
+	range 0 31
+	default 0
diff --git a/drivers/staging/avalon-drv/Makefile b/drivers/staging/avalon-drv/Makefile
new file mode 100644
index 000000000000..2e0f5f46488e
--- /dev/null
+++ b/drivers/staging/avalon-drv/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA driver
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+obj-$(CONFIG_AVALON_DRV)	+= avalon-drv.o
+
+avalon-drv-objs :=	avalon-drv-dev.o \
+			avalon-drv-ioctl.o \
+			avalon-drv-mmap.o \
+			avalon-drv-sg-buf.o \
+			avalon-drv-xfer.o \
+			avalon-drv-util.o
diff --git a/drivers/staging/avalon-drv/avalon-drv-dev.c b/drivers/staging/avalon-drv/avalon-drv-dev.c
new file mode 100644
index 000000000000..3c930770552f
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-dev.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "avalon-drv.h"
+#include "avalon-drv-ioctl.h"
+#include "avalon-drv-mmap.h"
+
+#define AVALON_DRV_PCI_VENDOR_ID	CONFIG_AVALON_DRV_PCI_VENDOR_ID
+#define AVALON_DRV_PCI_DEVICE_ID	CONFIG_AVALON_DRV_PCI_DEVICE_ID
+
+#define PCI_BAR			CONFIG_AVALON_DRV_PCI_BAR
+#define PCI_MSI_VECTOR		CONFIG_AVALON_DRV_PCI_MSI_VECTOR
+#define PCI_MSI_COUNT		BIT(CONFIG_AVALON_DRV_PCI_MSI_COUNT_ORDER)
+
+const struct file_operations avalon_dev_fops = {
+	.llseek		= generic_file_llseek,
+	.unlocked_ioctl	= avalon_dev_ioctl,
+	.mmap		= avalon_dev_mmap,
+};
+
+static int init_interrupts(struct pci_dev *pci_dev)
+{
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pci_dev,
+				    PCI_MSI_COUNT, PCI_MSI_COUNT,
+				    PCI_IRQ_MSI);
+	if (ret < 0) {
+		goto msi_err;
+	} else if (ret != PCI_MSI_COUNT) {
+		ret = -ENOSPC;
+		goto nr_msi_err;
+	}
+
+	ret = pci_irq_vector(pci_dev, PCI_MSI_VECTOR);
+	if (ret < 0)
+		goto vec_err;
+
+	return ret;
+
+vec_err:
+nr_msi_err:
+	pci_disable_msi(pci_dev);
+
+msi_err:
+	return ret;
+}
+
+static void term_interrupts(struct pci_dev *pci_dev)
+{
+	pci_disable_msi(pci_dev);
+}
+
+static int avalon_dev_register(struct avalon_dev *avalon_dev,
+			       const struct file_operations *fops)
+{
+	avalon_dev->misc_dev.minor	= MISC_DYNAMIC_MINOR;
+	avalon_dev->misc_dev.name	= DRIVER_NAME;
+	avalon_dev->misc_dev.nodename	= DRIVER_NAME;
+	avalon_dev->misc_dev.fops	= fops;
+	avalon_dev->misc_dev.mode	= 0644;
+
+	return misc_register(&avalon_dev->misc_dev);
+}
+
+static void avalon_dev_unregister(struct avalon_dev *avalon_dev)
+{
+	misc_deregister(&avalon_dev->misc_dev);
+}
+
+static int __init avalon_pci_probe(struct pci_dev *pci_dev,
+				   const struct pci_device_id *id)
+{
+	struct device *dev = &pci_dev->dev;
+	struct avalon_dev *avalon_dev;
+	void __iomem *regs;
+	int ret;
+
+	avalon_dev = kzalloc(sizeof(*avalon_dev), GFP_KERNEL);
+	if (!avalon_dev)
+		return -ENOMEM;
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		goto enable_err;
+
+	ret = pci_request_regions(pci_dev, DRIVER_NAME);
+	if (ret)
+		goto reg_err;
+
+	regs = pci_ioremap_bar(pci_dev, PCI_BAR);
+	if (!regs) {
+		ret = -ENOMEM;
+		goto ioremap_err;
+	}
+
+	ret = init_interrupts(pci_dev);
+	if (ret < 0)
+		goto int_err;
+
+	ret = avalon_dma_init(&avalon_dev->avalon_dma, dev, regs, ret);
+	if (ret)
+		goto dma_err;
+
+	ret = avalon_dev_register(avalon_dev, &avalon_dev_fops);
+	if (ret)
+		goto dev_reg_err;
+
+	pci_set_master(pci_dev);
+	pci_write_config_byte(pci_dev, PCI_INTERRUPT_LINE, pci_dev->irq);
+
+	avalon_dev->pci_dev = pci_dev;
+	pci_set_drvdata(pci_dev, avalon_dev);
+
+	return 0;
+
+	avalon_dev_unregister(avalon_dev);
+
+dev_reg_err:
+	avalon_dma_term(&avalon_dev->avalon_dma);
+
+dma_err:
+	term_interrupts(pci_dev);
+
+int_err:
+	pci_iounmap(pci_dev, regs);
+
+ioremap_err:
+	pci_release_regions(pci_dev);
+
+reg_err:
+	pci_disable_device(pci_dev);
+
+enable_err:
+	kfree(avalon_dev);
+
+	return ret;
+}
+
+static void __exit avalon_pci_remove(struct pci_dev *pci_dev)
+{
+	struct avalon_dev *avalon_dev = pci_get_drvdata(pci_dev);
+
+	pci_set_drvdata(pci_dev, NULL);
+
+	avalon_dev_unregister(avalon_dev);
+
+	avalon_dma_term(&avalon_dev->avalon_dma);
+
+	term_interrupts(pci_dev);
+
+	pci_release_regions(pci_dev);
+	pci_disable_device(pci_dev);
+
+	kfree(avalon_dev);
+}
+
+static struct pci_device_id pci_ids[] = {
+	{ PCI_DEVICE(AVALON_DRV_PCI_VENDOR_ID, AVALON_DRV_PCI_DEVICE_ID) },
+	{ 0 }
+};
+
+static struct pci_driver dma_driver_ops = {
+	.name		= DRIVER_NAME,
+	.id_table	= pci_ids,
+	.probe		= avalon_pci_probe,
+	.remove		= avalon_pci_remove,
+};
+
+static int __init avalon_drv_init(void)
+{
+	return pci_register_driver(&dma_driver_ops);
+}
+
+static void __exit avalon_drv_exit(void)
+{
+	pci_unregister_driver(&dma_driver_ops);
+}
+
+module_init(avalon_drv_init);
+module_exit(avalon_drv_exit);
+
+MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
+MODULE_DESCRIPTION("Avalon DMA control driver");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(pci, pci_ids);
diff --git a/drivers/staging/avalon-drv/avalon-drv-ioctl.c b/drivers/staging/avalon-drv/avalon-drv-ioctl.c
new file mode 100644
index 000000000000..ca68f3a3c697
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-ioctl.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/pci.h>
+#include <linux/uio.h>
+
+#include <uapi/linux/avalon-drv-ioctl.h>
+
+#include "avalon-drv.h"
+#include "avalon-drv-xfer.h"
+
+static const gfp_t gfp_flags = GFP_KERNEL;
+
+long avalon_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct avalon_dev *avalon_dev = container_of(file->private_data,
+		struct avalon_dev, misc_dev);
+	struct device *dev = &avalon_dev->pci_dev->dev;
+	struct iovec iovec[2];
+	void __user *buf = NULL, __user *buf_rd = NULL, __user *buf_wr = NULL;
+	size_t len = 0, len_rd = 0, len_wr = 0;
+	int ret = 0;
+
+	dev_dbg(dev, "%s(%d) { cmd %x", __FUNCTION__, __LINE__, cmd);
+
+	switch (cmd) {
+	case IOCTL_AVALON_GET_INFO: {
+		struct avalon_ioc_info info = {
+			.mem_addr	= TARGET_MEM_BASE,
+			.mem_size	= TARGET_MEM_SIZE,
+			.dma_size	= TARGET_DMA_SIZE,
+			.dma_size_sg	= TARGET_DMA_SIZE_SG,
+		};
+
+		if (copy_to_user((void *)arg, &info, sizeof(info))) {
+			ret = -EFAULT;
+			goto done;
+		}
+
+		goto done;
+	}
+	case IOCTL_AVALON_SET_INFO:
+		ret = -EINVAL;
+		goto done;
+
+	case IOCTL_AVALON_DMA_READ:
+	case IOCTL_AVALON_DMA_WRITE:
+	case IOCTL_AVALON_DMA_READ_SG:
+	case IOCTL_AVALON_DMA_WRITE_SG:
+	case IOCTL_AVALON_DMA_READ_SG_SMP:
+	case IOCTL_AVALON_DMA_WRITE_SG_SMP:
+		if (copy_from_user(iovec, (void *)arg, sizeof(iovec[0]))) {
+			ret = -EFAULT;
+			goto done;
+		}
+
+		buf = iovec[0].iov_base;
+		len = iovec[0].iov_len;
+
+		break;
+
+	case IOCTL_AVALON_DMA_RDWR:
+	case IOCTL_AVALON_DMA_RDWR_SG:
+		if (copy_from_user(iovec, (void *)arg, sizeof(iovec))) {
+			ret = -EFAULT;
+			goto done;
+		}
+
+		buf_rd = iovec[0].iov_base;
+		len_rd = iovec[0].iov_len;
+
+		buf_wr = iovec[1].iov_base;
+		len_wr = iovec[1].iov_len;
+
+		break;
+
+	default:
+		ret = -EINVAL;
+		goto done;
+	};
+
+	dev_dbg(dev,
+		"%s(%d) buf %px len %ld\nbuf_rd %px len_rd %ld\nbuf_wr %px len_wr %ld\n",
+		__FUNCTION__, __LINE__, buf, len, buf_rd, len_rd, buf_wr, len_wr);
+
+	switch (cmd) {
+	case IOCTL_AVALON_DMA_READ:
+		ret = xfer_rw(&avalon_dev->avalon_dma,
+			      DMA_FROM_DEVICE, buf, len);
+		break;
+	case IOCTL_AVALON_DMA_WRITE:
+		ret = xfer_rw(&avalon_dev->avalon_dma,
+			      DMA_TO_DEVICE, buf, len);
+		break;
+	case IOCTL_AVALON_DMA_RDWR:
+		ret = xfer_simultaneous(&avalon_dev->avalon_dma,
+					buf_rd, len_rd,
+					buf_wr, len_wr);
+		break;
+
+	case IOCTL_AVALON_DMA_READ_SG:
+		ret = xfer_rw_sg(&avalon_dev->avalon_dma,
+				 DMA_FROM_DEVICE, buf, len, false);
+		break;
+	case IOCTL_AVALON_DMA_WRITE_SG:
+		ret = xfer_rw_sg(&avalon_dev->avalon_dma,
+				 DMA_TO_DEVICE, buf, len, false);
+		break;
+	case IOCTL_AVALON_DMA_READ_SG_SMP:
+		ret = xfer_rw_sg(&avalon_dev->avalon_dma,
+				 DMA_FROM_DEVICE, buf, len, true);
+		break;
+	case IOCTL_AVALON_DMA_WRITE_SG_SMP:
+		ret = xfer_rw_sg(&avalon_dev->avalon_dma,
+				 DMA_TO_DEVICE, buf, len, true);
+		break;
+	case IOCTL_AVALON_DMA_RDWR_SG:
+		ret = xfer_simultaneous_sg(&avalon_dev->avalon_dma,
+					   buf_rd, len_rd,
+					   buf_wr, len_wr);
+		break;
+
+	default:
+		BUG();
+		ret = -EINVAL;
+	};
+
+done:
+	dev_dbg(dev, "%s(%d) } = %d", __FUNCTION__, __LINE__, ret);
+
+	return ret;
+}
diff --git a/drivers/staging/avalon-drv/avalon-drv-ioctl.h b/drivers/staging/avalon-drv/avalon-drv-ioctl.h
new file mode 100644
index 000000000000..149428c25c2b
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-ioctl.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DRV_IOCTL_H__
+#define __AVALON_DRV_IOCTL_H__
+
+long avalon_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+#endif
diff --git a/drivers/staging/avalon-drv/avalon-drv-mmap.c b/drivers/staging/avalon-drv/avalon-drv-mmap.c
new file mode 100644
index 000000000000..7af2f70c961e
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-mmap.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/pci.h>
+
+#include "avalon-drv.h"
+#include "avalon-drv-sg-buf.h"
+
+const gfp_t gfp_flags = GFP_KERNEL;
+
+static void avalon_drv_vm_close(struct vm_area_struct *vma)
+{
+	struct dma_sg_buf *sg_buf = vma->vm_private_data;
+	struct device *dev = sg_buf->dev;
+
+	dev_dbg(dev, "%s(%d) vma %px sg_buf %px",
+		__FUNCTION__, __LINE__, vma, sg_buf);
+
+	dma_sg_buf_free(sg_buf);
+}
+
+static const struct vm_operations_struct avalon_drv_vm_ops = {
+	.close	= avalon_drv_vm_close,
+};
+
+int avalon_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct avalon_dev *avalon_dev = container_of(file->private_data,
+		struct avalon_dev, misc_dev);
+	struct device *dev = &avalon_dev->pci_dev->dev;
+	unsigned long addr = vma->vm_start;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	enum dma_data_direction dir;
+	struct dma_sg_buf *sg_buf;
+	int ret;
+	int i;
+
+	dev_dbg(dev, "%s(%d) { vm_pgoff %08lx vm_flags %08lx, size %lu",
+		__FUNCTION__, __LINE__, vma->vm_pgoff, vma->vm_flags, size);
+
+	if (!(IS_ALIGNED(addr, PAGE_SIZE) && IS_ALIGNED(size, PAGE_SIZE)))
+		return -EINVAL;
+	if ((vma->vm_pgoff * PAGE_SIZE + size) > TARGET_MEM_SIZE)
+		return -EINVAL;
+	if (!(((vma->vm_flags & (VM_READ | VM_WRITE)) == VM_READ) ||
+	      ((vma->vm_flags & (VM_READ | VM_WRITE)) == VM_WRITE)))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	vma->vm_ops = &avalon_drv_vm_ops;
+
+	if (vma->vm_flags & VM_WRITE)
+		dir = DMA_TO_DEVICE;
+	else
+		dir = DMA_FROM_DEVICE;
+
+	sg_buf = dma_sg_buf_alloc(dev, size, dir, gfp_flags);
+	if (IS_ERR(sg_buf)) {
+		ret = PTR_ERR(sg_buf);
+		goto sg_buf_alloc_err;
+	}
+
+	for (i = 0; size > 0; i++) {
+		ret = vm_insert_page(vma, addr, sg_buf->pages[i]);
+		if (ret)
+			goto ins_page_err;
+
+		addr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	};
+
+	vma->vm_private_data = sg_buf;
+
+	dev_dbg(dev, "%s(%d) } vma %px sg_buf %px",
+		__FUNCTION__, __LINE__, vma, sg_buf);
+
+	return 0;
+
+ins_page_err:
+	dma_sg_buf_free(sg_buf);
+
+sg_buf_alloc_err:
+	dev_dbg(dev, "%s(%d) } vma %px err %d",
+		__FUNCTION__, __LINE__, vma, ret);
+
+	return ret;
+}
diff --git a/drivers/staging/avalon-drv/avalon-drv-mmap.h b/drivers/staging/avalon-drv/avalon-drv-mmap.h
new file mode 100644
index 000000000000..8ec7d9692217
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-mmap.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DRV_MMAP_H__
+#define __AVALON_DRV_MMAP_H__
+
+int avalon_dev_mmap(struct file *file, struct vm_area_struct *vma);
+
+#endif
diff --git a/drivers/staging/avalon-drv/avalon-drv-sg-buf.c b/drivers/staging/avalon-drv/avalon-drv-sg-buf.c
new file mode 100644
index 000000000000..f8d76a055bba
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-sg-buf.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+#include "avalon-drv-sg-buf.h"
+
+static int dma_sg_alloc_compacted(struct dma_sg_buf *buf, gfp_t gfp_flags)
+{
+	unsigned int last_page = 0;
+	int size = buf->size;
+
+	while (size > 0) {
+		struct page *pages;
+		int order;
+		int i;
+
+		order = get_order(size);
+		/* Dont over allocate*/
+		if ((PAGE_SIZE << order) > size)
+			order--;
+
+		pages = NULL;
+		while (!pages) {
+			pages = alloc_pages(gfp_flags | __GFP_NOWARN, order);
+			if (pages)
+				break;
+
+			if (order == 0) {
+				while (last_page--)
+					__free_page(buf->pages[last_page]);
+				return -ENOMEM;
+			}
+			order--;
+		}
+
+		split_page(pages, order);
+		for (i = 0; i < (1 << order); i++)
+			buf->pages[last_page++] = &pages[i];
+
+		size -= PAGE_SIZE << order;
+	}
+
+	return 0;
+}
+
+struct dma_sg_buf *dma_sg_buf_alloc(struct device *dev,
+				    unsigned long size,
+				    enum dma_data_direction dma_dir,
+				    gfp_t gfp_flags)
+{
+	struct dma_sg_buf *buf;
+	struct sg_table *sgt;
+	int ret;
+	int num_pages;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	buf->dma_dir = dma_dir;
+	buf->size = size;
+	/* size is already page aligned */
+	buf->num_pages = size >> PAGE_SHIFT;
+
+	buf->pages = kvmalloc_array(buf->num_pages, sizeof(struct page *),
+				    GFP_KERNEL | __GFP_ZERO);
+	if (!buf->pages)
+		goto fail_pages_array_alloc;
+
+	ret = dma_sg_alloc_compacted(buf, gfp_flags);
+	if (ret)
+		goto fail_pages_alloc;
+
+	ret = sg_alloc_table_from_pages(&buf->sgt, buf->pages,
+					buf->num_pages, 0, size,
+					GFP_KERNEL);
+	if (ret)
+		goto fail_table_alloc;
+
+	buf->dev = get_device(dev);
+
+	sgt = &buf->sgt;
+
+	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+	if (!sgt->nents)
+		goto fail_map;
+
+	buf->vaddr = vm_map_ram(buf->pages, buf->num_pages, -1, PAGE_KERNEL);
+	if (!buf->vaddr)
+		goto fail_vm_map;
+
+	return buf;
+
+fail_vm_map:
+	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+			   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+fail_map:
+	put_device(buf->dev);
+	sg_free_table(&buf->sgt);
+fail_table_alloc:
+	num_pages = buf->num_pages;
+	while (num_pages--)
+		__free_page(buf->pages[num_pages]);
+fail_pages_alloc:
+	kvfree(buf->pages);
+fail_pages_array_alloc:
+	kfree(buf);
+	return ERR_PTR(-ENOMEM);
+}
+
+void dma_sg_buf_free(struct dma_sg_buf *buf)
+{
+	struct sg_table *sgt = &buf->sgt;
+	int i = buf->num_pages;
+
+	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+			   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+	vm_unmap_ram(buf->vaddr, buf->num_pages);
+	sg_free_table(&buf->sgt);
+	while (--i >= 0)
+		__free_page(buf->pages[i]);
+	kvfree(buf->pages);
+	put_device(buf->dev);
+	kfree(buf);
+}
diff --git a/drivers/staging/avalon-drv/avalon-drv-sg-buf.h b/drivers/staging/avalon-drv/avalon-drv-sg-buf.h
new file mode 100644
index 000000000000..538f9329f8df
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-sg-buf.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DRV_SG_BUF_H__
+#define __AVALON_DRV_SG_BUF_H__
+
+struct dma_sg_buf {
+	struct device			*dev;
+	void				*vaddr;
+	struct page			**pages;
+	enum dma_data_direction		dma_dir;
+	struct sg_table			sgt;
+	size_t				size;
+	unsigned int			num_pages;
+};
+
+struct dma_sg_buf *dma_sg_buf_alloc(struct device *dev,
+				    unsigned long size,
+				    enum dma_data_direction dma_dir,
+				    gfp_t gfp_flags);
+void dma_sg_buf_free(struct dma_sg_buf *buf);
+
+#endif
diff --git a/drivers/staging/avalon-drv/avalon-drv-util.c b/drivers/staging/avalon-drv/avalon-drv-util.c
new file mode 100644
index 000000000000..b7ca5aa495d2
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-util.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/device.h>
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+static int print_mem(char *buf, size_t buf_len,
+		     const void *mem, size_t mem_len)
+{
+	int ret, i, total = 0;
+
+	if (buf_len < 3)
+		return -EINVAL;
+
+	mem_len = min_t(size_t, mem_len, buf_len / 3);
+	for (i = 0; i < mem_len; i++) {
+		ret = snprintf(buf + total, buf_len - total,
+			       "%02X ", ((const unsigned char *)mem)[i]);
+		if (ret < 0) {
+			strcpy(buf, "--");
+			return ret;
+		}
+		total += ret;
+	}
+
+	buf[total] = 0;
+
+	return total;
+}
+
+void dump_mem(struct device *dev, void *data, size_t len)
+{
+	char buf[256];
+	int n;
+
+	n = snprintf(buf, sizeof(buf),
+		     "%s(%d): %px [ ",
+		     __FUNCTION__, __LINE__, data);
+
+	print_mem(buf + n, sizeof(buf) - n, data, len);
+
+	dev_dbg(dev, "%s(%d): %s]\n", __FUNCTION__, __LINE__, buf);
+}
+#else
+void dump_mem(struct device *dev, void *data, size_t len)
+{
+}
+#endif
diff --git a/drivers/staging/avalon-drv/avalon-drv-util.h b/drivers/staging/avalon-drv/avalon-drv-util.h
new file mode 100644
index 000000000000..113115b7e59d
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-util.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DRV_UTIL_H__
+#define __AVALON_DRV_UTIL_H__
+
+void dump_mem(struct device *dev, void *data, size_t len);
+
+#endif
diff --git a/drivers/staging/avalon-drv/avalon-drv-xfer.c b/drivers/staging/avalon-drv/avalon-drv-xfer.c
new file mode 100644
index 000000000000..a4e305708308
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-xfer.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/uaccess.h>
+#include <linux/kthread.h>
+#include <linux/sched/signal.h>
+
+#include "avalon-drv.h"
+#include "avalon-drv-sg-buf.h"
+#include "avalon-drv-util.h"
+
+static const gfp_t gfp_flags	= GFP_KERNEL;
+static const size_t dma_size	= TARGET_DMA_SIZE;
+static const int nr_dma_reps	= 2;
+static const int dmas_per_cpu	= 8;
+
+char *__dir_str[] = {
+	[DMA_BIDIRECTIONAL]	= "DMA_BIDIRECTIONAL",
+	[DMA_TO_DEVICE]		= "DMA_TO_DEVICE",
+	[DMA_FROM_DEVICE]	= "DMA_FROM_DEVICE",
+	[DMA_NONE]		= "DMA_NONE",
+};
+
+struct xfer_callback_info {
+	struct device *dev;
+	struct completion completion;
+	atomic_t counter;
+	ktime_t kt_start;
+};
+
+static void init_callback_info(struct xfer_callback_info *info,
+			       struct device *dev,
+			       int value)
+{
+	info->dev = dev;
+	init_completion(&info->completion);
+
+	atomic_set(&info->counter, value);
+	smp_wmb();
+
+	info->kt_start = ktime_get();
+}
+
+static int xfer_callback(struct xfer_callback_info *info, const char *pfx)
+{
+	s64 time_us = ktime_us_delta(ktime_get(), info->kt_start);
+	int ret;
+
+	smp_rmb();
+	if (atomic_dec_and_test(&info->counter)) {
+		complete(&info->completion);
+		ret = 0;
+	} else {
+		ret = 1;
+	}
+
+	dev_dbg(info->dev, "%s_%s(%d) done = %d in %lli us",
+		pfx, __FUNCTION__, __LINE__, ret, time_us);
+
+	return ret;
+}
+
+static void rd_xfer_callback(void *dma_async_param)
+{
+	struct xfer_callback_info *info = dma_async_param;
+
+	xfer_callback(info, "rd");
+
+}
+
+static void wr_xfer_callback(void *dma_async_param)
+{
+	struct xfer_callback_info *info = dma_async_param;
+
+	xfer_callback(info, "wr");
+}
+
+int xfer_rw(struct avalon_dma *avalon_dma,
+	    enum dma_data_direction dir,
+	    void __user *user_buf, size_t user_len)
+{
+	struct device *dev = avalon_dma->dev;
+	dma_addr_t dma_addr;
+	void *buf;
+	struct xfer_callback_info info;
+	void (*xfer_callback)(void *dma_async_param);
+	int ret;
+	int i;
+
+	const size_t size = dma_size;
+	const int nr_reps = nr_dma_reps;
+
+	dev_dbg(dev, "%s(%d) { dir %s",
+		__FUNCTION__, __LINE__, __dir_str[dir]);
+
+	if (user_len < size) {
+		ret = -EINVAL;
+		goto mem_len_err;
+	} else {
+		user_len = size;
+	}
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		xfer_callback = wr_xfer_callback;
+		break;
+	case DMA_FROM_DEVICE:
+		xfer_callback = rd_xfer_callback;
+		break;
+	default:
+		BUG();
+		ret = -EINVAL;
+		goto dma_dir_err;
+	}
+
+	buf = kmalloc(size, gfp_flags);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto mem_alloc_err;
+	}
+
+	memset(buf, 0, size);
+
+	if (dir == DMA_TO_DEVICE) {
+		if (copy_from_user(buf, user_buf, user_len)) {
+			ret = -EFAULT;
+			goto cp_from_user_err;
+		}
+	}
+
+	dma_addr = dma_map_single(dev, buf, size, dir);
+	if (dma_mapping_error(dev, dma_addr)) {
+		ret = -ENOMEM;
+		goto dma_alloc_err;
+	}
+
+	init_callback_info(&info, dev, nr_reps);
+
+	dev_dbg(dev, "%s(%d) dma_addr %08llx size %lu dir %d reps = %d",
+		__FUNCTION__, __LINE__, dma_addr, size, dir, nr_reps);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = avalon_dma_submit_xfer(avalon_dma,
+					     dir,
+					     TARGET_MEM_BASE,
+					     dma_addr, size,
+					     xfer_callback, &info);
+		if (ret)
+			goto dma_submit_err;
+	}
+
+	ret = avalon_dma_issue_pending(avalon_dma);
+	if (ret)
+		goto issue_pending_err;
+
+	ret = wait_for_completion_interruptible(&info.completion);
+	if (ret)
+		goto wait_err;
+
+	if (dir == DMA_FROM_DEVICE) {
+		if (copy_to_user(user_buf, buf, user_len))
+			ret = -EFAULT;
+	}
+
+wait_err:
+issue_pending_err:
+dma_submit_err:
+	dma_unmap_single(dev, dma_addr, size, dir);
+
+dma_alloc_err:
+cp_from_user_err:
+	kfree(buf);
+
+mem_alloc_err:
+dma_dir_err:
+mem_len_err:
+	dev_dbg(dev, "%s(%d) } = %d", __FUNCTION__, __LINE__, ret);
+
+	return ret;
+}
+
+int xfer_simultaneous(struct avalon_dma *avalon_dma,
+		      void __user *user_buf_rd, size_t user_len_rd,
+		      void __user *user_buf_wr, size_t user_len_wr)
+{
+	struct device *dev = avalon_dma->dev;
+	dma_addr_t dma_addr_rd, dma_addr_wr;
+	void *buf_rd, *buf_wr;
+	struct xfer_callback_info info;
+	int ret;
+	int i;
+
+	const size_t size = dma_size;
+	const dma_addr_t target_rd = TARGET_MEM_BASE;
+	const dma_addr_t target_wr = target_rd + size;
+	const int nr_reps = nr_dma_reps;
+
+	dev_dbg(dev, "%s(%d) {", __FUNCTION__, __LINE__);
+
+	if (user_len_rd < size) {
+		ret = -EINVAL;
+		goto mem_len_err;
+	} else {
+		user_len_rd = size;
+	}
+
+	if (user_len_wr < size) {
+		ret = -EINVAL;
+		goto mem_len_err;
+	} else {
+		user_len_wr = size;
+	}
+
+	buf_rd = kmalloc(size, gfp_flags);
+	if (!buf_rd) {
+		ret = -ENOMEM;
+		goto rd_mem_alloc_err;
+	}
+
+	buf_wr = kmalloc(size, gfp_flags);
+	if (!buf_wr) {
+		ret = -ENOMEM;
+		goto wr_mem_alloc_err;
+	}
+
+	memset(buf_rd, 0, size);
+	memset(buf_wr, 0, size);
+
+	if (copy_from_user(buf_wr, user_buf_wr, user_len_wr)) {
+		ret = -EFAULT;
+		goto cp_from_user_err;
+	}
+
+	dma_addr_rd = dma_map_single(dev, buf_rd, size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, dma_addr_rd)) {
+		ret = -ENOMEM;
+		goto rd_dma_map_err;
+	}
+
+	dma_addr_wr = dma_map_single(dev, buf_wr, size, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma_addr_rd)) {
+		ret = -ENOMEM;
+		goto wr_dma_map_err;
+	}
+
+	init_callback_info(&info, dev, 2 * nr_reps);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = avalon_dma_submit_xfer(avalon_dma,
+					     DMA_TO_DEVICE,
+					     target_wr, dma_addr_wr, size,
+					     wr_xfer_callback, &info);
+		if (ret)
+			goto rd_dma_submit_err;
+
+		ret = avalon_dma_submit_xfer(avalon_dma,
+					     DMA_FROM_DEVICE,
+					     target_rd, dma_addr_rd, size,
+					     rd_xfer_callback, &info);
+		BUG_ON(ret);
+		if (ret)
+			goto wr_dma_submit_err;
+	}
+
+	ret = avalon_dma_issue_pending(avalon_dma);
+	BUG_ON(ret);
+	if (ret)
+		goto issue_pending_err;
+
+	dev_dbg(dev,
+		"%s(%d) dma_addr %08llx/%08llx rd_size %lu wr_size %lu",
+		__FUNCTION__, __LINE__,
+		dma_addr_rd, dma_addr_wr, size, size);
+
+	ret = wait_for_completion_interruptible(&info.completion);
+	if (ret)
+		goto wait_err;
+
+	if (copy_to_user(user_buf_rd, buf_rd, user_len_rd))
+		ret = -EFAULT;
+
+wait_err:
+issue_pending_err:
+wr_dma_submit_err:
+rd_dma_submit_err:
+	dma_unmap_single(dev, dma_addr_wr, size, DMA_TO_DEVICE);
+
+wr_dma_map_err:
+	dma_unmap_single(dev, dma_addr_rd, size, DMA_FROM_DEVICE);
+
+rd_dma_map_err:
+cp_from_user_err:
+	kfree(buf_wr);
+
+wr_mem_alloc_err:
+	kfree(buf_rd);
+
+rd_mem_alloc_err:
+mem_len_err:
+	dev_dbg(dev, "%s(%d) } = %d", __FUNCTION__, __LINE__, ret);
+
+	return ret;
+}
+
+static int kthread_xfer_rw_sg(struct avalon_dma *avalon_dma,
+			      enum dma_data_direction dir,
+			      dma_addr_t dev_addr, struct sg_table *sgt,
+			      void (*xfer_callback)(void *dma_async_param))
+{
+	struct device *dev = avalon_dma->dev;
+	struct xfer_callback_info info;
+	int ret = 0;
+	int i;
+
+	const int nr_reps = nr_dma_reps;
+
+	while (!kthread_should_stop()) {
+		init_callback_info(&info, dev, nr_reps);
+
+		for (i = 0; i < nr_reps; i++) {
+			ret = avalon_dma_submit_xfer_sg(avalon_dma,
+							dir,
+							dev_addr, sgt,
+							xfer_callback, &info);
+			if (ret) {
+				/*
+				 * Ideally, kind of avalon_dma_cancel() should
+				 * be called here to avoid running out of descs
+				 * (ones stuck in "submitted" list since it
+				 * never gets processed)
+				 *
+				 * However, a call to avalon_dma_issue_pending()
+				 * would do the job and let all outstanding
+				 * descs processed and moved back to "allocated"
+				 * queue in the end of the day.
+				 *
+				 * Leave it as is as a showcase of "allocated"
+				 * list empty and "submitted" list full and
+				 * unprocessed.
+				 */
+				goto err;
+			}
+		}
+
+		ret = avalon_dma_issue_pending(avalon_dma);
+		if (ret)
+			goto err;
+
+		ret = wait_for_completion_interruptible(&info.completion);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	dev_dbg(dev, "%s(%d) cpu %d avalon_dma_submit_xfer_sg() %d",
+		__FUNCTION__, __LINE__, smp_processor_id(), ret);
+
+	while (!kthread_should_stop())
+		cond_resched();
+
+	return ret;
+}
+
+struct kthread_xfer_rw_sg_data {
+	struct avalon_dma *avalon_dma;
+	enum dma_data_direction dir;
+	dma_addr_t dev_addr;
+	struct sg_table *sgt;
+	void (*xfer_callback)(void *dma_async_param);
+};
+
+static int __kthread_xfer_rw_sg(void *_data)
+{
+	struct kthread_xfer_rw_sg_data *data = _data;
+
+	return kthread_xfer_rw_sg(data->avalon_dma,
+				  data->dir,
+				  data->dev_addr, data->sgt,
+				  data->xfer_callback);
+}
+
+static int __xfer_rw_sg_smp(struct avalon_dma *avalon_dma,
+			    enum dma_data_direction dir,
+			    dma_addr_t dev_addr, struct sg_table *sgt,
+			    void (*xfer_callback)(void *dma_async_param))
+{
+	struct kthread_xfer_rw_sg_data data = {
+		avalon_dma,
+		dir,
+		dev_addr,
+		sgt,
+		xfer_callback
+	};
+	struct task_struct *task;
+	struct task_struct **tasks;
+	int nr_tasks = dmas_per_cpu * num_online_cpus();
+	int n, cpu;
+	int ret = 0;
+	int i = 0;
+
+	tasks = kmalloc(sizeof(tasks[0]) * nr_tasks, GFP_KERNEL);
+	if (!tasks)
+		return -ENOMEM;
+
+	for (n = 0; n < dmas_per_cpu; n++) {
+		for_each_online_cpu(cpu) {
+			if (i >= nr_tasks) {
+				ret = -ENOMEM;
+				goto kthread_err;
+			}
+
+			task = kthread_create(__kthread_xfer_rw_sg,
+					      &data, "av-dma-sg-%d-%d", cpu, n);
+			if (IS_ERR(task)) {
+				ret = PTR_ERR(task);
+				goto kthread_err;
+			}
+
+			kthread_bind(task, cpu);
+
+			tasks[i] = task;
+			i++;
+		}
+	}
+
+	for (i = 0; i < nr_tasks; i++)
+		wake_up_process(tasks[i]);
+
+	/*
+	 * Run child kthreads until user sent a signal (i.e Ctrl+C)
+	 * and clear the signal to avid user program from being killed.
+	 */
+	schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
+	flush_signals(current);
+
+kthread_err:
+	for (i = 0; i < nr_tasks; i++)
+		kthread_stop(tasks[i]);
+
+	kfree(tasks);
+
+	return ret;
+}
+
+static int __xfer_rw_sg(struct avalon_dma *avalon_dma,
+			enum dma_data_direction dir,
+			dma_addr_t dev_addr, struct sg_table *sgt,
+			void (*xfer_callback)(void *dma_async_param))
+{
+	struct device *dev = avalon_dma->dev;
+	struct xfer_callback_info info;
+	int ret = 0;
+	int i;
+
+	const int nr_reps = nr_dma_reps;
+
+	init_callback_info(&info, dev, nr_reps);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = avalon_dma_submit_xfer_sg(avalon_dma,
+						dir,
+						dev_addr, sgt,
+						xfer_callback, &info);
+		if (ret)
+			return ret;
+	}
+
+	ret = avalon_dma_issue_pending(avalon_dma);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_interruptible(&info.completion);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct vm_area_struct *get_vma(unsigned long addr,
+				      unsigned long size)
+{
+	struct vm_area_struct *vma;
+	unsigned long vm_size;
+
+	vma = find_vma(current->mm, addr);
+	if (!vma || (vma->vm_start != addr))
+		return ERR_PTR(-ENXIO);
+
+	vm_size = vma->vm_end - vma->vm_start;
+	if (size > vm_size)
+		return ERR_PTR(-EINVAL);
+
+	return vma;
+}
+
+int xfer_rw_sg(struct avalon_dma *avalon_dma,
+	       enum dma_data_direction dir,
+	       void __user *user_buf, size_t user_len,
+	       bool is_smp)
+{
+	struct device *dev = avalon_dma->dev;
+	int (*xfer)(struct avalon_dma *avalon_dma,
+		    enum dma_data_direction dir,
+		    dma_addr_t dev_addr,
+		    struct sg_table *sgt,
+		    void (*xfer_callback)(void *dma_async_param));
+	void (*xfer_callback)(void *dma_async_param);
+	struct vm_area_struct *vma;
+	struct dma_sg_buf *sg_buf;
+	dma_addr_t dma_addr;
+	int ret;
+
+	dev_dbg(dev, "%s(%d) { dir %s smp %d",
+		__FUNCTION__, __LINE__, __dir_str[dir], is_smp);
+
+	vma = get_vma((unsigned long)user_buf, user_len);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
+
+	sg_buf = vma->vm_private_data;
+	if (dir != sg_buf->dma_dir)
+		return -EINVAL;
+
+	if (is_smp)
+		xfer = __xfer_rw_sg_smp;
+	else
+		xfer = __xfer_rw_sg;
+
+	if (dir == DMA_FROM_DEVICE)
+		xfer_callback = rd_xfer_callback;
+	else
+		xfer_callback = wr_xfer_callback;
+
+	dma_addr = TARGET_MEM_BASE + vma->vm_pgoff * PAGE_SIZE;
+
+	if (dir == DMA_TO_DEVICE)
+		dump_mem(dev, sg_buf->vaddr, 16);
+
+	dma_sync_sg_for_device(dev,
+			       sg_buf->sgt.sgl, sg_buf->sgt.nents,
+			       sg_buf->dma_dir);
+
+	ret = xfer(avalon_dma, dir, dma_addr, &sg_buf->sgt, xfer_callback);
+	if (ret)
+		goto xfer_err;
+
+	dma_sync_sg_for_cpu(dev,
+			    sg_buf->sgt.sgl, sg_buf->sgt.nents,
+			    sg_buf->dma_dir);
+
+	if (dir == DMA_FROM_DEVICE)
+		dump_mem(dev, sg_buf->vaddr, 16);
+
+xfer_err:
+	dev_dbg(dev, "%s(%d) } = %d", __FUNCTION__, __LINE__, ret);
+
+	return ret;
+}
+
+int xfer_simultaneous_sg(struct avalon_dma *avalon_dma,
+			 void __user *user_buf_rd, size_t user_len_rd,
+			 void __user *user_buf_wr, size_t user_len_wr)
+{
+	struct device *dev = avalon_dma->dev;
+	dma_addr_t dma_addr_rd, dma_addr_wr;
+	struct xfer_callback_info info;
+	struct vm_area_struct *vma_rd, *vma_wr;
+	struct dma_sg_buf *sg_buf_rd, *sg_buf_wr;
+	int ret;
+	int i;
+
+	const int nr_reps = nr_dma_reps;
+
+	dev_dbg(dev, "%s(%d) {", __FUNCTION__, __LINE__);
+
+	vma_rd = get_vma((unsigned long)user_buf_rd, user_len_rd);
+	if (IS_ERR(vma_rd))
+		return PTR_ERR(vma_rd);
+
+	vma_wr = get_vma((unsigned long)user_buf_wr, user_len_wr);
+	if (IS_ERR(vma_wr))
+		return PTR_ERR(vma_wr);
+
+	sg_buf_rd = vma_rd->vm_private_data;
+	sg_buf_wr = vma_wr->vm_private_data;
+
+	if ((sg_buf_rd->dma_dir != DMA_FROM_DEVICE) ||
+	    (sg_buf_wr->dma_dir != DMA_TO_DEVICE))
+		return -EINVAL;
+
+	dma_addr_rd = TARGET_MEM_BASE + vma_rd->vm_pgoff * PAGE_SIZE;
+	dma_addr_wr = TARGET_MEM_BASE + vma_wr->vm_pgoff * PAGE_SIZE;
+
+	init_callback_info(&info, dev, 2 * nr_reps);
+
+	dma_sync_sg_for_device(dev,
+			       sg_buf_rd->sgt.sgl,
+			       sg_buf_rd->sgt.nents,
+			       DMA_FROM_DEVICE);
+	dma_sync_sg_for_device(dev,
+			       sg_buf_wr->sgt.sgl,
+			       sg_buf_wr->sgt.nents,
+			       DMA_TO_DEVICE);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = avalon_dma_submit_xfer_sg(avalon_dma,
+						DMA_TO_DEVICE,
+						dma_addr_wr,
+						&sg_buf_wr->sgt,
+						wr_xfer_callback, &info);
+		if (ret)
+			goto dma_submit_rd_err;
+
+		ret = avalon_dma_submit_xfer_sg(avalon_dma,
+						DMA_FROM_DEVICE,
+						dma_addr_rd,
+						&sg_buf_rd->sgt,
+						rd_xfer_callback, &info);
+		if (ret)
+			goto dma_submit_wr_err;
+	}
+
+	ret = avalon_dma_issue_pending(avalon_dma);
+	if (ret)
+		goto issue_pending_err;
+
+	ret = wait_for_completion_interruptible(&info.completion);
+	if (ret)
+		goto wait_err;
+
+	dma_sync_sg_for_cpu(dev,
+			    sg_buf_rd->sgt.sgl,
+			    sg_buf_rd->sgt.nents,
+			    DMA_FROM_DEVICE);
+	dma_sync_sg_for_cpu(dev,
+			    sg_buf_wr->sgt.sgl,
+			    sg_buf_wr->sgt.nents,
+			    DMA_TO_DEVICE);
+
+wait_err:
+issue_pending_err:
+dma_submit_wr_err:
+dma_submit_rd_err:
+	dev_dbg(dev, "%s(%d) } = %d", __FUNCTION__, __LINE__, ret);
+
+	return ret;
+}
diff --git a/drivers/staging/avalon-drv/avalon-drv-xfer.h b/drivers/staging/avalon-drv/avalon-drv-xfer.h
new file mode 100644
index 000000000000..5bd76cc393d3
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv-xfer.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DRV_XFER_H__
+#define __AVALON_DRV_XFER_H__
+
+int xfer_rw(struct avalon_dma *avalon_dma,
+	    enum dma_data_direction dir,
+	    void __user *user_buf, size_t user_len);
+int xfer_simultaneous(struct avalon_dma *avalon_dma,
+		      void __user *user_buf_rd, size_t user_len_rd,
+		      void __user *user_buf_wr, size_t user_len_wr);
+int xfer_rw_sg(struct avalon_dma *avalon_dma,
+	       enum dma_data_direction dir,
+	       void __user *user_buf, size_t user_len,
+	       bool is_smp);
+int xfer_simultaneous_sg(struct avalon_dma *avalon_dma,
+			 void __user *user_buf_rd, size_t user_len_rd,
+			 void __user *user_buf_wr, size_t user_len_wr);
+
+#endif
diff --git a/drivers/staging/avalon-drv/avalon-drv.h b/drivers/staging/avalon-drv/avalon-drv.h
new file mode 100644
index 000000000000..290c75ba4c77
--- /dev/null
+++ b/drivers/staging/avalon-drv/avalon-drv.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DRV_H__
+#define __AVALON_DRV_H__
+
+#include <linux/miscdevice.h>
+
+#include <linux/avalon-dma.h>
+
+#define DRIVER_NAME "avalon-drv"
+
+struct avalon_dev {
+	struct pci_dev *pci_dev;
+	struct avalon_dma avalon_dma;
+	struct miscdevice misc_dev;
+};
+
+#endif
diff --git a/include/uapi/linux/avalon-drv-ioctl.h b/include/uapi/linux/avalon-drv-ioctl.h
new file mode 100644
index 000000000000..af676b41a50f
--- /dev/null
+++ b/include/uapi/linux/avalon-drv-ioctl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef _UAPI_LINUX_AVALON_DRV_IOCTL_H__
+#define _UAPI_LINUX_AVALON_DRV_IOCTL_H__
+
+struct avalon_ioc_info {
+	size_t mem_addr;
+	size_t mem_size;
+	size_t dma_size;
+	size_t dma_size_sg;
+} __attribute((packed));
+
+#define AVALON_IOC 'V'
+
+#define IOCTL_AVALON_GET_INFO		_IOR(AVALON_IOC, 0, struct avalon_ioc_info)
+#define IOCTL_AVALON_SET_INFO		_IOR(AVALON_IOC, 1, struct avalon_ioc_info)
+#define IOCTL_AVALON_DMA_READ		_IOR(AVALON_IOC, 2, struct iovec)
+#define IOCTL_AVALON_DMA_WRITE		_IOW(AVALON_IOC, 3, struct iovec)
+#define IOCTL_AVALON_DMA_RDWR		_IOWR(AVALON_IOC, 4, struct iovec[2])
+#define IOCTL_AVALON_DMA_READ_SG	_IOR(AVALON_IOC, 5, struct iovec)
+#define IOCTL_AVALON_DMA_WRITE_SG	_IOW(AVALON_IOC, 6, struct iovec)
+#define IOCTL_AVALON_DMA_RDWR_SG	_IOWR(AVALON_IOC, 7, struct iovec[2])
+#define IOCTL_AVALON_DMA_READ_SG_SMP	_IOR(AVALON_IOC, 8, struct iovec)
+#define IOCTL_AVALON_DMA_WRITE_SG_SMP	_IOW(AVALON_IOC, 9, struct iovec)
+
+#endif
-- 
2.22.0

