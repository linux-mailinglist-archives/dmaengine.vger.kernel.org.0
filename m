Return-Path: <dmaengine+bounces-1107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2A862CC0
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654E5282CF6
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E71BC5E;
	Sun, 25 Feb 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMi3W9cp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAF1BC2F;
	Sun, 25 Feb 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891919; cv=none; b=D+LygMI9rzAe6bRXsFN1Dwug9YZyJGIX2mtGOSgODNMmU0Pi2H2/n1LPHBQw6TMM8QZBUExkj4Yk1X7D1EU5tvOPOE6lWa0J9WN+ckg0ZLrQM40/Nc+szcRYgVLMpmVZmxAr+MQHEwqqmJyUqtimwcEKkKUHA9AGZ/FHTTpxBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891919; c=relaxed/simple;
	bh=2ZHJPk46orqg1Qb+fXEa/VDYyDsc6n+YD/UPcHAmhuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YxY5bqz7iZH4ZIkONPz7kfaW6d6VDEm6Qq/b+uSOwoKjZKHw1lUuuVZBXtr5Alo0TYVz1qB+NlFtk8TpRSllXcNbLK7OZsB94lFPhYANKaxR7xwXh6oC+F3EDbDcFjzxfzDbP6w6JJvFYRCoiNZlIp7m3EImtWSwtX6KQT/AX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMi3W9cp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708891918; x=1740427918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ZHJPk46orqg1Qb+fXEa/VDYyDsc6n+YD/UPcHAmhuA=;
  b=TMi3W9cpMI+oqVydVw/2r3f6C/FNnYRZSQkgKEyfZYCqxQ+8O6zTtWyJ
   8eNJg10rSEyPa7ivUpXG3mw2FdshTE4ANI7zYKUABiuUlJLIluPrjuEXH
   Zy/AO0PZlucMOK+lwcGn8tCPX7hpWuJ3R7sgOvnDV2rOxARyFZZW8VdbN
   rWik3Su/u7wDL4ob8d4vrT0ZOQcUndEVj8aKY/KRCCTq0NkCQ779aPKGN
   c9NwRbDXWZGggqAxt+XTOajD+fofvmdP36j9PRX5GMf81/Itd8FW+jRTm
   sERlCkSMw0SF3WcLcIoP2tx5ZR/PijoVFW4pru3YJg8RQmJRVKzxs5KlS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="25639535"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="25639535"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="29632554"
Received: from rfredric-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.171.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:11:57 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: rex.zhang@intel.com,
	andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 2/2] crypto: iaa - Fix comp/decomp delay statistics
Date: Sun, 25 Feb 2024 14:11:34 -0600
Message-Id: <20240225201134.759335-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225201134.759335-1-tom.zanussi@linux.intel.com>
References: <20240225201134.759335-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comp/decomp delay statistics currently have no callers; somehow
they were dropped during refactoring. There originally were also two
sets, one for the async algorithm, the other for the synchronous
version. Because the synchronous algorithm was dropped, one set should
be removed. To keep it consistent with the rest of the stats, and
since there's no ambiguity, remove the acomp/adecomp versions.  Also
add back the callers.

Reported-by: Rex Zhang <rex.zhang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c  |  9 +++++++
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 28 ---------------------
 drivers/crypto/intel/iaa/iaa_crypto_stats.h |  8 +++---
 3 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 85ee4c965ccf..b54f93c64033 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1494,6 +1494,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	u32 compression_crc;
 	struct idxd_wq *wq;
 	struct device *dev;
+	u64 start_time_ns;
 	int order = -1;
 
 	compression_ctx = crypto_tfm_ctx(tfm);
@@ -1567,8 +1568,10 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
+	start_time_ns = iaa_get_ts();
 	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
 			   &req->dlen, &compression_crc, disable_async);
+	update_max_comp_delay_ns(start_time_ns);
 	if (ret == -EINPROGRESS)
 		return ret;
 
@@ -1615,6 +1618,7 @@ static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
 	struct idxd_wq *wq;
+	u64 start_time_ns;
 	int order = -1;
 
 	cpu = get_cpu();
@@ -1671,8 +1675,10 @@ static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
 	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
+	start_time_ns = iaa_get_ts();
 	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
 			     dst_addr, &req->dlen, true);
+	update_max_decomp_delay_ns(start_time_ns);
 	if (ret == -EOVERFLOW) {
 		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
 		req->dlen *= 2;
@@ -1703,6 +1709,7 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	int nr_sgs, cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
+	u64 start_time_ns;
 	struct idxd_wq *wq;
 
 	if (!iaa_crypto_enabled) {
@@ -1762,8 +1769,10 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
+	start_time_ns = iaa_get_ts();
 	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
 			     dst_addr, &req->dlen, false);
+	update_max_decomp_delay_ns(start_time_ns);
 	if (ret == -EINPROGRESS)
 		return ret;
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index cbf87d0effe3..c9f83af4b307 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -22,8 +22,6 @@ static u64 total_decomp_calls;
 static u64 total_sw_decomp_calls;
 static u64 max_comp_delay_ns;
 static u64 max_decomp_delay_ns;
-static u64 max_acomp_delay_ns;
-static u64 max_adecomp_delay_ns;
 static u64 total_comp_bytes_out;
 static u64 total_decomp_bytes_in;
 static u64 total_completion_einval_errors;
@@ -92,26 +90,6 @@ void update_max_decomp_delay_ns(u64 start_time_ns)
 		max_decomp_delay_ns = time_diff;
 }
 
-void update_max_acomp_delay_ns(u64 start_time_ns)
-{
-	u64 time_diff;
-
-	time_diff = ktime_get_ns() - start_time_ns;
-
-	if (time_diff > max_acomp_delay_ns)
-		max_acomp_delay_ns = time_diff;
-}
-
-void update_max_adecomp_delay_ns(u64 start_time_ns)
-{
-	u64 time_diff;
-
-	time_diff = ktime_get_ns() - start_time_ns;
-
-	if (time_diff > max_adecomp_delay_ns)
-		max_adecomp_delay_ns = time_diff;
-}
-
 void update_wq_comp_calls(struct idxd_wq *idxd_wq)
 {
 	struct iaa_wq *wq = idxd_wq_get_private(idxd_wq);
@@ -151,8 +129,6 @@ static void reset_iaa_crypto_stats(void)
 	total_sw_decomp_calls = 0;
 	max_comp_delay_ns = 0;
 	max_decomp_delay_ns = 0;
-	max_acomp_delay_ns = 0;
-	max_adecomp_delay_ns = 0;
 	total_comp_bytes_out = 0;
 	total_decomp_bytes_in = 0;
 	total_completion_einval_errors = 0;
@@ -280,10 +256,6 @@ int __init iaa_crypto_debugfs_init(void)
 			   iaa_crypto_debugfs_root, &max_comp_delay_ns);
 	debugfs_create_u64("max_decomp_delay_ns", 0644,
 			   iaa_crypto_debugfs_root, &max_decomp_delay_ns);
-	debugfs_create_u64("max_acomp_delay_ns", 0644,
-			   iaa_crypto_debugfs_root, &max_comp_delay_ns);
-	debugfs_create_u64("max_adecomp_delay_ns", 0644,
-			   iaa_crypto_debugfs_root, &max_decomp_delay_ns);
 	debugfs_create_u64("total_comp_calls", 0644,
 			   iaa_crypto_debugfs_root, &total_comp_calls);
 	debugfs_create_u64("total_decomp_calls", 0644,
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
index c10b87b86fa4..c916ca83f070 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
@@ -15,8 +15,6 @@ void	update_total_sw_decomp_calls(void);
 void	update_total_decomp_bytes_in(int n);
 void	update_max_comp_delay_ns(u64 start_time_ns);
 void	update_max_decomp_delay_ns(u64 start_time_ns);
-void	update_max_acomp_delay_ns(u64 start_time_ns);
-void	update_max_adecomp_delay_ns(u64 start_time_ns);
 void	update_completion_einval_errs(void);
 void	update_completion_timeout_errs(void);
 void	update_completion_comp_buf_overflow_errs(void);
@@ -26,6 +24,8 @@ void	update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n);
 void	update_wq_decomp_calls(struct idxd_wq *idxd_wq);
 void	update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n);
 
+static inline u64	iaa_get_ts(void) { return ktime_get_ns(); }
+
 #else
 static inline int	iaa_crypto_debugfs_init(void) { return 0; }
 static inline void	iaa_crypto_debugfs_cleanup(void) {}
@@ -37,8 +37,6 @@ static inline void	update_total_sw_decomp_calls(void) {}
 static inline void	update_total_decomp_bytes_in(int n) {}
 static inline void	update_max_comp_delay_ns(u64 start_time_ns) {}
 static inline void	update_max_decomp_delay_ns(u64 start_time_ns) {}
-static inline void	update_max_acomp_delay_ns(u64 start_time_ns) {}
-static inline void	update_max_adecomp_delay_ns(u64 start_time_ns) {}
 static inline void	update_completion_einval_errs(void) {}
 static inline void	update_completion_timeout_errs(void) {}
 static inline void	update_completion_comp_buf_overflow_errs(void) {}
@@ -48,6 +46,8 @@ static inline void	update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n) {}
 static inline void	update_wq_decomp_calls(struct idxd_wq *idxd_wq) {}
 static inline void	update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n) {}
 
+static inline u64	iaa_get_ts(void) { return 0; }
+
 #endif // CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS
 
 #endif
-- 
2.34.1


