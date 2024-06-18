Return-Path: <dmaengine+bounces-2399-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DC90C8D6
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAB28318D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBCE1AE0AB;
	Tue, 18 Jun 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JN3FcudL"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493C1AE096;
	Tue, 18 Jun 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705001; cv=none; b=T4Fh4SDo8YcBpYtC2EAmRltkWSVzfCbPt+C4PSxQwRhcsUOBvImKXaqwcg/gQDJIVin/pDDu2NKMXJWQr1ngHrAS90dxNH3ZmmNgpVGRD9002pYVbw9KACIQ56pp2DAvcpU2lOE4x7uDdE2pw8M2QVU6hA9lmu2NC9+LMnYdiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705001; c=relaxed/simple;
	bh=nWDpXsNxoYMpIQeLbKXHlfln59qAJRQXxEb+snINQHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrW/hfRbDcznKBBSHT/j1Q4UKXgFRlUzhAi6XSfDJuxW6uS5Fb5UmwW0ZK5y8ox7snh+rR/jgPSsiYji7+ATVbkiJ29x6PpSE/x+FE8yXQTiLZXVwZmLMW3sgXRaFGGtqoedxLpiqLFNw5+11wrRSRzBEOZ2hzOF5yPByqp58wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=JN3FcudL; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718704990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efgVLlNGDnopAmZBC5nh+wIIy52d8Py2hYi67rMzjJ0=;
	b=JN3FcudLNq/SSIZoMe8ldPeJhBQkpEe4d137sMJZXq/IGqeyiGifshBpfXtoUHzkd9+GzA
	NYbeTtTMPbu7nIepMZq8Kd54bZkAFaCDKOPYXJj3tj+GO9HnWdv5vAKQe5dTpnGr6kA1eW
	hu3oi1UCURO5Tf7hpUZTlGoaMUghfT8=
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
Subject: [PATCH v11 1/7] dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
Date: Tue, 18 Jun 2024 12:02:56 +0200
Message-ID: <20240618100302.72886-2-paul@crapouillou.net>
In-Reply-To: <20240618100302.72886-1-paul@crapouillou.net>
References: <20240618100302.72886-1-paul@crapouillou.net>
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
Co-developed-by: Nuno Sa <nuno.sa@analog.com>
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
index 73537fddbb52..b137fdb56093 100644
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


