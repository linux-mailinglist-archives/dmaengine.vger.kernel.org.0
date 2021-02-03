Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB430E5A8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhBCWGu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 17:06:50 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52506 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232975AbhBCWEm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 17:04:42 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8847C010B;
        Wed,  3 Feb 2021 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612389821; bh=SnKoXitkWOCapRJGjouiGRqUHkReUAsc8bf6YFLtRiI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TQoI689E1xDRh+YCfi9bctPBWCv/hC/L8ZBEvgWsCXJgn6+MTdtJ2O+34AH/8Gxto
         exII7nzLYt6/L1jYu0Io/mqnTDVS4eWdvXEhRyBQkH4mTKmebqqNXqKa810qZazgRJ
         76ufBhX5xlO7R8jQYGKtZwEQ6aVbiRWBChoGxEIM+qSDZFxqz9Omn75VP30EYrTnqB
         sPZ0E+me9Ni4NHs55pvwQ8UbBiZNGQoiFdhp0hgYBNrdt9CVQ8MXFD466n3A+A1rzt
         4hICCYWtwTkcYWXWdJFJx0fzxrBD24YD9I24QC+nguclJiVzu0jlBjT5ZaSVfWt5f/
         55aVTVytp439A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A997FA024B;
        Wed,  3 Feb 2021 22:03:39 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 1/6] misc: Add Synopsys DesignWare xData IP driver
Date:   Wed,  3 Feb 2021 23:03:25 +0100
Message-Id: <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612389746.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
References: <cover.1612389746.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Synopsys DesignWare xData IP driver. This driver enables/disables
the PCI traffic generator module pertain to the Synopsys DesignWare
prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/dw-xdata-pcie.c | 378 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)
 create mode 100644 drivers/misc/dw-xdata-pcie.c

diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
new file mode 100644
index 00000000..3e1bc35
--- /dev/null
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare xData driver
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci-epf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/bitops.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#define DW_XDATA_DRIVER_NAME		"dw-xdata-pcie"
+
+#define DW_XDATA_EP_MEM_OFFSET		0x8000000
+
+struct dw_xdata_pcie_data {
+	/* xData registers location */
+	enum pci_barno			rg_bar;
+	off_t				rg_off;
+	size_t				rg_sz;
+};
+
+static const struct dw_xdata_pcie_data snps_edda_data = {
+	/* xData registers location */
+	.rg_bar				= BAR_0,
+	.rg_off				= 0x00000000,   /*   0 Kbytes */
+	.rg_sz				= 0x0000012c,   /* 300  bytes */
+};
+
+#define STATUS_DONE			BIT(0)
+
+#define CONTROL_DOORBELL		BIT(0)
+#define CONTROL_IS_WRITE		BIT(1)
+#define CONTROL_LENGTH(a)		FIELD_PREP(GENMASK(13, 2), a)
+#define CONTROL_PATTERN_INC		BIT(16)
+#define CONTROL_NO_ADDR_INC		BIT(18)
+
+#define XPERF_CONTROL_ENABLE		BIT(5)
+
+struct dw_xdata_regs {
+	u32 addr_lsb;					/* 0x000 */
+	u32 addr_msb;					/* 0x004 */
+	u32 burst_cnt;					/* 0x008 */
+	u32 control;					/* 0x00c */
+	u32 pattern;					/* 0x010 */
+	u32 status;					/* 0x014 */
+	u32 RAM_addr;					/* 0x018 */
+	u32 RAM_port;					/* 0x01c */
+	u32 _reserved0[14];				/* 0x020..0x054 */
+	u32 perf_control;				/* 0x058 */
+	u32 _reserved1[41];				/* 0x05c..0x0fc */
+	u32 wr_cnt_lsb;					/* 0x100 */
+	u32 wr_cnt_msb;					/* 0x104 */
+	u32 rd_cnt_lsb;					/* 0x108 */
+	u32 rd_cnt_msb;					/* 0x10c */
+} __packed;
+
+struct dw_xdata_region {
+	phys_addr_t paddr;				/* physical address */
+	void __iomem *vaddr;				/* virtual address */
+	size_t sz;					/* size */
+};
+
+struct dw_xdata {
+	struct dw_xdata_region rg_region;		/* registers */
+	size_t max_wr_len;				/* max wr xfer len */
+	size_t max_rd_len;				/* max rd xfer len */
+	struct mutex mutex;
+	struct pci_dev *pdev;
+};
+
+static inline struct dw_xdata_regs __iomem *__dw_regs(struct dw_xdata *dw)
+{
+	return dw->rg_region.vaddr;
+}
+
+static void dw_xdata_stop(struct dw_xdata *dw)
+{
+	u32 burst = readl(&(__dw_regs(dw)->burst_cnt));
+
+	if (burst & BIT(31)) {
+		burst &= ~(u32)BIT(31);
+		writel(burst, &(__dw_regs(dw)->burst_cnt));
+	}
+}
+
+static void dw_xdata_start(struct dw_xdata *dw, bool write)
+{
+	u32 control, status;
+
+	/* Stop first if xfer in progress */
+	dw_xdata_stop(dw);
+
+	/* Clear status register */
+	writel(0x0, &(__dw_regs(dw)->status));
+
+	/* Burst count register set for continuous until stopped */
+	writel(0x80001001, &(__dw_regs(dw)->burst_cnt));
+
+	/* Pattern register */
+	writel(0x0, &(__dw_regs(dw)->pattern));
+
+	/* Control register */
+	control = CONTROL_DOORBELL | CONTROL_PATTERN_INC | CONTROL_NO_ADDR_INC;
+	if (write) {
+		control |= CONTROL_IS_WRITE;
+		control |= CONTROL_LENGTH(dw->max_wr_len);
+	} else {
+		control |= CONTROL_LENGTH(dw->max_rd_len);
+	}
+	writel(control, &(__dw_regs(dw)->control));
+
+	usleep_range(100, 150);
+
+	status = readl(&(__dw_regs(dw)->status));
+	if (!(status & STATUS_DONE))
+		pci_dbg(dw->pdev, "xData: started %s direction\n",
+			write ? "write" : "read");
+}
+
+static void dw_xdata_perf_meas(struct dw_xdata *dw, u64 *data, bool write)
+{
+	if (write) {
+		*data = readl(&(__dw_regs(dw)->wr_cnt_msb));
+		*data <<= 32;
+		*data |= readl(&(__dw_regs(dw)->wr_cnt_lsb));
+	} else {
+		*data = readl(&(__dw_regs(dw)->rd_cnt_msb));
+		*data <<= 32;
+		*data |= readl(&(__dw_regs(dw)->rd_cnt_lsb));
+	}
+}
+
+static u64 dw_xdata_perf_diff(u64 *m1, u64 *m2, u64 time)
+{
+	u64 rate = (*m1 - *m2);
+
+	rate *= (1000 * 1000 * 1000);
+	rate >>= 20;
+	rate = DIV_ROUND_CLOSEST_ULL(rate, time);
+
+	return rate;
+}
+
+static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
+{
+	u64 data[2], time[2], diff;
+
+	/* First measurement */
+	writel(0x0, &(__dw_regs(dw)->perf_control));
+	dw_xdata_perf_meas(dw, &data[0], write);
+	time[0] = jiffies;
+	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
+
+	/* Delay 100ms */
+	mdelay(100);
+
+	/* Second measurement */
+	writel(0x0, &(__dw_regs(dw)->perf_control));
+	dw_xdata_perf_meas(dw, &data[1], write);
+	time[1] = jiffies;
+	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
+
+	/* Calculations */
+	diff = jiffies_to_nsecs(time[1] - time[0]);
+	*rate = dw_xdata_perf_diff(&data[1], &data[0], diff);
+
+	pci_dbg(dw->pdev, "xData: time=%llu us, %s=%llu MB/s\n",
+		diff, write ? "write" : "read", *rate);
+}
+
+static ssize_t write_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	u64 rate;
+
+	mutex_lock(&dw->mutex);
+	dw_xdata_perf(dw, &rate, true);
+	mutex_unlock(&dw->mutex);
+
+	return sysfs_emit(buf, "%llu MB/s\n", rate);
+}
+
+static ssize_t write_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested write transfer\n");
+
+	mutex_lock(&dw->mutex);
+	dw_xdata_start(dw, true);
+	mutex_unlock(&dw->mutex);
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(write);
+
+static ssize_t read_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	u64 rate;
+
+	mutex_lock(&dw->mutex);
+	dw_xdata_perf(dw, &rate, false);
+	mutex_unlock(&dw->mutex);
+
+	return sysfs_emit(buf, "%llu MB/s\n", rate);
+}
+
+static ssize_t read_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested read transfer\n");
+
+	mutex_lock(&dw->mutex);
+	dw_xdata_start(dw, false);
+	mutex_unlock(&dw->mutex);
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(read);
+
+static ssize_t stop_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested stop any transfer\n");
+
+	mutex_lock(&dw->mutex);
+	dw_xdata_stop(dw);
+	mutex_unlock(&dw->mutex);
+
+	return size;
+}
+
+static DEVICE_ATTR_WO(stop);
+
+static struct attribute *default_attrs[] = {
+	&dev_attr_write.attr,
+	&dev_attr_read.attr,
+	&dev_attr_stop.attr,
+	NULL,
+};
+
+static const struct attribute_group xdata_attr_group = {
+	.attrs = default_attrs,
+	.name = DW_XDATA_DRIVER_NAME,
+};
+
+static int dw_xdata_pcie_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *pid)
+{
+	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
+	struct dw_xdata *dw;
+	u64 addr;
+	int err;
+
+	/* Enable PCI device */
+	err = pcim_enable_device(pdev);
+	if (err) {
+		pci_err(pdev, "enabling device failed\n");
+		return err;
+	}
+
+	/* Mapping PCI BAR regions */
+	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
+	if (err) {
+		pci_err(pdev, "xData BAR I/O remapping failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	/* Allocate memory */
+	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	/* Data structure initialization */
+	mutex_init(&dw->mutex);
+
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
+	if (!dw->rg_region.vaddr)
+		return -ENOMEM;
+
+	dw->rg_region.vaddr += pdata->rg_off;
+	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
+	dw->rg_region.paddr += pdata->rg_off;
+	dw->rg_region.sz = pdata->rg_sz;
+
+	dw->max_wr_len = pcie_get_mps(pdev);
+	dw->max_wr_len >>= 2;
+
+	dw->max_rd_len = pcie_get_readrq(pdev);
+	dw->max_rd_len >>= 2;
+
+	dw->pdev = pdev;
+
+	writel(0x0, &(__dw_regs(dw)->RAM_addr));
+	writel(0x0, &(__dw_regs(dw)->RAM_port));
+
+	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
+	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
+	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
+	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
+
+	pci_dbg(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
+		dw->max_wr_len * 4, dw->max_rd_len * 4);
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, dw);
+
+	/* Sysfs */
+	err = sysfs_create_group(&pdev->dev.kobj, &xdata_attr_group);
+	if (err)
+		return err;
+
+	err = sysfs_create_link(kernel_kobj, &pdev->dev.kobj,
+				DW_XDATA_DRIVER_NAME);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void dw_xdata_pcie_remove(struct pci_dev *pdev)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	if (dw) {
+		mutex_lock(&dw->mutex);
+		dw_xdata_stop(dw);
+		mutex_unlock(&dw->mutex);
+	}
+
+	sysfs_remove_link(kernel_kobj, DW_XDATA_DRIVER_NAME);
+	sysfs_remove_group(&pdev->dev.kobj, &xdata_attr_group);
+}
+
+static const struct pci_device_id dw_xdata_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dw_xdata_pcie_id_table);
+
+static struct pci_driver dw_xdata_pcie_driver = {
+	.name		= DW_XDATA_DRIVER_NAME,
+	.id_table	= dw_xdata_pcie_id_table,
+	.probe		= dw_xdata_pcie_probe,
+	.remove		= dw_xdata_pcie_remove,
+};
+
+module_pci_driver(dw_xdata_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare xData PCIe driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
+
-- 
2.7.4

