Return-Path: <dmaengine+bounces-1255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D044E870C53
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB7F288401
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E607BB12;
	Mon,  4 Mar 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZMxX+Km"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFE7B3E6;
	Mon,  4 Mar 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587222; cv=none; b=IdEDkoQZarv+zDUoDToj44B3HYPlO8foK7eVttaK8/5hLvN+s+F+MynsJFZXlIgY8wNPIHBtHIuvmbLUzBw8voq7KpmWG15GVd0uQdWYYr5QFIo74Nt5NuK/TPYjzCV/3rYQEWQkNn1IEpL0rJRcAx7zOeVUs98FWwdQQZToxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587222; c=relaxed/simple;
	bh=JssRPPLmPLeJKfOPjgxKKGEFvGgnvCIuSR7u+UyBWtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWhN+cpddJV+wNEnH3qvf2JLwJO60graiUsOE8nyED9TsTHYHf8BOM0nJWCK7Yc5Wykn1emah2L7cJrTn6quZNZ2n3hsnTAO/7NTuwv0EH4yinLgqDPuvh/IZFq9l/vjPg3Ly6YH6ByY+wZVXVQ2f0ogDChV7Jk5kQqiVbK7kV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZMxX+Km; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587220; x=1741123220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JssRPPLmPLeJKfOPjgxKKGEFvGgnvCIuSR7u+UyBWtQ=;
  b=JZMxX+KmO3X63CjpqAPdxJ+7kiqpRjm2yyBkLsDEt6E4hLYMTlnDPAN4
   jpq1Tn4N7PlsU0Nh2f0tS4nD8goQL3bC/BtDS8vuozP5zwUk7TZVa2z11
   yVZzvopoYdYdn9QVXheukUZ1+z15hnIQSVGksjX/6bSrVSJm2SMc4YN1Z
   00EVJUwCBrkNJuI2YnTKrZQMuWOyE1v+ASD9FnQm+UOqaayM1owK98vU+
   4A6ldOt88kxV8NaFO+BhS5wk4kHiZjG8/CNC+5Gd3ZqpZ78nAx+hCrCXS
   e/5Dd9RjJY6tg1YZsUUSFeqgiG0pzEMKEGrx0fonluS+vHvgnB28aT1df
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4271353"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4271353"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9040267"
Received: from skedaras-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.77.241])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:19 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 3/4] crypto: iaa - Add global_stats file and remove individual stat files
Date: Mon,  4 Mar 2024 15:20:10 -0600
Message-Id: <20240304212011.1525003-4-tom.zanussi@linux.intel.com>
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

Currently, the wq_stats output also includes the global stats, while
the individual global stats are also available as separate debugfs
files.  Since these are all read-only, there's really no reason to
have them as separate files, especially since we already display them
as global stats in the wq_stats.  It makes more sense to just add a
separate global_stats file to display those, and remove them from the
wq_stats, as well as removing the individual stats files.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      | 76 +++++++++++--------
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   | 30 ++++----
 2 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index de587cf9cbed..7b28aef39ba0 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -321,33 +321,30 @@ driver will generate statistics which can be accessed in debugfs at::
 
   # ls -al /sys/kernel/debug/iaa-crypto/
   total 0
-  drwxr-xr-x  2 root root 0 Mar  3 09:35 .
-  drwx------ 47 root root 0 Mar  3 09:35 ..
-  -rw-r--r--  1 root root 0 Mar  3 09:35 max_acomp_delay_ns
-  -rw-r--r--  1 root root 0 Mar  3 09:35 max_adecomp_delay_ns
-  -rw-r--r--  1 root root 0 Mar  3 09:35 max_comp_delay_ns
-  -rw-r--r--  1 root root 0 Mar  3 09:35 max_decomp_delay_ns
-  -rw-r--r--  1 root root 0 Mar  3 09:35 stats_reset
-  -rw-r--r--  1 root root 0 Mar  3 09:35 total_comp_bytes_out
-  -rw-r--r--  1 root root 0 Mar  3 09:35 total_comp_calls
-  -rw-r--r--  1 root root 0 Mar  3 09:35 total_decomp_bytes_in
-  -rw-r--r--  1 root root 0 Mar  3 09:35 total_decomp_calls
-  -rw-r--r--  1 root root 0 Mar  3 09:35 wq_stats
-
-Most of the above statisticss are self-explanatory.  The wq_stats file
-shows per-wq stats, a set for each iaa device and wq in addition to
-some global stats::
+  drwxr-xr-x  2 root root 0 Mar  3 07:55 .
+  drwx------ 53 root root 0 Mar  3 07:55 ..
+  -rw-r--r--  1 root root 0 Mar  3 07:55 global_stats
+  -rw-r--r--  1 root root 0 Mar  3 07:55 stats_reset
+  -rw-r--r--  1 root root 0 Mar  3 07:55 wq_stats
 
-  # cat wq_stats
+The global_stats file shows a set of global statistics collected since
+the driver has been loaded or reset::
+
+  # cat global_stats
   global stats:
-    total_comp_calls: 100
-    total_decomp_calls: 100
-    total_comp_bytes_out: 22800
-    total_decomp_bytes_in: 22800
+    total_comp_calls: 4300
+    total_decomp_calls: 4164
+    total_sw_decomp_calls: 0
+    total_comp_bytes_out: 5993989
+    total_decomp_bytes_in: 5993989
     total_completion_einval_errors: 0
     total_completion_timeout_errors: 0
-    total_completion_comp_buf_overflow_errors: 0
+    total_completion_comp_buf_overflow_errors: 136
+
+The wq_stats file shows per-wq stats, a set for each iaa device and wq
+in addition to some global stats::
 
+  # cat wq_stats
   iaa device:
     id: 1
     n_wqs: 1
@@ -379,21 +376,36 @@ some global stats::
   iaa device:
     id: 5
     n_wqs: 1
-    comp_calls: 100
-    comp_bytes: 22800
-    decomp_calls: 100
-    decomp_bytes: 22800
+    comp_calls: 1360
+    comp_bytes: 1999776
+    decomp_calls: 0
+    decomp_bytes: 0
     wqs:
       name: iaa_crypto
-      comp_calls: 100
-      comp_bytes: 22800
-      decomp_calls: 100
-      decomp_bytes: 22800
+      comp_calls: 1360
+      comp_bytes: 1999776
+      decomp_calls: 0
+      decomp_bytes: 0
+
+  iaa device:
+    id: 7
+    n_wqs: 1
+    comp_calls: 2940
+    comp_bytes: 3994213
+    decomp_calls: 4164
+    decomp_bytes: 5993989
+    wqs:
+      name: iaa_crypto
+      comp_calls: 2940
+      comp_bytes: 3994213
+      decomp_calls: 4164
+      decomp_bytes: 5993989
+    ...
 
-Writing 0 to 'stats_reset' resets all the stats, including the
+Writing to 'stats_reset' resets all the stats, including the
 per-device and per-wq stats::
 
-  # echo 0 > stats_reset
+  # echo 1 > stats_reset
   # cat wq_stats
     global stats:
     total_comp_calls: 0
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index 7820062a91e5..0f225bdf2279 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -159,7 +159,7 @@ static void device_stats_show(struct seq_file *m, struct iaa_device *iaa_device)
 		wq_show(m, iaa_wq);
 }
 
-static void global_stats_show(struct seq_file *m)
+static int global_stats_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "global stats:\n");
 	seq_printf(m, "  total_comp_calls: %llu\n", total_comp_calls);
@@ -173,6 +173,8 @@ static void global_stats_show(struct seq_file *m)
 		   total_completion_timeout_errors);
 	seq_printf(m, "  total_completion_comp_buf_overflow_errors: %llu\n\n",
 		   total_completion_comp_buf_overflow_errors);
+
+	return 0;
 }
 
 static int wq_stats_show(struct seq_file *m, void *v)
@@ -181,8 +183,6 @@ static int wq_stats_show(struct seq_file *m, void *v)
 
 	mutex_lock(&iaa_devices_lock);
 
-	global_stats_show(m);
-
 	list_for_each_entry(iaa_device, &iaa_devices, list)
 		device_stats_show(m, iaa_device);
 
@@ -219,6 +219,18 @@ static const struct file_operations wq_stats_fops = {
 	.release = single_release,
 };
 
+static int global_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, global_stats_show, file);
+}
+
+static const struct file_operations global_stats_fops = {
+	.open = global_stats_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 DEFINE_DEBUGFS_ATTRIBUTE(wq_stats_reset_fops, NULL, iaa_crypto_stats_reset, "%llu\n");
 
 int __init iaa_crypto_debugfs_init(void)
@@ -228,16 +240,8 @@ int __init iaa_crypto_debugfs_init(void)
 
 	iaa_crypto_debugfs_root = debugfs_create_dir("iaa_crypto", NULL);
 
-	debugfs_create_u64("total_comp_calls", 0644,
-			   iaa_crypto_debugfs_root, &total_comp_calls);
-	debugfs_create_u64("total_decomp_calls", 0644,
-			   iaa_crypto_debugfs_root, &total_decomp_calls);
-	debugfs_create_u64("total_sw_decomp_calls", 0644,
-			   iaa_crypto_debugfs_root, &total_sw_decomp_calls);
-	debugfs_create_u64("total_comp_bytes_out", 0644,
-			   iaa_crypto_debugfs_root, &total_comp_bytes_out);
-	debugfs_create_u64("total_decomp_bytes_in", 0644,
-			   iaa_crypto_debugfs_root, &total_decomp_bytes_in);
+	debugfs_create_file("global_stats", 0644, iaa_crypto_debugfs_root, NULL,
+			    &global_stats_fops);
 	debugfs_create_file("wq_stats", 0644, iaa_crypto_debugfs_root, NULL,
 			    &wq_stats_fops);
 	debugfs_create_file("stats_reset", 0644, iaa_crypto_debugfs_root, NULL,
-- 
2.34.1


