Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37B26CC6A9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjC1Phx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjC1PhY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:37:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E610A8D;
        Tue, 28 Mar 2023 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017789; x=1711553789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUQWBKoEay5lSyWxB1ceVbzFgGonXWTiuBfn0q/PydE=;
  b=OyNYHFp4TF6fo4JgeSWuJC1uiSTtgNaZpIb1FKkmhPZeYe86FfrzyEmi
   dFMcHLgNKoAU1Gf5n9qVWS6mrKejAn88drNtBWhGdhQoOnZ76eBlmcudH
   LJDukVX+i6E25Ym5TV8jw69h+gjDh4BGwNRW12zB5nUVmqPDcKvCH+ZxR
   OFIOfVh4yEyXExJNZQh8PLcXU8SToNTJFathX0+dizPDyZstdsk8G5+X8
   KJzqMgvpLPE0ehSP9ynuMhaDFEEr1odgrtHtkhN23SZQYkoK71QjiuY3n
   KROJLxN7LTpo5PXwLQb7qmI1DT4ilkcrjE2DrJRHiTio1mi7/7SHGzoLM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342192222"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342192222"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683948487"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683948487"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:10 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 12/15] crypto: iaa - Add support for iaa_crypto deflate compression algorithm
Date:   Tue, 28 Mar 2023 10:35:32 -0500
Message-Id: <20230328153535.126223-13-tom.zanussi@linux.intel.com>
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

This patch registers the iaa_crypto deflate compression algorithm and
hooks it up to the IAA hardware.

With this change, the IAA crypto algorithm is operational and
compression and decompression operations are fully enabled following
the successful binding of the first IAA workqueue to the iaa_crypto
sub-driver, and similarly, the IAA crypto algorithm is automatically
unregistered when there are no IAA workqueues bound to the driver,
following their removal.

A new iaa_crypto 'verify_compress' driver attribute is also added,
allowing the user to toggle compression verification.  If set, each
compress will be internally decompressed and the contents verified,
returning error codes if unsuccessful.  This can be toggled with 0/1:

  echo 0 > /sys/bus/dsa/drivers/crypto/verify_compress

The default setting is '1' - verify all compresses.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |  24 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 728 ++++++++++++++++++++-
 2 files changed, 751 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 2daa3522e073..7ed3d8de250d 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -10,11 +10,35 @@
 
 #define IDXD_SUBDRIVER_NAME		"crypto"
 
+#define IAA_DECOMP_ENABLE		BIT(0)
+#define IAA_DECOMP_FLUSH_OUTPUT		BIT(1)
+#define IAA_DECOMP_CHECK_FOR_EOB	BIT(2)
+#define IAA_DECOMP_STOP_ON_EOB		BIT(3)
+#define IAA_DECOMP_SUPPRESS_OUTPUT	BIT(9)
+
+#define IAA_COMP_FLUSH_OUTPUT		BIT(1)
+#define IAA_COMP_APPEND_EOB		BIT(2)
+
+#define IAA_COMPLETION_TIMEOUT		1000000
+
+#define IAA_ANALYTICS_ERROR		0x0a
+#define IAA_ERROR_DECOMP_BUF_OVERFLOW	0x0b
+#define IAA_ERROR_COMP_BUF_OVERFLOW	0x19
+#define IAA_ERROR_WATCHDOG_EXPIRED	0x24
+
 #define IAA_COMP_MODES_MAX		2
 
 #define FIXED_HDR			0x2
 #define FIXED_HDR_SIZE			3
 
+#define IAA_COMP_FLAGS			(IAA_COMP_FLUSH_OUTPUT | \
+					 IAA_COMP_APPEND_EOB)
+
+#define IAA_DECOMP_FLAGS		(IAA_DECOMP_ENABLE |	   \
+					 IAA_DECOMP_FLUSH_OUTPUT | \
+					 IAA_DECOMP_CHECK_FOR_EOB | \
+					 IAA_DECOMP_STOP_ON_EOB)
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 1ee7e3052177..d0b1ac45cc51 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/idxd.h>
 #include <linux/highmem.h>
 #include <linux/sched/smt.h>
+#include <crypto/internal/acompress.h>
 
 #include "idxd.h"
 #include "iaa_crypto.h"
@@ -20,6 +21,8 @@
 
 #define pr_fmt(fmt)			"idxd: " IDXD_SUBDRIVER_NAME ": " fmt
 
+#define IAA_ALG_PRIORITY		300
+
 /* number of iaa instances probed */
 static unsigned int nr_iaa;
 static unsigned int nr_cpus;
@@ -32,6 +35,20 @@ static unsigned int cpus_per_iaa;
 /* Per-cpu lookup table for balanced wqs */
 static struct wq_table_entry __percpu *wq_table;
 
+static struct idxd_wq *wq_table_next_wq(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
+
+	if (++entry->cur_wq >= entry->n_wqs)
+		entry->cur_wq = 0;
+
+	pr_debug("%s: returning wq at idx %d (iaa wq %d.%d) from cpu %d\n", __func__,
+		 entry->cur_wq, entry->wqs[entry->cur_wq]->idxd->id,
+		 entry->wqs[entry->cur_wq]->id, cpu);
+
+	return entry->wqs[entry->cur_wq];
+}
+
 static void wq_table_add(int cpu, struct idxd_wq *wq)
 {
 	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
@@ -66,6 +83,39 @@ static void wq_table_clear_entry(int cpu)
 static LIST_HEAD(iaa_devices);
 static DEFINE_MUTEX(iaa_devices_lock);
 
+/* If enabled, IAA hw crypto algos are registered, unavailable otherwise */
+static bool iaa_crypto_enabled;
+
+/* Verify results of IAA compress or not */
+static bool iaa_verify_compress = true;
+
+static ssize_t verify_compress_show(struct device_driver *driver, char *buf)
+{
+	return sprintf(buf, "%d\n", iaa_verify_compress);
+}
+
+static ssize_t verify_compress_store(struct device_driver *driver,
+				     const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = kstrtobool(buf, &iaa_verify_compress);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(verify_compress);
+
 static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 static int active_compression_mode;
 
@@ -86,6 +136,9 @@ static ssize_t compression_mode_store(struct device_driver *driver,
 
 	mutex_lock(&iaa_devices_lock);
 
+	if (iaa_crypto_enabled)
+		goto out;
+
 	mode_name = kstrndup(buf, count, GFP_KERNEL);
 	if (!mode_name) {
 		ret = -ENOMEM;
@@ -350,6 +403,89 @@ static void free_device_compression_mode(struct iaa_device *iaa_device,
 	kfree(device_mode);
 }
 
+#define IDXD_OP_FLAG_AECS_RW_TGLS       0x400000
+#define IAX_AECS_DEFAULT_FLAG (IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC)
+#define IAX_AECS_COMPRESS_FLAG	(IAX_AECS_DEFAULT_FLAG | IDXD_OP_FLAG_RD_SRC2_AECS)
+#define IAX_AECS_DECOMPRESS_FLAG (IAX_AECS_DEFAULT_FLAG | IDXD_OP_FLAG_RD_SRC2_AECS)
+#define IAX_AECS_GEN_FLAG (IAX_AECS_DEFAULT_FLAG | \
+						IDXD_OP_FLAG_WR_SRC2_AECS_COMP | \
+						IDXD_OP_FLAG_AECS_RW_TGLS)
+
+static int check_completion(struct device *dev,
+			    struct iax_completion_record *comp,
+			    bool compress,
+			    bool only_once);
+
+static int decompress_header(struct iaa_device_compression_mode *device_mode,
+			     struct iaa_compression_mode *mode,
+			     struct idxd_wq *wq)
+{
+	dma_addr_t src_addr, src2_addr;
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct device *dev;
+	int ret = 0;
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc))
+		return PTR_ERR(idxd_desc);
+
+	desc = idxd_desc->iax_hw;
+
+	dev = &wq->idxd->pdev->dev;
+
+	src_addr = dma_map_single(dev, (void *)mode->header_table,
+				  mode->header_table_size, DMA_TO_DEVICE);
+	dev_dbg(dev, "%s: mode->name %s, src_addr %llx, dev %p, src %p, slen %d\n",
+		__func__, mode->name, src_addr,	dev,
+		mode->header_table, mode->header_table_size);
+	if (unlikely(dma_mapping_error(dev, src_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	desc->flags = IAX_AECS_GEN_FLAG;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->src1_size = mode->header_table_size;
+
+	src2_addr = device_mode->aecs_decomp_table_dma_addr;
+	desc->src2_addr = (u64)src2_addr;
+	desc->src2_size = 1088;
+	dev_dbg(dev, "%s: mode->name %s, src2_addr %llx, dev %p, src2_size %d\n",
+		__func__, mode->name, desc->src2_addr, dev, desc->src2_size);
+	desc->max_dst_size = 0; // suppressed output
+
+	desc->decompr_flags = mode->gen_decomp_table_flags;
+
+#ifdef SPR_E0
+	desc->priv = 1;
+#else
+	desc->priv = 0;
+#endif
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		pr_err("%s: submit_desc failed ret=0x%x\n", __func__, ret);
+		goto out;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret)
+		dev_dbg(dev, "%s: mode->name %s check_completion failed ret=%d\n",
+			__func__, mode->name, ret);
+	else
+		dev_dbg(dev, "%s: mode->name %s succeeded\n", __func__,
+			mode->name);
+out:
+	dma_unmap_single(dev, src2_addr, 1088, DMA_TO_DEVICE);
+
+	return ret;
+}
+
 static int init_device_compression_mode(struct iaa_device *iaa_device,
 					struct iaa_compression_mode *mode,
 					int idx, struct idxd_wq *wq)
@@ -382,6 +518,14 @@ static int init_device_compression_mode(struct iaa_device *iaa_device,
 	memcpy(device_mode->aecs_comp_table->ll_sym, mode->ll_table, mode->ll_table_size);
 	memcpy(device_mode->aecs_comp_table->d_sym, mode->d_table, mode->d_table_size);
 
+	if (mode->header_table) {
+		ret = decompress_header(device_mode, mode, wq);
+		if (ret) {
+			pr_debug("iaa header decompression failed: ret=%d\n", ret);
+			goto free;
+		}
+	}
+
 	if (mode->init) {
 		ret = mode->init(device_mode);
 		if (ret)
@@ -831,6 +975,555 @@ static void rebalance_wq_table(void)
 	}
 }
 
+static inline int check_completion(struct device *dev,
+				   struct iax_completion_record *comp,
+				   bool compress,
+				   bool only_once)
+{
+	char *op_str = compress ? "compress" : "decompress";
+	int ret = 0;
+
+	while (!comp->status) {
+		if (only_once)
+			return -EAGAIN;
+		cpu_relax();
+	}
+
+	if (comp->status != IAX_COMP_SUCCESS) {
+		if (comp->status == IAA_ERROR_WATCHDOG_EXPIRED) {
+			ret = -ETIMEDOUT;
+			dev_dbg(dev, "%s timed out, size=0x%x\n",
+				op_str, comp->output_size);
+			goto out;
+		}
+
+		if (comp->status == IAA_ANALYTICS_ERROR &&
+		    comp->error_code == IAA_ERROR_COMP_BUF_OVERFLOW && compress) {
+			ret = -E2BIG;
+			dev_dbg(dev, "compressed > uncompressed size,"
+				" not compressing, size=0x%x\n",
+				comp->output_size);
+			goto out;
+		}
+
+		if (comp->status == IAA_ERROR_DECOMP_BUF_OVERFLOW) {
+			ret = -EOVERFLOW;
+			goto out;
+		}
+
+		ret = -EINVAL;
+		dev_dbg(dev, "iaa %s status=0x%x, error=0x%x, size=0x%x\n",
+			op_str, comp->status, comp->error_code, comp->output_size);
+		print_hex_dump(KERN_INFO, "cmp-rec: ", DUMP_PREFIX_OFFSET, 8, 1, comp, 64, 0);
+
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
+			struct idxd_wq *wq,
+			dma_addr_t src_addr, unsigned int slen,
+			dma_addr_t dst_addr, unsigned int *dlen,
+			u32 *compression_crc,
+			bool disable_async)
+{
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	iaa_wq = wq->private_data;
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc)) {
+		dev_dbg(dev, "idxd descriptor allocation failed\n");
+		dev_dbg(dev, "iaa compress failed: ret=%ld\n", PTR_ERR(idxd_desc));
+		return PTR_ERR(idxd_desc);
+	}
+	desc = idxd_desc->iax_hw;
+
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR |
+		IDXD_OP_FLAG_RD_SRC2_AECS | IDXD_OP_FLAG_CC;
+	desc->opcode = IAX_OPCODE_COMPRESS;
+	desc->compr_flags = IAA_COMP_FLAGS;
+	desc->priv = 1;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->src1_size = slen;
+	desc->dst_addr = (u64)dst_addr;
+	desc->max_dst_size = *dlen;
+	desc->src2_addr = iaa_wq->iaa_device->active_compression_mode->aecs_comp_table_dma_addr;
+	desc->src2_size = sizeof(struct aecs_comp_table_record);
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	dev_dbg(dev, "%s: compression mode %s,"
+		" desc->src1_addr %llx, desc->src1_size %d,"
+		" desc->dst_addr %llx, desc->max_dst_size %d,"
+		" desc->src2_addr %llx, desc->src2_size %d\n", __func__,
+		iaa_wq->iaa_device->active_compression_mode->name,
+		desc->src1_addr, desc->src1_size, desc->dst_addr,
+		desc->max_dst_size, desc->src2_addr, desc->src2_size);
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
+		goto err;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, true, false);
+	if (ret) {
+		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
+		goto err;
+	}
+
+	*dlen = idxd_desc->iax_completion->output_size;
+
+	*compression_crc = idxd_desc->iax_completion->crc;
+
+	idxd_free_desc(wq, idxd_desc);
+out:
+	return ret;
+err:
+	idxd_free_desc(wq, idxd_desc);
+	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
+
+	goto out;
+}
+
+static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
+			       struct idxd_wq *wq,
+			       dma_addr_t src_addr, unsigned int slen,
+			       dma_addr_t dst_addr, unsigned int *dlen,
+			       u32 compression_crc)
+{
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	iaa_wq = wq->private_data;
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc)) {
+		dev_dbg(dev, "idxd descriptor allocation failed\n");
+		dev_dbg(dev, "iaa compress failed: ret=%ld\n",
+			PTR_ERR(idxd_desc));
+		return PTR_ERR(idxd_desc);
+	}
+	desc = idxd_desc->iax_hw;
+
+	/* Verify (optional) - decompress and check crc, suppress dest write */
+
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+	desc->decompr_flags = IAA_DECOMP_FLAGS | IAA_DECOMP_SUPPRESS_OUTPUT;
+	desc->priv = 1;
+
+	desc->src1_addr = (u64)dst_addr;
+	desc->src1_size = *dlen;
+	desc->dst_addr = (u64)src_addr;
+	desc->max_dst_size = slen;
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	dev_dbg(dev, "(verify) compression mode %s,"
+		" desc->src1_addr %llx, desc->src1_size %d,"
+		" desc->dst_addr %llx, desc->max_dst_size %d,"
+		" desc->src2_addr %llx, desc->src2_size %d\n",
+		iaa_wq->iaa_device->active_compression_mode->name,
+		desc->src1_addr, desc->src1_size, desc->dst_addr,
+		desc->max_dst_size, desc->src2_addr, desc->src2_size);
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		dev_dbg(dev, "submit_desc (verify) failed ret=%d\n", ret);
+		goto err;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret) {
+		dev_dbg(dev, "(verify) check_completion failed ret=%d\n", ret);
+		goto err;
+	}
+
+	if (compression_crc != idxd_desc->iax_completion->crc) {
+		ret = -EINVAL;
+		dev_dbg(dev, "(verify) iaa comp/decomp crc mismatch:"
+			" comp=0x%x, decomp=0x%x\n", compression_crc,
+			idxd_desc->iax_completion->crc);
+		print_hex_dump(KERN_INFO, "cmp-rec: ", DUMP_PREFIX_OFFSET,
+			       8, 1, idxd_desc->iax_completion, 64, 0);
+		goto err;
+	}
+
+	idxd_free_desc(wq, idxd_desc);
+out:
+	return ret;
+err:
+	idxd_free_desc(wq, idxd_desc);
+	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
+
+	goto out;
+}
+
+static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
+			  struct idxd_wq *wq,
+			  dma_addr_t src_addr, unsigned int slen,
+			  dma_addr_t dst_addr, unsigned int *dlen,
+			  bool disable_async)
+{
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	iaa_wq = wq->private_data;
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc)) {
+		dev_dbg(dev, "idxd descriptor allocation failed\n");
+		dev_dbg(dev, "iaa decompress failed: ret=%ld\n",
+			PTR_ERR(idxd_desc));
+		return PTR_ERR(idxd_desc);
+	}
+	desc = idxd_desc->iax_hw;
+
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+	desc->max_dst_size = PAGE_SIZE;
+	desc->decompr_flags = IAA_DECOMP_FLAGS;
+	desc->priv = 1;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->dst_addr = (u64)dst_addr;
+	desc->max_dst_size = *dlen;
+	desc->src1_size = slen;
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	dev_dbg(dev, "%s: decompression mode %s,"
+		" desc->src1_addr %llx, desc->src1_size %d,"
+		" desc->dst_addr %llx, desc->max_dst_size %d,"
+		" desc->src2_addr %llx, desc->src2_size %d\n", __func__,
+		iaa_wq->iaa_device->active_compression_mode->name,
+		desc->src1_addr, desc->src1_size, desc->dst_addr,
+		desc->max_dst_size, desc->src2_addr, desc->src2_size);
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
+		goto err;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret) {
+		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
+		goto err;
+	}
+
+	*dlen = idxd_desc->iax_completion->output_size;
+
+	idxd_free_desc(wq, idxd_desc);
+out:
+	return ret;
+err:
+	idxd_free_desc(wq, idxd_desc);
+	dev_dbg(dev, "iaa decompress failed: ret=%d\n", ret);
+
+	goto out;
+}
+
+static int iaa_comp_acompress(struct acomp_req *req)
+{
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	u32 compression_crc;
+	struct idxd_wq *wq;
+	struct device *dev;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not compressing\n");
+		return -ENODEV;
+	}
+
+	if (!req->src || !req->slen) {
+		pr_debug("invalid src, not compressing\n");
+		return -EINVAL;
+	}
+
+	if (!req->dst) {
+		gfp_t flags = req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
+		/* incompressible data will always be < 2 * slen */
+		req->dlen = 2 * req->slen;
+		req->dst = sgl_alloc(req->dlen, flags, NULL);
+		if (!req->dst)
+			return -ENOMEM;
+	}
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		ret = -ENODEV;
+		goto out;
+	}
+	iaa_wq = wq->private_data;
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+
+	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
+			   &req->dlen, &compression_crc, false);
+	if (ret == -EINPROGRESS)
+		goto out;
+
+	if (!ret && iaa_verify_compress) {
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+
+	if (ret)
+		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
+{
+	gfp_t flags = req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+		GFP_KERNEL : GFP_ATOMIC;
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	struct device *dev;
+	struct idxd_wq *wq;
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		ret = -ENODEV;
+		goto out;
+	}
+	iaa_wq = wq->private_data;
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	req->dlen = 4 * req->slen; /* start with ~avg comp rato */
+alloc_dest:
+	req->dst = sgl_alloc(req->dlen, flags, NULL);
+	if (!req->dst)
+		return -ENOMEM;
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
+			     dst_addr, &req->dlen, true);
+	if (ret == -EOVERFLOW) {
+		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+		sgl_free(req->dst);
+		req->dlen *= 2;
+		if (req->dlen > CRYPTO_ACOMP_DST_MAX)
+			goto err_map_dst;
+		goto alloc_dest;
+	}
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static int iaa_comp_adecompress(struct acomp_req *req)
+{
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	struct device *dev;
+	struct idxd_wq *wq;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not decompressing\n");
+		return -ENODEV;
+	}
+
+	if (!req->src || !req->slen) {
+		pr_debug("invalid src, not decompressing\n");
+		return -EINVAL;
+	}
+
+	if (!req->dst)
+		return iaa_comp_adecompress_alloc_dest(req);
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		ret = -ENODEV;
+		goto out;
+	}
+	iaa_wq = wq->private_data;
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+
+	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
+			     dst_addr, &req->dlen, false);
+	if (ret == -EINPROGRESS)
+		goto out;
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static struct acomp_alg iaa_acomp_deflate = {
+	.compress		= iaa_comp_acompress,
+	.decompress		= iaa_comp_adecompress,
+	.dst_free		= sgl_free,
+	.base			= {
+		.cra_name		= "deflate",
+		.cra_driver_name	= "iaa_crypto",
+		.cra_module		= THIS_MODULE,
+		.cra_priority           = IAA_ALG_PRIORITY,
+	}
+};
+
+static int iaa_register_compression_device(void)
+{
+	int ret;
+
+	ret = crypto_register_acomp(&iaa_acomp_deflate);
+	if (ret)
+		pr_err("deflate algorithm acomp registration failed (%d)\n", ret);
+
+	return ret;
+}
+
+static int iaa_unregister_compression_device(void)
+{
+	if (refcount_read(&iaa_acomp_deflate.base.cra_refcnt) > 1)
+		return -EBUSY;
+
+	crypto_unregister_acomp(&iaa_acomp_deflate);
+
+	return 0;
+}
+
 static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 {
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
@@ -881,12 +1574,26 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	rebalance_wq_table();
 
+	if (first_wq) {
+		iaa_crypto_enabled = true;
+		ret = iaa_register_compression_device();
+		if (ret != 0) {
+			iaa_crypto_enabled = false;
+			dev_dbg(dev, "IAA compression device registration failed\n");
+			goto err_register;
+		}
+
+		pr_info("iaa_crypto now ENABLED\n");
+	}
+
 	mutex_unlock(&iaa_devices_lock);
 out:
 	mutex_unlock(&wq->wq_lock);
 
 	return ret;
 
+err_register:
+	remove_iaa_wq(wq);
 err_save:
 	if (first_wq)
 		free_wq_table();
@@ -902,6 +1609,7 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 {
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+	struct device *dev = &idxd_dev->conf_dev;
 
 	idxd_wq_quiesce(wq);
 
@@ -912,9 +1620,16 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 	drv_disable_wq(wq);
 	rebalance_wq_table();
 
-	if (nr_iaa == 0)
+	if (nr_iaa == 0) {
+		iaa_crypto_enabled = false;
 		free_wq_table();
 
+		if (iaa_unregister_compression_device())
+			dev_dbg(dev, "IAA compression device unregister failed\n");
+
+		pr_info("iaa_crypto now DISABLED\n");
+	}
+
 	mutex_unlock(&iaa_devices_lock);
 	mutex_unlock(&wq->wq_lock);
 }
@@ -952,6 +1667,13 @@ static int __init iaa_crypto_init_module(void)
 		goto err_attr_create;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				 &driver_attr_verify_compress);
+	if (ret) {
+		pr_debug("IAA verify_compress attr creation failed\n");
+		goto err_attr_create;
+	}
+
 	ret = iaa_aecs_init_fixed();
 	if (ret < 0) {
 		pr_debug("IAA fixed compression mode init failed\n");
@@ -965,6 +1687,8 @@ static int __init iaa_crypto_init_module(void)
 err_compression_mode:
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 err_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 
@@ -975,6 +1699,8 @@ static void __exit iaa_crypto_cleanup_module(void)
 {
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
 	iaa_aecs_cleanup_fixed();
 
-- 
2.34.1

