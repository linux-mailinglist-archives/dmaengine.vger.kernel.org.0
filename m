Return-Path: <dmaengine+bounces-861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEBD840CC1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E2A1C23247
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E71586C0;
	Mon, 29 Jan 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ROERA/vs"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07121157026;
	Mon, 29 Jan 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547747; cv=none; b=Yo64Khv9v3fo9N/8z+nIKV0vQdOhEk31KEJzaRLAuD/L6niC3h4kcYuKV6xF7L9e1EuunUrP1cGfrivanFB53z/keOWsSmByO6zx0Wiqjm4v0mNemMj/HG2H1dR8Oz0fUJXnOtl3maECLndJgE0p42g2tOq9HTwSZFiMeQW0oQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547747; c=relaxed/simple;
	bh=Zq5Xbj+rWU8akfSZxarVMv3U6m+GKxNoE54+0tQg5Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpbcLAZHQWGM5j/lBJcC5Jo0nkrO4SkH1PKf/VI+qUBfRDwF7jo/nPTNFeTQ7kXsTpmvY9yfnIvds9hi0pka/q9hoOQSj/KURAjYo6PAyZOm0VvKbuVqsvBOPJu6T4zNsVqDiC2/Rifgddk9AmBSd+9UAglLjaSlhbJMXMgag4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=ROERA/vs; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706547736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciNLk5XaUXAioykenKcf7E1KkXSWDnIcRp3Oxutuxu0=;
	b=ROERA/vshX8isvB0THFWyZBHPRQ3mRtms+JQHpKmfHNwLf3v8hy8SK0RzrSrf8PqWpYJ5A
	HqSDGa+GfTVW/uhOVp3EZ+mT8TwlYxnIAcYjcq2rDUG2msXKy5MinDfeIRRvlZcNglPKsf
	Ygr0mAttNSk7DNo6Qb7ZuiqXDTBbHls=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 1/6] dmaengine: Add API function dmaengine_prep_slave_dma_vec()
Date: Mon, 29 Jan 2024 18:01:56 +0100
Message-ID: <20240129170201.133785-2-paul@crapouillou.net>
In-Reply-To: <20240129170201.133785-1-paul@crapouillou.net>
References: <20240129170201.133785-1-paul@crapouillou.net>
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

---
v3: New patch

v5: Replace with function dmaengine_prep_slave_dma_vec(), and struct
    'dma_vec'.
    Note that at some point we will need to support cyclic transfers
    using dmaengine_prep_slave_dma_vec(). Maybe with a new "flags"
    parameter to the function?
---
 include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3df70d6131c8..ee5931ddb42f 100644
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
 
+	struct dma_async_tx_descriptor *(*device_prep_slave_dma_vec)(
+		struct dma_chan *chan, const struct dma_vec *vecs,
+		size_t nents, enum dma_transfer_direction direction,
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -972,6 +986,17 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_dma_vec(
+	struct dma_chan *chan, const struct dma_vec *vecs, size_t nents,
+	enum dma_transfer_direction dir, unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_slave_dma_vec)
+		return NULL;
+
+	return chan->device->device_prep_slave_dma_vec(chan, vecs, nents,
+						       dir, flags);
+}
+
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
 	enum dma_transfer_direction dir, unsigned long flags)
-- 
2.43.0


