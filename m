Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64B76A2D5
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 23:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjGaVbz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGaVbO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 17:31:14 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745E2108;
        Mon, 31 Jul 2023 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839041; x=1722375041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J65qrX4k/SUWpoznz9CsQPIO8T/UQBh4dDIdy6Ri0Po=;
  b=JhUI+JCyfRQtzD7+RWuZ/u8iTM6Z3AQBBOZp6JXASeQUV9Rf32AI9SmQ
   NMh6/LGx/FlLaw/fwybmLUMZb2TCySnfCMN8bse8l1ysQ5xeUH1LiRfIY
   Iu4WHcbnEKp/+YbTmV1NObYhh1UHFYXRJ1/QQ9h8jUCWwkb2zVo53nUGC
   j9vdkCV3gilhmbtCJOYsJWWmFEUYQvsJzdEbDSGXDJixAAAKtcqSb92cp
   E3L5+vvi6b27vYWDQrIeD68m89OY6JcwcM7eus25z6g2hmdLwDxDYRShW
   iTTBoCMuWAWgZn2QeNOwUQlK0lLxl5bgjLlJc+dDUL3lhsNBFabQNqnCw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349425990"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349425990"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728428878"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728428878"
Received: from sgimmeke-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.91.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:30:15 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v8 13/14] crypto: iaa - Add irq support for the crypto async interface
Date:   Mon, 31 Jul 2023 16:29:38 -0500
Message-Id: <20230731212939.1391453-14-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 250 ++++++++++++++++++++-
 2 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 4c6b0f5a6b50..de014ac53adb 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -153,6 +153,8 @@ enum iaa_mode {
 struct iaa_compression_ctx {
 	enum iaa_mode	mode;
 	bool		verify_compress;
+	bool		async_mode;
+	bool		use_irq;
 };
 
 #endif
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 75c4846cb4ff..17568c9440c2 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -119,6 +119,102 @@ static ssize_t verify_compress_store(struct device_driver *driver,
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
@@ -997,6 +1093,95 @@ static int deflate_generic_decompress(struct acomp_req *req)
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
+		if (ctx->compress == false &&
+		    idxd_desc->iax_completion->status == IAA_ANALYTICS_ERROR) {
+			pr_warn("%s: falling back to deflate-generic decompress, "
+				"analytics error code %x\n", __func__,
+				idxd_desc->iax_completion->error_code);
+			ret = deflate_generic_decompress(ctx->req);
+			if (ret) {
+				dev_dbg(dev, "%s: deflate-generic failed ret=%d\n",
+					__func__, ret);
+				err = -EIO;
+				goto err;
+			}
+		} else {
+			err = -EIO;
+			goto err;
+		}
+	} else {
+		ctx->req->dlen = idxd_desc->iax_completion->output_size;
+	}
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
@@ -1045,6 +1230,22 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
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
@@ -1059,6 +1260,12 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
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
@@ -1069,7 +1276,8 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	idxd_free_desc(wq, idxd_desc);
+	if (!ctx->async_mode)
+		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
 err:
@@ -1212,6 +1420,22 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	desc->src1_size = slen;
 	desc->completion_addr = idxd_desc->compl_dma;
 
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
@@ -1226,6 +1450,12 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
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
 		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
@@ -1248,7 +1478,8 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*dlen = req->dlen;
 
-	idxd_free_desc(wq, idxd_desc);
+	if (!ctx->async_mode)
+		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
 err:
@@ -1546,6 +1777,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 {
 	ctx->verify_compress = iaa_verify_compress;
+	ctx->async_mode = async_mode;
+	ctx->use_irq = use_irq;
 }
 
 static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
@@ -1753,6 +1986,7 @@ static struct idxd_device_driver iaa_crypto_driver = {
 	.remove = iaa_crypto_remove,
 	.name = IDXD_SUBDRIVER_NAME,
 	.type = dev_types,
+	.desc_complete = iaa_desc_complete,
 };
 
 static int __init iaa_crypto_init_module(void)
@@ -1791,10 +2025,20 @@ static int __init iaa_crypto_init_module(void)
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
@@ -1810,6 +2054,8 @@ static void __exit iaa_crypto_cleanup_module(void)
 	if (iaa_unregister_compression_device())
 		pr_debug("IAA compression device unregister failed\n");
 
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
-- 
2.34.1

