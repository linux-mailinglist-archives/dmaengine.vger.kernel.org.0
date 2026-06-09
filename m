Return-Path: <dmaengine+bounces-11359-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wV5/JduRKGqOGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11359-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:21:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77B664870
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:21:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W37A8QLH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11359-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11359-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE0330580B1
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB08386C3B;
	Tue,  9 Jun 2026 22:19:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB7350D7D
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:19:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043589; cv=none; b=ReaKQzJ0+48ETDiVjJzkD+Jl3weYDKxNJ0rZv7Rctx1ohQMj4faNUtRZs787ybhW7NBmqDYQQ2fmxFI80xTMQlXIUe8oW7tZByTj63TXDWYontJuKoH6p6zPoUCTuNHwCW4RqcKp52BQsHZUqfUByPc8/WpTEMFYDqDX56RFd1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043589; c=relaxed/simple;
	bh=OOgwhv43ry+5h77HNuIbZvCTH1xVVupSRztczl681xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWEjzE3D0tU4xSyoUv3ylbH9KJcJ9+6O63xUJ8fMh7i9xfFwf3Yas/ruqX1InYthzQjloaYYeQMZ1/6N2hL8N+EiMsS/MD0ZvVkwgcTN2KMODw8+iIbVUPXIpz7wOLkdsg3Oh7IbS4Ue39iYl+O7KB1kWgQIP0LdihHuo2XBtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W37A8QLH; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso3989337a12.1
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043588; x=1781648388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VabrJGQKyMUS5+LwCSzuBvRxZba7atk/VeVHPvy/VCE=;
        b=W37A8QLHuXC+GFJhE72ItexvCrrEaWvMmpswZ0gN9rpUDj4mZuCcR0t/vbPhFhJpG4
         HqqK7ibyECMIb1W6N+MfJhxAAVnDbl+dFZmAk4fNocfZxrovnrRYcViDp+2sb4h0E1fz
         N11zsGeSFVh/mcj81n8qDS+tr9uWjB3d5Z99IGt2Q2T6teBYEM8UbdJvgzSYBKamUxb/
         sTSqZjZUM8tEE+H2HDslDeHYlwD+s8eqpOaUxGCAh0f9OkfOv4+T7gKgZLrK/+CmjStq
         EyqFuQzY5wZMKDcZsuVVHPXCQQkhVV5eMw4rIzb60xQC9dg3fFtSQqc+FbcSK1jJdYSf
         ZP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043588; x=1781648388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VabrJGQKyMUS5+LwCSzuBvRxZba7atk/VeVHPvy/VCE=;
        b=EOKucVEY+YZTGz+xduc6lLP3zVodUfs5zIZLD5/i9bv+Hs8EoZTBDsnMIEDieAA7E/
         GV/vvBVEuqe3j2nkPm8Z/3jNtQnq38zanawMcka48nTk1Ou7/z4zwTWL69OPqkwBnCGQ
         PzvRsOq+DEUMaPKUPzcd3vPs1m6ZMyAcvHomEji8iOHAuX0qS9OLkR03VyMzy8DiVaQu
         praXsUgrnH085nNxVVjjyp74ALvvNsLw3Ehl9k5AgLjwlRPotY8aAX14JnOO8rdj1cOx
         JwUZ+GsiN1W8bSUcRJa/4YxVM1utGm4igjfHMUmYIbbkM8pCAAlt+zz7E/+m/61M24WH
         nb5Q==
X-Gm-Message-State: AOJu0YwQ4Qk8es4tsg3VTfPnu69InqCZY5+WiHvu9c+0Hws7nH1cmZQT
	BnpJhI+OB0Winf8CR9xzrZkzfjfCANDtUD/wEt/XZ07MudVjz6K1x7pFJ0SuE50f
X-Gm-Gg: Acq92OGLlM/rwcJVlgd9hwNpXDWZrVgdySuqt4C5EgIqWbG/MFwRoe6fawvujM0Erat
	pRtNZ8dH7w7eAWgMXmspq37YuzqedOLi9cqFSG7BC1/FYOTdf7y3DFkubMea+WZzyxAoJMBE1l9
	1B8Ls/uX1qeO8teD7I22Mr2EbgwgcG3rmTQLQMBiLalpgLl/vI6S+chx1HCDHmudWOrYvrze9GQ
	V491AY5IxilCbLe+ysiK5Vt3DgPtXaattWoUOMhdAsKT4USaCd6AI/2CEimagocKmBZgb8daqOe
	sa8kd/Va0/POb0cV77qI2rNvcusJyPDaq61EGr+ssb7cLdpE5LpLn3/wogV/SnPF1xz0ZTxZHml
	j8QEghDJVmz6Lq2j2fP93sfrov/ndPLIFWoHoVCdZvET7sqLe6K47HdR+04ScOYMc7DkXj6eLdB
	ccSnaXlDAhkmcnXk8Bid4XK1Q4M2K4TPuUlyGaZeJq2RCQM6FkiEnw2YtimNOXqhzQ5ePWS79yl
	zxCcBwUZ7X9Z6T9HVE+OWS/y93/KEkhQBnbpF0377OXxQ==
X-Received: by 2002:a05:6a21:a07:b0:3b4:85db:1bdb with SMTP id adf61e73a8af0-3b4cd0801bfmr27114883637.44.1781043587709;
        Tue, 09 Jun 2026 15:19:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:46 -0700 (PDT)
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
Subject: [PATCHv3 01/15] dmaengine: fsldma: kill tasklet before removing channel
Date: Tue,  9 Jun 2026 15:19:12 -0700
Message-ID: <20260609221926.35538-2-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11359-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E77B664870

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race
where the tasklet, scheduled by the IRQ handler, runs after
the channel has been freed.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 22d62d958abd..0e2f84862261 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
-- 
2.54.0


