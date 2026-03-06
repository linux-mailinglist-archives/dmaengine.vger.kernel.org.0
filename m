Return-Path: <dmaengine+bounces-9299-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PcsCUTNqmkNXQEAu9opvQ
	(envelope-from <dmaengine+bounces-9299-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:49:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734C220F3C
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D5631AB08F
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986182F6193;
	Fri,  6 Mar 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MgDLNuim"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47502285C9F
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800904; cv=none; b=fZuzZxt55jqAiQelIGer1r0zUL/CBTdLGpC2qW4H2go11PF3W82oJCDOQVzxTdCrdnuEthTucFAgfZQO39YFfO1wl1NzT/UePG7A3XzTPZXKfcGz06du09f0O/HH84Y0ixehqnAc4FixQI9w+Xk1Ub2VLlP6NAg0zlavTS9Crfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800904; c=relaxed/simple;
	bh=SjCE/QHioNwLTDQuUYwPk6oerv0xCCcUmYIaEF9w9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZ8s0NoCj+QtckjKaI2bad62BRz0te998b+hXf1Yykiq0tdIl5uXKifFrWu6vAHWFBeq8Nf4l7DIaMT13bQJ43Sw53IHzlGdFErKO50FBJLgx7WRhxldJXg7wisV81hohvHSkdv/oCRTnwr4tDBi02WXjhIlBLqZkjRHlFO00zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MgDLNuim; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so104597895e9.2
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800901; x=1773405701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdAKvTV1z72NR5PYnaT/8EadbSxsVoneWRjGufMFMis=;
        b=MgDLNuimauUMfytoXW1D4QnlFlhMwqrZSRTqyZw2oz4V82C57sIw6NAYamBJLRsSoh
         xLoHA1KcyiEwUXP1i48pHbwODCQtr4KRwTCLo7c3DuJXmHGmc9UAlNK4Btfn842dFVg/
         oLpz4eOCqtCRTr1d/3QARBajXQbseg6ejsdzx7rarleZE3lNPzzLzk/ZMEAwNrEgNO5N
         uwrepxiCgQc7STIbRfHpjfM7yi76IAdaiyyqJtiWgesMDY3n2A/AS17yGKwo6tuTCXLT
         wtynLGHcsKDcQbx65kznAu6LU5MrlP9NhNMt7cbu4UFZzSlL9Vea105hNBWUrJrEUOA0
         rxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800901; x=1773405701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdAKvTV1z72NR5PYnaT/8EadbSxsVoneWRjGufMFMis=;
        b=rDXOE4lTDRA1VQdLfxA0Udf91hu379ySVvNFz+StFEMQBnTGHgJkHl96PxMLoJvvF9
         YhWX7Vo2LgjoucNJYBj4laLaaXTBq1bI6Rq/V49kCndWViqG4zkpvSDdCECy2n6JLLLG
         cM9wkfDd6TUNM6xrdjIf2VsZsiiFk0Ozr0UMmv1lonrOjb3mM/vV9hS6s91iUOQtGLXm
         XMUUxXthNWFdyPI4Aqn5fkaRtXD0L5E3V7KA2Uu3kYmdcCK+Wczhn/jE3zPADWeoabtR
         aGz9Yv8xn3C1Cd4dHQv3kbAHtqVl/aQa3aHfzPKBk8M0b16werq2PzOnwRjv9bwlscTo
         KCbA==
X-Forwarded-Encrypted: i=1; AJvYcCXESPSJQMGQEtpDnpP9Dw/J0NZJdABEa7NofEOOlMDB6zw5rDkcTatt/wV4Y/xXjqKqYPC81jRKj0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0vppMyUgrcTaMsWLZMpaG9i4rQ6XKjC+50SbV2WcHKorVNvP
	4on3yqJ7Emo9H6+oA3beF8c3tkqWaSx8YO9/uf2n/nZLEpCLAyarn+M80rXCYpsLRrQ=
X-Gm-Gg: ATEYQzyBVj3I/EL3MORGTHLtRZhiPxMPla6y9HxxOgWGlg0jv36w+CpcP6h6UIeZXTf
	xUrCyBsPymc+5QcUJYEzncXquLNG61c7v44iS7o7b852gBt5xwT8tcX6+Ieekr56GZ+TWQdOwS1
	ou5zUVRlQedgnLXteOnNcWQxcORa4RG1VtlFhf5LL4LclB4tHqZSSBy4EtORnRfPJwcezh/hWqk
	aCm++jqzyV/WXQWepXqi4hToLB9ap48SRRxb6ZbUZxl5FuTEpuIbXcHtgQtKLtBISUWZzwXp/xH
	i/D31zXPMDdIuDnO8xTzpqp2idwe5jp8PXlSsjOL0P1LFiRIF1fLaWHCcGPnLxlq7FcFlkqSJ11
	PPWu7Z0TRwDnI/cRPxiZYlyxg2nUKZE/ClMUIu4ZC7/0fZqi56rQyfJGH5DQXLpq6y/oVN2PqNS
	jCEl+1qvloa+7ty2Zsgjz1EV3oQgbCN/tX6iNl23vK4h5usbt7zuuM
X-Received: by 2002:a05:600c:3acf:b0:483:b505:9db4 with SMTP id 5b1f17b1804b1-48526978d8fmr30254655e9.31.1772800900661;
        Fri, 06 Mar 2026 04:41:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Fri,  6 Mar 2026 14:41:28 +0200
Message-ID: <20260306124133.2304687-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7734C220F3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9299-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bp.renesas.com:mid,renesas.com:email,tuxon.dev:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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
index f30bdf69c740..2895d10aa2c8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -697,7 +697,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -709,8 +709,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
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


