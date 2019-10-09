Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1DD0C55
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJIKMp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 06:12:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40081 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfJIKMn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 06:12:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so2114626wrv.7;
        Wed, 09 Oct 2019 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5rmwk7mDjkg9nne5byobPbEGZPSPlGtJADURgCwMJg=;
        b=FKo6mIwgLNaRyaUp7JziZmSbzEBka8LHi8SFM1uYa8G8NCDcVr+CD3b6dAHBn08LYS
         fmHN1thxgL10zbcprMFdf+QUg0YVuN3jTYRtj8OXLzXM8PifPcUGfxVYUC1AN6yvcfLD
         VxxBI43QWq7CwkX8cF5AwZ52rgVl+fvMmQmK2INX4Yfw2QERobzpnQFKUZao+QFFllu+
         ZRdRQMOaBEJ51s4A7WFUfmHRQsAlpfT/y+Dx94Hgk9/d+YlKk/Vsy5XWjD075d2mbQ7O
         PoL/cJSPD3YhE7rU32Xq6nVE2kuR7VzeouWNkvkTBQ9C2IhEcIjpB5c3yMf+/CuRRsms
         6U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5rmwk7mDjkg9nne5byobPbEGZPSPlGtJADURgCwMJg=;
        b=KeOiALtOCeNaI36luW/HZwcRjrUc41r/OgnaUlAzLi/yueGG8wi3cmVjQaG98PwHQP
         PCVur5gcpIyMSSrUURWszzn7swXt/wRNZcPQFuo19UDw5A+nH9AV7FEuG6qAk/PbsDeK
         lF2WLu+b0VTxtN+eyWp1E5q1e0+i1lwnZjIekArRfdCy4JFtb/HPwu8M9gHQjxMD9/hq
         6CmNqJPTdB9ZTR0UkaN+2MqMmPXrPGU4IsRU0jIupN89qPUA0kfMuEO7Z2K/LO5c9sEU
         T8oTYDnpJseP3pbhZR3x97lIAiyk7t4/DyQtShnEWFU6BojXl4f3M5qlwssuPkocWxy0
         CW+Q==
X-Gm-Message-State: APjAAAVM4plC7XBcz0oJ4mf6uX1r9OD9XatZPO6VkW/ra1aQYipJXWyq
        CTgigB5UyZCbknW+Zbklqr9uzVx6
X-Google-Smtp-Source: APXvYqwo3I2HGdyCL99vPpnPcC0IfY7EJ7Jw+m23vBB7+nS4B6YYe8H/I00hdIxxWYns/wYOR1jXEw==
X-Received: by 2002:adf:ee8a:: with SMTP id b10mr2201456wro.40.1570615958279;
        Wed, 09 Oct 2019 03:12:38 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.46])
        by smtp.googlemail.com with ESMTPSA id c9sm1734065wrt.7.2019.10.09.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:12:37 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Michael Chen <micchen@altera.com>, devel@driverdev.osuosl.org,
        dmaengine@vger.kernel.org
Subject: [PATCH RFC v2 2/2] dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe test
Date:   Wed,  9 Oct 2019 12:12:31 +0200
Message-Id: <6b540aeae71112154836003f2356703df2b36333.1570558807.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570558807.git.a.gordeev.box@gmail.com>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is sample implementation of a driver that uses "avalon-dma"
driver interface to perform data transfers between on-chip and
system memory in devices using Avalon-MM DMA Interface for PCIe
design. Companion user-level tool could be found at
https://github.com/a-gordeev/avalon-tool.git

CC: Michael Chen <micchen@altera.com>
CC: devel@driverdev.osuosl.org
CC: dmaengine@vger.kernel.org

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/dma/Kconfig                     |   1 +
 drivers/dma/Makefile                    |   1 +
 drivers/dma/avalon-test/Kconfig         |  23 +
 drivers/dma/avalon-test/Makefile        |  14 +
 drivers/dma/avalon-test/avalon-dev.c    |  65 +++
 drivers/dma/avalon-test/avalon-dev.h    |  33 ++
 drivers/dma/avalon-test/avalon-ioctl.c  | 128 +++++
 drivers/dma/avalon-test/avalon-ioctl.h  |  12 +
 drivers/dma/avalon-test/avalon-mmap.c   |  93 ++++
 drivers/dma/avalon-test/avalon-mmap.h   |  12 +
 drivers/dma/avalon-test/avalon-sg-buf.c | 132 +++++
 drivers/dma/avalon-test/avalon-sg-buf.h |  26 +
 drivers/dma/avalon-test/avalon-util.c   |  54 ++
 drivers/dma/avalon-test/avalon-util.h   |  12 +
 drivers/dma/avalon-test/avalon-xfer.c   | 697 ++++++++++++++++++++++++
 drivers/dma/avalon-test/avalon-xfer.h   |  28 +
 include/uapi/linux/avalon-ioctl.h       |  32 ++
 17 files changed, 1363 insertions(+)
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
 create mode 100644 drivers/dma/avalon-test/avalon-util.c
 create mode 100644 drivers/dma/avalon-test/avalon-util.h
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
index 000000000000..021c28fe77a6
--- /dev/null
+++ b/drivers/dma/avalon-test/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA engine
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+config AVALON_TEST
+	select AVALON_DMA
+	tristate "Intel Avalon-MM DMA Interface for PCIe test driver"
+	help
+	  This selects a test driver for Avalon-MM DMA Interface for PCI
+
+if AVALON_TEST
+
+config AVALON_TEST_TARGET_BASE
+	hex "Target device base address"
+	default "0x70000000"
+
+config AVALON_TEST_TARGET_SIZE
+	hex "Target device memory size"
+	default "0x10000000"
+
+endif
diff --git a/drivers/dma/avalon-test/Makefile b/drivers/dma/avalon-test/Makefile
new file mode 100644
index 000000000000..63351c52478a
--- /dev/null
+++ b/drivers/dma/avalon-test/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA driver
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+obj-$(CONFIG_AVALON_TEST)	+= avalon-test.o
+
+avalon-test-objs :=	avalon-dev.o \
+			avalon-ioctl.o \
+			avalon-mmap.o \
+			avalon-sg-buf.o \
+			avalon-xfer.o \
+			avalon-util.o
diff --git a/drivers/dma/avalon-test/avalon-dev.c b/drivers/dma/avalon-test/avalon-dev.c
new file mode 100644
index 000000000000..9e83f777f937
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-dev.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+
+#include "avalon-dev.h"
+#include "avalon-ioctl.h"
+#include "avalon-mmap.h"
+
+const struct file_operations avalon_dev_fops = {
+	.llseek		= generic_file_llseek,
+	.unlocked_ioctl	= avalon_dev_ioctl,
+	.mmap		= avalon_dev_mmap,
+};
+
+static struct avalon_dev avalon_dev;
+
+static int __init avalon_drv_init(void)
+{
+	struct avalon_dev *adev = &avalon_dev;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, NULL, NULL);
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
+	if (ret)
+		return ret;
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
index 000000000000..f06362ebf110
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-dev.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_DEV_H__
+#define __AVALON_DEV_H__
+
+#include <linux/dmaengine.h>
+#include <linux/miscdevice.h>
+
+#include "../avalon/avalon-hw.h"
+
+#define TARGET_MEM_BASE		CONFIG_AVALON_TEST_TARGET_BASE
+#define TARGET_MEM_SIZE		CONFIG_AVALON_TEST_TARGET_SIZE
+
+#define TARGET_DMA_SIZE         (2 * AVALON_DMA_MAX_TANSFER_SIZE)
+#define TARGET_DMA_SIZE_SG      TARGET_MEM_SIZE
+
+#define DEVICE_NAME		"avalon-dev"
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
index 000000000000..b90cdedf4400
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-ioctl.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/uio.h>
+
+#include <uapi/linux/avalon-ioctl.h>
+
+#include "avalon-xfer.h"
+
+long avalon_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct avalon_dev *adev = container_of(file->private_data,
+		struct avalon_dev, misc_dev);
+	struct dma_chan *chan = adev->dma_chan;
+	struct device *dev = chan_to_dev(chan);
+	struct iovec iovec[2];
+	void __user *buf = NULL, __user *buf_rd = NULL, __user *buf_wr = NULL;
+	size_t len = 0, len_rd = 0, len_wr = 0;
+	int ret = 0;
+
+	dev_dbg(dev, "%s(%d) { cmd %x", __FUNCTION__, __LINE__, cmd);
+
+	switch (cmd) {
+	case IOCTL_AVALON_DMA_GET_INFO: {
+		struct avalon_dma_info info = {
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
+	case IOCTL_AVALON_DMA_SET_INFO:
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
+		ret = xfer_rw(chan, DMA_FROM_DEVICE, buf, len);
+		break;
+	case IOCTL_AVALON_DMA_WRITE:
+		ret = xfer_rw(chan, DMA_TO_DEVICE, buf, len);
+		break;
+	case IOCTL_AVALON_DMA_RDWR:
+		ret = xfer_simultaneous(chan,
+					buf_rd, len_rd,
+					buf_wr, len_wr);
+		break;
+
+	case IOCTL_AVALON_DMA_READ_SG:
+		ret = xfer_rw_sg(chan, DMA_FROM_DEVICE, buf, len, false);
+		break;
+	case IOCTL_AVALON_DMA_WRITE_SG:
+		ret = xfer_rw_sg(chan, DMA_TO_DEVICE, buf, len, false);
+		break;
+	case IOCTL_AVALON_DMA_READ_SG_SMP:
+		ret = xfer_rw_sg(chan, DMA_FROM_DEVICE, buf, len, true);
+		break;
+	case IOCTL_AVALON_DMA_WRITE_SG_SMP:
+		ret = xfer_rw_sg(chan, DMA_TO_DEVICE, buf, len, true);
+		break;
+	case IOCTL_AVALON_DMA_RDWR_SG:
+		ret = xfer_simultaneous_sg(chan,
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
diff --git a/drivers/dma/avalon-test/avalon-ioctl.h b/drivers/dma/avalon-test/avalon-ioctl.h
new file mode 100644
index 000000000000..14a5952f1e20
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-ioctl.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_IOCTL_H__
+#define __AVALON_IOCTL_H__
+
+long avalon_dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+#endif
diff --git a/drivers/dma/avalon-test/avalon-mmap.c b/drivers/dma/avalon-test/avalon-mmap.c
new file mode 100644
index 000000000000..1309db9bceeb
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-mmap.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/dma-direction.h>
+
+#include "avalon-dev.h"
+#include "avalon-sg-buf.h"
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
diff --git a/drivers/dma/avalon-test/avalon-mmap.h b/drivers/dma/avalon-test/avalon-mmap.h
new file mode 100644
index 000000000000..494be31c9f54
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-mmap.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_MMAP_H__
+#define __AVALON_MMAP_H__
+
+int avalon_dev_mmap(struct file *file, struct vm_area_struct *vma);
+
+#endif
diff --git a/drivers/dma/avalon-test/avalon-sg-buf.c b/drivers/dma/avalon-test/avalon-sg-buf.c
new file mode 100644
index 000000000000..620b03c42ec5
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-sg-buf.c
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
diff --git a/drivers/dma/avalon-test/avalon-sg-buf.h b/drivers/dma/avalon-test/avalon-sg-buf.h
new file mode 100644
index 000000000000..c3a94bc1c664
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-sg-buf.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
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
diff --git a/drivers/dma/avalon-test/avalon-util.c b/drivers/dma/avalon-test/avalon-util.c
new file mode 100644
index 000000000000..b7ca5aa495d2
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-util.c
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
diff --git a/drivers/dma/avalon-test/avalon-util.h b/drivers/dma/avalon-test/avalon-util.h
new file mode 100644
index 000000000000..0d30dd6ecdf7
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-util.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_UTIL_H__
+#define __AVALON_UTIL_H__
+
+void dump_mem(struct device *dev, void *data, size_t len);
+
+#endif
diff --git a/drivers/dma/avalon-test/avalon-xfer.c b/drivers/dma/avalon-test/avalon-xfer.c
new file mode 100644
index 000000000000..96924c2159b2
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-xfer.c
@@ -0,0 +1,697 @@
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
+#include <linux/dmaengine.h>
+
+#include "avalon-xfer.h"
+#include "avalon-sg-buf.h"
+#include "avalon-util.h"
+
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
+	struct completion completion;
+	atomic_t counter;
+	ktime_t kt_start;
+	ktime_t kt_end;
+};
+
+static inline struct dma_async_tx_descriptor *__dmaengine_prep_slave_single(
+	struct dma_chan *chan, dma_addr_t buf, size_t len,
+	enum dma_transfer_direction dir, unsigned long flags)
+{
+	struct scatterlist *sg;
+
+	sg = kmalloc(sizeof(*sg), GFP_KERNEL);
+
+	sg_init_table(sg, 1);
+	sg_dma_address(sg) = buf;
+	sg_dma_len(sg) = len;
+
+	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+		return NULL;
+
+	return chan->device->device_prep_slave_sg(chan, sg, 1,
+						  dir, flags, NULL);
+}
+
+static void init_callback_info(struct xfer_callback_info *info, int value)
+{
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
+	int ret;
+
+	info->kt_end = ktime_get();
+
+	smp_rmb();
+	if (atomic_dec_and_test(&info->counter)) {
+		complete(&info->completion);
+		ret = 0;
+	} else {
+		ret = 1;
+	}
+
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
+static int
+submit_xfer_single(struct dma_chan *chan,
+		   enum dma_data_direction dir,
+		   dma_addr_t dev_addr,
+		   dma_addr_t host_addr, unsigned int size,
+		   dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config config = {
+		.direction	= dir,
+		.src_addr	= dev_addr,
+		.dst_addr	= dev_addr,
+	};
+	int ret;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret)
+		return ret;
+
+	tx = __dmaengine_prep_slave_single(chan, host_addr, size, dir, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	tx->callback = callback;
+	tx->callback_param = callback_param;
+
+	ret = dmaengine_submit(tx);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int
+submit_xfer_sg(struct dma_chan *chan,
+	       enum dma_data_direction dir,
+	       dma_addr_t dev_addr,
+	       struct scatterlist *sg, unsigned int sg_len,
+	       dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config config = {
+		.direction	= dir,
+		.src_addr	= dev_addr,
+		.dst_addr	= dev_addr,
+	};
+	int ret;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret)
+		return ret;
+
+	tx = dmaengine_prep_slave_sg(chan, sg, sg_len, dir, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	tx->callback = callback;
+	tx->callback_param = callback_param;
+
+	ret = dmaengine_submit(tx);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int xfer_rw(struct dma_chan *chan,
+	    enum dma_data_direction dir,
+	    void __user *user_buf, size_t user_len)
+{
+	struct device *dev = chan_to_dev(chan);
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
+	buf = kmalloc(size, GFP_KERNEL);
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
+	init_callback_info(&info, nr_reps);
+
+	dev_dbg(dev, "%s(%d) dma_addr %08llx size %lu dir %d reps = %d",
+		__FUNCTION__, __LINE__, dma_addr, size, dir, nr_reps);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = submit_xfer_single(chan, dir,
+					 TARGET_MEM_BASE, dma_addr, size,
+					 xfer_callback, &info);
+		if (ret)
+			goto dma_submit_err;
+	}
+
+	dma_async_issue_pending(chan);
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
+int xfer_simultaneous(struct dma_chan *chan,
+		      void __user *user_buf_rd, size_t user_len_rd,
+		      void __user *user_buf_wr, size_t user_len_wr)
+{
+	struct device *dev = chan_to_dev(chan);
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
+	buf_rd = kmalloc(size, GFP_KERNEL);
+	if (!buf_rd) {
+		ret = -ENOMEM;
+		goto rd_mem_alloc_err;
+	}
+
+	buf_wr = kmalloc(size, GFP_KERNEL);
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
+	init_callback_info(&info, 2 * nr_reps);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = submit_xfer_single(chan, DMA_TO_DEVICE,
+					 target_wr, dma_addr_wr, size,
+					 wr_xfer_callback, &info);
+		if (ret < 0)
+			goto rd_dma_submit_err;
+
+		ret = submit_xfer_single(chan, DMA_FROM_DEVICE,
+					 target_rd, dma_addr_rd, size,
+					 rd_xfer_callback, &info);
+		if (ret < 0)
+			goto wr_dma_submit_err;
+	}
+
+	dma_async_issue_pending(chan);
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
+static int kthread_xfer_rw_sg(struct dma_chan *chan,
+			      enum dma_data_direction dir,
+			      dma_addr_t dev_addr,
+			      struct scatterlist *sg, unsigned int sg_len,
+			      void (*xfer_callback)(void *dma_async_param))
+{
+	struct xfer_callback_info info;
+	int ret;
+	int i;
+
+	const int nr_reps = nr_dma_reps;
+
+	while (!kthread_should_stop()) {
+		init_callback_info(&info, nr_reps);
+
+		for (i = 0; i < nr_reps; i++) {
+			ret = submit_xfer_sg(chan, dir,
+					    dev_addr, sg, sg_len,
+					    xfer_callback, &info);
+			if (ret < 0)
+				goto err;
+		}
+
+		dma_async_issue_pending(chan);
+
+		ret = wait_for_completion_interruptible(&info.completion);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	while (!kthread_should_stop())
+		cond_resched();
+
+	return ret;
+}
+
+struct kthread_xfer_rw_sg_data {
+	struct dma_chan *chan;
+	enum dma_data_direction dir;
+	dma_addr_t dev_addr;
+	struct scatterlist *sg;
+	unsigned int sg_len;
+	void (*xfer_callback)(void *dma_async_param);
+};
+
+static int __kthread_xfer_rw_sg(void *_data)
+{
+	struct kthread_xfer_rw_sg_data *data = _data;
+
+	return kthread_xfer_rw_sg(data->chan, data->dir,
+				  data->dev_addr, data->sg, data->sg_len,
+				  data->xfer_callback);
+}
+
+static int __xfer_rw_sg_smp(struct dma_chan *chan,
+			    enum dma_data_direction dir,
+			    dma_addr_t dev_addr,
+			    struct scatterlist *sg, unsigned int sg_len,
+			    void (*xfer_callback)(void *dma_async_param))
+{
+	struct kthread_xfer_rw_sg_data data = {
+		chan, dir,
+		dev_addr, sg, sg_len,
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
+static int __xfer_rw_sg(struct dma_chan *chan,
+			enum dma_data_direction dir,
+			dma_addr_t dev_addr,
+			struct scatterlist *sg, unsigned int sg_len,
+			void (*xfer_callback)(void *dma_async_param))
+{
+	struct xfer_callback_info info;
+	int ret;
+	int i;
+
+	const int nr_reps = nr_dma_reps;
+
+	init_callback_info(&info, nr_reps);
+
+	for (i = 0; i < nr_reps; i++) {
+		ret = submit_xfer_sg(chan, dir,
+				     dev_addr, sg, sg_len,
+				     xfer_callback, &info);
+		if (ret < 0)
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
+int xfer_rw_sg(struct dma_chan *chan,
+	       enum dma_data_direction dir,
+	       void __user *user_buf, size_t user_len,
+	       bool is_smp)
+{
+	struct device *dev = chan_to_dev(chan);
+	int (*xfer)(struct dma_chan *chan,
+		    enum dma_data_direction dir,
+		    dma_addr_t dev_addr,
+		    struct scatterlist *sg, unsigned int sg_len,
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
+	ret = xfer(chan, dir,
+		   dma_addr, sg_buf->sgt.sgl, sg_buf->sgt.nents,
+		   xfer_callback);
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
+int xfer_simultaneous_sg(struct dma_chan *chan,
+			 void __user *user_buf_rd, size_t user_len_rd,
+			 void __user *user_buf_wr, size_t user_len_wr)
+{
+	struct device *dev = chan_to_dev(chan);
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
+	init_callback_info(&info, 2 * nr_reps);
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
+		ret = submit_xfer_sg(chan, DMA_TO_DEVICE,
+				     dma_addr_wr,
+				     sg_buf_wr->sgt.sgl,
+				     sg_buf_wr->sgt.nents,
+				     wr_xfer_callback, &info);
+		if (ret < 0)
+			goto dma_submit_rd_err;
+
+		ret = submit_xfer_sg(chan, DMA_FROM_DEVICE,
+				     dma_addr_rd,
+				     sg_buf_wr->sgt.sgl,
+				     sg_buf_wr->sgt.nents,
+				     rd_xfer_callback, &info);
+		if (ret < 0)
+			goto dma_submit_wr_err;
+	}
+
+	dma_async_issue_pending(chan);
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
+dma_submit_wr_err:
+dma_submit_rd_err:
+	dev_dbg(dev, "%s(%d) } = %d", __FUNCTION__, __LINE__, ret);
+
+	return ret;
+}
diff --git a/drivers/dma/avalon-test/avalon-xfer.h b/drivers/dma/avalon-test/avalon-xfer.h
new file mode 100644
index 000000000000..7cf515543284
--- /dev/null
+++ b/drivers/dma/avalon-test/avalon-xfer.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_XFER_H__
+#define __AVALON_XFER_H__
+
+#include <linux/dma-direction.h>
+
+#include "avalon-dev.h"
+
+int xfer_rw(struct dma_chan *chan,
+	    enum dma_data_direction dir,
+	    void __user *user_buf, size_t user_len);
+int xfer_simultaneous(struct dma_chan *chan,
+		      void __user *user_buf_rd, size_t user_len_rd,
+		      void __user *user_buf_wr, size_t user_len_wr);
+int xfer_rw_sg(struct dma_chan *chan,
+	       enum dma_data_direction dir,
+	       void __user *user_buf, size_t user_len,
+	       bool is_smp);
+int xfer_simultaneous_sg(struct dma_chan *chan,
+			 void __user *user_buf_rd, size_t user_len_rd,
+			 void __user *user_buf_wr, size_t user_len_wr);
+
+#endif
diff --git a/include/uapi/linux/avalon-ioctl.h b/include/uapi/linux/avalon-ioctl.h
new file mode 100644
index 000000000000..b929c2dd46ea
--- /dev/null
+++ b/include/uapi/linux/avalon-ioctl.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef _UAPI_LINUX_AVALON_IOCTL_H__
+#define _UAPI_LINUX_AVALON_IOCTL_H__
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
2.23.0

