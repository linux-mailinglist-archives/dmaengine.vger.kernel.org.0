Return-Path: <dmaengine+bounces-6094-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3DB2EC48
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 05:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1655C372F
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 03:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2FC2E88B4;
	Thu, 21 Aug 2025 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neGSrA/P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AF2E7F11;
	Thu, 21 Aug 2025 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747931; cv=none; b=hKzPfBLKKtXEkoXzLwN0dmeQmdVeFFs9l5Jl93ZkArugY+eiylj5biONE/3YcnUvaVkWLdFSUeGMnCjbjU68vBqIHYaDrOlp5YKzu6rIjC3CtO88OJXHMJFQQ2EENjwfMrzqQD/d3qKgvDkCLXlbx+XFQA2VJN40gvAO2ah+Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747931; c=relaxed/simple;
	bh=duHJrcuN+a6VGbHHRUXM6AyyXv7mjDeSL3MEGJah8SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqDVZcprFzUCMsn9NJQc0+EZ/4kmZWjjvRLpnU8UcidQgzNb6jGFHWvxgwAK+BhWKRcJZEy2VTl8PUcCWiQ42id6ztZnFf78iKxjRir+NpUuGCCBnyN21DHknzZaTXVruldCRsPUYdHRq/3pzSzL2SY8YNL7hSiLb+kJuAYe8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neGSrA/P; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso495837a91.1;
        Wed, 20 Aug 2025 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747929; x=1756352729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crrUsFCfq3k63xR/frZMkp0dE+IOgUMhJSDZs9vTaEM=;
        b=neGSrA/PATE+pnnl/y7b8YnjW7f5v/BC7wicIxyGDkK4gb2Al13yeB//n4VHqSDSHd
         Bqg4Fl4VjKmXksjew/yoamnmCVyLc7IsGWtQHYRhAeyj3Vasc2yC4p7JKwq3RhSno+Yz
         SXqmNZk6c7Hf3O8PtqopQrk6Nefdtobj8wOYzm34sh8t2ChFzSWQteDxjliiRglQpSLl
         Zv1CVh98so/V6Xs6sz9yE9NRcGoSYrV8BAXrVFDWlyH6/8NhV+blwQZaB+O+iS1KVmx/
         Dg9dMcNdNZmrYwBtvyeJa7uwwsHX4H2BX9M4goDemMvvqgCwCBf2ks10QHv0RWcOzPXr
         9WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747929; x=1756352729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crrUsFCfq3k63xR/frZMkp0dE+IOgUMhJSDZs9vTaEM=;
        b=JyTfUAqY0UM492gM+djASpHxR3uFyfwAUplnvM1NvtYzyJxqBgnqJwnPcpk3ypfB3P
         LpAFLrGyeQ/DKGEnoyjgEdsVIc29q1Qm8acY2XAlK9NAi8Cq0kXYJnp9nLyU4gaQEjpG
         CSW4Zx6rtgbG4QHD8rWFkVN1f3hv+PvGWJElkEacrAeEaBKwGd+HLsloKouSeRq1Hdnv
         K3MjFNu+Ld8b2JHk1OOvM+/6X+uF8SGdBhn4upGxErujO5OzQVJtnNiKdWuaO83khNSf
         WKRL57Ne60wCTwMEYnPgUfQb7/1Wmi5G/ae2GWDZJPeQss9THp2KTHWMUUDcYtZweDC3
         Pn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7AzCZ7OPSeBJf1b0FwIdCOt3ywAn9Ke8K8Yn6zKaZHi/sRrAs/NhmqQc+FNaBJKgHTvR2g8a/mOhIA5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSo9KKxPXb3lrOwCZ3p4QYRY71mpWI8GqfQ0tn3oG8Tk/ZRtAk
	HWq4FnTFAQy09mIZZB4zqSN3eYnsiscnnp+HSOGb8Dqfrx1bOQyG+CSOFStamA==
X-Gm-Gg: ASbGncu+GWpq3LLcEbL0/yTOZFDmt+EtA02Hem5MPxHzwB4OdhkZuVDpLgOB0u5N1Rj
	P0Jf7YGw+LmgXg2MQMxp+1BJrmluBGoMyf1eslbS+isjEj01dUY1HEpPz4MXtDSRCFiBeesm15I
	iqvUifRqE/MfNoP4ZOTf0LMApJJFnR464wSdVjzvMQquNDpTxW2BAP6c7DtgfCYfVH4WjYOquds
	S2wtIoSQ0HNk2+ilAUYiF0V2YazwxAaevEPrk4/1KDyq79Tpfb29Fq0VbDR3Nxl/sBUq++1BuQF
	lBuwfq8VmlykrV2CVUz9IdpqQsg7ZWJNZ1GBo7pv2a4MstZTP/rcloK/id6DX2e5yOC4WgaUM4Q
	J5Esb
X-Google-Smtp-Source: AGHT+IHsDt928GDuTpULjuqdN4JrTIOvzBlZyIvUuOn1oUNZJCHPP0ghkkaFnemIKVtwYzrvotnhEg==
X-Received: by 2002:a17:90b:3d08:b0:321:c37e:e325 with SMTP id 98e67ed59e1d1-324ed0f1999mr1656032a91.12.1755747929361;
        Wed, 20 Aug 2025 20:45:29 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2402c9asm504932a91.11.2025.08.20.20.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:45:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/3] dmaengine: mv_xor: use devm for request_irq
Date: Wed, 20 Aug 2025 20:45:25 -0700
Message-ID: <20250821034525.642664-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821034525.642664-1-rosenp@gmail.com>
References: <20250821034525.642664-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is only called in _probe. Removes the need to manually free_irq.

Same with irq_dispose_mapping.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 8f0c3bfc60cb..18ddbff38abc 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1025,8 +1025,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 		list_del(&chan->device_node);
 	}
 
-	free_irq(mv_chan->irq, mv_chan);
-
 	return 0;
 }
 
@@ -1112,8 +1110,9 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
 
-	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
-			  0, dev_name(&pdev->dev), mv_chan);
+	ret = devm_request_irq(&pdev->dev, mv_chan->irq,
+			       mv_xor_interrupt_handler, 0,
+			       dev_name(&pdev->dev), mv_chan);
 	if (ret)
 		goto err_free_dma;
 
@@ -1138,14 +1137,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		ret = mv_chan_memcpy_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
 		if (ret)
-			goto err_free_irq;
+			goto err_free_dma;
 	}
 
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
 		ret = mv_chan_xor_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
 		if (ret)
-			goto err_free_irq;
+			goto err_free_dma;
 	}
 
 	dev_info(&pdev->dev, "Marvell XOR (%s): ( %s%s%s)\n",
@@ -1156,12 +1155,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_dma;
 
 	return mv_chan;
 
-err_free_irq:
-	free_irq(mv_chan->irq, mv_chan);
 err_free_dma:
 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
@@ -1398,7 +1395,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 						  cap_mask, irq);
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
-				irq_dispose_mapping(irq);
 				goto err_channel_add;
 			}
 
@@ -1433,11 +1429,8 @@ static int mv_xor_probe(struct platform_device *pdev)
 
 err_channel_add:
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
-		if (xordev->channels[i]) {
+		if (xordev->channels[i])
 			mv_xor_channel_remove(xordev->channels[i]);
-			if (pdev->dev.of_node)
-				irq_dispose_mapping(xordev->channels[i]->irq);
-		}
 
 	return ret;
 }
-- 
2.50.1


