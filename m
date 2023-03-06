Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AFE6ACD35
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCFSyd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCFSyB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:54:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF123137;
        Mon,  6 Mar 2023 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128785; x=1709664785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uR+iWhHaiU+j4y6I4WFGPNMBDa5ZX0CzLHFXsMED2LY=;
  b=AoSwoll/01ew2uCQsAy255X7p24Cz2RfEza90Pr0bD1kQqzmclY3O7pZ
   mnw1zKmkTzd6H+N7bNy6VMhzihbF8kBG+pnGakoJib81/lvryXrDHksmJ
   J6NUCO7Vu/0KOpPBZc7HghokcTV+j/dpICCf1T9JDVkAArJWr2OWomH5H
   YiyCDAq0x4uDuN5zgHQPoY8WtGSV6IqlbXWd6X0k3tNtVHvAmYQsalNCh
   xC6HO+u0IGRBLaLR3bcYgKeg2kj83Zmv0xy0WC/EVvpk0d3+MHWJzj//d
   /qtg/7Qw0OHGAYRO+RlH7qJ4DTtiZ6lAVRUBUh+LQTxDQNTeaHCEte1kj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227788"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227788"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255903"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255903"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:59 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 12/16] crypto: iaa - Add support for iaa_crypto deflate compression algorithm
Date:   Mon,  6 Mar 2023 12:52:22 -0600
Message-Id: <20230306185226.26483-13-tom.zanussi@linux.intel.com>
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
 drivers/crypto/iaa/iaa_crypto.h      |  23 +
 drivers/crypto/iaa/iaa_crypto_main.c | 608 ++++++++++++++++++++++++++-
 2 files changed, 630 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/iaa/iaa_crypto.h b/drivers/crypto/iaa/iaa_crypto.h
index 2daa3522e073..176beb2afff6 100644
--- a/drivers/crypto/iaa/iaa_crypto.h
+++ b/drivers/crypto/iaa/iaa_crypto.h
@@ -10,11 +10,34 @@
 
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
diff --git a/drivers/crypto/iaa/iaa_crypto_main.c b/drivers/crypto/iaa/iaa_crypto_main.c
index 9bd42cfa949e..7626e12e65c9 100644
--- a/drivers/crypto/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/iaa/iaa_crypto_main.c
@@ -20,6 +20,8 @@
 
 #define pr_fmt(fmt)			"idxd: " IDXD_SUBDRIVER_NAME ": " fmt
 
+#define IAA_ALG_PRIORITY		300
+
 /* number of iaa instances probed */
 static unsigned int nr_iaa;
 static unsigned int nr_cpus;
@@ -32,6 +34,20 @@ static unsigned int cpus_per_iaa;
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
@@ -66,6 +82,39 @@ static void wq_table_clear_entry(int cpu)
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
 
@@ -86,6 +135,9 @@ static ssize_t compression_mode_store(struct device_driver *driver,
 
 	mutex_lock(&iaa_devices_lock);
 
+	if (iaa_crypto_enabled)
+		goto out;
+
 	mode_name = kstrndup(buf, count, GFP_KERNEL);
 	if (!mode_name) {
 		ret = -ENOMEM;
@@ -350,6 +402,89 @@ static void free_device_compression_mode(struct iaa_device *iaa_device,
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
@@ -382,6 +517,14 @@ static int init_device_compression_mode(struct iaa_device *iaa_device,
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
@@ -831,6 +974,436 @@ static void rebalance_wq_table(void)
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
+	dev_dbg(dev, "%s decompression mode %s,"
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
+static int iaa_comp_compress(struct crypto_tfm *tfm,
+			     const u8 *src, unsigned int slen,
+			     u8 *dst, unsigned int *dlen)
+{
+	dma_addr_t src_addr, dst_addr;
+	u32 compression_crc;
+	struct idxd_wq *wq;
+	struct device *dev;
+	int cpu, ret = 0;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not compressing\n");
+		return -ENODEV;
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
+	dev = &wq->idxd->pdev->dev;
+
+	src_addr = dma_map_single(dev, (void *)src, slen, DMA_TO_DEVICE);
+	dev_dbg(dev, "dma_map_single, src_addr %llx, dev %p,"
+		" src %p, slen %d\n", src_addr, dev, src, slen);
+	if (unlikely(dma_mapping_error(dev, src_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	dst_addr = dma_map_single(dev, (void *)dst, *dlen, DMA_FROM_DEVICE);
+	dev_dbg(dev, "dma_map_single, dst_addr %llx, dev %p,"
+		" dst %p, *dlen %d\n", dst_addr, dev, dst, *dlen);
+	if (unlikely(dma_mapping_error(dev, dst_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		goto err_map_dst;
+	}
+
+	dev_dbg(dev, "src %p, src_addr %llx, slen %d, dst %p,"
+		" dst_addr %llx, dlen %u\n", src, src_addr,
+		slen, dst, dst_addr, *dlen);
+
+	ret = iaa_compress(tfm, NULL, wq, src_addr, slen, dst_addr,
+			   dlen, &compression_crc, true);
+	if (iaa_verify_compress) {
+		dma_sync_single_for_device(dev, dst_addr, *dlen, DMA_FROM_DEVICE);
+		dma_sync_single_for_device(dev, src_addr, slen, DMA_TO_DEVICE);
+		ret = iaa_compress_verify(tfm, NULL, wq, src_addr,
+					  slen, dst_addr, dlen, compression_crc);
+	}
+
+	if (ret != 0)
+		dev_dbg(dev, "synchronous compress failed ret=%d\n", ret);
+
+	dma_unmap_single(dev, dst_addr, *dlen, DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_single(dev, src_addr, slen, DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static int iaa_comp_decompress(struct crypto_tfm *tfm,
+			       const u8 *src, unsigned int slen,
+			       u8 *dst, unsigned int *dlen)
+{
+	dma_addr_t src_addr, dst_addr;
+	struct idxd_wq *wq;
+	struct device *dev;
+	int cpu, ret = 0;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not decompressing\n");
+		return -ENODEV;
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
+	dev = &wq->idxd->pdev->dev;
+
+	dev_dbg(dev, "using wq for cpu=%d = wq %p\n", cpu, wq);
+
+	src_addr = dma_map_single(dev, (void *)src, slen, DMA_TO_DEVICE);
+	dev_dbg(dev, "dma_map_single, src_addr %llx, dev %p,"
+		" src %p, slen %d\n", src_addr, dev, src, slen);
+	if (unlikely(dma_mapping_error(dev, src_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	dst_addr = dma_map_single(dev, (void *)dst, *dlen, DMA_FROM_DEVICE);
+	dev_dbg(dev, "dma_map_single, dst_addr %llx, dev %p,"
+		" dst %p, *dlen %d\n", dst_addr, dev, dst, *dlen);
+	if (unlikely(dma_mapping_error(dev, dst_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		goto err_map_dst;
+	}
+
+	dev_dbg(dev, "src %p, src_addr %llx, slen %d, dst %p,"
+		" dst_addr %llx, dlen %u\n", src, src_addr,
+		slen, dst, dst_addr, *dlen);
+
+	ret = iaa_decompress(tfm, NULL, wq, src_addr, slen, dst_addr, dlen, true);
+	if (ret != 0)
+		dev_dbg(dev, "synchronous decompress failed ret=%d\n", ret);
+
+	dma_unmap_single(dev, dst_addr, *dlen, DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_single(dev, src_addr, slen, DMA_TO_DEVICE);
+out:
+	return ret;
+}
+
+static struct crypto_alg iaa_comp_deflate = {
+	.cra_name		= "deflate",
+	.cra_driver_name	= "iaa_crypto",
+	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
+	.cra_priority		= IAA_ALG_PRIORITY,
+	.cra_module		= THIS_MODULE,
+	.cra_u			= {
+	.compress = {
+			.coa_compress	= iaa_comp_compress,
+			.coa_decompress	= iaa_comp_decompress
+		}
+	}
+};
+
+static int iaa_register_compression_device(void)
+{
+	int ret;
+
+	ret = crypto_register_alg(&iaa_comp_deflate);
+	if (ret < 0) {
+		pr_debug("deflate algorithm registration failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int iaa_unregister_compression_device(void)
+{
+	crypto_unregister_alg(&iaa_comp_deflate);
+
+	return 0;
+}
+
 static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 {
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
@@ -881,12 +1454,26 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	rebalance_wq_table();
 
+	if (first_wq) {
+		ret = iaa_register_compression_device();
+		if (ret == 0) {
+			iaa_crypto_enabled = true;
+		} else {
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
@@ -902,6 +1489,7 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 {
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+	struct device *dev = &idxd_dev->conf_dev;
 
 	idxd_wq_quiesce(wq);
 
@@ -912,9 +1500,16 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
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
@@ -952,6 +1547,13 @@ static int __init iaa_crypto_init_module(void)
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
@@ -965,6 +1567,8 @@ static int __init iaa_crypto_init_module(void)
 err_compression_mode:
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 err_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 
@@ -975,6 +1579,8 @@ static void __exit iaa_crypto_cleanup_module(void)
 {
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
 	iaa_aecs_cleanup_fixed();
 
-- 
2.34.1

