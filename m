Return-Path: <dmaengine+bounces-11371-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7QclF+mSKGrGGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11371-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:25:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B86648E8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:25:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hlo/BG+J";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11371-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11371-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2884E30972E2
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992D4CA288;
	Tue,  9 Jun 2026 22:20:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55314403B1E
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:20:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043612; cv=none; b=kqdTSMBmuoyhNadeoQjs5FMMlBLrIepvvd3Q6djc+JsMk7RzJiQlCW48ObncfA+wVB2yv9IWjPGfjNSenE5r90OGIT3zo09xUpRwZTlKsQXW7QKD0TMeDt5SXdymzzkwabYofl9RBHygyn+LdCWqFZfHuGBUPeovC4tndQCTy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043612; c=relaxed/simple;
	bh=xaWrr2fdsZgTd0OCkKwIZ+Wux7+r+wiMWqymMs4IDvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWCbEjw8DIXWWpOs9TgmNcnE8JLB7sUV6TxoSYLVbqm2SKvYxizQ/bFtqS4I5+xRgYB1oFQKYWe8mryfeJ1rKPfm5EshY77XdfXp6BIn0UwOqb0ijFQYQot53xrnCWxQFnPspA9UoR6gJiydfi+9ODMlmESrcjv220Iyys+T1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlo/BG+J; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so3589760a12.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043611; x=1781648411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpnKWjXftKVnMmEr+XvL/qwRK2/ShAzH1rSpA9h79n8=;
        b=hlo/BG+JMq7fGfXHACGe3SpAYnEyQcWi+gqfK+nNp5DgFP3H7yM46rWoI4HFieo9qi
         xzOOMCEk1RK028Ct1lsfw2XDo6q9dg7KeFBdCgOSz8yu3tzlkoh2ps3gCC8KetDX1KDy
         Ynce2cmEmWJnm9HkAD4FEUPsBXO8Yk++3mZ4fRvbNZ1GTyJ9OVVREkkwntoaQAID/dMo
         KjhL4Ub9JU4f1HXmb7z8do6vGBfYKDh5nL5aPU19aSZXTLpqWVALlCvIDE/ZjliTDjxn
         R5KNqtHFQiPz3VLE3bMKGvl0kHU4E4NhR4AgBnEkSckQw9LYa8MnNWTyK3aOADMzYw+U
         yu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043611; x=1781648411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpnKWjXftKVnMmEr+XvL/qwRK2/ShAzH1rSpA9h79n8=;
        b=YMoAgF2bRq7+Y0QUNBLzXVOk6EnaZ+jtXAlvyOEyJOk/RpDjEGyAdCBSqSSBQQAAvr
         R1NsJdnW967qwM8yUNHJCrnkfi0Shuxd1HPr6GXNvJMFzP8KgtZqkmsopmltMZ7oBZjJ
         OCJgvlLFbigsrMoPQrz8xOGac9S79owt9nS3kSLQYu6ZqOV7Mq3Zu8wIbjY68f4Mz2Zj
         H9ho//5dZuCPOqPNI/H5/PcVE+4ZmEpX8cNak+x9OMbmEq9VKMqRrwbbzG2PG1pJGxrk
         O2uHyHOmS4RRLboKf0cTWGTB6z1VSdrubcEifGkWDPlm7e0GHrbE414aiUhKUqg8uhU/
         kTlg==
X-Gm-Message-State: AOJu0YzKh3tEca/IX93vWZepPfEw/9cUD3klNxWtZMXa7eUXt6RKnOTK
	dYNuPidgJkOBLtZhYKHhby72yvPFr18nby0o+WSoN50UkyJKFKpCTgujrzst9cmj
X-Gm-Gg: Acq92OFZGEqQpyRYFWgGjwgXVo0iF68a+OjBeBtke2rZy+XeJexDwSDVVKoV1/qQXg5
	DcGW8bEP2z5AbiHOR6ggUhJQVofJgKhhcnpI6HdpDqmwQ0AxcC0AMojzurs9QxfP2VgwtSQePdg
	CSk3PBjrl54DLqfFcrUTvCdNjGcBupDGz5KwvKrcMlOlDhzhfMIUS6Omaw6dUQNU6k1iX71OcWo
	+n5oGYYENwbeSIehIw+1uN8ELvXPDzEt6YJ/HjaviR3AHedyWxWWortD+VfZ/HDAAM4gfIzsY8z
	F2xWMkcEaVMq5prTqzy2+I/yYxaXpVZcakRtrjG4/kpkVsu6tMv4jhNoGYanUJAoOXUCx1jdtNY
	SJLf7KbvPkoSYWtUh7cX7f6Z54lVrBa3c1POU5NeO+TidZEpp5/83d+QfIMfW6VRFsXKwYn+cdI
	7YbS2VXE2YXbgK2nhCBhFk4CyXvzi6PHCH295ddLfa3AalqLDjKWkkM+Z9hoOWQ0HtcxxYzhB8T
	IG5SjhDO2pybG3J4OnV0FtJ8KX51a5jVgbUeIYUgUTnsg==
X-Received: by 2002:a05:6a21:62c8:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3b4ccd45993mr24628603637.12.1781043610661;
        Tue, 09 Jun 2026 15:20:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:10 -0700 (PDT)
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
Subject: [PATCHv3 13/15] dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
Date: Tue,  9 Jun 2026 15:19:24 -0700
Message-ID: <20260609221926.35538-14-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11371-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B20B86648E8

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
index a3792864f02a..7d0c80121aa4 100644
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
@@ -1181,7 +1187,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = of_irq_get(node, 0);
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-- 
2.54.0


