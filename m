Return-Path: <dmaengine+bounces-2320-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F99013AC
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDC1F21D2C
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 21:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052724B29;
	Sat,  8 Jun 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFDeej58"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AE1B80F;
	Sat,  8 Jun 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717882368; cv=none; b=W3qKbmSViiEgXffLYcw2Bes5fgwoiQ5Jtn3Ej4QRcXfdcUAC40z85qSjIl0OAujBRvqD0g7qfX7cG2lXRpuJ1qA7rdVKfzj5s4+7BEA3f0V0wzzgA9HJbemb6B4gzyYyT8R1biixkt/EQTzFj0LvfLDS4X9m11+xUNyqgT/SM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717882368; c=relaxed/simple;
	bh=SjzAcYcWtfxknYFag5U6s/JvNy4G+mVRyzzStXQixrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1L6yo9RZpeF4tiKX26Vd2s6GLQr+auhmegsz7rLNctoHedOhMpnK+Z/nNqdy9lDJpc46tUUxikvCKodkcBl8c1XgW43+btmiRm6/arTYUv0qQI2CfrxnAD7I2e5YDLpP/CIIf0XjjBpkmjICBe7gEQUMT/OLqbdebkv2YYDVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFDeej58; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35ef92111afso2219313f8f.2;
        Sat, 08 Jun 2024 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717882364; x=1718487164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIfA/ODECV+f+oLK30+MKaz/KyG3cWL0Wm6WLkPADsE=;
        b=fFDeej58+GDuTcTIsweDBbniRp23BlR+iViNShoBLKexL3XDtYTaPWmqr/xv3mPmka
         FPjmQJg+thKMAhWGCcof7U/8At5pusNq+oaZuBIXbip+5fSnNotjSkj/MYfzQMEd34lJ
         qvOSKLel8Vs2+6Yti6CMNgs9Asi8ziOqSVA/+t8+4UOK8jLjMXenziqNviCnkruCKHkm
         ligmenNGLH2owyhSlBxT9ePEUks9AKtjp2dO5qgK4ThP4oLCGwrph2vkYdavD7iclLDL
         hC4hoorWZeglOiqDKBEB61cT/0+FKcslVEwUTFYEeQzbFTpmOGH/Fu3JW5mcITLjcSMF
         GwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717882364; x=1718487164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIfA/ODECV+f+oLK30+MKaz/KyG3cWL0Wm6WLkPADsE=;
        b=p263u7Ni+/WxYJN7elFm79KR9DRR40OGCpe/sPBfk/Fw1QrigwATgfjScJ0JlE/7MU
         DYtYxPKVZmlkiL+Yw7/2sF7ijrI5alGSZHqH1DTT6O/wTi/eRam4DAFoP33N1G+gWaLs
         BMy4UzGFFNF5fBO0MWwxTLcWVfnOu04AhMotO7EiOqkhwyCnLB3cCxgqMB0STzOz6y+H
         9HDMwlpHzBWYxZTUkoR94k5u9wKp//dNuK0P2rV/JaJJgJao7JA6AJ5oT5LfDsYG5AxD
         eqrNzb4rceS3O496qyjQzIcy0de/iQ3DMHtLLSRuqSv5tGT5PKuGjw/wKgKqX72qgR0/
         OdPA==
X-Forwarded-Encrypted: i=1; AJvYcCWI8+M5BMa38Yf2zDY1e2GWAxh+AhnzNWOreyljlFUzAEJNU/dnT2cFNG9mk/PFwiaOZeXG88rNJ2rYfPyWIFTZxNkhEVD0kHOj
X-Gm-Message-State: AOJu0YyMeWoJ6+q7Apcn8w1+RMAlgOIRcjAJ+a8Dr12ijf56jAXRSEBO
	vCTfBP0y6jEo2cHhyVQV/EGHCBRzH8BuP/gAYJJS0ocBiTHAR/K+
X-Google-Smtp-Source: AGHT+IG9LL9kKcLs0kIB6wXpHNriYLuhOvm1Wg5G/KtRnySZCgdKCiu19WqmALtNVrdfLESyjzWqew==
X-Received: by 2002:a5d:5608:0:b0:34c:cca6:3d18 with SMTP id ffacd0b85a97d-35efedf981bmr3778836f8f.68.1717882364408;
        Sat, 08 Jun 2024 14:32:44 -0700 (PDT)
Received: from localhost.localdomain (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f116540d5sm2793247f8f.15.2024.06.08.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 14:32:44 -0700 (PDT)
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Eric Schwarz <eas@sw-optimization.com>,
	Olivier Dautricourt <olivierdautricourt@gmail.com>
Subject: [PATCH v2 2/3] dmaengine: altera-msgdma: cleanup after completing all descriptors
Date: Sat,  8 Jun 2024 23:31:47 +0200
Message-ID: <20240608213216.25087-2-olivierdautricourt@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240608213216.25087-1-olivierdautricourt@gmail.com>
References: <20240608213216.25087-1-olivierdautricourt@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msgdma_chan_desc_cleanup iterates the done list for each completed
descriptor while we need to do it once after all descriptors are
completed.

This fixes a Sparse warning because we first take the lock in
msgdma_tasklet.
- Move locking to msgdma_chan_desc_cleanup.
- Move call to msgdma_chan_desc_cleanup outside of the critical section of
msgdma_tasklet.

Inspired by: commit 16ed0ef3e931 ("dmaengine: zynqmp_dma: cleanup after
                                   completing all descriptors")

Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
Tested-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
Suggested-by: Eric Schwarz <eas@sw-optimization.com>
---
 drivers/dma/altera-msgdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 160a465b06dd..f32453c97dac 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -585,6 +585,8 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 	struct msgdma_sw_desc *desc, *next;
 	unsigned long irqflags;
 
+	spin_lock_irqsave(&mdev->lock, irqflags);
+
 	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
 		struct dmaengine_desc_callback cb;
 
@@ -600,6 +602,8 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 		/* Run any dependencies, then free the descriptor */
 		msgdma_free_descriptor(mdev, desc);
 	}
+
+	spin_unlock_irqrestore(&mdev->lock, irqflags);
 }
 
 /**
@@ -714,10 +718,11 @@ static void msgdma_tasklet(struct tasklet_struct *t)
 		}
 
 		msgdma_complete_descriptor(mdev);
-		msgdma_chan_desc_cleanup(mdev);
 	}
 
 	spin_unlock_irqrestore(&mdev->lock, flags);
+
+	msgdma_chan_desc_cleanup(mdev);
 }
 
 /**
-- 
2.45.0


