Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0306ACD3F
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCFSzJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCFSyu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:54:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655ED79B07;
        Mon,  6 Mar 2023 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128805; x=1709664805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=quzK9fB7Fr3XWUDpEtz1+NyY16J6Kbj/fqzstjTLfrE=;
  b=h709Kk8iA/lDdYAoAnbaa8oNGYolVyE4NEalpM83dymRS3aPqzYBex0b
   HjYeRboGxkvFAdDk91QuJu/ptObRbIWhy3z4oxGwp3XxYTLv77HNp0q73
   IkosIGEKyjXC0y8lM7qB+QEXXmvTZKwAUH3DlSP83FJYAvF8cxwx6M+1g
   6u3finwjQczWBJ5Dx3+O665A1LbqZziwuvifCWWZkHESlUGwOTBbnQ1gX
   b/Uk59TH1V6c3RKe6kvp1xiVWuOZuZg2gEl9Chp4iEBngFjRt5F18rDQM
   SS4H15aaoTZmTqV/IZzSwEyGe1GasYxI+xRHpJXYd4Gj1Ggw/8RlRJQ45
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227849"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255963"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255963"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:08 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 16/16] crypto: iaa - Add IAA Compression Accelerator stats
Date:   Mon,  6 Mar 2023 12:52:26 -0600
Message-Id: <20230306185226.26483-17-tom.zanussi@linux.intel.com>
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

Add support for optional debugfs statistics support for the IAA
Compression Accelerator.  This is enabled by the kernel config item:

  CRYPTO_DEV_IAA_CRYPTO_STATS

When enabled, the IAA crypto driver will generate statistics which can
be accessed at /sys/kernel/debug/iaa-crypto/.

See Documentation/driver-api/crypto/iax/iax-crypto.rst for details.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/iaa/Kconfig            |   9 +
 drivers/crypto/iaa/Makefile           |   2 +
 drivers/crypto/iaa/iaa_crypto.h       |  22 +++
 drivers/crypto/iaa/iaa_crypto_main.c  |  71 +++++++
 drivers/crypto/iaa/iaa_crypto_stats.c | 271 ++++++++++++++++++++++++++
 drivers/crypto/iaa/iaa_crypto_stats.h |  58 ++++++
 6 files changed, 433 insertions(+)
 create mode 100644 drivers/crypto/iaa/iaa_crypto_stats.c
 create mode 100644 drivers/crypto/iaa/iaa_crypto_stats.h

diff --git a/drivers/crypto/iaa/Kconfig b/drivers/crypto/iaa/Kconfig
index fcccb6ff7e29..cffb3a4359fc 100644
--- a/drivers/crypto/iaa/Kconfig
+++ b/drivers/crypto/iaa/Kconfig
@@ -8,3 +8,12 @@ config CRYPTO_DEV_IAA_CRYPTO
 	  decompression with the Intel Analytics Accelerator (IAA)
 	  hardware using the cryptographic API.  If you choose 'M'
 	  here, the module will be called iaa_crypto.
+
+config CRYPTO_DEV_IAA_CRYPTO_STATS
+	bool "Enable Intel(R) IAA Compression Accelerator Statistics"
+	depends on CRYPTO_DEV_IAA_CRYPTO
+	default n
+	help
+          Enable statistics for the IAA compression accelerator.
+	  These include per-device and per-workqueue statistics in
+	  addition to global driver statistics.
diff --git a/drivers/crypto/iaa/Makefile b/drivers/crypto/iaa/Makefile
index ff6ab1d0bc13..2a1bee385932 100644
--- a/drivers/crypto/iaa/Makefile
+++ b/drivers/crypto/iaa/Makefile
@@ -8,3 +8,5 @@ ccflags-y += -I $(srctree)/drivers/dma/idxd -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 obj-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO) := iaa_crypto.o
 
 iaa_crypto-y := iaa_crypto_main.o iaa_crypto_comp_canned.o iaa_crypto_comp_fixed.o
+
+iaa_crypto-$(CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS) += iaa_crypto_stats.o
diff --git a/drivers/crypto/iaa/iaa_crypto.h b/drivers/crypto/iaa/iaa_crypto.h
index ed910201e2fc..b7842d2df682 100644
--- a/drivers/crypto/iaa/iaa_crypto.h
+++ b/drivers/crypto/iaa/iaa_crypto.h
@@ -44,6 +44,11 @@ struct iaa_wq {
 	struct idxd_wq		*wq;
 
 	struct iaa_device	*iaa_device;
+
+	u64			comp_calls;
+	u64			comp_bytes;
+	u64			decomp_calls;
+	u64			decomp_bytes;
 };
 
 struct iaa_device_compression_mode {
@@ -66,6 +71,11 @@ struct iaa_device {
 
 	int				n_wq;
 	struct list_head		wqs;
+
+	u64				comp_calls;
+	u64				comp_bytes;
+	u64				decomp_calls;
+	u64				decomp_bytes;
 };
 
 struct wq_table_entry {
@@ -146,4 +156,16 @@ int add_iaa_compression_mode(const char *name,
 void remove_iaa_compression_mode(const char *name);
 int set_iaa_compression_mode(const char *name);
 
+#if defined(CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS)
+void	global_stats_show(struct seq_file *m);
+void	device_stats_show(struct seq_file *m, struct iaa_device *iaa_device);
+void	reset_iaa_crypto_stats(void);
+void	reset_device_stats(struct iaa_device *iaa_device);
+#else
+static inline void	global_stats_show(struct seq_file *m) {}
+static inline void	device_stats_show(struct seq_file *m, struct iaa_device *iaa_device) {}
+static inline void	reset_iaa_crypto_stats(void) {}
+static inline void	reset_device_stats(struct iaa_device *iaa_device) {}
+#endif
+
 #endif
diff --git a/drivers/crypto/iaa/iaa_crypto_main.c b/drivers/crypto/iaa/iaa_crypto_main.c
index aedf06a0c1ec..5292f9f0480d 100644
--- a/drivers/crypto/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/iaa/iaa_crypto_main.c
@@ -14,6 +14,7 @@
 
 #include "idxd.h"
 #include "iaa_crypto.h"
+#include "iaa_crypto_stats.h"
 
 #ifdef pr_fmt
 #undef pr_fmt
@@ -1101,6 +1102,7 @@ static inline int check_completion(struct device *dev,
 			ret = -ETIMEDOUT;
 			dev_dbg(dev, "%s timed out, size=0x%x\n",
 				op_str, comp->output_size);
+			update_completion_timeout_errs();
 			goto out;
 		}
 
@@ -1110,6 +1112,7 @@ static inline int check_completion(struct device *dev,
 			dev_dbg(dev, "compressed > uncompressed size,"
 				" not compressing, size=0x%x\n",
 				comp->output_size);
+			update_completion_comp_buf_overflow_errs();
 			goto out;
 		}
 
@@ -1117,6 +1120,7 @@ static inline int check_completion(struct device *dev,
 		dev_dbg(dev, "iaa %s status=0x%x, error=0x%x, size=0x%x\n",
 			op_str, comp->status, comp->error_code, comp->output_size);
 		print_hex_dump(KERN_INFO, "cmp-rec: ", DUMP_PREFIX_OFFSET, 8, 1, comp, 64, 0);
+		update_completion_einval_errs();
 
 		goto out;
 	}
@@ -1161,6 +1165,15 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 
 	ctx->req->dlen = idxd_desc->iax_completion->output_size;
 
+	/* Update stats */
+	if (ctx->compress) {
+		update_total_comp_bytes_out(ctx->req->dlen);
+		update_wq_comp_bytes(iaa_wq->wq, ctx->req->dlen);
+	} else {
+		update_total_decomp_bytes_in(ctx->req->dlen);
+		update_wq_decomp_bytes(iaa_wq->wq, ctx->req->dlen);
+	}
+
 	if (ctx->compress && iaa_verify_compress) {
 		u32 compression_crc;
 
@@ -1261,6 +1274,10 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 		goto err;
 	}
 
+	/* Update stats */
+	update_total_comp_calls();
+	update_wq_comp_calls(wq);
+
 	if (req && async_mode && !disable_async) {
 		ret = -EINPROGRESS;
 		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
@@ -1275,6 +1292,10 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*dlen = idxd_desc->iax_completion->output_size;
 
+	/* Update stats */
+	update_total_comp_bytes_out(*dlen);
+	update_wq_comp_bytes(wq, *dlen);
+
 	*compression_crc = idxd_desc->iax_completion->crc;
 
 	idxd_free_desc(wq, idxd_desc);
@@ -1451,6 +1472,10 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		goto err;
 	}
 
+	/* Update stats */
+	update_total_decomp_calls();
+	update_wq_decomp_calls(wq);
+
 	if (req && async_mode && !disable_async) {
 		ret = -EINPROGRESS;
 		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
@@ -1466,6 +1491,10 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	*dlen = idxd_desc->iax_completion->output_size;
 
 	idxd_free_desc(wq, idxd_desc);
+
+	/* Update stats */
+	update_total_decomp_bytes_in(slen);
+	update_wq_decomp_bytes(wq, slen);
 out:
 	return ret;
 err:
@@ -1483,6 +1512,7 @@ static int iaa_comp_compress(struct crypto_tfm *tfm,
 	u32 compression_crc;
 	struct idxd_wq *wq;
 	struct device *dev;
+	u64 start_time_ns;
 	int cpu, ret = 0;
 
 	if (!iaa_crypto_enabled) {
@@ -1522,8 +1552,10 @@ static int iaa_comp_compress(struct crypto_tfm *tfm,
 		" dst_addr %llx, dlen %u\n", src, src_addr,
 		slen, dst, dst_addr, *dlen);
 
+	start_time_ns = iaa_get_ts();
 	ret = iaa_compress(tfm, NULL, wq, src_addr, slen, dst_addr,
 			   dlen, &compression_crc, true);
+	update_max_comp_delay_ns(start_time_ns);
 	if (iaa_verify_compress) {
 		dma_sync_single_for_device(dev, dst_addr, *dlen, DMA_FROM_DEVICE);
 		dma_sync_single_for_device(dev, src_addr, slen, DMA_TO_DEVICE);
@@ -1548,6 +1580,7 @@ static int iaa_comp_decompress(struct crypto_tfm *tfm,
 	dma_addr_t src_addr, dst_addr;
 	struct idxd_wq *wq;
 	struct device *dev;
+	u64 start_time_ns;
 	int cpu, ret = 0;
 
 	if (!iaa_crypto_enabled) {
@@ -1589,7 +1622,9 @@ static int iaa_comp_decompress(struct crypto_tfm *tfm,
 		" dst_addr %llx, dlen %u\n", src, src_addr,
 		slen, dst, dst_addr, *dlen);
 
+	start_time_ns = iaa_get_ts();
 	ret = iaa_decompress(tfm, NULL, wq, src_addr, slen, dst_addr, dlen, true);
+	update_max_decomp_delay_ns(start_time_ns);
 	if (ret != 0)
 		dev_dbg(dev, "synchronous decompress failed ret=%d\n", ret);
 
@@ -1925,6 +1960,38 @@ static struct idxd_device_driver iaa_crypto_driver = {
 	.desc_complete = iaa_desc_complete,
 };
 
+int wq_stats_show(struct seq_file *m, void *v)
+{
+	struct iaa_device *iaa_device;
+
+	mutex_lock(&iaa_devices_lock);
+
+	global_stats_show(m);
+
+	list_for_each_entry(iaa_device, &iaa_devices, list)
+		device_stats_show(m, iaa_device);
+
+	mutex_unlock(&iaa_devices_lock);
+
+	return 0;
+}
+
+int iaa_crypto_stats_reset(void *data, u64 value)
+{
+	struct iaa_device *iaa_device;
+
+	reset_iaa_crypto_stats();
+
+	mutex_lock(&iaa_devices_lock);
+
+	list_for_each_entry(iaa_device, &iaa_devices, list)
+		reset_device_stats(iaa_device);
+
+	mutex_unlock(&iaa_devices_lock);
+
+	return 0;
+}
+
 static int __init iaa_crypto_init_module(void)
 {
 	int ret = 0;
@@ -1973,6 +2040,9 @@ static int __init iaa_crypto_init_module(void)
 		goto err_compression_mode;
 	}
 
+	if (iaa_crypto_debugfs_init())
+		pr_warn("debugfs init failed, stats not available\n");
+
 	pr_debug("initialized\n");
 out:
 	return ret;
@@ -1992,6 +2062,7 @@ static int __init iaa_crypto_init_module(void)
 
 static void __exit iaa_crypto_cleanup_module(void)
 {
+	iaa_crypto_debugfs_cleanup();
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
diff --git a/drivers/crypto/iaa/iaa_crypto_stats.c b/drivers/crypto/iaa/iaa_crypto_stats.c
new file mode 100644
index 000000000000..336847b83085
--- /dev/null
+++ b/drivers/crypto/iaa/iaa_crypto_stats.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <uapi/linux/idxd.h>
+#include <linux/idxd.h>
+#include <linux/dmaengine.h>
+#include "../../dma/idxd/idxd.h"
+#include <linux/debugfs.h>
+#include <crypto/internal/acompress.h>
+#include "iaa_crypto.h"
+#include "iaa_crypto_stats.h"
+
+static u64 total_comp_calls;
+static u64 total_decomp_calls;
+static u64 max_comp_delay_ns;
+static u64 max_decomp_delay_ns;
+static u64 max_acomp_delay_ns;
+static u64 max_adecomp_delay_ns;
+static u64 total_comp_bytes_out;
+static u64 total_decomp_bytes_in;
+static u64 total_completion_einval_errors;
+static u64 total_completion_timeout_errors;
+static u64 total_completion_comp_buf_overflow_errors;
+
+static struct dentry *iaa_crypto_debugfs_root;
+
+void update_total_comp_calls(void)
+{
+	total_comp_calls++;
+}
+
+void update_total_comp_bytes_out(int n)
+{
+	total_comp_bytes_out += n;
+}
+
+void update_total_decomp_calls(void)
+{
+	total_decomp_calls++;
+}
+
+void update_total_decomp_bytes_in(int n)
+{
+	total_decomp_bytes_in += n;
+}
+
+void update_completion_einval_errs(void)
+{
+	total_completion_einval_errors++;
+}
+
+void update_completion_timeout_errs(void)
+{
+	total_completion_timeout_errors++;
+}
+
+void update_completion_comp_buf_overflow_errs(void)
+{
+	total_completion_comp_buf_overflow_errors++;
+}
+
+void update_max_comp_delay_ns(u64 start_time_ns)
+{
+	u64 time_diff;
+
+	time_diff = ktime_get_ns() - start_time_ns;
+
+	if (time_diff > max_comp_delay_ns)
+		max_comp_delay_ns = time_diff;
+}
+
+void update_max_decomp_delay_ns(u64 start_time_ns)
+{
+	u64 time_diff;
+
+	time_diff = ktime_get_ns() - start_time_ns;
+
+	if (time_diff > max_decomp_delay_ns)
+		max_decomp_delay_ns = time_diff;
+}
+
+void update_max_acomp_delay_ns(u64 start_time_ns)
+{
+	u64 time_diff;
+
+	time_diff = ktime_get_ns() - start_time_ns;
+
+	if (time_diff > max_acomp_delay_ns)
+		max_acomp_delay_ns = time_diff;
+}
+
+void update_max_adecomp_delay_ns(u64 start_time_ns)
+{
+	u64 time_diff;
+
+	time_diff = ktime_get_ns() - start_time_ns;
+
+	if (time_diff > max_adecomp_delay_ns)
+
+		max_adecomp_delay_ns = time_diff;
+}
+
+void update_wq_comp_calls(struct idxd_wq *idxd_wq)
+{
+	struct iaa_wq *wq = idxd_wq->private_data;
+
+	wq->comp_calls++;
+	wq->iaa_device->comp_calls++;
+}
+
+void update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n)
+{
+	struct iaa_wq *wq = idxd_wq->private_data;
+
+	wq->comp_bytes += n;
+	wq->iaa_device->comp_bytes += n;
+}
+
+void update_wq_decomp_calls(struct idxd_wq *idxd_wq)
+{
+	struct iaa_wq *wq = idxd_wq->private_data;
+
+	wq->decomp_calls++;
+	wq->iaa_device->decomp_calls++;
+}
+
+void update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n)
+{
+	struct iaa_wq *wq = idxd_wq->private_data;
+
+	wq->decomp_bytes += n;
+	wq->iaa_device->decomp_bytes += n;
+}
+
+void reset_iaa_crypto_stats(void)
+{
+	total_comp_calls = 0;
+	total_decomp_calls = 0;
+	max_comp_delay_ns = 0;
+	max_decomp_delay_ns = 0;
+	max_acomp_delay_ns = 0;
+	max_adecomp_delay_ns = 0;
+	total_comp_bytes_out = 0;
+	total_decomp_bytes_in = 0;
+	total_completion_einval_errors = 0;
+	total_completion_timeout_errors = 0;
+	total_completion_comp_buf_overflow_errors = 0;
+}
+
+static void reset_wq_stats(struct iaa_wq *wq)
+{
+	wq->comp_calls = 0;
+	wq->comp_bytes = 0;
+	wq->decomp_calls = 0;
+	wq->decomp_bytes = 0;
+}
+
+void reset_device_stats(struct iaa_device *iaa_device)
+{
+	struct iaa_wq *iaa_wq;
+
+	iaa_device->comp_calls = 0;
+	iaa_device->comp_bytes = 0;
+	iaa_device->decomp_calls = 0;
+	iaa_device->decomp_bytes = 0;
+
+	list_for_each_entry(iaa_wq, &iaa_device->wqs, list)
+		reset_wq_stats(iaa_wq);
+}
+
+static void wq_show(struct seq_file *m, struct iaa_wq *iaa_wq)
+{
+	seq_printf(m, "    name: %s\n", iaa_wq->wq->name);
+	seq_printf(m, "    comp_calls: %llu\n", iaa_wq->comp_calls);
+	seq_printf(m, "    comp_bytes: %llu\n", iaa_wq->comp_bytes);
+	seq_printf(m, "    decomp_calls: %llu\n", iaa_wq->decomp_calls);
+	seq_printf(m, "    decomp_bytes: %llu\n\n", iaa_wq->decomp_bytes);
+}
+
+void device_stats_show(struct seq_file *m, struct iaa_device *iaa_device)
+{
+	struct iaa_wq *iaa_wq;
+
+	seq_puts(m, "iaa device:\n");
+	seq_printf(m, "  id: %d\n", iaa_device->idxd->id);
+	seq_printf(m, "  n_wqs: %d\n", iaa_device->n_wq);
+	seq_printf(m, "  comp_calls: %llu\n", iaa_device->comp_calls);
+	seq_printf(m, "  comp_bytes: %llu\n", iaa_device->comp_bytes);
+	seq_printf(m, "  decomp_calls: %llu\n", iaa_device->decomp_calls);
+	seq_printf(m, "  decomp_bytes: %llu\n", iaa_device->decomp_bytes);
+	seq_puts(m, "  wqs:\n");
+
+	list_for_each_entry(iaa_wq, &iaa_device->wqs, list)
+		wq_show(m, iaa_wq);
+}
+
+void global_stats_show(struct seq_file *m)
+{
+	seq_puts(m, "global stats:\n");
+	seq_printf(m, "  total_comp_calls: %llu\n", total_comp_calls);
+	seq_printf(m, "  total_decomp_calls: %llu\n", total_decomp_calls);
+	seq_printf(m, "  total_comp_bytes_out: %llu\n", total_comp_bytes_out);
+	seq_printf(m, "  total_decomp_bytes_in: %llu\n", total_decomp_bytes_in);
+	seq_printf(m, "  total_completion_einval_errors: %llu\n",
+		   total_completion_einval_errors);
+	seq_printf(m, "  total_completion_timeout_errors: %llu\n",
+		   total_completion_timeout_errors);
+	seq_printf(m, "  total_completion_comp_buf_overflow_errors: %llu\n\n",
+		   total_completion_comp_buf_overflow_errors);
+}
+
+static int wq_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, wq_stats_show, file);
+}
+
+const struct file_operations wq_stats_fops = {
+	.open = wq_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+DEFINE_DEBUGFS_ATTRIBUTE(wq_stats_reset_fops, NULL, iaa_crypto_stats_reset, "%llu\n");
+
+int __init iaa_crypto_debugfs_init(void)
+{
+	if (!debugfs_initialized())
+		return -ENODEV;
+
+	iaa_crypto_debugfs_root = debugfs_create_dir("iaa_crypto", NULL);
+	if (!iaa_crypto_debugfs_root)
+		return -ENOMEM;
+
+	debugfs_create_u64("max_comp_delay_ns", 0644,
+			   iaa_crypto_debugfs_root, &max_comp_delay_ns);
+	debugfs_create_u64("max_decomp_delay_ns", 0644,
+			   iaa_crypto_debugfs_root, &max_decomp_delay_ns);
+	debugfs_create_u64("max_acomp_delay_ns", 0644,
+			   iaa_crypto_debugfs_root, &max_comp_delay_ns);
+	debugfs_create_u64("max_adecomp_delay_ns", 0644,
+			   iaa_crypto_debugfs_root, &max_decomp_delay_ns);
+	debugfs_create_u64("total_comp_calls", 0644,
+			   iaa_crypto_debugfs_root, &total_comp_calls);
+	debugfs_create_u64("total_decomp_calls", 0644,
+			   iaa_crypto_debugfs_root, &total_decomp_calls);
+	debugfs_create_u64("total_comp_bytes_out", 0644,
+			   iaa_crypto_debugfs_root, &total_comp_bytes_out);
+	debugfs_create_u64("total_decomp_bytes_in", 0644,
+			   iaa_crypto_debugfs_root, &total_decomp_bytes_in);
+	debugfs_create_file("wq_stats", 0644, iaa_crypto_debugfs_root, NULL,
+			    &wq_stats_fops);
+	debugfs_create_file("stats_reset", 0644, iaa_crypto_debugfs_root, NULL,
+			    &wq_stats_reset_fops);
+
+	return 0;
+}
+
+void __exit iaa_crypto_debugfs_cleanup(void)
+{
+	debugfs_remove_recursive(iaa_crypto_debugfs_root);
+}
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/iaa/iaa_crypto_stats.h b/drivers/crypto/iaa/iaa_crypto_stats.h
new file mode 100644
index 000000000000..ad8333329fa6
--- /dev/null
+++ b/drivers/crypto/iaa/iaa_crypto_stats.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
+
+#ifndef __CRYPTO_DEV_IAA_CRYPTO_STATS_H__
+#define __CRYPTO_DEV_IAA_CRYPTO_STATS_H__
+
+#if defined(CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS)
+int	iaa_crypto_debugfs_init(void);
+void	iaa_crypto_debugfs_cleanup(void);
+
+void	update_total_comp_calls(void);
+void	update_total_comp_bytes_out(int n);
+void	update_total_decomp_calls(void);
+void	update_total_decomp_bytes_in(int n);
+void	update_max_comp_delay_ns(u64 start_time_ns);
+void	update_max_decomp_delay_ns(u64 start_time_ns);
+void	update_max_acomp_delay_ns(u64 start_time_ns);
+void	update_max_adecomp_delay_ns(u64 start_time_ns);
+void	update_completion_einval_errs(void);
+void	update_completion_timeout_errs(void);
+void	update_completion_comp_buf_overflow_errs(void);
+
+void	update_wq_comp_calls(struct idxd_wq *idxd_wq);
+void	update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n);
+void	update_wq_decomp_calls(struct idxd_wq *idxd_wq);
+void	update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n);
+
+int	wq_stats_show(struct seq_file *m, void *v);
+int	iaa_crypto_stats_reset(void *data, u64 value);
+
+static inline u64	iaa_get_ts(void) { return ktime_get_ns(); }
+
+#else
+static inline int	iaa_crypto_debugfs_init(void) { return 0; }
+static inline void	iaa_crypto_debugfs_cleanup(void) {}
+
+static inline void	update_total_comp_calls(void) {}
+static inline void	update_total_comp_bytes_out(int n) {}
+static inline void	update_total_decomp_calls(void) {}
+static inline void	update_total_decomp_bytes_in(int n) {}
+static inline void	update_max_comp_delay_ns(u64 start_time_ns) {}
+static inline void	update_max_decomp_delay_ns(u64 start_time_ns) {}
+static inline void	update_max_acomp_delay_ns(u64 start_time_ns) {}
+static inline void	update_max_adecomp_delay_ns(u64 start_time_ns) {}
+static inline void	update_completion_einval_errs(void) {}
+static inline void	update_completion_timeout_errs(void) {}
+static inline void	update_completion_comp_buf_overflow_errs(void) {}
+
+static inline void	update_wq_comp_calls(struct idxd_wq *idxd_wq) {}
+static inline void	update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n) {}
+static inline void	update_wq_decomp_calls(struct idxd_wq *idxd_wq) {}
+static inline void	update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n) {}
+
+static inline u64	iaa_get_ts(void) { return 0; }
+
+#endif // CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS
+
+#endif
-- 
2.34.1

