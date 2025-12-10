Return-Path: <dmaengine+bounces-7558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E07CB3DE4
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 20:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6428030A35F9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380A31B823;
	Wed, 10 Dec 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIg8K37Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89D381C4
	for <dmaengine@vger.kernel.org>; Wed, 10 Dec 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395076; cv=none; b=Qg2ftWqjLcBHU6DNBcc+eiu41jNPwpf/30yTy0Klm9JflLN0/1VzWDknaQ7zzrXvti56h8vf6bLtvWWoGudjqJMAwsUPSLY0qpShTZa0lSmJbrhLdLiO7ZAzkgJNBYavtCsUSmE2lGYa208PFyhwBvq4YhfwQuzpN+Cni5yLF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395076; c=relaxed/simple;
	bh=YqPz9Xt4JconGPKB7H1nvBnJY4LIBmzUWRtoZym29V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM2uyTS+7PdPoHI49ED/skrVYrEB2xbw4b5GzR2zIO9HyL7j7Zw1AZ7Gg69iWaWKqu7eI69ya6vee1H5sH4VHvRk24VLLzg+IQrNjriNDs6ahzY03izXDkj55Xquiy4fGUzC1DL8k0cEvj5jG06rDmgM4e5l/uw72WCA2bc4Jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIg8K37Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477aa218f20so1368885e9.0
        for <dmaengine@vger.kernel.org>; Wed, 10 Dec 2025 11:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395072; x=1765999872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUygINJwBiQR5/xt5IgZK/GlpK6OO7X4BKt/LNCencc=;
        b=UIg8K37YrUjdpZKaTwtk1UT8pxUCuwZHGVo+J9h+1AiwCQW7nv/U/ffr4ly+QxO1g3
         JEsmFhFrtWkytpIIN3HRiUBUM80sptJMcLDgfHtrePxLBFON45OO63+eQP4m3Gfyiboi
         y6g08IqxWzfyznngvH5MaBeg+Rxjs5vHS+AkMp4vmRHfzpELqxdFCwB3zEUiIAPYx08o
         e6L3hMMa5GhkGAIsiIJQSvwVfiMjw9ZFhK+AQSwK1cx7v1pR2GOxp7Dvkkl+I4Icduo4
         dVFgWVNEB2k8Q5oRSQo5Z0+5Idc933q9hcC9r0YTHn+/LohKqEO1bXzYIAAFlQawD6Lf
         IBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395072; x=1765999872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUygINJwBiQR5/xt5IgZK/GlpK6OO7X4BKt/LNCencc=;
        b=uBvaZFLAlOl+D2uUCvlarhY2AfPARdgY1k1yk/ZB3Ignpou6v2hYMX7PT5DCIt6A8m
         N/c5TkcZHfVLQZ5WJBqjri0AVlUJ1Md5rSP8JVfmyCxeGQ3Ws2TuQlh2fxLE7Kb8Kae5
         D3A0egfsCMoJUIFsP6hpj0yvvnoquuGIeJG3Ommu1biFtKddAUSDN/eYflw7HWjJjRBq
         eyw15VgCsdPJqMTxbvRsf6bShnu+4to09pndfetLse1V6B16uIbeZHjUkz7iK4wc4uWf
         05wowMQssFDIMF9icdPJRg+k4wFNHW8IERvQDcN2gHD5U2akBZqNXQ8/a5OoAs+ZYMdY
         Mwag==
X-Gm-Message-State: AOJu0YzA496KvdQeNi4lE6edTa/RIs5PatBaOJ+1pT8zoXPeTgBrHq2z
	VMq2EZt/eKpebxrdzjqlPXMO8bDLW6ytnUH4vCEJbFEGDMFB4nHzUuNT
X-Gm-Gg: ASbGncsluI9bWWsxCeAMk5w/lDNCMZyHRSL6or0YTnWgQsBl3B1XmbgUeTV4VStEfhO
	wEFNsJmB0fxjraXsTFlI/NbnrJJph98ORQNRFwT8+55RWVkskS3LJVnah3xIGduhN+7AWUPu+ET
	8VWq9IO4013DPsvJL04YeqF8/sWx6Zyhmj0IEDeDGsaTf+R9nBjg9cGo7zgluKGqN7/P7SaJ7g1
	Ut7NO9j+JFh7ZluAjd5/OkqKWp5ON/56JLvnwihgYyEhLluIsHHGCQ8fr4FZkM9kX2arWW5Ecr8
	KJxEZ4bldBKNkHW3PtoRRlHQgU6bij50mQhnGoOToy6td7zq/YugAqhCSnlmVdHbEN4+FbfFQnn
	emUx43coNHmc5IWbE0D6c9eLai/42WYv2XPyKfvFN4N6UgFHgZnIh9GRnvO3d6hKE6VhK8O+FwK
	QXvGHi6s6gtmcEyDQ57st7neB0ThRKcnbx85wNfB8+qgLL
X-Google-Smtp-Source: AGHT+IFkql1ij2gs6ixXOw1rPCKSbCIW8e/NxKM+3h3S227vchXKYCHdaaVdSLS6BFaAqRx4oXq9AQ==
X-Received: by 2002:a05:600c:3541:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-47a8375a183mr46122505e9.16.1765395072375;
        Wed, 10 Dec 2025 11:31:12 -0800 (PST)
Received: from dev-AI-Series.. (bba-86-96-93-57.alshamil.net.ae. [86.96.93.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a88281e85sm8828475e9.9.2025.12.10.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:31:12 -0800 (PST)
From: "Anton D. Stavinskii" <stavinsky@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	inochiama@gmail.com,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Subject: [PATCH] dmaengine: cv1800b-dmamux: fix channel allocation order
Date: Wed, 10 Dec 2025 23:30:12 +0400
Message-ID: <20251210193011.567210-2-stavinsky@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dmamux builds the free_maps list using llist_add(), which inserts
new nodes at the head. Using increasing channel indices causes the
first allocation to use DMA channel 7 while the DMA engine hands out
channel 0, leading to mismatched routing.

Reverse the channel index order so the first allocation gets channel 0.

Fixes: db7d07b5add4d ("dmaengine: add driver for Sophgo CV18XX/SG200X dmamux")
Signed-off-by: Anton D. Stavinskii <stavinsky@gmail.com>
---
 drivers/dma/cv1800b-dmamux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/cv1800b-dmamux.c b/drivers/dma/cv1800b-dmamux.c
index e900d6595617..825e1614051d 100644
--- a/drivers/dma/cv1800b-dmamux.c
+++ b/drivers/dma/cv1800b-dmamux.c
@@ -214,7 +214,7 @@ static int cv1800_dmamux_probe(struct platform_device *pdev)
 		}
 
 		init_llist_node(&tmp->node);
-		tmp->channel = i;
+		tmp->channel = MAX_DMA_CH_ID - i;
 		llist_add(&tmp->node, &data->free_maps);
 	}
 
-- 
2.43.0


