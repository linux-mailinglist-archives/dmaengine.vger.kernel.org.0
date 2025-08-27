Return-Path: <dmaengine+bounces-6233-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22155B38BE4
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 00:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF06E203A9C
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFB2080C8;
	Wed, 27 Aug 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAhCzDM1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EA2DA746;
	Wed, 27 Aug 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332011; cv=none; b=FNVSqu/xQBms+/oJGC03wlyQl5rDW9SOxfr4YgUWHUF0qlXw1BGoDz7i5hdiAi2smLleXWorgngGQ7L4+fxonhaVJbE28X4jlzpXoemP8Y/VoDzTUvtM6lC4rfTDTHcjTvsK0G6b+ZlrVzByxGUBjnFhyN8OEkvNU0rMaiiowKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332011; c=relaxed/simple;
	bh=A8WjhC3DiGRPvZ4pZueH9qgpb6iZD/fWWPlcc96PZiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdpiaHO0YwFgbHZ71QzEX59bWttfVOMsoKfR7Yg0be8JpnPXK7lAsGF4E8LOEsSVk8++kZGCJ8jMAMENjozagr3mnaRdV5Iwnwo2nOtjIrf7b61i9DFSWkPXhEl+n+6mKp1NUlGYBv/M4kX9GL0LdyYRO7TWbFW1chL9S9ZwnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAhCzDM1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77201f3d389so380597b3a.2;
        Wed, 27 Aug 2025 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756332009; x=1756936809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f/5fComQOV6WzBxL6f+7JPmlog+dx/PN5RQ28Vh8mo=;
        b=ZAhCzDM1TCwL0W1KxlJw9AmI3Oq1+dabPLaaeT/kBj767Y/UnEYERK2+8isPUnFRg6
         7LJX19HQYTk0OkZDQA0ONAVcxu7yRRHsgZuWkeus43KdpUPdkWDgWCTferO1hLbF1Uiw
         jCGSDOQbyIIuvjQprqgz3JqnnjQr7N8K0akqe49CtaOC7B4COela05WiEAjBHFIHKl8y
         rF6++4nly88u+XZ7lj/VNBjBVvIps5eeA4zccI8fyXaD6sAQNMP24rR+YONCkpoJnd6X
         NrdAGGwmURLzVFUJWLhSPm8xaD4BWSyKcF1mxVFPIYxSwhWhnJX2UxxkYQ3qk8Vz5Im5
         B6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332009; x=1756936809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f/5fComQOV6WzBxL6f+7JPmlog+dx/PN5RQ28Vh8mo=;
        b=BobSzt/3a662dxeMW9nljHol4vDqB3t4N7ewS6QwsQ4Tu0cdazvgxsUyew6+IMJd/J
         CT7EHPnGvFvlUtRBYSfKfqc58Lg0WXhISvMk2xYiJQ2L+Hwu5Je1ghOnryHyJIairhy/
         gxZZSU+HKzZQDGky3McPsDzx1SAq1fAADJEeH2SrhtdqyHQ5YcPZ7uBb76/Sc76hsyjp
         0u8iBXEpnCQ2iLwJR9r1kiCUfcRIL8SK8Wp5Fu196bPNk8nPxjasNQQ6kP2fvxclEX2+
         CpMd2kfswmzAfIMTw3oRsXOT+WTZMwkIq2nze0XU8b+rq24wALNWpaUUsrncoEcjWNqI
         bF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9RrcIlNpHi1plUbvEWymz2PGfTvPlhAB8cQT8nr9/7Uhjzk8ZmKdAfVtEwBh8N/AfMl9rTVhXr5ZPEJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzerCgBpMC8O3i6/CeWz1ZoMQopBBVllOoa6Ebxv4tGAPn37LHi
	JKdbC+1TK2ITW2o8uQjVh2nAj+SirTjgqGxiA5XPTT1P2ZPvMgqEDBIIpBgoUw==
X-Gm-Gg: ASbGncthy+cII/dNh0Hs4BNgOak9o2s3xLZcKbW5W1iMOELu/Jv90rEBT+u7G0eLi5g
	vxdYrKCmrR0Mmd8FojGA2okvVl600+ZKGil5t8QNGIRPRq2Fn8BZ1Vcna7HfAqUJtmXBGwE9bZa
	rIeCfcIGF2UqdrcLyEHpjXUij1rt9FCaxwh7KDh+ADZI6MRaIsyupnnhUkPncgkjDOC16ZjSJme
	xfBikxq7Akt6G7uvXGb1VATXtmNL60OJsXr4iEkTvoEaQyWNj5PSW5Pwt/uFHf68AJyXQdF8vO/
	jtQOy5u70brnN3GxsYNzORRKptWBuWe+FtW/Fqe09GlzRvKV0r2Q7HucLyEPBjOMGJPIV0SGTIY
	4naXzHBjqnUAm/Lgy66KsvTGp9fPOFhvnO6i1bw93QHJRHMrUDFOpkHru5p/ROp9l7UW44uxBfg
	4a
X-Google-Smtp-Source: AGHT+IF5zpen7OiNCMFlimI7ZUGU+Y1BQ/eUePehYyHOFL9jX68xvb0k+exxRfLo1/2Ot4Zqnos2vA==
X-Received: by 2002:a05:6a20:a11d:b0:243:98b1:3960 with SMTP id adf61e73a8af0-24398b13ce4mr7419295637.35.1756332009085;
        Wed, 27 Aug 2025 15:00:09 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7bf2dsm12389128a12.31.2025.08.27.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:00:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 2/3] dmaengine: mv_xor: use devm_clk_get_optional_enabled
Date: Wed, 27 Aug 2025 15:00:04 -0700
Message-ID: <20250827220005.82899-3-rosenp@gmail.com>
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

Driver was written before this was available. Simplifies code slightly.

Actually also a bugfix. clk_disable_unprepare is missing in _remove,
which is also missing.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3597ad8d1220..d15a1990534b 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1351,9 +1351,9 @@ static int mv_xor_probe(struct platform_device *pdev)
 	/* Not all platforms can gate the clock, so it is not
 	 * an error if the clock does not exists.
 	 */
-	xordev->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(xordev->clk))
-		clk_prepare_enable(xordev->clk);
+	xordev->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (IS_ERR(xordev->clk))
+		return PTR_ERR(xordev->clk);
 
 	/*
 	 * We don't want to have more than one channel per CPU in
@@ -1441,11 +1441,6 @@ static int mv_xor_probe(struct platform_device *pdev)
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
2.51.0


