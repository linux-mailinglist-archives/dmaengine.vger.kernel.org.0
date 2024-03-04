Return-Path: <dmaengine+bounces-1256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD6870C57
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 22:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0291DB2407D
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED67C08E;
	Mon,  4 Mar 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv1ig345"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180B7BAF5;
	Mon,  4 Mar 2024 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587223; cv=none; b=hhUH3MfKbXjnuHbUidJkKBSAx3i4r2XvEwg1wTI/wPih0FD+E+vcAwv1PoyHBgo3pP3S0T/Vs50pAM8nzYbUkAtu1VZgb6Ske2A9r75vGwscOHs/n+JGYJ5ZIbGbieHYH3qGkQ3ozILp4SPQfxN+v8JYAQoInDzZ80DfuyjVW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587223; c=relaxed/simple;
	bh=Ykx1BfrSd1tjyZ02xfrWYUAEX8QKoOkzNcCwDPyIQZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XC+ctlQdoLCG48qh3V6eN3fVBNpXjKmUH3D6IeumivURinofsVMJWG+qh2ksuQqZJX3VXihe1PVEbLEiNZ1rwWom0JJcnSIZ5P3U0Zk7m5h/9Ng6IDvO+7WE6PXDUBZMg/3dk7YJT9pCWHTlQpraMlD9RARx+KJiEwKctEAWJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv1ig345; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587222; x=1741123222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ykx1BfrSd1tjyZ02xfrWYUAEX8QKoOkzNcCwDPyIQZg=;
  b=Xv1ig345hspxvdUKvbA7P9GcPygxw/bOkxD37brtHeEbZrMIRO87BAPw
   lx2nRKyEQ8Q6Sm54D7DyG4IYpkpriUQ/QgixPFHa0lYjWklT3Fktg7HmI
   3UfsTStv+j57lzLxCNZW6jWRLUpznUhsBqQ72MpQtSwC/kKkShp7Y/IPy
   kVqdPZuDggaygKz54vvP6ugFA9JJsiEQ0r3ATren5hJV9ypph2Y4qxekz
   ju67eUn8MdnDRyoGXt1vOL7saYD3z2f2FbfZeD5M46r5oxj8c8Zam0ec1
   QjAVu+pkBVldqzw9qqvs71ibug6eN4e9KhX5y/W3OGehRbpk4LKzX/ljt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4271358"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4271358"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9040278"
Received: from skedaras-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.77.241])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:21 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 4/4] crypto: iaa - Change iaa statistics to atomic64_t
Date: Mon,  4 Mar 2024 15:20:11 -0600
Message-Id: <20240304212011.1525003-5-tom.zanussi@linux.intel.com>
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

Change all the iaa statistics to use atomic64_t instead of the current
u64, to avoid potentially inconsistent counts.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h       |  16 +--
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 125 +++++++++++---------
 2 files changed, 77 insertions(+), 64 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 2524091a5f70..56985e395263 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -49,10 +49,10 @@ struct iaa_wq {
 
 	struct iaa_device	*iaa_device;
 
-	u64			comp_calls;
-	u64			comp_bytes;
-	u64			decomp_calls;
-	u64			decomp_bytes;
+	atomic64_t		comp_calls;
+	atomic64_t		comp_bytes;
+	atomic64_t		decomp_calls;
+	atomic64_t		decomp_bytes;
 };
 
 struct iaa_device_compression_mode {
@@ -73,10 +73,10 @@ struct iaa_device {
 	int				n_wq;
 	struct list_head		wqs;
 
-	u64				comp_calls;
-	u64				comp_bytes;
-	u64				decomp_calls;
-	u64				decomp_bytes;
+	atomic64_t			comp_calls;
+	atomic64_t			comp_bytes;
+	atomic64_t			decomp_calls;
+	atomic64_t			decomp_bytes;
 };
 
 struct wq_table_entry {
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index 0f225bdf2279..f5cc3d29ca19 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -17,117 +17,117 @@
 #include "iaa_crypto.h"
 #include "iaa_crypto_stats.h"
 
-static u64 total_comp_calls;
-static u64 total_decomp_calls;
-static u64 total_sw_decomp_calls;
-static u64 total_comp_bytes_out;
-static u64 total_decomp_bytes_in;
-static u64 total_completion_einval_errors;
-static u64 total_completion_timeout_errors;
-static u64 total_completion_comp_buf_overflow_errors;
+static atomic64_t total_comp_calls;
+static atomic64_t total_decomp_calls;
+static atomic64_t total_sw_decomp_calls;
+static atomic64_t total_comp_bytes_out;
+static atomic64_t total_decomp_bytes_in;
+static atomic64_t total_completion_einval_errors;
+static atomic64_t total_completion_timeout_errors;
+static atomic64_t total_completion_comp_buf_overflow_errors;
 
 static struct dentry *iaa_crypto_debugfs_root;
 
 void update_total_comp_calls(void)
 {
-	total_comp_calls++;
+	atomic64_inc(&total_comp_calls);
 }
 
 void update_total_comp_bytes_out(int n)
 {
-	total_comp_bytes_out += n;
+	atomic64_add(n, &total_comp_bytes_out);
 }
 
 void update_total_decomp_calls(void)
 {
-	total_decomp_calls++;
+	atomic64_inc(&total_decomp_calls);
 }
 
 void update_total_sw_decomp_calls(void)
 {
-	total_sw_decomp_calls++;
+	atomic64_inc(&total_sw_decomp_calls);
 }
 
 void update_total_decomp_bytes_in(int n)
 {
-	total_decomp_bytes_in += n;
+	atomic64_add(n, &total_decomp_bytes_in);
 }
 
 void update_completion_einval_errs(void)
 {
-	total_completion_einval_errors++;
+	atomic64_inc(&total_completion_einval_errors);
 }
 
 void update_completion_timeout_errs(void)
 {
-	total_completion_timeout_errors++;
+	atomic64_inc(&total_completion_timeout_errors);
 }
 
 void update_completion_comp_buf_overflow_errs(void)
 {
-	total_completion_comp_buf_overflow_errors++;
+	atomic64_inc(&total_completion_comp_buf_overflow_errors);
 }
 
 void update_wq_comp_calls(struct idxd_wq *idxd_wq)
 {
 	struct iaa_wq *wq = idxd_wq_get_private(idxd_wq);
 
-	wq->comp_calls++;
-	wq->iaa_device->comp_calls++;
+	atomic64_inc(&wq->comp_calls);
+	atomic64_inc(&wq->iaa_device->comp_calls);
 }
 
 void update_wq_comp_bytes(struct idxd_wq *idxd_wq, int n)
 {
 	struct iaa_wq *wq = idxd_wq_get_private(idxd_wq);
 
-	wq->comp_bytes += n;
-	wq->iaa_device->comp_bytes += n;
+	atomic64_add(n, &wq->comp_bytes);
+	atomic64_add(n, &wq->iaa_device->comp_bytes);
 }
 
 void update_wq_decomp_calls(struct idxd_wq *idxd_wq)
 {
 	struct iaa_wq *wq = idxd_wq_get_private(idxd_wq);
 
-	wq->decomp_calls++;
-	wq->iaa_device->decomp_calls++;
+	atomic64_inc(&wq->decomp_calls);
+	atomic64_inc(&wq->iaa_device->decomp_calls);
 }
 
 void update_wq_decomp_bytes(struct idxd_wq *idxd_wq, int n)
 {
 	struct iaa_wq *wq = idxd_wq_get_private(idxd_wq);
 
-	wq->decomp_bytes += n;
-	wq->iaa_device->decomp_bytes += n;
+	atomic64_add(n, &wq->decomp_bytes);
+	atomic64_add(n, &wq->iaa_device->decomp_bytes);
 }
 
 static void reset_iaa_crypto_stats(void)
 {
-	total_comp_calls = 0;
-	total_decomp_calls = 0;
-	total_sw_decomp_calls = 0;
-	total_comp_bytes_out = 0;
-	total_decomp_bytes_in = 0;
-	total_completion_einval_errors = 0;
-	total_completion_timeout_errors = 0;
-	total_completion_comp_buf_overflow_errors = 0;
+	atomic64_set(&total_comp_calls, 0);
+	atomic64_set(&total_decomp_calls, 0);
+	atomic64_set(&total_sw_decomp_calls, 0);
+	atomic64_set(&total_comp_bytes_out, 0);
+	atomic64_set(&total_decomp_bytes_in, 0);
+	atomic64_set(&total_completion_einval_errors, 0);
+	atomic64_set(&total_completion_timeout_errors, 0);
+	atomic64_set(&total_completion_comp_buf_overflow_errors, 0);
 }
 
 static void reset_wq_stats(struct iaa_wq *wq)
 {
-	wq->comp_calls = 0;
-	wq->comp_bytes = 0;
-	wq->decomp_calls = 0;
-	wq->decomp_bytes = 0;
+	atomic64_set(&wq->comp_calls, 0);
+	atomic64_set(&wq->comp_bytes, 0);
+	atomic64_set(&wq->decomp_calls, 0);
+	atomic64_set(&wq->decomp_bytes, 0);
 }
 
 static void reset_device_stats(struct iaa_device *iaa_device)
 {
 	struct iaa_wq *iaa_wq;
 
-	iaa_device->comp_calls = 0;
-	iaa_device->comp_bytes = 0;
-	iaa_device->decomp_calls = 0;
-	iaa_device->decomp_bytes = 0;
+	atomic64_set(&iaa_device->comp_calls, 0);
+	atomic64_set(&iaa_device->comp_bytes, 0);
+	atomic64_set(&iaa_device->decomp_calls, 0);
+	atomic64_set(&iaa_device->decomp_bytes, 0);
 
 	list_for_each_entry(iaa_wq, &iaa_device->wqs, list)
 		reset_wq_stats(iaa_wq);
@@ -136,10 +136,14 @@ static void reset_device_stats(struct iaa_device *iaa_device)
 static void wq_show(struct seq_file *m, struct iaa_wq *iaa_wq)
 {
 	seq_printf(m, "    name: %s\n", iaa_wq->wq->name);
-	seq_printf(m, "    comp_calls: %llu\n", iaa_wq->comp_calls);
-	seq_printf(m, "    comp_bytes: %llu\n", iaa_wq->comp_bytes);
-	seq_printf(m, "    decomp_calls: %llu\n", iaa_wq->decomp_calls);
-	seq_printf(m, "    decomp_bytes: %llu\n\n", iaa_wq->decomp_bytes);
+	seq_printf(m, "    comp_calls: %llu\n",
+		   atomic64_read(&iaa_wq->comp_calls));
+	seq_printf(m, "    comp_bytes: %llu\n",
+		   atomic64_read(&iaa_wq->comp_bytes));
+	seq_printf(m, "    decomp_calls: %llu\n",
+		   atomic64_read(&iaa_wq->decomp_calls));
+	seq_printf(m, "    decomp_bytes: %llu\n\n",
+		   atomic64_read(&iaa_wq->decomp_bytes));
 }
 
 static void device_stats_show(struct seq_file *m, struct iaa_device *iaa_device)
@@ -149,10 +153,14 @@ static void device_stats_show(struct seq_file *m, struct iaa_device *iaa_device)
 	seq_puts(m, "iaa device:\n");
 	seq_printf(m, "  id: %d\n", iaa_device->idxd->id);
 	seq_printf(m, "  n_wqs: %d\n", iaa_device->n_wq);
-	seq_printf(m, "  comp_calls: %llu\n", iaa_device->comp_calls);
-	seq_printf(m, "  comp_bytes: %llu\n", iaa_device->comp_bytes);
-	seq_printf(m, "  decomp_calls: %llu\n", iaa_device->decomp_calls);
-	seq_printf(m, "  decomp_bytes: %llu\n", iaa_device->decomp_bytes);
+	seq_printf(m, "  comp_calls: %llu\n",
+		   atomic64_read(&iaa_device->comp_calls));
+	seq_printf(m, "  comp_bytes: %llu\n",
+		   atomic64_read(&iaa_device->comp_bytes));
+	seq_printf(m, "  decomp_calls: %llu\n",
+		   atomic64_read(&iaa_device->decomp_calls));
+	seq_printf(m, "  decomp_bytes: %llu\n",
+		   atomic64_read(&iaa_device->decomp_bytes));
 	seq_puts(m, "  wqs:\n");
 
 	list_for_each_entry(iaa_wq, &iaa_device->wqs, list)
@@ -162,17 +170,22 @@ static void device_stats_show(struct seq_file *m, struct iaa_device *iaa_device)
 static int global_stats_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "global stats:\n");
-	seq_printf(m, "  total_comp_calls: %llu\n", total_comp_calls);
-	seq_printf(m, "  total_decomp_calls: %llu\n", total_decomp_calls);
-	seq_printf(m, "  total_sw_decomp_calls: %llu\n", total_sw_decomp_calls);
-	seq_printf(m, "  total_comp_bytes_out: %llu\n", total_comp_bytes_out);
-	seq_printf(m, "  total_decomp_bytes_in: %llu\n", total_decomp_bytes_in);
+	seq_printf(m, "  total_comp_calls: %llu\n",
+		   atomic64_read(&total_comp_calls));
+	seq_printf(m, "  total_decomp_calls: %llu\n",
+		   atomic64_read(&total_decomp_calls));
+	seq_printf(m, "  total_sw_decomp_calls: %llu\n",
+		   atomic64_read(&total_sw_decomp_calls));
+	seq_printf(m, "  total_comp_bytes_out: %llu\n",
+		   atomic64_read(&total_comp_bytes_out));
+	seq_printf(m, "  total_decomp_bytes_in: %llu\n",
+		   atomic64_read(&total_decomp_bytes_in));
 	seq_printf(m, "  total_completion_einval_errors: %llu\n",
-		   total_completion_einval_errors);
+		   atomic64_read(&total_completion_einval_errors));
 	seq_printf(m, "  total_completion_timeout_errors: %llu\n",
-		   total_completion_timeout_errors);
+		   atomic64_read(&total_completion_timeout_errors));
 	seq_printf(m, "  total_completion_comp_buf_overflow_errors: %llu\n\n",
-		   total_completion_comp_buf_overflow_errors);
+		   atomic64_read(&total_completion_comp_buf_overflow_errors));
 
 	return 0;
 }
-- 
2.34.1


