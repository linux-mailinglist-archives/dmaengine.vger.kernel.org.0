Return-Path: <dmaengine+bounces-1978-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032CC8B9126
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 23:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE9284B43
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 21:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30916ABF3;
	Wed,  1 May 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfkLiytt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76D168AEB;
	Wed,  1 May 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599999; cv=none; b=gmHzQo1WPywUx5C5we37Q+NxoRCZ941Qm9SHwNOPloQN630K4uYmUo9Wo+E2j5glEn9IcgSnlNmow4YJSvS4UuLj/tE/MLlevFQ61Vnoecyv+nkUXeTSoqg7ch5WsGvu6MOtkxsH9lro4sL94rk6an8dnTGU72iXFVxtRztHXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599999; c=relaxed/simple;
	bh=a4IlgIS4l1i81IPaTOa4H1/eUifTwYw5lDJiYhgh13s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5EQ6EnkzDZb9jmzFFEdHS868ZR8QUvH5O/zaXmGtzHegQH9Vq7NYk/fAX2qDum94zr0T5z7PgB0uTKN+lRF1/G83/LMMulheBidT0OazINhyna0jmwLTYnyEurrL2V97av4gHUE8CgmeBWNdoo5TnKE40KJBDv3vZVKprQuFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfkLiytt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714599998; x=1746135998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4IlgIS4l1i81IPaTOa4H1/eUifTwYw5lDJiYhgh13s=;
  b=JfkLiyttzYCfe1a1uPA7YP77TufmonCZuBrkfCN3FxxXrxw14O754ODy
   Ezs5RM4yzF7kP9AzWgs7BEG5r8rrmMpm52z6TMSQ8h1E/mNF5O31u5CkB
   Hj5QwoLP6dN+RNf1pcFR3aChA8Ip1XgWvs3ACj5wde1aphvibAMeRheaP
   5l+JA02kqhA1qKKq+8cK2yx33rC3TA9m+wVe9ILAiesT7ZawyefZNy8te
   pY28wrgIECLo4DcprNnuC6PaSuqEtAWIMkw1o17IQCcq5BFBG4K3Vh4am
   gm+3HQuVoYiK9NsICDboiXR75oKGM0k5saLkq/WazJ8nfBc7qlNHE/pkC
   g==;
X-CSE-ConnectionGUID: SFeZQ9TRRwats7LyyS8cSQ==
X-CSE-MsgGUID: 3rWJ9R07SEGkM/bKNYCCSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14130170"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="14130170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:37 -0700
X-CSE-ConnectionGUID: Ax45GVOQQ8u5Wavq99bMlw==
X-CSE-MsgGUID: /fxx20rpRFOw7dOsbf2n6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31726397"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:36 -0700
From: Andre Glover <andre.glover@linux.intel.com>
To: tom.zanussi@linux.intel.com,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	dave.jiang@intel.com
Cc: wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	vinodh.gopal@intel.com,
	bala.seshasayee@intel.com,
	heath.caldwell@intel.com,
	kanchana.p.sridhar@intel.com,
	andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [RFC PATCH 3/3] crypto: Add deflate-canned-byN algorithm to IAA
Date: Wed,  1 May 2024 14:46:29 -0700
Message-Id: <bc1fe4fb03557a707365243ca662731fac87c503.1714581792.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1714581792.git.andre.glover@linux.intel.com>
References: <cover.1714581792.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using IAA hardware accelerated 'canned' compression, we are able to
take advantage of the IAA architecture and initiate independent
parallel operations for both compress and decompress. In support of mTHP
and large folio swap in/out, we have developed an algorithm based on
'canned' compression, called 'canned-by_n' that takes advantage of the IAA
hardware that has multiple compression and decompression engines which
creates parallelism for each single compress and/or decompress operation
thus greatly reducing latency.

Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |   9 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 402 ++++++++++++++++++++-
 2 files changed, 398 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 70abcbffd930..dd2c3056fd5d 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -49,6 +49,9 @@
 #define DECOMP_INT_STATE_FMT1_LEN	1088
 #define DECOMP_INT_STATE_FMT2_LEN	1248
 
+#define HDR_ENTRY_SIZE			sizeof(u32)
+#define MAX_BYN_DESC			64
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
@@ -183,6 +186,12 @@ struct iaa_compression_ctx {
 	bool		verify_compress;
 	bool		async_mode;
 	bool		use_irq;
+	bool		by_n;
+};
+
+struct iaa_private_data {
+	struct idxd_desc		*desc[MAX_BYN_DESC];
+	int				num_comp_descs;
 };
 
 extern struct list_head iaa_devices;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index e84a9524b429..f3ea835dbcb9 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -94,6 +94,7 @@ DEFINE_MUTEX(iaa_devices_lock);
 static bool iaa_crypto_enabled;
 static bool iaa_crypto_fixed_registered;
 static bool iaa_crypto_canned_registered;
+static bool iaa_crypto_canned_by_n_registered;
 static bool iaa_crypto_dynamic_registered;
 
 /* Verify results of IAA compress or not */
@@ -1178,6 +1179,7 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *compression_ctx;
+	struct iaa_private_data *private_data;
 	struct crypto_ctx *ctx = __ctx;
 	struct iaa_device *iaa_device;
 	struct idxd_device *idxd;
@@ -1188,6 +1190,8 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 
 	compression_ctx = crypto_tfm_ctx(ctx->tfm);
 
+	private_data = *(ctx->req->__ctx);
+
 	iaa_wq = idxd_wq_get_private(idxd_desc->wq);
 	iaa_device = iaa_wq->iaa_device;
 	idxd = iaa_device->idxd;
@@ -1241,7 +1245,7 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 		update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
 	}
 
-	if (ctx->compress && compression_ctx->verify_compress) {
+	if (ctx->compress && compression_ctx->verify_compress && !compression_ctx->by_n) {
 		dma_addr_t src_addr, dst_addr;
 		u32 compression_crc;
 
@@ -1277,11 +1281,35 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 	if (ctx->req->base.complete)
 		acomp_request_complete(ctx->req, err);
 
-	if (free_desc)
+	if (free_desc) {
 		idxd_free_desc(idxd_desc->wq, idxd_desc);
+		if (private_data)
+			private_data->desc[private_data->num_comp_descs--] = NULL;
+	}
+
 	iaa_wq_put(idxd_desc->wq);
 }
 
+static int iaa_alloc_private_data(struct acomp_req *req)
+{
+	int ret = -ENOMEM;
+
+	if (!*req->__ctx)
+		*req->__ctx = kzalloc(sizeof(struct iaa_private_data), GFP_KERNEL);
+
+	if (!*req->__ctx)
+		goto out;
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static void iaa_free_private_data(struct acomp_req *req)
+{
+	kfree(*req->__ctx);
+}
+
 static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
@@ -1291,6 +1319,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct iaa_private_data *private_data;
 	struct iaa_device *iaa_device;
 	struct idxd_desc *idxd_desc;
 	struct iax_hw_desc *desc;
@@ -1300,6 +1329,8 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	struct device *dev;
 	int ret = 0;
 
+	private_data = *req->__ctx;
+
 	iaa_wq = idxd_wq_get_private(wq);
 	iaa_device = iaa_wq->iaa_device;
 	idxd = iaa_device->idxd;
@@ -1347,7 +1378,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			" src_addr %llx, dst_addr %llx\n", __func__,
 			active_compression_mode->name,
 			src_addr, dst_addr);
-	} else if (ctx->async_mode && !disable_async)
+	} else if ((ctx->async_mode && !disable_async) || (ctx->by_n))
 		req->base.data = idxd_desc;
 
 	dev_dbg(dev, "%s: compression mode %s,"
@@ -1358,6 +1389,9 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 		desc->src1_addr, desc->src1_size, desc->dst_addr,
 		desc->max_dst_size, desc->src2_addr, desc->src2_size);
 
+	if (private_data)
+		private_data->desc[private_data->num_comp_descs++] = idxd_desc;
+
 	ret = idxd_submit_desc(wq, idxd_desc);
 	if (ret) {
 		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
@@ -1368,7 +1402,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	update_total_comp_calls();
 	update_wq_comp_calls(wq);
 
-	if (ctx->async_mode && !disable_async) {
+	if ((ctx->async_mode && !disable_async) || (ctx->by_n)) {
 		ret = -EINPROGRESS;
 		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
 		goto out;
@@ -1388,12 +1422,17 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	if (!ctx->async_mode || disable_async)
+	if (!ctx->async_mode || disable_async) {
 		idxd_free_desc(wq, idxd_desc);
+		if (private_data)
+			private_data->desc[private_data->num_comp_descs--] = NULL;
+	}
 out:
 	return ret;
 err:
 	idxd_free_desc(wq, idxd_desc);
+	if (private_data)
+		private_data->desc[private_data->num_comp_descs--] = NULL;
 	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
 
 	goto out;
@@ -1542,6 +1581,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct iaa_private_data *private_data;
 	struct iaa_device *iaa_device;
 	struct idxd_desc *idxd_desc;
 	struct iax_hw_desc *desc;
@@ -1552,6 +1592,8 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	struct device *dev;
 	int ret = 0;
 
+	private_data = *req->__ctx;
+
 	iaa_wq = idxd_wq_get_private(wq);
 	iaa_device = iaa_wq->iaa_device;
 	idxd = iaa_device->idxd;
@@ -1601,7 +1643,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 			" src_addr %llx, dst_addr %llx\n", __func__,
 			active_compression_mode->name,
 			src_addr, dst_addr);
-	} else if (ctx->async_mode && !disable_async)
+	} else if ((ctx->async_mode && !disable_async) || (ctx->by_n))
 		req->base.data = idxd_desc;
 
 	dev_dbg(dev, "%s: decompression mode %s,"
@@ -1612,6 +1654,9 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		desc->src1_addr, desc->src1_size, desc->dst_addr,
 		desc->max_dst_size, desc->src2_addr, desc->src2_size);
 
+	if (private_data)
+		private_data->desc[private_data->num_comp_descs++] = idxd_desc;
+
 	ret = idxd_submit_desc(wq, idxd_desc);
 	if (ret) {
 		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
@@ -1622,7 +1667,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	update_total_decomp_calls();
 	update_wq_decomp_calls(wq);
 
-	if (ctx->async_mode && !disable_async) {
+	if ((ctx->async_mode && !disable_async) || (ctx->by_n)) {
 		ret = -EINPROGRESS;
 		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
 		goto out;
@@ -1657,9 +1702,11 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*dlen = req->dlen;
 
-	if (!ctx->async_mode || disable_async)
+	if (!ctx->async_mode || disable_async) {
 		idxd_free_desc(wq, idxd_desc);
-
+		if (private_data)
+			private_data->desc[private_data->num_comp_descs--] = NULL;
+	}
 	/* Update stats */
 	update_total_decomp_bytes_in(slen);
 	update_wq_decomp_bytes(wq, slen);
@@ -1667,11 +1714,212 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	return ret;
 err:
 	idxd_free_desc(wq, idxd_desc);
+	if (private_data)
+		private_data->desc[private_data->num_comp_descs--] = NULL;
 	dev_dbg(dev, "iaa decompress failed: ret=%d\n", ret);
 
 	goto out;
 }
 
+static int iaa_comp_poll(struct acomp_req *req)
+{
+	struct iaa_compression_ctx *compression_ctx;
+	struct crypto_tfm *tfm = req->base.tfm;
+	struct iaa_private_data *private_data;
+	struct idxd_desc *idxd_desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct idxd_wq *wq;
+	bool compress;
+	int ret;
+	int i = 0;
+	int size;
+	u8 *dst;
+
+	private_data = *req->__ctx;
+	compression_ctx = crypto_tfm_ctx(tfm);
+
+	idxd_desc = req->base.data;
+	if (!idxd_desc)
+		return -EAGAIN;
+
+	compress = (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS);
+
+	wq = idxd_desc->wq;
+	iaa_wq = idxd_wq_get_private(wq);
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	for (i = 0; i < private_data->num_comp_descs; i++) {
+		idxd_desc = private_data->desc[i];
+		ret = check_completion(dev, idxd_desc->iax_completion, true, true);
+		if (ret == -EAGAIN)
+			return ret;
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		int num_wait = private_data->num_comp_descs;
+		unsigned long wait_mask = 0;
+
+		while (hweight64(wait_mask) != num_wait) {
+			for (i = 0; i < private_data->num_comp_descs; i++) {
+				idxd_desc = private_data->desc[i];
+				if (check_completion(dev, idxd_desc->iax_completion,
+						     true, true) != -EAGAIN)
+					set_bit(i, &wait_mask);
+			}
+		}
+		goto out;
+	}
+	idxd_desc = private_data->desc[0];
+
+	if (private_data && compress &&
+	    private_data->num_comp_descs < req->by_n) {
+		ret = -EIO;
+		goto out;
+	}
+
+	req->dlen = 0;
+	dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
+	size = private_data->num_comp_descs * HDR_ENTRY_SIZE;
+	for (i = 0; i < private_data->num_comp_descs; i++) {
+		idxd_desc = private_data->desc[i];
+		if ((idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS) &&
+		     compression_ctx->by_n) {
+			u32 *offset = (u32 *)dst;
+
+			size += idxd_desc->iax_completion->output_size;
+			offset[0] = private_data->num_comp_descs;
+
+			if (i < (private_data->num_comp_descs - 1))
+				offset[i+1] = size;
+
+			if (i > 0) {
+				memcpy(dst + offset[i],
+				       dst + (i * req->slen/private_data->num_comp_descs),
+				       idxd_desc->iax_completion->output_size);
+			}
+			req->dlen = size;
+		} else {
+			req->dlen += idxd_desc->iax_completion->output_size;
+		}
+	}
+	kunmap_local(dst);
+
+	/* Update stats */
+	if (compress) {
+		update_total_comp_bytes_out(req->dlen);
+		update_wq_comp_bytes(wq, req->dlen);
+	} else {
+		update_total_decomp_bytes_in(req->slen);
+		update_wq_decomp_bytes(wq, req->slen);
+	}
+
+	if (!compression_ctx->by_n && iaa_verify_compress &&
+	    (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS)) {
+		struct crypto_tfm *tfm = req->base.tfm;
+		dma_addr_t src_addr, dst_addr;
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+
+		src_addr = sg_dma_address(req->src);
+		dst_addr = sg_dma_address(req->dst);
+
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+out:
+	/* caller doesn't call crypto_wait_req, so no acomp_request_complete() */
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+
+	for (i = 0; i < private_data->num_comp_descs; i++) {
+		idxd_desc = private_data->desc[i];
+		idxd_free_desc(idxd_desc->wq, idxd_desc);
+		iaa_wq_put(idxd_desc->wq);
+		private_data->desc[i] = NULL;
+	}
+	private_data->num_comp_descs = 0;
+	return ret;
+}
+
+static int iaa_compress_by_n(struct crypto_tfm *tfm, struct acomp_req *req,
+			  struct idxd_wq *wq,
+			  dma_addr_t src_addr, unsigned int slen,
+			  dma_addr_t dst_addr, unsigned int *dlen,
+			  bool disable_async, int cpu)
+{
+	struct iaa_compression_ctx *compression_ctx;
+	struct iaa_wq *iaa_wq;
+	u32 compression_crc;
+	int ret = 0;
+	int i;
+
+	iaa_wq = idxd_wq_get_private(wq);
+	compression_ctx = crypto_tfm_ctx(tfm);
+
+	if (req->by_n < 1 || req->by_n > MAX_BYN_DESC) {
+		pr_debug("by_n value is too large max value is %d\n", MAX_BYN_DESC);
+		ret = -EINVAL;
+		iaa_comp_poll(req);
+		goto out;
+	}
+
+	for (i = 0; i < req->by_n; i++) {
+		unsigned int byn_dlen = (i == 0) ?
+					req->slen/req->by_n - (HDR_ENTRY_SIZE * (req->by_n)) :
+					req->slen/req->by_n;
+		int offset = i == 0 ? (HDR_ENTRY_SIZE * (req->by_n)) : 0;
+
+		ret = iaa_compress(tfm, req, wq, src_addr + (i * req->slen/req->by_n),
+				   req->slen/req->by_n,
+				   dst_addr + (i * req->slen/req->by_n) + offset,
+				   &byn_dlen, &compression_crc, disable_async);
+		if (ret != -EINPROGRESS && compression_ctx->async_mode)
+			break;
+
+		if (i == (req->by_n - 1))
+			break;
+
+		wq = wq_table_next_wq(cpu);
+
+		if (!wq) {
+			pr_debug("no wq configured for cpu=%d\n", cpu);
+			ret = -ENODEV;
+			break;
+		}
+
+		ret = iaa_wq_get(wq);
+
+		if (ret) {
+			pr_debug("no wq available for cpu=%d\n", cpu);
+			ret = -ENODEV;
+			break;
+		}
+
+		iaa_wq = idxd_wq_get_private(wq);
+	}
+
+	if (!compression_ctx->async_mode && !compression_ctx->use_irq) {
+		ret = iaa_comp_poll(req);
+		while (ret == -EAGAIN)
+			ret = iaa_comp_poll(req);
+	}
+
+out:
+	return ret;
+}
+
 static int iaa_comp_acompress(struct acomp_req *req)
 {
 	struct iaa_compression_ctx *compression_ctx;
@@ -1759,12 +2007,17 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
-	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
+	if (compression_ctx->by_n)
+		return iaa_compress_by_n(tfm, req, wq, src_addr, req->slen, dst_addr,
+					&req->dlen, disable_async, cpu);
+	else
+		ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
 			   &req->dlen, &compression_crc, disable_async);
+
 	if (ret == -EINPROGRESS)
 		return ret;
 
-	if (!ret && compression_ctx->verify_compress) {
+	if (!ret && compression_ctx->verify_compress && !compression_ctx->by_n) {
 		ret = iaa_remap_for_verify(dev, iaa_wq, req, &src_addr, &dst_addr);
 		if (ret) {
 			dev_dbg(dev, "%s: compress verify remap failed ret=%d\n", __func__, ret);
@@ -1890,12 +2143,16 @@ static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
 
 static int iaa_comp_adecompress(struct acomp_req *req)
 {
+	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
 	int nr_sgs, cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
 	struct idxd_wq *wq;
+	int i;
+
+	compression_ctx = crypto_tfm_ctx(tfm);
 
 	if (!iaa_crypto_enabled) {
 		pr_debug("iaa_crypto disabled, not decompressing\n");
@@ -1954,14 +2211,90 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
-	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
-			     dst_addr, &req->dlen, false);
+
+	if (!compression_ctx->by_n) {
+		ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
+				     dst_addr, &req->dlen, false);
+	} else {
+		u32 start_offset = 0;
+		u32 chunk_size = 0;
+		unsigned int byn_dlen;
+		u32 *offsets;
+		void *src;
+		int by_n;
+
+		src = kmap_local_page(sg_page(req->src)) + req->src->offset;
+		offsets = (u32 *)src;
+		by_n = offsets[0];
+		byn_dlen = req->dlen/by_n;
+
+		if (by_n < 1 || by_n > MAX_BYN_DESC) {
+			ret = -EINVAL;
+			kunmap_local(src);
+			pr_debug("by_n value is too large max value is %d\n", MAX_BYN_DESC);
+			goto err_by_n;
+		}
+
+		for (i = 0; i < by_n; i++) {
+			if (i == 0) {
+				start_offset =  ((by_n) * HDR_ENTRY_SIZE);
+				chunk_size = (by_n == 1) ? req->slen - HDR_ENTRY_SIZE :
+				offsets[1] - ((by_n) * HDR_ENTRY_SIZE);
+			} else {
+				start_offset = offsets[i];
+				chunk_size = (i == (by_n - 1)) ? req->slen - offsets[i] :
+				offsets[i+1] - offsets[i];
+			}
+
+			/*
+			 * byn_dlen doesn't get modified for a by_n decomp, so we don't need
+			 * to set the value again but we may want to separate dlen being used
+			 * as input and output.
+			 */
+
+			ret = iaa_decompress(tfm, req, wq, src_addr + start_offset, chunk_size,
+					     dst_addr +  (i * req->dlen/by_n), &byn_dlen, false);
+
+			if (ret != -EINPROGRESS)
+				break;
+
+			if (i == (by_n - 1))
+				break;
+
+			wq = wq_table_next_wq(cpu);
+
+			if (!wq) {
+				pr_debug("no wq configured for cpu=%d\n", cpu);
+				ret = -ENODEV;
+				break;
+			}
+
+			ret = iaa_wq_get(wq);
+			if (ret) {
+				pr_debug("no wq available for cpu=%d\n", cpu);
+				ret = -ENODEV;
+				break;
+			}
+			iaa_wq = idxd_wq_get_private(wq);
+		}
+
+		kunmap_local(src);
+
+		if (!compression_ctx->async_mode && !compression_ctx->use_irq) {
+			ret = iaa_comp_poll(req);
+			while (ret == -EAGAIN)
+				ret = iaa_comp_poll(req);
+		}
+		return ret;
+	}
+
 	if (ret == -EINPROGRESS)
 		return ret;
 
 	if (ret != 0)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
+err_by_n:
 	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
 err_map_dst:
 	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
@@ -2040,6 +2373,37 @@ static struct acomp_alg iaa_acomp_canned_deflate = {
 	}
 };
 
+static int iaa_comp_init_canned_by_n(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	compression_ctx_init(ctx);
+
+	ctx->mode = IAA_MODE_CANNED;
+
+	ctx->by_n = true;
+
+	return 0;
+}
+
+static struct acomp_alg iaa_acomp_canned_by_n_deflate = {
+	.init			= iaa_comp_init_canned_by_n,
+	.compress		= iaa_comp_acompress,
+	.decompress		= iaa_comp_adecompress,
+	.dst_free               = dst_free,
+	.pre_alloc		= iaa_alloc_private_data,
+	.post_free		= iaa_free_private_data,
+	.base			= {
+		.cra_name		= "deflate-canned-by_n",
+		.cra_driver_name	= "deflate-iaa-canned-by_n",
+		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
+		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_module		= THIS_MODULE,
+		.cra_priority		= IAA_ALG_PRIORITY,
+	}
+};
+
 static int iaa_comp_init_dynamic(struct crypto_acomp *acomp_tfm)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
@@ -2085,6 +2449,13 @@ static int iaa_register_compression_device(struct idxd_device *idxd)
 	}
 	iaa_crypto_canned_registered = true;
 
+	ret = crypto_register_acomp(&iaa_acomp_canned_by_n_deflate);
+	if (ret) {
+		pr_err("deflate algorithm acomp canned_by_n registration failed (%d)\n", ret);
+		goto err_canned_by_n;
+	}
+	iaa_crypto_canned_by_n_registered = true;
+
 	/* Header Generation Capability is required for the dynamic algorithm. */
 	if (idxd->hw.iaa_cap.header_gen) {
 		ret = crypto_register_acomp(&iaa_acomp_dynamic_deflate);
@@ -2098,6 +2469,9 @@ static int iaa_register_compression_device(struct idxd_device *idxd)
 	goto out;
 
 err_dynamic:
+	crypto_unregister_acomp(&iaa_acomp_canned_by_n_deflate);
+	iaa_crypto_canned_by_n_registered = false;
+err_canned_by_n:
 	crypto_unregister_acomp(&iaa_acomp_canned_deflate);
 	iaa_crypto_canned_registered = false;
 err_canned:
@@ -2113,6 +2487,8 @@ static int iaa_unregister_compression_device(void)
 		crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
 	if (iaa_crypto_canned_registered)
 		crypto_unregister_acomp(&iaa_acomp_canned_deflate);
+	if (iaa_crypto_canned_by_n_registered)
+		crypto_unregister_acomp(&iaa_acomp_canned_by_n_deflate);
 	if (iaa_crypto_dynamic_registered)
 		crypto_unregister_acomp(&iaa_acomp_dynamic_deflate);
 
-- 
2.27.0


