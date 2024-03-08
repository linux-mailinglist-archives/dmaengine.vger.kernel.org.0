Return-Path: <dmaengine+bounces-1317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C476387692B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9EBB22DA8
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95412033B;
	Fri,  8 Mar 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="asYXEOeO"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175C24A06;
	Fri,  8 Mar 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917319; cv=none; b=BI+YJRueqfPlmNSS93v3ZTKbpkIp6Manyi8+VmoOYwe7NOdI8oNBOpevnUDYtxp9LZZN0PsIxiKFaXxP5PMoyJysSxmRQgTH6G25E/lets9KMFI+RZwnkq0sAbNWlgKhR3wl/mGwnySQmXrKs3hD41ziY+aZ/YuiLCwulza3nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917319; c=relaxed/simple;
	bh=v8F5DoNlHt0mR7veIGDJ45cx2qJsTw433pwoyOQmQcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCdQBq0oUDyULOfsMf4Zo1tKq4/cCuRXT1+VRCRbJ4pY3wQnEU1dE6OpfBWzgOugFhnd9g0Gbnn+jHlZVkHyKR4GTvNvbJNEZ2wU/V2VIr1S9vWGTf9NIus7S6ylcnzXgQXBlvWjPfkIdFMHogiQHydS3JpzzKnQFn6HAAWPkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=asYXEOeO; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1709917272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diVnTKGYmGTXMK2fWu9xl+JrtOVoNzvMtMZ/RN8kb8E=;
	b=asYXEOeOdL6jGQoMvpH6GdoOvPbLs6Oe+mVG5gFHm6wp7SdIe+qgLPa7N8kq8+/JPpjQSC
	RwuF9qGk9yGOLcB1IWwOu8VanOIdG9KqFHrdKB4cgTNHmV1FDPEjWK30Q1OMmz6SCHzGsg
	GX4hHQky6fk+lU7IUyv/oWuXmJjHRLA=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 5/6] iio: buffer-dmaengine: Support new DMABUF based userspace API
Date: Fri,  8 Mar 2024 18:00:45 +0100
Message-ID: <20240308170046.92899-6-paul@crapouillou.net>
In-Reply-To: <20240308170046.92899-1-paul@crapouillou.net>
References: <20240308170046.92899-1-paul@crapouillou.net>
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
---
 .../buffer/industrialio-buffer-dmaengine.c    | 59 +++++++++++++++++--
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index a18c1da292af..3b7b649f0a89 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -64,15 +64,55 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
 	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sgl;
+	struct dma_vec *vecs;
 	dma_cookie_t cookie;
+	size_t len_total;
+	size_t max_size;
+	unsigned int i;
+	int nents;
 
-	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
-	block->bytes_used = round_down(block->bytes_used,
-			dmaengine_buffer->align);
+	if (queue->buffer.direction != IIO_BUFFER_DIRECTION_IN) {
+		/* We do not yet support output buffers. */
+		return -EINVAL;
+	}
 
-	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
-		DMA_PREP_INTERRUPT);
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
+
+		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
+							 vecs, nents,
+							 DMA_DEV_TO_MEM,
+							 DMA_PREP_INTERRUPT, 0);
+		kfree(vecs);
+	} else {
+		max_size = min(block->size, dmaengine_buffer->max_size);
+		max_size = round_down(max_size, dmaengine_buffer->align);
+		block->bytes_used = max_size;
+
+		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
+						   block->phys_addr,
+						   block->bytes_used,
+						   DMA_DEV_TO_MEM,
+						   DMA_PREP_INTERRUPT);
+	}
 	if (!desc)
 		return -ENOMEM;
 
@@ -120,6 +160,13 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.data_available = iio_dma_buffer_data_available,
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


