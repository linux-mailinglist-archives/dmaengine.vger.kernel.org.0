Return-Path: <dmaengine+bounces-2266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D568FC9C0
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60511C22155
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE31922FC;
	Wed,  5 Jun 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="duOEvwmL"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D6190490;
	Wed,  5 Jun 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585757; cv=none; b=rhFXlgsDFebldskGJ5ncHfqIa+GT98EhOxtGxwm8Lk8T10nlCW78ZRypRZT57k1JqlQOL1KlSIHsmu7PtjBozuI/yLlMOJ5Q4YUyI6pv9ShqbAdmGZVX9ScHlklsRFq51QackKwocpGrihBPbM7xvX5YJnsfzQujUzFrE9ZYxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585757; c=relaxed/simple;
	bh=u1AIWsnttLSRKtpaWK94JbuZszg9FRkieNFLz9/mkVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqeYzXR+u+dAQuDjRdlPxbKL6lejuuAx07le0gUCBXx/FrGdYpWc64h3Ol3Yo78ELp7QK/Vis6cSArUcGRD0iqE/B7OEteVDba5rS6kRw+H7lIrOL7MbuiNp6d5B/44QtgwqkIzoQ1PMsLQko7YRCLD2NZ5sfbXfkfjYMzM5yH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=duOEvwmL; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1717585739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+bpo9IhXlSNnyxVxTZI9wza03doX2paj+5rtqcioR4=;
	b=duOEvwmLl9bd8EXe/ieWKxDYIPVHIJVs32vqQ7hYjjmYfzNxBznCUE+9V8uZc71TGgu4Pg
	C8LTXVDnrE1tyki4Wf0IC1mRKHVwafp94PNFRK6SHnTinxWx+IM+xPSClfUHJCohKHIt+w
	XpMPyzrHCKx5/6AhZYsBzzyvtZ7db5Y=
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
Subject: [PATCH v10 1/6] dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
Date: Wed,  5 Jun 2024 13:08:40 +0200
Message-ID: <20240605110845.86740-2-paul@crapouillou.net>
In-Reply-To: <20240605110845.86740-1-paul@crapouillou.net>
References: <20240605110845.86740-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function can be used to initiate a scatter-gather DMA transfer,
where the address and size of each segment is located in one entry of
the dma_vec array.

The major difference with dmaengine_prep_slave_sg() is that it supports
specifying the lengths of each DMA transfer; as trying to override the
length of the transfer with dmaengine_prep_slave_sg() is a very tedious
process. The introduction of a new API function is also justified by the
fact that scatterlists are on their way out.

Note that dmaengine_prep_interleaved_dma() is not helpful either in that
case, as it assumes that the address of each segment will be higher than
the one of the previous segment, which we just cannot guarantee in case
of a scatter-gather transfer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>

---
v3: New patch

v5: Replace with function dmaengine_prep_slave_dma_vec(), and struct
    'dma_vec'.
    Note that at some point we will need to support cyclic transfers
    using dmaengine_prep_slave_dma_vec(). Maybe with a new "flags"
    parameter to the function?

v7:
  - Renamed *device_prep_slave_dma_vec() -> device_prep_peripheral_dma_vec();
  - Added a new flag parameter to the function as agreed between Paul
    and Vinod. I renamed the first parameter to prep_flags as it's supposed to
    be used (I think) with enum dma_ctrl_flags. I'm not really sure how that API
    can grow but I was thinking in just having a bool cyclic parameter (as the
    first intention of the flags is to support cyclic transfers) but ended up
    "respecting" the previously agreed approach.

v10:
  - Add kernel doc to dmaengine_prep_peripheral_dma_vec()
  - Remove extra flags parameter
---
 include/linux/dmaengine.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 752dbde4cec1..9fc03068cabc 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -160,6 +160,16 @@ struct dma_interleaved_template {
 	struct data_chunk sgl[];
 };
 
+/**
+ * struct dma_vec - DMA vector
+ * @addr: Bus address of the start of the vector
+ * @len: Length in bytes of the DMA vector
+ */
+struct dma_vec {
+	dma_addr_t addr;
+	size_t len;
+};
+
 /**
  * enum dma_ctrl_flags - DMA flags to augment operation preparation,
  *  control completion, and communicate status.
@@ -910,6 +920,10 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
 		struct dma_chan *chan, unsigned long flags);
 
+	struct dma_async_tx_descriptor *(*device_prep_peripheral_dma_vec)(
+		struct dma_chan *chan, const struct dma_vec *vecs,
+		size_t nents, enum dma_transfer_direction direction,
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -973,6 +987,25 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 						  dir, flags, NULL);
 }
 
+/**
+ * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
+ * @chan: The channel to be used for this descriptor
+ * @vecs: The array of DMA vectors that should be transferred
+ * @nents: The number of DMA vectors in the array
+ * @dir: Specifies the direction of the data transfer
+ * @flags: DMA engine flags
+ */
+static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
+	struct dma_chan *chan, const struct dma_vec *vecs, size_t nents,
+	enum dma_transfer_direction dir, unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_peripheral_dma_vec)
+		return NULL;
+
+	return chan->device->device_prep_peripheral_dma_vec(chan, vecs, nents,
+							    dir, flags);
+}
+
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
 	enum dma_transfer_direction dir, unsigned long flags)
-- 
2.43.0


