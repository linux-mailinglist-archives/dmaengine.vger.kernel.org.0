Return-Path: <dmaengine+bounces-7896-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71999CD980B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC37305E78F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E02D4806;
	Tue, 23 Dec 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ls9qBBIA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4C2877EA
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497851; cv=none; b=uOmpGHgIpiINTVK72iaOztWjPc4QtVK8XcbrfCe3JtXN+IYZcUsRtPM57EuBBU3TihEq+PRFTOBMc7+8BH2oDHyhL0rpgYmz4Xt/OpHAUqIB6iNaCSPbTrJyslow5FHJB/BwVt5SXjshC0aCHfnTJHMWU057gPjcNA3PhPoMeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497851; c=relaxed/simple;
	bh=Km1aZNVXUokGZG+Hi3ebns4lEQqHpnqjkOASGrRxGsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8fhlDKEAYRldz9EuSHvXMhek/SJdxTb3geyOu4xBjH2KiP2jZOiQifinkl2DMPv8X/A5/+h7fk9C7ipdZdAgX0EDqdczQj1ycOiuSIqBfAcZIPSoJqAvkBUj3hUp+d/uGM9tpCqws/u/I9yCgiYSOzsxZ6Ql0ucvxNnPCkOkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ls9qBBIA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c28778so57505625e9.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497847; x=1767102647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Kc5eyb/iSkZT0bPBeQBdO3AtAfI/oXN1kmysUx4qCE=;
        b=Ls9qBBIA9EBJHuMbc90vpQVDt8CG7u6wfE48DnHEZ2dkDbUd1pZ+p2CF/XjdACDAcq
         2N8aqwCuSqg6SdNALnz9JDRyKcPzH8OZhg+C5Fr4valnI57OF3gk3OJBrVfsGNhyoWO+
         jzTa3WScoBI05q7QQ/IGK+7Mnol08DJ1JpIabzSvtbqlrRkXa8GPDQOWPSsfShvGX7zs
         tyWhNfdWSXHUKyCYX1X5IEGbKk4QU6PokaP/siqIwmkNJP/qAxJev7Mpgo9yZ9ELRFqa
         RJTx5OslcdOpd4CfJvk8kiodGOfaGfod+mFAlPUZiiJUqJCuLv0rBHskMQ3iCbhqDUgb
         RoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497847; x=1767102647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Kc5eyb/iSkZT0bPBeQBdO3AtAfI/oXN1kmysUx4qCE=;
        b=EKypSh2v3hi+YOfZMBdNzui4sYiNJpzeN3Pdmx/pHXyGLzkzoF2DRCbe9dbc+nziN7
         172V2kbHzRJI6tFVlC3cQeCLnD4qS9SbZ3Hu3rZm7rjpjTapBmhXGrlXTdwUW4DnXcRx
         F5tt+DiF/t29bj6P4aZqy8yzdtgIyz8QCtcgcPDsRKMALK7Eo0hOz1GgQdO913ez64G2
         0X3E1/XeF0pj+cL45gmVwUbpuWqRTdLWOIDMR2x7z+SsIWvHNUcBbgAPPu7ag9ciPOC5
         g+5f+HidQTNDrxmc3M1zDOihgqHCWD2JsgVhDnngYZTMhqP5f1jfz5RhKoQQq0ei8Bt4
         5+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXVfI9/vZnukVE1OcoMIYtR3qjhNssD7or1NIrWfJUT/cBlY1nOl9FzL7aS2HiYmZa/XPg92O+JEYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloBuUqDoxivC9ANPoMZMjSll4REulfhFZMWP66UqnQTsBrm+R
	KN0Ryvv/rDD7G7xd9oPvn4/8/AYmq25dOXf0hYBiXGZyImr5GUgWLtQET7XliQSUOLI=
X-Gm-Gg: AY/fxX6GCqsm116rkRHGtrE5DRiMq4TNlrjucGh9vY+Qu5vx+WmX+TxKs464TjcTDP+
	FBPRbCqzzL6A8OW9RL+deQst+e1YIul1Qd+jRufSHfg9cvp5/R/Cqgz7xtK8kaXUxhn9gbzlddc
	15NQxfqdAiORNoo4G5JR457+OnZEGKri5aCqntS1quMlQm4DCBoi8MdG8MjPo4ut22z6EIaxv27
	QQpd6yqmOmyHG83uQ9eqYJRomPHgPqujNNP9FIkxfBkSJudfzVfCGzOJiPBzv3BC0QX11AJcE3O
	7M+M4I1NNXmzi94ITzXGKho79XBAP7U3fBjafBKSiKTIrX3+XPqiBWNmsirr34xq9PpmZS83Esl
	C1wC6z7kDY3SPQdYtYbg9aNbyBMoGPL5P3Ofu442+dE6bz+CHt7HWOAMmb02ahSGVsf5BUUWFc1
	2AcM4TRUROShBcDl8ZlznhsBdNSxhOuCIN8ACnLQhnebbckHsyGaXitV/AKAcfwALZ8tY9RcY=
X-Google-Smtp-Source: AGHT+IGuFz7Ozy02JtIIyMczbxKNk13M+AOoYfGj2cgq2MPwqq4wKAu3fvsA2DoiHSohIMc2z2Wxuw==
X-Received: by 2002:a05:600c:524f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47d19594b2emr132953945e9.20.1766497846787;
        Tue, 23 Dec 2025 05:50:46 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:46 -0800 (PST)
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
Subject: [PATCH v6 5/8] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Tue, 23 Dec 2025 15:49:49 +0200
Message-ID: <20251223134952.460284-6-claudiu.beznea.uj@bp.renesas.com>
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

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index a2e16b52efe8..72ec42fedac6 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -267,15 +267,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 	u32 nxla;
 	u32 chctrl;
 	u32 chstat;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
-
 	rz_dmac_lmdesc_recycle(channel);
 
 	nxla = channel->lmdesc.base_dma +
@@ -290,8 +287,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
-- 
2.43.0


