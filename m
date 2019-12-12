Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 082A411D55C
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 19:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfLLSYx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Dec 2019 13:24:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:59647 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfLLSYx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Dec 2019 13:24:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="245829459"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2019 10:24:51 -0800
Subject: [PATCH RFC v2 07/14] dmaengine: update dmatest to support dma
 request
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Thu, 12 Dec 2019 11:24:51 -0700
Message-ID: <157617509183.42350.16448608428757625955.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157617487798.42350.4471714981643413895.stgit@djiang5-desk3.ch.intel.com>
References: <157617487798.42350.4471714981643413895.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Introduce dmatest to the new dma request API so the testing of the new
drivers that utilizies the new functionalities can be performed. The
existing DMA setup function has been split to its own function.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmatest.c |  366 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 241 insertions(+), 125 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a2cadfa2e6d7..a544f05b0fd7 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -535,6 +535,240 @@ static int dmatest_alloc_test_data(struct dmatest_data *d,
 	return -ENOMEM;
 }
 
+static int dma_test_req_op(struct dmatest_thread *thread,
+			   struct dmatest_data *src, struct dmatest_data *dst,
+			   int total_tests, unsigned int len)
+{
+	struct dmatest_info *info = thread->info;
+	struct dmatest_params *params = &info->params;
+	struct dma_chan *chan = thread->chan;
+	struct dma_device *dma_dev = chan->device;
+	struct device *dev = dma_dev->dev;
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	int ret = -ENOMEM;
+	struct dma_request *rq;
+	struct scatterlist *sg;
+	void *vdst = dst->aligned[0] + dst->off;
+	int req_retry = 100;
+
+	do {
+		rq = dma_chan_alloc_request(chan);
+		if (!rq)
+			msleep(20);
+	} while (!rq && req_retry--);
+
+	if (!rq) {
+		result("get request", total_tests, src->off, dst->off,
+		       len, ret);
+		return -ENXIO;
+	}
+
+	if (thread->type == DMA_MEMCPY) {
+		rq->cmd = DMA_MEMCPY;
+	} else {
+		dma_chan_free_request(chan, rq);
+		result("wrong thread type", total_tests, src->off, dst->off,
+		       len, ret);
+		return -ENXIO;
+	}
+
+	rq->chan = chan;
+	rq->flags = flags;
+	rq->bvec.bv_page = virt_to_page(vdst);
+	rq->bvec.bv_offset = offset_in_page(vdst);
+	rq->pg_dma = dma_map_page(dev, rq->bvec.bv_page, rq->bvec.bv_offset,
+				  len, DMA_FROM_DEVICE);
+	if (rq->pg_dma == DMA_MAPPING_ERROR) {
+		dma_chan_free_request(chan, rq);
+		result("DMA map dest", total_tests, src->off, dst->off,
+		       len, ret);
+		msleep(100);
+		return -ENXIO;
+	}
+
+	rq->bvec.bv_len = len;
+	sg = &rq->sg[0];
+	sg_init_one(sg, src->aligned[0] + src->off, len);
+	rq->sg_nents = 1;
+
+	ret = dma_map_sg(dev, sg, 1, DMA_TO_DEVICE);
+	if (ret == 0) {
+		dma_unmap_page(dev, rq->pg_dma, len, DMA_FROM_DEVICE);
+		dma_chan_free_request(chan, rq);
+		result("DMA map src", total_tests, src->off, dst->off,
+		       len, ret);
+		return -ENXIO;
+	}
+
+	ret = dmaengine_submit_request_and_wait(chan, rq,
+						msecs_to_jiffies(params->timeout));
+	if (ret < 0) {
+		dma_chan_free_request(chan, rq);
+		dma_unmap_page(dev, rq->pg_dma, len, DMA_FROM_DEVICE);
+		dma_unmap_sg(dev, sg, 1, DMA_TO_DEVICE);
+		result("submit error", total_tests, src->off, dst->off,
+		       len, ret);
+		return -ENXIO;
+	}
+
+	if (ret == 0) {
+		result("test timed out", total_tests, src->off,
+		       dst->off, len, 0);
+		ret = -ETIMEDOUT;
+		goto out_unmap;
+	} else if (rq->result.result != DMA_TRANS_NOERROR) {
+		result("completion error", total_tests, src->off,
+		       dst->off, len, ret);
+		ret = -ENXIO;
+		goto out_unmap;
+	}
+
+ out_unmap:
+	dma_unmap_page(dev, rq->pg_dma, len, DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, sg, 1, DMA_TO_DEVICE);
+	dma_chan_free_request(chan, rq);
+
+	return ret;
+}
+
+static int dma_test_op(struct dmatest_thread *thread,
+		       struct dmatest_data *src, struct dmatest_data *dst,
+		       dma_addr_t *srcs, dma_addr_t *dma_pq,
+		       int total_tests, unsigned int len, u8 *pq_coefs)
+{
+	struct dma_async_tx_descriptor *tx = NULL;
+	struct dmaengine_unmap_data *um;
+	struct dmatest_info *info = thread->info;
+	struct dmatest_params *params = &info->params;
+	struct dma_chan *chan = thread->chan;
+	struct dma_device *dev = chan->device;
+	struct dmatest_done *done = &thread->test_done;
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	dma_cookie_t cookie;
+	dma_addr_t *dsts;
+	enum dma_status status;
+	int ret = -ENOMEM, i;
+
+	um = dmaengine_get_unmap_data(dev->dev, src->cnt + dst->cnt,
+				      GFP_KERNEL);
+	if (!um) {
+		result("unmap data NULL", total_tests,
+		       src->off, dst->off, len, ret);
+		return -ENXIO;
+	}
+
+	um->len = len;
+	for (i = 0; i < src->cnt; i++) {
+		void *buf = src->aligned[i];
+		struct page *pg = virt_to_page(buf);
+		unsigned long pg_off = offset_in_page(buf);
+
+		um->addr[i] = dma_map_page(dev->dev, pg, pg_off,
+					   um->len, DMA_TO_DEVICE);
+		srcs[i] = um->addr[i] + src->off;
+		ret = dma_mapping_error(dev->dev, um->addr[i]);
+		if (ret) {
+			result("src mapping error", total_tests,
+			       src->off, dst->off, len, ret);
+			goto error_unmap;
+		}
+		um->to_cnt++;
+	}
+	/* map with DMA_BIDIRECTIONAL to force writeback/invalidate */
+	dsts = &um->addr[src->cnt];
+	for (i = 0; i < dst->cnt; i++) {
+		void *buf = dst->aligned[i];
+		struct page *pg = virt_to_page(buf);
+		unsigned long pg_off = offset_in_page(buf);
+
+		dsts[i] = dma_map_page(dev->dev, pg, pg_off, um->len,
+				       DMA_BIDIRECTIONAL);
+		ret = dma_mapping_error(dev->dev, dsts[i]);
+		if (ret) {
+			result("dst mapping error", total_tests,
+			       src->off, dst->off, len, ret);
+			goto error_unmap;
+		}
+		um->bidi_cnt++;
+	}
+
+	if (thread->type == DMA_MEMCPY)
+		tx = dev->device_prep_dma_memcpy(chan,
+						 dsts[0] + dst->off,
+						 srcs[0], len, flags);
+	else if (thread->type == DMA_MEMSET)
+		tx = dev->device_prep_dma_memset(chan,
+					dsts[0] + dst->off,
+					*(src->aligned[0] + src->off),
+					len, flags);
+	else if (thread->type == DMA_XOR)
+		tx = dev->device_prep_dma_xor(chan,
+					      dsts[0] + dst->off,
+					      srcs, src->cnt,
+					      len, flags);
+	else if (thread->type == DMA_PQ) {
+		for (i = 0; i < dst->cnt; i++)
+			dma_pq[i] = dsts[i] + dst->off;
+		tx = dev->device_prep_dma_pq(chan, dma_pq, srcs,
+					     src->cnt, pq_coefs,
+					     len, flags);
+	}
+
+	if (!tx) {
+		result("prep error", total_tests, src->off,
+		       dst->off, len, ret);
+		msleep(100);
+		goto error_unmap;
+	}
+
+	done->done = false;
+	if (!params->polled) {
+		tx->callback = dmatest_callback;
+		tx->callback_param = done;
+	}
+	cookie = tx->tx_submit(tx);
+
+	if (dma_submit_error(cookie)) {
+		result("submit error", total_tests, src->off,
+		       dst->off, len, ret);
+		msleep(100);
+		goto error_unmap;
+	}
+
+	if (params->polled) {
+		status = dma_sync_wait(chan, cookie);
+		dmaengine_terminate_sync(chan);
+		if (status == DMA_COMPLETE)
+			done->done = true;
+	} else {
+		dma_async_issue_pending(chan);
+
+		wait_event_freezable_timeout(thread->done_wait, done->done,
+					     msecs_to_jiffies(params->timeout));
+
+		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+	}
+
+	if (!done->done) {
+		result("test timed out", total_tests, src->off, dst->off,
+		       len, 0);
+		goto error_unmap;
+	} else if (status != DMA_COMPLETE) {
+		result(status == DMA_ERROR ?
+		       "completion error status" :
+		       "completion busy status", total_tests, src->off,
+		       dst->off, len, ret);
+		goto error_unmap;
+	}
+
+	dmaengine_unmap_put(um);
+	return 0;
+
+ error_unmap:
+	dmaengine_unmap_put(um);
+	return -ENXIO;
+}
+
 /*
  * This function repeatedly tests DMA transfers of various lengths and
  * offsets for a given operation type until it is told to exit by
@@ -552,7 +786,6 @@ static int dmatest_alloc_test_data(struct dmatest_data *d,
 static int dmatest_func(void *data)
 {
 	struct dmatest_thread	*thread = data;
-	struct dmatest_done	*done = &thread->test_done;
 	struct dmatest_info	*info;
 	struct dmatest_params	*params;
 	struct dma_chan		*chan;
@@ -560,8 +793,6 @@ static int dmatest_func(void *data)
 	unsigned int		error_count;
 	unsigned int		failed_tests = 0;
 	unsigned int		total_tests = 0;
-	dma_cookie_t		cookie;
-	enum dma_status		status;
 	enum dma_ctrl_flags 	flags;
 	u8			*pq_coefs = NULL;
 	int			ret;
@@ -664,9 +895,6 @@ static int dmatest_func(void *data)
 	ktime = ktime_get();
 	while (!kthread_should_stop()
 	       && !(params->iterations && total_tests >= params->iterations)) {
-		struct dma_async_tx_descriptor *tx = NULL;
-		struct dmaengine_unmap_data *um;
-		dma_addr_t *dsts;
 		unsigned int len;
 
 		total_tests++;
@@ -714,123 +942,17 @@ static int dmatest_func(void *data)
 			filltime = ktime_add(filltime, diff);
 		}
 
-		um = dmaengine_get_unmap_data(dev->dev, src->cnt + dst->cnt,
-					      GFP_KERNEL);
-		if (!um) {
+		if (dev->device_submit_request)
+			ret = dma_test_req_op(thread, src, dst, total_tests,
+					      len);
+		else
+			ret = dma_test_op(thread, src, dst, srcs,
+					  dma_pq, total_tests, len, pq_coefs);
+		if (ret < 0) {
 			failed_tests++;
-			result("unmap data NULL", total_tests,
-			       src->off, dst->off, len, ret);
 			continue;
 		}
 
-		um->len = buf_size;
-		for (i = 0; i < src->cnt; i++) {
-			void *buf = src->aligned[i];
-			struct page *pg = virt_to_page(buf);
-			unsigned long pg_off = offset_in_page(buf);
-
-			um->addr[i] = dma_map_page(dev->dev, pg, pg_off,
-						   um->len, DMA_TO_DEVICE);
-			srcs[i] = um->addr[i] + src->off;
-			ret = dma_mapping_error(dev->dev, um->addr[i]);
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
-			dsts[i] = dma_map_page(dev->dev, pg, pg_off, um->len,
-					       DMA_BIDIRECTIONAL);
-			ret = dma_mapping_error(dev->dev, dsts[i]);
-			if (ret) {
-				result("dst mapping error", total_tests,
-				       src->off, dst->off, len, ret);
-				goto error_unmap_continue;
-			}
-			um->bidi_cnt++;
-		}
-
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
-		}
-
-		if (!tx) {
-			result("prep error", total_tests, src->off,
-			       dst->off, len, ret);
-			msleep(100);
-			goto error_unmap_continue;
-		}
-
-		done->done = false;
-		if (!params->polled) {
-			tx->callback = dmatest_callback;
-			tx->callback_param = done;
-		}
-		cookie = tx->tx_submit(tx);
-
-		if (dma_submit_error(cookie)) {
-			result("submit error", total_tests, src->off,
-			       dst->off, len, ret);
-			msleep(100);
-			goto error_unmap_continue;
-		}
-
-		if (params->polled) {
-			status = dma_sync_wait(chan, cookie);
-			dmaengine_terminate_sync(chan);
-			if (status == DMA_COMPLETE)
-				done->done = true;
-		} else {
-			dma_async_issue_pending(chan);
-
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
-
-			status = dma_async_is_tx_complete(chan, cookie, NULL,
-							  NULL);
-		}
-
-		if (!done->done) {
-			result("test timed out", total_tests, src->off, dst->off,
-			       len, 0);
-			goto error_unmap_continue;
-		} else if (status != DMA_COMPLETE) {
-			result(status == DMA_ERROR ?
-			       "completion error status" :
-			       "completion busy status", total_tests, src->off,
-			       dst->off, len, ret);
-			goto error_unmap_continue;
-		}
-
-		dmaengine_unmap_put(um);
-
 		if (params->noverify) {
 			verbose_result("test passed", total_tests, src->off,
 				       dst->off, len, 0);
@@ -871,12 +993,6 @@ static int dmatest_func(void *data)
 			verbose_result("test passed", total_tests, src->off,
 				       dst->off, len, 0);
 		}
-
-		continue;
-
-error_unmap_continue:
-		dmaengine_unmap_put(um);
-		failed_tests++;
 	}
 	ktime = ktime_sub(ktime_get(), ktime);
 	ktime = ktime_sub(ktime, comparetime);

