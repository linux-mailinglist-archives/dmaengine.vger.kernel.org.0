Return-Path: <dmaengine+bounces-862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21C840CCC
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD0F1F29BB3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333515704F;
	Mon, 29 Jan 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="reCqO7KH"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878C159578;
	Mon, 29 Jan 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547755; cv=none; b=q+Kdn7zDbA41J+nceGGZKT03e+gRW0tC4QziDIrORH1Qd970LBaXdTSnvpeHKYDlAI7Vw3QSgS6BmPQ3mKH3Na9aFep77RPQMqDMTC91sTsULBFhYLWeHYYq1faqfsrSjr+5PXR3Kk02jfML5A6+Skm69G8JBdKA8u9QCWbyyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547755; c=relaxed/simple;
	bh=0y8kLw+aA7K36Gjm6NOLYCOcdvQW78uBQ7ekLR5rBGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9fDZv8vXm0ZHoFzS1a/w9sGVnTULykWWflG/tCT26QO/RxVLB85f9kwl4HIYKoKNypIX7PSeBw6sZHx4Dq3EeJKtlOi6STBJ0r3jT7iZMlzORxgAzhZn+09gfmzhiP8USZbL9aeD8lnnrMp2NoFPcU+JRRnXxu2PQ1rgDeUVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=reCqO7KH; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706547737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AurlEA6DoJCzg+71bkiCFnfLG7gMwOBZhYf30UJ9HR8=;
	b=reCqO7KHV08j9c8YnlrUDobYtPOoXhcSBM5TvFFi9A2IoHtmdScjc6h1aDrHx00MQwOnpV
	JB9OaENhyi9FKNLFet5DZB5rXl2JCxyTs091MFUPhbNLuU6ijt2AAqctWNg2D1/jL3YLMD
	soUqE3clcatavU8p5WDb6lYM21HG648=
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
Subject: [PATCH v6 2/6] dmaengine: dma-axi-dmac: Implement device_prep_slave_dma_vec
Date: Mon, 29 Jan 2024 18:01:57 +0100
Message-ID: <20240129170201.133785-3-paul@crapouillou.net>
In-Reply-To: <20240129170201.133785-1-paul@crapouillou.net>
References: <20240129170201.133785-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation of the .device_prep_slave_dma_vec() callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v3: New patch

v5: Implement .device_prep_slave_dma_vec() instead of v3's
    .device_prep_slave_dma_array().

v6: Use new prototype for axi_dmac_alloc_desc() as it changed upstream.
---
 drivers/dma/dma-axi-dmac.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 4e339c04fc1e..276856a1742d 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -620,6 +620,45 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	return sg;
 }
 
+static struct dma_async_tx_descriptor *
+axi_dmac_prep_slave_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
+			    size_t nb, enum dma_transfer_direction direction,
+			    unsigned long flags)
+{
+	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
+	struct axi_dmac_desc *desc;
+	unsigned int num_sgs = 0;
+	struct axi_dmac_sg *dsg;
+	size_t i;
+
+	if (direction != chan->direction)
+		return NULL;
+
+	for (i = 0; i < nb; i++)
+		num_sgs += DIV_ROUND_UP(vecs[i].len, chan->max_length);
+
+	desc = axi_dmac_alloc_desc(chan, num_sgs);
+	if (!desc)
+		return NULL;
+
+	dsg = desc->sg;
+
+	for (i = 0; i < nb; i++) {
+		if (!axi_dmac_check_addr(chan, vecs[i].addr) ||
+		    !axi_dmac_check_len(chan, vecs[i].len)) {
+			kfree(desc);
+			return NULL;
+		}
+
+		dsg = axi_dmac_fill_linear_sg(chan, direction, vecs[i].addr, 1,
+					      vecs[i].len, dsg);
+	}
+
+	desc->cyclic = false;
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
 static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	struct dma_chan *c, struct scatterlist *sgl,
 	unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1055,6 +1094,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_tx_status = dma_cookie_status;
 	dma_dev->device_issue_pending = axi_dmac_issue_pending;
 	dma_dev->device_prep_slave_sg = axi_dmac_prep_slave_sg;
+	dma_dev->device_prep_slave_dma_vec = axi_dmac_prep_slave_dma_vec;
 	dma_dev->device_prep_dma_cyclic = axi_dmac_prep_dma_cyclic;
 	dma_dev->device_prep_interleaved_dma = axi_dmac_prep_interleaved;
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
-- 
2.43.0


