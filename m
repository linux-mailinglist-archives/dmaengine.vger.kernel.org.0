Return-Path: <dmaengine+bounces-8386-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EFD3BBBB
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 00:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EA4B300751C
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jan 2026 23:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29E2DB7B3;
	Mon, 19 Jan 2026 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhqMxntS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A92D592C
	for <dmaengine@vger.kernel.org>; Mon, 19 Jan 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865177; cv=none; b=iLQtSPsDGOWrHpqKanJpVUJc8w8jlk7Y5aSQ2y1CPf8j6sQdZ7BK/8zBixMoaN3jJdlSIu0ceOUG+qOvPAUF/J2+NnzAhgwWI8aT1BLsAhAwTEwDyKivlO+E4rvWUSyuBV/RVSieN1xHMdzQSsODImMTbyUTQwEziPQXKemhc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865177; c=relaxed/simple;
	bh=1MNtHKJboIytqAn8D093hCtbngd/ZolnXDwBMwLltdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFN0cXCt7uUZzqscZlbUG2BR0bLUytogIAUPNKQtsBkWUOZ5gWRq76vxrd9C6kA34e05Dq2kIC44Q9k0Rrpq6kVsMrHW3MGEx71TAJVg3js8Q02YLbp2Oso8Si1fEsqr0OgopfKtMWFQymAv3/Us+DZyYkLCMOv0XBQG2kuBZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhqMxntS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a110548cdeso31593135ad.0
        for <dmaengine@vger.kernel.org>; Mon, 19 Jan 2026 15:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768865175; x=1769469975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0vpLCJZXxjsKEBOE8IfRD/+CdPfHIJWtuF4tMUY63I=;
        b=dhqMxntSYADGEqkcy+eN+6T8zaPAYoO7V5xPum6felm9/dDYQU5bA0+IsG8yUF0OdX
         AUU8Xh7oYwDbgwWdxlPMY007SHdR4ORR9njA8ePNcBLcyS4oRjqpgq2DS1uiAkuEoo2V
         tmSJPvVIolOY6pkaN4SFWzbf4/8H845J/SLFdt0ItrGlgbdHaKCU/be8zwQKF5kq3zZk
         85mTDiW3V6WOuy+n/SW1NngwVIrJBz63AHluZmSxo3rhsbOIn4KXBrpyBwSEMENva5zm
         kPR8lXdPwBNqfK1MWXbO7GfNESikttGPwYVkb6fydPNEUaeleVU+aIuFRaMReTGeJYsO
         2xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768865175; x=1769469975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0vpLCJZXxjsKEBOE8IfRD/+CdPfHIJWtuF4tMUY63I=;
        b=QzSptLXfht4Md7o7Qw5ABlBz8DwMu05DHP2EQMpgjMk2XQJVFrVtbsvaYKBBZ21jiQ
         AbvhP2bcOv4ZNOOJqMv3Zcg+rr33HIfMkv33tkS4sXI1Gy0jet7D/XpsN7znnhU6aiIi
         UaeLfHVrP9/z3Tgd1Y7ab0vYoZC0Pd0ahW3cqDH8DHzqZPMc158QF11JE30cUGDtA/LI
         Pc/jyFpxTSOGDR/N/yk/hzxPY9u5GVT6lNgTQu/GvknAbV2UKKYHfR63Mzj/0rLx5Kgb
         9fKJPqrICMNwAFnIVeSUovMD1MrwVISA0TOWz3F7UbebqZRSphaYQHyglDQA5B8XYRMq
         0BoQ==
X-Gm-Message-State: AOJu0YxaLVRTg6SfllJGgPq//lCoh978YhXlN+IPsa5A2jdd6KOXSqQ5
	8wde6YQvokRrKSAvxIkJlSlJBdcbkHHvdqfOwyqjjhzWeY1FkVmXpQv7SnMZLQ==
X-Gm-Gg: AZuq6aKoukfhyh3aGYKuw7eQez4teL00G8Wa+0jYojknayuCxgJttXL1lrb/9cNSX8Z
	FU5HxXIycF2YwGBiTEvmx3AEdhmuEbc7hnOJfJNkXP/ZRvdYc5j8T6JrQUg87dzvQyS0QZpC93w
	CVgUUItJ/zHhJo2wFNIJkEYoFtI3NjitdEeyg956LTat1+EmYaCda/C/9Rgns/NE7bAjV9L2H20
	cFB+qwrV1jWmO/OpYHVLqv7VgWFVUtPumX9sTNgO/khQyDVsGrGW697YkPFyE7Dzgi4GlmOmCV4
	jZm1Y880DG6B3fkQalwU+JLgnTbh/3DQ/c9imfzkSEe+hGjLf+D8RJv8HJObfw7SvVE4UMAc+6J
	hp+PBP/Lg/g3TSf7CZsM7AJxPI/4GXi+61ZQlYuGCZQq4h0LYukw7O8Ne7THxtlnSltTK
X-Received: by 2002:a17:902:e80f:b0:2a7:682b:50af with SMTP id d9443c01a7336-2a7682b521bmr702345ad.40.1768865175221;
        Mon, 19 Jan 2026 15:26:15 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab96fsm105399185ad.13.2026.01.19.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 15:26:14 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dmaengine: tegra210-adma: use platform to ioremap
Date: Mon, 19 Jan 2026 15:25:57 -0800
Message-ID: <20260119232557.10818-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code slightly with devm_platform_ioremap_resource.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
v2: reword commit message
 drivers/dma/tegra210-adma.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 215bfef37ec6..5353fbb3d995 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -1073,14 +1073,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		}
 	} else {
 		/* If no 'page' property found, then reg DT binding would be legacy */
-		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (res_base) {
-			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
-			if (IS_ERR(tdma->base_addr))
-				return PTR_ERR(tdma->base_addr);
-		} else {
-			return -ENODEV;
-		}
+		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(tdma->base_addr))
+			return PTR_ERR(tdma->base_addr);

 		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
 	}
--
2.52.0


