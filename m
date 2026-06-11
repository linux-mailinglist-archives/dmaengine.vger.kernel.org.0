Return-Path: <dmaengine+bounces-11418-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id imlZKeQxKmqXjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11418-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FC66E14B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nNsqsXQw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11418-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11418-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F5D31E5D83
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706632C957;
	Thu, 11 Jun 2026 03:53:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01033D4EC
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149998; cv=none; b=SSM2dq599ZQRIp27cDIuBJy2+z55wVnKVd27gYwB4Ib3WFakNz28oHU7eeNVy/hpHFOD+cKS11qi5tGhoFZWE3CZyOJwTEd5dMPZWJg9PH/eemj0m5j30WNT1iqvomp+Cq+/m74Z9NKrW8P61oWki7E0DzncUSqPxHVbD7qpJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149998; c=relaxed/simple;
	bh=US673kb/X8Z8RqJZ4fkrI1dtQ4jRRXybN/z0dPlMBx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLn0r3RDxX0SAg4ZeaTXvp0jdvWEOFrrJGzo54J669GQElmydkIg5+rh5xacTsiaWWXB95j3E/sCwtmp7VNnT8ppY+C4e7bktzHUy4OWWw6NZ2Q3Nu3AsIPBawSNygTKY03haSLQM6H0zuNvw2ooWoFG0CXPw75x6BSnc9KbjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNsqsXQw; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so6314824a91.1
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149997; x=1781754797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Y9CBzltffMyeyjO+tKHgWOm91RTvExE1MCtYJb7pE=;
        b=nNsqsXQw2sB4BttBNkvHkppf1n/3LcdquLO+YnZhAJ/S2+wBz5V1IPW3zZYUN0ww5V
         wwfoD3r8MjhKzfRLY7VGjDgLiKUrau2jI2UqfXQXf091WX9ZYoFWyVxWCDAfp6EzgU26
         zEZ5hxrtgRisErlVPZXVnKEHGUu+Reuczdjig52NJq8Y7EeG8K5GNE1go+tH6f3gQmTX
         +HjD3hCC9hNAyuY0TTCTaeFdZl1uRjPDUJv2i2hF6VNOYfExX27F+mBd8Wn+PF1z27yf
         //GSZKXL99xFo8XFbYWgu0XQU9OrqlQocR+wLQtyfsdFDmtghjxifTRvlB7Hg9oCYktu
         gtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149997; x=1781754797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3Y9CBzltffMyeyjO+tKHgWOm91RTvExE1MCtYJb7pE=;
        b=CVD7ynTz1uc6yWfdJbTmFhhN84w3RJEJpyN4IgfKOVQgh4jZPe7Lh3xCa2vuNgNkTd
         ILNbZK6vyc8plsk01X+EfooqbEswtTq30cwfJPdj+h1TqjTTWq8DO8iBdvpkBBe0cghN
         +wT8Bh/OBlcrQ/8qZoO6u0CRtH0WKd7Hz8Lew0WKiwdeSSkjZjZcTckcyrmdCNI1nbyi
         g9v8WKHIVIl349kEMuYmWIKdczUn06ApzFQIe+80B7Hqz8EA1htcdpVPuITznfMNlMxB
         6wX6PM3GIRuFcZDyqBOiaRVcnACaHh4dbI6QUgIQpzysk/f/7xut31ioyL5X2ND95nIQ
         mZqA==
X-Gm-Message-State: AOJu0Ywt6vdivOQ768FNScRJ9bRbXBEQK93qapup4BAhSC92jdoX5/zS
	oJ5V/BBrengq5rYyapYy+h3bk74oGXcyu5kiUxFBde6tsGvfAzjkhLKg6P0j+Q==
X-Gm-Gg: Acq92OEIWzhv1HYthDdagaLal0WKYf9iYPDMOXA082POPsihKqq7plhqzLKivX000/g
	3XGyf+F29VRO+urjcmSc5tTfGtG+G9guKgN8Gl5XgfCFypA78vCFnvhIdSgOta6ox7sW2krUHg+
	CukFzSYy7KalTmnGQdtDfEhXl8sKWZoQJN1rzdlUPe1wD1krt+bWfOll+unSzTMlGH/LXqR6+ZN
	CPH/S5bsPiDWMXaWFgZZ0pjQeU8iQ3hnw94swb3T6+p3FnoPgFeKTfXm5HAucSPr9/ls3TaxSh+
	oZuUHT6Yorb+2Ypjzuzaa/jWlCX4Ff3itU+favl/BWQ7Y93+zupHbPZ/TpRGdSYPwUhO21niDSD
	npI7+7+XyZNKcRogyYajoQgKNLcylAJPBlLEWnH5kFJQpx3Qnn10sa/xfT+3IeMMHQ9UwT8Kyjx
	Wc4hAEJo5s2WLNAq0jFsGL9Qpbvb6ZehC4kp5omZY9WpKEz0hMQi16HtSvjBVRMP0aEXxispR5/
	iSdQNfrvjJFn3Z/+AHen/VYnO/hwtKOOAQjZtL4rqu0gw==
X-Received: by 2002:a17:90b:5905:b0:36d:649b:ea46 with SMTP id 98e67ed59e1d1-3779beb2b77mr1242498a91.2.1781149996617;
        Wed, 10 Jun 2026 20:53:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:16 -0700 (PDT)
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
Subject: [PATCHv4 09/15] dmaengine: fsldma: use devm_kzalloc() to simplify code
Date: Wed, 10 Jun 2026 20:52:39 -0700
Message-ID: <20260611035245.13439-10-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11418-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 032FC66E14B

Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
the probe error and remove paths by dropping the explicit kfree.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index eba194d64105..c3d2b24f8f07 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1222,29 +1222,25 @@ static void fsldma_device_release(struct dma_device *dma_dev);
 
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
 
 	/* ioremap the registers for use */
 	fdev->regs = of_iomap(op->dev.of_node, 0);
-	if (!fdev->regs) {
-		dev_err(&op->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free;
-	}
+	if (!fdev->regs)
+		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
 	fdev->irq = platform_get_irq_optional(op, 0);
@@ -1325,9 +1321,6 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 out_iounmap:
 	iounmap(fdev->regs);
-out_free:
-	kfree(fdev);
-out_return:
 	return err;
 }
 
@@ -1361,7 +1354,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	}
 
 	iounmap(fdev->regs);
-	kfree(fdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


