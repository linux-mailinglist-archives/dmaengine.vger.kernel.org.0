Return-Path: <dmaengine+bounces-11131-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7axtF72aH2rMngAAu9opvQ
	(envelope-from <dmaengine+bounces-11131-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:08:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF36633C50
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JBVBkwcU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11131-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11131-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB873082916
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7F3E5A3B;
	Wed,  3 Jun 2026 03:08:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EF3E3176
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456103; cv=none; b=b9yTUAqWyx2hpC4JfV2JhgYVFKMEQhIhermlxAzy1IrD/zdSx+H23I7L4hD7tSHywz8IWusThx4cGSkrFEI9Y2sTaOfaBEkAvDjZXh+hwzQ851y2WVaB9EWXd6L50rR33HaybJ+UNwd4SEy34b/LZd23hpolSGSmr9pp4wJdzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456103; c=relaxed/simple;
	bh=xkKW8ssF61j3wciQU5I5OgNSDBxKhZtUrbfTMBdFQsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAB60h/GH/d+amME+oRof1rADvPYjGS0/7ORVLKra0dWofHpyOL5cxHIJPq57tF2wbg0k0HfumOXBN2u1aaz6lu7fBP7kIm8SnPmt8/HYMDWDu0FjTwnxJBhLCi1i9hnNjfcOCWvVMUI7zxZhn6120vthkWxHw1x22PjWyOuUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBVBkwcU; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so111547a91.1
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456099; x=1781060899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzSNw5MqtTwHbrXr4I82ADeuVf15/M6YUefhoKAdT3o=;
        b=JBVBkwcU1sDDCJ6T7Gxl5OcOCO7ZiWgLQfnKaCbbSIwaGOZaF9MM/zNzeRmWiBmwpa
         s1dP6fpaZC4OO+DBM+w5LgCoQm82MjqYpqUDLWaWwp2u9Qk8wDDf3M9194NN8+RRYkgQ
         TVeTwcAOjC3/45DBxO8/bsTDqbX84tBpxy8/AmAR5D/xopR6yCUknSnIZicycnASy6TF
         NBwwOhJB6VfCIc08KtDJrpBZ/IX9nbiOBF/DADvUg5OxJGvYzke+MANA5OyajQiOdqnu
         Cxj61UDr16hYeV0FOaR2tn7FUY5N78Q2vS6Ycl5HxRbwvdDHVtfZJrbrby+TnsjIkS+S
         48EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456099; x=1781060899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzSNw5MqtTwHbrXr4I82ADeuVf15/M6YUefhoKAdT3o=;
        b=m2Ho0yB+miYojz39nUFjIdwdxicf4iDK9GdfIvLddwSXoPWaYA0ZxVO9SpgKBLJOxB
         V1/CAYutlseWzFIS5k90s2EtmpUc1WFKgVbmbdIf6RS2iAu/PhYoJTP2WScu4xx+gkQt
         AkWBj2Y93Z42roa8xxJsSmNQMFY1VJmqAaqwXlNA67y+ISIY9zp3zLKlNsMdqdGfbQZf
         EPsvHb6kMb25IzWjETl03q89nipaSpXREk/DTzyA32FJBDegcT/z2r6Xxlig/uiNrMCb
         W6NEmeB10avQrZDs8NDnLrS9r4SFxR87zR64XBeoDsrofWHBpA4/EY17rfS/D3pYcWmR
         qXLw==
X-Gm-Message-State: AOJu0Yyym7uEhoW6BxVccnRLfyG7kWKtegXq0bUxiKhCy+phyhou8Rxc
	X3J+W+xybrrnD3VeJ4qhU1fTrVWWJweBzl2IbluRgxOoEmu7c5mAdacvtGtfAzx/
X-Gm-Gg: Acq92OG6R4BhgAZXizw3FLJr5b4FzJKdCIbQNFaq9GLrjHDaTQMFPPjnfpQxBb7IwwW
	tW/syUAef2Cror9RMY/nKKBxdDe46RAhsuEKw+ze0zAnx30GMFgT88FJFb5RXVvg61YfBaQYbJI
	QbujKPhIEcM/vgbcbclUHdaqRzf/BDmiGn3pBFA/k65sfKI9DXY/HRC2dZITlDW+1vz2qhgk9s4
	ie/DFTau5eT4/VQbxOq3FA7D/3Fp4gex8RqUhiioE2LqH4SGKTnu2Ep+shiJ2i+dPyu3brEhAuO
	OgfFhL2E9oYJWQ3F4gwBEHor77vIlxOsuaj3bDPcrGnv3uKibjSPxlAX1+yX3nOL3YD7U/ukU2X
	Kp00qRFWuDBDRYHDWfZJn1312DJgYiWgVR3nWOTNPcVzjdcA83HGbTQmxLKg4ThrH5BbiThQ7DJ
	uuwLYMuzqkp7y+Lv36525QINmfDZuGdIelMeI5fUnLvvHFAoAJoNQUvLtu0ZvD6S39DH5UeGOgX
	DHRQ22y7BCuuWzn5LhCXnkILwO3SlSVJ9xrTNFSgr5hkA==
X-Received: by 2002:a17:90b:3d44:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-36e385786f9mr967492a91.3.1780456099427;
        Tue, 02 Jun 2026 20:08:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 4/8] dmaengine: ti: omap-dma: stop channels during teardown
Date: Tue,  2 Jun 2026 20:07:50 -0700
Message-ID: <20260603030754.288757-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,atomide.com,arm.linux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11131-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:vulab@iscas.ac.cn,m:tony@atomide.com,m:rmk+kernel@arm.linux.org.uk,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,m:rmk@arm.linux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBF36633C50

omap_dma_free() removes channels and frees their storage without
first stopping an active transfer. A channel may have moved the
active descriptor out of the virt-dma lists into c->desc, so freeing
only the list state can leave hardware running against descriptor
memory that is about to disappear.

Terminate each channel before removing it, then drain the virt-dma
resource lists before freeing the channel structure.

Fixes: 7bedaa553760 ("dmaengine: add OMAP DMA engine driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 0ad8da8b35f8..cef4e3a38b04 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1521,8 +1521,10 @@ static void omap_dma_free(struct omap_dmadev *od)
 		struct omap_chan *c = list_first_entry(&od->ddev.channels,
 			struct omap_chan, vc.chan.device_node);
 
+		omap_dma_terminate_all(&c->vc.chan);
 		list_del(&c->vc.chan.device_node);
 		tasklet_kill(&c->vc.task);
+		vchan_free_chan_resources(&c->vc);
 		kfree(c);
 	}
 }
-- 
2.54.0


