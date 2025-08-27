Return-Path: <dmaengine+bounces-6232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BCDB38BE2
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326B51C22C1A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0E236454;
	Wed, 27 Aug 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBBidJS5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190042D481D;
	Wed, 27 Aug 2025 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332010; cv=none; b=ZFa4yhTQCb5VVZ2OX7yrIQpSvx8ZnwxyLni1FibVdpYJmXQj9yuclUlbp86TtBzZlF5pBogWkJYVCBSE2sBytjd3fXFTlPNimPk+yznyS6SN22dsukzUijT0gZESJ8GjiPsFS4gPTc/Vow+HmF8Cqfyi9H1NVzScg1pASF/iaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332010; c=relaxed/simple;
	bh=uqpDtgYEsH/2teiN26HjR0864oP2Dn+Pu3LOHffYlZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI4Fn9LIQO/UMxpSGZy9iF/CoQ0bZ9p9sWU1fEiJGtbjex8WOaPHe9GpZ/DHkeWX8TNEGBwkBaiYgTWPXMWWUB3mqoTi3jJ8i7oou5hMu7D8QnuhaRUd1ZzbKtyEoAbsQfwj/xziQUOTSFMi0WhUSQOyGY1ZJ2w4fy8cerZW5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBBidJS5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77057c4d88bso357686b3a.2;
        Wed, 27 Aug 2025 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756332008; x=1756936808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azT5/Oxy5nI5gMRz7mftyiFsz2F/SySsnSiyz7a6cX4=;
        b=ZBBidJS5G0SVbYfzW1Hl/7/Z/uxedeSGxzifFZhT0iDzlU7t9kXCUuSgJwDRirZlR4
         l73n72vF4emrm0yObKV7/kcqp3KE3qFrK9BVhdhqFd5P2SuI4HgGNKrWDyURISO/QPTs
         HV3topPi3mBFLxJgltb6XiVHdm1rPrPu0JABid+Z6hnIaafWfYSB+VLELLaZfd3yBA7M
         sfVOMcaO64/X+sCRpfgH9ERhMVU0ELqTjdqkkuCAcGFhg3N/6oPawP+zeqI2vpiGvV0M
         5FBAgWwLZ0SGxA/QqbkCjb0aaH2URTPSSyJdKb+MySmRdzt7lqaXZW8wOaZdncnohMAc
         hddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332008; x=1756936808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azT5/Oxy5nI5gMRz7mftyiFsz2F/SySsnSiyz7a6cX4=;
        b=i7NLe/mEc8mJF+MFKKHdQ7uPGfP19kCpiFDN2PJ7pVlA/shARY8wZANWoaZKW48+NG
         ghwXSXisz46NgcFeBWlYonufiiFxePH1yo9F7BNcbXJRx7QywTcp9dozfEtmvxpazoyv
         C/plurnTIcaWTfU6Uj/6aUfo74AyqSrNwX3kHPgpexyIiE9YL34Iydh+aPzVJJqq/G0v
         +U5g7+ex/UmziCsPIcDwgLLUQtlQ3I0YF1fH/JR/bVFYf7hVBW8heiTcVMIjLh2AhNFu
         /wpNqO7noghBvOJ2LQp49EoxDd1gPJDlI9BfYqXZ33Lt6rYrKPYZ7bZGzB/nOYn6SXgk
         V8gA==
X-Forwarded-Encrypted: i=1; AJvYcCVp0ObXaQtb6VpbnvJjfARrhzesmYnEcdAKTcxIQaGOJKVoDW010Y7gzOOMsL5v4sEVg08RN/a+UYAmYr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHtYycpfEYaTnqqoY/J9CekHeUTkqlNUC3dpJiISw1oNfm6Rn
	ZNHUAdeDq/ICV76NmK9WNYPLymqYrhfrFcBJ/KSPeQVjwLvWCYeaG04DNPSSaA==
X-Gm-Gg: ASbGncuKfjy3xC7whfSsWB+vyRn/jXUMI38W6oL9Evpun93zjvBa+MD7xbxMWYNvNWX
	pzFq1Z7spuDqmEyyHLDsYuf56afC9aPKZk8+LswRxRsXdBkHejYIlNOF8pb9IkxBw7kc0P7lrLN
	PIttECGKLZSuOTcrpVmSnTghf+broi/cGK8E12wX5SO3yy0vmkMbFtIGe9vS0py/QdU165fuocu
	Rwq9xjBxm9FnzGTRso5/l0pOCV1c75YlwJFU8rWiciEc8amG1571S6/nkqiJ8sru8x3FPFpX1Dx
	BiHsZk/g12+ti78tXkBoHnw7BMU72mrrz7rcikI7bKCyJgQ0H/2nal0tquttGYWrHU9c9h6Q4BJ
	AybAtTNzXwX1HISC+IAmV5V1EIcySbFHObwNHGyu4EtJdoVmu0cZiD83Jl+VxbOq0Kw==
X-Google-Smtp-Source: AGHT+IEQRThp7GAmIznOv/UYVBsPTlJTmslelWrkx9sKxgT+03gMoMvwkdEtOtQvtV80/gOp3Dn3Rg==
X-Received: by 2002:a05:6a21:328c:b0:243:a5be:c4a8 with SMTP id adf61e73a8af0-243a5bec653mr3165617637.22.1756332008058;
        Wed, 27 Aug 2025 15:00:08 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7bf2dsm12389128a12.31.2025.08.27.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:00:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 1/3] dmaengine: mv_xor: use devm_platform_ioremap_resource
Date: Wed, 27 Aug 2025 15:00:03 -0700
Message-ID: <20250827220005.82899-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827220005.82899-1-rosenp@gmail.com>
References: <20250827220005.82899-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies probe slightly by removing explicit struct resource pointers
and platform_get_resource calls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 5e8386296046..3597ad8d1220 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1309,7 +1309,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *res;
 	unsigned int max_engines, max_channels;
 	int i, ret;
 
@@ -1319,23 +1318,13 @@ static int mv_xor_probe(struct platform_device *pdev)
 	if (!xordev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	xordev->xor_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xordev->xor_base))
+		return PTR_ERR(xordev->xor_base);
 
-	xordev->xor_base = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!xordev->xor_base)
-		return -EBUSY;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
-
-	xordev->xor_high_base = devm_ioremap(&pdev->dev, res->start,
-					     resource_size(res));
-	if (!xordev->xor_high_base)
-		return -EBUSY;
+	xordev->xor_high_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(xordev->xor_high_base))
+		return PTR_ERR(xordev->xor_high_base);
 
 	platform_set_drvdata(pdev, xordev);
 
-- 
2.51.0


