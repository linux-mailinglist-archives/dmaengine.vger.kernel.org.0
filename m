Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416B2723102
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jun 2023 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjFEUSA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Jun 2023 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjFEURA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Jun 2023 16:17:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C010C1;
        Mon,  5 Jun 2023 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996190; x=1717532190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOS9e2AKYpWgxBUVN5e9lkOrzYD82wKhBhndCHJDAco=;
  b=K19+CX64etBHrMMf27MYzhtwBBWJATjzgjfBdWgIliXx8AkvLuqIwDlG
   Tqtg6OVllTglu6WhAxpPDnvYfYrP/ChRNSh6MXx03tPhhWxNdk/G3JwUf
   75XzHWxNTiVftNfHcxGZO8p3EqtYZRHT7T3gHnN0V7vBe8JkzhxSMLqBR
   YdojzZk/vzyZ2IynkZRJNoSgE5uQIbjC6kpsV3z8atg2/X2uxHkXWvspt
   yabbvSpqKXSAa/kHPrdg7a+ew0c0ScQ7s+tvhrKCd++SkAvOADsS/FDcK
   CDeWv8YgMq7bO9+p2NxVtUo81hDESnLYnqsz61CmbwbXpAAiEZGxaNC0X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356480475"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="356480475"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711934585"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="711934585"
Received: from rkbrewer-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.33.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:16:07 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v6 14/15] crypto: iaa - Add irq support for the crypto async interface
Date:   Mon,  5 Jun 2023 15:15:35 -0500
Message-Id: <20230605201536.738396-15-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
References: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The existing iaa crypto async support provides an implementation that
satisfies the interface but does so in a synchronous manner - it fills
and submits the IDXD descriptor and then waits for it to complete
before returning.  This isn't a problem at the moment, since all
existing callers (e.g. zswap) wrap any asynchronous callees in a
synchronous wrapper anyway.

This change makes the iaa crypto async implementation truly
asynchronous: it fills and submits the IDXD descriptor, then returns
immediately with -EINPROGRESS.  It also sets the descriptor's 'request
completion irq' bit and sets up a callback with the IDXD driver which
is called when the operation completes and the irq fires.  The
existing callers such as zswap use synchronous wrappers to deal with
-EINPROGRESS and so work as expected without any changes.

This mode can be enabled by writing 'async_irq' to the sync_mode
iaa_crypto driver attribute:

  echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode

Async mode without interrupts (caller must poll) can be enabled by
writing 'async' to it:

  echo async > /sys/bus/dsa/drivers/crypto/sync_mode

The default sync mode can be enabled by writing 'sync' to it:

  echo sync > /sys/bus/dsa/drivers/crypto/sync_mode

The sync_mode value setting at the time the IAA algorithms are
registered is captured in each algorithm's crypto_ctx and used for all
compresses and decompresses when using a given algorithm.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |   2 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 236 ++++++++++++++++++++-
 2 files changed, 236 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 1144ea06a1b0..a26662cd28d8 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -156,6 +156,8 @@ enum iaa_mode {
 struct iaa_compression_ctx {
 	enum iaa_mode	mode;
 	bool		verify_compress;
+	bool		async_mode;
+	bool		use_irq;
 };
 
 #endif
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 60ba967e1158..d03ca1bf7a5e 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -115,6 +115,102 @@ static ssize_t verify_compress_store(struct device_driver *driver,
 }
 static DRIVER_ATTR_RW(verify_compress);
 
+/*
+ * The iaa crypto driver supports three 'sync' methods determining how
+ * compressions and decompressions are performed:
+ *
+ * - sync:      the compression or decompression completes before
+ *              returning.  This is the mode used by the async crypto
+ *              interface when the sync mode is set to 'sync' and by
+ *              the sync crypto interface regardless of setting.
+ *
+ * - async:     the compression or decompression is submitted and returns
+ *              immediately.  Completion interrupts are not used so
+ *              the caller is responsible for polling the descriptor
+ *              for completion.  This mode is applicable to only the
+ *              async crypto interface and is ignored for anything
+ *              else.
+ *
+ * - async_irq: the compression or decompression is submitted and
+ *              returns immediately.  Completion interrupts are
+ *              enabled so the caller can wait for the completion and
+ *              yield to other threads.  When the compression or
+ *              decompression completes, the completion is signaled
+ *              and the caller awakened.  This mode is applicable to
+ *              only the async crypto interface and is ignored for
+ *              anything else.
+ *
+ * These modes can be set using the iaa_crypto sync_mode driver
+ * attribute.
+ */
+
+/* Use async mode */
+static bool async_mode;
+/* Use interrupts */
+static bool use_irq;
+
+/**
+ * set_iaa_sync_mode - Set IAA sync mode
+ * @name: The name of the sync mode
+ *
+ * Make the IAA sync mode named @name the current sync mode used by
+ * compression/decompression.
+ */
+
+static int set_iaa_sync_mode(const char *name)
+{
+	int ret = 0;
+
+	if (sysfs_streq(name, "sync")) {
+		async_mode = false;
+		use_irq = false;
+	} else if (sysfs_streq(name, "async")) {
+		async_mode = true;
+		use_irq = false;
+	} else if (sysfs_streq(name, "async_irq")) {
+		async_mode = true;
+		use_irq = true;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t sync_mode_show(struct device_driver *driver, char *buf)
+{
+	int ret = 0;
+
+	if (!async_mode && !use_irq)
+		ret = sprintf(buf, "%s\n", "sync");
+	else if (async_mode && !use_irq)
+		ret = sprintf(buf, "%s\n", "async");
+	else if (async_mode && use_irq)
+		ret = sprintf(buf, "%s\n", "async_irq");
+
+	return ret;
+}
+
+static ssize_t sync_mode_store(struct device_driver *driver,
+			       const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = set_iaa_sync_mode(buf);
+	if (ret == 0)
+		ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(sync_mode);
+
 static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 
 static int find_empty_iaa_compression_mode(void)
@@ -979,6 +1075,81 @@ static inline int check_completion(struct device *dev,
 	return ret;
 }
 
+static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
+			       struct idxd_wq *wq,
+			       dma_addr_t src_addr, unsigned int slen,
+			       dma_addr_t dst_addr, unsigned int *dlen,
+			       u32 compression_crc);
+
+static void iaa_desc_complete(struct idxd_desc *idxd_desc,
+			      enum idxd_complete_type comp_type,
+			      bool free_desc, void *__ctx,
+			      u32 *status)
+{
+	struct iaa_device_compression_mode *active_compression_mode;
+	struct iaa_compression_ctx *compression_ctx;
+	struct crypto_ctx *ctx = __ctx;
+	struct iaa_device *iaa_device;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret, err = 0;
+
+	compression_ctx = crypto_tfm_ctx(ctx->tfm);
+
+	iaa_wq = idxd_wq_get_private(idxd_desc->wq);
+	iaa_device = iaa_wq->iaa_device;
+	idxd = iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	active_compression_mode = get_iaa_device_compression_mode(iaa_device,
+								  compression_ctx->mode);
+	dev_dbg(dev, "%s: compression mode %s,"
+		" ctx->src_addr %llx, ctx->dst_addr %llx\n", __func__,
+		active_compression_mode->name,
+		ctx->src_addr, ctx->dst_addr);
+
+	ret = check_completion(dev, idxd_desc->iax_completion,
+			       ctx->compress, false);
+	if (ret) {
+		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
+		err = -EIO;
+		goto err;
+	}
+
+	ctx->req->dlen = idxd_desc->iax_completion->output_size;
+
+	if (ctx->compress && compression_ctx->verify_compress) {
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+		dma_sync_sg_for_device(dev, ctx->req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, ctx->req->src, 1, DMA_TO_DEVICE);
+		ret = iaa_compress_verify(ctx->tfm, ctx->req, iaa_wq->wq, ctx->src_addr,
+					  ctx->req->slen, ctx->dst_addr, &ctx->req->dlen,
+					  compression_crc);
+		if (ret) {
+			dev_dbg(dev, "%s: compress verify failed ret=%d\n", __func__, ret);
+			err = -EIO;
+		}
+	}
+err:
+	if (ctx->req->base.complete)
+		acomp_request_complete(ctx->req, err);
+
+	dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, ctx->req->src, sg_nents(ctx->req->src), DMA_TO_DEVICE);
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
+
+	if (free_desc)
+		idxd_free_desc(idxd_desc->wq, idxd_desc);
+	iaa_wq_put(idxd_desc->wq);
+}
+
 static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
@@ -1030,6 +1201,22 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	desc->src2_size = sizeof(struct aecs_comp_table_record);
 	desc->completion_addr = idxd_desc->compl_dma;
 
+	if (ctx->use_irq) {
+		desc->flags |= IDXD_OP_FLAG_RCI;
+
+		idxd_desc->crypto.req = req;
+		idxd_desc->crypto.tfm = tfm;
+		idxd_desc->crypto.src_addr = src_addr;
+		idxd_desc->crypto.dst_addr = dst_addr;
+		idxd_desc->crypto.compress = true;
+
+		dev_dbg(dev, "%s use_async_irq: compression mode %s,"
+			" src_addr %llx, dst_addr %llx\n", __func__,
+			active_compression_mode->name,
+			src_addr, dst_addr);
+	} else if (ctx->async_mode && !disable_async)
+		req->base.data = idxd_desc;
+
 	dev_dbg(dev, "%s: compression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1044,6 +1231,12 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 		goto err;
 	}
 
+	if (ctx->async_mode && !disable_async) {
+		ret = -EINPROGRESS;
+		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
+		goto out;
+	}
+
 	ret = check_completion(dev, idxd_desc->iax_completion, true, false);
 	if (ret) {
 		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
@@ -1054,7 +1247,8 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	idxd_free_desc(wq, idxd_desc);
+	if (!ctx->async_mode)
+		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
 err:
@@ -1219,6 +1413,22 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
 	}
 
+	if (ctx->use_irq && !disable_async) {
+		desc->flags |= IDXD_OP_FLAG_RCI;
+
+		idxd_desc->crypto.req = req;
+		idxd_desc->crypto.tfm = tfm;
+		idxd_desc->crypto.src_addr = src_addr;
+		idxd_desc->crypto.dst_addr = dst_addr;
+		idxd_desc->crypto.compress = false;
+
+		dev_dbg(dev, "%s: use_async_irq compression mode %s,"
+			" src_addr %llx, dst_addr %llx\n", __func__,
+			active_compression_mode->name,
+			src_addr, dst_addr);
+	} else if (ctx->async_mode && !disable_async)
+		req->base.data = idxd_desc;
+
 	dev_dbg(dev, "%s: decompression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1233,6 +1443,12 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		goto err;
 	}
 
+	if (ctx->async_mode && !disable_async) {
+		ret = -EINPROGRESS;
+		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
+		goto out;
+	}
+
 	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
 	if (ret) {
 		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
@@ -1241,7 +1457,8 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*dlen = idxd_desc->iax_completion->output_size;
 
-	idxd_free_desc(wq, idxd_desc);
+	if (!ctx->async_mode)
+		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
 err:
@@ -1525,6 +1742,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 {
 	ctx->verify_compress = iaa_verify_compress;
+	ctx->async_mode = async_mode;
+	ctx->use_irq = use_irq;
 }
 
 static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
@@ -1760,6 +1979,7 @@ static struct idxd_device_driver iaa_crypto_driver = {
 	.remove = iaa_crypto_remove,
 	.name = IDXD_SUBDRIVER_NAME,
 	.type = dev_types,
+	.desc_complete = iaa_desc_complete,
 };
 
 static int __init iaa_crypto_init_module(void)
@@ -1795,10 +2015,20 @@ static int __init iaa_crypto_init_module(void)
 		goto err_verify_attr_create;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				 &driver_attr_sync_mode);
+	if (ret) {
+		pr_debug("IAA sync mode attr creation failed\n");
+		goto err_sync_attr_create;
+	}
+
 	pr_debug("initialized\n");
 out:
 	return ret;
 
+err_sync_attr_create:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 err_verify_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
@@ -1814,6 +2044,8 @@ static void __exit iaa_crypto_cleanup_module(void)
 	if (iaa_unregister_compression_device())
 		pr_debug("IAA compression device unregister failed\n");
 
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
-- 
2.34.1

