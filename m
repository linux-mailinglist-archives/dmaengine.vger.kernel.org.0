Return-Path: <dmaengine+bounces-7934-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05885CDA8FF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BD73019B55
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF08313555;
	Tue, 23 Dec 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfnhowmC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC42FBE1F
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522584; cv=none; b=lSVtCta5/VQyMcVTQMG+u54s+3/HI2EYOPTwcdtZ6TUTUz3zkGtzGdrNKwb1WpFIza6+9NoDX9PqEMmhJymJ4DCxbtn9DmPAhoiMBxaxEkl+m0zAX9TvDRVDnLIcJuoAJ/mn3sWCDnBJINja94adITuaGvfrWCsJok1HrlTt1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522584; c=relaxed/simple;
	bh=yMwiptWpv+B9ZQzk1lcYIODOZzAI5+8f83d3TcSFEMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqi4U0KtXDfx6sOfp/gT+4lXtPSj5JUvIfrfqobjbiwCYflJl5jt5h0lDBc7YvYQqPApeR4Wqru75j1A49InLBKXuKxCWfiuigkxtQOahV9AGkezxEviiDN8PzfiExd6Bnpd9ClCu/I4SOsn+3hC5yDDJanesj9acdqC6BuJWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfnhowmC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6608185b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766522582; x=1767127382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K53dh7iZV5I7itYjrbEpcWSYQZjhrNtckyUwAic/RY=;
        b=RfnhowmCe8QmPzlJ5viprKu10igza5MjCGFhiEaHBZ90vNquEvxc7rMPgXr1/1APg7
         4C8MY3g0Qj37Vyn0I6jtXYeI8I6Lp9+j0DW7XbbkEnbZtJCu2mXt9UWD2dMHlfng7Nv1
         rubDpINRXf+0tz1lLpbgVVKOGK4mDJQ0RvG9auanw6UbmCVnwLNNo9jpmmbOo9dR//BJ
         92QYc9qwGMJ6qpj2QD+0FcUyt5HmDMpGgiqxsi1GsnZsZkk1JJc3OPpJpS4oeBo+hkOz
         /eerB+GuSNqUDLhOWtOQlLXQ5OqQQ6H6bQRGQyx5gbCeFfp4xOJIz1mJc0Bqn4wNg/f/
         lotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522582; x=1767127382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5K53dh7iZV5I7itYjrbEpcWSYQZjhrNtckyUwAic/RY=;
        b=uT3hDN7GklVDTsgUxYh+nucY+rxe6Sa1hq182gLnfVhu7OL5bDT9bBNHMhuScy3+LT
         K2XcAGs2rSysOF2cTvRd8boEaJXVO7pSpffdQxSP/31/w/yHEQeNlSlySZoY6+U9XQ3z
         nCWAH0DJAOUg9F8PAPGGLtUiNTY5URdU3IvgnFzRq94AcKVmNzRSAvWbUbNGPoGuipSS
         YiZKMtO+auafHlxhOq/mAecMFCJ8rDnX7zNuloMO/r2UfliK02Uolej91NnZv1JSmCqD
         kJvNFEjHy3kJOCngMePtz/wnqAzydimfu2KwuDayNACL5MxfH7yB0o9eAIzklqssmHxY
         Acvg==
X-Gm-Message-State: AOJu0YzpoqGO9WoVfDt3mxPiNCdmZWvV1r8yQJvEFBKYNgJTc9mubsm8
	c4+bmaX/t9y+5VPWa3egwfoYHKfKqQ8alNKaIh3A3msIVtG7EuAc6SKBslZY1A==
X-Gm-Gg: AY/fxX6tm/t3NvDnKSgEmhBwYviyf9tJnxGvDav4aQ6sMoaybYXvQGd3UIxBtO48Ey6
	LqDkhoxTPhb0/DGoc2nqagz8XaCCKj96bs3p17/I/kWujxRAgBE+RMx/6H5hVDMxklCpnKu4G2x
	ASo8YWcH2EzJSV8WCta9b2W8E7i53z9lb5pc5R8H+rocgKJBK1ZyJ85qDUScBXzPzFMUGKXml+G
	7LFAGbs89oisDyrkcWtOex4LNSgkqKiLOXx7Pq9uCqaDGN4HNvPMURPUjMTPZxwp+OIPSimkjjH
	MiUtnLAX46l64efVYUmNpCPEyC3pnq3MCOtVCVL7ONCtYDFqV3cyLP38EY7xuviCDHLOdRcBMor
	echATDQaSf1IKXvkctpr1o2Jsl74PkLdKXWa2/ZkUAghzh7XR0Db/OelBCw==
X-Google-Smtp-Source: AGHT+IG5U1kfjxNkKuFC7Oj5ybiC1eIbI8paxEgn2ytDfdv38mA4nXn5G9F1DYN1N+ndgD5VvLuyDw==
X-Received: by 2002:a05:6a20:918b:b0:366:14ac:e1e0 with SMTP id adf61e73a8af0-376ab1ea654mr15523988637.70.1766522582461;
        Tue, 23 Dec 2025 12:43:02 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e922278a4sm13931871a91.11.2025.12.23.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:43:01 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 2/2] dmaengine: mv_xor: use devm_clk_get_optional_enabled
Date: Tue, 23 Dec 2025 12:42:42 -0800
Message-ID: <20251223204242.3415-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223204242.3415-1-rosenp@gmail.com>
References: <20251223204242.3415-1-rosenp@gmail.com>
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
2.52.0


