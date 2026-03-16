Return-Path: <dmaengine+bounces-9437-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NIqB+AHuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9437-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:38:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80B29A95C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F3D130138F1
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054A39A04C;
	Mon, 16 Mar 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AJf9WrcH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA6397E79
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668013; cv=none; b=Y3+9WwETnM7zv6CIi1qvGwpboMbdw+LPcclg0LMx/Xkde1cYR/UgOJ0JkrY1sPCfulmWCjshecF98nFk6IPUJg4riIgIw1l0EdovDjNz3jBBQSXd0uNGM1/CJr3JX8KvfNaArmk1nsGYo8ZdRZ+IjlDp+CGgWjDPyXW13+s8yTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668013; c=relaxed/simple;
	bh=L5geDWiGcTUN9x6Qm56Swndmi1WWAZi7fHSFPyS6Udo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zd2HJlElag8cMJW6eda5ji0tQIOqcBmuDpHg0ppfUXSYGCCd4e85dHambxo9PofSvEsF2UCpoW4NYOAtdaYTLYQb2TvH6dyZ4tbW302ob5XCW0Q8EpazNamZPw+WjXkFZwbxumzhi6ZxOaMBLAl5mroIZo3a7DWOdtBrSX81PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AJf9WrcH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a13d1c6f25so4769906e87.3
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773668010; x=1774272810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJLUcXBzmJ7olAbj0A01gWZuReFxSOM42B5au/jsgg=;
        b=AJf9WrcHHqJPmgZ5lxataPmnW9maV1A9NaWktxO4k9qkG6Rzp7/UQUgox9xie17R7h
         WymPYrqw7Z9f5Zv4rKTzSP56twifDGfsvN6hoqY1M2FFYHwlYniBElqTivTb7HtomsQF
         N4C35tydnyIt92EhzR39JKtznuEXJXD1B3sWZnVSzuLDxCfIaIWAuxjLbXdmNNYIiRFi
         KN3w2HzrjM8vyAK3U+iucbv4Dh1VZgVsa6hKkVeQs1TRmPGw9yrh/S+hdFsYlEfLbtpW
         5CY+wzxXm/EDFDGRGgrX4aQqMqHa4STWMZSxXob0/0C/zicsiV7E4FxDBxFCp9O9z0oG
         DKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773668010; x=1774272810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTJLUcXBzmJ7olAbj0A01gWZuReFxSOM42B5au/jsgg=;
        b=noEbBH9JFVWZ24DRlP9GoDn/peJD+CUabtodvAHTbdDzGALAudOKPfK2V4rvyn3kk4
         0r8eCROvo9wucNT3mFVYMNpY59fCQU7YVYqIxG+88OoQhBuajbYc9EV3NVoVup6jJW7u
         riwvGtupmHB04hzsFv65nTqyih86z+LDUbyRgriegy1kiPxOXmcis/lppxOZJ1OkwORx
         9yLqODEdxOHZ51JItdLV396pEmBkZ9LMHVxF2sLpwEcoRsBaEHjTxoA5kIcysal0dH7B
         MtFg1r9zLwN5XT3o1Z4ABvbsurHurZDwe1k19e1BzvnV+AMiu0uhRcD34C4szvwrMk1f
         QMig==
X-Forwarded-Encrypted: i=1; AJvYcCVmzs53qHsofd5/vhokv055i6akNIgt3KgP3+TIyew6X8qgMacDLgcLJKCdDREd6Q5VTf80Lr3Msi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWJopCJhtw+vokcHP42dFV33Gyl9kvNOORFweAbHupkEYNU+v
	v8p7AkcqzR0241IPnXEP3K3jRKShn6y14n9SxG/LMVUw67M8u66GqWJQmT5QUGOyqwp5Suf/3Of
	NhI8O
X-Gm-Gg: ATEYQzwUZconL/tsuJ8/qHYn4AgszUWFa+M3Qt1iednXWus04UTBuDYYt3rIvJGwyio
	8gz3129nA7496L5AbVPVMRCYWGAi3ODjuQq69/zVNHWxDFTDGslZQoTPpDK8e6u8P4EcFdyzqZL
	Y5eRqPIQiT6lWwFWuRWzNPK8Av2lb9clhwg7D/oHe0cSeJYPiP0RgFxAjSLzDTLgXE4uFgB/FHs
	jmQXbFDXDty2IE/86X6+2tBJr5e02DqvTSHkF7jJyOBO1XdDZI+p3HQQhbI2HTqamSkExVQ1N/Y
	rj0oO7V+J+l3hfiiUtj1kekUc5fRAuMj/S1saXG7Bd4zFS61RZWzvgWtZFBIgneWz1JWNC99owC
	FLcO4+cZrOh22macBRmUT4rtCuGrnr/V5/i2Z0HWxGPAlDiZYqDolPE8AeRbvAGQ6A6lmwTNpNd
	qfRQLOx2vw3FVzxgM9fc/mxE9whFOm7ajQvOtA9PCUYE9HdRBpO+zGENjeQgwVWE/2akgnl5FxI
	gNEI02KmTpFl4UTMw==
X-Received: by 2002:a5d:5f83:0:b0:439:b1be:819f with SMTP id ffacd0b85a97d-43a04d86767mr24243679f8f.2.1773667990801;
        Mon, 16 Mar 2026 06:33:10 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:10 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 5/8] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Mon, 16 Mar 2026 15:32:49 +0200
Message-ID: <20260316133252.240348-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9437-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 1E80B29A95C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none

Changes in v9:
- collected tags

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6c9bfe39a11e..eca62d9e9772 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -272,15 +272,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
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
@@ -295,8 +292,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
-- 
2.43.0


