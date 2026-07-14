Return-Path: <dmaengine+bounces-12449-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DwhrKPu2VWqcrwAAu9opvQ
	(envelope-from <dmaengine+bounces-12449-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374F750C16
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CSHuPKr+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12449-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12449-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E04E3034B77
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50493340A6F;
	Tue, 14 Jul 2026 04:11:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD03B0AEF;
	Tue, 14 Jul 2026 04:11:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002284; cv=none; b=Xn1/md4VXWicWMtKqn+nWKuKbJYcgJ5op+GiF8ZF9VxDDeHNy05UpmeO93U+x2Er35j1vQLfRWEPh22odHZ2WWZdmjsf0Q27RTsfiPCEqL9oyXuIUYGmL/mAhq2qhIV1rxvsrCKSMPtBpvXFM5nQ51vhtHxiEUSC7G2N77JsxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002284; c=relaxed/simple;
	bh=dDkV8rRh4v6dOr4vEdgVLR9a6liTDDRDpJ0Z/lOagTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwYaF0/DaTzFupaUTCLhl+Xk1kMFd1DwJc2kWgCGIhnpawDV/cE9NmtUB4FYO4GBCJVTGIB/K/ztaj4zs3j2ecEXH3X3hWddf0hd7ZpfspzNic3oe3uisA3Vl1DYohyL3mF7Z4yrkEkIsKfRPZJTMaL5gswu/wbdnXpXll7VJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSHuPKr+; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784002274; x=1815538274;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dDkV8rRh4v6dOr4vEdgVLR9a6liTDDRDpJ0Z/lOagTA=;
  b=CSHuPKr+ImYRNzce3h5gC0Eu0H/YHbPJ1YprOm3WR5Lf/GMryBGj65TV
   +scftWhr2Q5VrTnmHnW+WLkAnTcacMJ4kgCnM3ILBX5i4zu+hnnuDI67i
   4mORDAYSfVHRFIE+HHm8YmiM/T33k6wNTTZf/IDm8Y2+LVCyg4nxbJad7
   RbYYJEyI4wPCoHTrSbL6bh8K39/o9OTe3VH8z2TLWAUVSYpUlMQnZ8Rih
   S81sY80yIEotgaubYZTjfNYcd+eOsRfRf3EpPwhMARITFip/MYspandA7
   9h4DLIxnuMYhmwgMxrljXHruTa+2yQHiF5VTH4TGFFtWeRiP93FxlpeTU
   A==;
X-CSE-ConnectionGUID: ix6heqfAT/e+K7ovqoVu7w==
X-CSE-MsgGUID: X+fbh165TyGe2GNtv2+eTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94970496"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94970496"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:10 -0700
X-CSE-ConnectionGUID: fYLFWutNRISUtZmR/uFicw==
X-CSE-MsgGUID: ODymvmhySKyOv3vMci0N2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249383524"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:09 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 13 Jul 2026 21:10:56 -0700
Subject: [PATCH 4/4] crypto: iaa - use bounce buffer for multi-sg
 decompress input
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-iaa-crypto-fixes-zswap-v1-4-65cac23c684d@intel.com>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 Kristen Accardi <kristen.c.accardi@intel.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784002267; l=10830;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=p1gGEqzD5ux4EjagTqMYvoTxA8Qq3vs/vbF7VLcJ3v4=;
 b=JWQEMEY+i1NfiJymTtZdvm9RYje9J++66fiOppgbrDc/BS81M30YUNJYIs4IbbAbCFsfMe3WW
 dpdYgYST3BWCnsoH3fONfwI9+OfyQ26IRYvcjxXoAQuw1G/e7YGQ0/X
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:dave.jiang@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kristen.c.accardi@intel.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:akpm@linux-foundation.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:vinicius.gomes@intel.com,m:giovanni.cabiddu@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,kernel.org,gondor.apana.org.au,davemloft.net,linux-foundation.org,gmail.com];
	FORGED_SENDER(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12449-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3374F750C16

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Since commit e2c3b6b21c77 ("mm: zswap: use SG list decompression APIs
from zsmalloc"), zswap passes the raw zsmalloc SG list directly to
crypto drivers, so a compressed object spanning multiple pages reaches
IAA as a multi-entry source. Such requests currently fall back to
software decompression.

As IAA hardware requires a single DMA source buffer, linearize small
multi-entry sources into a pre-allocated bounce page and submit that to
the hardware instead of falling back to software. Keep the software
fallback only for multi-entry destinations. This recovers most of the
performance lost by using the software fallback.

Store the bounce-page state in the acomp request context alongside the
existing compression CRC, free it through a shared source-unmap helper,
and back the pages with a small module-wide mempool so the path remains
available in reclaim-driven callers.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 110 ++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 8f68b1478476..54bde11c454c 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -9,6 +9,7 @@
 #include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/iommu.h>
+#include <linux/mempool.h>
 #include <uapi/linux/idxd.h>
 #include <linux/highmem.h>
 #include <linux/sched/smt.h>
@@ -157,6 +158,15 @@ static bool async_mode;
 /* Use interrupts */
 static bool use_irq;
 
+struct iaa_req_ctx {
+	u32 compression_crc;
+	struct page *bounce_src;
+	struct scatterlist bounce_sg;
+};
+
+static mempool_t *iaa_bounce_pool;
+#define IAA_BOUNCE_POOL_SIZE	128
+
 /**
  * set_iaa_sync_mode - Set IAA sync mode
  * @name: The name of the sync mode
@@ -984,6 +994,19 @@ static inline int check_completion(struct device *dev,
 	return ret;
 }
 
+static void iaa_unmap_src(struct device *dev, struct acomp_req *req)
+{
+	struct iaa_req_ctx *req_ctx = acomp_request_ctx(req);
+	struct scatterlist *src = req_ctx->bounce_src ? &req_ctx->bounce_sg : req->src;
+
+	dma_unmap_sg(dev, src, 1, DMA_TO_DEVICE);
+
+	if (req_ctx->bounce_src) {
+		mempool_free(req_ctx->bounce_src, iaa_bounce_pool);
+		req_ctx->bounce_src = NULL;
+	}
+}
+
 static int deflate_fallback(struct acomp_req *req, bool compress)
 {
 	ACOMP_FBREQ_ON_STACK(fbreq, req);
@@ -1040,6 +1063,7 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_ctx *ctx = __ctx;
+	struct iaa_req_ctx *req_ctx = acomp_request_ctx(ctx->req);
 	struct iaa_device *iaa_device;
 	struct idxd_device *idxd;
 	struct iaa_wq *iaa_wq;
@@ -1098,10 +1122,9 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 	}
 
 	if (ctx->compress && compression_ctx->verify_compress) {
-		u32 *compression_crc = acomp_request_ctx(ctx->req);
 		dma_addr_t src_addr, dst_addr;
 
-		*compression_crc = idxd_desc->iax_completion->crc;
+		req_ctx->compression_crc = idxd_desc->iax_completion->crc;
 
 		ret = iaa_remap_for_verify(dev, iaa_wq, ctx->req, &src_addr, &dst_addr);
 		if (ret) {
@@ -1124,7 +1147,7 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 	}
 err:
 	dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst), DMA_FROM_DEVICE);
-	dma_unmap_sg(dev, ctx->req->src, sg_nents(ctx->req->src), DMA_TO_DEVICE);
+	iaa_unmap_src(dev, ctx->req);
 out:
 	if (ret != 0)
 		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
@@ -1144,7 +1167,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
-	u32 *compression_crc = acomp_request_ctx(req);
+	struct iaa_req_ctx *req_ctx = acomp_request_ctx(req);
 	struct iaa_device *iaa_device;
 	struct idxd_desc *idxd_desc;
 	struct iax_hw_desc *desc;
@@ -1235,7 +1258,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	update_total_comp_bytes_out(*dlen);
 	update_wq_comp_bytes(wq, *dlen);
 
-	*compression_crc = idxd_desc->iax_completion->crc;
+	req_ctx->compression_crc = idxd_desc->iax_completion->crc;
 
 	if (!ctx->async_mode)
 		idxd_free_desc(wq, idxd_desc);
@@ -1295,7 +1318,7 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
-	u32 *compression_crc = acomp_request_ctx(req);
+	struct iaa_req_ctx *req_ctx = acomp_request_ctx(req);
 	struct iaa_device *iaa_device;
 	struct idxd_desc *idxd_desc;
 	struct iax_hw_desc *desc;
@@ -1355,10 +1378,10 @@ static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
 		goto err;
 	}
 
-	if (*compression_crc != idxd_desc->iax_completion->crc) {
+	if (req_ctx->compression_crc != idxd_desc->iax_completion->crc) {
 		ret = -EINVAL;
-		dev_dbg(dev, "(verify) iaa comp/decomp crc mismatch:"
-			" comp=0x%x, decomp=0x%x\n", *compression_crc,
+		dev_dbg(dev, "(verify) iaa comp/decomp crc mismatch: comp=0x%x, decomp=0x%x\n",
+			req_ctx->compression_crc,
 			idxd_desc->iax_completion->crc);
 		print_hex_dump(KERN_INFO, "cmp-rec: ", DUMP_PREFIX_OFFSET,
 			       8, 1, idxd_desc->iax_completion, 64, 0);
@@ -1498,6 +1521,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 static int iaa_comp_acompress(struct acomp_req *req)
 {
+	struct iaa_req_ctx *req_ctx = acomp_request_ctx(req);
 	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
@@ -1506,6 +1530,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct idxd_wq *wq;
 	struct device *dev;
 
+	req_ctx->bounce_src = NULL;
+
 	compression_ctx = crypto_tfm_ctx(tfm);
 
 	if (!iaa_crypto_enabled) {
@@ -1597,12 +1623,18 @@ static int iaa_comp_acompress(struct acomp_req *req)
 
 static int iaa_comp_adecompress(struct acomp_req *req)
 {
+	struct iaa_req_ctx *req_ctx = acomp_request_ctx(req);
 	struct crypto_tfm *tfm = req->base.tfm;
+	struct scatterlist *src = req->src;
 	dma_addr_t src_addr, dst_addr;
+	bool use_bounce_src = false;
 	int cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
 	struct idxd_wq *wq;
+	struct page *page;
+
+	req_ctx->bounce_src = NULL;
 
 	if (!iaa_crypto_enabled) {
 		pr_debug("iaa_crypto disabled, not decompressing\n");
@@ -1614,10 +1646,16 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		return -EINVAL;
 	}
 
-	/* Fall back to software if src or dst has multiple sg entries */
-	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
+	/* Fall back to software if dst has multiple sg entries */
+	if (sg_nents(req->dst) > 1)
 		return deflate_generic_decompress(req);
 
+	if (sg_nents(req->src) > 1) {
+		if (req->slen > PAGE_SIZE)
+			return deflate_generic_decompress(req);
+		use_bounce_src = true;
+	}
+
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1636,20 +1674,45 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 
 	dev = &wq->idxd->pdev->dev;
 
-	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
+	if (unlikely(use_bounce_src)) {
+		page = mempool_alloc(iaa_bounce_pool, GFP_ATOMIC);
+		if (!page) {
+			iaa_wq_put(wq);
+			return deflate_generic_decompress(req);
+		}
+
+		if (sg_copy_to_buffer(req->src, sg_nents(req->src),
+				      page_address(page), req->slen) != req->slen) {
+			mempool_free(page, iaa_bounce_pool);
+			iaa_wq_put(wq);
+			return deflate_generic_decompress(req);
+		}
+
+		sg_init_table(&req_ctx->bounce_sg, 1);
+		sg_set_page(&req_ctx->bounce_sg, page, req->slen, 0);
+		req_ctx->bounce_src = page;
+		src = &req_ctx->bounce_sg;
+	}
+
+	if (!dma_map_sg(dev, src, 1, DMA_TO_DEVICE)) {
 		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
 			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		if (req_ctx->bounce_src) {
+			mempool_free(req_ctx->bounce_src, iaa_bounce_pool);
+			req_ctx->bounce_src = NULL;
+		}
 		iaa_wq_put(wq);
 		return deflate_generic_decompress(req);
 	}
-	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
-		req->src, req->slen, sg_dma_len(req->src));
+	src_addr = sg_dma_address(src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr,
+		src, req->slen, sg_dma_len(src));
 
 	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
 		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
 			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
-		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
+		iaa_unmap_src(dev, req);
 		iaa_wq_put(wq);
 		return deflate_generic_decompress(req);
 	}
@@ -1666,7 +1729,7 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
 	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
-	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
+	iaa_unmap_src(dev, req);
 	iaa_wq_put(wq);
 
 	return ret;
@@ -1700,7 +1763,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 		.cra_driver_name	= "deflate-iaa",
 		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
-		.cra_reqsize		= sizeof(u32),
+		.cra_reqsize		= sizeof(struct iaa_req_ctx),
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= IAA_ALG_PRIORITY,
 	}
@@ -1899,6 +1962,12 @@ static int __init iaa_crypto_init_module(void)
 		goto err_aecs_init;
 	}
 
+	iaa_bounce_pool = mempool_create_page_pool(IAA_BOUNCE_POOL_SIZE, 0);
+	if (!iaa_bounce_pool) {
+		ret = -ENOMEM;
+		goto err_bounce_pool;
+	}
+
 	ret = idxd_driver_register(&iaa_crypto_driver);
 	if (ret) {
 		pr_debug("IAA wq sub-driver registration failed\n");
@@ -1932,6 +2001,9 @@ static int __init iaa_crypto_init_module(void)
 err_verify_attr_create:
 	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
+	mempool_destroy(iaa_bounce_pool);
+	iaa_bounce_pool = NULL;
+err_bounce_pool:
 	iaa_aecs_cleanup_fixed();
 err_aecs_init:
 
@@ -1948,6 +2020,8 @@ static void __exit iaa_crypto_cleanup_module(void)
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
+	mempool_destroy(iaa_bounce_pool);
+	iaa_bounce_pool = NULL;
 	iaa_aecs_cleanup_fixed();
 
 	pr_debug("cleaned up\n");

-- 
2.55.0


