Return-Path: <dmaengine+bounces-11419-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9uIlJecxKmqYjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11419-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F105066E150
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="S39/sjfF";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11419-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11419-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D463330A7DE8
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E15D331A63;
	Thu, 11 Jun 2026 03:53:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970E33D6FC
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150000; cv=none; b=KJl64x0+6BfsOwQVi6CQRsIgDAxibQv9b4LK2Ox5rqk3lb+fyoSK0S9TfQ9cOX/bkiMAnv3HcuL+HXK5UJFFKYi/NKzDHizoE02+RDl2HbyWrtWjvZm0cyrVniKtV510UUXl4lZ/RRVZZ9rO/753agHTf9+8lkI2SIrHUMmB0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150000; c=relaxed/simple;
	bh=UT1C4wA3q9lIRCyJivjf61ODs1oCMhkNHxkHksrCzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9JpEU13fXWtG7RySCHxDMbzdTpdNUjn9OOcASBBDoNVZv7Bnf4lV9Z83B508v5kl8YNXUsR1t0NYwVxhUdfbj3WM3sV/+Tjrp+cXXq1ywJyutdwxAaYmy0YLADFfbK5shL9PjrlwOaFcFXVmOArTb3Pcg47bkS+kfbkxI3okLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S39/sjfF; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso6502691a91.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149998; x=1781754798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RqUuykkdPZkLeqRZi/NqGaxU3+Ffx6rHHdgS1c9JQc=;
        b=S39/sjfFv81RbxlPZiHvhvyEWeXL37K1bkrooNmuqHQLKJos92lJOxM5BGbDmg6lPy
         csYeTAuz2ltIuAKQVS+06Xl3SUvIZYdMChhrn0j4mgpwuOLJOhrfd6j79F2JY4os7lgl
         v22/VGTsIZhUJ/Nk04iehwijyHzUIlAGokCgY5Lrmb2qzVeLzCyuJJd4gvpZuw69IK2H
         FcfbEbM8CtXgS5GAPfnY3F2+R6jb/nXpeh+b05KNF0x/+m/Qej10tlIyoRn1fjXgmM0S
         WJVbI1L0iCHaGB6JSIgKAiPKNhi0te9q/tw9RT6GNt+XVLjJCVqvjMw4E/QDy20X3YRH
         c7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149998; x=1781754798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RqUuykkdPZkLeqRZi/NqGaxU3+Ffx6rHHdgS1c9JQc=;
        b=GQ9RQ5FfsQdgxan5EWfCDJmcZWtwBOKEq6Uk9s/bOm4h/4J43UfqIQperhgHaMZPSy
         uQwQEninr8+r4hYKhQEGEEzp+l4aM4IAO/rJdxc7I8/s2GKZ6+u2YODsw0OFnP9veL2C
         DUIxNJSXC+dt5tK6X/qEyKfwaPqpVg0/pvYcbbMSIiwyKGlHcPPGUJSemyV2HwqibLrj
         C84Xg0FpjMYpxKpbsWNwnc9ogWIk87tSNOWUeM11FO0pBppJBrFrwNK4gBWiOeros8sI
         JkxrHdJMrpzCrBbijMRbha78Y4G7M0Yl6V+ueQKXcleDwehwyuZe8CnYER77AcQwMXxS
         3FkA==
X-Gm-Message-State: AOJu0YwD5QWcQJNcYHQq7jc6CC7yoxpSJ56ViTAL4Tr3FS1yUs40XKGC
	pxtXDUiIj6Ew5J2JHA1wmi92OenviIEbjpDVnIXNEPJqv1XhJaaOz3ygfcWd9g==
X-Gm-Gg: Acq92OHYeIUqAxtw2DlT0nX10fwCz52zfrCqRWXrob/cS1o7YSxZ7DiW8mjgqsSNJQ6
	j0SOmOPNc539wE9A2RAJ6jmbp2GmVfTXy/NRF9U9cHpktuRf7ZciTMl/DGEggsVJ9ABc6cqIL6x
	gWD8HXXMRh7ZnXEMYBtXBQMDiK/G9/pPn0FNfBSwJnBoiOxG8l8B6Z8qfMmb4TSffIMbv7MF19/
	Wgdios6+Gxn09fcz8bEwjxvl0ZGrqB8nXm/REQuLyVZZkCRePfwI5n0sXdqiiPFhN9P4GO3Rxwi
	oXdrnYBchIHCAX/cJn28bTiLQNjZGsZSXmyqNp4sQM4Cio4nDt1k6eyWe+9GLiC245g3gdT5jJs
	n9B7QA4JwHL8kpurhv0t+J0SjsrPqGnet7ZU6FRzTweyWA6RzDXfq1amU471pTJEVh0KSDLNdwB
	dPhG625TE+2VPXOn+u5bi5msBXjYKIVwRWpnpnZSdU6cHYPVzjYaImLFXB2YaWU0fZ0/R3F+1+u
	0N6Y1apm8nyDbXpbqdYc3+0w+UBRY4PxKcneEcxSeKpjg==
X-Received: by 2002:a17:90b:3a05:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-3779f186dcfmr1274210a91.10.1781149997909;
        Wed, 10 Jun 2026 20:53:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:17 -0700 (PDT)
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
Subject: [PATCHv4 10/15] dmaengine: fsldma: use devm_platform_ioremap_resource()
Date: Wed, 10 Jun 2026 20:52:40 -0700
Message-ID: <20260611035245.13439-11-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11419-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: F105066E150

Convert of_iomap() to devm_platform_ioremap_resource() to let the devm
framework handle unmapping. This allows removing the out_iounmap
label and the explicit iounmap() in both the probe error path and
the remove function.

The DGSR (fdev->regs) and per-channel registers (chan->regs) map
physically distinct regions in all supported variants
(EloPlus/Elo/Elo3), so there is no overlap risk.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c3d2b24f8f07..e4a3315a7d9d 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1238,17 +1238,15 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
 
 	/* ioremap the registers for use */
-	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs)
-		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
+	fdev->regs = devm_platform_ioremap_resource(op, 0);
+	if (IS_ERR(fdev->regs))
+		return PTR_ERR(fdev->regs);
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = platform_get_irq_optional(op, 0);
 	if (fdev->irq < 0) {
-		if (fdev->irq != -ENXIO) {
-			err = fdev->irq;
-			goto out_iounmap;
-		}
+		if (fdev->irq != -ENXIO)
+			return fdev->irq;
 		fdev->irq = 0;
 	}
 
@@ -1319,8 +1317,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-out_iounmap:
-	iounmap(fdev->regs);
 	return err;
 }
 
@@ -1352,8 +1348,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (chans[i])
 			fsl_dma_chan_remove(chans[i]);
 	}
-
-	iounmap(fdev->regs);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


