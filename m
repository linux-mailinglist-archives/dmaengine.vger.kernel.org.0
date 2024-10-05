Return-Path: <dmaengine+bounces-3270-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3863D991585
	for <lists+dmaengine@lfdr.de>; Sat,  5 Oct 2024 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDCF284849
	for <lists+dmaengine@lfdr.de>; Sat,  5 Oct 2024 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD81145B2E;
	Sat,  5 Oct 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feqLMFOy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F52145348;
	Sat,  5 Oct 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728120887; cv=none; b=SX5x6tUwUps3uL7nUPcfYm4ipXlTO7LgeYlAl1BfCTxuqizZtoIUpN809yzU+XB/9mL4Md3jAZH/0Jc14go8MVe/hrUHEMBEHsYJVZDIezQiZDCeWM9wN+VXBUsoIgqjJVS0NQ+ta1nLS6kendMZqK7e5hcEMZyKnxq5BwVnUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728120887; c=relaxed/simple;
	bh=xstx975tEFBHbbi0/rWfgvfGIF9+MbN4ZQexs33fetk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ki4BDrHc0uT00tbq1muByU95TTMCf8aSuQXSA+icATeJQXJ5apBHVXwO6wnh8VMP2XVh57HN/xiwyzNy/JHe2FYG0coUagIP+gQg6jmH5zt1Tsiz2u8uM+5aQVWtoIaZuDRdlGDCle9IF+RPmxvMiuF+sGATUetmyMZGclZ34/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feqLMFOy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b01da232aso23568625ad.1;
        Sat, 05 Oct 2024 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728120885; x=1728725685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CSZFVajzlH2GJ/7V0dZ4OXbVqD0p3FTgtVcGkfDX2M=;
        b=feqLMFOyhjRUrL/Zk5mvpHZ/hmq9JmsZPwjC1HefvDOhNSpHsBnxm4NZsnDg7OCk2N
         wmGuJoAJZO5IuQ7Smgy6rSvAcq9YBKIkCWptARnm6sJANwirYDuGfoHqnfTycLf3crNe
         t2GE0nSurupohrCCqabQZTYP+URnB/s7yw3UqUHZl4uAV2IXgQPsRT03ESmugMsxutll
         XlKe0dyGkcAsbYqZiTeGgFCqh44f6+8BAYsQmV8cQwH6jdPGLn5Mbnu8Pkt0rYVsJw47
         VGtueKre+0VvQkKM15cWesVmMoh3zQ+xr7H7oJZhFJNYXyr8Q2r3tUybnyrzw6WDNtbt
         LRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728120885; x=1728725685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CSZFVajzlH2GJ/7V0dZ4OXbVqD0p3FTgtVcGkfDX2M=;
        b=OrfN7VzLK+keuLMoEhNiA509cpln0OQOP8WZVEaWKqT9PxoQnlhxAXrr26Hn1XLBz3
         kmJ4VwKhqwm7hUAKnBNk+pyXiOI8ZIpjSEl1GJndqtNeRVbAX9EwGXVC/CIX7HCUMeB4
         OmbKfT9Egsr1aXTyb5lyC9Q+I8Gj8F01L2nFV2hV/gAUi7+EeJH37JYs7V14JOJq6KMe
         2Qag489HOTr7HeoqqxgleLPyDWEXeDnpTv3ss3GMO8HG+09j7EM6V6FNa7VFo4ZVfKOv
         eMZ2CJXVD0ihN06P621ZInaZmV8SKcHVDVMgKT6RVBRQCOQbAsqSjitHCRb2rkjboYC4
         xodw==
X-Forwarded-Encrypted: i=1; AJvYcCVUGDkputg6GS52i3rWKJUz21gdnd0kdErLpTOlo3v6FLvsLaQQy4CID3bZwU3+H+0YMP7BaHd7w32+BEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IETLkh7PgMd1JbkhLHkS1dTWmFT1XRA06LGS9qDcFx5qaZXX
	/2Mnu+cptS4YnhxECdWC6Tjf8KeREJuTeZXKitG3VQNqG1vF8K3r
X-Google-Smtp-Source: AGHT+IFUbNU5XHQPdbayqRz7wSpaM4nQndBKYBvY21vsxL//xvPcmxwTBuoZb7NoqKIcp8DSKPopEA==
X-Received: by 2002:a17:902:d2ca:b0:206:9dfb:3e9e with SMTP id d9443c01a7336-20be189892dmr127377125ad.10.1728120884889;
        Sat, 05 Oct 2024 02:34:44 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:3667:ab4b:122d:211b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cbbcdsm10241625ad.82.2024.10.05.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 02:34:44 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH] drivers/dma: Fix unsigned compared against 0
Date: Sat,  5 Oct 2024 15:04:36 +0530
Message-Id: <20241005093436.27728-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unsigned value can never be negative,
so this test will always evaluate the same way.
In ep93xx_dma_alloc_chan_resources: An unsigned dma_cfg.port's
value is checked against EP93XX_DMA_I2S1 which is 0.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/dma/ep93xx_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 995427afe077..6d7f6bd12d76 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -929,8 +929,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 
 	/* Sanity check the channel parameters */
 	if (!edmac->edma->m2m) {
-		if (edmac->dma_cfg.port < EP93XX_DMA_I2S1 ||
-		    edmac->dma_cfg.port > EP93XX_DMA_IRDA)
+		if (edmac->dma_cfg.port > EP93XX_DMA_IRDA)
 			return -EINVAL;
 		if (edmac->dma_cfg.dir != ep93xx_dma_chan_direction(chan))
 			return -EINVAL;
-- 
2.34.1


