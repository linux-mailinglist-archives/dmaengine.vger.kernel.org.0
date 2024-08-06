Return-Path: <dmaengine+bounces-2812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CF948765
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 04:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D221F23DD2
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 02:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333115D1;
	Tue,  6 Aug 2024 02:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIr0hF27"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1CF9DF
	for <dmaengine@vger.kernel.org>; Tue,  6 Aug 2024 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910673; cv=none; b=AFVZ9WhWXyV5X5UZIOmM1+uSmxmHq4AAhIsLrFznOHIfJ7pHsrehGMD1OJjToavwaXkXwDWW+cITEP8hb4stLyV+uTBay7+SlgRR5ildWOmpx6kzl2wAQAJeB+a0x4cebKiwj0TfxmhYwO2BygBL/dVTZ9X1OsF/cM9P5M4k13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910673; c=relaxed/simple;
	bh=JRhQfo/ztHvpjlrb+wxSoTmiRBUjOuL3IDj6gu4IOT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tizjZux1aqD76sprGonpzbYdTG/4lDeJ16owPewbgQouP3EBmhJPns3/E1wfBMf7mD/FTZwspjuuSczoInDVfHHhbF2L0UjAxQ7jZp4Wjscr9bOoCOK+yB0Hsw+tY5lvzuXBy9K+GXdOkSkWI+qDekSwg4yolpWOxw+/6QbrluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIr0hF27; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db1d48083dso52918b6e.3
        for <dmaengine@vger.kernel.org>; Mon, 05 Aug 2024 19:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722910671; x=1723515471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+ehD75BWluQoZLMCLsE4DRj4fPkWd2bPdDlGv/84Is=;
        b=iIr0hF27Tq/MmZtLtGdJOf89pNdL817eV5Xxt54JB9z+SxwzX/En2t4VC/z3E88QCd
         eTChQeYB4rYlTj3/czyPxN2I/q/5Wa7ujNXaFr1aPC19wvZPCa9JIzB7umqbXWWa9qnm
         6KWlKJp8Paj1fznSQs9RSBbt8GgabG3tykHQSNFTHUf1/JcIDVwf63JvN/CTcMdSsyeS
         FiLuXS8y3STb5Bj8eSurKmZLJyxXfYeZodOBaUVQ0VW1EDWXZJczqU9WHqdfpcATy7tM
         HhCWfynWuBjU4s98xrXnLjGF004ORghNOg6aijurGuZF0qlvx05lKLG6FL8YeBjEeo9S
         QzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910671; x=1723515471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+ehD75BWluQoZLMCLsE4DRj4fPkWd2bPdDlGv/84Is=;
        b=L6SmuLVr384B67Y9dth30LoWlL2vz5dRalo5g031rxWHnquVBl091GJ7Tilb6mf897
         WJAFTcsYsWPWsfzfKH7BbuWSn1it8oBRQ7DMdXpx1u5iLWql8Cp0VK3yajMVmzyMC+Om
         aiNAP2B2a2i26IvKqGbVCPGlimnZnaXc9saubJN6w5H7XiatJdROZqgyk+5PyuMTisqH
         eNOg1a/7ezxQ3iT3s0GHBA7LkKehuuR3Dn4XAd6RYxzzT59f0gyXOTOQ/gqr4MLGeZBj
         Lz7FMIdTqnrnM/Kb8Na4ZsqOEZ2EDW6tuMcviNKoMmBCCT2r3etFgbn4J9edAI4WwGa2
         Zo6w==
X-Forwarded-Encrypted: i=1; AJvYcCXgrJdNqCPLqdfaRQJ/cct8yyACyM7KUDU+8px3KLE7HM5rPAniFSfw8WJXaxNGtaIqWod0PBUPgHR5ulfMICDCnhLiK9bljH/p
X-Gm-Message-State: AOJu0YwZRAPQ8oveDhhxHScBS9MuRUzuR9amvAHNv4K3+bQkU9smEYlv
	Ss8QYWzV4LkdhdgceKCvXD+cKNwnyjzMHwjQow3ejVF1g2hpr261Rs4sCQ==
X-Google-Smtp-Source: AGHT+IGipj1l5BHjyuJ8T+rj9N2QAzB76ZmbF3UgMJBLoPA5tI9PQ/S7wtGfIv+QxEGplcX38KeNUQ==
X-Received: by 2002:a05:6808:1811:b0:3d9:402e:4d17 with SMTP id 5614622812f47-3db557f613emr8289854b6e.2.1722910671397;
        Mon, 05 Aug 2024 19:17:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3668:14ca:30e:638f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b764fb50ccsm6087006a12.71.2024.08.05.19.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 19:17:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] dmaengine: imx-dma: Remove i.MX21 support
Date: Mon,  5 Aug 2024 23:17:44 -0300
Message-Id: <20240806021744.2524233-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

i.MX21 support has been removed since commit 4b563a066611 ("ARM: imx:
Remove imx21 support").

Remove the i.MX21 support inside the imx-dma driver.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Fix typo in commit log (th --> the)

 drivers/dma/imx-dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ebf7c115d553..e913f0db99da 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -167,7 +167,6 @@ struct imxdma_channel {
 
 enum imx_dma_type {
 	IMX1_DMA,
-	IMX21_DMA,
 	IMX27_DMA,
 };
 
@@ -194,8 +193,6 @@ struct imxdma_filter_data {
 static const struct of_device_id imx_dma_of_dev_id[] = {
 	{
 		.compatible = "fsl,imx1-dma", .data = (const void *)IMX1_DMA,
-	}, {
-		.compatible = "fsl,imx21-dma", .data = (const void *)IMX21_DMA,
 	}, {
 		.compatible = "fsl,imx27-dma", .data = (const void *)IMX27_DMA,
 	}, {
-- 
2.34.1


