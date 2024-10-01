Return-Path: <dmaengine+bounces-3257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC998C7D9
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5A1F23EF2
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470151CF288;
	Tue,  1 Oct 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inB9y5QX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0B1CEE89;
	Tue,  1 Oct 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819953; cv=none; b=qgtePtfbKjhWg6/KdNSh9eO+AH6H9n2OCdgqghBP9VtUua17ozZVZvt9/1OAVSpdzNp28oyTGq2rDHxfbbgVKLQCgC4jR9oYueNH+6DlTtS55/yZWed2m3C48nEfP+VU2IrxNRfdlm5sKL/zSUSI+juuoCgG1/PlAlgOeoAkT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819953; c=relaxed/simple;
	bh=LkItG/XM2lPcbiYc9wOuFAj95UjQCOY/auMtrslpOY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je8oAtJx+52J97BprG9JgPvGDBOGVKDJQYfndWjBZdh6DVlqsFfT82OEQOhnUX/JCXEdbBAgG65UlPpkncBeMyoCIcwmuSpJqcQLMKEZ4AW35dcjHyLzTI9RpAQrkC8hxITuNxHh2B0GDeitiZq00Ymu4gGEs4+jH6JmM9LfeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inB9y5QX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso5154465a12.3;
        Tue, 01 Oct 2024 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727819951; x=1728424751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDUmlBvkzd45Lb0kE8W4n/5dpJsPmG0u2wmjx5yqbQQ=;
        b=inB9y5QXDLahvAKlZlEG1Lyi9KG7Ygjr9Co7ziAs3SNQtJtGVFS+tAyeRZTjIOcbBy
         KZaHHHC36b2Jgf2CInfZHgkB1F7BsYexLcTxizyJ7suWiFVZFaP1SlYKGwOnV6jUak8A
         kg6JacqHqJlOVZ2NI/9xZ3XL7ZWiehUcQM3XIu+CqA9vV5jHV9R7llFXyhzrfg551F6d
         9T/l6vsRm8F7G8zVZe8LUqisbSgUTRA33Nu6ko3HI9lQe5B/I7Rdn7bzzzwCU46YQUpC
         h/9YcMHPGtyvjNMaHBlt7N42u+j58Bg5W+4sjgDRK1sBcRAvW42qZk4OyxzGRSUnlwtj
         77LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819951; x=1728424751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDUmlBvkzd45Lb0kE8W4n/5dpJsPmG0u2wmjx5yqbQQ=;
        b=Vp/72nB8unJOcbRohnbyAVYwJR9xZPKgMTCowpg/JovGCuulGPqodzWOaKCHcaRZCt
         1xrOmCFb1bPIBsNqtpE2EwELp8giEB568yYV+DH0a9eH8voKbdZjL/ChnSRLb5IVH4Et
         ypDxZkUOi97NVWuTDiIIXGoIlTzbwfMh8EJZHFSrhQOekar3DpmuRMVZTXxtRPkwd4uW
         3+fDz+ahaC1/e79qnqKDBV2nf/wZBBKlayGiJQpmc2RF2qrhhyJCKYyV+zRdg9bkz1sX
         m1xxaNqtEoXBVHzzM5mvRiGGiQIoEU17jMVVwYrDvq+/2ZvOWWsjW7lRssWKTWYP+09y
         S9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbTly3qAqTVH4BINr/2ctOT2JKXphJTIi8ZCRcQ79+epyEeRIdjTfSmz+mJZn6zpuPfBKdeezVpRKdFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTr+0KupBzUvUVjS0vplxNQ1iqlml155TZdh/CpglOwRM2D6n
	lRMCwC+TrtiUnDBkRp6toTPMQMnqb35Oz2QZs9j4oBxA1BnXknxw7qSlGDSD
X-Google-Smtp-Source: AGHT+IHjtg7fH1kJgK/bPu9LnMjn4rLIwOCsVQ7TuJLmUrSlmPmtimjQo+lRK7OnIKTnuiIbhU4CpQ==
X-Received: by 2002:a05:6a20:c6cd:b0:1d5:1604:65e5 with SMTP id adf61e73a8af0-1d5e2d2f303mr1421339637.40.1727819951052;
        Tue, 01 Oct 2024 14:59:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651630esm8599162b3a.109.2024.10.01.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:59:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] dma: mv_xor: use devm for request_irq
Date: Tue,  1 Oct 2024 14:59:05 -0700
Message-ID: <20241001215905.316366-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001215905.316366-1-rosenp@gmail.com>
References: <20241001215905.316366-1-rosenp@gmail.com>
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
index 54e3c24d1666..3a0044bff993 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1025,8 +1025,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 		list_del(&chan->device_node);
 	}
 
-	free_irq(mv_chan->irq, mv_chan);
-
 	return 0;
 }
 
@@ -1102,8 +1100,9 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
 
-	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
-			  0, dev_name(&pdev->dev), mv_chan);
+	ret = devm_request_irq(&pdev->dev, mv_chan->irq,
+			       mv_xor_interrupt_handler, 0,
+			       dev_name(&pdev->dev), mv_chan);
 	if (ret)
 		goto err_free_dma;
 
@@ -1128,14 +1127,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
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
@@ -1146,12 +1145,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
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
@@ -1382,7 +1379,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 						  cap_mask, irq);
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
-				irq_dispose_mapping(irq);
 				goto err_channel_add;
 			}
 
@@ -1417,11 +1413,8 @@ static int mv_xor_probe(struct platform_device *pdev)
 
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
2.46.2


