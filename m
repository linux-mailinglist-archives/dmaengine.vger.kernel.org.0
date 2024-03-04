Return-Path: <dmaengine+bounces-1254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBBA870C50
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 22:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD342874A8
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98F7BAE2;
	Mon,  4 Mar 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxQAEf6B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CEC47F79;
	Mon,  4 Mar 2024 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587220; cv=none; b=eXWWmIVDEyCnoooGrkwdQo82GMYUKIlk8c1jEc3OAZWgJNkFnJG2l/GoQknxo8OPjnav8PokMNP53Z3WejXjClPyZwS5sGI04NgtgR+gQXBwDWu/HesHLZXHbynt5jHSeVYplOATs8M9fRC8NBkAlx6+yZdg1+82V/hZwb536DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587220; c=relaxed/simple;
	bh=88Pe+kMFtA2O1ACHKEEsbE0yNTFbS+C7bzIC7aRQfyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwJ4jYa6f3IrpqKPjBXqRkgUh4faFH2cHZWPYl0hf2E7D7yNmKs8br9QfjBBaMV93coNJnNZVeeKDjCQJ6pYWLDYmKR2ZnSEYglnbl4S/t0sJAqC4thigGM8en5g/3klslofB0kHUIocqJ+AVSdFrJFZJDH/9Ur6HgOUmOFlx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxQAEf6B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587219; x=1741123219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=88Pe+kMFtA2O1ACHKEEsbE0yNTFbS+C7bzIC7aRQfyY=;
  b=lxQAEf6BWcaexBTDANLzDC8f+H+VrPf1+UWE9LrWmUW76mQW75LpwJL0
   SG+qVJtZtK8rSSWueXgGjzoh4ad1oJ7uijW2jM9xkWB41Zzxh8VwcdT+5
   cDhvRrKnhKq1KXpDBLUmAnlkrWRZcH9WQPPhWoJ+aLaNow4E2v31NXepj
   8ubzG3c17iRIsw/1ztg7mXxvee0zkeh/TinHkTmS2TXYL415Wcmt35WNP
   9a2oavUC25fx0CV6kDc4d9siSto18sd/BDOzLlNOTdW7xHq5gsSCgG6f+
   vsdl+mBQBk0rIAd2A0JKePmBn1bzeApqgEp+o3vAQhUlkpDdjeOCgmOCA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4271347"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4271347"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9040258"
Received: from skedaras-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.77.241])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:18 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 2/4] crypto: iaa - Remove comp/decomp delay statistics
Date: Mon,  4 Mar 2024 15:20:09 -0600
Message-Id: <20240304212011.1525003-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>
References: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the simplification/cleanup of the iaa statistics, remove
the comp/decomp delay statistics.

They're actually not really useful and can be/are being more flexibly
generated using standard kernel tracing infrastructure.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c  |  9 -------
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 28 ---------------------
 drivers/crypto/intel/iaa/iaa_crypto_stats.h |  8 ------
 3 files changed, 45 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 466bd0c71816..89bc06d4ebc9 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1494,7 +1494,6 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	u32 compression_crc;
 	struct idxd_wq *wq;
 	struct device *dev;
-	u64 start_time_ns;
 	int order = -1;
 
 	compression_ctx = crypto_tfm_ctx(tfm);
@@ -1568,10 +1567,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
-	start_time_ns = iaa_get_ts();
 	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
 			   &req->dlen, &compression_crc, disable_async);
-	update_max_comp_delay_ns(start_time_ns);
 	if (ret == -EINPROGRESS)
 		return ret;
 
@@ -1618,7 +1615,6 @@ static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
 	struct idxd_wq *wq;
-	u64 start_time_ns;
 	int order = -1;
 
 	cpu = get_cpu();
@@ -1675,10 +1671,8 @@ static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
 	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
-	start_time_ns = iaa_get_ts();
 	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
 			     dst_addr, &req->dlen, true);
-	update_max_decomp_delay_ns(start_time_ns);
 	if (ret == -EOVERFLOW) {
 		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
 		req->dlen *= 2;
@@ -1709,7 +1703,6 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	int nr_sgs, cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
-	u64 start_time_ns;
 	struct idxd_wq *wq;
 
 	if (!iaa_crypto_enabled) {
@@ -1769,10 +1762,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
-	start_time_ns = iaa_get_ts();
 	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
 			     dst_addr, &req->dlen, false);
-	update_max_decomp_delay_ns(start_time_ns);
 	if (ret == -EINPROGRESS)
 		return ret;
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index c9f83af4b307..7820062a91e5 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -20,8 +20,6 @@
 static u64 total_comp_calls;
 static u64 total_decomp_calls;
 static u64 total_sw_decomp_calls;
-static u64 max_comp_delay_ns;
-static u64 max_decomp_delay_ns;
 static u64 total_comp_bytes_out;
 static u64 total_decomp_bytes_in;
 static u64 total_completion_einval_errors;
@@ -70,26 +68,6 @@ void update_completion_comp_buf_overflow_errs(void)
 	total_completion_comp_buf_overflow_errors++;
 }
 
-void update_max_comp_delay_ns(u64 start_time_ns)
-{
-	u64 time_diff;
-
-	time_diff = ktime_get_ns() - start_time_ns;
-
-	if (time_diff > max_comp_delay_ns)
-		max_comp_delay_ns = time_diff;
-}
-
-void update_max_decomp_delay_ns(u64 start_time_ns)
-{
-	u64 time_diff;
-
-	time_diff = ktime_get_ns() - start_time_ns;
-
-	if (time_diff > max_decomp_delay_ns)
-		max_decomp_delay_ns = time_diff;
-}
-
 void update_wq_comp_calls(struct idxd_wq *idxd_wq)
 {
 	struct iaa_wq *wq = idxd_wq_get_private(idxd_wq);
@@ -127,8 +105,6 @@ static void reset_iaa_crypto_stats(void)
 	total_comp_calls = 0;
 	total_decomp_calls = 0;
 	total_sw_decomp_calls = 0;
-	max_comp_delay_ns = 0;
-	max_decomp_delay_ns = 0;
 	total_comp_bytes_out = 0;
 	total_decomp_bytes_in = 0;
 	total_completion_einval_errors = 0;
@@ -252,10 +228,6 @@ int __init iaa_crypto_debugfs_init(void)
 
 	iaa_crypto_debugfs_root = debugfs_create_dir("iaa_crypto", NULL);
 
-	debugfs_create_u64("max_comp_delay_ns", 0644,
-			   iaa_crypto_debugfs_root, &max_comp_delay_ns);
-	debugfs_create_u64("max_decomp_delay_ns", 0644,
-			   iaa_crypto_debugfs_root, &max_decomp_delay_ns);
 	debugfs_create_u64("total_comp_calls", 0644,
 			   iaa_crypto_debugfs_root, &total_comp_calls);
 	debugfs_create_u64("total_decomp_calls", 0644,
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
index c916ca83f070..3787a5f507eb 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
@@ -13,8 +13,6 @@ void	update_total_comp_bytes_out(int n);
 void	update_total_decomp_calls(void);
 void	update_total_sw_decomp_calls(void);
 void	update_total_decomp_bytes_in(int n);
-void	update_max_comp_delay_ns(u64 start_time_ns);
-void	update_max_decomp_delay_ns(u64 start_time_ns);
 void	update_completion_einval_errs(void);
 void	update_completion_timeout_errs(void);
 void	update_completion_comp_buf_overflow_errs(void);
@@ -24,8 +22,6 @@ void	update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n);
 void	update_wq_decomp_calls(struct idxd_wq *idxd_wq);
 void	update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n);
 
-static inline u64	iaa_get_ts(void) { return ktime_get_ns(); }
-
 #else
 static inline int	iaa_crypto_debugfs_init(void) { return 0; }
 static inline void	iaa_crypto_debugfs_cleanup(void) {}
@@ -35,8 +31,6 @@ static inline void	update_total_comp_bytes_out(int n) {}
 static inline void	update_total_decomp_calls(void) {}
 static inline void	update_total_sw_decomp_calls(void) {}
 static inline void	update_total_decomp_bytes_in(int n) {}
-static inline void	update_max_comp_delay_ns(u64 start_time_ns) {}
-static inline void	update_max_decomp_delay_ns(u64 start_time_ns) {}
 static inline void	update_completion_einval_errs(void) {}
 static inline void	update_completion_timeout_errs(void) {}
 static inline void	update_completion_comp_buf_overflow_errs(void) {}
@@ -46,8 +40,6 @@ static inline void	update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n) {}
 static inline void	update_wq_decomp_calls(struct idxd_wq *idxd_wq) {}
 static inline void	update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n) {}
 
-static inline u64	iaa_get_ts(void) { return 0; }
-
 #endif // CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS
 
 #endif
-- 
2.34.1


