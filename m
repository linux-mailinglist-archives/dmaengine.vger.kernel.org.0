Return-Path: <dmaengine+bounces-11706-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WniiMWaSOGqfdwcAu9opvQ
	(envelope-from <dmaengine+bounces-11706-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:39:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD9D6ABF5B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:39:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cxrgqgXj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11706-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11706-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FCD23032CC4
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56282571B8;
	Mon, 22 Jun 2026 01:38:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FCD254B18
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 01:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092324; cv=none; b=gDjY8yv2MqowPeI/Wbot7WrWdFusCnG07sAzEYrqMY69oUsRs1+N92huOdRxiY5Is5zn34KvlupFHgazwzHwlkdqFhp/lvN1ESRWad3dUYO8JrujLj7xlY6NKjKtm7UVgakZil45GYxKO0JNzPBN6HMSvo5KJ4X5b5dfFavSXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092324; c=relaxed/simple;
	bh=ie+sMnD6uAa0Y5KDamC6d/Sl2iQiNR5jEQH6gwdWpFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/IQxdbaZvzN1BrlwGGdM7H77zwX5hq0Kd+eyh9t8F0ca0x0mT/EcdmBW7FSbsGBd72T0wSfQdv4HgSG3dXPpz9Mm57vXlJ0iduzfFEZQAE+O/RCqws0yJf2OQcKo/qW997TGzj2e8MuQJdzRX/9cspolaY6Ut0+C4poRHG+lC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxrgqgXj; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51a0188b92fso21231971cf.3
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782092322; x=1782697122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egN3juT3vo+m+4LZ0Q68Au8I/pA97hL0YrjeQoHBISE=;
        b=cxrgqgXjR50fgDj0b+37apLC6JuHZOwyJdHceTYYtaoUQU9Og1aIJ0yNl/OrQIv/Fw
         H7zX6mDm8QM5XzNyi7dwkY1M+KafWYgzYqPJcsIAkVODv+LlG4h/6EBi9AOco88FDv/6
         JpZnt6c+C9flknDAiQUxqBn3Ny8nqH3noUMrYjAqiLuodg3kbaRAeal4ncqiBMcrOzh2
         /lzWXaTZySN62VnShknJYVoRSnkSuaqebHkraj1DSK/+GYSNsHv+ra1ctrJTvPVXG+3P
         vhaOXkCnqJRw7vutCipanSle0dRazSMs2VJ7igyJ1GwmcDv2GDzJldPasowTe6VDtQzj
         LgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782092322; x=1782697122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=egN3juT3vo+m+4LZ0Q68Au8I/pA97hL0YrjeQoHBISE=;
        b=ELEh7E75WS1hM2y2gqPHqPXGPkX4+TrN4YW2DaHVhp3bb+OJoOW77TuA9OunXYssus
         c/+2MqlG0ymsBhv2OcrCKiwuziWVvHJNKaCcqR5cET1LUDr4wSfOax8DznCqEuSTuclN
         CFm3bQ2RhFXoXxUlrk8aLQUmHel0hWGTch+hsgoW2TN1rdz2vUlJ3oNskMwRT7LT42tb
         Gw6Z0kRw8iQRhBXXOAiEaWrcbqJDchs/6o0D5QcWyhU6HEdywGxXqpKpefucolfZUFak
         hd80lZqLl8E+Hy741M/a35FJXEQHx6Z9SsTN7jXEwVAb/ol3R+lRjQ01uYiwfdHno95/
         NvNg==
X-Forwarded-Encrypted: i=1; AFNElJ/OuydyndmpkbvaXnmrAsW4uMiwld8cbB7ctpFK/s00rVl75rkkpgEoHOQLxhp6tYuPO1fPsvzsky4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvX/AVgPWPb+u5bu0Lbj0Hls7zP18qY+tooxFK8o+kvaSAn89N
	OY8y/3uDuv89XP4XoQ1oQ0br19Uv/Mx7MQNI8iv0G9ahatzXL/zvjdAJ
X-Gm-Gg: AfdE7clukoQqfcDCBC+xlSffNnVEWOFYUy8q6xc786LyJM91Jl/81Wwj/CpvOLok4SF
	x5Lbsr7JGsR3aqDBVy6IhccHoQX1xQYrQEp3QEbE5vkMxrhwgeKVPVPcPyJO7KQxUlMp1alHdx2
	zxoyjxvsRDZg5/1XXwsCQH8yB50Mju7FCsO5pq7YujTzH9BexJHzu6aqaxqVRKkKT55vQJ97Dhe
	kvGM3mP5uAGZbmeaypRkJ/O3HDoTgGIBQsem0HazDV1LP7ZgaJChC4Z10uIL1bWd4T1yYkElbaR
	63pwvIIettxfIzM8j4n4PBVTaeK+8HdsV82JXcZjqC0MP3MWozUfoX9o2RPz9+xHwJJoseBWD7J
	t6kxSO0RV3ye/iUwe6wENZ+migShXtABDkM84NGQ2+HrrbdmkEMhUGwVO3CFOqiFl1gZH4QVCJE
	QHGEdNrNHA/Otjsg==
X-Received: by 2002:a05:622a:1f1b:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-519e4a54ab1mr164968221cf.16.1782092322553;
        Sun, 21 Jun 2026 18:38:42 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a098e287csm55778831cf.29.2026.06.21.18.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 18:38:42 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Mon, 22 Jun 2026 01:36:26 +0000
Subject: [PATCH v3 4/5] dt-bindings: dmaengine: sun50i-a64-dma: Add
 allwinner,sun60i-a733-dma compatible string
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sun60i-a733-dma-v3-4-f697ef296cbc@gmail.com>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
In-Reply-To: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
To: conor+dt@kernel.org, mripard@kernel.org, krzk+dt@kernel.org, 
 robh@kernel.org, samuel@sholland.org, wens@kernel.org, 
 jernej.skrabec@gmail.com, Frank.Li@kernel.org, vkoul@kernel.org
Cc: Yuanshen Cao <alex.caoys@gmail.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
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
	TAGGED_FROM(0.00)[bounces-11706-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@nxp.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sholland.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,nxp.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DD9D6ABF5B

Add `allwinner,sun60i-a733-dma` to the list of compatible strings for the
`sun50i-a64-dma` dtbinding documentation.

While the A733 DMA controller shares many similarities with the sun50i-a64
DMA controller, it requires a specific configuration due to differences in:
- Interrupt register layout and mapping.
- Number of channels per interrupt register.
- Support for higher (32G) address widths in LLI parameters.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


