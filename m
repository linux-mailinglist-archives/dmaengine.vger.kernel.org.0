Return-Path: <dmaengine+bounces-3256-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525C98C7D6
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 23:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4BC2854DB
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227A1CEEA2;
	Tue,  1 Oct 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ50fI06"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F021CEAD9;
	Tue,  1 Oct 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819952; cv=none; b=ICIOBDVj3Yb/19d98/4OtCTF6QJfUCBv6xjLHr3BBQpa2om2dHcDyYa6a0bAiRrCVM2Jsftj6DWfgBrI7ADtzPeJ+zCXuV1OyttcRyiVcAQ7MjBkB3Q21kEjko9VEnRYKuyn/FmbqAlrKQAYKp7UWzcTSbiAaIRFPAjscOsVREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819952; c=relaxed/simple;
	bh=wT54DUM23cRMFJbX1OGPnpPeFFp4V54AWUcEawGvmAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0QsH/wJxdL7482kM2c3hlpN/YglFJ+675oFXpeYAnBTn3EFJgzn4ztzvLWJNd3VIW8lre6LSPtO5Qh5JSQkTEuiCodxqLuiLhBrK5EC6yevQQDCtX3lBo3YIKfjhL8zpm6aP8STINiaXxndIKR2hAaT4d7icyRPKZpeSArxzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ50fI06; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6b738acd5so2348467a12.0;
        Tue, 01 Oct 2024 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727819949; x=1728424749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvY980vGnSj9GOPHk6OH7hxmhi/61lkBJqdX69NjbjA=;
        b=nQ50fI0663f7gXgAyJc9eSLEn2GKw6lBjNHZ9d6EC6+Fn42zWjzWiAyIXKDqQ4Y0HF
         88oDFUHRIYz/73Frg8Rk+zI66V+zDYppGLB7lAeo2GwRljjD/4WXGc8dIsMGNzY1D7rV
         WDZaixQs0xQsoR9CGOm5FxOacYkllLMfnuSgK3C5/PFiVLrbwHv43rDtWzZGy0uOLmOH
         WtGH8eQBq/xsSGlrKJoSekan4O4aq+/GHiKM9mZs5+SWum8ECUrIMX3gnvA/TDX/wqG1
         k+5CqZP5JszJy9GfdFTG38rqS4jezhtDducRpd+ZEan3SUvlbHbKZLjeWCwcrnYOFpNs
         /mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819949; x=1728424749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvY980vGnSj9GOPHk6OH7hxmhi/61lkBJqdX69NjbjA=;
        b=u6jPnQCw4Z+9CBvif0A9ZEjajczDBVSibFdh+xSBoIL1AAOM4lwBuNsjtmzwKq0z/t
         0V7nN13pMIGH1KoJNaI9TMVLfEne8hNuytb6o1w8xtsoIisE1et73NfwHHXThYU8HxrC
         QC03bwlzFv6M6wl9lKIjumiqihPVHn/v7vFvfCMlGK+xtHn+3KcZBLugt2uNeBvYOv4b
         VHJXZKG2uDu4RHApO6ibyZ7B+F6zjXv95XK2/DtNWYYtsIwENhw9WNOgFS2vD4/azrpQ
         2pQe2VyjAdD9hHvtHQLkEoEm9Nt2Cq7H19zMCxSfABlsAp6aUtveWnKQwOb7VkhHAu1A
         ZW2g==
X-Forwarded-Encrypted: i=1; AJvYcCV51eGTZRFqi4JihmL/4S9uiSox9/79ahpg/3gaABigBhSsPhVBA6c1aGY6SPH0n7mZofWQ5assPRN02oE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywibb3p2kyrya/uGG9u3VZWWCqDhKWTpL81vBXV2QSA5RCDP9Wd
	q3jDGyGZtYeH/C7g+LXd4sgaBd9r9yr/qySViNNfatRB8b9OSEiR1qvx/UKb
X-Google-Smtp-Source: AGHT+IHkU8nhPQ+TFNULmiYdDh5HrllZsYtSC9ULkaNxB8JESq1R3QjY8mq15+E+3f2IgBphhqRqsg==
X-Received: by 2002:a05:6a21:1646:b0:1cf:ff65:22f4 with SMTP id adf61e73a8af0-1d5e2d0217amr1199319637.41.1727819948966;
        Tue, 01 Oct 2024 14:59:08 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651630esm8599162b3a.109.2024.10.01.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:59:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] dma: mv_xor: use devm_platform_ioremap_resource
Date: Tue,  1 Oct 2024 14:59:03 -0700
Message-ID: <20241001215905.316366-2-rosenp@gmail.com>
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

Simplifies probe slightly by removing explicit struct resource pointers
and platform_get_resource calls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 43efce77bb57..9355ee84db25 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1292,7 +1292,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *res;
 	unsigned int max_engines, max_channels;
 	int i, ret;
 
@@ -1302,23 +1301,13 @@ static int mv_xor_probe(struct platform_device *pdev)
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
2.46.2


