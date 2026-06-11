Return-Path: <dmaengine+bounces-11482-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qeauHmQkK2rZ3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11482-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:11:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C627675634
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:11:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bBV2klXB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11482-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11482-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78B5E33DEB0C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB3382F2F;
	Thu, 11 Jun 2026 21:07:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D43164BA
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212073; cv=none; b=XSzNufA+lEfLplUxq8q5tp7z+yVLRmluVgcSpIa18vdnjro5LzKL6i8gCQIADpZWrN/FeQfjGBhBQJR92fEkzmw2jeFXac4tJZCc9wV6KkwM9rFKBhUsRSKFb46PuEBh8tw/f3+J8HSP6MXtMS6smf0qv1O4LxZJ5kipF2ZoOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212073; c=relaxed/simple;
	bh=EwWhH0tmc87rXWNLfbjvT0gCg/ee+d85d/JJzsByeag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uli/8fpe4AV2Z3pHo49fOsTxJb6+E2+6lvMvuEZzUygxg0jCNHCz4xGyHlewsj8sb3S3eiIklhlbuoxmXNHjUrIKP2w2J8dkJ7hxqaMAYNXJYHC6lHdBcLFNNno8GdjsGkGXc8b8iKqZVT6LQvMEv4S6c+wpwAUpnsoR63hnt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBV2klXB; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0aa420401so2419735ad.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212071; x=1781816871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yxjtuyAoVuuegBTIVE4wKKcPrLwBh7tLs1zHhyCbPM=;
        b=bBV2klXBB8fN7UrUOgNYly+RtZgP/uCCqyfGUhMHpPWpu3woIscdlYs/DxYn+5YHCN
         tmV8SSzpoIiRAMlAS3oXiPTDfgp4+PiTFy/6HV89S45jD2Z1OhPE8pVL5C6ussxo1Kru
         yP7xOYNsgvy5XDC+qcTBOmNlw/HBk+JtL5PpADQNclnApgDe3Q+9b8jCUdgjHbc6o8ls
         sWsASNEpc70TYo9JeYYtiADNcEtap3EsA6CEWMMhnTn8a3ccoLv6UNZBCMFpeRIcm5Il
         2uDQ+FHmQJNBstXfFxYNIag2oBi1fA9cDFwBAySGABZsqThrUVW7QQ4CVg4pBlGxZImT
         s3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212071; x=1781816871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yxjtuyAoVuuegBTIVE4wKKcPrLwBh7tLs1zHhyCbPM=;
        b=jEVK1Re1gh11K2vyhjLZhFTA6ZDvxPmUGvpYV1o9dx89LX5CHSV6QzdYNijMpoKS2w
         z3fwNker2rdT7WtHdszDg8yRBb9EIQUQsP0YMxD+g8ByonNVJOCgQqRTouajFlNx4H0t
         3e4LQQ71RFOYHiwhqSW/RUhGeEq2PfWTOwdkuzPLaJqWE7Em6a/ZGrJnvV7yC1oizziF
         dneoKkS6TLOfJLo5cbLfOM60nlXmlIDoGVHzH83Z9fFiBuxWHAVqy7Zo85ARh8uAXv5e
         1PZRJ6omwnLm+kHx1QS+p6SFcV1wLIni+xeswXqaP1e1/reNTdrDi39LlYgB7UzOG2DS
         l+bg==
X-Gm-Message-State: AOJu0YzSO5H+kdYOifBZUqtsa4SGyXSGE9fuCuxW0pr8Gjpj3shumhTG
	h7HDmtOmJZpO23ApeY2ze6e19o5k+wiMCcfN0sDlW+aX+3bMNUXbyRACsxxsGg==
X-Gm-Gg: Acq92OGi/5ZwUV01Mi3+HrlIfUef6DIYT5DKQkhDSSwmqXygl6Gq9G4kIK9yhO0rjGH
	IQYqksNHEhonUmN3wFn6LT2r5vN3ke0+btu7SbmXV3xGHG7fdaSi7FBFmEnFqEJyMqjgCnpbmt3
	kEQWOXWzUAwRgfj7/gMBD55gmamXm0U2n+lHtZbwAtmGecIRafPssceg7NCgIcGFo+xrf+1Wafr
	dwP4ioORFBFoe+BLwjopocvvSp+6qRzCRdGsX/eWMyA/dkOjNQvKxTL5ggjwW69sRy6MwfyMsO0
	l5b0Qj0UEUUscUW+9USH0luvotrjxHBi3ue+mEnyM65+HMqI++ThuThRycOMLuaoNa0FbP9nk/e
	zt6jbPjBm8BdCk3JvjKMY5seYTS3LX74kapYGGTvuQWC0qTqgK4hQWlErltWXqZpzWhhskStUHZ
	UhbEFIxuOt4KMidHvHX0RbYcSRdpHkxIlSbTPQ05Tvcvy1ojhhrSsPB8mlek7vIHwVX6oDcx7iY
	CVz1opMIxM1gnJmgzWbPIUaViX8jYNwbOo=
X-Received: by 2002:a17:903:2ec4:b0:2bd:9b0f:5f2e with SMTP id d9443c01a7336-2c4125593c9mr950285ad.22.1781212070579;
        Thu, 11 Jun 2026 14:07:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 8/9] dmaengine: mv_xor: allocate dummy buffers with dmam_alloc_coherent
Date: Thu, 11 Jun 2026 14:07:20 -0700
Message-ID: <20260611210721.81979-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611210721.81979-1-rosenp@gmail.com>
References: <20260611210721.81979-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11482-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C627675634

Replace the streaming DMA mappings for the dummy interrupt-operation
buffers with coherent allocations.  The embedded char arrays in the
channel struct shared cachelines with other members, so dma_map_single
could corrupt adjacent data during cache maintenance.  These buffers
are never touched by the CPU, so coherent memory is the correct choice.

The old DMA directions were also reversed: dummy_src is read by the
XOR engine (should be DMA_TO_DEVICE) and dummy_dst is written by it
(should be DMA_FROM_DEVICE).  Coherent allocations are semantically
directionless, sidestepping the issue entirely.

With dmam_alloc_coherent managing the lifetime the old dma_unmap_single
calls and the error-path labels in mv_xor_channel_add are no longer
needed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 50 ++++++++++++++------------------------------
 drivers/dma/mv_xor.h |  4 ++--
 2 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0c159b9e9216..255df2dd9c71 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1029,7 +1029,6 @@ mv_chan_xor_self_test(struct mv_xor_chan *mv_chan)
 static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 {
 	struct dma_chan *chan, *_chan;
-	struct device *dev = mv_chan->dmadev.dev;
 
 	mv_chan_mask_interrupts(mv_chan);
 	mv_chan_disable(mv_chan);
@@ -1037,11 +1036,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 
 	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_unmap_single(dev, mv_chan->dummy_src_addr,
-			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
-	dma_unmap_single(dev, mv_chan->dummy_dst_addr,
-			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
-
 	list_for_each_entry_safe(chan, _chan, &mv_chan->dmadev.channels,
 				 device_node) {
 		list_del(&chan->device_node);
@@ -1055,9 +1049,9 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		   struct platform_device *pdev,
 		   int idx, dma_cap_mask_t cap_mask, int irq)
 {
-	int ret = 0;
 	struct mv_xor_chan *mv_chan;
 	struct dma_device *dma_dev;
+	int ret;
 
 	mv_chan = devm_kzalloc(&pdev->dev, sizeof(*mv_chan), GFP_KERNEL);
 	if (!mv_chan)
@@ -1089,19 +1083,18 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/*
 	 * These source and destination dummy buffers are used to implement
 	 * a DMA_INTERRUPT operation as a minimum-sized XOR operation.
-	 * Hence, we only need to map the buffers at initialization-time.
+	 * Hence, we only need to allocate the buffers at initialization-time.
+	 * The XOR engine reads from dummy_src and writes to dummy_dst.
 	 */
-	mv_chan->dummy_src_addr = dma_map_single(dma_dev->dev,
-		mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_src_addr))
+	mv_chan->dummy_src = dmam_alloc_coherent(&pdev->dev, MV_XOR_MIN_BYTE_COUNT,
+						  &mv_chan->dummy_src_addr, GFP_KERNEL);
+	if (!mv_chan->dummy_src)
 		return ERR_PTR(-ENOMEM);
 
-	mv_chan->dummy_dst_addr = dma_map_single(dma_dev->dev,
-		mv_chan->dummy_dst, MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
-	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_dst_addr)) {
-		ret = -ENOMEM;
-		goto err_unmap_src;
-	}
+	mv_chan->dummy_dst = dmam_alloc_coherent(&pdev->dev, MV_XOR_MIN_BYTE_COUNT,
+						  &mv_chan->dummy_dst_addr, GFP_KERNEL);
+	if (!mv_chan->dummy_dst)
+		return ERR_PTR(-ENOMEM);
 
 
 	/* allocate coherent memory for hardware descriptors
@@ -1111,10 +1104,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	mv_chan->dma_desc_pool_virt =
 	  dmam_alloc_attrs(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
 			   GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
-	if (!mv_chan->dma_desc_pool_virt) {
-		ret = -ENOMEM;
-		goto err_unmap_dst;
-	}
+	if (!mv_chan->dma_desc_pool_virt)
+		return ERR_PTR(-ENOMEM);
 
 	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = cap_mask;
@@ -1143,7 +1134,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	ret = devm_request_irq(&pdev->dev, mv_chan->irq, mv_xor_interrupt_handler,
 			  0, dev_name(&pdev->dev), mv_chan);
 	if (ret)
-		goto err_unmap_dst;
+		return ERR_PTR(ret);
 
 	mv_chan_unmask_interrupts(mv_chan);
 
@@ -1158,14 +1149,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		ret = mv_chan_memcpy_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
 		if (ret)
-			goto err_unmap_dst;
+			return ERR_PTR(ret);
 	}
 
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
 		ret = mv_chan_xor_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
 		if (ret)
-			goto err_unmap_dst;
+			return ERR_PTR(ret);
 	}
 
 	dev_info(&pdev->dev, "Marvell XOR (%s): ( %s%s%s)\n",
@@ -1176,18 +1167,9 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
-		goto err_unmap_dst;
+		return ERR_PTR(ret);
 
 	return mv_chan;
-
-err_unmap_dst:
-	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
-			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
-err_unmap_src:
-	dma_unmap_single(dma_dev->dev, mv_chan->dummy_src_addr,
-			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
-
-	return ERR_PTR(ret);
 }
 
 static void
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index c87cefd38a07..666c72e457d6 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -120,8 +120,8 @@ struct mv_xor_chan {
 	int			slots_allocated;
 	struct tasklet_struct	irq_tasklet;
 	int                     op_in_desc;
-	char			dummy_src[MV_XOR_MIN_BYTE_COUNT];
-	char			dummy_dst[MV_XOR_MIN_BYTE_COUNT];
+	void			*dummy_src;
+	void			*dummy_dst;
 	dma_addr_t		dummy_src_addr, dummy_dst_addr;
 	u32                     saved_config_reg, saved_int_mask_reg;
 
-- 
2.54.0


