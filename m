Return-Path: <dmaengine+bounces-2440-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6691041B
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B091C211B6
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3251AD4B0;
	Thu, 20 Jun 2024 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="y/QRkIPc"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0E1AC777;
	Thu, 20 Jun 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886513; cv=none; b=FoP2UmLOeaErUQ6UAnz8Rbl1XujtxrVM3wf0jSAkDfZx4QiBvYdlvDgFbHdS3LXwHk2ZRcIBFFgQK082jWttgZKtwIAdoZowQvno/C0nrp7BVcPnE3jA0di2KcMqJjJyBC4QqeIOO/MC/a7pa1fNHsIStaUOWJibUoMhedn4/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886513; c=relaxed/simple;
	bh=lM3sZojwQF3b6AAoZU4Zv13gMxXQXy9eI+E/mcVgwlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGO5WzsL/sAJe6H4zkJEBtH3NFODWSN8TnmH66SE7XOcWTOARHfID/OpnEfTAri6P9RSCXq4yYD/IBsdpyLs1zaqJvmqEuXZ0LzKVmRSoYmYHvJuKBEyOsjvdNGxWXmIMTqgmzvQX4BiBjA5mtUz+o6QuMhy67meJJ3XCD+NYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=y/QRkIPc; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718886467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HdP73lD+hFGyCnDoiLYzWmkwAFo8c/CN4zvOA6YpR4=;
	b=y/QRkIPc8b9hwHGDKgSN1Umiu3QovDqB+L794AHgaqqV4LhmCch3NoSDTGkgzwDJFYuttR
	4J78Qh1ccl0wQ68m/drhEAQxJTWBWKoRUfeX/gZQQbkPZB4wpQ4+Q54mmaT52CfqwQz4By
	7jNKnkYw4YSjpp2xCFF+9K8C6enpwUE=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v12 5/7] iio: buffer-dmaengine: Support new DMABUF based userspace API
Date: Thu, 20 Jun 2024 14:27:24 +0200
Message-ID: <20240620122726.41232-6-paul@crapouillou.net>
In-Reply-To: <20240620122726.41232-1-paul@crapouillou.net>
References: <20240620122726.41232-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the functions provided by the buffer-dma core to implement the
DMABUF userspace API in the buffer-dmaengine IIO buffer implementation.

Since we want to be able to transfer an arbitrary number of bytes and
not necesarily the full DMABUF, the associated scatterlist is converted
to an array of DMA addresses + lengths, which is then passed to
dmaengine_prep_slave_dma_array().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Co-developed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>

---
v3: Use the new dmaengine_prep_slave_dma_array(), and adapt the code to
    work with the new functions introduced in industrialio-buffer-dma.c.

v5: - Use the new dmaengine_prep_slave_dma_vec().
    - Restrict to input buffers, since output buffers are not yet
      supported by IIO buffers.

v6: - Populate .lock_queue / .unlock_queue callbacks
    - Switch to atomic memory allocations in .submit_queue, because of
      the dma_fence critical section
    - Make sure that the size of the scatterlist is enough

v7: Adapted patch for the changes made in patch 1.

v10:
  - Remove extra flags parameter to dmaengine_prep_peripheral_dma_vec()
  - Add support for TX transfers
---
 .../buffer/industrialio-buffer-dmaengine.c    | 62 ++++++++++++++++---
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 918f6f8d65b6..12aa1412dfa0 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -65,25 +65,62 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
 	struct dma_async_tx_descriptor *desc;
 	enum dma_transfer_direction dma_dir;
+	struct scatterlist *sgl;
+	struct dma_vec *vecs;
 	size_t max_size;
 	dma_cookie_t cookie;
+	size_t len_total;
+	unsigned int i;
+	int nents;
 
 	max_size = min(block->size, dmaengine_buffer->max_size);
 	max_size = round_down(max_size, dmaengine_buffer->align);
 
-	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
-		block->bytes_used = max_size;
+	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
 		dma_dir = DMA_DEV_TO_MEM;
-	} else {
+	else
 		dma_dir = DMA_MEM_TO_DEV;
-	}
 
-	if (!block->bytes_used || block->bytes_used > max_size)
-		return -EINVAL;
+	if (block->sg_table) {
+		sgl = block->sg_table->sgl;
+		nents = sg_nents_for_len(sgl, block->bytes_used);
+		if (nents < 0)
+			return nents;
+
+		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
+		if (!vecs)
+			return -ENOMEM;
+
+		len_total = block->bytes_used;
+
+		for (i = 0; i < nents; i++) {
+			vecs[i].addr = sg_dma_address(sgl);
+			vecs[i].len = min(sg_dma_len(sgl), len_total);
+			len_total -= vecs[i].len;
+
+			sgl = sg_next(sgl);
+		}
 
-	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, dma_dir,
-		DMA_PREP_INTERRUPT);
+		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
+							 vecs, nents, dma_dir,
+							 DMA_PREP_INTERRUPT);
+		kfree(vecs);
+	} else {
+		max_size = min(block->size, dmaengine_buffer->max_size);
+		max_size = round_down(max_size, dmaengine_buffer->align);
+
+		if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
+			block->bytes_used = max_size;
+
+		if (!block->bytes_used || block->bytes_used > max_size)
+			return -EINVAL;
+
+		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
+						   block->phys_addr,
+						   block->bytes_used,
+						   dma_dir,
+						   DMA_PREP_INTERRUPT);
+	}
 	if (!desc)
 		return -ENOMEM;
 
@@ -133,6 +170,13 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.space_available = iio_dma_buffer_usage,
 	.release = iio_dmaengine_buffer_release,
 
+	.enqueue_dmabuf = iio_dma_buffer_enqueue_dmabuf,
+	.attach_dmabuf = iio_dma_buffer_attach_dmabuf,
+	.detach_dmabuf = iio_dma_buffer_detach_dmabuf,
+
+	.lock_queue = iio_dma_buffer_lock_queue,
+	.unlock_queue = iio_dma_buffer_unlock_queue,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };
-- 
2.43.0


