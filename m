Return-Path: <dmaengine+bounces-9434-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DRlFIgHuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9434-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:37:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519EF29A8F6
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42F16302F8A8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1939B4BE;
	Mon, 16 Mar 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VeJfnrRi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802439B49A
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667993; cv=none; b=dUOoCCUz9AkP5PNSgYQAcJIModx3/wb3/kPW5AL5bGNvQJExjXfdy64LhBK7ZWQWM7nfKt3MACBYfXTyApZpvVLNq6gUFO5y5S6Ar3ntMsPk2hqTeyW2YfPLmzTmAPLqfcORiEl+T3TcI/wonKH+8MeTJM8yw1ggpxWpuy2x9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667993; c=relaxed/simple;
	bh=BupfuUeepmoB7xVVwacbx2/wxqNrZQtov+patEo2Bt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYOs4nYD6IXooJ1Z+f5cegkeVWIuQXDuMzeF61lT5kPEYUg5DoRWv//uiRBls5RC3l7qbNNxQ0R6QNGGVBxUu6z0Uencmc+ManizmYLHwZByGuSsN3XxRIeVfZaZtGlGwAJV3IkOOJko9ulDb1+CWDvblp3wLvunjXJT/V/m+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VeJfnrRi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b43f5990dso624754f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667991; x=1774272791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnXG4ZrgMRGRj5vokF2ff//q4bPBRfw2gjw8/p6FNyY=;
        b=VeJfnrRioHx6xxRwxkaaHnZ1iXpNjInboJvy8Tvs045iwRSaLm2MUHGGfimm6aOl8b
         NLiuS37ZFhJ4b88q/niNjTQ6x38CYmEWXdfG5QEvWA4zusoWR8t6n09X46WYqAGJmueL
         1UAgxTxMrb0U++6sX1yMpxxxZna5NGrD4gSL0fIWMpiH5K/qPp4yMl9a4GBpXaY8LWSf
         AvyKJdllRI6bcoHnAaqDbQZ8B5Hp58ihomU5lpD1WzhSRw6nZ2U67vQcXT3L6Eo8ZBK9
         TXyTTVWiUeVOPsBNIu8KSJ0coz4ln5IIzxYTjmFoRkpsEwgedZpaFysKnu+9R8fS5+Ef
         LpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667991; x=1774272791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LnXG4ZrgMRGRj5vokF2ff//q4bPBRfw2gjw8/p6FNyY=;
        b=BfRxS6/uULjqHP3Ya4AfEhOH9QJmiYhlQw1LLmLgA3AM2w2d+QVIjpRT5Wk85I2+lm
         Hn47ge6cqd4NS5Polhke/sJcoRF7LiQ5RORwQPCQJBjVvg7eWwNDBk7vnJYFfuKtqV3v
         fcxBRMXOzg4wfuqxEfN3619N5sHamJuPVGza1dCczQfmbn7gRB+pIngfb3QMWuIgqlki
         8/Id0dT8J6UGjLsS6b7AwL6yiIhsO0xcTZriS2TxqsaQcSOWPjpEbC8fzbpl8AB526FI
         17MRaDbw306RoDpYb+0oQfbVMRpDVBt/PoGeuxTbP4E3jqng6kG0yWHs91Ctn1zbyyXo
         vIhA==
X-Forwarded-Encrypted: i=1; AJvYcCW8J83cngz1XmLM9beKlZuPooMSgEJXTOz1iX5O2HFGAg3dTOY6zMQ4zThT3r9c0P6e6kW20edA1DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2l8FiAqsTdz7kRDSjVYIBHRfBG9jom2dLr2jKVUWRfNL56ron
	ywdiSdwpAXrnEJHnTKtpVhOVvMOLXHnl74Xs090voZBWFwqWC2761qYwq0ybtwZACyo=
X-Gm-Gg: ATEYQzz4Ggz8zSZsmjUYnopEbDZHWUR/neuu1+sXfGHvKsROlNUY92QweR+sLa2JX23
	aH76oSw33h21gGp5Z5xePZ6AgUfHpxTI6tSuYy8Pc5ljQffUN2kEiEZUELvyvU4SEmDtmKovr+e
	FTJ1TsU921jnwTPpWXhUZhXCrRr0vu40X0kAfxNsWhM4I77CECSazPSyQGeX3mFOdj0CMKX5dad
	2t74OU2u9tKxwmLwfvnqdtslp7cL5YmLurIpTTa41IL7JT05um0ZyHW3sJYo7BgRDqo9b4YiOHq
	OjXSbNigD4nJ457Ig8aRnbBseeom82L6N6LhJH7eZ3UY+RIfdyeVcsoqDKVmzF9ZZ8ujcVRMr4W
	6F37+KhR+H1Khyig6tXhcCqsLPrlu62zEeBdXfFkJwI2o/gMw7v4YAR5hqRwYouYCLpHyPHcKdC
	bxxtyYiM06AiaOl4YPadrznI8jI9XqVcs3NEPwQjk1qOQscG+WswF1C7nJOVdgs5Batxv3OrBaQ
	e+wsGA=
X-Received: by 2002:a05:6000:4210:b0:43b:447a:11ab with SMTP id ffacd0b85a97d-43b447a134amr5408871f8f.2.1773667987544;
        Mon, 16 Mar 2026 06:33:07 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:07 -0700 (PDT)
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
Subject: [PATCH v10 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Mon, 16 Mar 2026 15:32:47 +0200
Message-ID: <20260316133252.240348-4-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9434-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,renesas.com:email,bp.renesas.com:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: 519EF29A8F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The CHCTRL register has 11 bits that can be updated by software. The
documentation for all these bits states the following:
- A read operation results in 0 being read
- Writing zero does not affect the operation

All bits in the CHCTRL register accessible by software are set and clear
bits.

The documentation for the CLREND bit of CHCTRL states:
Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
Also, the DMA transfer end interrupt is cleared. An attempt to read this
bit results in 0 being read.
1: Clears the END bit.
0: Does not affect the operation.

Since writing zero to any bit in this register does not affect controller
operation and reads always return zero, there is no need to perform
read-modify-write accesses to set the CLREND bit. Drop the read of the
CHCTRL register.

Also, since setting the CLREND bit does not interact with other
functionalities exposed through this register and only clears the END
interrupt, there is no need to lock around this operation. Add a comment
to document this.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
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
- collected tags

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index e2d506eb8194..29fa2ad07e30 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -696,7 +696,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -708,8 +708,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 		goto done;
 	}
 
-	chctrl = rz_dmac_ch_readl(channel, CHCTRL, 1);
-	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+	/*
+	 * No need to lock. This just clears the END interrupt. Writing
+	 * zeros to CHCTRL is just ignored by HW.
+	 */
+	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
 done:
 	return;
 }
-- 
2.43.0


