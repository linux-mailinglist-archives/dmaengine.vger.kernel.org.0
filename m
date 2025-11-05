Return-Path: <dmaengine+bounces-7062-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC98C37D2F
	for <lists+dmaengine@lfdr.de>; Wed, 05 Nov 2025 22:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 094804E4BA8
	for <lists+dmaengine@lfdr.de>; Wed,  5 Nov 2025 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F66334C989;
	Wed,  5 Nov 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHvEmO8F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143B126C02
	for <dmaengine@vger.kernel.org>; Wed,  5 Nov 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376618; cv=none; b=V5xQWmNdsupd+6z2KE98PL7Yg1hYTa+Ah576v6MUergbv6/S6r5ymftBMdg2oUnRXvptGVGb4LBZ79eHTUiunZe2ozgmFWEqoggkXdQO/kLgKD64j0fyiio3lbzW/Aw2SzY2Jb76Ha2qYqi1SyGe9AEV6c01Zoyn5Obbn14WyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376618; c=relaxed/simple;
	bh=dZxbC32mzy/JF02DKZ2snFfIWQ/TTrnP2h3YmTHbL8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/NOebW4rt+tJBWklzLZPys9s4nDcGKJMC4HdgrFZb1iNBo9O+NJsYrSkqUg06rqnNR/m5RaEoIcBEdl/rfwTIz68EF6cGmhHCKRPtqDCfFfS0Eg9E6tvyHAZVf6njoG6+wYA7TDPI4ZNENbDv58c+cJoySYl7OAqRLRrPwdnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHvEmO8F; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-341c68c953bso425021a91.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762376616; x=1762981416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvK6qvFSDKA15whyYqvYMfPkmiZehgHvoYJ0yEG/DmU=;
        b=UHvEmO8FDqslTM//zGwzpVTHnVnIzwxC8pLjsFNJOzG1VNAiDeY2i1v3/wuLwj5Ku6
         s1pckZZIMwLJDpoCWYIiHl1OXgI33stdCpx455K5AaYyuyE2Q59gBJQ3Y0EVzeXVirGt
         llQI/Q/ZFGNNhHFY1TuDBgnrIEPSVssWEaZ+H5NacwaEH9Cv9eRzq/lsPzK7uXt/rye9
         NZjCRgg4D8AKpCHVBm74SQDY1T8t2k7GE6DwzKTDSSvINYJPKTBZc75OFReHXubHW/fm
         jaqo1PYk8qIYhuahbxDhnSMPT3DABDQEMbV3H2qZyd3Onw6B3i31+IHnLIlYFfRPtYqa
         2opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376616; x=1762981416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvK6qvFSDKA15whyYqvYMfPkmiZehgHvoYJ0yEG/DmU=;
        b=w1RDXe7G/OKNYBDDpVamN8V2r8wE+mk9+A3QK2B86EzYD7NGfcF1Yn3A5avpeDQEo4
         S30f3Ab/I9zha5w/LHZAmz7m1lpxMxCFi5YetTzz9eZZdO1c5cPmS4z1K6fC1sIBXaUB
         9BTFX/DSXNmMtz00uO+183DUF66Jo9G/m4UyGMsM8ci4nKIBuZFxe1o2eCYxQNGY7Owo
         MbN/tZsV7vN5p57smk2tjlT4insoAl25u+oDgEgxz92cvR+711VcVbqCqAoaYdn5TMgw
         oEKLr7QlBo2SGMoSVJLPpTKi7Yfgk6tarVP9ZRbuxq7wiBj4mn5DJTtugRUSF1+VGr+P
         kpcw==
X-Gm-Message-State: AOJu0Yyh3vI4wMJtGS2x0F8ZW8SaY6qUKp5mu4z9ikTjG0zqzkCNQRkK
	FzMW6AVD8315R+2J8e0gfhjpppViVGiwJ5NRRSn3tjuLSwXRV85WSUy9fbx98Q==
X-Gm-Gg: ASbGncsCHKTNgbAuSwrYQyXzq70teREJfhNSFmuO7/69crynowTJMZC9MhVmBoH9GfJ
	x3X3sifTRsvrpV2bcxwp8OJpAG4cNssMREjpqeVyT9LtY7DfO/X9Y8WAYhNYVubZxpg/0R1XLD4
	rQhoS7v9vwH0jPPGTvowhBC8Mp6Gf7+BaK35GYQ1vCRgURzvsGS1VYwZYnwLOCYjJcErovrLaAp
	0dIhQobYYgGb9wCVSVvKDoXfoAVVo4xK/sWFNJwc/7WQCvKNbpqzO+ijpJYPbzkuscNqXs+7Hgf
	Z+CoudUKOkpqqstVlDdRV48HVyHFO+cRTlfWNIzKjn6k4B9IXFS6a/ot67Z2rzcnK8HDakx0rbA
	SQpnsDeK7d19jVQASoIVRvXoEevzAyFH9+N2JHJI1IZJNcGX6/FGxCprxzg==
X-Google-Smtp-Source: AGHT+IHOziVsZSS5XJszgFIOI3dDfa90KKWH3MYFTR2nMejbJeWj2BTL5+TWVQ9T3SiGEY66XetT7g==
X-Received: by 2002:a17:90b:5847:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-341a6dcc6admr4852945a91.23.1762376616023;
        Wed, 05 Nov 2025 13:03:36 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d125c93fsm13626a91.14.2025.11.05.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:03:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 dmaengine 1/2] dmaengine: mv_xor: use devm_platform_ioremap_resource
Date: Wed,  5 Nov 2025 13:03:16 -0800
Message-ID: <20251105210317.18215-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105210317.18215-1-rosenp@gmail.com>
References: <20251105210317.18215-1-rosenp@gmail.com>
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
2.51.2


