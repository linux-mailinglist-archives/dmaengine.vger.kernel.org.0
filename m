Return-Path: <dmaengine+bounces-5709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3BAEF8CE
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859481C0372C
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79BD26E173;
	Tue,  1 Jul 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8Hh8y/e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2E274653;
	Tue,  1 Jul 2025 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373513; cv=none; b=JwvQ2VcUU6Vc4thrZtFVLPgGHhaJ5BzY8QznefNZCeoQ0ybzPDnAfFaRmdCTwGKa68Zp5vCLIUKmHLHFejlnaqLE4SidZLQsgA/m/lK2rmMGiMuo9Ba1kYeWBa/kifMRIp1/utYZLgJmu/s4PpF+HrfkLGj7ZvOv0SM3Hif2Wy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373513; c=relaxed/simple;
	bh=6n3Z+au68UHb+9v+Qq/ulc80NCYEt6D42KSfSZBINHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXq/bnDN1+9kxIti+Ptf7q33T32m2qkYB2wL2D6TqpH8rlBjSY3mp/Fo1FPiK7qeLZ/M/RQwl7qV6oOtlvNbhKNE/Q3EQQ7uoCC26z8Ogm+M5QH3NBiViywYqveE1yoxdh3cTkPt7ABa4jTnbs3Toao8JY6XZDsr16b/N/+xu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8Hh8y/e; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a52878d37aso732857f8f.2;
        Tue, 01 Jul 2025 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751373510; x=1751978310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1pfhh/N50xGHthfuOsKcU9+fCnCqH7gN3Kquy18LxY=;
        b=G8Hh8y/e184Eo6TghZVUHss3vUjEba9FVyd5gQnxO9zAyqG1z+rAE35bDd69gH500Q
         7RxNbZVEFbKC2s9EYheYsFVsIQJrJmaCgiazJCj9uDtVvQCYzI41t6tuuv8CG7XYGNxI
         17Ex5dBwp8UKydLYpmm4O8sN4DYN6oU5TPmXaJJJTs8jhRRuRn+XeWmw8QQIbgVIkRz2
         wJL17hwhtrfs0sAllnHVBzPJXqoFvjfOPpaqWeoGAg3VMSRLkLPmlK4NshaIVQKxib9s
         z8Uy6g0axv5H0kj5OMZaCbOv+z26E6L6IqVmWqHHH1RE7+/eVZydPsc7RkPfjcWqBRzr
         ZxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373510; x=1751978310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1pfhh/N50xGHthfuOsKcU9+fCnCqH7gN3Kquy18LxY=;
        b=GywvjIyHm9YqC1HdEIKlzFfCND35EaSxd3e9L/MheITaDhuqMB6FY8ZhVDOpLdUMQ1
         C16SpXiwRzYFns4AI9Jg8pvmLfP4peeEYqEUtF6ILD7JFwdM+1ssMi5vluvsMGXu8P6r
         O9l6a9RK0jaRE8iRIOUW8OA0gf35zXjgta0ffbXMkm27EupZfHfylF/S676368gcoSKN
         dZjSncqLXA1owny3URruRrukc+81FQWKRfvoW5pZWNxmnTog9gjqF5PIXaPD0mqA1VjA
         eYaXi5FC3b5KpgJk4bkpFaBfQLrPCtAzWUH5ay5lh86LsYYrOuMMWlONe5Ih6LLV17t8
         /yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkrei2M6a2BEEBSYe3WD0PVf4cxg1QPpKFGlVGKvWvptjTG6gDJXnR6jCiF3W78Ii8jUUGlXGHXQD5uTMx@vger.kernel.org, AJvYcCVlw3pREfuAUfA+LMxMvB98/noV29WoR0Hkkv9cjNdTOtwUomxDCvzjLarZpWG0nqbuSGMqHcmDAKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFD8S8Dn6wwvUIzIb1rl50K/8LpmMGNw3QL6yrl+IpFs5D0zR+
	OMVXCgPBKpJi2rt9LO4H4MUJ48keQP8+3fxq6EQDlizuqXm8Z9AQN06f
X-Gm-Gg: ASbGncsphKw08YgjkLxYoIcDkxVEDJhOkLXe9Sc5TbOxT2fY/YRJ9SRKLvUMbw9grTW
	nIrnl61rtZ/6E0tEmXE9i2Ji2LzMBdxkEOFo7VKgxZMM/MDjk3v8v0GrR4qh7XoJsVJPZ6heJpw
	vXHjrhfgZdww+Hiv4MmWXRzeKP6Jbs4gKluuh+MflBYRR+ARwa4E8AHwV3AQhp+GlxY9HfIZ8Vs
	mQF/tUNsGTuy5/6L5BkpGVZncFlTAaFtpLcgwAaiOwiDQxVTkoADeQDgyD/vq8C3GpGBNewGhW4
	YlPtaRB5pNZdIVpBe5IZvRG82mzMj/QzrdRASx8unRwMseVscA4hXZUz1Fwp9ALzQzWAhEe4/iB
	Ipa/fkWzT0iEzZQI=
X-Google-Smtp-Source: AGHT+IF7xfXWIgEEQTepfFkA8Dq+FFvh/bodnyrAg08k9lWTsmEPjoDWuCf8E4Gm+conMeyqAEB5SQ==
X-Received: by 2002:a05:6000:4021:b0:3a4:e0ad:9aa5 with SMTP id ffacd0b85a97d-3af259a094fmr949039f8f.11.1751373509923;
        Tue, 01 Jul 2025 05:38:29 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:a723:4386:e2f6:bd22])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c800eaasm13443541f8f.37.2025.07.01.05.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:38:29 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma: mv_xor: Fix missing check after DMA map and missing unmap
Date: Tue,  1 Jul 2025 14:37:52 +0200
Message-ID: <20250701123753.46935-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

In case of error, unmap the already mapped regions.

Fixes: 22843545b200 ("dma: mv_xor: Add support for DMA_INTERRUPT")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/dma/mv_xor.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index fa6e4646fdc2..1fdcb0f5c9e7 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1061,8 +1061,16 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	 */
 	mv_chan->dummy_src_addr = dma_map_single(dma_dev->dev,
 		mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_src_addr))
+		return ERR_PTR(-ENOMEM);
+
 	mv_chan->dummy_dst_addr = dma_map_single(dma_dev->dev,
 		mv_chan->dummy_dst, MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_dst_addr)) {
+		ret = -ENOMEM;
+		goto err_unmap_src;
+	}
+
 
 	/* allocate coherent memory for hardware descriptors
 	 * note: writecombine gives slightly better performance, but
@@ -1071,8 +1079,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	mv_chan->dma_desc_pool_virt =
 	  dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
 		       GFP_KERNEL);
-	if (!mv_chan->dma_desc_pool_virt)
-		return ERR_PTR(-ENOMEM);
+	if (!mv_chan->dma_desc_pool_virt) {
+		ret = -ENOMEM;
+		goto err_unmap_dst;
+	}
 
 	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = cap_mask;
@@ -1155,6 +1165,13 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 err_free_dma:
 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
+err_unmap_dst:
+	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
+			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
+err_unmap_src:
+	dma_unmap_single(dma_dev->dev, mv_chan->dummy_src_addr,
+			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
+
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0


