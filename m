Return-Path: <dmaengine+bounces-11416-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AGU5JXsxKmqGjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11416-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:54:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC366E11D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C+Lsou2A;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11416-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11416-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 947EA314B37F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740E3314B7;
	Thu, 11 Jun 2026 03:53:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83833031C
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149992; cv=none; b=Rj7iAv3046nxlovhM1kIY6zIQ2cGfZH30aDxBoeriicGTdd8NLIAVpJ2HTQ/kQ23NahH19uaDZRJlEjV2JffDCKm2WjFWgJUwm7oBaQgK9zElDWf3xbGWaAuuI2XDcTeNvejywtwLvA3yyXOV7BRC+VGQ3ruXfxZOcycVlfNYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149992; c=relaxed/simple;
	bh=xvy4bkq3P2rtPuts3OtlogJt4Cz0NMbc+ohhmCAWkn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOVEbiYtnvYjWrDk6Tqr1i86scOeGUlu/KYNGu8pCyhhuO5AMC36vKECoz6MPe7YZTll5jmmd9Pt4HmYNYrXik4BQD6eQxc9Y6D0OvsH3k9dFE9Nsfv5hEi/aUGyMhF7CtClpMBnsGiHXTUY+SX/8Ab/rgPyWjPNCMRB8ATq+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Lsou2A; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36da8439078so6522432a91.2
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149990; x=1781754790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=C+Lsou2AiQjb0SRlqEO25xzgoNgIdIBbK3f6KwBedUFCOuVA0F9ppvq4yWRmupaS3C
         gE83HwUzu1SfvlipHNMBMnJnMEtCdPnPOkP60YnA10nXzEu1+dOh4Zqd7WzlxUERv2JC
         tQZ5jmCkPqoN0EgHqxpFjZ5+AkXCpvsc2xsSfGaEyajzXFT0d/wUT7DA7M9iAoAcEp/2
         0TqNS8vV6b0D/enKqvSl0Ghkx9a3JKDp4ON4M58FVFPtQKszSiUu3xh/FBejBIYIiZKz
         GwPOsm+uHVToKGM0v7cOum3H4PRkXuY+TK/TnpKpqLfWweM0KcOIqAstv8pzoE7A3+Kg
         4FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149990; x=1781754790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6ipJNaJivS6R5/q/SqMYFm/sZfUc0Uv8GQU8fX6jMU=;
        b=gTeDAyAe9jfMJSvXJ1NM+PvFoMaIrKG3MKFCVxJJ3Km4Vrjnv6TBzZrTN4xPJ0T1Kf
         Fjjb0TC6FM/JT+8mSGCW2ac3ILa9/fwEGGBKzFN8lFd9oWagp6ppQnbVNPYXmkEvaJss
         WK7ZLflzOz8m9RuvMi7gxd343Omqq9VPOSGDzaieH5c3KzhD/4a/ybR6DqfhvvrMNo5s
         d5ByrYo+Y5m6DQwzmiRKDpNMx2FJxJPPmm0tpv73AfhJ7o8U90aBzmuGABKH1qHzC2dB
         fBTNFwlgs896isZoR5DSodPD7laoYR1uI/hgyGd4ru3nE6Rgfmhn085FP09PIZM0djRE
         eRbg==
X-Gm-Message-State: AOJu0YzlYIdXnIFpnvE2zzyTA2jhB0dlCjjav4ncXTL2QeM6lQDTQ5Wi
	EEZ3JXTlhagyU6R5HQ9CLYx/bNWISQsC8F3Tm4QaAXl8/LHEW/b/bZiGypyhDQ==
X-Gm-Gg: Acq92OH1SGOuaFwfEA4WxcjQJsVHseHmK1DE9PwMkp3NVgon4PxrDgLSESeH3YrLNqR
	RNwZiIPi/IxXkE//u+ouQMw7jIVbFRSf4NoDLDsEE7IQJ6KeHzTGsQkUEQmRyW30d7VtG7Jq/2S
	ska3zUC16EI/lT+fIlk0eQfUOE0ZfaI7wjs7E/mM1GCJmndbKEWUbM68j56Pwtkd7yKciOUxslO
	djQx83frmAXn745vXavJ5tWEWbNZtJK58JUPW9g1OYOQ2a+gYpqVCjFOBy5SxdsyLKxNkhIjf/3
	t1Nv3mUNyVnG3/apCoPElEBFQklXqJqNBc0exAhabWqM96QzDBF9wm6b/OLDVoz6Q7DlzOud5MH
	JpVWuKliTyZcQdyLI5Dy0MJnBOKBdKK74x7jFLiBMqlyU05NKZHK0uFvkjMKLgfKo6eXqIvwQm+
	f37GCZL0LEJvBXuYgRHlF7BToO3Q9zLM5GDHfKhDw4cxf9GWSA63n9YnQalmccfULRvH48e+7mp
	WdrxoiPv+5NPm4PCCfvX4umipfNGVwxnP7WwobKEchvlg==
X-Received: by 2002:a17:90b:48c7:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-377a15f7523mr1221678a91.10.1781149989944;
        Wed, 10 Jun 2026 20:53:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:09 -0700 (PDT)
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
Subject: [PATCHv4 04/15] dmaengine: fsldma: provide device_release callback
Date: Wed, 10 Jun 2026 20:52:34 -0700
Message-ID: <20260611035245.13439-5-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11416-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 03CC366E11D

The DMA core requires drivers to set dma_device.device_release so that
the container structure is only freed after all references to it have
been dropped (see the comment above dma_async_device_register()).

This driver violated that contract: fdev was devm_kzalloc()'d with no
device_release callback.  If a client still held a channel reference
when the driver was unbound, dma_device_release() would eventually
run on freed memory, causing a use-after-free.

Fix by allocating fdev with kzalloc_obj(), adding
fsldma_device_release() to free it, and setting device_release.
fsldma_of_remove() now saves channel pointers and frees IRQs before
calling dma_async_device_unregister(), since fdev may be freed by
the release callback inside that call.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1ba10d065278..43d817f6ded1 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1219,6 +1219,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	kfree(chan);
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev);
+
 static int fsldma_of_probe(struct platform_device *op)
 {
 	struct fsldma_device *fdev;
@@ -1257,6 +1259,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
 	fdev->common.device_config = fsl_dma_device_config;
 	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
+	fdev->common.device_release = fsldma_device_release;
 	fdev->common.dev = &op->dev;
 
 	fdev->common.src_addr_widths = FSL_DMA_BUSWIDTHS;
@@ -1316,19 +1319,33 @@ static int fsldma_of_probe(struct platform_device *op)
 	return err;
 }
 
+static void fsldma_device_release(struct dma_device *dma_dev)
+{
+	struct fsldma_device *fdev = container_of(dma_dev, struct fsldma_device,
+						  common);
+	kfree(fdev);
+}
+
 static void fsldma_of_remove(struct platform_device *op)
 {
-	struct fsldma_device *fdev;
+	struct fsldma_device *fdev = platform_get_drvdata(op);
+	struct fsldma_chan *chans[FSL_DMA_MAX_CHANS_PER_DEVICE];
 	unsigned int i;
 
-	fdev = platform_get_drvdata(op);
-	dma_async_device_unregister(&fdev->common);
+	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
+		chans[i] = fdev->chan[i];
 
 	fsldma_free_irqs(fdev);
 
+	/*
+	 * fdev may be freed by fsldma_device_release inside this call;
+	 * use saved copies of the channel pointers afterwards.
+	 */
+	dma_async_device_unregister(&fdev->common);
+
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
-		if (fdev->chan[i])
-			fsl_dma_chan_remove(fdev->chan[i]);
+		if (chans[i])
+			fsl_dma_chan_remove(chans[i]);
 	}
 	irq_dispose_mapping(fdev->irq);
 
-- 
2.54.0


