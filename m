Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227D66ACD2C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCFSxm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCFSx0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:53:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2C271C;
        Mon,  6 Mar 2023 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128773; x=1709664773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5HUmfxrM8xSxXSlb+w7H0MXJqXI9H3bd/PqVDb4Ba4=;
  b=jMI6kgekCbvJalWJ4dLxeHup3faSDSw1AxzIH9Xy7Fv1BfkPEJK7uySZ
   a5EbpdiP4uONC6C2egyGLYeOaR6zsATS2mhPS7aFk5FGTCPSoSnu7sZ8Z
   U65bYVwqEm8OnRRWHJgrHCMV94hNn/6EujC2rVQHmQTa5L1cETA2kQEYj
   +quwnKCh4LVJ+7A7cCg93HS/v5/vHTH+vG7qbM3SVdw3HxZ1x6gV+6SRJ
   gAPRJVbYlfvC3oTGcIXAiatCEiTS6LnpB6AePz6cgW73psdkGQbbu58We
   LMUmX+z6o32r30H/IqKWTvRZg8G6c7iCsGLqEIhGvuxZDS2ffluAUWwUV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227748"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227748"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255834"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255834"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:51 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 09/16] crypto: iaa - Add Intel IAA Compression Accelerator crypto driver core
Date:   Mon,  6 Mar 2023 12:52:19 -0600
Message-Id: <20230306185226.26483-10-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
allows compression algorithms to be selected.

For example, a zram drive can select iaa_crypto via:

  # echo iaa_crypto > /sys/block/zram1/comp_algorithm

Similarly for zswap:

  # echo iaa_crypto > /sys/module/zswap/parameters/compressor

This patch adds iaa_crypto as an idxd sub-driver and tracks iaa
devices and workqueues as they are probed or removed.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/Kconfig               |   1 +
 drivers/crypto/Makefile              |   1 +
 drivers/crypto/iaa/Kconfig           |  10 +
 drivers/crypto/iaa/Makefile          |  10 +
 drivers/crypto/iaa/iaa_crypto.h      |  30 +++
 drivers/crypto/iaa/iaa_crypto_main.c | 326 +++++++++++++++++++++++++++
 6 files changed, 378 insertions(+)
 create mode 100644 drivers/crypto/iaa/Kconfig
 create mode 100644 drivers/crypto/iaa/Makefile
 create mode 100644 drivers/crypto/iaa/iaa_crypto.h
 create mode 100644 drivers/crypto/iaa/iaa_crypto_main.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 3b2516d1433f..46123f59f9a6 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -506,6 +506,7 @@ source "drivers/crypto/qat/Kconfig"
 source "drivers/crypto/cavium/cpt/Kconfig"
 source "drivers/crypto/cavium/nitrox/Kconfig"
 source "drivers/crypto/marvell/Kconfig"
+source "drivers/crypto/iaa/Kconfig"
 
 config CRYPTO_DEV_CAVIUM_ZIP
 	tristate "Cavium ZIP driver"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 476f1a25ca32..d96fc84ce755 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CRYPTO_DEV_ATMEL_I2C) += atmel-i2c.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_ECC) += atmel-ecc.o
 obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA204A) += atmel-sha204a.o
 obj-$(CONFIG_CRYPTO_DEV_CAVIUM_ZIP) += cavium/
+obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) += iaa/
 obj-$(CONFIG_CRYPTO_DEV_CCP) += ccp/
 obj-$(CONFIG_CRYPTO_DEV_CCREE) += ccree/
 obj-$(CONFIG_CRYPTO_DEV_CHELSIO) += chelsio/
diff --git a/drivers/crypto/iaa/Kconfig b/drivers/crypto/iaa/Kconfig
new file mode 100644
index 000000000000..fcccb6ff7e29
--- /dev/null
+++ b/drivers/crypto/iaa/Kconfig
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
diff --git a/drivers/crypto/iaa/Makefile b/drivers/crypto/iaa/Makefile
new file mode 100644
index 000000000000..03859431c897
--- /dev/null
+++ b/drivers/crypto/iaa/Makefile
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
diff --git a/drivers/crypto/iaa/iaa_crypto.h b/drivers/crypto/iaa/iaa_crypto.h
new file mode 100644
index 000000000000..5d1fff7f4b8e
--- /dev/null
+++ b/drivers/crypto/iaa/iaa_crypto.h
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
diff --git a/drivers/crypto/iaa/iaa_crypto_main.c b/drivers/crypto/iaa/iaa_crypto_main.c
new file mode 100644
index 000000000000..e7e7fbdd72e3
--- /dev/null
+++ b/drivers/crypto/iaa/iaa_crypto_main.c
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
+	ret = drv_enable_wq(wq, IDXD_DTYPE_CRYPTO);
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

