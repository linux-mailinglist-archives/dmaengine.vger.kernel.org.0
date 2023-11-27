Return-Path: <dmaengine+bounces-256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEEC7FAB63
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 21:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A9E1C20EB2
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 20:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D2F45C19;
	Mon, 27 Nov 2023 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSobYgUF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340D10CC;
	Mon, 27 Nov 2023 12:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701116848; x=1732652848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=exPEJ2NHytrZASgF46XH+MN564oA5CR2jV1mTYa4zNo=;
  b=BSobYgUFpi7+jqtbXw7k3cZXsBxHe1eFEMi62MtgVXuOH2+kjv8LseUh
   HDJUF7JmJJvJl22QGfmsrNfcpxKka9+ECoNLjNVeOJYTccmX3jd06kPaR
   10VUrzxHFHxSCaMhJ47swwhrnV6jMkUjKTPGo5nY2yJ9KzbpM+r1MPIez
   FXZd6JtRNhpldX2kXp5Dl4hYe2zIbiwDb0j/ijxt3oXiAS4bHut/ubuxW
   7BAgZdDeWkhFP/QCgIGhWRkn4YEudB4WbCL6DyxheYaGUsemiOFYQnNKS
   OyPDpc/fBmCasCcCzphbfNmznZk+e+dIPHl99U9yvlyn42cTLk+Yswfmf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457115547"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457115547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16394552"
Received: from rpkulapa-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.213.183.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:27 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	vinodh.gopal@intel.com,
	giovanni.cabiddu@intel.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v10 08/14] crypto: iaa - Add Intel IAA Compression Accelerator crypto driver core
Date: Mon, 27 Nov 2023 14:26:58 -0600
Message-Id: <20231127202704.1263376-9-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel Analytics Accelerator (IAA) is a hardware accelerator that
provides very high thoughput compression/decompression compatible with
the DEFLATE compression standard described in RFC 1951, which is the
compression/decompression algorithm exported by this module.

Users can select IAA compress/decompress acceleration by specifying
one of the deflate-iaa* algorithms as the compression algorithm to use
by whatever facility allows asynchronous compression algorithms to be
selected.

For example, zswap can select the IAA fixed deflate algorithm
'deflate-iaa' via:

  # echo deflate-iaa > /sys/module/zswap/parameters/compressor

This patch adds iaa_crypto as an idxd sub-driver and tracks iaa
devices and workqueues as they are probed or removed.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 MAINTAINERS                                |   7 +
 drivers/crypto/intel/Kconfig               |   1 +
 drivers/crypto/intel/Makefile              |   1 +
 drivers/crypto/intel/iaa/Kconfig           |  10 +
 drivers/crypto/intel/iaa/Makefile          |  10 +
 drivers/crypto/intel/iaa/iaa_crypto.h      |  30 ++
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 323 +++++++++++++++++++++
 7 files changed, 382 insertions(+)
 create mode 100644 drivers/crypto/intel/iaa/Kconfig
 create mode 100644 drivers/crypto/intel/iaa/Makefile
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto.h
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..686ff0e1ce34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10719,6 +10719,13 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
 F:	drivers/dma/ioat*
 
+INTEL IAA CRYPTO DRIVER
+M:	Tom Zanussi <tom.zanussi@linux.intel.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+F:	drivers/crypto/intel/iaa/*
+
 INTEL IDLE DRIVER
 M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
 M:	Len Brown <lenb@kernel.org>
diff --git a/drivers/crypto/intel/Kconfig b/drivers/crypto/intel/Kconfig
index 3d90c87d4094..f38cd62a3f67 100644
--- a/drivers/crypto/intel/Kconfig
+++ b/drivers/crypto/intel/Kconfig
@@ -3,3 +3,4 @@
 source "drivers/crypto/intel/keembay/Kconfig"
 source "drivers/crypto/intel/ixp4xx/Kconfig"
 source "drivers/crypto/intel/qat/Kconfig"
+source "drivers/crypto/intel/iaa/Kconfig"
diff --git a/drivers/crypto/intel/Makefile b/drivers/crypto/intel/Makefile
index b3d0352ae188..2f56f6d34cf0 100644
--- a/drivers/crypto/intel/Makefile
+++ b/drivers/crypto/intel/Makefile
@@ -3,3 +3,4 @@
 obj-y += keembay/
 obj-y += ixp4xx/
 obj-$(CONFIG_CRYPTO_DEV_QAT) += qat/
+obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) += iaa/
diff --git a/drivers/crypto/intel/iaa/Kconfig b/drivers/crypto/intel/iaa/Kconfig
new file mode 100644
index 000000000000..fcccb6ff7e29
--- /dev/null
+++ b/drivers/crypto/intel/iaa/Kconfig
@@ -0,0 +1,10 @@
+config CRYPTO_DEV_IAA_CRYPTO
+	tristate "Support for Intel(R) IAA Compression Accelerator"
+	depends on CRYPTO_DEFLATE
+	depends on INTEL_IDXD
+	default n
+	help
+	  This driver supports acceleration for compression and
+	  decompression with the Intel Analytics Accelerator (IAA)
+	  hardware using the cryptographic API.  If you choose 'M'
+	  here, the module will be called iaa_crypto.
diff --git a/drivers/crypto/intel/iaa/Makefile b/drivers/crypto/intel/iaa/Makefile
new file mode 100644
index 000000000000..03859431c897
--- /dev/null
+++ b/drivers/crypto/intel/iaa/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for IAA crypto device drivers
+#
+
+ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
+
+obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
+
+iaa_crypto-y := iaa_crypto_main.o
diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
new file mode 100644
index 000000000000..5d1fff7f4b8e
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#ifndef __IAA_CRYPTO_H__
+#define __IAA_CRYPTO_H__
+
+#include <linux/crypto.h>
+#include <linux/idxd.h>
+#include <uapi/linux/idxd.h>
+
+#define IDXD_SUBDRIVER_NAME		"crypto"
+
+/* Representation of IAA workqueue */
+struct iaa_wq {
+	struct list_head	list;
+	struct idxd_wq		*wq;
+
+	struct iaa_device	*iaa_device;
+};
+
+/* Representation of IAA device with wqs, populated by probe */
+struct iaa_device {
+	struct list_head		list;
+	struct idxd_device		*idxd;
+
+	int				n_wq;
+	struct list_head		wqs;
+};
+
+#endif
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
new file mode 100644
index 000000000000..9a662ae49106
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/iommu.h>
+#include <uapi/linux/idxd.h>
+#include <linux/highmem.h>
+#include <linux/sched/smt.h>
+
+#include "idxd.h"
+#include "iaa_crypto.h"
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt)			"idxd: " IDXD_SUBDRIVER_NAME ": " fmt
+
+/* number of iaa instances probed */
+static unsigned int nr_iaa;
+
+static LIST_HEAD(iaa_devices);
+static DEFINE_MUTEX(iaa_devices_lock);
+
+static struct iaa_device *iaa_device_alloc(void)
+{
+	struct iaa_device *iaa_device;
+
+	iaa_device = kzalloc(sizeof(*iaa_device), GFP_KERNEL);
+	if (!iaa_device)
+		return NULL;
+
+	INIT_LIST_HEAD(&iaa_device->wqs);
+
+	return iaa_device;
+}
+
+static void iaa_device_free(struct iaa_device *iaa_device)
+{
+	struct iaa_wq *iaa_wq, *next;
+
+	list_for_each_entry_safe(iaa_wq, next, &iaa_device->wqs, list) {
+		list_del(&iaa_wq->list);
+		kfree(iaa_wq);
+	}
+
+	kfree(iaa_device);
+}
+
+static bool iaa_has_wq(struct iaa_device *iaa_device, struct idxd_wq *wq)
+{
+	struct iaa_wq *iaa_wq;
+
+	list_for_each_entry(iaa_wq, &iaa_device->wqs, list) {
+		if (iaa_wq->wq == wq)
+			return true;
+	}
+
+	return false;
+}
+
+static struct iaa_device *add_iaa_device(struct idxd_device *idxd)
+{
+	struct iaa_device *iaa_device;
+
+	iaa_device = iaa_device_alloc();
+	if (!iaa_device)
+		return NULL;
+
+	iaa_device->idxd = idxd;
+
+	list_add_tail(&iaa_device->list, &iaa_devices);
+
+	nr_iaa++;
+
+	return iaa_device;
+}
+
+static void del_iaa_device(struct iaa_device *iaa_device)
+{
+	list_del(&iaa_device->list);
+
+	iaa_device_free(iaa_device);
+
+	nr_iaa--;
+}
+
+static int add_iaa_wq(struct iaa_device *iaa_device, struct idxd_wq *wq,
+		      struct iaa_wq **new_wq)
+{
+	struct idxd_device *idxd = iaa_device->idxd;
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct iaa_wq *iaa_wq;
+
+	iaa_wq = kzalloc(sizeof(*iaa_wq), GFP_KERNEL);
+	if (!iaa_wq)
+		return -ENOMEM;
+
+	iaa_wq->wq = wq;
+	iaa_wq->iaa_device = iaa_device;
+	idxd_wq_set_private(wq, iaa_wq);
+
+	list_add_tail(&iaa_wq->list, &iaa_device->wqs);
+
+	iaa_device->n_wq++;
+
+	if (new_wq)
+		*new_wq = iaa_wq;
+
+	dev_dbg(dev, "added wq %d to iaa device %d, n_wq %d\n",
+		wq->id, iaa_device->idxd->id, iaa_device->n_wq);
+
+	return 0;
+}
+
+static void del_iaa_wq(struct iaa_device *iaa_device, struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = iaa_device->idxd;
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct iaa_wq *iaa_wq;
+
+	list_for_each_entry(iaa_wq, &iaa_device->wqs, list) {
+		if (iaa_wq->wq == wq) {
+			list_del(&iaa_wq->list);
+			iaa_device->n_wq--;
+
+			dev_dbg(dev, "removed wq %d from iaa_device %d, n_wq %d, nr_iaa %d\n",
+				wq->id, iaa_device->idxd->id,
+				iaa_device->n_wq, nr_iaa);
+
+			if (iaa_device->n_wq == 0)
+				del_iaa_device(iaa_device);
+			break;
+		}
+	}
+}
+
+static int save_iaa_wq(struct idxd_wq *wq)
+{
+	struct iaa_device *iaa_device, *found = NULL;
+	struct idxd_device *idxd;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	list_for_each_entry(iaa_device, &iaa_devices, list) {
+		if (iaa_device->idxd == wq->idxd) {
+			idxd = iaa_device->idxd;
+			pdev = idxd->pdev;
+			dev = &pdev->dev;
+			/*
+			 * Check to see that we don't already have this wq.
+			 * Shouldn't happen but we don't control probing.
+			 */
+			if (iaa_has_wq(iaa_device, wq)) {
+				dev_dbg(dev, "same wq probed multiple times for iaa_device %p\n",
+					iaa_device);
+				goto out;
+			}
+
+			found = iaa_device;
+
+			ret = add_iaa_wq(iaa_device, wq, NULL);
+			if (ret)
+				goto out;
+
+			break;
+		}
+	}
+
+	if (!found) {
+		struct iaa_device *new_device;
+		struct iaa_wq *new_wq;
+
+		new_device = add_iaa_device(wq->idxd);
+		if (!new_device) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = add_iaa_wq(new_device, wq, &new_wq);
+		if (ret) {
+			del_iaa_device(new_device);
+			goto out;
+		}
+	}
+
+	if (WARN_ON(nr_iaa == 0))
+		return -EINVAL;
+out:
+	return 0;
+}
+
+static void remove_iaa_wq(struct idxd_wq *wq)
+{
+	struct iaa_device *iaa_device;
+
+	list_for_each_entry(iaa_device, &iaa_devices, list) {
+		if (iaa_has_wq(iaa_device, wq)) {
+			del_iaa_wq(iaa_device, wq);
+			break;
+		}
+	}
+}
+
+static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
+{
+	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+	struct idxd_device *idxd = wq->idxd;
+	struct idxd_driver_data *data = idxd->data;
+	struct device *dev = &idxd_dev->conf_dev;
+	int ret = 0;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return -ENXIO;
+
+	if (data->type != IDXD_TYPE_IAX)
+		return -ENODEV;
+
+	mutex_lock(&wq->wq_lock);
+
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		dev_dbg(dev, "wq %d.%d driver_name match failed: wq driver_name %s, dev driver name %s\n",
+			idxd->id, wq->id, wq->driver_name, dev->driver->name);
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		ret = -ENODEV;
+		goto err;
+	}
+
+	wq->type = IDXD_WQT_KERNEL;
+
+	ret = idxd_drv_enable_wq(wq);
+	if (ret < 0) {
+		dev_dbg(dev, "enable wq %d.%d failed: %d\n",
+			idxd->id, wq->id, ret);
+		ret = -ENXIO;
+		goto err;
+	}
+
+	mutex_lock(&iaa_devices_lock);
+
+	ret = save_iaa_wq(wq);
+	if (ret)
+		goto err_save;
+
+	mutex_unlock(&iaa_devices_lock);
+out:
+	mutex_unlock(&wq->wq_lock);
+
+	return ret;
+
+err_save:
+	idxd_drv_disable_wq(wq);
+err:
+	wq->type = IDXD_WQT_NONE;
+
+	goto out;
+}
+
+static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
+{
+	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+
+	idxd_wq_quiesce(wq);
+
+	mutex_lock(&wq->wq_lock);
+	mutex_lock(&iaa_devices_lock);
+
+	remove_iaa_wq(wq);
+	idxd_drv_disable_wq(wq);
+
+	mutex_unlock(&iaa_devices_lock);
+	mutex_unlock(&wq->wq_lock);
+}
+
+static enum idxd_dev_type dev_types[] = {
+	IDXD_DEV_WQ,
+	IDXD_DEV_NONE,
+};
+
+static struct idxd_device_driver iaa_crypto_driver = {
+	.probe = iaa_crypto_probe,
+	.remove = iaa_crypto_remove,
+	.name = IDXD_SUBDRIVER_NAME,
+	.type = dev_types,
+};
+
+static int __init iaa_crypto_init_module(void)
+{
+	int ret = 0;
+
+	ret = idxd_driver_register(&iaa_crypto_driver);
+	if (ret) {
+		pr_debug("IAA wq sub-driver registration failed\n");
+		goto out;
+	}
+
+	pr_debug("initialized\n");
+out:
+	return ret;
+}
+
+static void __exit iaa_crypto_cleanup_module(void)
+{
+	idxd_driver_unregister(&iaa_crypto_driver);
+
+	pr_debug("cleaned up\n");
+}
+
+MODULE_IMPORT_NS(IDXD);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_IDXD_DEVICE(0);
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("IAA Compression Accelerator Crypto Driver");
+
+module_init(iaa_crypto_init_module);
+module_exit(iaa_crypto_cleanup_module);
-- 
2.34.1


