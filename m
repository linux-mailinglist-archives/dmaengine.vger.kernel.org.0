Return-Path: <dmaengine+bounces-11422-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 78IrJPExKmqdjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11422-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E366E15B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PvqF9Uzl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11422-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11422-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0066A31F4B00
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F933BBBA;
	Thu, 11 Jun 2026 03:53:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0733C194
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150001; cv=none; b=MhsCJrnOKPdnWxrMQZQ4FkeduMgSvWNUX4cLhH6uRh1Ni98dqGK83ciwPU2ScbncsBuhD6GgSRvNfCRLgPRNUqkeCytwRvatxi2NQ1EGkSluLBmjnENA2Aui7TyqOekGN1GoQn1c0lxOSlrDD9Ra6gOcfw4+0c1mzqspgkOUU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150001; c=relaxed/simple;
	bh=Q/PgZrUxr7JJJLlNJf1HKxpgmT9Z+J8tRDHEovzB8l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3UzRmr9wqrWjK6JIYEKAzZb/yFeXPfas1vvhNHptPV31+GfQZeBqHSPt2kOeVvNKZZE78/PCV+AWsncP5+dAFs9BN3J0MJWbPvtpZYZ57umt+lMWiiOjK/lNSCdGYXr7mAhPc1Bb78UykZpMETeX2V64x4BGzlUWWQv7JoGXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvqF9Uzl; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso4881069a91.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149992; x=1781754792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=PvqF9Uzlmvto+4zxhnkGgZFQjOv5NzMt34rpoRvliekGRxFJVNvH5ZxTB1H85jiOtE
         rK4hc+PrgbTyzjauG7u86Sz54FGi1H9l1PT3rfsPhyxlwdDtSMMKntEwmuqRJpXSrPNj
         mnziR+UlO0IMQPLjkWG/7M3Tw3P9PVjjBiE2cvr9SEcCE6DhInhdlqO/bfZ33PnjAjgs
         zIqHLg/TXHtiLdrebjfg7XqnGQvNyZzY7aKToFJxmjkSco4EKbWGEjUH4F3NjygOqrzS
         lUepUzDUVvraC2ykgR7HT6ttwvC4jEvuogmF609XKYmBTfOJLLoDBr3T8SLvFGfbfIrY
         DXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149992; x=1781754792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHDaxjKNRdlH2zlMKhtRadxGEkWWwDYddu/hmn7v0eI=;
        b=WgFx5g658h8wqmOS3dQOMNjjbQHavBbMSZwL5zM6zzhsqA/1qTxeRCUdfCwdMpT0WQ
         KEPdH7KoYpzaX+EL4pUBy9p8csAaE7WxOxwcwhQ7JuKk2Ph1FHTCY5wjNObeg2ZVlABG
         UtgTOM1n7FjgPXHF1USvEHkn+oO7wlkrtRaZkWMoibcH/Z8HBDhSjaPh7s2HiX9ugLb1
         nXekr1+oEsnpVnkmJhoEgQPq8Sh/oXwXzTDOfBPEW+vYkuRcPmV6h0Wz77LCanOYBWe2
         6kjU60New/I397z/kycIU+9jZ83pM0UNPxs0AxH5YlZR2Jdu+gRAPHWm3X/mRQtWDzSu
         kaBw==
X-Gm-Message-State: AOJu0YzcSnEtCWTDm0dtvJKRwOsFjaASQuIiq2MBjtWKlHsX95VLGvMI
	C6Xnwq6dU6BOYOo4FAVNnAL1/0G0qRm/bsxRZq7+2WRd3Hk7pT4A2cAWCKzbZA==
X-Gm-Gg: Acq92OHVZVmvKHamD0qIVrilk5hGmiPG1bsRFwHsjMscgnJ5yUqp771FZpZhvBXGeLn
	ovwbX2zJiacP0Uj6xtopIx4+YMsfEssV5ksprErJ/SD2FdsRmwV1VF02h7L+LLz+f80LI43xKZ6
	Qhsdir/BZok610XPBESwzH2xJCJTguWeXZ898YN8eERKXdzQcJ9FYUtXFnSGDNKoMZHcdRHO13D
	PuRZmdHxm65zStXDuujDd79OxqEkjpyP0M0LyyMYmMkAhuU1vh5dDLcsxLlCvMBbdtzJYVJW6wp
	ohEQ1eCK3G3RvtY55OtQjbDkgxpyLDpFZ3ljiS9CFAAqqPDaqSi8adr8meEvklJw54QEmB/r6st
	HzodPn+MOr9rvIvT3H0hq11YscASWGTnGQoAWJ3KJXeF4EhYPX1kSyQ84gC7+TK05iMsnE/uA63
	cy+ubvMaUBGOZDY2GmuQneP+ckqRFA6f+P/zqvCd5pSU7ccKIzj14mnz8j9jUu2yIcoBSPOPBHm
	MzFFdnIz8UhhUyEnsYbfVO7VdzHSBtwsqE973vQwk9sgQ==
X-Received: by 2002:a17:90a:d004:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-3779e231462mr1177515a91.7.1781149992546;
        Wed, 10 Jun 2026 20:53:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:12 -0700 (PDT)
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
Subject: [PATCHv4 06/15] dmaengine: fsldma: fix probe error path not freeing IRQs
Date: Wed, 10 Jun 2026 20:52:36 -0700
Message-ID: <20260611035245.13439-7-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11422-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 328E366E15B

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


