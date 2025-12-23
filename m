Return-Path: <dmaengine+bounces-7893-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381DCD97F0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B3C3038048
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D55C29D275;
	Tue, 23 Dec 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QVgACvO4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1A27E05F
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497846; cv=none; b=qwTiCKI1GEqCWoYLAAWN8zAEAeLYBQmdT0frsg5NYCGonpc4Hzc4goIv0PLR7+6jvV1uFZ8PNJy2YxCheW9wKUY2fo6/R9Rkt+ff20Bo+CIdmOmXLKNgl+SbUuhAM+OyiaqRcs5B15DTnhoBUSf43lBStXEWDq8uotU60nSZaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497846; c=relaxed/simple;
	bh=NuLQyH+VwGHRR72oMwwugrjxP5H7eBUcMTxjyn0Mn3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEwhuj4G5lCN1lxZDP3TKS+KwsazRIrbyGJ67sBKPjHuh7efiEUTYhr6bpzrRi4sAXFsPGEp/AX0Ng+qLAmMoZeeNDWE+ycs18T7Gv8htTsIzSD2glrhgjCiRYRnu1qDZchWWu3PfCRXykbeKJDB1Un/nvP8MuTpU8yAdwjqdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QVgACvO4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so39920985e9.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497843; x=1767102643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ9+0Yi+2nkzLK6cHQIgso5yqDARPMTK/Jx14dRo/m8=;
        b=QVgACvO4Ji2edDIbIDuO4Epac+uxD68+ax1NZRPHt/iGFWtY8dqRK4jBGlLKD1siKu
         d8gpyewQulDCmeRGgeCnRo4iCquWHqc/ErC5uu0fQyBxxahp8bNSyRpDIV2/hJrjHBm9
         4uudbx68z4IoY621r37QMcv7SgmJmO+DE22P6oMlUUtl78f9LVI4XbkSMQKLqBquhqTD
         zgXOY4NU2GBu5tNWJNTMl46A8peu66vO++kkCUOwmD7IuCC6hczzFJ9fqCi993oNQsKz
         +j/BfxiNZYW3sANhjffLVS7rucZKNlg9zn2OcOQomP9HRW1pYZ9vgDvakUnMN+gVWvLN
         pJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497843; x=1767102643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ9+0Yi+2nkzLK6cHQIgso5yqDARPMTK/Jx14dRo/m8=;
        b=tij+8+TOFPuS6xHGZLdLHXWhQpJkbuVxQdV8N6t1nwGSOF0IaZ0/kTZ4plyLyEmHpD
         ndwYUVE0b7b1oXi100nKVCNAuo978TgHQIbLBNbJBY9jbfObWI7AV1vtj0CjZ/eiL18Q
         VWXY7KJx1DZegiy+GahxjoQczcEauVM2B03OPbB1FT85gNLwRf1ydPaYSU6SbO4eivzu
         bVdD79QFPNkIToFot+E4S/KxNAJwIZ+470X+sv+BpHuDjhvQznV4kN2VgzLGoHE+dDs8
         a9kOy7b0X5PoKjoB3X39bctYVsckOOOiktPZYM7C9UlIC5VOJH32XfiqNtQ/sblIUJfY
         djdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/6rriOaiagzhPRth12+NNyJ+dTRMCWPEVfI/AAQ8gnd+LgoHht9vxgcZZfvbOoomuOH69T9SDO9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ah9mhlaPgx2e2ypjfeTuAs9Yvue7irn+c99lQq3YOvSp++Wu
	nGF1KL5WY4oc7eyLAlpyrKz4Ga4/vUIge6BOschIsef68mVx2Ye4SMJmV0vW2bc0jd8=
X-Gm-Gg: AY/fxX5QhEvRXRc54oYO0/zLfQ6s8FGmFGKqefZNOntClDBUi84RT690w4jp0O/W4VM
	bx43v/wyd0gK8JFFDZupzzZtFPhspnU+MRYnAmGmVRzPTrdp8RhmGa/E7Ly1oXt8J/Wpk/uoTTv
	Sv1zl8pa0Lu7Jn7lB2wN6yR0uwZ6Q1E2tq7cHmja85y1cGxXhA3Henee4mbbDPrJVkACWQyLnzu
	6eu9DSXDfM9jUUDtNbXtmiEymAE/9RHkAUe0W1CSgC4f2osHW7g31OJfESmUcF9HtzKPDFMQQYy
	fz08wyUIu1zLPbXM14THrPyLfxGyo/tmZ2UT2aQI2JgLC4+xV+0oLkz70sby2bDAQ47eNArxK6M
	gGSHdDkbnE0TSnleYvz7amYPx7/0i0gj1gmSz5eMg9BYeGuLtzfJ5YezeYLt7rGhAWJCkY5geAZ
	mXH2Ou2tWgCOsNEGylTwEc0+AZU0TjfSaoTps/lR2P4JszOeR1r7GgEMdQZ2mjJpy40oP8HJA=
X-Google-Smtp-Source: AGHT+IHKxYmc9Jyegqhg5MAp6RDYOMSBp3GbrsFKuRyQtLXF0v+7GhMm6p7R8YXuU3Tk5WSJGR2hMg==
X-Received: by 2002:a05:600c:8b6d:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-47d1959d1d8mr152368795e9.32.1766497842594;
        Tue, 23 Dec 2025 05:50:42 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:42 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Tue, 23 Dec 2025 15:49:46 +0200
Message-ID: <20251223134952.460284-3-claudiu.beznea.uj@bp.renesas.com>
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

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- update patch title and description
- in rz_dmac_irq_handle_channel() lock only around the
  updates for the error path and continued using the vc lock
  as this is the error path and the channel will anyway be
  stopped; this avoids updating the code with another lock
  as it was suggested in the review process of v5 and the code
  remain simpler for a fix, w/o any impact on performance

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c8e3d9f77b8a..818d1ef6f0bf 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -298,13 +298,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -569,8 +566,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -707,7 +704,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		goto done;
 	}
 
-- 
2.43.0


