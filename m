Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4498BF1E9F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfKFTXA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 14:23:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbfKFTW7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 14:22:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so27390605wrm.8;
        Wed, 06 Nov 2019 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEteUeord344ekkrXpE1Gz+Kyq7NniT10YDTNWq5fjE=;
        b=WzvkPQyLCbfgOlY/Lc/Hm/PozO9tiVn1cVMkd7kfHc6BOr4HE0masfn2LhmS6OStqq
         DjZ2VynnzRx3W0RezUsISbqvnqNopFazJdpeGu0MPo/2+9qrDDROC/DjaY7Gb0EPBXIw
         cJzC5pnIbr89Wyb5N+1HH9mPtoLkyRQ8Ur4iPGxKstZBOJV68B3MQkiGLOJcG3pJO/Su
         1ZUw91UMiqK9FX0N7Ce7foh9vqW+8tF5iWsB2VAXq9wKSkwgxBsvVGxdwcmtijjuCz9I
         0MbbwmnZ/A6QNImRbAipfePF6pY0DkckSb/1dva8XK/m4qmv3ZVt5wyAq2MLtwpIYHCv
         udWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEteUeord344ekkrXpE1Gz+Kyq7NniT10YDTNWq5fjE=;
        b=PZnh2JVxRme/so+BDIMWsn2bktiXDZEe8wHD4L9KC1/wliH6ORGilUe1i6fsg45GO7
         5L/XQELcyLeCuTxipNJuVVWx7vUO/HG9+R6G+xoloFGSOv3HcKxl6cuIjLwf7x6moeB+
         1s1BFBeCyDKgPlPrF/kBDRl8TnLES5u18Ry+DNcuygrJTcSTg6DAGi6txk/7DhFs35xV
         VZhiHDIIOJdn2OPIaPl+iS5KP49SkXoyWSHOmZf4ivrRNZm7bjCMsZoakO3onAYJSWDx
         AAr0JWVHu28YlRuliAEzG+VkqZHOL+dYnxWMB8mWO9alaGl/575NFCbwGEC0uC322tJK
         B26A==
X-Gm-Message-State: APjAAAXIoQ4qCJBHF6LqTCJnmi3lL5mKgEfJUuMb6UWPsMxxN217B7cx
        xDcsDHZ9TE1rHvE2dBouciKYA0vF2G8=
X-Google-Smtp-Source: APXvYqyhNZOyWnO3trjoqslfRsJuJMo7+PkVUULOUrpT/l+go5f4uGXl7xRqFUu7tRYNesaCzPFrOA==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr4020340wrj.391.1573068174973;
        Wed, 06 Nov 2019 11:22:54 -0800 (PST)
Received: from localhost.localdomain ([213.86.25.46])
        by smtp.googlemail.com with ESMTPSA id h7sm2331175wmb.37.2019.11.06.11.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:22:54 -0800 (PST)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        dmaengine@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH RFC v5 2/2] dmaengine: avalon-test: Intel Avalon-MM DMA Interface for PCIe test
Date:   Wed,  6 Nov 2019 20:22:42 +0100
Message-Id: <948f34471b74a8a20747311cc1d7733d00d77645.1573052725.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573052725.git.a.gordeev.box@gmail.com>
References: <cover.1573052725.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is a sample implementation of a driver using "avalon-dma" to
perform data transfers between target device memory and system memory:

    +----------+    +----------+            +----------+
    |   RAM    |<-->|  Avalon  |<---PCIe--->|   Host   |
    +----------+    +----------+            +----------+

The target device is expected to use only Avalon-MM DMA Interface for
PCIe to initiate DMA transactions - without custom hardware specifics
to make such transfers possible.

Unlike "dmatest" driver, the contents of DMAed data is not manipulated by
"avalon-test" in any way. It is basically pass-through and the the data
are fully dependent on the target device implementation. Thus, it is up
to the users to analyze received or provide meaningful transmitted data.

CC: dmaengine@vger.kernel.org

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/dma/Kconfig                     |   1 +
 drivers/dma/Makefile                    |   1 +
 drivers/dma/avalon-test/Kconfig         |  12 +
 drivers/dma/avalon-test/Makefile        |  14 +
 drivers/dma/avalon-test/avalon-dev.c    | 108 +++++
 drivers/dma/avalon-test/avalon-dev.h    |  33 ++
 drivers/dma/avalon-test/avalon-ioctl.c  | 101 +++++
 drivers/dma/avalon-test/avalon-ioctl.h  |  13 +
 drivers/dma/avalon-test/avalon-mmap.c   |  74 +++
 drivers/dma/avalon-test/avalon-mmap.h   |  13 +
 drivers/dma/avalon-test/avalon-sg-buf.c | 132 ++++++
 drivers/dma/avalon-test/avalon-sg-buf.h |  27 ++
 drivers/dma/avalon-test/avalon-xfer.c   | 575 ++++++++++++++++++++++++
 drivers/dma/avalon-test/avalon-xfer.h   |  29 ++
 include/uapi/linux/avalon-ioctl.h       |  34 ++
 15 files changed, 1167 insertions(+)
 create mode 100644 drivers/dma/avalon-test/Kconfig
 create mode 100644 drivers/dma/avalon-test/Makefile
 create mode 100644 drivers/dma/avalon-test/avalon-dev.c
 create mode 100644 drivers/dma/avalon-test/avalon-dev.h
 create mode 100644 drivers/dma/avalon-test/avalon-ioctl.c
 create mode 100644 drivers/dma/avalon-test/avalon-ioctl.h
 create mode 100644 drivers/dma/avalon-test/avalon-mmap.c
 create mode 100644 drivers/dma/avalon-test/avalon-mmap.h
 create mode 100644 drivers/dma/avalon-test/avalon-sg-buf.c
 create mode 100644 drivers/dma/avalon-test/avalon-sg-buf.h
 create mode 100644 drivers/dma/avalon-test/avalon-xfer.c
 create mode 100644 drivers/dma/avalon-test/avalon-xfer.h
 create mode 100644 include/uapi/linux/avalon-ioctl.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f6f43480a4a4..4b3c6a6baf4c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -670,6 +670,7 @@ source "drivers/dma/sh/Kconfig"
 source "drivers/dma/ti/Kconfig"
 
 source "drivers/dma/avalon/Kconfig"
+source "drivers/dma/avalon-test/Kconfig"
 
 # clients
 comment "DMA Clients"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index fd7e11417b73..eb3ee7f6cac6 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
 obj-$(CONFIG_AVALON_DMA) += avalon/
+obj-$(CONFIG_AVALON_TEST) += avalon-test/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/avalon-test/Kconfig b/drivers/dma/avalon-test/Kconfig
new file mode 100644
index 000000000000..b4d22720ce23
--- /dev/null
+++ b/drivers/dma/avalon-test/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2019, The Linux Foundation. All rights reserved.
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+# Avalon DMA engine
+#
+config AVALON_TEST
+	select AVALON_DMA
+	tristate "Intel Avalon-MM DMA Interface for PCIe test driver"
+	help
+	  This selects a test driver for Avalon-MM DMA Interface for PCI
diff --git a/drivers/dma/avalon-test/Makefile b/drivers/dma/avalon-test/Makefile
new file mode 100644
index 000000000000..2387fc41c3ad
--- /dev/null
+++ b/drivers/dma/avalon-test/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2019, The Linux Foundation. All rights reserved.
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+# Avalon DMA driver
+#
+obj-$(CONFIG_AVALON_TEST)	+= avalon-test.o
+
+avalon-test-objs :=	avalon-dev.o \
+			avalon-ioctl.o \
+			avalon-mmap.o \
+			avalon-sg-buf.o \
+			avalon-xfer.o
diff --git a/drivers/dma/avalon-test/avalon-dev.c b/drivers/dma/avalon-test/avalon-dev.c
new file mode 100644
index 000000000000..937ac3663efd
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-dev.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/pci.h>
+
+#include "avalon-dev.h"
+#include "avalon-ioctl.h"
+#include "avalon-mmap.h"
+
+unsigned int mem_base = 0x70000000;
+module_param(mem_base, uint, 0644);
+MODULE_PARM_DESC(mem_base, "Device memory base (default: 0x70000000)");
+
+unsigned int mem_size = 0x10000000;
+module_param(mem_size, uint, 0644);
+MODULE_PARM_DESC(mem_size, "Device memory size (default: 0x10000000)");
+
+unsigned int dma_size = 0x200000;
+module_param(dma_size, uint, 0644);
+MODULE_PARM_DESC(dma_size, "DMA buffer transfer size (default: 0x200000)");
+
+unsigned int dma_size_sg = 0x10000000;
+module_param(dma_size_sg, uint, 0644);
+MODULE_PARM_DESC(dma_size_sg,
+		 "DMA scatter list transfer size (default: 0x10000000)");
+
+unsigned int nr_dma_reps = 4;
+module_param(nr_dma_reps, uint, 0644);
+MODULE_PARM_DESC(nr_dma_reps, "Device memory size (default: 4)");
+
+unsigned int dmas_per_cpu = 8;
+module_param(dmas_per_cpu, uint, 0644);
+MODULE_PARM_DESC(dmas_per_cpu, "Device memory size (default: 8)");
+
+static const struct file_operations avalon_dev_fops = {
+	.llseek		= generic_file_llseek,
+	.unlocked_ioctl	= avalon_dev_ioctl,
+	.mmap		= avalon_dev_mmap,
+};
+
+static struct avalon_dev avalon_dev;
+
+static bool filter(struct dma_chan *chan, void *filter_param)
+{
+	return !strcmp(chan->device->dev->driver->name, "avalon-dma");
+}
+
+static int __init avalon_drv_init(void)
+{
+	struct avalon_dev *adev = &avalon_dev;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	int ret;
+
+	if (!IS_ALIGNED(mem_base, PAGE_SIZE) ||
+	    !IS_ALIGNED(mem_size, PAGE_SIZE) ||
+	    !IS_ALIGNED(dma_size, sizeof(u32)) ||
+	    !IS_ALIGNED(dma_size_sg, sizeof(u32)))
+		return -EINVAL;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, filter, NULL);
+	if (!chan)
+		return -ENODEV;
+
+	adev->dma_chan		= chan;
+
+	adev->misc_dev.minor	= MISC_DYNAMIC_MINOR;
+	adev->misc_dev.name	= DEVICE_NAME;
+	adev->misc_dev.nodename	= DEVICE_NAME;
+	adev->misc_dev.fops	= &avalon_dev_fops;
+	adev->misc_dev.mode	= 0644;
+
+	ret = misc_register(&adev->misc_dev);
+	if (ret) {
+		dma_release_channel(chan);
+		return ret;
+	}
+
+	dma_size = min(dma_size_sg, mem_size);
+	dma_size_sg = min(dma_size_sg, mem_size);
+
+	return 0;
+}
+
+static void __exit avalon_drv_exit(void)
+{
+	struct avalon_dev *adev = &avalon_dev;
+
+	misc_deregister(&adev->misc_dev);
+	dma_release_channel(adev->dma_chan);
+}
+
+module_init(avalon_drv_init);
+module_exit(avalon_drv_exit);
+
+MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
+MODULE_DESCRIPTION("Avalon DMA control driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/avalon-test/avalon-dev.h b/drivers/dma/avalon-test/avalon-dev.h
new file mode 100644
index 000000000000..ad8f2f5717fa
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-dev.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#ifndef __AVALON_DEV_H__
+#define __AVALON_DEV_H__
+
+#include <linux/dmaengine.h>
+#include <linux/miscdevice.h>
+
+#define DEVICE_NAME		"avalon-dev"
+
+extern unsigned int mem_base;
+extern unsigned int mem_size;
+extern unsigned int dma_size;
+extern unsigned int dma_size_sg;
+extern unsigned int nr_dma_reps;
+extern unsigned int dmas_per_cpu;
+
+struct avalon_dev {
+	struct dma_chan *dma_chan;
+	struct miscdevice misc_dev;
+};
+
+static inline struct device *chan_to_dev(struct dma_chan *chan)
+{
+	return chan->device->dev;
+}
+
+#endif
diff --git a/drivers/dma/avalon-test/avalon-ioctl.c b/drivers/dma/avalon-test/avalon-ioctl.c
new file mode 100644
index 000000000000..39a6a7050ee5
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-ioctl.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/uio.h>
+
+#include <uapi/linux/avalon-ioctl.h>
+
+#include "avalon-ioctl.h"
+#include "avalon-xfer.h"
+
+long avalon_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct avalon_dev *adev = container_of(file->private_data,
+		struct avalon_dev, misc_dev);
+	struct dma_chan *chan = adev->dma_chan;
+	struct iovec iovec[2];
+	void __user *buf = NULL, *buf_rd = NULL, *buf_wr = NULL;
+	size_t len = 0, len_rd = 0, len_wr = 0;
+	int ret = -EINVAL;
+
+	switch (cmd) {
+	case IOCTL_AVALON_DMA_GET_INFO: {
+		struct avalon_dma_info info = {
+			.mem_addr	= mem_base,
+			.mem_size	= mem_size,
+			.dma_size	= dma_size,
+			.dma_size_sg	= dma_size_sg,
+		};
+
+		if (copy_to_user((void __user *)arg, &info, sizeof(info)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case IOCTL_AVALON_DMA_SET_INFO:
+		return -EINVAL;
+	case IOCTL_AVALON_DMA_READ:
+	case IOCTL_AVALON_DMA_WRITE:
+	case IOCTL_AVALON_DMA_READ_SG:
+	case IOCTL_AVALON_DMA_WRITE_SG:
+	case IOCTL_AVALON_DMA_READ_SG_SMP:
+	case IOCTL_AVALON_DMA_WRITE_SG_SMP:
+		if (copy_from_user(iovec, (void __user *)arg, sizeof(iovec[0])))
+			return -EFAULT;
+
+		buf = iovec[0].iov_base;
+		len = iovec[0].iov_len;
+
+		break;
+	case IOCTL_AVALON_DMA_RDWR:
+	case IOCTL_AVALON_DMA_RDWR_SG:
+		if (copy_from_user(iovec, (void __user *)arg, sizeof(iovec)))
+			return -EFAULT;
+
+		buf_rd = iovec[0].iov_base;
+		len_rd = iovec[0].iov_len;
+
+		buf_wr = iovec[1].iov_base;
+		len_wr = iovec[1].iov_len;
+
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	switch (cmd) {
+	case IOCTL_AVALON_DMA_READ:
+		ret = xfer_single(chan, DMA_DEV_TO_MEM, buf, len);
+		break;
+	case IOCTL_AVALON_DMA_WRITE:
+		ret = xfer_single(chan, DMA_MEM_TO_DEV, buf, len);
+		break;
+	case IOCTL_AVALON_DMA_RDWR:
+		ret = xfer_rw_single(chan, buf_rd, len_rd, buf_wr, len_wr);
+		break;
+	case IOCTL_AVALON_DMA_READ_SG:
+		ret = xfer_sg(chan, DMA_DEV_TO_MEM, buf, len, false);
+		break;
+	case IOCTL_AVALON_DMA_WRITE_SG:
+		ret = xfer_sg(chan, DMA_MEM_TO_DEV, buf, len, false);
+		break;
+	case IOCTL_AVALON_DMA_READ_SG_SMP:
+		ret = xfer_sg(chan, DMA_DEV_TO_MEM, buf, len, true);
+		break;
+	case IOCTL_AVALON_DMA_WRITE_SG_SMP:
+		ret = xfer_sg(chan, DMA_MEM_TO_DEV, buf, len, true);
+		break;
+	case IOCTL_AVALON_DMA_RDWR_SG:
+		ret = xfer_rw_sg(chan, buf_rd, len_rd, buf_wr, len_wr);
+		break;
+	};
+
+	return ret;
+}
diff --git a/drivers/dma/avalon-test/avalon-ioctl.h b/drivers/dma/avalon-test/avalon-ioctl.h
new file mode 100644
index 000000000000..a10ab0b5d67c
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-ioctl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#ifndef __AVALON_IOCTL_H__
+#define __AVALON_IOCTL_H__
+
+long avalon_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+#endif
diff --git a/drivers/dma/avalon-test/avalon-mmap.c b/drivers/dma/avalon-test/avalon-mmap.c
new file mode 100644
index 000000000000..434a8f8d4720
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-mmap.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/dma-direction.h>
+
+#include "avalon-dev.h"
+#include "avalon-mmap.h"
+#include "avalon-sg-buf.h"
+
+static void avalon_drv_vm_close(struct vm_area_struct *vma)
+{
+	struct dma_sg_buf *sg_buf = vma->vm_private_data;
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
+	struct avalon_dev *adev = container_of(file->private_data,
+		struct avalon_dev, misc_dev);
+	struct device *dev = chan_to_dev(adev->dma_chan);
+	unsigned long addr = vma->vm_start;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	enum dma_data_direction dir;
+	struct dma_sg_buf *sg_buf;
+	int ret;
+	int i;
+
+	if (!IS_ALIGNED(addr, PAGE_SIZE) || !IS_ALIGNED(size, PAGE_SIZE))
+		return -EINVAL;
+	if ((vma->vm_pgoff * PAGE_SIZE + size) > mem_size)
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
+	sg_buf = dma_sg_buf_alloc(dev, size, dir, GFP_KERNEL);
+	if (IS_ERR(sg_buf))
+		return PTR_ERR(sg_buf);
+
+	for (i = 0; size > 0; i++) {
+		ret = vm_insert_page(vma, addr, sg_buf->pages[i]);
+		if (ret) {
+			dma_sg_buf_free(sg_buf);
+			return ret;
+		}
+
+		addr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	};
+
+	vma->vm_private_data = sg_buf;
+
+	return 0;
+}
diff --git a/drivers/dma/avalon-test/avalon-mmap.h b/drivers/dma/avalon-test/avalon-mmap.h
new file mode 100644
index 000000000000..3d3878f236cf
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-mmap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#ifndef __AVALON_MMAP_H__
+#define __AVALON_MMAP_H__
+
+int avalon_dev_mmap(struct file *file, struct vm_area_struct *vma);
+
+#endif
diff --git a/drivers/dma/avalon-test/avalon-sg-buf.c b/drivers/dma/avalon-test/avalon-sg-buf.c
new file mode 100644
index 000000000000..31a578e20cc1
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-sg-buf.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
+#include "avalon-sg-buf.h"
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
+	buf->num_pages = size >> PAGE_SHIFT;
+
+	buf->pages = kvcalloc(buf->num_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!buf->pages)
+		goto free_buf;
+
+	ret = dma_sg_alloc_compacted(buf, gfp_flags);
+	if (ret)
+		goto free_arr;
+
+	ret = sg_alloc_table_from_pages(&buf->sgt, buf->pages,
+					buf->num_pages, 0, size,
+					GFP_KERNEL);
+	if (ret)
+		goto free_pages;
+
+	buf->dev = get_device(dev);
+
+	sgt = &buf->sgt;
+
+	sgt->nents = dma_map_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+				      buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+	if (!sgt->nents)
+		goto free_sgt;
+
+	buf->vaddr = vm_map_ram(buf->pages, buf->num_pages, -1, PAGE_KERNEL);
+	if (!buf->vaddr)
+		goto unmap_sg;
+
+	return buf;
+
+unmap_sg:
+	dma_unmap_sg_attrs(buf->dev, sgt->sgl, sgt->orig_nents,
+			   buf->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
+free_sgt:
+	put_device(buf->dev);
+	sg_free_table(&buf->sgt);
+free_pages:
+	num_pages = buf->num_pages;
+	while (num_pages--)
+		__free_page(buf->pages[num_pages]);
+free_arr:
+	kvfree(buf->pages);
+free_buf:
+	kfree(buf);
+
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
diff --git a/drivers/dma/avalon-test/avalon-sg-buf.h b/drivers/dma/avalon-test/avalon-sg-buf.h
new file mode 100644
index 000000000000..a5cce1c18714
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-sg-buf.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ * Avalon DMA driver
+ */
+#ifndef __AVALON_SG_BUF_H__
+#define __AVALON_SG_BUF_H__
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
diff --git a/drivers/dma/avalon-test/avalon-xfer.c b/drivers/dma/avalon-test/avalon-xfer.c
new file mode 100644
index 000000000000..57f3543bc7c3
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-xfer.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <linux/uaccess.h>
+#include <linux/kthread.h>
+#include <linux/sched/signal.h>
+#include <linux/dmaengine.h>
+
+#include "avalon-xfer.h"
+#include "avalon-sg-buf.h"
+
+struct callback_info {
+	struct completion completion;
+	atomic_t counter;
+};
+
+static void init_callback_info(struct callback_info *info, int value)
+{
+	init_completion(&info->completion);
+
+	/*
+	 * Pairs with smp_rmb() in xfer_callback()
+	 */
+	atomic_set(&info->counter, value);
+	smp_wmb();
+}
+
+static void xfer_callback(void *arg)
+{
+	struct callback_info *info = arg;
+
+	/*
+	 * Pairs with smp_wmb() in init_callback_info()
+	 */
+	smp_rmb();
+	if (atomic_dec_and_test(&info->counter))
+		complete(&info->completion);
+}
+
+static int config_chan(struct dma_chan *chan,
+		       enum dma_transfer_direction direction,
+		       dma_addr_t dev_addr)
+{
+	struct dma_slave_config config = {
+		.direction	= direction,
+		.src_addr	= dev_addr,
+		.dst_addr	= dev_addr,
+	};
+
+	return dmaengine_slave_config(chan, &config);
+}
+
+static int submit_tx(struct dma_chan *chan,
+		     struct dma_async_tx_descriptor *tx,
+		     dma_async_tx_callback callback, void *callback_param)
+{
+	dma_cookie_t cookie;
+
+	tx->callback = callback;
+	tx->callback_param = callback_param;
+
+	cookie = dmaengine_submit(tx);
+	if (cookie < 0) {
+		dmaengine_terminate_sync(chan);
+		return cookie;
+	}
+
+	return 0;
+}
+
+static
+int submit_xfer_single(struct dma_chan *chan,
+		       enum dma_transfer_direction direction,
+		       dma_addr_t dev_addr,
+		       dma_addr_t host_addr, unsigned int size,
+		       dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_async_tx_descriptor *tx;
+	int ret;
+
+	ret = config_chan(chan, direction, dev_addr);
+	if (ret)
+		return ret;
+
+	tx = dmaengine_prep_slave_single(chan,
+					 host_addr, size, direction, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	ret = submit_tx(chan, tx, callback, callback_param);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static
+int submit_xfer_sg(struct dma_chan *chan,
+		   enum dma_transfer_direction direction,
+		   dma_addr_t dev_addr,
+		   struct scatterlist *sg, unsigned int sg_len,
+		   dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_async_tx_descriptor *tx;
+	int ret;
+
+	ret = config_chan(chan, direction, dev_addr);
+	if (ret)
+		return ret;
+
+	tx = dmaengine_prep_slave_sg(chan, sg, sg_len, direction, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	ret = submit_tx(chan, tx, callback, callback_param);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int xfer_single(struct dma_chan *chan,
+		enum dma_transfer_direction direction,
+		void __user *user_buf, size_t user_len)
+{
+	struct device *dev = chan_to_dev(chan);
+	dma_addr_t dma_addr;
+	enum dma_data_direction dma_dir;
+	void *buf;
+	struct callback_info info;
+	int ret;
+	int i;
+
+	if (user_len < dma_size)
+		return -EINVAL;
+	if (direction == DMA_MEM_TO_DEV)
+		dma_dir = DMA_TO_DEVICE;
+	else if (direction == DMA_DEV_TO_MEM)
+		dma_dir = DMA_FROM_DEVICE;
+	else
+		return -EINVAL;
+
+	user_len = min_t(size_t, user_len, dma_size);
+
+	buf = kzalloc(dma_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (direction == DMA_MEM_TO_DEV) {
+		if (copy_from_user(buf, user_buf, user_len)) {
+			ret = -EFAULT;
+			goto free_buf;
+		}
+	}
+
+	dma_addr = dma_map_single(dev, buf, dma_size, dma_dir);
+	if (dma_mapping_error(dev, dma_addr)) {
+		ret = -ENOMEM;
+		goto free_buf;
+	}
+
+	init_callback_info(&info, nr_dma_reps);
+
+	for (i = 0; i < nr_dma_reps; i++) {
+		ret = submit_xfer_single(chan, direction,
+					 mem_base, dma_addr, dma_size,
+					 xfer_callback, &info);
+		if (ret)
+			goto unmap_buf;
+	}
+
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_interruptible(&info.completion);
+	if (ret)
+		goto unmap_buf;
+
+	if (direction == DMA_DEV_TO_MEM) {
+		if (copy_to_user(user_buf, buf, user_len))
+			ret = -EFAULT;
+	}
+
+unmap_buf:
+	dma_unmap_single(dev, dma_addr, dma_size, dma_dir);
+
+free_buf:
+	kfree(buf);
+
+	return ret;
+}
+
+int xfer_rw_single(struct dma_chan *chan,
+		   void __user *user_buf_rd, size_t user_len_rd,
+		   void __user *user_buf_wr, size_t user_len_wr)
+{
+	struct device *dev = chan_to_dev(chan);
+	dma_addr_t target_rd = mem_base;
+	dma_addr_t target_wr = target_rd + dma_size;
+	dma_addr_t dma_addr_rd, dma_addr_wr;
+	void *buf_rd, *buf_wr;
+	struct callback_info info;
+	int ret;
+	int i;
+
+	if ((user_len_rd < dma_size) || (user_len_wr < dma_size))
+		return -EINVAL;
+
+	user_len_rd = min_t(size_t, user_len_rd, dma_size);
+	user_len_wr = min_t(size_t, user_len_wr, dma_size);
+
+	buf_rd = kzalloc(dma_size, GFP_KERNEL);
+	if (!buf_rd) {
+		ret = -ENOMEM;
+		goto alloc_err;
+	}
+
+	buf_wr = kzalloc(dma_size, GFP_KERNEL);
+	if (!buf_wr) {
+		ret = -ENOMEM;
+		goto free_buf_rd;
+	}
+
+	if (copy_from_user(buf_wr, user_buf_wr, user_len_wr)) {
+		ret = -EFAULT;
+		goto free_buf_wr;
+	}
+
+	dma_addr_rd = dma_map_single(dev, buf_rd, dma_size, DMA_DEV_TO_MEM);
+	if (dma_mapping_error(dev, dma_addr_rd)) {
+		ret = -ENOMEM;
+		goto free_buf_wr;
+	}
+
+	dma_addr_wr = dma_map_single(dev, buf_wr, dma_size, DMA_MEM_TO_DEV);
+	if (dma_mapping_error(dev, dma_addr_rd)) {
+		ret = -ENOMEM;
+		goto unmap_buf_rd;
+	}
+
+	init_callback_info(&info, 2 * nr_dma_reps);
+
+	for (i = 0; i < nr_dma_reps; i++) {
+		ret = submit_xfer_single(chan, DMA_MEM_TO_DEV,
+					 target_wr, dma_addr_wr, dma_size,
+					 xfer_callback, &info);
+		if (ret)
+			goto unmap_buf_wr;
+
+		ret = submit_xfer_single(chan, DMA_DEV_TO_MEM,
+					 target_rd, dma_addr_rd, dma_size,
+					 xfer_callback, &info);
+		if (ret)
+			goto unmap_buf_wr;
+	}
+
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_interruptible(&info.completion);
+	if (ret)
+		goto unmap_buf_wr;
+
+	if (copy_to_user(user_buf_rd, buf_rd, user_len_rd))
+		ret = -EFAULT;
+
+unmap_buf_wr:
+	dma_unmap_single(dev, dma_addr_wr, dma_size, DMA_MEM_TO_DEV);
+
+unmap_buf_rd:
+	dma_unmap_single(dev, dma_addr_rd, dma_size, DMA_DEV_TO_MEM);
+
+free_buf_wr:
+	kfree(buf_wr);
+
+free_buf_rd:
+	kfree(buf_rd);
+
+alloc_err:
+	return ret;
+}
+
+static int kthread_xfer_rw_sg(struct dma_chan *chan,
+			      enum dma_transfer_direction direction,
+			      dma_addr_t dev_addr,
+			      struct scatterlist *sg, unsigned int sg_len,
+			      dma_async_tx_callback callback)
+{
+	struct callback_info info;
+	int ret;
+	int i;
+
+	while (!kthread_should_stop()) {
+		init_callback_info(&info, nr_dma_reps);
+
+		for (i = 0; i < nr_dma_reps; i++) {
+			ret = submit_xfer_sg(chan, direction,
+					     dev_addr, sg, sg_len,
+					     callback, &info);
+			if (ret)
+				return ret;
+		}
+
+		dma_async_issue_pending(chan);
+
+		ret = wait_for_completion_interruptible(&info.completion);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct kthread_xfer_rw_sg_data {
+	struct dma_chan *chan;
+	enum dma_transfer_direction direction;
+	dma_addr_t dev_addr;
+	struct scatterlist *sg;
+	unsigned int sg_len;
+	dma_async_tx_callback callback;
+};
+
+static int __kthread_xfer_rw_sg(void *__data)
+{
+	struct kthread_xfer_rw_sg_data *data = __data;
+
+	return kthread_xfer_rw_sg(data->chan, data->direction,
+				  data->dev_addr, data->sg, data->sg_len,
+				  data->callback);
+}
+
+static int __xfer_sg_smp(struct dma_chan *chan,
+			 enum dma_transfer_direction direction,
+			 dma_addr_t dev_addr,
+			 struct scatterlist *sg, unsigned int sg_len,
+			 dma_async_tx_callback callback)
+{
+	struct kthread_xfer_rw_sg_data data = {
+		chan, direction,
+		dev_addr, sg, sg_len,
+		callback
+	};
+	struct task_struct *task;
+	struct task_struct **tasks;
+	int nr_tasks = dmas_per_cpu * num_online_cpus();
+	int n, cpu;
+	int ret = 0;
+	int i = 0;
+
+	tasks = kmalloc_array(nr_tasks, sizeof(tasks[0]), GFP_KERNEL);
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
+					      &data, "avalon-dma-%d-%d",
+					      cpu, n);
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
+	for (n = 0; n < i; n++)
+		wake_up_process(tasks[n]);
+
+	/*
+	 * Run child kthreads until user sent a signal (i.e Ctrl+C)
+	 * and clear the signal to avid user program from being killed.
+	 */
+	schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
+	flush_signals(current);
+
+kthread_err:
+	while (--i >= 0)
+		kthread_stop(tasks[i]);
+
+	kfree(tasks);
+
+	return ret;
+}
+
+static int __xfer_sg(struct dma_chan *chan,
+		     enum dma_transfer_direction direction,
+		     dma_addr_t dev_addr,
+		     struct scatterlist *sg, unsigned int sg_len,
+		     dma_async_tx_callback callback)
+{
+	struct callback_info info;
+	int ret;
+	int i;
+
+	init_callback_info(&info, nr_dma_reps);
+
+	for (i = 0; i < nr_dma_reps; i++) {
+		ret = submit_xfer_sg(chan, direction, dev_addr, sg, sg_len,
+				     callback, &info);
+		if (ret)
+			return ret;
+	}
+
+	dma_async_issue_pending(chan);
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
+int xfer_sg(struct dma_chan *chan,
+	    enum dma_transfer_direction direction,
+	    void __user *user_buf, size_t user_len,
+	    bool is_smp)
+{
+	struct device *dev = chan_to_dev(chan);
+	int (*xfer)(struct dma_chan *chan,
+		    enum dma_transfer_direction direction,
+		    dma_addr_t dev_addr,
+		    struct scatterlist *sg, unsigned int sg_len,
+		    dma_async_tx_callback callback);
+	struct vm_area_struct *vma;
+	struct dma_sg_buf *sg_buf;
+	dma_addr_t dma_addr;
+	int ret;
+
+	vma = get_vma((unsigned long)user_buf, user_len);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
+
+	sg_buf = vma->vm_private_data;
+	switch (sg_buf->dma_dir) {
+	case DMA_TO_DEVICE:
+		if (direction != DMA_MEM_TO_DEV)
+			return -EINVAL;
+		break;
+	case DMA_FROM_DEVICE:
+		if (direction != DMA_DEV_TO_MEM)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (is_smp)
+		xfer = __xfer_sg_smp;
+	else
+		xfer = __xfer_sg;
+
+	dma_addr = mem_base + vma->vm_pgoff * PAGE_SIZE;
+
+	dma_sync_sg_for_device(dev,
+			       sg_buf->sgt.sgl, sg_buf->sgt.nents,
+			       sg_buf->dma_dir);
+
+	ret = xfer(chan, direction,
+		   dma_addr, sg_buf->sgt.sgl, sg_buf->sgt.nents,
+		   xfer_callback);
+
+	dma_sync_sg_for_cpu(dev,
+			    sg_buf->sgt.sgl, sg_buf->sgt.nents,
+			    sg_buf->dma_dir);
+
+	return ret;
+}
+
+int xfer_rw_sg(struct dma_chan *chan,
+	       void __user *user_buf_rd, size_t user_len_rd,
+	       void __user *user_buf_wr, size_t user_len_wr)
+{
+	struct device *dev = chan_to_dev(chan);
+	dma_addr_t dma_addr_rd, dma_addr_wr;
+	struct callback_info info;
+	struct vm_area_struct *vma_rd, *vma_wr;
+	struct dma_sg_buf *sg_buf_rd, *sg_buf_wr;
+	int ret;
+	int i;
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
+	if ((sg_buf_rd->dma_dir != DMA_TO_DEVICE) ||
+	    (sg_buf_wr->dma_dir != DMA_FROM_DEVICE))
+		return -EINVAL;
+
+	dma_addr_rd = mem_base + vma_rd->vm_pgoff * PAGE_SIZE;
+	dma_addr_wr = mem_base + vma_wr->vm_pgoff * PAGE_SIZE;
+
+	init_callback_info(&info, 2 * nr_dma_reps);
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
+	for (i = 0; i < nr_dma_reps; i++) {
+		ret = submit_xfer_sg(chan, DMA_MEM_TO_DEV,
+				     dma_addr_wr,
+				     sg_buf_wr->sgt.sgl,
+				     sg_buf_wr->sgt.nents,
+				     xfer_callback, &info);
+		if (ret)
+			goto submit_err;
+
+		ret = submit_xfer_sg(chan, DMA_DEV_TO_MEM,
+				     dma_addr_rd,
+				     sg_buf_rd->sgt.sgl,
+				     sg_buf_rd->sgt.nents,
+				     xfer_callback, &info);
+		if (ret)
+			goto submit_err;
+	}
+
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_interruptible(&info.completion);
+
+submit_err:
+	dma_sync_sg_for_cpu(dev,
+			    sg_buf_rd->sgt.sgl,
+			    sg_buf_rd->sgt.nents,
+			    DMA_DEV_TO_MEM);
+	dma_sync_sg_for_cpu(dev,
+			    sg_buf_wr->sgt.sgl,
+			    sg_buf_wr->sgt.nents,
+			    DMA_MEM_TO_DEV);
+
+	return ret;
+}
diff --git a/drivers/dma/avalon-test/avalon-xfer.h b/drivers/dma/avalon-test/avalon-xfer.h
new file mode 100644
index 000000000000..32bc6c0e7fc9
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-xfer.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#ifndef __AVALON_XFER_H__
+#define __AVALON_XFER_H__
+
+#include <linux/dmaengine.h>
+
+#include "avalon-dev.h"
+
+int xfer_single(struct dma_chan *chan,
+		enum dma_transfer_direction direction,
+		void __user *user_buf, size_t user_len);
+int xfer_rw_single(struct dma_chan *chan,
+		   void __user *user_buf_rd, size_t user_len_rd,
+		   void __user *user_buf_wr, size_t user_len_wr);
+int xfer_sg(struct dma_chan *chan,
+	    enum dma_transfer_direction direction,
+	    void __user *user_buf, size_t user_len,
+	    bool is_smp);
+int xfer_rw_sg(struct dma_chan *chan,
+	       void __user *user_buf_rd, size_t user_len_rd,
+	       void __user *user_buf_wr, size_t user_len_wr);
+
+#endif
diff --git a/include/uapi/linux/avalon-ioctl.h b/include/uapi/linux/avalon-ioctl.h
new file mode 100644
index 000000000000..a42d7b4bc0a2
--- /dev/null
+++ b/include/uapi/linux/avalon-ioctl.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef _UAPI_LINUX_AVALON_IOCTL_H__
+#define _UAPI_LINUX_AVALON_IOCTL_H__
+
+#include <linux/types.h>
+
+#define AVALON_DEVICE_NAME		"avalon-dev"
+
+struct avalon_dma_info {
+	size_t mem_addr;
+	size_t mem_size;
+	size_t dma_size;
+	size_t dma_size_sg;
+} __attribute((packed));
+
+#define AVALON_SIG 'V'
+
+#define IOCTL_AVALON_DMA_GET_INFO	_IOR(AVALON_SIG, 0, struct avalon_dma_info)
+#define IOCTL_AVALON_DMA_SET_INFO	_IOW(AVALON_SIG, 1, struct avalon_dma_info)
+#define IOCTL_AVALON_DMA_READ		_IOR(AVALON_SIG, 2, struct iovec)
+#define IOCTL_AVALON_DMA_WRITE		_IOW(AVALON_SIG, 3, struct iovec)
+#define IOCTL_AVALON_DMA_RDWR		_IOWR(AVALON_SIG, 4, struct iovec[2])
+#define IOCTL_AVALON_DMA_READ_SG	_IOR(AVALON_SIG, 5, struct iovec)
+#define IOCTL_AVALON_DMA_WRITE_SG	_IOW(AVALON_SIG, 6, struct iovec)
+#define IOCTL_AVALON_DMA_RDWR_SG	_IOWR(AVALON_SIG, 7, struct iovec[2])
+#define IOCTL_AVALON_DMA_READ_SG_SMP	_IOR(AVALON_SIG, 8, struct iovec)
+#define IOCTL_AVALON_DMA_WRITE_SG_SMP	_IOW(AVALON_SIG, 9, struct iovec)
+
+#endif
-- 
2.24.0

