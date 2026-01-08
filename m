Return-Path: <dmaengine+bounces-8105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0AED02320
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 11:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4AF230B8FCB
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F54BB0B5;
	Thu,  8 Jan 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iUXeLhAG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4034B9E53
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868590; cv=none; b=iEuW7IflPcmReWx0I+UgTMBZXlbKw9+S+PR4BRtLoldhspjIDARWtprnOXE6SBxa/qUT2dIezXSN1QqHVZyZ7KQn/FUVkjNWg3oBYggG9gxrFt6i/aKPsdtI3c6OMyajCNfnsxUXX0Bjvp8xmFytrhkKdql0b01eJplmbfiGKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868590; c=relaxed/simple;
	bh=fyzinmoZgqFGQzgRbE/I7nHy5ErOVP8KVl3+X5XcpuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjrFccw2elWsUlI6o6WhQ4whnk5iRfe64r/3PJHgRV7W7Pj+DFRE626BkKbDUxY9l6yFvJRljCFBJ5Xf9iuscuz1M1SshlvlqQBurfDMTdeqH3zbKBIorkK9BXhHduz9t0tCaAt875LL9uWWIjRKNLjZSp5RSWJdSCv48P7UyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iUXeLhAG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso8836295e9.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868585; x=1768473385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlWiT31f3SgtmE+UZqtSfS3Vhw2y+XyQEAsJHfCJGJM=;
        b=iUXeLhAGI09KUOPeDeh8Zl1t3KTkrzO/7Zo6eptFVMVvnKbjOdutNUKNqbJWY70fq7
         CtEFLjlC+RurTj9Spe/BZuwt8u63uKKMPbiPOFximl4d6n1XDDxBScnfIlXyfepWEncH
         7lKVnZ6yR2hHNbkF7qw5fwVjG5FdLWvVfqeynvHXHB5gnFhbNPOj+2WCiC5dhdC/IbAJ
         nGUbpMUQILA0GFQDhBw9lPHuYH8HHdhI+iDdnVgEV0jJlPSmEc9H0YnE/GbooAHtovso
         bKhHXMt67GzrX1zfR0Hf0MFZ6phJh/JbDPPpgaUkoWp/q3fm12pMRzOvrH2SPeebTrEg
         bxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868585; x=1768473385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MlWiT31f3SgtmE+UZqtSfS3Vhw2y+XyQEAsJHfCJGJM=;
        b=flu0KPJkJ1/T7zJbpg16JFpccCNdy8o07btIRQ7iYXZmCzRuMJOVxfUM1up6ER24JB
         n82rKpF5v4aU5w1CfE0x5Wu6xQxhhO4cPsTl8nR8EFfPNGWojI8m7Co1cqj3YlK20YKi
         bsylTgCfm/l/muzr1NAFiNYayYyBCItfxJB5k6kk0y3mki2e0BJTxRIAmmEasPFgrSwF
         EPl+IAwmd0TKr0i66hyFZlzPNN921yS6AM/7uQZbgwwrA2jMZe93DE4qa6eFtdjH+y1G
         TLip1NbBVM1JQXXrwBsxNaJpgT0JawUGQAhv0TTyzskdy+odDl0b/fJ6Kge3o3ajVLuc
         Oi1A==
X-Forwarded-Encrypted: i=1; AJvYcCWg1yPSe/wcgvvzsmMhIRNdbpmlyInd8Mi+7tii1+Os7M/l8xq0+G5j5P4fekWMuRPvoIOGcbCGuME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZ5GUJeSr/hvslFUoEV9UXP8ciZneWO/OAe/i6UG+2XQK7D4K
	7TXc/DTC/GsfsphuReO+YZBQAdv/Dk6laXTQnSF6E1eCK02u4GlN8kU7xSUFvSCqJTf3Y6eUwAi
	ARN1D
X-Gm-Gg: AY/fxX5cjxugecGbhh6TrB62XJrjE55VNtj2mGyvTpDGfhK4dYudRJV77FycPixBh36
	4lCxuGtquNDNQlb29lcqJbY/Or5EqKpDHm1Ai5IAJnQZwJAvqYb8/mbcOyalNuxEkaQbQ8jWiwk
	5DnAoWSEKdnwcNB+XS7jUQpgC6sDFaYWPwqOx0UEn41OiwkKjiBCxko7LKzFurlq8nxhVmTYtKP
	gyfRksFDMW6qkXXvCu2aMpAzBr6ntF5j/IHZsMKMALlDPOc0hTfSBpEP/7aWHihM8tIDJqRN8iD
	Gzo50TJ1cPcjDzuF9YQrbUK48XNzZIM5bqBrWCcSJo+hfXlcvXlOb0KLFw3mZDedP9wSpz85kUy
	7F7gp90rCKuF4Du9I6wcJOLxzfg/2R/Lkhb6V4DXyOLmVc2U6fslMpELSqdUi1CQoP3xt9IM1hW
	6w2hmI87Bgqb8mF/DzWxmfwjNW8VUrBQQYwybSRmc=
X-Google-Smtp-Source: AGHT+IF+EBHPhz3JKj5aczdkdvcVVpNzewaaim609iBvVtqQDrzRGqQxcaDVKwG6DKoC5k9Zk7ZRjA==
X-Received: by 2002:a05:600c:8b44:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47d7f410cc8mr113421185e9.7.1767868584926;
        Thu, 08 Jan 2026 02:36:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Thu,  8 Jan 2026 12:36:14 +0200
Message-ID: <20260108103620.3482147-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- collected tags

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


