Return-Path: <dmaengine+bounces-11426-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pm1eO2wxKmp+jwMAu9opvQ
	(envelope-from <dmaengine+bounces-11426-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:54:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E266E100
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:54:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gCDwH8R1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11426-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11426-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63561303C7EE
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA489335066;
	Thu, 11 Jun 2026 03:53:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2D33260B
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150007; cv=none; b=q8SQBGvY6+OV/pBQy6F+Pvt5GvrIlZkxufc7WKQZLNKPkyKBImdHtvz+kkK6Ar80kD6wWRAg4f6RhdjrUSnoJz5YgP18iNMKYiQjnX69tpq3r4S+S2kCEKmG690e2PewdvtFe2hwLpKu+BYvmnAfzHdZdK0bERNunaeFTwzl1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150007; c=relaxed/simple;
	bh=d1dwl51R0SVH7jP5sjbK9oDfm/F9UhJ8pLa3jSft4To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0R/W6FuLDnw2o08w9VByRIe5OhCHdEiB8pIsvb5X/WnYwxLsYAd7OG/TKlibesMXX5OgEr9cC3uTFSUPPoQoOShoOeEGgpmqk+aGBCvtYV/THlqwmKFcutgphCcZ0Z4VRBp58kZ7IC9x+n0BvvsbPANdGkYgtWYsa0325FeP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCDwH8R1; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso6582993a91.1
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150003; x=1781754803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSyqeaLlyNKBtKqq9I2lY6bL8Oe5QRX1qiD3SyWg9M8=;
        b=gCDwH8R1/iZMm6e6oSJ0xy6xUW/yG8H2jcF9oLpBzBWppl9bqa9S0UrYMKzbEz5D7/
         ONxb5a3tYfjeJb5bytVmHjuvow7iEjUFDgGAHvfDTXkV2/qJx7PIvoESM5cQ53Oj3ZjR
         f0TB/+hblyqoIclS222l19ZgazY3bCCXGFVQRf7CMmP/hVEz8idfFD5YARUcNSOQgaTg
         dj4VX52FfhCRS4H48Rwgj97uVylvNHHBbALMcJJYYxQqy3H71NelGQzNi47LRQph2wCV
         08Dg6ZAMgwcaZV/TIhb3LsmnnysUzH8uyOYpQuLC7wkvB+AS1U/hAmVukyOGfwKmAfCS
         1Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150003; x=1781754803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSyqeaLlyNKBtKqq9I2lY6bL8Oe5QRX1qiD3SyWg9M8=;
        b=GkezQ915OivysY9Y3xCFqoLAbX6rueXXSN1bYKNQoZGRvcdo/SVlzqC6BA4drmuCB5
         GmZH5RsPoFnXYwTjDTP6wmW3lj0/2QXMldzRgeTaCz4X6jqJzWemXlTuHCNzMZ/cN/7D
         kNcCgPIvwopVKf0zKlAynryEKrVKSlfEW3/I4SYKYTMkHoYyYHOIJvFBo4KNvwAD9Vhw
         +y4ZqgRKJ3+uNM8AM0iA+SeH8iP0o8n0ypOIGIpfCEI8UGY4yMGSJ3tqqMAE2fqXlpMX
         1CyqUqDfjfmc9BuR309E5WTCeNjpdrI2FQoD/zaZwz4kgZc9Ta/Vk+RLDbMhjG/1N1/Q
         dtMQ==
X-Gm-Message-State: AOJu0Yz/MoV7mi/d8LoTF/VBaDMAMuQJLjH9AfXt0gGMz5VvKiVzcXAs
	BV/4LgrAYikRfRZsCtUfqKVjs2uKt/sLFSDPfNUkghYSGRyysprymiYcyW+C9w==
X-Gm-Gg: Acq92OHjP1TIlxT2SN6cv0tItLXdMA0jckBNi6u5j/8WWR2+kj1phUF0tiF4IUFShoS
	RlyN4P5SQiUz47AmdomQafNk6Hs2aRdc8q2OFUUPneNsvaGFvjVUbVreoNCSGiuHKD7NbWoeNpY
	KDnthaRrIMxjZzhWHNkQyvAZqeOF8Y4Wf1IN0m/jliuOP+4c5e1u4zCe1QcRV5R3VS6KDlE71ns
	1Dz9Ogva7+OGI/B9Msj2STnk/uk3jfg44+dofHF0e9jZasS5uHua4+8kdeG+pySZoeOpb0qWqb0
	rxsvRE1P0FAWo5PRutIOsy85dUyn1CKjtHt0LR0zJPJ0gS4AMglcNHjpDBGKD5mxkW+dT3GNWRk
	Ef1k759HSqQ5Ya+CjuXTkEElniJbBCjBQuVt7Xsgd3Nlld8hUAd1HPJ33UFR0XuM6L82BWrxynB
	fwaaDfdYDzWY1er7A3E4v3JCAa/vs85duQyJ12E+sFdJrw5mPvI4ZDNeMXHn0uQSiDJQm2/DpSG
	6DDBKO548QZd8QTZuaCG0OO7UG5IwfBWHrjKRLkBHj7Qg==
X-Received: by 2002:a17:90b:4acb:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-377a73e2750mr1300085a91.16.1781150002966;
        Wed, 10 Jun 2026 20:53:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv4 13/15] dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
Date: Wed, 10 Jun 2026 20:52:43 -0700
Message-ID: <20260611035245.13439-14-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11426-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C0E266E100

Use of_irq_get() which returns a negative error code on failure
instead of silently returning 0. Split the IRQ validation check
in fsldma_request_irqs to handle three cases:

  - chan->irq < 0: propagate the error (e.g. -EPROBE_DEFER)
  - chan->irq == 0: IRQ not found, return -ENODEV
  - chan->irq > 0: valid IRQ, proceed

The fsldma_free_irqs() function's !chan->irq check is unchanged
since both 0 and negative values mean no IRQ to free.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index dc70a6bf5723..0ee3d719ae95 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1070,6 +1070,12 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
+		if (chan->irq < 0) {
+			if (chan->irq != -EPROBE_DEFER)
+				chan_err(chan, "interrupts property missing in device tree\n");
+			ret = chan->irq;
+			goto out_unwind;
+		}
 		if (!chan->irq) {
 			chan_err(chan, "interrupts property missing in device tree\n");
 			ret = -ENODEV;
@@ -1093,7 +1099,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (!chan->irq)
+		if (chan->irq <= 0)
 			continue;
 
 		free_irq(chan->irq, chan);
@@ -1178,7 +1184,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = of_irq_get(node, 0);
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-- 
2.54.0


