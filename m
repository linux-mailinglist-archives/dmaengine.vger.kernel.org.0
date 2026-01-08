Return-Path: <dmaengine+bounces-8111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEBD025C2
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 12:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF3DC3004625
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85539A7E9;
	Thu,  8 Jan 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="F4WK8N55"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01D387568
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868602; cv=none; b=MzydXf3fQq8Y2bZritFbKrz1umP8H3mPjJG3L83Atrcn0v6dx642syQdlyq/ORdvR6wxPWYB3BTHquRp0mCLb3FX8HqnDjnvGAVy6/fT5KWpYHBc6sKkV3nJD6XBMtGSoGqVHTsQlrl3ueHSuajPweoDxC8jwQ4laxMLu/v9zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868602; c=relaxed/simple;
	bh=6WsUDBB7QB7beHKPFRpBEY1bDN8cUp493GVUrOWSTok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okie8dwDsiPOqgE/LTCOssdkMbwmln5GsT35HcxwgzIPy4TKnUP+6Qh4mQDAnSTvL4IUeCBGvn5bR5u9MXm2rFsXAPBWZsn/CXfi145Vki0TZ8Bes4UOzJWd1uk/ql3QYugmXx7Zs1lnJj0HmE9BR/6myaQmLZVTrF1jB/z4TFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=F4WK8N55; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so2502601f8f.0
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868589; x=1768473389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1SXKH3uUM3QnZfl6aZyV1ZJSZCTqIp00wyVEztqcnA=;
        b=F4WK8N55OHopne6Nm39snqKl9wIVf98Zy23Kptoef6q5194Pyvnyd5YiOy1E1Bwl3u
         9trMbOvQ3+fAlEH5gZxpi9Yp1IsMGKh6dM6+xyWge8yqtxqrC7iqeToJtrpt9FwfZJ0f
         lus8D+JpTeitHjrjZrdnXsMJ/gEqTg6Xljsk8TaC0MMsExcLjSM8LmJXj92ITgqrQ57w
         3Vqj2lV+w/krWrIcShj/O2AnftXBT9doPBDQ+d/leWhypNlp2gSw4cA0dNHrOlC5znb6
         cmR24xMCKe8ikD1+u/WEOLyltDs8RTnvoXWMFvVbbhawlDybf0KWER40ZEvLwQMP1gaK
         o4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868589; x=1768473389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1SXKH3uUM3QnZfl6aZyV1ZJSZCTqIp00wyVEztqcnA=;
        b=YxlG3d12GCuEKyCRDNBNrTMKug90adLd99iA40C9zF9rAgQtoPzt659pHAbD9JXsYq
         021iAQEd1ZoSmKniQCOiDVEnGqHpkSNfTxp48g+s5WcoW+QiFDW2W72M8rdlYWD+JhRr
         /bauLCwsa6yCRQn6WdcU7IkBGf9XydG5Hjct7ZOEPstaih9t3k7oIkadALv+TqmW+5N6
         GOYAt39CKMdEVOcXZXw5AD5B9TvlWOTPnCFY7QBDrMFRefvcVpv1q/BW8KlpsBOhxoTs
         xzYxFSFfZlHJjm7fPsLqbLFK5tZhg7I7BY4q47ms2XgbStxfrmhubFlTrhY8F41wyw+S
         hLEw==
X-Forwarded-Encrypted: i=1; AJvYcCUHnrarBtQEQGGMzSzEDbwik8KapNTxlS7r9DiStKp+2/2WMGeiZ0+1GmrdL9o6tc6UWnSAl2Rul0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDYr18xxTVD4DpUyiwVl+BexXC/iz0XHm1lSA2WlNNh+NzTCw
	C6JTTt/umacHkUjt/sv9YXrRCqxqkV6cBYm/5nvv8dTDG1TlWcDu/6bGV2Jja3x5t1o=
X-Gm-Gg: AY/fxX5EBREdGvIQJfd1NiDwA3QRZlfhxQk1mITRQoxUgEqprVHBFf6BCK+pVDjsuCB
	Yb1/ecRrzC5UoJCNbMwwuuNtIXDqZm1gAwTSdLqkRvgr8FipPLTvuE5ynR44IxegVQPkPlrYEOA
	3yBcKbRrPZ/JyoowdtMEPhmwPgISGJpBxSl5UGfTFbW1J3JVOUyhRFYxwgFZ9BSVIgBWNKB+OVU
	ykx3tvTr93Jh3gNec2NoD129gXQ/p/KO2Z3etyGdCpvoZHscN3Q6vZ72rqH6ktW/bacS0jpRsB0
	LjldVbOHDlT2fVNp6zL7DUiJOI4JYRmSTgI4cO7OUAb3Gmj2HFmYQrUsaX9MXvX+69JAIFAQhmS
	2annsOttPM4kmQ7Wr855askTGXXiWZqG26EierNQt5tQmf3IVs+VFNucWxJpgvFIu7D79VMOReE
	wBJH2zBFMXpN27gOH9jy3XERSeYcRXMErruSJc5XQ=
X-Google-Smtp-Source: AGHT+IHsxCiYx8rmqp77oAdTH6pZgI1q5pv2nheYrLqEiaVk/RQ4pqEz3b62xkFaX7spNJWohof1hQ==
X-Received: by 2002:a05:6000:2909:b0:431:84:33e with SMTP id ffacd0b85a97d-432c37d3641mr7597423f8f.50.1767868588683;
        Thu, 08 Jan 2026 02:36:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:28 -0800 (PST)
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
Subject: [PATCH v7 5/8] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Thu,  8 Jan 2026 12:36:17 +0200
Message-ID: <20260108103620.3482147-6-claudiu.beznea.uj@bp.renesas.com>
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

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

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


