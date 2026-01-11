Return-Path: <dmaengine+bounces-8208-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF16D0F841
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18552300B8B2
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2221ABBB;
	Sun, 11 Jan 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNTEZFj/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF9217F31
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768152857; cv=none; b=tivPWi7+DQiUQUpd9sGLJoFLbOUl+ifRde79KcamLa49p4BI5oYs/J5/TT6z6Wh07oW3Oze07HvHCG6MT6K4yxboESy+WsBlnoi2Nf7Qj+FXpNxPJZtYC5IRWz+4oxPZxb4aeYqv4jtCqZERU2dIWc1gYiiCm7MtiaRsBpfQct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768152857; c=relaxed/simple;
	bh=dLXg8Tun1CATMwFuG8BO0FoaoeUR2NCtQgRLoHdzjcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDAgpwSW/kjZ8iQxNYQ5oDZxCEod/VY8V4lKe+55PkYN+4lfXuAiOJIyyZM8dhM3lt3g2XkzSo2lrcsEVHHUxBFUUDBq+21HO/5Bu7TGm9tf/vJ39drls6R06Orw7I/W9DpYG6Ymo80giOYb0vEsmS90UQflxmH6wTcAVx3I2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNTEZFj/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so1566568b3a.0
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768152856; x=1768757656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAdFa71sxulBHvN3d+ZO19BCSK5Dix0XN3EYZJMwXuI=;
        b=GNTEZFj/87da/T2EKLUwmOmR2EM1QQjmIs1RMIbtlkivu9gk+A7HNpyyxwNEnN9nnG
         wIOG8BhrZbsPVr6dl9e0kqBuVHkm34ISHjxP7FoOMW7MuVCLsDgkYLtPTA5MxmdqaAgS
         DLXnjpKYoLpTk1I4eHGIi7QrfjUjxJ+o9TrYa99EExDaDyKe2lUuc5dVjkxGjqaN3lKp
         fomm60vjlsAb7QYlICWWF9dhmdkbo5CPZHzN2mogXp1hB+f1MVzDhX/rVXxuRzhzZQsh
         c/C9Mhh273LLdIIJQQ4p/nzgt13YhSznIkiG8AKYzGHJGHxbyp6m2PrUE3EbYbTR7EPi
         5DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768152856; x=1768757656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAdFa71sxulBHvN3d+ZO19BCSK5Dix0XN3EYZJMwXuI=;
        b=jyxbBj8ccZvBkYI9xnrfl5v5DgPE0UnGH9R3KKKcWCpuGcyuVIJyUyiFO06z/ioe5t
         96Du0fqEyfpwco4oHksmSU3XVugGRi38uVVzYliO7+GGRwlNomr+WJ63YCCa0fU9N+DQ
         P3VLeJd0CioVNDYQsfbnEcZxPxPWPdsO83vsyxv9ZVgfjC2t8YtP3Then3Q3WfQbeQJ/
         TUZo2i/2DdcYgwVMmfZXkL+Z75kZyBva/UuVe3rECe9WPq652T7cVLt+arolFGbkOjAZ
         VqDGxhvFhFjXcjHwMErEUcATleF8qxeEGSVNJ2NXdvkddFqJU6XfL3p5W3s6w81otz1R
         D6dg==
X-Forwarded-Encrypted: i=1; AJvYcCUaPKIREnc3MV5wIGK7aJ8vBdTDmRKj2iBPBr8RIz+r2X8AHQjw3QG4Y1A90NjEF+L6xDB8ByZBwgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJ8f8MVmnjvyxSejokhdtEvoZT3eT92MgXRlyz4pzl+BH7hKW
	Lk9Zcq2CE/ERaIhA5Qf41zI9ZrRhQUmFKvdkmQ/sMO/vgxmB/DIy3g4=
X-Gm-Gg: AY/fxX6W2OgBEA3G2AFZuKUsUEHoG6uxtlCN3D3J1Gh9CrkHIJElpDXQGrcFzXdkYky
	Ppa2HmMC5mWpqcjGhvqzBJBVyVVWB09SeFgTf2q2sv8aRdriSKG3HR9VUsqY2Yq9quoniFYWzFX
	g5IOkkSkHFrf+S6bPocxgTglxg1uy8nIMQakCSid7o9oHK7/7pNdpA2vCBP/1yOzb19okmS1Gju
	z9C2W6UHnUkFk7Pq7eRGwC0ts0RN3rwYEdUArS2ZT0JTz6dS9zDmzW6CpJeKod4it6IwxXWITDy
	pYEz9BFIjJbseJG89ZAgfJ6dYefHSoqTLYqVzvX4wJ7S3B0XJMUWKzllxvNokJtdICuiIHE4J/e
	mVikr/Iag6GzEwm04H+l12UCQzjTafRUZYRcd5wY1uRaPv6sB5pQl93KGAaPNqhk+SqTRBLP13u
	ZQV/BO6UcgIHuZBCa1
X-Google-Smtp-Source: AGHT+IGaMeHE02sK4SYHQBbCo/FHXxeNBMLTX0e8l/oO17jzSDdnVjve18NU2WXgh/2lEl9RfKUdPQ==
X-Received: by 2002:a05:6a20:7d9d:b0:366:14ac:e1d9 with SMTP id adf61e73a8af0-3898f9bde73mr14022720637.63.1768152855900;
        Sun, 11 Jan 2026 09:34:15 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.136.255.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5dbfsm15176159a12.27.2026.01.11.09.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:34:15 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: peter.ujfalusi@gmail.com
Cc: vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] dma: ti: edma: Fix PM reference leak on probe failure
Date: Mon, 12 Jan 2026 01:33:49 +0800
Message-ID: <20260111173348.2218-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PM reference count is not expected to be incremented on
return in functions edma_probe.

However, pm_runtime_get_sync will increment pm usage counter
even failed. Forgetting to putting operation will result in a
reference leak here.

Replace it with pm_runtime_resume_and_get to keep usage
counter balanced, since the failure path returns without a
matching pm_runtime_put_noidle().

Fixes: 2a03c1314506 ("dmaengine: ti: edma: add missed operations")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 552be71db6c4..93171b473151 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2345,9 +2345,9 @@ static int edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ecc);
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		dev_err(dev, "pm_runtime_resume_and_get() failed\n");
 		pm_runtime_disable(dev);
 		return ret;
 	}
-- 
2.34.1


