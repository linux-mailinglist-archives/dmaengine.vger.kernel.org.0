Return-Path: <dmaengine+bounces-6092-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C6B2EC44
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 05:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CA15C3193
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 03:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A02E7BD1;
	Thu, 21 Aug 2025 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHst2UdP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453B1E515;
	Thu, 21 Aug 2025 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747929; cv=none; b=QuL1rT8skbGOFNYYV8wdTKx7gCixQfds+QphX8GIKwNwJIy4Snz5Q2+oOkURXwUhPZSXCUsTIdQZx4aS81d3x6tKH7Fe5bfdTIBFJQlqPs61rXkeVQerSO/FiRNND7u1A3gB9asuEqisumr8Z1/cgAczTTjbey4xmr4GWDqKX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747929; c=relaxed/simple;
	bh=v5s76WnsbuJ9cg6yUVZLfCAa/WCAVb7oOP2MvNqhpus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvhthIe+tCeILAJ9S+w/24xECtH6ilO7J9TMbum3HMrDDcr6gyFvOndL1fLsLH9Ud7AirmoSpeW5JQdYx2ijGyNxLfulRxiN2JOGoMp907fnEk+ozfJBDt/1iS9wwgimVOIX7pBBt25LByW8rVLRAwAy8z2AEssNAoMfHdwtmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHst2UdP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244581caca6so4376085ad.2;
        Wed, 20 Aug 2025 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747927; x=1756352727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLl3mzRnbVoD6mdEcJJgJVvFz4R0gVIec6mQrjfS8wk=;
        b=fHst2UdPU1LzRTvhGMjdMK2TI1T9Gik8xx6hmg2kjNgzLv75GCJByHGLK6ZHHLnEIx
         eU63H3ksMKe29wF1ininVmoIEs6mNCLk2vlXCVD8a70zuDmp54Uoq8OR3tITYQhs0Q6m
         6ajBQgr8ohBwZpvKQtcxAA/6IRcwx3aaE80gzcDUgwwbsCqpVA8d9L6/WghMWl0VQnxG
         ooTitHgCYhsGsX+1k3KHkGyX0H0gYIaYpjgzR8DvoWLCUvITT2/B+xaNwuw3VZd5IT7Z
         hZtLk2C8WfEN3+cer0gyCcYY0QmaCVEHj3ecMzVlwx/u8H0AJfCrIBNzQb8377IiEn6M
         2N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747927; x=1756352727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLl3mzRnbVoD6mdEcJJgJVvFz4R0gVIec6mQrjfS8wk=;
        b=BkASEYxPiMbe4Fn06zUO87DbtMWupGIJEOoXF5Xm04POI5dixp7X2/2zb65DUPo7yl
         t7NDM3ZmIWk9V6BogyA1RW/8SrXag3Z6F4yu6I91hHgZUMHb+/wlJJPnZm0b3N68s7Ow
         rn1BmaPw7/LF348L6oGy4MPQ3OEch16vhc2temUIzQvdNN8ZNvaz92HDHchPHQKlw/nq
         Zw/VTjoABEEesvzTIm47IqttXRrjYHEYx6zJru0yGaori5JIXu/uqiiPKgzwET41qwTu
         +hSHmWEn4u5kIfF3ivYb+M59QiRmFiEbnZ8D2WuLwwqeue5ZY9pwJRkAJHFKeYcu+nFn
         6R8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgraJaYbE1+2geEdc/x++tSp5txzO+3WzKBA5Sgq1qNKSr421g51qW6VSLCPykp0ApsUCptZFcq3aRlyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEIU84Ep1D2QgtbAvVvPXrQKhZ1CSB4VL9FkHq2Rm+0wSGWQU
	l1CIbnDJ1TeDNk+Vu8XEXBjHw/XFS3uA3p3TDALYl+miMAYrgPSDhezv8oX1TQ==
X-Gm-Gg: ASbGncsidv9Lekm47mbNo9DRtkXwt+tVljkFCzkq4oXFaq+K+xOIHXh0aEAr1LK9oJk
	cmrzwwqi0NfBTR1o6Q6mOVRQnjZLAYpizwiuz9rDF/akeoYSFuiAsNgra+p9FMJHH2Tsw2pqM7W
	6JpHHq2U+lWqikwaRBYMvOw57oONBTTWy4wB81qDHTS2B6SJenhw8lcryhwaJBzBMceW6pCFbI0
	PgNPo5g5/lX9NH6ZMNjVjJzfyscyHso3fdKPnm6mprooDL+rXrtNjY+xMsk328MppTbp2d0yJBn
	RSpifR+N9lNoxRIzx9a0jc6LxIGm2MxbtsmNX622BsodoV8U4sZSsBSPFHcDM7wO3zZYII/2ZuY
	oBC1YN2ZnIJ6eejw=
X-Google-Smtp-Source: AGHT+IHfbRF9UmMgXD55WGYe26OOaOjjKzhbDId5APji1BWvZx5t24lfhxY9exDIj8cWfSc7gTpe2g==
X-Received: by 2002:a17:903:2341:b0:240:719c:65a7 with SMTP id d9443c01a7336-245febe5c8fmr14825275ad.4.1755747927339;
        Wed, 20 Aug 2025 20:45:27 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2402c9asm504932a91.11.2025.08.20.20.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:45:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 1/3] dmaengine: mv_xor: use devm_platform_ioremap_resource
Date: Wed, 20 Aug 2025 20:45:23 -0700
Message-ID: <20250821034525.642664-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821034525.642664-1-rosenp@gmail.com>
References: <20250821034525.642664-1-rosenp@gmail.com>
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
index 1fdcb0f5c9e7..d56fd130173b 100644
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
2.50.1


