Return-Path: <dmaengine+bounces-11204-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RMJSNxlII2qAngEAu9opvQ
	(envelope-from <dmaengine+bounces-11204-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:05:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5613C64B8B2
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:05:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lKpRYODC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11204-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11204-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DFE23093322
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DAC3446CB;
	Fri,  5 Jun 2026 22:02:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634143DCDAC
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:02:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780696928; cv=none; b=e/FxEjb0/JrW3ZKNbeoiKm/aTpg+Eevt2re6RyTEY0CYi9izBKFroOKUPPf0KgBM2KAH4OIjkZhjhVhpUTyU5eAbxEOoipkX4/mTZZ8eYwJN8kAjExkyREPYXLAwugQqBKPNv2wenwOZFJX1EtsOTWtQROOe9y7zwhuh7RZ1SH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780696928; c=relaxed/simple;
	bh=jRckM7Q/DiYZgoe/UjgP6+oEblX3ejArkHyi4yqjIho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdF+yvO9BXpcbid0nqPo7xRSTO57KvFN3WsJUUX9UWdtuyRXJFlqaoZSZfVyUbFXbPIvLbpjRkfulrh1mNL51Q55lY03M7aU09OnknGMvZXQzPRjjrwdcTyxooIw9Gc+JZlFAoMvm8b/f2M0u6aK5x363G8807+zCkaSGPi9qoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKpRYODC; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f420455so1088360b3a.3
        for <dmaengine@vger.kernel.org>; Fri, 05 Jun 2026 15:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780696927; x=1781301727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDWu5/hG//ENwpueDa3x2k+unyGwqq6tLB7KN2pYPhY=;
        b=lKpRYODCRRXbxBUzk37XEHD+f31cYk6GHwifjnNINpAmHy8WY2o6aZDVyqGJ8cUFMq
         0MzYAgDhPU4hNB1w7TdX+v8+xNHwX+PcqoxbZLi/302lzNpmaBBBxXPgT4s7ztWX2Yfd
         raV4vyzpKR0dMabuPKDR5Nubp06tKc1Ft2NwJTMdd7gaKIziR3oQ0JDbbLCJinZlzt1e
         GOYvbqvq4krjrnmmIsiHC3IJBrYSMNVjLzlx3E7x5TWHC1Zwrr+3vqsdJYV7xX3hVjmW
         zTSWTBS90hJw8wha+OkZTqOaVuZYm2nhavu/EADofYa3rgpqRsf0IH6f8rxMnFxklvjI
         QPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780696927; x=1781301727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDWu5/hG//ENwpueDa3x2k+unyGwqq6tLB7KN2pYPhY=;
        b=hOXNHHiXntMx9wpJ0q8+vmkoI4h39S35WDrH65HQ9kYKXtvTIOIq941BMDMY5qaAuw
         lXcJLLk0uiafiGv05qWUEqAFPBs//TEdze1FHz7VtKPsQpnNBBnDT4QdL0X6w4CXckWw
         rW3oNVKPF09YLWGUzAabucRjoYIlIm3Hdu7QhFdDnrT/FoA16DoeyrwLuJqXk25pA/az
         Y/R42VOVZtgVGHZeNgPF7V2ukUkXMvbcopF3KBiACrAU1UjTTc5M1wihds0TFoMVvP69
         d3nu2bzfHt5XDFuQSsx2TEzUMzSBvqJkw1j/CeU08WRG23R5jGrJDSJuZWUFcZoN8+7v
         3kBg==
X-Gm-Message-State: AOJu0Yx79jUno5t1ZpbLgMMF9NYY1Qx/0wEp79g0ExBBPiHcPMEUf4Ug
	cVOMIL1n7PBPSQJE9FAAolXuHuSTe5J09NfxCjYnA2pSm1d0fRIj4T1dQPcdog==
X-Gm-Gg: Acq92OFDsxBcoK+VglbbkUrk5nmVr0qt/mjU48J2pmUDS+gGtgbosyvTuKt/552lVgU
	tZRWbk+aiD14FcNCmZwQsU5871oLxq41oDXm7ops4Ad5izBpBj5P0+WhrZXfwwInIWJDceDRZCO
	RRfvAY7Od9fDCABaPdy4ZwOc7RSeRCDQXqbM+Zo0LRT22SxO8DUgVagTpAEr1V9XiK2N1osGA70
	fB0GvZNvfOmqzpO2Ewb8vO9bwfu9qnMTyC5BHHXiDGxQxq6D888mb9aJqHS8C1Gp0Ri615FMhse
	PQW0RLXrdxHerUf3dKXdiIicJF2QrwLZW5sb/o2ltXIyGoIS0IPsQ9n1NeaCl4XQYkiHb5UOQlX
	dEQHUBqbn3y6J8RsKx9MNLt3MrQ4gCUoZD7akAIxDKDC1Ec2phgLkDOUaElIzUfp2EVzlRzHxD9
	3hewxZ4CYilAjxJ/fUTbL+wyv/PJrpURdtDidlZ4gpdCNkAyUUv2nNW+zjxHSjaXVUj1LdV2zDg
	a3Mm4V1SRdd82nK3b9GDPQZCToMUUj301FXmMoQ2hAvMQ==
X-Received: by 2002:a05:6a00:bc81:b0:842:2ae0:968d with SMTP id d2e1a72fcca58-842b0f6f508mr5278874b3a.32.1780696926573;
        Fri, 05 Jun 2026 15:02:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm12518883b3a.26.2026.06.05.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:02:05 -0700 (PDT)
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
Subject: [PATCH 08/10] dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
Date: Fri,  5 Jun 2026 15:01:32 -0700
Message-ID: <20260605220134.43295-9-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11204-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 5613C64B8B2

Use of_irq_get which returns a negative error code on failure
instead of silently returning 0. Update the IRQ validation checks
in fsldma_request_irqs from !chan->irq to chan->irq <= 0 to handle
both 0 and negative error returns correctly.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0d73ce3dbfe6..79a268139b9f 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1067,7 +1067,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (!chan->irq) {
+		if (chan->irq <= 0) {
 			chan_err(chan, "interrupts property missing in device tree\n");
 			ret = -ENODEV;
 			goto out_unwind;
@@ -1090,7 +1090,7 @@ static int fsldma_request_irqs(struct fsldma_device *fdev)
 		if (!chan)
 			continue;
 
-		if (!chan->irq)
+		if (chan->irq <= 0)
 			continue;
 
 		free_irq(chan->irq, chan);
@@ -1180,7 +1180,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = of_irq_get(node, 0);
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-- 
2.54.0


