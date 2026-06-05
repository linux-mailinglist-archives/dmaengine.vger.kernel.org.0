Return-Path: <dmaengine+bounces-11200-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EAoeLsZHI2okngEAu9opvQ
	(envelope-from <dmaengine+bounces-11200-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:03:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AC64B87E
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:03:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pgNGDyyF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11200-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11200-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D693064130
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FC3D646B;
	Fri,  5 Jun 2026 22:02:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9723D47A8
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:01:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696921; cv=none; b=ew5eaTXgm9oxnUYTyWzsvSoWGrxCk6Tjw+KLj1bz8QYnDnS+27disJ+gJO/Fn8K7guKw48AWFmeuAppMHSeGtUkupe3rCEV0shSYPcm5U1EhHHKv9GsQkLBJrBLHILjQuEIP2NaK1XuXcCmA27VloDje15lw6TKtq5oeiOTh1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696921; c=relaxed/simple;
	bh=reYbgeVAQzFvOU2OYbCzswcoW1erxmIKcVROrzvbUos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf4ZyeL3vFJWHGfG6V5YgtbjeFjt/qQ2inlRmwUZOs94JwNAHcif355BcST27zOsJJmZtBSIGR/jFpeh77v2BE/8N+2Op12swXbCuIZbd9sfUwhG2oa8X6FNAAFqZDGhXAUWH+Rgv36y9NPkwShqg3qt5HICnfWOHSw1hitJC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgNGDyyF; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so1574583a12.2
        for <dmaengine@vger.kernel.org>; Fri, 05 Jun 2026 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696919; x=1781301719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sz7+xisuSM5PYR/do66zevMAZphs/3eVGB3/an7yPc=;
        b=pgNGDyyFl6/eyfS4xNkE5uGEcowoWkJP8/os4wKWcRX3yLVJVT5cdl3009qJzJl8As
         w4ascXMLXrjKgOzBJXrKHVcXCv0o3f2xB8laaFvNeBmN9pkVex8HiYRtoOGbDwL86vmG
         DXTLgKVyxXpjpFKQ3PzluOu3UgThg0eOGVvaWr/9iqKsdCDPudaepGPdFYfyWZ440Rab
         B9I4k0StaRCd5jv2tAE72gDT3TmTSxJ9EqoihlY4aHScAl8dvN8zov2XqgDc91OTx021
         LvpC3QHvqnJxX9ZzxqN20ERIAiLhzcCyVPdtzzFyYFxS+vLWkZqQ9X1uVo+Dy6tVE1xD
         UHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696919; x=1781301719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sz7+xisuSM5PYR/do66zevMAZphs/3eVGB3/an7yPc=;
        b=ToKUGyCYuDrE+alnV2K+8e0L/BjOd6ez8Lw89OFOoe7YD2t0WVB/58z7Q3bH+bHTh+
         ft1HCwqS2BXDq4IYIjx0Xk44DlTa87MHzUHTFtvgWbY0GcJAnjL5CbSpMnOEqcPOqeS9
         MGw3Na0C+4uYajgySE6gNttpyJR0OYrglx8TZC4AETW9Ics+1A58d6fxMiCvCbyLHEsK
         /0mEQ97SH4SLhpfEes86ibZNdY6KaGiKeg4V8T8nerh9h26R3nhmh5a8rt7/aAEMN1TC
         vVbGQb1fIFyFaeXpUvAEKPImKLmELcxOXuUylwBCjqKgdFCiyumd/CnK33RLONf0ivSn
         ycrg==
X-Gm-Message-State: AOJu0YyVRxtShk2dvgM2M/uUyi85onTGIrY+O2BW4paKhOxRwqGIdyv9
	StSzB9s9KWIyFz7xG3y3dtRQQQymPCtqLwRu2g72KIPJQ64H9xOPysOnGvZyqA==
X-Gm-Gg: Acq92OGCsc96L4HBSSMC5CZHDGKff21MQaMIKTEXVxmXpvtSvuBbDUqB0E7Ou5VIJjx
	K3rWDjct0Ddp+4TErdd3tLCDGS6/79yWUlBpdJr/jUe8+2j/soAD82Gk2pTpimkMeDGpkkIWMz3
	V1pvN9tUeFRmvLuJ2GjRAmKik+7+Wy//cEh0Hx5UScWj4nAuAZFOd45xQGmwulS8cvGbK1dL+y4
	qzbkxqEjb92rKXJ/zdkdyB0nWe9gFRfXsnBVCTwYOl+oVwBYUn8e4uXpiQ/FMWyZi398ADAPpuK
	KXz6bOa1+ICcqCJq0g2Zlt750OLVLVEYUP5uQ7xrhYZWzvfjy27l+fqY3lChOWjd9ZJCiwwhNxl
	oGa1bakq9KKxoajCIagVd0u4qsZubE0GFVkj5EEicV7fA3L3IJxuq4rNNDIEc0sNw5d66rgGxLn
	Dd5AG8kFD507kJubjERMkTZ+TC7PhTOndtXyp4PEQ7CBioJXnBiUhE1JcvsOLg23BTNlqasXJwt
	CQsOX1B9rUFJkbbY2Fjiq9rL8QjAq6U4unFv0taQQixM9zhESFsYLsR
X-Received: by 2002:a05:6a00:21cf:b0:83a:3135:edbd with SMTP id d2e1a72fcca58-842b0e1e1f7mr5458741b3a.7.1780696919249;
        Fri, 05 Jun 2026 15:01:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:01:58 -0700 (PDT)
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
Subject: [PATCH 04/10] dmaengine: fsldma: convert to devm_kzalloc and fix error path
Date: Fri,  5 Jun 2026 15:01:28 -0700
Message-ID: <20260605220134.43295-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
References: <20260605220134.43295-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11200-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A4AC64B87E

Convert fdev allocation from kzalloc_obj to devm_kzalloc to simplify
the probe error and remove paths by dropping the explicit kfree.

While at it, fix a goto target mismatch introduced in the recent
platform_get_irq_optional() conversion: goto err_iounmap should
be goto out_iounmap.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0d28f8299bf8..2efa16d12679 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1213,18 +1213,17 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 
 static int fsldma_of_probe(struct platform_device *op)
 {
+	struct device *dev = &op->dev;
 	struct fsldma_device *fdev;
 	struct device_node *child;
 	unsigned int i;
 	int err;
 
-	fdev = kzalloc_obj(*fdev);
-	if (!fdev) {
-		err = -ENOMEM;
-		goto out_return;
-	}
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
 
-	fdev->dev = &op->dev;
+	fdev->dev = dev;
 	INIT_LIST_HEAD(&fdev->common.channels);
 	/* The DMA address bits supported for this device. */
 	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
@@ -1233,8 +1232,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->regs = of_iomap(op->dev.of_node, 0);
 	if (!fdev->regs) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free;
+		return -ENOMEM;
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
@@ -1313,9 +1311,6 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 out_iounmap:
 	iounmap(fdev->regs);
-out_free:
-	kfree(fdev);
-out_return:
 	return err;
 }
 
@@ -1335,7 +1330,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	}
 
 	iounmap(fdev->regs);
-	kfree(fdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


