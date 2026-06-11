Return-Path: <dmaengine+bounces-11423-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIR4BPUxKmqfjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11423-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68766E15E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ijHgXKiq;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11423-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11423-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D1C331F9D5C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3E33C1BD;
	Thu, 11 Jun 2026 03:53:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC7306746
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150001; cv=none; b=DVyB9CpjfAoid6pTDB4oVqrhpJ4dTS+XXRatQwVV+Lsi3W57QZkRcvjX5rAdwEiT/Rvs+xujBjsf/WN8WFwivA6uLvls5I48ixjPeHMqCj+WT76UBNrmxtyBb4kDlbV/sw4yH+dvb398U3N+ON47gh4XIzY1Q9rR/hSHoRSQa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150001; c=relaxed/simple;
	bh=QNstBAc1L91v28F1oF1V1UBDhakUFuGDQ4mwwDQaYVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd6xXENbmWyymT5kCyKke/8yifH7NPe9QW5ABcC4sv7eQb+u5dX5Ju5zYD/ywH/4L8QPElhmuWpj+h9azyUcc+ArSRa0j3yfwaV2SzD4smWgoX5F5HpujR8fHjprBJRouoS/hxRp/T4rm5dpFVUFgfGYy03mQMAMigEaWNjpbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijHgXKiq; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso5156688a91.0
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149994; x=1781754794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
        b=ijHgXKiqDiLNIyCOE+hAkkmR2Khr2We0ZjgaEaFDpcQF19g2iNaZTBDnqxwL4+BV11
         V35S4J4IMTzCwvva5RhBUUjSqZ8tYuYqjvW9EU4LC3PAl4VzHjXmyfnNWRToogD9Tojt
         bLnH490Bp8Wb9/vZIX1rWAwXqNcfBi+bVFMwLV7bo1w2zsSZ3Y3fWzhHJJH5Agx9sCtc
         LCM861CoL51020BIS2SSmLhDeLyyjhL37OYg/63y2bR0PkuTN2HL0pI1+c6pWgnr6X21
         jXzSnfYpb6l/w9StxON7iFZSBxT0MUBO6Jmi+FeavBHQV4MDUvIoEdiOJYUsAGq+OTT0
         1fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149994; x=1781754794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tT9xKJ0Z4ILZqTxJ8ZpiwY1jbcqBK/pYbLAZ3NF4IQ=;
        b=E4jE93jtpFarhQI3ne0bFDDp9ahjZTFMS0EUZcuRc8MQZBBuotso8EzkjIfmG2CW7H
         ZNhrjK+VKjIyF0QElC1b1uIj9cOzx9t1UW4uSRNAi7k6Zjk81/X3OkZIxDEDZPyZs4Al
         qvG5EFElgXhumOt8ZH678wXrZAi5yqZcoILZsq8m54U30B1Y9iho8OtKXd9/MSxMBvC5
         vlJFSp9uS8TrXYPh+IsdMF/eRxnAZWFVF1cz1EXuARLZjfjTWy40EB0M0vBDBiHP9AT5
         ORI30icQ3mZu9wJJpRw/+KaFMuzJsAkG61dAiu83euyKmfOIzcgDNExo7anom2xv4vb7
         qv+A==
X-Gm-Message-State: AOJu0YxmMGVPDJ0NuKbA3Z5BPpCNntyWk9NQ24D97I5S6fcW1j1q2+vT
	OQOi3bAhLaVQbj8i4ou0aW4ujr+NawHR/DToIDDymLvQDfvgLPi4pxo6cEs61w==
X-Gm-Gg: Acq92OHGsCFOcYv4xa+k1QqjsPLEfNrOs3+JqQUi86l1gzJgbUzp4HaEXRDzLR3YH2Z
	YcKx2CIZr2QSaZ90z+uEoJVi5FD0/4/mzbW45qJ7EVZWB4Ll1hUBVsiwO1oSKHqpfJSyKKO6JxK
	bP25FWNLXw6n35FO7QWfPRmuG2ybY12uGH9hpm5HfwzWgZfStQlJBnRD1pQVhUGCR3yqzF1NgMJ
	JnC2JyjXcENB/uew3rSGUDSP6nveyWMpTgD/ZhqXtTHLDL9hEI0qAmIsZ6iNWlreKD9q0FDKUce
	ds4/2oKy8wASGk0psi1kgSoJfvNR32q40Dnv6NTl5QKVUvFSW+GC7fbr9CEQi4ESs4vFzvYC5qy
	n3qnfbaAIIHVI2O6z5+bZy+2fV2yifULSEzYNgRPivaVFtNQnsvrVcs1OodX3HmeP+yFTFZ0Ou5
	mDliWxziE4ywZybr7c+FX9Z3rj82v/yNOHmhMKNvmXRKEGLyXcTIaqytpdX6we5lfqCP008DVud
	JdFU95+m6rsCq/+sgAcBUv56QkjjJ1akC06xhD+6NaPcw==
X-Received: by 2002:a17:90b:4d84:b0:367:b819:2214 with SMTP id 98e67ed59e1d1-377a4ab6f54mr1274422a91.13.1781149993882;
        Wed, 10 Jun 2026 20:53:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:13 -0700 (PDT)
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
Subject: [PATCHv4 07/15] dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ
Date: Wed, 10 Jun 2026 20:52:37 -0700
Message-ID: <20260611035245.13439-8-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11423-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 9E68766E15E

When fsldma_request_irqs() fails on a per-channel IRQ, the unwind
loop starts at the current index i, which calls free_irq() on the
IRQ that request_irq() just failed to register.  Decrement i before
the loop to skip the failed channel.

Bug introduced by commit 586f54672b33 ("dmaengine: fsldma: convert
to platform_get_irq_optional()").

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 4475d50a94f5..c04a7fbd2ed0 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1088,7 +1088,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 	return 0;
 
 out_unwind:
-	for (/* none */; i >= 0; i--) {
+	for (i--; i >= 0; i--) {
 		chan = fdev->chan[i];
 		if (!chan)
 			continue;
-- 
2.54.0


