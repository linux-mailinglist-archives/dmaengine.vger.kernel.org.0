Return-Path: <dmaengine+bounces-7936-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC2CDA9B9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2B7930F9743
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDD25F988;
	Tue, 23 Dec 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR2L41MZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA753093D8
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522828; cv=none; b=ufRY5eI6b59lWDHzgBKegHczPlkdaQEigIdLxaaMSnBDZ34M0lEU3MdJ0K591EeUBL6GweNUDuqqCWZIJh2NYICe/H8tjr8UzaMMsOksuF7KW6TWVfHrZAypoJ3/oXDoupJ/9DN7uweA/zpIgT8ByoW1ts8UWlIlVzIJI3PyhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522828; c=relaxed/simple;
	bh=3d4OKNlzKWCjWAaPIKmGWLQfdrv/dO6JCfyye/NB2lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbAvaKXrg0buR4bngrcm9zKPd54gw3aNgziW0g7D9OdeNHRuErXjqG1NhbJrbo9UL5NHxDjldtnwOCvP9b1I1UB3fymhBFpPMHQmJSFgRYHratSmzXG6nUVNjlY+7LPj+FRajJx75TA/NlwEM+qT2XqEaXrhEv+Mo84GTWW0qzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR2L41MZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29efd139227so71618405ad.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766522825; x=1767127625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq0j0tbdVnJAA23CTExCnxXrx5D9T13riCwpcS1VEEs=;
        b=PR2L41MZ6tzUJ//7bhCXTjoApaB3gjsEC0pufy9eyh4yuIU73PbVlRbOdFSK61ne5W
         Auolgl2Jzq7BXSFzX1HGYA5qRkZbRlAmHL1Cgn3v7z7VVXV5EW3bAKoR6vhFUTtmjhr6
         O+LDqUfFaCjaugkYr/uRSZekylK6pwowu3AdC6XiQxRxqAhLVIQzGXWphP5+nBhZSSZA
         hbx+B8mEgTqY9M6++AWAVLa38sm6ClRoCqsQKCQcfXAu786bO+4SWndvTngIceLjXehZ
         qC1y0Cz19RYSwWxyn/zGaM12EmGN3KO/JWN0YM7ePNiv5m8iBqEBghI3h6M+gNc6U1VO
         wrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522825; x=1767127625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq0j0tbdVnJAA23CTExCnxXrx5D9T13riCwpcS1VEEs=;
        b=Qw2lhCl7gOA5VZuiPwvv/K10T8Zy10LKO7xbTvxr1efVpeHoL8tcsJDVjCbITpuBXj
         8duvDtqvSO1fKd32qfLF4euGWLZL7MO928+JRz3S0Ifb5v5+HAM1FV7LWRJGIfz7wuSJ
         BqxZF5wrfRgSinTVD8CXR7nKzj5T0YDI9DNfgMkU07PgWi7RqFog7kgpbY/uNK4tFfxY
         hDbDcAHl7zl1IA1qFpWJ6CSkYyjsJdka0xSpTB/K2fo5HeNBm4F5dfMXw9deMwJKhVer
         fMQkNAQ9nQqpiBGa8Z8dtox1dYZYivJSpIGnkISR2ofsbnrLyFDIGodtTBtRS0mUMpT8
         xQcQ==
X-Gm-Message-State: AOJu0YxHuL7udQcJwqAmUcEYK0CmXt/+blTlKpRQb6SDl44qqghkhwYf
	a2R4ME9N+FJwSmY8C84Po9oAYQ9wCS70vnB+kulyBfU/rOw/7GSP5PJ0XYAb4Q==
X-Gm-Gg: AY/fxX7XAQqdZL+0fGRFv4c/pkKJFHAvgEnPMkuhN3mHvgWEFw15In3trR78NEiNWxz
	ZTIaBT9zmnYZQDXTv6uREH5HHjT9E5WGEF0mbwrHZilAShbA2hg5g1THDyxmlNp8R29x4X7CmDK
	viLAZCVoy0kPLCpqwqglNtX4tV+K/XsB1uNlutytlIIT7V3pAPlAEzRF3c1I+DBRzbP/UPurrNc
	hGuo5Cyg/4vP5rcBZ+pk1aSrraV+EIdYiIrGeGBkanSL3EG/QqMb2d05+ZNFYbYE0SPOtJkJIL7
	9nMsheG67wPfWW8LEesn/NdpT3FKz/+nxdv4NdU8U0fjSEhcsnK0+Q9PwhOpdbL/llZ/oCtniaj
	O9lh1M/ytcShjBrK0Q/ZErjHS9uxvAxMutDw6Ya2uVlJ8CcY2FB8HrSYwhDzQoCZlTzEJ
X-Google-Smtp-Source: AGHT+IHS2NtUHegFOEt7CP+ojUG3bqkkAvfhDyQQyX4Z7DAyzki/HKyxB1pTnMTphYfOx3KAPuFJpQ==
X-Received: by 2002:a17:902:cf0d:b0:29f:b3e5:5186 with SMTP id d9443c01a7336-2a2f293d13bmr151099575ad.56.1766522824768;
        Tue, 23 Dec 2025 12:47:04 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c87845sm137642545ad.39.2025.12.23.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:47:04 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: tegra210-adma: use platform to ioremap
Date: Tue, 23 Dec 2025 12:46:46 -0800
Message-ID: <20251223204646.12903-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler to call the proper function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
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


