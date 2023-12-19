Return-Path: <dmaengine+bounces-578-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D724818ED3
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02031F26E0F
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03839AEB;
	Tue, 19 Dec 2023 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MD7vMUMC"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507993B78E;
	Tue, 19 Dec 2023 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1703008218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mefUUY4PY+5zEqdnyMwjckQ6lxyQfK8RCtgZJoFSsZA=;
	b=MD7vMUMC4oPmjYBQEv5bIQAzFYYL4b9CV6xWxXvAkBxCrHvfJJsOT2a6KLYYVE57uZ7lP5
	fe9LxGyopxojuYwQ732mr9+TTP72e+ZzX2oeEjWnjoia0RiSBypWGtlhwBamgIlX+IkKrb
	I6KJv4FcSUA2mHJo7BsHK5ZX1myVTh8=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 1/8] iio: buffer-dma: Get rid of outgoing queue
Date: Tue, 19 Dec 2023 18:50:02 +0100
Message-ID: <20231219175009.65482-2-paul@crapouillou.net>
In-Reply-To: <20231219175009.65482-1-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

The buffer-dma code was using two queues, incoming and outgoing, to
manage the state of the blocks in use.

While this totally works, it adds some complexity to the code,
especially since the code only manages 2 blocks. It is much easier to
just check each block's state manually, and keep a counter for the next
block to dequeue.

Since the new DMABUF based API wouldn't use the outgoing queue anyway,
getting rid of it now makes the upcoming changes simpler.

With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and can
be removed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v2: - Only remove the outgoing queue, and keep the incoming queue, as we
      want the buffer to start streaming data as soon as it is enabled.
    - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now functionally the
      same as IIO_BLOCK_STATE_DONE.
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 44 ++++++++++----------
 include/linux/iio/buffer-dma.h               |  7 ++--
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index d348af8b9705..1fc91467d1aa 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -179,7 +179,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 	}
 
 	block->size = size;
-	block->state = IIO_BLOCK_STATE_DEQUEUED;
+	block->state = IIO_BLOCK_STATE_DONE;
 	block->queue = queue;
 	INIT_LIST_HEAD(&block->head);
 	kref_init(&block->kref);
@@ -191,16 +191,8 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 
 static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 {
-	struct iio_dma_buffer_queue *queue = block->queue;
-
-	/*
-	 * The buffer has already been freed by the application, just drop the
-	 * reference.
-	 */
-	if (block->state != IIO_BLOCK_STATE_DEAD) {
+	if (block->state != IIO_BLOCK_STATE_DEAD)
 		block->state = IIO_BLOCK_STATE_DONE;
-		list_add_tail(&block->head, &queue->outgoing);
-	}
 }
 
 /**
@@ -261,7 +253,6 @@ static bool iio_dma_block_reusable(struct iio_dma_buffer_block *block)
 	 * not support abort and has not given back the block yet.
 	 */
 	switch (block->state) {
-	case IIO_BLOCK_STATE_DEQUEUED:
 	case IIO_BLOCK_STATE_QUEUED:
 	case IIO_BLOCK_STATE_DONE:
 		return true;
@@ -317,7 +308,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 	 * dead. This means we can reset the lists without having to fear
 	 * corrution.
 	 */
-	INIT_LIST_HEAD(&queue->outgoing);
 	spin_unlock_irq(&queue->list_lock);
 
 	INIT_LIST_HEAD(&queue->incoming);
@@ -456,14 +446,20 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
 	struct iio_dma_buffer_queue *queue)
 {
 	struct iio_dma_buffer_block *block;
+	unsigned int idx;
 
 	spin_lock_irq(&queue->list_lock);
-	block = list_first_entry_or_null(&queue->outgoing, struct
-		iio_dma_buffer_block, head);
-	if (block != NULL) {
-		list_del(&block->head);
-		block->state = IIO_BLOCK_STATE_DEQUEUED;
+
+	idx = queue->fileio.next_dequeue;
+	block = queue->fileio.blocks[idx];
+
+	if (block->state == IIO_BLOCK_STATE_DONE) {
+		idx = (idx + 1) % ARRAY_SIZE(queue->fileio.blocks);
+		queue->fileio.next_dequeue = idx;
+	} else {
+		block = NULL;
 	}
+
 	spin_unlock_irq(&queue->list_lock);
 
 	return block;
@@ -539,6 +535,7 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
 	struct iio_dma_buffer_block *block;
 	size_t data_available = 0;
+	unsigned int i;
 
 	/*
 	 * For counting the available bytes we'll use the size of the block not
@@ -552,8 +549,15 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 		data_available += queue->fileio.active_block->size;
 
 	spin_lock_irq(&queue->list_lock);
-	list_for_each_entry(block, &queue->outgoing, head)
-		data_available += block->size;
+
+	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
+		block = queue->fileio.blocks[i];
+
+		if (block != queue->fileio.active_block
+		    && block->state == IIO_BLOCK_STATE_DONE)
+			data_available += block->size;
+	}
+
 	spin_unlock_irq(&queue->list_lock);
 	mutex_unlock(&queue->lock);
 
@@ -617,7 +621,6 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 	queue->ops = ops;
 
 	INIT_LIST_HEAD(&queue->incoming);
-	INIT_LIST_HEAD(&queue->outgoing);
 
 	mutex_init(&queue->lock);
 	spin_lock_init(&queue->list_lock);
@@ -645,7 +648,6 @@ void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
 			continue;
 		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
 	}
-	INIT_LIST_HEAD(&queue->outgoing);
 	spin_unlock_irq(&queue->list_lock);
 
 	INIT_LIST_HEAD(&queue->incoming);
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 6564bdcdac66..18d3702fa95d 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -19,14 +19,12 @@ struct device;
 
 /**
  * enum iio_block_state - State of a struct iio_dma_buffer_block
- * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
  * @IIO_BLOCK_STATE_QUEUED: Block is on the incoming queue
  * @IIO_BLOCK_STATE_ACTIVE: Block is currently being processed by the DMA
  * @IIO_BLOCK_STATE_DONE: Block is on the outgoing queue
  * @IIO_BLOCK_STATE_DEAD: Block has been marked as to be freed
  */
 enum iio_block_state {
-	IIO_BLOCK_STATE_DEQUEUED,
 	IIO_BLOCK_STATE_QUEUED,
 	IIO_BLOCK_STATE_ACTIVE,
 	IIO_BLOCK_STATE_DONE,
@@ -73,12 +71,15 @@ struct iio_dma_buffer_block {
  * @active_block: Block being used in read()
  * @pos: Read offset in the active block
  * @block_size: Size of each block
+ * @next_dequeue: index of next block that will be dequeued
  */
 struct iio_dma_buffer_queue_fileio {
 	struct iio_dma_buffer_block *blocks[2];
 	struct iio_dma_buffer_block *active_block;
 	size_t pos;
 	size_t block_size;
+
+	unsigned int next_dequeue;
 };
 
 /**
@@ -93,7 +94,6 @@ struct iio_dma_buffer_queue_fileio {
  *   list and typically also a list of active blocks in the part that handles
  *   the DMA controller
  * @incoming: List of buffers on the incoming queue
- * @outgoing: List of buffers on the outgoing queue
  * @active: Whether the buffer is currently active
  * @fileio: FileIO state
  */
@@ -105,7 +105,6 @@ struct iio_dma_buffer_queue {
 	struct mutex lock;
 	spinlock_t list_lock;
 	struct list_head incoming;
-	struct list_head outgoing;
 
 	bool active;
 
-- 
2.43.0


