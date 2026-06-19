Return-Path: <dmaengine+bounces-11633-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yi7SH+bLNGrqhAYAu9opvQ
	(envelope-from <dmaengine+bounces-11633-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:56:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B576A3E21
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:56:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CHDE80Ng;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11633-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11633-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5963050686
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46F833F5B1;
	Fri, 19 Jun 2026 04:54:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A133D6D5
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 04:54:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844877; cv=none; b=nLbVBqBoDgxhL30V+Km1bZVfhGqh2qtglZ4je3Q9bjc45BmgWASvT6pO8IG9FObmK5pHF0H5GYLtfpLTzVGF0Zu+SNTJQFKXMenqvxSDA7rT/uamONCboMutpxO8CwTbr0IYZqyuWOHepI6qcYG7CoV8G8m8suEYVgm/sVx5tOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844877; c=relaxed/simple;
	bh=1/J1QDc8wYS4aTyB2hGxeW2e18b7qy0uZ1pmyFz9DR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/L2OkwQg/I8YXnFPQ8IAq9b19afPtA8V0so/f51LsYRT36PQ+IbKoq1BW7OCHsCYvw/juUMNdID1Bw0m9eJC/mJV3fPmNud9eZzoczhKoGP4/qcV/oRmmcJ3xbHRI+W0pgvk2praOmEpNPK77kUw741mcwCCxcg3yejnxvxMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHDE80Ng; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9157ec935c5so254564785a.2
        for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 21:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844875; x=1782449675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=des/YMvzXKFvsVSBqNlCoInqunzXPQ6/th3snijZ9DY=;
        b=CHDE80NgogKmp1+q6QSB4m/PafmrebiGTEUzVJkanCGtKL1JxNlhGY70qniY0jtBnx
         a2qs4nIqJluMVg3TQ+tGPW1tfbdCkWwlrca1epoQ7TmQFppa+vI8/0QxOZ0q9hjcJaWA
         hRmVeh1SRBDlpnah75Fbck/e3RxxwjbUwAsgQxKrrwIFYO5Ckw26J0Uq6Xeq5rNAbuk5
         DlNIHRl8wxVUv324QtMs5de4PxmcC2t2hIX0T7o2D4h/1HzIZT/JAM1MXF1TxW9zB0op
         vItDbCycM5UOzdE947XPHvT4Z62gsxfn1QqLaQdjptPoCDV/SCRhXYRSVxQps8Rw+Rgv
         Kuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844875; x=1782449675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=des/YMvzXKFvsVSBqNlCoInqunzXPQ6/th3snijZ9DY=;
        b=oIrwuEHvB8jEwScHSporuCy/z5TO2KR9qfXV6j71pvbJpTmlqHmUK2pa0/eN8U66mX
         roMlf6zpdtxV2GWJebtcu2CndXpThsQ7ZfUxCenmk4eDaXDuBC7YUq4VtgS1XkpB7SHB
         c/l3uBZhFkN3OYxKgYLWruyJw+GWqczGtTYxGEvlOCK4ien7QQujKQ9eXedsmxJQEqWG
         2Q0T8cKfj5RofKzhslV5VEX4okoa2nrylybvuFcW6yMRXpkOJPCdV4PH1cFNg4AyPkn3
         +8+zyt7z/KnBE227MId9FR6e9Cl+xQOMBWwwBTfMmq0evZOo3688tqSNXoBlEirhXW3L
         JKSA==
X-Gm-Message-State: AOJu0YzQ1AwMaaf4LRjmHy8xwDX1Nh25YH3Bg3jt/P/U47k+ed8T9Qg7
	tpc7FrknZRTkdvciIfjPdn0OVLKC8FUtEQ/pMBw+gAYmllarpgsIiF0G
X-Gm-Gg: AfdE7cnKfkjWneyGcsygQNvIJth/8t57E5KgoR5O7+D1d9AXSqZb1cp4DZL4k3TwR0o
	z3tBs+Vcsjd81AO+ZRF1UHB8VJUEyEQlF9DhrQCbKZ26mMTNMtVZUH6IXqNnQsAz9AtNMwip6uh
	SF7pGx4mwHbBXJzo6nPpuVxC3yUQwUcrsP3RE0vL365N1F8FkaNmPaidldP4zRo+PZDQPwYSsd1
	LOuKWHzuwBcN8iww8j+h4Y6gvRN8qt8Hv6D4QvzdUHUw1aprVOK5MU+qZj0Mg1GZJa6CnXi64mW
	256Q78pshCTj4cL64r36S+GUydaUfpbnLyUeZTT0vyV1hKBad07SSIudV9guBC16mk/IN2PmCCl
	gsAfH//TZxxJoU1y/DhXuC1qqT4ctRehJTCh3vBrb5yzdifyDjGZz2F/mLwYlCWzi+mOGifNVnu
	XJpFCjy5rwYf0IRA==
X-Received: by 2002:a05:620a:284c:b0:915:422b:fb49 with SMTP id af79cd13be357-92091397994mr303581385a.28.1781844875147;
        Thu, 18 Jun 2026 21:54:35 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a425448asm134464485a.23.2026.06.18.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:54:34 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Fri, 19 Jun 2026 04:53:34 +0000
Subject: [PATCH 5/5] dt-bindings: dma: sun50i-a64-dma: Update device tree
 bindings documentation for A733
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-sun60i-a733-dma-v1-5-da4b649fc72a@gmail.com>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
In-Reply-To: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11633-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alex.caoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7B576A3E21

To complete the support for the A733 DMA controller, added
`allwinner,sun60i-a733-dma` to the list of compatible strings for
`allwinner,sun50i-a64-dma` dt-binding documentations..

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index c3e14eb6cfff..1cc3304b7414 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -25,6 +25,7 @@ properties:
           - allwinner,sun50i-a64-dma
           - allwinner,sun50i-a100-dma
           - allwinner,sun50i-h6-dma
+          - allwinner,sun60i-a733-dma
       - items:
           - const: allwinner,sun8i-r40-dma
           - const: allwinner,sun50i-a64-dma
@@ -70,6 +71,7 @@ if:
           - allwinner,sun20i-d1-dma
           - allwinner,sun50i-a100-dma
           - allwinner,sun50i-h6-dma
+          - allwinner,sun60i-a733-dma
 
 then:
   properties:

-- 
2.54.0


