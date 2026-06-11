Return-Path: <dmaengine+bounces-11424-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y7ZXIfUxKmqgjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11424-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC466E15F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ni6Umfxf;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11424-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11424-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E8631FA656
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877F1331A63;
	Thu, 11 Jun 2026 03:53:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9033CEA8
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150001; cv=none; b=F/B4MutIn4AbsatIR4kTDGvLfcgTBBRfCxuTxxd9H6yk4KW1+jtGVFoRK6uFB+H/o42kN+OL/tvNC9eLSAWTBpKYm+s8G71S7JHGqL3FR1N5OkehWFMh6Ca3cLbXJV+NxSupLN5sDpgrNnt4Jw0NyqClsYncbZ+1z6hOGB717sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150001; c=relaxed/simple;
	bh=PGNeHFjQkdZFVCBNSlBrOzGYn37IRrmrGpkyMACc34M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJHpESJOU5Bkh6sRfjaI4rW7LJV/10Wfm6F20lvnnb/E7WaIOoR1AwEBjX+rfFs2HsncIl7Rgcz1VLZ3pG9ozuTSpgfgiCJyE76tVEEdUpznG+yWXWkqNs8i//k8v5lfzJ+gqPAGoZd1lmnqBVIG6k9RXHwQmH+g5XKGh5siRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni6Umfxf; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so6885912a91.0
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149995; x=1781754795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8RAk798iHkOqMUF+266tq7iD91rBE+7QMl47XALgu8=;
        b=Ni6UmfxfCZDZCuHMkoeBATQPSvmDxCBrUF0DcJ2gQ1LtiO6j2EcHEgBRe3763xefoZ
         RTAknq7HLgrG/vNBj0hPPbCrspViKCus5AzXPS2jYti1O3StPJJ3k5ZPgnBTKw3OW/6Z
         Qm01jtLtdUeenQa20UPDxR6/MbA/t7htmr9t8R7qi2bD15fJIzj1MrmPcPOD3zpF4Nhx
         uPiqyr1rwxE+8wKL47vnk2d7RxN00RMCWW28E3YDzLcJUd52bTHCRSCf7+YHQtAlfW3+
         41TzGO6+8dInXGZIz8VbytYQrqGZLt6zbmTi0sZnKol9TrmwkwQgLJRCw0y3nIM0sSWn
         1CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149995; x=1781754795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8RAk798iHkOqMUF+266tq7iD91rBE+7QMl47XALgu8=;
        b=YgbmMMB5ayPfPbJZZvkIUo5BMNL08OKJqxoUW6uZ+0/iXL74C633/CgyBIZui7YrQi
         SuRjnRhn2Jdt69rCpBxylKt8k91Y7zPHSuO/OWe14jtRhpeTew5bzz1Jrwj+Nl46Q5Yq
         D/hxQdbwPun8/LTnj2w91HS9ztC/kbZk+xnL8qrE6b5XZhs61yHcTXUxpPtBGpU7K8+m
         uxxEHlhLtMtT5APu/BRfcX/idmUia0sjGIfIcGp3/cZ80HB9Q5Wu54fj/FozdQoIrnVL
         5wMyYeGRqOOYbX3U44Q1jccl4EUG+EOhH6Ta/V9xzytNbqxWLdJLrEuC/Zj44mBNnMaP
         HfcQ==
X-Gm-Message-State: AOJu0YwUgkyYN50DDAF++5HjJ+ywZxBhY30MlEArpOty3xEohyGtRLwJ
	RySukQ4Jyh0HyRcUAiONfDIFvDBadDuDKed+dNGgx5CjnKAseETAVKqDTDSV6g==
X-Gm-Gg: Acq92OHAP9COtTorkTqjlTdUPvddjqv7NC4L/8YRJG/4k1pzrx3jccMEsow2bF2fCHN
	QC1ti4/FYnsNH3Getwcpk6NS7hzfAoOQ0dc4Bh9PS6/SBkUkcHtCguwS5knHYyhGAeWa0jKBJg6
	CAhnLH0ZihaFTpbpz9fS6n2tR9hNvRf3K4DeTjsNmdPZ+cXdoYUpr4CSYBFFNp6eKs9NxquUs0W
	k8Xntrt6u81NIgITYsIATDRorZaVlhKU7gRSQxGwCViwckZVjBAWvEq/RHddCurNVQ7m2by1LiV
	MQ282GJsZfYFcHcVlyZDzpncbiQvQ/q4ZjEao5d8a8o9YYwCcjeV3M6FfT2lJFAD2d80KvUbX/T
	6DriR57MaQLPkAmufaMzhRz+YYqTLNhPNrnbHxZ1762yy+Ig++G2iRT5YGFHBTTvMKZW15T2Ai1
	vwTv/Omp/cdm4XQCwIKibdmYGVuP4MLrplZQQV78iW3nppkoNYZ3VhG9ShpLio1qzOVIbLtujt0
	6q/XpLoNM54VphKLHLuiP+8Op7rciB2cB44fiXtQMEKIQ==
X-Received: by 2002:a17:90b:1642:b0:369:7421:75c3 with SMTP id 98e67ed59e1d1-377a5915432mr1202815a91.16.1781149995246;
        Wed, 10 Jun 2026 20:53:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:14 -0700 (PDT)
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
Subject: [PATCHv4 08/15] dmaengine: fsldma: convert to platform_get_irq_optional()
Date: Wed, 10 Jun 2026 20:52:38 -0700
Message-ID: <20260611035245.13439-9-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11424-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10CC466E15F

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional when absent
(-ENXIO) and the driver falls back to per-channel IRQs. Any other error is
treated as fatal. The corresponding irq_dispose_mapping() calls in the
probe error path and remove function are removed.

The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
device_node rather than the platform device's of_node, so it is not
converted here.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index c04a7fbd2ed0..eba194d64105 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1213,7 +1213,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	spin_unlock_bh(&chan->desc_lock);
 
 	tasklet_kill(&chan->tasklet);
-	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
 	iounmap(chan->regs);
 	kfree(chan);
@@ -1248,7 +1247,14 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = platform_get_irq_optional(op, 0);
+	if (fdev->irq < 0) {
+		if (fdev->irq != -ENXIO) {
+			err = fdev->irq;
+			goto out_iounmap;
+		}
+		fdev->irq = 0;
+	}
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1317,7 +1323,7 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
+out_iounmap:
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1353,7 +1359,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (chans[i])
 			fsl_dma_chan_remove(chans[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


