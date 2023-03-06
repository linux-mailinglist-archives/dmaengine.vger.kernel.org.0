Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D37F6ACD3C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCFSzH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCFSye (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:54:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1BD78CAF;
        Mon,  6 Mar 2023 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128803; x=1709664803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHrdduABqoYk7FYqgdOqGwEE+ECLY4d79jW5db6sXVE=;
  b=fThthSYQUfRK9rm0AUQ5zvJV3c1abFgo0IlHn+iwWQ0boTo+LACd5enq
   dMMGseVHjtOLEQykQiok3e2T0wmPGja3QrGL93q54Tcl66VWKyn6c2TCk
   go6/i3m6d7N8ipc/WQzLK8cx5o8OEZz0y1QWxvyAaGmknI3I3rms/EIdv
   NXva8/zRXwDAZw1y89QROI7dhOZeXB/+HG09GcBQ2LMYWmPo4zgp6MjO/
   n8d4wt5I5zmWSYB+PKVx68cRCHCwGMV/4+V0F7T0aN5KAcYV94QRCOkyE
   OWZ49KwgOKGM0Yf7GVvUUuwMG7Jit3OjZ5NJ+6WbLYgHLgsKz+GaGpohM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227831"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255949"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255949"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:53:06 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 15/16] crypto: iaa - Add irq support for the crypto async interface
Date:   Mon,  6 Mar 2023 12:52:25 -0600
Message-Id: <20230306185226.26483-16-tom.zanussi@linux.intel.com>
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

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/iaa/iaa_crypto_main.c | 216 ++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/iaa/iaa_crypto_main.c b/drivers/crypto/iaa/iaa_crypto_main.c
index 39f72eda43ff..aedf06a0c1ec 100644
--- a/drivers/crypto/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/iaa/iaa_crypto_main.c
@@ -116,6 +116,102 @@ static ssize_t verify_compress_store(struct device_driver *driver,
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
 static int active_compression_mode;
 
@@ -1028,6 +1124,71 @@ static inline int check_completion(struct device *dev,
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
+	struct crypto_ctx *ctx = __ctx;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret, err = 0;
+
+	iaa_wq = idxd_desc->wq->private_data;
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	dev_dbg(dev, "%s: compression mode %s,"
+		" ctx->src_addr %llx, ctx->dst_addr %llx\n", __func__,
+		iaa_wq->iaa_device->active_compression_mode->name,
+		ctx->src_addr, ctx->dst_addr);
+
+	ret = check_completion(dev, idxd_desc->iax_completion,
+			       ctx->compress, false);
+	if (ret) {
+		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
+		err = -EIO;
+	}
+
+	ctx->req->dlen = idxd_desc->iax_completion->output_size;
+
+	if (ctx->compress && iaa_verify_compress) {
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
+
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
+}
+
 static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
@@ -1070,6 +1231,22 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	desc->src2_size = sizeof(struct aecs_comp_table_record);
 	desc->completion_addr = idxd_desc->compl_dma;
 
+	if (use_irq) {
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
+			iaa_wq->iaa_device->active_compression_mode->name,
+			src_addr, dst_addr);
+	} else if (req && async_mode && !disable_async)
+		req->base.data = idxd_desc;
+
 	dev_dbg(dev, "%s: compression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1084,6 +1261,12 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 		goto err;
 	}
 
+	if (req && async_mode && !disable_async) {
+		ret = -EINPROGRESS;
+		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
+		goto out;
+	}
+
 	ret = check_completion(dev, idxd_desc->iax_completion, true, false);
 	if (ret) {
 		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
@@ -1241,6 +1424,19 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
 	}
 
+	if (use_irq) {
+		desc->flags |= IDXD_OP_FLAG_RCI;
+
+		idxd_desc->crypto.req = req;
+		idxd_desc->crypto.compress = false;
+
+		dev_dbg(dev, "%s: use_async_irq compression mode %s,"
+			" src_addr %llx, dst_addr %llx\n", __func__,
+			iaa_wq->iaa_device->active_compression_mode->name,
+			src_addr, dst_addr);
+	} else if (req && async_mode && !disable_async)
+		req->base.data = idxd_desc;
+
 	dev_dbg(dev, "%s: decompression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1255,6 +1451,12 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		goto err;
 	}
 
+	if (req && async_mode && !disable_async) {
+		ret = -EINPROGRESS;
+		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
+		goto out;
+	}
+
 	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
 	if (ret) {
 		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
@@ -1627,7 +1829,7 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	wq->type = IDXD_WQT_KERNEL;
 
-	ret = drv_enable_wq(wq, IDXD_DTYPE_CRYPTO);
+	ret = drv_enable_wq(wq);
 	if (ret < 0) {
 		dev_dbg(dev, "enable wq %d.%d failed: %d\n",
 			idxd->id, wq->id, ret);
@@ -1720,6 +1922,7 @@ static struct idxd_device_driver iaa_crypto_driver = {
 	.remove = iaa_crypto_remove,
 	.name = IDXD_SUBDRIVER_NAME,
 	.type = dev_types,
+	.desc_complete = iaa_desc_complete,
 };
 
 static int __init iaa_crypto_init_module(void)
@@ -1736,6 +1939,13 @@ static int __init iaa_crypto_init_module(void)
 		goto out;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				 &driver_attr_sync_mode);
+	if (ret) {
+		pr_debug("IAA sync mode attr creation failed\n");
+		goto err_attr_create;
+	}
+
 	ret = driver_create_file(&iaa_crypto_driver.drv,
 				 &driver_attr_compression_mode);
 	if (ret) {
@@ -1768,6 +1978,8 @@ static int __init iaa_crypto_init_module(void)
 	return ret;
 
 err_compression_mode:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
@@ -1780,6 +1992,8 @@ static int __init iaa_crypto_init_module(void)
 
 static void __exit iaa_crypto_cleanup_module(void)
 {
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
-- 
2.34.1

