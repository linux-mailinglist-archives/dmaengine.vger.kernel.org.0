Return-Path: <dmaengine+bounces-3255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B998C7D5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 23:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CCD1C2323A
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD21CEE99;
	Tue,  1 Oct 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn4/KlDj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D1199FCE;
	Tue,  1 Oct 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819952; cv=none; b=A0+V8Ipeyj/JGXK/oStsQ+hR1WiaiIINhX5jC6WP831TbEvyEvKtzoN1yYABNuOIR09Gqg4JB6RbS66G4eAWEkxI72BLCv7Ga5GYBDNsS0MI/JgYI+OHkmQ7TzMnNJFoIXnjc9rLUWMtuAwtrlfeYRvszGHnbOpsGigxo6df+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819952; c=relaxed/simple;
	bh=2yyuriHHBr8R1O+VhUXk20J6rf9QrtERM8c8NCXhQe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4IVFucBLChhpvesfMgjTuksEiNupvcRHnYvcIcdij25lpUm1Iuf1jaaUChHCKJ4MbrVkmBUeIIeTQ3tkWAaZLwLp9JZxYEun94v/x4batd3hWmVvITRnCAq7oHHRERRWvjZn7LAlJfye+0TMz9LY97rLYJKT7jCRDHRDnFCGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn4/KlDj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71b070ff24dso5373417b3a.2;
        Tue, 01 Oct 2024 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727819950; x=1728424750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ7T8K/Tnf00Kp9c09l+WJdESYIb4iZRlfJCkyHiL0U=;
        b=fn4/KlDjsX3bDVhkpyMOwzU/nvAln7ipa+yXgA0P2P5WV3eSrXk89CTf1X5B2vaO8x
         fHDZXnI4B3VWHOueLfHOzaLR1Vc6D99gBTcE8WaYAas31VTjpQQbPtTgy4wdmnu5sp7M
         FokWfhodDnWi9LA+YR6f2PZ0cO6rTjTGDW/ZPwiYyDvGOWZOklaj+aHp4kPOJfxGTEpz
         +qR7slJ56mo8ggo8U8TBsbcch50p49STGLURYuIVhy9t9y9kCjSy6oynb8GnkbQi4l5G
         itlmlZ06XTWYfmd0PMKgORvuzBax4ZlGEp/TxQH4TOC1Q80/EOF1nseVLVt1/DD02dtR
         APIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819950; x=1728424750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ7T8K/Tnf00Kp9c09l+WJdESYIb4iZRlfJCkyHiL0U=;
        b=DsDYI7FcyZ+r7/DToQVbHhrFkwEQU0jyrbAAANaoWYa4dQi8c0BFBiw0jrBgRUjFna
         lAcHB7EvmYo5XsWX5gaBsau9TI3GyYaQ6S6g3EmMn699ndsHxExXjnSm7MGjTj4T5rPs
         +uXahI3P9VHcxmv2ajZZpujCxEQywl13bv/AN6Px9U5M9xxeBNqQ5IgwMMSN5V2VqRmo
         Ipr1eAtLjut/2RdVOvb7E1Nx72/9XOyfMSdxCABmw4EMZzS+2XgjHvfV3yLeTYEsHjqS
         fDYjKxa8RankDRmJkbxAPygfLMNjSZ+kxyT81VoB7thplIGtO38iqJZZgvII7+48bMjf
         zHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3iqfUQfxHGQaBli5aPWV0Wz6Rb5KC7MPiBraaPtqGvxLq4QT4C9qBAn3E328zLGrLJaP5OfSdnuQD5SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnI00bPKbRFVNJu/sSXdmBrUrZHx8wmEFsCcx6cjAJ6gMjtR5i
	+RAwYO1cOEJ9jpJcZ1xLHKdLtmGcRpO5JXbIE+tff72j3KrrNYN+eOTeIKL9
X-Google-Smtp-Source: AGHT+IGvBidk1lwQH9zAG51b4sJ21kemnAFmecLuPAwC6AyZ6QZq/HgzNkCl/QaPQ+Hur+Qj577oxQ==
X-Received: by 2002:a05:6a00:1783:b0:713:f127:ad5f with SMTP id d2e1a72fcca58-71dc5d59a5fmr1899371b3a.22.1727819949943;
        Tue, 01 Oct 2024 14:59:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651630esm8599162b3a.109.2024.10.01.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:59:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] dma: mv_xor: use devm_clk_get_optional_enabled
Date: Tue,  1 Oct 2024 14:59:04 -0700
Message-ID: <20241001215905.316366-3-rosenp@gmail.com>
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

Driver was written before this was available. Simplifies code slightly.

Actually also a bugfix. clk_disable_unprepare is missing in _remove,
which is also missing.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 9355ee84db25..54e3c24d1666 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1334,9 +1334,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 	/* Not all platforms can gate the clock, so it is not
 	 * an error if the clock does not exists.
 	 */
-	xordev->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(xordev->clk))
-		clk_prepare_enable(xordev->clk);
+	xordev->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 
 	/*
 	 * We don't want to have more than one channel per CPU in
@@ -1425,11 +1423,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 				irq_dispose_mapping(xordev->channels[i]->irq);
 		}
 
-	if (!IS_ERR(xordev->clk)) {
-		clk_disable_unprepare(xordev->clk);
-		clk_put(xordev->clk);
-	}
-
 	return ret;
 }
 
-- 
2.46.2


