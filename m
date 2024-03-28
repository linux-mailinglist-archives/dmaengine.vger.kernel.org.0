Return-Path: <dmaengine+bounces-1630-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB31890766
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7161C29E9F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDF128370;
	Thu, 28 Mar 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcsbCQW6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93E12F38C;
	Thu, 28 Mar 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647912; cv=none; b=NREPul0fah30+zY1eC07AyPm5qPLjD1GTe0pxxEfFApr1axfbDaK9LIOw7VtrIn62AlZU7gn/Zv9um4LTkiQUA5NImHEW9LlFlENCPWPyTN/hforoUv8Zi8LGs4SG0gdqLHi4ZE1T96t7QesJ0S9r2oujLWfp2oFwVLrIPQkK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647912; c=relaxed/simple;
	bh=OiI+HabGYQA9Bx+Wt6goUKKVjRy0/sOX9BxjFGUxS9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZAhey7kuJl2d74Vp0hmLxMTTDjfG0N1qyBtZ3E+OkYi9XOJiugGt5jbV8cUJ3ZYQNn1TVAXC63Ho5VDQYRNmqEHYUMaC4gHI/TwMoRQ0HiCWE3Wah/tzfwoFOFdoHLTR5V0DWIQqSkiy9SltZfs3eEM6MG2DVWpyJorEgfUHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcsbCQW6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711647911; x=1743183911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OiI+HabGYQA9Bx+Wt6goUKKVjRy0/sOX9BxjFGUxS9g=;
  b=JcsbCQW63AFEA15h5HoZP0cK0oiJkakEvpZCBZhLd90cwWrVhH4u2XYS
   7qofSy0xnl7pvqQiNzOUnDGDLEKd6UcvIQF1XhfXtLvGkxlSFMp3opLQ9
   VWy9V7x3RD38VHRFmMafYNxaQJLOjkD6IzhTXsm9FnfTJhUIABOgVXADW
   T63avfO+MAbIri/ZK927neJWLjNCLXvSEfABM3EBdZigVGiA8H5LIH9Di
   Fhl8IZ9Pd8SfoGyq7VxxFxTcbcMZ/gMB6rck59sPuU86SEVAc/s9sq8P3
   VosAGmgwFh/eNV3AMgH9eNk2nLpTO+U783hzvkxaCyqO72vNs729aTLi/
   Q==;
X-CSE-ConnectionGUID: GIv0eCI5RdS9WzVgjNd1Uw==
X-CSE-MsgGUID: 2mWrmFxmS7u9Ud8XM3kAnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10631360"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10631360"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16675654"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:45:00 -0700
From: Andre Glover <andre.glover@linux.intel.com>
To: tom.zanussi@linux.intel.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: dave.jiang@intel.com,
	fenghua.yu@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	vinodh.gopal@intel.com,
	tony.luck@intel.com,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	andre.glover@linux.intel.com
Subject: [PATCH 4/4] crypto: iaa - Add Software Compression stats to IAA Compression Accelerator stats
Date: Thu, 28 Mar 2024 10:44:45 -0700
Message-Id: <f5136e3a9f4745dc8ecdfc9f0cc8ebd793fbd602.1710969449.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710969449.git.andre.glover@linux.intel.com>
References: <cover.1710969449.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update optional debugfs statistics support for IAA with additional software
compression statistics. The software compression statistics will track
instances where iaa falls back to software deflate (e.g. when the source
data input length is greater than 4KB).

Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c  | 2 ++
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 8 ++++++++
 drivers/crypto/intel/iaa/iaa_crypto_stats.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 4d34096b80ca..ad88ad727d0a 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1152,6 +1152,8 @@ static int deflate_generic_compress(struct acomp_req *req)
 	kunmap_local(src);
 	kunmap_local(dst);
 
+	update_total_sw_comp_calls();
+
 	return ret;
 }
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index f5cc3d29ca19..42aae8a738ac 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -19,6 +19,7 @@
 
 static atomic64_t total_comp_calls;
 static atomic64_t total_decomp_calls;
+static atomic64_t total_sw_comp_calls;
 static atomic64_t total_sw_decomp_calls;
 static atomic64_t total_comp_bytes_out;
 static atomic64_t total_decomp_bytes_in;
@@ -43,6 +44,11 @@ void update_total_decomp_calls(void)
 	atomic64_inc(&total_decomp_calls);
 }
 
+void update_total_sw_comp_calls(void)
+{
+	atomic64_inc(&total_sw_comp_calls);
+}
+
 void update_total_sw_decomp_calls(void)
 {
 	atomic64_inc(&total_sw_decomp_calls);
@@ -174,6 +180,8 @@ static int global_stats_show(struct seq_file *m, void *v)
 		   atomic64_read(&total_comp_calls));
 	seq_printf(m, "  total_decomp_calls: %llu\n",
 		   atomic64_read(&total_decomp_calls));
+	seq_printf(m, "  total_sw_comp_calls: %llu\n",
+		   atomic64_read(&total_sw_comp_calls));
 	seq_printf(m, "  total_sw_decomp_calls: %llu\n",
 		   atomic64_read(&total_sw_decomp_calls));
 	seq_printf(m, "  total_comp_bytes_out: %llu\n",
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
index 3787a5f507eb..6e0c6f9939bf 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
@@ -11,6 +11,7 @@ void	iaa_crypto_debugfs_cleanup(void);
 void	update_total_comp_calls(void);
 void	update_total_comp_bytes_out(int n);
 void	update_total_decomp_calls(void);
+void	update_total_sw_comp_calls(void);
 void	update_total_sw_decomp_calls(void);
 void	update_total_decomp_bytes_in(int n);
 void	update_completion_einval_errs(void);
@@ -29,6 +30,7 @@ static inline void	iaa_crypto_debugfs_cleanup(void) {}
 static inline void	update_total_comp_calls(void) {}
 static inline void	update_total_comp_bytes_out(int n) {}
 static inline void	update_total_decomp_calls(void) {}
+static inline void	update_total_sw_comp_calls(void) {}
 static inline void	update_total_sw_decomp_calls(void) {}
 static inline void	update_total_decomp_bytes_in(int n) {}
 static inline void	update_completion_einval_errs(void) {}
-- 
2.27.0


