Return-Path: <dmaengine+bounces-11364-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BM8kInKSKGqoGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11364-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:23:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E05676648BA
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:23:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZONDlq9x;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11364-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11364-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B56310BE61
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A43FE348;
	Tue,  9 Jun 2026 22:20:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAC3F6C2A
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:19:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043600; cv=none; b=aYCWDaa0VAn+mBfNJyguqFQfJGH1tdt2LU3ryNn2tUAk+N3+taeQ90s9j5II81pv9nCd76C93OaZXVyvakmwNYCh/JZr3TpHhpEvxbo0HuKQPc0BDqXrzFMG6vn1Xd1uA26x3syDzLRIT7mY2iHt7uSQD/l3wGI0dBDfTSaKpkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043600; c=relaxed/simple;
	bh=Q/PgZrUxr7JJJLlNJf1HKxpgmT9Z+J8tRDHEovzB8l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSSGFlhPiGfMqhfuj5j+UC6jEnyIZAuOmdTXrO4DqWd298fZNgFMt1J9NEeWeHNfjnpvPwlRRiHwXEXpCS9WXF6s1AznlELO03AsC7kvEjUDuYhFqRvn+lc1gNMtxSRv/jcnE2QZ84u/cgnuXvozASSgAOIpTQD1OfJOy11AbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZONDlq9x; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso3666132a12.2
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043598; x=1781648398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=ZONDlq9xye2J5i8YirIlidaw5Q5V8phYPxwHHJG7N+nAHcRp3f/h3R8dtHYDvjQ2JG
         goPWOlVtSvW2CCz/QT+Ko77OaiHpC/e8Quior+xcfnOi2X8B5YOA8aF0L+qyD02FyeI2
         fcYWRmTT2XhLrBnxkFyWWDBhyUyeP2kMxrG9xc20KNJJOyywhkA+p18yAGcaP246KgiW
         frywjjr3Z6/216XC7w9DJU7JhH9vkDSHHtt4MeJrKkgA7ORrO9DBtl6HZG1d6prleJH/
         tMYxcncuvUWmcu/raxLANaNmJsQBQRhy4n1mxGufsTX+sQ1OKX7pUXVys1TZUYi74jwy
         +HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043598; x=1781648398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=oPXMHEuwXa+BM+/9zJPt/YF3jzWjtgcp+Ye9PBlIa1D/zL71bUcI/ve3bipJd7EyXU
         ciyVVwcyghYiSIfy0Krh76uqXNDafV7iri20bk60kokuZZYFhY/K6rErpD0Jgnl4kZJT
         9QDwpXd728GRU1xyuJ32eBjpYfPuFi4CJZGE14e9DMnBOR8QmMRYM7PLfKcSz6COWFLt
         O1xv6WwuoJB6eY4vkLwBTjIHad2uZG4zTzgg997cHVWHOK1sM8Sy4fctsUOa9REfVOvX
         5puDN1Sn9bvmSIFKhBlXYisY+pP+wgOrHY1352wqZdiXpy/qqf+OcezleBmX0TeK76/z
         5SeQ==
X-Gm-Message-State: AOJu0Yyeev3r1Z1vzHTT1/7f2zgZoYHbbe4NTLnWZWXniM22EaFS1Xnh
	kLGz13MMTWHg/ZJHOzcVC2kz1rMq40bZNSI//lM50AdtpleE/jn1S+YKyOME4sqO
X-Gm-Gg: Acq92OHMcOLgJjXoCkHeylNg7/MMX87vqDDv3qzTl/vqyNgPUfgz5lrNnwT3j5yj8IH
	OSpZFvMgU2ocUBJ+ncQLPiYu+oaw1PHaQdA2+TUO4tm/nDG2R1KttJTkyPIKiQLQhIFm3HCrl8j
	gh23ZkTv1MEXXTMew0ZL2NKsdWf1EFYWp0TyZy8AQEGY2cT2Eh0lYmhtdf1OiIpDiTP3X8siGIY
	8ebB58GnEo/lOC3MV0DFRXuWyipBvqVljzdhM7GkT8hf48cOqSJpdd3npmlosdozwNYX7la290q
	bJd4nwVXrAT012sMUadc3/zd0J+qLi74pbzYoLKR88mOiPGo65hzjIEm0wBeySN13IhBPOekkJU
	k5LtZlLMBmwJ9qJ9G9BseaueZZLAYSvQ3w1S7dEZP3zpkQntRJsYiKtyT/1Z2v6NQK0i2c4ae47
	ruh//xWEhvokU7oRVlMxCcld01wWIIEfOh0y6OgwLcTVO20Bms3ZRUWgl/kKVSGDXEs9unNXUo1
	TSe67IFfhnSt7Dh9mImBxs7yaEF65DI8ucstDcyeLDnNg==
X-Received: by 2002:a05:6a20:2cf:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3b4ccd77495mr28317102637.5.1781043597716;
        Tue, 09 Jun 2026 15:19:57 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:57 -0700 (PDT)
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
Subject: [PATCHv3 06/15] dmaengine: fsldma: fix probe error path not freeing IRQs
Date: Tue,  9 Jun 2026 15:19:17 -0700
Message-ID: <20260609221926.35538-7-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11364-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: E05676648BA

If dma_async_device_register() fails after fsldma_request_irqs()
succeeded, the error path jumped to out_free_fdev which only removed
channels but never freed the already-registered IRQs.  A subsequent
interrupt would access freed memory.

Fix by adding an out_free_irqs label that calls fsldma_free_irqs()
before falling through to the existing channel cleanup.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 3009e1531292..4475d50a94f5 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1306,10 +1306,12 @@ static int fsldma_of_probe(struct platform_device *op)
 	err = dma_async_device_register(&fdev->common);
 	if (err) {
 		dev_err(fdev->dev, "unable to register DMA device\n");
-		goto out_free_fdev;
+		goto out_free_irqs;
 	}
 	return 0;
 
+out_free_irqs:
+	fsldma_free_irqs(fdev);
 out_free_fdev:
 	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
 		if (fdev->chan[i])
-- 
2.54.0


