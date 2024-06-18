Return-Path: <dmaengine+bounces-2400-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBB90C920
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D808BB27728
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0A211116;
	Tue, 18 Jun 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EESD9ly6"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0121110A;
	Tue, 18 Jun 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705009; cv=none; b=E8PmrhI/ozl6BkSCK996w+POPO2HDfDsFmXSKjltPzKtRmcKWVidHIjVAdoG8L02ZexSkFPkWdl+CLzmLQcZUlRKYei4gO0DPELHpkG1owt5i/BNjW3Adb7gx+n7RIha9P4vWHfmoLCbDsHyAkzZclK2atcivdOHLTDY/59y0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705009; c=relaxed/simple;
	bh=0DRFcH0U5xSf8HflqJd88zYqjJ+VSUZlgKUpOhHeL3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O128KzrKJzcP7dW4Pgd4TxsAfj2koRTbvG7EXdDHXeiBotW+KQiIJJ4ldRl0LNBJB8h7z1lG+EX3HZpiO32ua8Qd0EH66J7by8OyD8Ba6460Y0wvSWd2kLwHBnnfqKteJoRotFQcYrY8PUWf4dKhRLU3iEtDnze2FFBAC8lPBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=EESD9ly6; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718704991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSnpIY3MKSqN2Xbh+3dII8pUFm0HIfotCaLrSnzvqJo=;
	b=EESD9ly6KffVvT5xygjvnxeUSTBwKbz3lDXiEicB05FxTvE3YwPBF2cW/VWpKcf56mpFS2
	WS7w3nCkFgODPJThNYo13JRdprR5jAB5PWMO4frBnqfdMpTxdtNXf1A1WcqC6ts5XyTiBc
	SrwH7P0xKSd0d3ebwe7UZePZ5tQdCOc=
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
Subject: [PATCH v11 2/7] dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
Date: Tue, 18 Jun 2024 12:02:57 +0200
Message-ID: <20240618100302.72886-3-paul@crapouillou.net>
In-Reply-To: <20240618100302.72886-1-paul@crapouillou.net>
References: <20240618100302.72886-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation of the .device_prep_peripheral_dma_vec() callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Co-developed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>

---
v3: New patch

v5: Implement .device_prep_slave_dma_vec() instead of v3's
    .device_prep_slave_dma_array().

v6: Use new prototype for axi_dmac_alloc_desc() as it changed upstream.

v7: Adapted patch for the changes made in patch 1.

v10: Use the new function prototype (without the extra prep_flags).
---
 drivers/dma/dma-axi-dmac.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index bdb752f11869..36943b0c6d60 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -620,6 +620,45 @@ static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	return sg;
 }
 
+static struct dma_async_tx_descriptor *
+axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
+				 size_t nb, enum dma_transfer_direction direction,
+				 unsigned long flags)
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
@@ -1061,6 +1100,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_tx_status = dma_cookie_status;
 	dma_dev->device_issue_pending = axi_dmac_issue_pending;
 	dma_dev->device_prep_slave_sg = axi_dmac_prep_slave_sg;
+	dma_dev->device_prep_peripheral_dma_vec = axi_dmac_prep_peripheral_dma_vec;
 	dma_dev->device_prep_dma_cyclic = axi_dmac_prep_dma_cyclic;
 	dma_dev->device_prep_interleaved_dma = axi_dmac_prep_interleaved;
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
-- 
2.43.0


