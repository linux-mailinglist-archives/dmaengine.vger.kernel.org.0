Return-Path: <dmaengine+bounces-9912-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF7jBa4J1WnMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-9912-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:42:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A49373AF56C
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5736230A379F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43753BBA04;
	Tue,  7 Apr 2026 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="U1KKZCpE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFC3B9DBB
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568946; cv=none; b=srGSmnIK1E+o0WXIE+ITSTEfGT8efQFTqfGVBWushc68tZZSYkewBU/Px/jlpVo78ahOogq+3XQJ3cK3Zhy3YC9myRlbLsxFM/H1zTj7FCWSL87O3VCVICLw2f5WZW0vtYDTJ9cpWqAEN5bhKhL9zhtoQy+Nw7ZxVhaMekmekIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568946; c=relaxed/simple;
	bh=sc5J0ko6+f5qMruxGnuhxh+K+pC7up54mVtxLBKGuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3ziOQiVtfIMnUUaLp5EOyXp0GZmmtI/Tey3rv7j7+K/pWGoecX2sptG1mwsOKoFd3ycHAUowLv6T4YgqqdCJs4TYXGwzhsyehfoD/trhnM1C+te9G+SPLfKXG5/oTUe72lsnFn8cFP7KA1dJY/u1BVvs/Y4mke+bgOnpmh1O18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=U1KKZCpE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so34307845e9.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568939; x=1776173739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKSqR4T8tyfmhs9vyicABDHYtpzKYEAr1dHgduim9us=;
        b=U1KKZCpEFV6hig6YAhBAVymQNch3kbBz1itv8VBJv7rCiruZsoJB1ByggNQ6l4aYSN
         lt837E1FW2vaSQB5nliYBlI9/vloGzR47reJirNc1ngvCalGucPBx43d2EJUGF7SPsv7
         qKTLkcBTx2pfKW8WR0QBgfmYzw6hHamVpFdMztgF8EZbe8pki9uHl3DKhHXwOF536kl+
         0+WrcJSxuUqN6YbYF2JRMmTv6fGu9A1x4pPzGtve3fvUHPJhWRwwDKaGpQ6IM7JHxWN4
         hoTk35G5wCH4xds11GL904CVrnduVVP4hj3uQLQlKVDLoI9dMizpv0WFgYt4sXsxn/j2
         NMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568939; x=1776173739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKSqR4T8tyfmhs9vyicABDHYtpzKYEAr1dHgduim9us=;
        b=Y9Q3eakl8dMkDMOAbujuUesZS+/VwmF8DuaCjgvmqA/w/ZzB0lh3W+UKGldwq5Sb65
         bPmKlybsiFdMQiWa2/ZRzO4e7jyjJEtIpkENyN0FuXvFLrh0Y4FltW+OEAi6akGwpnSy
         MWWHkiiG41jbBJ7ReTIXVusBN+wjV+nbXOKaf6FT5nk9pRURD5POOY8LQWazgo3Bk9MQ
         ZuqK6DG/6Sh9JSvm/JApYu9XiSPNFaQaW85BsX/KCfDN9s/NInvy8ajkm9/kpGaReHuH
         K/gM4+GAj+d53/w42aMuJCFmyB9YIgTTvcI8J89LcNKr00y+1X6Auh2g9IrT/+fitRXa
         Wtvw==
X-Forwarded-Encrypted: i=1; AJvYcCUd5eKYNTyfDscHIJd2BBs6lVDj84elW3XImo0EFT721Zmap05NJ7DAK6+YgqIhFhvKiZ786qWrTLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnnH2ahAKK+QjA0T/Jyx/Ir1iU2W25nrhH7IzYFiWngHrSPSO
	cSag5IEKWoOUAwMV4qpeOFhLoMkuP6o7vGfmfLT1zbtnEn7odl7kJ86txzdlRZiaPU4=
X-Gm-Gg: AeBDieuRA2hQe9gsaj+krlCajqdNPMCMO22zkWhdopIPSCGSUOZMudRp0pgzPIs5Cgt
	IooIlo20BRrJxfhYkwl/SFC3JbtjTTQNh8Ybfb/yUw+fem/jDUxUIncZD9b5Q9jf5oN0KAaZvKc
	S8Qo6U3YpcgIX90cY0ToMUvDwrca4kBws82JPGqR2Vk3x/6ik5+Xo78zj40i3GRAXHZUstO3YTO
	4Nd5EdAw5/Dk8eRd6wvCfTHEx3suk3uX8p/H/Q1SsbaAW31pAZ87EyBk+QB4tCdupWtZlIzC4dn
	ZhAHT8pCuyEprxkdngd6t9PGo0zwFayNScVxFaqq9E0ebSty182j6T6hQ3Z6Hhx6vhcgjemm0bW
	dzc32U0KYV2sCGpJmEFZcoMei9cGhHNfN8TFTWGWfYJ43gFxqKGDwYUlHBKOLy/Wzku9s/y17JN
	38Pk/MbaSKeKWRth9Es9JnltJTMy1qMHg+BUXZ9tGgpF7tRvCNwgi31QteX3F5ueg=
X-Received: by 2002:a05:600c:2d07:b0:488:a82f:bba9 with SMTP id 5b1f17b1804b1-488a82fbd2fmr95263155e9.22.1775568939310;
        Tue, 07 Apr 2026 06:35:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 07/15] dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
Date: Tue,  7 Apr 2026 16:34:59 +0300
Message-ID: <20260407133507.887404-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9912-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: A49373AF56C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a helper to check if the channel is paused. This will be reused in
subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 083e81c07aff..bfc217e8f873 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -286,6 +286,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *chan)
 	return !!(val & CHSTAT_EN);
 }
 
+static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *chan)
+{
+	u32 val = rz_dmac_ch_readl(chan, CHSTAT, 1);
+
+	return !!(val & CHSTAT_SUS);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -822,12 +829,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 		return status;
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		u32 val;
-
 		residue = rz_dmac_chan_get_residue(channel, cookie);
 
-		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
-		if (val & CHSTAT_SUS)
+		if (rz_dmac_chan_is_paused(channel))
 			status = DMA_PAUSED;
 	}
 
-- 
2.43.0


