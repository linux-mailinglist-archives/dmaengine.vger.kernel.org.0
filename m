Return-Path: <dmaengine+bounces-12529-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lf5gMabKVmrtBAEAu9opvQ
	(envelope-from <dmaengine+bounces-12529-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:47:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329C75980D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NfhXU226;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12529-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12529-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5E38301FF3D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711C3E3165;
	Tue, 14 Jul 2026 23:47:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987D42BC50
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 23:47:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072867; cv=none; b=h+NeqwwRiNPhpJIV3+JrKzynTcu8rPGWUEfyuWTfbFhYWedzXGcCQAjIKeSF9kHg0Ue3Qo/o7DV/2Gd1O182uBtFLnjh8KCSd+cBeuidSy8u5HdcJhld6aL5qIL/AxUZ3UmM0SF6UTBxaI/pAi1LjivUjMI5zq+QOcLpOFMIIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072867; c=relaxed/simple;
	bh=j7A3pcuv3jfcB1SCiN4d6mbm3zZfaJLcFrPpk+oB9T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NooNLduHwzHS/vVncUHuaXhu6f+nfazw3rnH1Ng0I0/Ze8kUvxM+ghFxiMJ2KxasuLKWxDAWyOQpIskZ2xy+/LO4Fn2yxWp4CGqxxlPbMwXJCN4/QTtrr+ZZPB/saX6t/C44bUl3oF4CA50pZQTlYauEnkxIHLXJLH4WtJHsLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfhXU226; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1394539b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784072866; x=1784677666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=evgtESGRHB6CFpaYMcRbPRnjXl+LyEJwwEDrH4fU+3c=;
        b=NfhXU2266bDS7bm1azdgiX+3ef5Oe5rSklozhBTMKHbT7EieUOj+/+j5t/g84WbD2H
         g+VoBnJrqcLuJwNRGWuogLkg4AC7oiyLqlncrXOB8a59cYiGofMhQZuAYG4fmBr9lB6z
         o9F90rXhCYjrOHbEJertlwuuBGIr6etDh014jWGQWHbGkZ/V8rpj6V7Y5XhiPvr6GeNH
         7p7qiSVLQ6XoxQjxrcL1c0t43xDIie5xjCunctIMN4B0vtUdmRZJpne36lNCXcRl3ToG
         aeurCzitoKKFZOyuYCGE3MH5MQW4Yt3j6O67oDg8NEUwVLQIB1B+owPtfDt5+ejAuWFA
         +Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072866; x=1784677666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evgtESGRHB6CFpaYMcRbPRnjXl+LyEJwwEDrH4fU+3c=;
        b=cfESO4UYSYM9r2tcu2YzED+OC7HLAdU7zDzlyRg0I9nUCIaINO8ZmIA+YbUqbXpSZ2
         4FxWR+wjW/unQojhGLsfNq332pADP1TDBwU9xk/xtsH1+vUUQTnZW+LxOypv7hhaVnkq
         KcqwRTww0StqtX7GNaVo4+YIxUA5DxjNlmrO6gXlmhrZrRGLyyuFe957GKI/ZhUoHKqr
         TE4q43YZhtwVcFM8He3k6vdqykq3iwCY5/MPTWJtXK7DcvZVEexmxE2mS0EHVH4iwDxw
         86QER3P9BGVNQwXlGgHYimgJfA3W1RWHH1cu/hKdhwVHj0iKcnrEPfsiF+La+qMJ3KYP
         YTMw==
X-Gm-Message-State: AOJu0Yx9s3HDGC1F8rFDxlloonhpNYzud+XtX2dRIzVbwMsrU9qdHIzp
	+QrvksUV/m78avJ8U/8CL2VtZX9kHQHxOq6fc1LswdJT8H7Vhi8eLO7IndBZfQ==
X-Gm-Gg: AfdE7clZuP4lnh8OBpzg3682pYRcKY57c/R3zB4TAWhMJW0uFubg/O8SZr1dErgbLmB
	Fb8Ge+79Sl0jOF9+zmfdAbhYQYy/X+4/7Jh5M3MI33tfOJ4eCkdqmZeujGXt3pLWdYKK9pSSMen
	mmZekIFJzBNLcVj2VxT8cusCmGIAfmu8/RWRCo/TwEvAtlQGZxt2+mHV+NOBKcKuvPuZQjwDgPz
	LABKwo1fXqvZ77YT4iZJhFbkAJlRwaGX8RcE9+T7tcXM92QHHYQfaEMZe0nE/lvWWCcbuogcqtC
	I1kAtNm93t5OG2gzqRJokf+fVIwZOdVWX+FgWpv2Pqk1RlKDjnzoWRfMvdKKopZuB7mJtZprYbn
	KN1q4XC0OQFWCmdgXBUWPpp/Asc+GIvCOdHVQfJH49tOEzHAALfSEwTPrW7T21SUVCcPB74WQNN
	aFPTo3lRBUqF8uzgKqQPFN6AKyVBtRPlF8onuDAcG9mTqCJU3iqylPaVSWcA0B0uAN33xW8I8KD
	nfMoJin16xRIGA7KTwMzvVefKMnj+3rB/TxPAK4AscngYlEt8riTk+4tSawRKa1SA==
X-Received: by 2002:a05:6a00:1a8c:b0:848:5476:330a with SMTP id d2e1a72fcca58-84889625e42mr13796411b3a.32.1784072865600;
        Tue, 14 Jul 2026 16:47:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f242999sm2140674b3a.1.2026.07.14.16.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:47:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: txx9dmac: use devm_platform_ioremap_resource()
Date: Tue, 14 Jul 2026 16:47:42 -0700
Message-ID: <20260714234742.908956-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12529-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5329C75980D

Replace the open-coded platform_get_resource() plus devm_request_mem_region()
and devm_ioremap() sequence with a single devm_platform_ioremap_resource()
call, which folds the resource lookup, region reservation and mapping into
one step and returns an ERR_PTR on failure, checked with IS_ERR() and
propagated via PTR_ERR().

This is behaviorally equivalent: the driver already reserved the region
with devm_request_mem_region(), so the non-overlapping reg requirement of
devm_platform_ioremap_resource() was already satisfied. The txx9dmac
platform device (arch/mips/txx9/generic/setup.c) provides a single
IORESOURCE_MEM window per DMAC instance, and the child txx9dmac-chan
devices carry only IRQ resources, so no region conflict is introduced.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/txx9dmac.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 05622b68a936..6595a54a4b97 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1167,26 +1167,20 @@ static void txx9dmac_chan_remove(struct platform_device *pdev)
 static int __init txx9dmac_probe(struct platform_device *pdev)
 {
 	struct txx9dmac_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *io;
 	struct txx9dmac_dev *ddev;
+	void __iomem *regs;
 	u32 mcr;
 	int err;
 
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!io)
-		return -EINVAL;
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	ddev = devm_kzalloc(&pdev->dev, sizeof(*ddev), GFP_KERNEL);
 	if (!ddev)
 		return -ENOMEM;
 
-	if (!devm_request_mem_region(&pdev->dev, io->start, resource_size(io),
-				     dev_name(&pdev->dev)))
-		return -EBUSY;
-
-	ddev->regs = devm_ioremap(&pdev->dev, io->start, resource_size(io));
-	if (!ddev->regs)
-		return -ENOMEM;
+	ddev->regs = regs;
 	ddev->have_64bit_regs = pdata->have_64bit_regs;
 	if (__is_dmac64(ddev))
 		ddev->descsize = sizeof(struct txx9dmac_hwdesc);
-- 
2.55.0


