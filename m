Return-Path: <dmaengine+bounces-11691-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mn4AAJVbOGrMbQcAu9opvQ
	(envelope-from <dmaengine+bounces-11691-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:45:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDA6ABA54
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o26ZswIJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11691-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11691-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56BC7304FA4B
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1440371D15;
	Sun, 21 Jun 2026 21:41:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98E371D05
	for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 21:41:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078099; cv=none; b=tV7ehl5yUh3wZ1qLIH2ImTBjLC2yXcxRR11ARNoAW7dG7I1Jv+MmLoDx47CTnu7RhC8Ynyu91Krzp2jIW+WUEtofK1weyhHkelizSGmyxTQwqk1U9ySfgHZs0NWthE+fOsfmoukz+KUc5piFaSJ5qbuL/eKH3CZiXCNu88cPn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078099; c=relaxed/simple;
	bh=snXtiK6PEmUwjwB87Qy4uEGoHKMvUL4i+B4X0NTiCQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg+46ZdzzJIcA1hAtuhe/l3a2FFBHBY19KLD4P6+pWl5m47cJ3xmz2yQyVeldLslJqSDjXvFnVmVWicwtLSWgYu2W8gTYwhrBWpyDrH5VsWZ3LJTnUsiXjna7J0KEpVazRP1abqhoTZ6qLUNZW0FYZwpxHnpb9am2r8mP06W3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o26ZswIJ; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8dc09919aa2so65741546d6.3
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782078094; x=1782682894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTAQ0YVnmRPUTpM5kMc2Jmb3ZZIxno5dgQysePNdwmo=;
        b=o26ZswIJrAwUEk6UvAEpQBKBZPCC8gOpjs0FWoPCy7xjCOOFQWDpPy2gDxdeXb9UEf
         Jfn0qQPPb41q6EUxw2RWOz2gwxTi/Ywh0XcjOPCqCpAIdMeYHwmhCNjo2LXBPSdWU1xQ
         GkWXjb3/9Lw6JsOSrkh8Ru+uT/qpES57PnxZAn2Uj97/ylwkSJ3nOdMd85bTFcP5hMok
         RHstueO5m+4KoQ1E6mYdiDCX+NpAbtRGN4DrlZSF7/SUyufCnp/T606DN2R0vPa/OQii
         9uTqizWOBGxfFh0WrxHmUb8ui5B/L+67LOMHigu4LCfsbJ19Ee3OrrviQdEjl+RN5F2F
         n2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782078094; x=1782682894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HTAQ0YVnmRPUTpM5kMc2Jmb3ZZIxno5dgQysePNdwmo=;
        b=HJKfkB7R9FITFR4lhTq9yh59jE1GPqeHpGYSEXI/jgGZirhMoGOy1cyUBSEAPCZrdx
         bTTMPKDyQnBjDb38xcKp9Gq/o1uEQSW8NgPpV951WkqbROQF1J3TPDkA4YAV5/JtTLC1
         IPNwkSN/oS/Ds3JgB2L+2z4XYZY+dbj/A4IaZ3phJ6MRmKRMMMqO6ojgeG3mLeHl6kUM
         my6wW7WG+4f7AspfBoOyl2kY+m4dV2LxfGDjW3woSP/4sydgjNuRTdhhtmU6jXaN7hEf
         2L7WSNhKzzN5+QRHyQKd2RDEuvxPi8KNnkzGY8VGHADJLH+8zuc3XQDx/FWrfnPFpiEE
         VmIw==
X-Forwarded-Encrypted: i=1; AHgh+RpnDn+eTZ7t5p2B83VJpSCXwATusRLWmJ6tuICQ/Byqi/PlGRdJCktw80eH7MOesXTuHyHa28YMFkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfh7BuP3ObJcAXRkN/4WL+5PYwlDhd+E3TO1RmlaaqVLRVmCZ
	TVqH9MkpyuohPjg4boUYCOUuwIH/97nJypPCNNm6Hq14Do04MUXc+cUByBx/SIOZEHU=
X-Gm-Gg: AfdE7clh/LG8BaeiE1d9R8EUE/5dWSJRi4IBUvGK65ITf08QMQh5mv8HrcI1RZnDMZP
	kOWw5zginWJke9fBJ2UAURSBjlESMsGTKnL6KgZAZ9+KyxJFEAGbzlnwjcA3Uh8nibDpRj+5yzb
	gR+ZUoGSAqDEROTSchLZf724LfiZUDNiE+rZmHNkK9e/k/zX0reQ749RHDHUzc8V+lUWA7eKBzE
	OGUZH0GbmpiqvVcE/Qiu4TzYYZVxc4DH5x4jZuRpDrPhnj8LTv1GCmsHv1trqnO/NFPTw0quhbM
	519BD/xlSSnGZkwQPEQsSW+FY+098v38Uy3k9c5VIuc4bFfNV9WLxec52NGZywmyEpb5PrOL4G5
	FCmQ0I9fmQtIVmpqPLYC6J8V1mS9L1RJOrrxg4qpzuHPaKxWrzGwUstAmBg+eaQZpzV4flpcQc9
	FNCqodM4SmtFs+6A==
X-Received: by 2002:a05:6214:124a:b0:8a1:8b0a:6678 with SMTP id 6a1803df08f44-8de415cc13fmr219484556d6.31.1782078094430;
        Sun, 21 Jun 2026 14:41:34 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde9ecsm76274676d6.24.2026.06.21.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 14:41:34 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Sun, 21 Jun 2026 21:40:57 +0000
Subject: [PATCH v2 4/5] dt-bindings: dma: sun50i-a64-dma: Add
 allwinner,sun60i-a733-dma compatible string
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-sun60i-a733-dma-v2-4-340f205891cc@gmail.com>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
In-Reply-To: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: Yuanshen Cao <alex.caoys@gmail.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11691-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AFDA6ABA54

Add `allwinner,sun60i-a733-dma` to the list of compatible strings for the
`sun50i-a64-dma` dtbinding documentation.

While the A733 DMA controller shares many similarities with the sun50i-a64
DMA controller, it requires a specific configuration due to differences in:
- Interrupt register layout and mapping.
- Number of channels per interrupt register.
- Support for higher (32G) address widths in LLI parameters.

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


