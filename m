Return-Path: <dmaengine+bounces-7063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF43C37D32
	for <lists+dmaengine@lfdr.de>; Wed, 05 Nov 2025 22:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AB024E634A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Nov 2025 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7E34CFCD;
	Wed,  5 Nov 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXbST3Ij"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F934CFA8
	for <dmaengine@vger.kernel.org>; Wed,  5 Nov 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376619; cv=none; b=Er5Pg3aOvgyHRfvDncDtuRD4vZD1j8REUV/v8ZfKDdYjoMg8qCa8CewwmdY2RcxJeOP1/AdN8I1sxyxwzL3IQQIlz/LbdD0nw7/YZtMjNkh3qJNOGFQE4XOq1PAOyfVJABrPhmyvxSiu1pcbwSVdtJFSKCWQxWtWVuBGtXcHhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376619; c=relaxed/simple;
	bh=7zfVMY8XIGnKYdGtLUi3KWKuh80GmnankiFSdnvKcoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spp/ipjiI5BI/Kan2Xd2zZLNW25Ju9okUkYO4EJ9SwepTGxLl7q4Hcxf4S/4CtSE4UCU1s/+52nvsgMcwt/HWv1nNcDO9grHbgo4z7aQ0VtZH07GoktByJS9wJGVQ4rdruGFUkR1XPK24XcfpjHxIDVl8p6TEhI+hndSV1AfOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXbST3Ij; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-294fe7c2e69so3017295ad.0
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762376618; x=1762981418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkrJkdba1xSje2XMh2x048aEOPt8IqS+4z2rOIVGwVs=;
        b=NXbST3IjoD8sTIj1lwmrdm+jAfpfgZ0h/oSYjlEJbcPW6kpqnXfYyrGE9rKplh83XO
         1QGiipHr9u9eC3Waxb0dvg5bOCG8hCTNuC2CZQMCkX1Xj8MhmO6yG0zMlPHGW0lP4Kup
         yTOFCbmW2eVkCbXo2tRX5XuRDwuA3LkSnUSrgjIpOjbekw+UqF66RJWTowotrMYQvdUs
         ZeZRR51KZbN5jywzWWeKi0MAWE32CDEDDuEPSmQ31SoDSOcpVSKUnAUKGD2WKCuu7WhQ
         svyX65mM722LsL7YPHg3LpJ0p3sfBZjF7dbCGSV84rSJeiYPlHps3NXZOTrqXxJ6WOHl
         joKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376618; x=1762981418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkrJkdba1xSje2XMh2x048aEOPt8IqS+4z2rOIVGwVs=;
        b=knhJRfZqQrSBpvt2SKRoGT2aMZsEowbQHAgIZkGbecLc3DFNsEC8Ojun2G04k6sBtm
         +GSEXy4j00wprCkK/lEKi0fprhJTiMYKHHvcSsEJP++WcTQjJFDZjITOLfPFJdFmoAld
         KQdfuYUK2e1LExOCfL//spjBpEHjSo3nl8/CW7HVOHb88hYcCUXSSaVfCAQVIB3iC0vO
         78NhC6HoDE6BPNChm3imrP6uZ1LYRpjJaY22dtSu0tMh1DcqhCe1tFDOyp3lrqk0zorN
         prT7A40P92Akus8fgVll/Uk05uFoyX750yZriRfVRjHXNLeS621Zl+rmjdvM4HbPvjgI
         0i9w==
X-Gm-Message-State: AOJu0YyrH2WsiYZtlm63pLtXYIrlh1UcuCj7RPl0/lZWdH8blP3yyYi9
	A3zQFShsXRB3z7x9oQ//iufPcAeYcI8jR275JTmJ1aGl+dWuISkht3qRbeV00g==
X-Gm-Gg: ASbGnctl1AOv1kPz2kalFc0/uH8Pkb0pbpgoA4S+ClrLDokSdFORhjCgPat8sDOK7Ec
	jarRLnR6gNlEYecY3C04llLH5kpfjN8w2xBQOce3VH8eNTA26rrEZxrCDiZ35mCSnsEdiVZr8C7
	avOTNpi+I1zbzTcRkZZCuaVfccplEFlV1mW3oaFdVtbliy8kdMoymnjCPRQMn7vKdQ5AYWyE25K
	YVPIn+m7fBg+PG6Q2gDgGA4YKFwci6D1Go2lci9lO6Vs4bPpbTGuofaTEsTZD1VoDFOM8ue1IcD
	pixISQ1Cg276h6O5Jk5rBFyyJ0Dao86c60DGFCwd6o+cQBco/R49O0DAtKeuq+wMNK7jWIu26q7
	K2aXpf2Bg7WF4K88WZkVFzDpM28ui3KIkbJ87uJcKWKxQBmE/yZfeOiy7wA==
X-Google-Smtp-Source: AGHT+IE+n66VzklfbAOrQrgUIqTmTgKBWIWBX+BwQFs7o7CvfPqTM+UfY6E430xCte9cNWMIOyPm9g==
X-Received: by 2002:a17:902:fc44:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2962b7a9106mr49267945ad.32.1762376617589;
        Wed, 05 Nov 2025 13:03:37 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d125c93fsm13626a91.14.2025.11.05.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:03:36 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 dmaengine 2/2] dmaengine: mv_xor: use devm_clk_get_optional_enabled
Date: Wed,  5 Nov 2025 13:03:17 -0800
Message-ID: <20251105210317.18215-3-rosenp@gmail.com>
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
2.51.2


