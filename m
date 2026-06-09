Return-Path: <dmaengine+bounces-11366-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4LR1C5KSKGqsGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11366-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:24:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C456648C8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:24:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CC6EixSQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11366-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11366-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B76A311A662
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125703F6C2A;
	Tue,  9 Jun 2026 22:20:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED43EBF0F
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:20:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043604; cv=none; b=NVV3kwPvzMD5UzVLoeaRDWRMKgKjlJev0WinT70zQ9/83ptDJSs2VY6U3XZFqwIAdwIqABXOCORSeVgUV+ONxbL0wGPz9x98mof09kAy0Fa/BRp7FhvVCpXyzG4WUlNegbMiocU+YU+xZHSCCp0Hi9YHF1gjNzloNhmJctSy6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043604; c=relaxed/simple;
	bh=mMIyKUxGwOQ8VAAYDDOeEGrsfwtY2nZkynSELcs+FUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9dN3BRG6yTjqP6BcirJZzP3EIUhnhkTmrgb3tcbpQo1Em8ecRkB6JfwnryCjyH8cTHBLOvBRZ9Df1MaXIDJrq/XiuTujNtcFvp7PEQx9OJQxn+u49q0tRHncG9uousXaklIWA9uOEP4J8hTPBdZb20J7Daf2d9aG9PfSeqFPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC6EixSQ; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8589498839so2708580a12.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043602; x=1781648402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQhRsjTa8nt00Vhb5aXmUlX4VLfCEPtM7YH8ZPQELfs=;
        b=CC6EixSQONkImY7HW8uGss/b56J1EgO5L9L38yqQq/4JadzQa85M4azU26feVDdIW2
         QdivhlSEVvIpYhSR1p0AWkAF+BGSFNmHj8ZX8849IfDLJnP+UYc0Jb1r+eKNFq3QOMRD
         n85lNZZyNr56u52G/mn5soPi9rAdLrSAAwaebc0DzlaMn4o6s5EpRgGvDiIBcCZfzK+6
         IUn4z5uw8UsnBPdPwBrvcemEPTdbF1ZvZ2Qo6Ycj3FghOC5khKYVn5QuhNq8QegHfGfo
         aKoaS3PbqF7StZsQqmKRa3KoZ/WFF+gn0eX24H1XcEl+J6SnQ8/8kLR82sw4ngww+FXZ
         sbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043602; x=1781648402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQhRsjTa8nt00Vhb5aXmUlX4VLfCEPtM7YH8ZPQELfs=;
        b=AnZ/XIGoEXyRYIMg66iLq+H7NoTwT/bS+LslOvwl6osRX2tZqICh1ElV9TTEDMk/KS
         NOeyjm+beAda5x5bLW7J9hZ07On2I2WjbHtKeZYPlIF3rZ3xOTqYBub6idEBfcBc5naa
         juZTyBO5gBCSo1o6bODPSGItef3BjTtp+emOPAHdXS5FpocLGKpHsWirDmbbP7LXYUnb
         qZO0C8YylbooSdCuSORX0LeqBM/zB0aBKAAHA2SqqaKC7NVbV3g7EVQ9qtNLFtEzQtoA
         yHBxXnV1xpB8hI347KypKFHBuqcuXuxKzEv4fn6hSQBvf960Mg28koKikrfWlxSFZ5fD
         twMA==
X-Gm-Message-State: AOJu0YxoS/sZn79FMv519ukR8YndfFguWhz3nvN6qLWe0/dPp/6u0234
	3ZERDiazqrFKYbrar3bfGD2SNHYeoLV61IMb/N1caigbZO2gdzIudY6EmE8vag+P
X-Gm-Gg: Acq92OEBGxZ126WYc5Z8jn9j4k4Ml8d34ujKi/XkXTDzLOgMp8tTWeJgUqwh9Xu1xNr
	NO9ASSylh7l3G6i+UsVy7VU1kZaf9+Y9XGqIGAhzzvYazOzEPEcOZUZ6/CsBPczPHXXVRjRSC8R
	cQDZANM9WQQv4oFfExzpSe4sFwxN0rFe0+4dstUOSToSXG/b/4u89LX8Nj0j9oxRAKYQ49YT3Cg
	01AM2V5H6Xj+FYZK9RNJzpGIOiPiQaL3tAqjYCevcFu/E0Jz5NjZ6cfhkjolzrzOZVjxWJ4MBDR
	Lf5B6H7mQRi7AO1aDreICe+vJchHXkR2bifg0hF4eKLz5ZRHXMGJSKVdsK1fFvlAk149LAEISDO
	ZbBYGGOF74WQRlUT4HdMxUxrlSy6+xLmEYi/U8TMZsJcde/hZIgq0IKmwrBEDtGivCeJcwdQ8Ey
	HmVJ8u8bnQdtTdGe5W74YS9SUPa6R4ZnIUNpaeJCnou/4KZZO9if4vCPTCiEQFJ35ldg9qDJJbU
	S5X69G76DzJR72Y02i1k4V5wuHHQ13GlyaJNSNRb+NdRoPR01Ibuq9x
X-Received: by 2002:a05:6a21:a94:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-3b4ccd76836mr27046937637.12.1781043602200;
        Tue, 09 Jun 2026 15:20:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:20:01 -0700 (PDT)
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
Subject: [PATCHv3 09/15] dmaengine: fsldma: use devm for kzalloc()
Date: Tue,  9 Jun 2026 15:19:20 -0700
Message-ID: <20260609221926.35538-10-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11366-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: B8C456648C8

Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
the probe error and remove paths by dropping the explicit kfree.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index eba194d64105..dac12de06ef5 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1222,18 +1222,17 @@ static void fsldma_device_release(struct dma_device *dma_dev);
 
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
@@ -1242,8 +1241,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->regs = of_iomap(op->dev.of_node, 0);
 	if (!fdev->regs) {
 		dev_err(&op->dev, "unable to ioremap registers\n");
-		err = -ENOMEM;
-		goto out_free;
+		return -ENOMEM;
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
@@ -1325,9 +1323,6 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 out_iounmap:
 	iounmap(fdev->regs);
-out_free:
-	kfree(fdev);
-out_return:
 	return err;
 }
 
@@ -1361,7 +1356,6 @@ static void fsldma_of_remove(struct platform_device *op)
 	}
 
 	iounmap(fdev->regs);
-	kfree(fdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.54.0


