Return-Path: <dmaengine+bounces-5225-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A234ABE756
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029613A5FFA
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC819261580;
	Tue, 20 May 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DGgVcYaT"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859F1A704B;
	Tue, 20 May 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780763; cv=none; b=m4TDy65CL2Jp9YqJLCQt2yg6ReSHeJsoaLfAEND8P82Nic5GnWyciaGj/rlMgYX3AL+PO0HndtEzZzzK0PzqQdMUBZCfM3JBYy6yIse+YGmJq3gkuEnIsJmHcU947QD1sn18btCi6tH0zNrGkQmrIdergXTojqcpRQfpvBz5xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780763; c=relaxed/simple;
	bh=bjweMhzgo2TBjFMZvc1ZB3XnfTBp25kxXiVCvZjzvFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcEmii6IndxpEQN37Ro4NiDzsXofAvD/LhZx4TyBbQCiWuvNacX4i40JtcS0Hv8selOniDiDLMCZAVx4s0O4DaKN8DACxCrwsZg6sVYqhxJ1YgXEVzcpJKe84lOgq9MLGRBsxQDLTEgTaXfQ7vSgPqpJ3fZFFpdtXHfPRD6/wF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DGgVcYaT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SL4b1xDgxA+NkPmd/OR6nKSjVcBp8Xk4LTDY9e3464E=; b=DGgVcYaTikXHQ16WpLmURPmm9z
	vgPOtwZ21Ze49qIw0xllbcqAqxfCDq4bRIaefXDCPnUtSqynCaZ88nTzrbRmm9+B6DI0th6NGMoGW
	gnMVW0bNELeKAO5btU4aN8meYH/zOllPmenTy+kICatawcqVyJCGh6UsQBH2tD/EVBk5pP8x2BSoB
	nXrhuWdsOU7TXGrzNYygMJLwN56+dG6bvSfMn3nadhYi0Z8iIiLyYMVCEdcQXOrrZx1E59f2t4r/k
	HdyDKN1RVsTMdqnKWGdH/yhVN43nx1G6Ye4oFKA3/K8tMATXfFsXmwgwMoflHh2ZpdFGIyvoOX9vD
	271UFjTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVcA-0000000EIME-0yIc;
	Tue, 20 May 2025 22:39:14 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: vkoul@kernel.org,
	chenxiang66@hisilicon.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leon@kernel.org,
	jgg@nvidia.com,
	alex.williamson@redhat.com,
	joel.granados@kernel.org
Cc: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 3/6] dmatest: move printing to its own routine
Date: Tue, 20 May 2025 15:39:10 -0700
Message-ID: <20250520223913.3407136-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520223913.3407136-1-mcgrof@kernel.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Move statistics printing to its own routine, and while at it, put
the test counters into the struct dmatest_thread for the streaming DMA
API to allow us to later add IOVA DMA API support and be able to
differentiate.

While at it, use a mutex to serialize output so we don't get garbled
messages between different threads.

This makes no functional changes other than serializing the output
and prepping us for IOVA DMA API support.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/dma/dmatest.c | 77 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 921d89b4d2ed..b4c129e688e3 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -92,6 +92,8 @@ static bool polled;
 module_param(polled, bool, 0644);
 MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
 
+static DEFINE_MUTEX(stats_mutex);
+
 /**
  * struct dmatest_params - test parameters.
  * @nobounce:		prevent using swiotlb buffer
@@ -239,6 +241,12 @@ struct dmatest_thread {
 	bool			done;
 	bool			pending;
 	u8			*pq_coefs;
+
+	/* Streaming DMA statistics */
+	unsigned int streaming_tests;
+	unsigned int streaming_failures;
+	unsigned long long streaming_total_len;
+	ktime_t streaming_runtime;
 };
 
 struct dmatest_chan {
@@ -898,6 +906,30 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 	return ret;
 }
 
+static void dmatest_print_detailed_stats(struct dmatest_thread *thread)
+{
+	unsigned long long streaming_iops, streaming_kbs;
+	s64 streaming_runtime_us;
+
+	mutex_lock(&stats_mutex);
+
+	streaming_runtime_us = ktime_to_us(thread->streaming_runtime);
+	streaming_iops = dmatest_persec(streaming_runtime_us, thread->streaming_tests);
+	streaming_kbs = dmatest_KBs(streaming_runtime_us, thread->streaming_total_len);
+
+	pr_info("=== %s: DMA Test Results ===\n", current->comm);
+
+	/* Streaming DMA statistics */
+	pr_info("%s: STREAMINMG DMA: %u tests, %u failures\n",
+		current->comm, thread->streaming_tests, thread->streaming_failures);
+	pr_info("%s: STREAMING DMA: %llu.%02llu iops, %llu KB/s, %lld us total\n",
+		current->comm, FIXPT_TO_INT(streaming_iops), FIXPT_GET_FRAC(streaming_iops),
+		streaming_kbs, streaming_runtime_us);
+
+	pr_info("=== %s: End Results ===\n", current->comm);
+	mutex_unlock(&stats_mutex);
+}
+
 /*
  * This function repeatedly tests DMA transfers of various lengths and
  * offsets for a given operation type until it is told to exit by
@@ -921,20 +953,22 @@ static int dmatest_func(void *data)
 	unsigned int buf_size;
 	u8 align;
 	bool is_memset;
-	unsigned int failed_tests = 0;
-	unsigned int total_tests = 0;
-	ktime_t ktime, start;
+	unsigned int total_iterations = 0;
+	ktime_t start_time, streaming_start;
 	ktime_t filltime = 0;
 	ktime_t comparetime = 0;
-	s64 runtime = 0;
-	unsigned long long total_len = 0;
-	unsigned long long iops = 0;
 	int ret;
 
 	set_freezable();
 	smp_rmb();
 	thread->pending = false;
 
+	/* Initialize statistics */
+	thread->streaming_tests = 0;
+	thread->streaming_failures = 0;
+	thread->streaming_total_len = 0;
+	thread->streaming_runtime = 0;
+
 	/* Setup test parameters and allocate buffers */
 	ret = dmatest_setup_test(thread, &buf_size, &align, &is_memset);
 	if (ret)
@@ -942,34 +976,39 @@ static int dmatest_func(void *data)
 
 	set_user_nice(current, 10);
 
-	ktime = start = ktime_get();
+	start_time = ktime_get();
 	while (!(kthread_should_stop() ||
-		(params->iterations && total_tests >= params->iterations))) {
+		(params->iterations && total_iterations >= params->iterations))) {
 
+		/* Test streaming DMA path */
+		streaming_start = ktime_get();
 		ret = dmatest_do_dma_test(thread, buf_size, align, is_memset,
-					  &total_tests, &failed_tests, &total_len,
+					  &thread->streaming_tests, &thread->streaming_failures,
+					  &thread->streaming_total_len,
 					  &filltime, &comparetime);
+		thread->streaming_runtime = ktime_add(thread->streaming_runtime,
+						    ktime_sub(ktime_get(), streaming_start));
 		if (ret < 0)
 			break;
+
+		total_iterations++;
 	}
 
-	ktime = ktime_sub(ktime_get(), ktime);
-	ktime = ktime_sub(ktime, comparetime);
-	ktime = ktime_sub(ktime, filltime);
-	runtime = ktime_to_us(ktime);
+	/* Subtract fill and compare time from both paths */
+	thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
+					   ktime_divns(filltime, 2));
+	thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
+					   ktime_divns(comparetime, 2));
 
 	ret = 0;
 	dmatest_cleanup_test(thread);
 
 err_thread_type:
-	iops = dmatest_persec(runtime, total_tests);
-	pr_info("%s: summary %u tests, %u failures %llu.%02llu iops %llu KB/s (%d)\n",
-		current->comm, total_tests, failed_tests,
-		FIXPT_TO_INT(iops), FIXPT_GET_FRAC(iops),
-		dmatest_KBs(runtime, total_len), ret);
+	/* Print detailed statistics */
+	dmatest_print_detailed_stats(thread);
 
 	/* terminate all transfers on specified channels */
-	if (ret || failed_tests)
+	if (ret || (thread->streaming_failures))
 		dmaengine_terminate_sync(chan);
 
 	thread->done = true;
-- 
2.47.2


