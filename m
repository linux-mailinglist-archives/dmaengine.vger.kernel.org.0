Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDE6CC698
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjC1PhN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjC1Pgf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:36:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF251040B;
        Tue, 28 Mar 2023 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017768; x=1711553768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFg3YO6Slrhe435sqvZN4G7hJiqhwfJCZSCWX1miZmo=;
  b=XwJ8Asz/ER8NiQmxtsj9Zy2SqhOXil0vlLwdjAulB7nG2rLPb1+Xfvrk
   qW8UdnUCPZzAAsNSHAYM4y9STbmQeeoQa2ey8Ae8jlkQwUMlLwJmzWDXi
   zr4J67cNnzAPjaOzKkDkXfqZ4zEGMeSQRzQ3qzaRIHFLTCm4gddSZkH6h
   B3ZTi4VDZI6RNdHQ4qmS2DQ2275VXpd0baroLVZbfqYs/Y/AZByZDAEbV
   uGf7uMlQIM15vwR8lYGCfiFHSBbJOhdAabJxmiYoYT16Fm7HzDjdHMh1E
   VDy1NQYL9DbX4yxbDRVD9uH0qJSaVMvYZSJRdSbRJyZpImij5udTLPctO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342192171"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342192171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683948439"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683948439"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:03 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 09/15] crypto: iaa - Add Intel IAA Compression Accelerator crypto driver core
Date:   Tue, 28 Mar 2023 10:35:29 -0500
Message-Id: <20230328153535.126223-10-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Intel Analytics Accelerator (IAA) is a hardware accelerator that
provides very high thoughput compression/decompression compatible with
the DEFLATE compression standard described in RFC 1951, which is the
compression/decompression algorithm exported by this module.

Users can select IAA compress/decompress acceleration by specifying
'iaa_crypto' as the compression algorithm to use by whatever facility
allows asynchronous compression algorithms to be selected.

For example, zswap can select iaa_crypto via:

  # echo iaa_crypto > /sys/module/zswap/parameters/compressor

This patch adds iaa_crypto as an idxd sub-driver and tracks iaa
devices and workqueues as they are probed or removed.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 MAINTAINERS                                |   7 +
 drivers/crypto/Kconfig                     |   1 +
 drivers/crypto/Makefile                    |   1 +
 drivers/crypto/intel/Kconfig               |   3 +
 drivers/crypto/intel/Makefile              |   3 +
 drivers/crypto/intel/iaa/Kconfig           |  10 +
 drivers/crypto/intel/iaa/Makefile          |  10 +
 drivers/crypto/intel/iaa/iaa_crypto.h      |  30 ++
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 326 +++++++++++++++++++++
 9 files changed, 391 insertions(+)
 create mode 100644 drivers/crypto/intel/Kconfig
 create mode 100644 drivers/crypto/intel/Makefile
 create mode 100644 drivers/crypto/intel/iaa/Kconfig
 create mode 100644 drivers/crypto/intel/iaa/Makefile
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto.h
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc8bd26b6cf..2db8b4940de8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10313,6 +10313,13 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
 F:	drivers/dma/ioat*
 
+INTEL IAA CRYPTO DRIVER
+M:	Tom Zanussi <tom.zanussi@linux.intel.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+F:	drivers/crypto/intel/iaa/*
+
 INTEL IDXD DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3b2516d1433f..56466eeb4eef 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -506,6 +506,7 @@ source "drivers/crypto/qat/Kconfig"
 source "drivers/crypto/cavium/cpt/Kconfig"
 source "drivers/crypto/cavium/nitrox/Kconfig"
 source "drivers/crypto/marvell/Kconfig"
+source "drivers/crypto/intel/Kconfig"
 
 config CRYPTO_DEV_CAVIUM_ZIP
 	tristate "Cavium ZIP driver"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 476f1a25ca32..34c1e60d9dd1 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -52,3 +52,4 @@ obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += keembay/
+obj-y += intel/
diff --git a/drivers/crypto/intel/Kconfig b/drivers/crypto/intel/Kconfig
new file mode 100644
index 000000000000..7c9f51b873ea
--- /dev/null
+++ b/drivers/crypto/intel/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+source "drivers/crypto/intel/iaa/Kconfig"
diff --git a/drivers/crypto/intel/Makefile b/drivers/crypto/intel/Makefile
new file mode 100644
index 000000000000..b1263f1f90cc
--- /dev/null
+++ b/drivers/crypto/intel/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
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
index 000000000000..c35a778d53a6
--- /dev/null
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -0,0 +1,326 @@
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
+	wq->private_data = iaa_wq;
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
+
+	idxd_wq_get(wq);
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
+			idxd_wq_put(wq);
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
+	ret = drv_enable_wq(wq);
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
+	drv_disable_wq(wq);
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
+	drv_disable_wq(wq);
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

