Return-Path: <dmaengine+bounces-5227-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B63ABE761
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 00:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF98C4E08C1
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACC2620CD;
	Tue, 20 May 2025 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/Rq81z9"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861D25E81C;
	Tue, 20 May 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780764; cv=none; b=DRhTtJfszattZ7dc88U/ObwaBqVOrAkX5N4my7lEdYpPvxZcEaUsYFUCt+NeXHecSPi4jZhMtq4Or/9so9oarH3di5EfYRBiGynu0x6IhdIGHZfRY5/suR76d/Ob+niiK5NJXmGZIqiyuFIMZP5TNwID4f5zhgqXfLD7H52gTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780764; c=relaxed/simple;
	bh=H1fKq6KVU0acWXKFa8RwyKgXyjjOYp2ODK0LTTISDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo6rRcfsRcZvfpk5R4BdhMrLvxUyxI0jge9wZ9v3uVzy7D/6pPtIeFdj1yB7TOqg0tFQlzViXDHT8R1MVSyfzgRASe6x74MxY/gtPjAKnODtoBTSkKJhGkSwatfwu27UCExbgfAvRaE9bK7AspmSPA9oEZ9ccX0gPh7rqbme/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B/Rq81z9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QeKO5WpcdWd/rnQmvvan6zzkNh3NOFrxEjjxYAOl7BU=; b=B/Rq81z9Xzby7o+T2uPzXSmvIy
	mHdH8FS7ztOeujmoSZMOwnPrEgqE5ccN9QSTU4BafrcKOaH8rSdl8X9FMpmtHVgetuORaBExJ7TuR
	LffiCeUI85dBk3NnDSDkgwg2xZueDOd1duU6C6jh0HHoq5zwIPjclv/Ne0rKGPoluL1peYwq1tE7e
	3GSLLtwXnXoWuguzMZA5npaYWS7AHck+ImmJT5Y2wq+2zHL/OvOTP224NppJCrA0Gt2L9I7YcaquG
	UmGPiA2/3HIAhKgwB/Pi3TZrJ5RQcJgitCbpzisNRy7pxEfPXntU4j3IpPOlLy6fuaaZ33ZXKb2i7
	hLzUed3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVcA-0000000EIMC-0peT;
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
Subject: [PATCH 2/6] dmatest: split dmatest_func() into helpers
Date: Tue, 20 May 2025 15:39:09 -0700
Message-ID: <20250520223913.3407136-3-mcgrof@kernel.org>
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

Split the core logic of dmatest_func() into helpers so that the routine
dmatest_func() becomes thin, letting us later add alternative routines
which use a different preamble setup.

This introduces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/dma/dmatest.c | 607 ++++++++++++++++++++++--------------------
 1 file changed, 320 insertions(+), 287 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 91b2fbc0b864..921d89b4d2ed 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -238,6 +238,7 @@ struct dmatest_thread {
 	struct dmatest_done test_done;
 	bool			done;
 	bool			pending;
+	u8			*pq_coefs;
 };
 
 struct dmatest_chan {
@@ -557,377 +558,409 @@ static int dmatest_alloc_test_data(struct dmatest_data *d,
 	return -ENOMEM;
 }
 
-/*
- * This function repeatedly tests DMA transfers of various lengths and
- * offsets for a given operation type until it is told to exit by
- * kthread_stop(). There may be multiple threads running this function
- * in parallel for a single channel, and there may be multiple channels
- * being tested in parallel.
- *
- * Before each test, the source and destination buffer is initialized
- * with a known pattern. This pattern is different depending on
- * whether it's in an area which is supposed to be copied or
- * overwritten, and different in the source and destination buffers.
- * So if the DMA engine doesn't copy exactly what we tell it to copy,
- * we'll notice.
- */
-static int dmatest_func(void *data)
+static int dmatest_setup_test(struct dmatest_thread *thread,
+			      unsigned int *buf_size,
+			      u8 *align,
+			      bool *is_memset)
 {
-	struct dmatest_thread	*thread = data;
-	struct dmatest_done	*done = &thread->test_done;
-	struct dmatest_info	*info;
-	struct dmatest_params	*params;
-	struct dma_chan		*chan;
-	struct dma_device	*dev;
-	struct device		*dma_dev;
-	unsigned int		error_count;
-	unsigned int		failed_tests = 0;
-	unsigned int		total_tests = 0;
-	dma_cookie_t		cookie;
-	enum dma_status		status;
-	enum dma_ctrl_flags	flags;
-	u8			*pq_coefs = NULL;
-	int			ret;
-	unsigned int		buf_size;
-	struct dmatest_data	*src;
-	struct dmatest_data	*dst;
-	int			i;
-	ktime_t			ktime, start, diff;
-	ktime_t			filltime = 0;
-	ktime_t			comparetime = 0;
-	s64			runtime = 0;
-	unsigned long long	total_len = 0;
-	unsigned long long	iops = 0;
-	u8			align = 0;
-	bool			is_memset = false;
-	dma_addr_t		*srcs;
-	dma_addr_t		*dma_pq;
-
-	set_freezable();
-
-	ret = -ENOMEM;
+	struct dmatest_info *info = thread->info;
+	struct dmatest_params *params = &info->params;
+	struct dma_chan *chan = thread->chan;
+	struct dma_device *dev = chan->device;
+	struct dmatest_data *src = &thread->src;
+	struct dmatest_data *dst = &thread->dst;
+	int ret;
 
-	smp_rmb();
-	thread->pending = false;
-	info = thread->info;
-	params = &info->params;
-	chan = thread->chan;
-	dev = chan->device;
-	dma_dev = dmaengine_get_dma_device(chan);
-
-	src = &thread->src;
-	dst = &thread->dst;
 	if (thread->type == DMA_MEMCPY) {
-		align = params->alignment < 0 ? dev->copy_align :
-						params->alignment;
+		*align = params->alignment < 0 ? dev->copy_align : params->alignment;
 		src->cnt = dst->cnt = 1;
+		*is_memset = false;
 	} else if (thread->type == DMA_MEMSET) {
-		align = params->alignment < 0 ? dev->fill_align :
-						params->alignment;
+		*align = params->alignment < 0 ? dev->fill_align : params->alignment;
 		src->cnt = dst->cnt = 1;
-		is_memset = true;
+		*is_memset = true;
 	} else if (thread->type == DMA_XOR) {
-		/* force odd to ensure dst = src */
 		src->cnt = min_odd(params->xor_sources | 1, dev->max_xor);
 		dst->cnt = 1;
-		align = params->alignment < 0 ? dev->xor_align :
-						params->alignment;
+		*align = params->alignment < 0 ? dev->xor_align : params->alignment;
+		*is_memset = false;
 	} else if (thread->type == DMA_PQ) {
-		/* force odd to ensure dst = src */
 		src->cnt = min_odd(params->pq_sources | 1, dma_maxpq(dev, 0));
 		dst->cnt = 2;
-		align = params->alignment < 0 ? dev->pq_align :
-						params->alignment;
+		*align = params->alignment < 0 ? dev->pq_align : params->alignment;
+		*is_memset = false;
 
-		pq_coefs = kmalloc(params->pq_sources + 1, GFP_KERNEL);
-		if (!pq_coefs)
-			goto err_thread_type;
+		thread->pq_coefs = kmalloc(params->pq_sources + 1, GFP_KERNEL);
+		if (!thread->pq_coefs)
+			return -ENOMEM;
 
-		for (i = 0; i < src->cnt; i++)
-			pq_coefs[i] = 1;
+		for (int i = 0; i < src->cnt; i++)
+			thread->pq_coefs[i] = 1;
 	} else
-		goto err_thread_type;
+		return -EINVAL;
 
-	/* Check if buffer count fits into map count variable (u8) */
+	/* Buffer count check */
 	if ((src->cnt + dst->cnt) >= 255) {
 		pr_err("too many buffers (%d of 255 supported)\n",
-		       src->cnt + dst->cnt);
+		src->cnt + dst->cnt);
+		ret = -EINVAL;
 		goto err_free_coefs;
 	}
 
-	buf_size = params->buf_size;
-	if (1 << align > buf_size) {
+	*buf_size = params->buf_size;
+
+	if (1 << *align > *buf_size) {
 		pr_err("%u-byte buffer too small for %d-byte alignment\n",
-		       buf_size, 1 << align);
+		       *buf_size, 1 << *align);
+		ret = -EINVAL;
 		goto err_free_coefs;
 	}
 
+	/* Set GFP flags */
 	src->gfp_flags = GFP_KERNEL;
 	dst->gfp_flags = GFP_KERNEL;
+
 	if (params->nobounce) {
 		src->gfp_flags = GFP_DMA;
 		dst->gfp_flags = GFP_DMA;
 	}
 
-	if (dmatest_alloc_test_data(src, buf_size, align) < 0)
+	/* Allocate test data */
+	if (dmatest_alloc_test_data(src, *buf_size, *align) < 0) {
+		ret = -ENOMEM;
 		goto err_free_coefs;
+	}
 
-	if (dmatest_alloc_test_data(dst, buf_size, align) < 0)
+	if (dmatest_alloc_test_data(dst, *buf_size, *align) < 0) {
+		ret = -ENOMEM;
 		goto err_src;
+	}
 
-	set_user_nice(current, 10);
+	return 0;
 
-	srcs = kcalloc(src->cnt, sizeof(dma_addr_t), GFP_KERNEL);
-	if (!srcs)
-		goto err_dst;
+err_src:
+	dmatest_free_test_data(src);
+err_free_coefs:
+	kfree(thread->pq_coefs);
+	return ret;
+}
 
-	dma_pq = kcalloc(dst->cnt, sizeof(dma_addr_t), GFP_KERNEL);
-	if (!dma_pq)
-		goto err_srcs_array;
+static void dmatest_cleanup_test(struct dmatest_thread *thread)
+{
+	dmatest_free_test_data(&thread->src);
+	dmatest_free_test_data(&thread->dst);
+	kfree(thread->pq_coefs);
+	thread->pq_coefs = NULL;
+}
 
-	/*
-	 * src and dst buffers are freed by ourselves below
-	 */
-	if (params->polled)
-		flags = DMA_CTRL_ACK;
-	else
-		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+static int dmatest_do_dma_test(struct dmatest_thread *thread,
+			       unsigned int buf_size, u8 align, bool is_memset,
+			       unsigned int *total_tests,
+			       unsigned int *failed_tests,
+			       unsigned long long *total_len,
+			       ktime_t *filltime,
+			       ktime_t *comparetime)
+{
+	struct dmatest_info *info = thread->info;
+	struct dmatest_params *params = &info->params;
+	struct dma_chan *chan = thread->chan;
+	struct dma_device *dev = chan->device;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
+	struct dmatest_data *src = &thread->src;
+	struct dmatest_data *dst = &thread->dst;
+	struct dmatest_done *done = &thread->test_done;
+	dma_addr_t *srcs;
+	dma_addr_t *dma_pq;
+	struct dma_async_tx_descriptor *tx = NULL;
+	struct dmaengine_unmap_data *um;
+	dma_addr_t *dsts;
+	unsigned int len;
+	unsigned int error_count;
+	enum dma_ctrl_flags flags;
+	dma_cookie_t cookie;
+	enum dma_status status;
+	ktime_t start, diff;
+	int ret;
 
-	ktime = ktime_get();
-	while (!(kthread_should_stop() ||
-	       (params->iterations && total_tests >= params->iterations))) {
-		struct dma_async_tx_descriptor *tx = NULL;
-		struct dmaengine_unmap_data *um;
-		dma_addr_t *dsts;
-		unsigned int len;
-
-		total_tests++;
-
-		if (params->transfer_size) {
-			if (params->transfer_size >= buf_size) {
-				pr_err("%u-byte transfer size must be lower than %u-buffer size\n",
-				       params->transfer_size, buf_size);
-				break;
-			}
-			len = params->transfer_size;
-		} else if (params->norandom) {
-			len = buf_size;
-		} else {
-			len = dmatest_random() % buf_size + 1;
-		}
+	(*total_tests)++;
 
-		/* Do not alter transfer size explicitly defined by user */
-		if (!params->transfer_size) {
-			len = (len >> align) << align;
-			if (!len)
-				len = 1 << align;
+	/* Calculate transfer length */
+	if (params->transfer_size) {
+		if (params->transfer_size >= buf_size) {
+			pr_err("%u-byte transfer size must be lower than %u-buffer size\n",
+			       params->transfer_size, buf_size);
+			return -EINVAL;
 		}
-		total_len += len;
+		len = params->transfer_size;
+	} else if (params->norandom)
+		len = buf_size;
+	else
+		len = dmatest_random() % buf_size + 1;
 
-		if (params->norandom) {
-			src->off = 0;
-			dst->off = 0;
-		} else {
-			src->off = dmatest_random() % (buf_size - len + 1);
-			dst->off = dmatest_random() % (buf_size - len + 1);
+	/* Align length */
+	if (!params->transfer_size) {
+		len = (len >> align) << align;
+		if (!len)
+			len = 1 << align;
+	}
 
-			src->off = (src->off >> align) << align;
-			dst->off = (dst->off >> align) << align;
-		}
+	*total_len += len;
 
-		if (!params->noverify) {
-			start = ktime_get();
-			dmatest_init_srcs(src->aligned, src->off, len,
-					  buf_size, is_memset);
-			dmatest_init_dsts(dst->aligned, dst->off, len,
-					  buf_size, is_memset);
+	/* Calculate offsets */
+	if (params->norandom) {
+		src->off = 0;
+		dst->off = 0;
+	} else {
+		src->off = dmatest_random() % (buf_size - len + 1);
+		dst->off = dmatest_random() % (buf_size - len + 1);
+		src->off = (src->off >> align) << align;
+		dst->off = (dst->off >> align) << align;
+	}
 
-			diff = ktime_sub(ktime_get(), start);
-			filltime = ktime_add(filltime, diff);
-		}
+	/* Initialize buffers */
+	if (!params->noverify) {
+		start = ktime_get();
+		dmatest_init_srcs(src->aligned, src->off, len, buf_size, is_memset);
+		dmatest_init_dsts(dst->aligned, dst->off, len, buf_size, is_memset);
+		diff = ktime_sub(ktime_get(), start);
+		*filltime = ktime_add(*filltime, diff);
+	}
 
-		um = dmaengine_get_unmap_data(dma_dev, src->cnt + dst->cnt,
-					      GFP_KERNEL);
-		if (!um) {
-			failed_tests++;
-			result("unmap data NULL", total_tests,
-			       src->off, dst->off, len, ret);
-			continue;
-		}
+	/* Map buffers */
+	um = dmaengine_get_unmap_data(dma_dev, src->cnt + dst->cnt, GFP_KERNEL);
+	if (!um) {
+		(*failed_tests)++;
+		result("unmap data NULL", *total_tests, src->off, dst->off, len, ret);
+		return -ENOMEM;
+	}
 
-		um->len = buf_size;
-		for (i = 0; i < src->cnt; i++) {
-			void *buf = src->aligned[i];
-			struct page *pg = virt_to_page(buf);
-			unsigned long pg_off = offset_in_page(buf);
+	um->len = buf_size;
+	srcs = kcalloc(src->cnt, sizeof(dma_addr_t), GFP_KERNEL);
+	if (!srcs) {
+		dmaengine_unmap_put(um);
+		return -ENOMEM;
+	}
 
-			um->addr[i] = dma_map_page(dma_dev, pg, pg_off,
-						   um->len, DMA_TO_DEVICE);
-			srcs[i] = um->addr[i] + src->off;
-			ret = dma_mapping_error(dma_dev, um->addr[i]);
-			if (ret) {
-				result("src mapping error", total_tests,
-				       src->off, dst->off, len, ret);
-				goto error_unmap_continue;
-			}
-			um->to_cnt++;
-		}
-		/* map with DMA_BIDIRECTIONAL to force writeback/invalidate */
-		dsts = &um->addr[src->cnt];
-		for (i = 0; i < dst->cnt; i++) {
-			void *buf = dst->aligned[i];
-			struct page *pg = virt_to_page(buf);
-			unsigned long pg_off = offset_in_page(buf);
-
-			dsts[i] = dma_map_page(dma_dev, pg, pg_off, um->len,
-					       DMA_BIDIRECTIONAL);
-			ret = dma_mapping_error(dma_dev, dsts[i]);
-			if (ret) {
-				result("dst mapping error", total_tests,
-				       src->off, dst->off, len, ret);
-				goto error_unmap_continue;
-			}
-			um->bidi_cnt++;
+	/* Map source buffers */
+	for (int i = 0; i < src->cnt; i++) {
+		void *buf = src->aligned[i];
+		struct page *pg = virt_to_page(buf);
+		unsigned long pg_off = offset_in_page(buf);
+
+		um->addr[i] = dma_map_page(dma_dev, pg, pg_off, um->len, DMA_TO_DEVICE);
+		srcs[i] = um->addr[i] + src->off;
+		ret = dma_mapping_error(dma_dev, um->addr[i]);
+		if (ret) {
+			result("src mapping error", *total_tests, src->off, dst->off, len, ret);
+			goto error_unmap;
 		}
+		um->to_cnt++;
+	}
 
-		if (thread->type == DMA_MEMCPY)
-			tx = dev->device_prep_dma_memcpy(chan,
-							 dsts[0] + dst->off,
-							 srcs[0], len, flags);
-		else if (thread->type == DMA_MEMSET)
-			tx = dev->device_prep_dma_memset(chan,
-						dsts[0] + dst->off,
-						*(src->aligned[0] + src->off),
-						len, flags);
-		else if (thread->type == DMA_XOR)
-			tx = dev->device_prep_dma_xor(chan,
-						      dsts[0] + dst->off,
-						      srcs, src->cnt,
-						      len, flags);
-		else if (thread->type == DMA_PQ) {
-			for (i = 0; i < dst->cnt; i++)
-				dma_pq[i] = dsts[i] + dst->off;
-			tx = dev->device_prep_dma_pq(chan, dma_pq, srcs,
-						     src->cnt, pq_coefs,
-						     len, flags);
+	/* Map destination buffers */
+	dsts = &um->addr[src->cnt];
+	for (int i = 0; i < dst->cnt; i++) {
+		void *buf = dst->aligned[i];
+		struct page *pg = virt_to_page(buf);
+		unsigned long pg_off = offset_in_page(buf);
+
+		dsts[i] = dma_map_page(dma_dev, pg, pg_off, um->len, DMA_BIDIRECTIONAL);
+		ret = dma_mapping_error(dma_dev, dsts[i]);
+		if (ret) {
+			result("dst mapping error", *total_tests, src->off, dst->off, len, ret);
+			goto error_unmap;
 		}
+		um->bidi_cnt++;
+	}
 
-		if (!tx) {
-			result("prep error", total_tests, src->off,
-			       dst->off, len, ret);
-			msleep(100);
-			goto error_unmap_continue;
-		}
+	/* Prepare DMA transaction */
+	if (params->polled)
+		flags = DMA_CTRL_ACK;
+	else
+		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 
-		done->done = false;
-		if (!params->polled) {
-			tx->callback = dmatest_callback;
-			tx->callback_param = done;
+	if (thread->type == DMA_MEMCPY) {
+		tx = dev->device_prep_dma_memcpy(chan, dsts[0] + dst->off,
+						srcs[0], len, flags);
+	} else if (thread->type == DMA_MEMSET) {
+		tx = dev->device_prep_dma_memset(chan, dsts[0] + dst->off,
+						*(src->aligned[0] + src->off), len, flags);
+	} else if (thread->type == DMA_XOR) {
+		tx = dev->device_prep_dma_xor(chan, dsts[0] + dst->off, srcs,
+					     src->cnt, len, flags);
+	} else if (thread->type == DMA_PQ) {
+		dma_pq = kcalloc(dst->cnt, sizeof(dma_addr_t), GFP_KERNEL);
+		if (!dma_pq) {
+			ret = -ENOMEM;
+			goto error_unmap;
 		}
-		cookie = tx->tx_submit(tx);
+		for (int i = 0; i < dst->cnt; i++)
+			dma_pq[i] = dsts[i] + dst->off;
+		tx = dev->device_prep_dma_pq(chan, dma_pq, srcs,
+					    src->cnt, thread->pq_coefs,
+					    len, flags);
+		kfree(dma_pq);
+	}
 
-		if (dma_submit_error(cookie)) {
-			result("submit error", total_tests, src->off,
-			       dst->off, len, ret);
-			msleep(100);
-			goto error_unmap_continue;
-		}
+	if (!tx) {
+		result("prep error", *total_tests, src->off, dst->off, len, ret);
+		ret = -EIO;
+		goto error_unmap;
+	}
 
-		if (params->polled) {
-			status = dma_sync_wait(chan, cookie);
-			dmaengine_terminate_sync(chan);
-			if (status == DMA_COMPLETE)
-				done->done = true;
-		} else {
-			dma_async_issue_pending(chan);
+	/* Submit transaction */
+	done->done = false;
+	if (!params->polled) {
+		tx->callback = dmatest_callback;
+		tx->callback_param = done;
+	}
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+	cookie = tx->tx_submit(tx);
 
-			status = dma_async_is_tx_complete(chan, cookie, NULL,
-							  NULL);
-		}
+	if (dma_submit_error(cookie)) {
+		result("submit error", *total_tests, src->off, dst->off, len, ret);
+		ret = -EIO;
+		goto error_unmap;
+	}
 
-		if (!done->done) {
-			result("test timed out", total_tests, src->off, dst->off,
-			       len, 0);
-			goto error_unmap_continue;
-		} else if (status != DMA_COMPLETE &&
-			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
-					 dev->cap_mask) &&
-			     status == DMA_OUT_OF_ORDER)) {
-			result(status == DMA_ERROR ?
-			       "completion error status" :
-			       "completion busy status", total_tests, src->off,
-			       dst->off, len, ret);
-			goto error_unmap_continue;
-		}
+	/* Wait for completion */
+	if (params->polled) {
+		status = dma_sync_wait(chan, cookie);
+		dmaengine_terminate_sync(chan);
+		if (status == DMA_COMPLETE)
+			done->done = true;
+	} else {
+		dma_async_issue_pending(chan);
+		wait_event_freezable_timeout(thread->done_wait, done->done,
+				   msecs_to_jiffies(params->timeout));
+		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	}
 
-		dmaengine_unmap_put(um);
+	if (!done->done) {
+		result("test timed out", *total_tests, src->off, dst->off, len, 0);
+		ret = -ETIMEDOUT;
+		goto error_unmap;
+	} else if (status != DMA_COMPLETE &&
+		   !(dma_has_cap(DMA_COMPLETION_NO_ORDER, dev->cap_mask) &&
+		     status == DMA_OUT_OF_ORDER)) {
+		result(status == DMA_ERROR ? "completion error status" :
+		       "completion busy status",
+		       *total_tests, src->off, dst->off, len, ret);
+		ret = -EIO;
+		goto error_unmap;
+	}
 
-		if (params->noverify) {
-			verbose_result("test passed", total_tests, src->off,
-				       dst->off, len, 0);
-			continue;
-		}
+	dmaengine_unmap_put(um);
+	kfree(srcs);
 
+	/* Verify results */
+	if (!params->noverify) {
 		start = ktime_get();
-		pr_debug("%s: verifying source buffer...\n", current->comm);
-		error_count = dmatest_verify(src->aligned, 0, src->off,
-				0, PATTERN_SRC, true, is_memset);
+		error_count = dmatest_verify(src->aligned, 0, src->off, 0,
+					    PATTERN_SRC, true, is_memset);
 		error_count += dmatest_verify(src->aligned, src->off,
-				src->off + len, src->off,
-				PATTERN_SRC | PATTERN_COPY, true, is_memset);
+					     src->off + len, src->off,
+					     PATTERN_SRC | PATTERN_COPY, true, is_memset);
 		error_count += dmatest_verify(src->aligned, src->off + len,
-				buf_size, src->off + len,
-				PATTERN_SRC, true, is_memset);
-
-		pr_debug("%s: verifying dest buffer...\n", current->comm);
-		error_count += dmatest_verify(dst->aligned, 0, dst->off,
-				0, PATTERN_DST, false, is_memset);
-
+					     buf_size, src->off + len, PATTERN_SRC, true, is_memset);
+		error_count += dmatest_verify(dst->aligned, 0, dst->off, 0,
+					     PATTERN_DST, false, is_memset);
 		error_count += dmatest_verify(dst->aligned, dst->off,
-				dst->off + len, src->off,
-				PATTERN_SRC | PATTERN_COPY, false, is_memset);
-
+					     dst->off + len, src->off,
+					     PATTERN_SRC | PATTERN_COPY, false, is_memset);
 		error_count += dmatest_verify(dst->aligned, dst->off + len,
-				buf_size, dst->off + len,
-				PATTERN_DST, false, is_memset);
+					     buf_size, dst->off + len, PATTERN_DST, false, is_memset);
 
 		diff = ktime_sub(ktime_get(), start);
-		comparetime = ktime_add(comparetime, diff);
+		*comparetime = ktime_add(*comparetime, diff);
 
 		if (error_count) {
-			result("data error", total_tests, src->off, dst->off,
-			       len, error_count);
-			failed_tests++;
+			result("data error", *total_tests, src->off,
+			       dst->off, len, error_count);
+			(*failed_tests)++;
+			ret = -EIO;
 		} else {
-			verbose_result("test passed", total_tests, src->off,
+			verbose_result("test passed", *total_tests, src->off,
 				       dst->off, len, 0);
+			ret = 0;
 		}
+	} else {
+		verbose_result("test passed", *total_tests, src->off, dst->off, len, 0);
+		ret = 0;
+	}
 
-		continue;
+	return ret;
 
-error_unmap_continue:
-		dmaengine_unmap_put(um);
-		failed_tests++;
+error_unmap:
+	dmaengine_unmap_put(um);
+	kfree(srcs);
+	(*failed_tests)++;
+	return ret;
+}
+
+/*
+ * This function repeatedly tests DMA transfers of various lengths and
+ * offsets for a given operation type until it is told to exit by
+ * kthread_stop(). There may be multiple threads running this function
+ * in parallel for a single channel, and there may be multiple channels
+ * being tested in parallel.
+ *
+ * Before each test, the source and destination buffer is initialized
+ * with a known pattern. This pattern is different depending on
+ * whether it's in an area which is supposed to be copied or
+ * overwritten, and different in the source and destination buffers.
+ * So if the DMA engine doesn't copy exactly what we tell it to copy,
+ * we'll notice.
+ */
+static int dmatest_func(void *data)
+{
+	struct dmatest_thread *thread = data;
+	struct dmatest_info *info = thread->info;
+	struct dmatest_params *params = &info->params;
+	struct dma_chan *chan = thread->chan;
+	unsigned int buf_size;
+	u8 align;
+	bool is_memset;
+	unsigned int failed_tests = 0;
+	unsigned int total_tests = 0;
+	ktime_t ktime, start;
+	ktime_t filltime = 0;
+	ktime_t comparetime = 0;
+	s64 runtime = 0;
+	unsigned long long total_len = 0;
+	unsigned long long iops = 0;
+	int ret;
+
+	set_freezable();
+	smp_rmb();
+	thread->pending = false;
+
+	/* Setup test parameters and allocate buffers */
+	ret = dmatest_setup_test(thread, &buf_size, &align, &is_memset);
+	if (ret)
+		goto err_thread_type;
+
+	set_user_nice(current, 10);
+
+	ktime = start = ktime_get();
+	while (!(kthread_should_stop() ||
+		(params->iterations && total_tests >= params->iterations))) {
+
+		ret = dmatest_do_dma_test(thread, buf_size, align, is_memset,
+					  &total_tests, &failed_tests, &total_len,
+					  &filltime, &comparetime);
+		if (ret < 0)
+			break;
 	}
+
 	ktime = ktime_sub(ktime_get(), ktime);
 	ktime = ktime_sub(ktime, comparetime);
 	ktime = ktime_sub(ktime, filltime);
 	runtime = ktime_to_us(ktime);
 
 	ret = 0;
-	kfree(dma_pq);
-err_srcs_array:
-	kfree(srcs);
-err_dst:
-	dmatest_free_test_data(dst);
-err_src:
-	dmatest_free_test_data(src);
-err_free_coefs:
-	kfree(pq_coefs);
+	dmatest_cleanup_test(thread);
+
 err_thread_type:
 	iops = dmatest_persec(runtime, total_tests);
 	pr_info("%s: summary %u tests, %u failures %llu.%02llu iops %llu KB/s (%d)\n",
-- 
2.47.2


