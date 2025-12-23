Return-Path: <dmaengine+bounces-7895-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE65CD97FF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579F7304C2BB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959329B204;
	Tue, 23 Dec 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YFjoaPTn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD09296BAF
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497849; cv=none; b=mcKPffaJgKoUQbN3EzeE2us3ee5ANeZZbEu+2h4LPHsZ8ZoiEn1+qQKvRJU1a/DTrTANv+iRN65k0m/tDGE0q6RiJJ3oGzND/h4otvPln0VwfOSRwxPrxsTagQEErmj2t/4H2ysvv4xzJvLyPOdzqx2sS0CCs5AMD9bbzSbBsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497849; c=relaxed/simple;
	bh=5ku80iO5mYA9cdkGR8VMlpdrWhksxjs6noDVRuZi610=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnR6mwsmZrUObBnp1fRuME5vtCwL4onzoNI4j8lclUcgXGN9lKO8VUz3ws3L9OjrwUhboVHRGRd2J71kGaV+ehCh9TlpF7RRfqSZi9dZVnBU1aZ0oIEAGthBQj4LEbp3AvPfj3tKbLLnIZPYOUqFpk7uSrirpKmT3PljEvI3l9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YFjoaPTn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso41837135e9.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497845; x=1767102645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ76Tn6wk+dZFT/1SemDEgh7JP5C0Hyow55JGr1Byus=;
        b=YFjoaPTnGRE1txaTG3FU1YbxTI7MUocCYSz0YpbEWM+klfH+XCPyGfcA5A5oouoILk
         YVLlpeWYGqek9Z0o1IAWiCmwUB4mXxEcR+oVJhA3OvJY4FRgrRC3fl5JJd1mYJf0bDz+
         eDHpfYQwn3PXffBogxyWVxtvYu0IzXoOtddHM7dHtp9D0vco4Nau4hbzA3296hAMfjPy
         AiBKMWoyFAuxSk5rX1k/THS7U28lFlDcOvIO1Y/Kav9/jrAw2Tx7LiKsPmz1p3UBC3JI
         XjUSm1eq9GqE61FuvBQMLCAJPiI39UyoVu3kfCIfMGZLqkLPrHMT77osZimwH1LNpY6E
         8Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497845; x=1767102645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZ76Tn6wk+dZFT/1SemDEgh7JP5C0Hyow55JGr1Byus=;
        b=EWLWLxesf56JIPbPeoWmtkurOZO+X0NDfeM3zWg/71EpqfWZKZkkrJWaPH3GNf20CG
         jXPaX7WCLWay6YkcjdXOhiKqoOXxraYjhGuZu7uggXJdhvH5uLEUoIi81g6ORrrrUKH2
         GxF8mySZ7NwSGiBhRki3JpY8o333SrGSaNmMfhJSIaKk7WTOHI7TZMtx73ZdKnJ349Co
         cEjPrPMHx1n82nEm2g89FPaIIWxjaHrHrbKtNNElgJfvhfsI8wUd5HpUvqq/O07b6g9M
         AEHbDjmxiEJ5/K/TpuQ1+7KGYEdeTTIZ7zxhiEH/2NGLcuI540qI0iWj0a+WZEacdspN
         CWKw==
X-Forwarded-Encrypted: i=1; AJvYcCXeK3TQPawGJamhipfsMuKcHKstxfdG7jVsViP/NlZJ19Plx5BG58alqZDl0X5+RTQ7ayQ6GX1goN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/Vwc6JH3ocIdP/P2ppOYOkcFlcVApjvcJRAS6wXBLKCciSSo
	Zvx3lB5/W6zQCe0rQe1APdQNyw6ZswaQkpu9YegauI1cGXkArnuzt1xjidTeQHChFbQ=
X-Gm-Gg: AY/fxX7gUpwBMxBXLc8aqBytJxPMPnwICa6ID/pP6wWDMDKZJmtOmZZukHDu3XKFDgB
	hm1xKpN/CVug0ur9OmhwjFc8YzQ0xNCEGPYURKL7n/xGfF280vIcsX0WMQFt0yl7M96PF0sBqQV
	CzuASv50ayEQsaqnTIRYIFkE2+4wTHLa2nw5pNVO5V7511M8TscbpxcIfCzYVOytzkIbSuZEGoK
	Gf4AZXfGSrzULXZeOv27yxaxETWoAukFo+v5Enxge+pOu8MpdHDCQIWjyYulr7SDcPn8EWyLv/w
	lqkGZNJI5qjG3ebG9DnErpIQWC05SPrbLgtT/WFsbNY1wOoQBwi6fAuQk3FUmhK86UewpQB1cYu
	4thOY6nhsbAPpHM2ZUoOXNTabIB1Jr5dDYTf/elv1mYCypa/wbl9a7qREnaxRBIEBu3M12Ked0k
	04LQSWn2qjOmM32Wt///PR4l1HF+yekymC+givJEAYEoRxv4tKA3kEZD6ltp2QXRQ/P+5jfFg=
X-Google-Smtp-Source: AGHT+IFDCAPdLr0O9RM7rEnukky+OXqXM8/fNRsKzq2gxBjZCuBFZjoGflG+jDSFEXGrOkphHeoAPg==
X-Received: by 2002:a05:600c:444b:b0:477:557b:691d with SMTP id 5b1f17b1804b1-47d1959fa3emr139050755e9.25.1766497845376;
        Tue, 23 Dec 2025 05:50:45 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 4/8] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Tue, 23 Dec 2025 15:49:48 +0200
Message-ID: <20251223134952.460284-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to jump to the done label just to return.
Return immediately.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 43a772e4478c..a2e16b52efe8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -707,7 +707,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
 
 	/*
@@ -715,8 +715,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
 
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
-- 
2.43.0


