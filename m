Return-Path: <dmaengine+bounces-8470-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FabEY4ydGmm3AAAu9opvQ
	(envelope-from <dmaengine+bounces-8470-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:46:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A237C3F6
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 03:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E960303968B
	for <lists+dmaengine@lfdr.de>; Sat, 24 Jan 2026 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2235226863;
	Sat, 24 Jan 2026 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlDteU7x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD62217F33
	for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769222752; cv=none; b=XxZ69HbeiRHRipnBoxRpvxfF9S8v77X8qeCE6xcZW7USr3S+zhjVLkkjBaahho0qoAhKD2UcAl353Wu6IAvbbYyjV38ZWf5Q8kwDRnZY7jDhVfdkNA5rDMEYZuWPynjdUwygiTkVQlk1EWmfZm8O19bFnI6L4Nhi8xBV3XMSX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769222752; c=relaxed/simple;
	bh=7kIYCT/CsNfKsrwpWxONV+yvNh3NM5fdoFMTV9HU2OI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQUAPmZJE0h9vScO1SjIzQuKRKFtMn7O4ceDtTGlcq89W6fOrg1+jvTZIl6NJEU7JN8Yu/snaiqulirJKUb+99768DWk2VPQgaNhqcDauThmuIg+SjTBxLL5tLGrKdM4edhS+eKqUYpW4U5WqGfphCeLitu+0kJi/s/XkjLe/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlDteU7x; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso1551145b3a.1
        for <dmaengine@vger.kernel.org>; Fri, 23 Jan 2026 18:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769222751; x=1769827551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5idsE3kyWrOGo2nrRKbAdnFEr6dvFU7Gg/6HS06H7Y=;
        b=UlDteU7x7NxJ3Tnt9kR+h97bF3Btwp8DslcGIhGT9v49MX8cltk94GM2Wd2NIa8FhZ
         egU7+BRWt6wEl1EjQ6PwsQhH5VJhmY1WO4zPbB7destAFsTh0dqfX003as+shWBD9t5k
         KfCxYuSqZpfvB/dyHFAEST4CSv0b4skiKHSLvY6zZlE5fDVnPl1OK9KmiIuLQzcQ3M/l
         vCViSTGQyxZptzl74BWjomKvjuaazEfZAIR9/1lXsybJOP596M2A4JOLzvKJDzrMLzxT
         gPYQ31R8vSJ5mfhYhBXQTbXa89DqG3T453GZnCENojDvLIGwtC+/xMuJv7Lv31LO/1h4
         lAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769222751; x=1769827551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g5idsE3kyWrOGo2nrRKbAdnFEr6dvFU7Gg/6HS06H7Y=;
        b=NdpBmQD44F/l0eWecE0PqpfY25J/2SXkkfRDfNNxPQt/Osprt1FV1sh1lXpeq3voep
         gIHHoFnYZ1eR5oPbMg7hi9ib0BjofZjApPCYPusxo+EZWNC8Qtnl+K44z9QWUFbsMGjs
         fGppqiKWBAiUDQmbww0mhpPa9iUVzb6HdttuMpDr1+om16KGn/Aiub1f3ahDXJX/n555
         pQgSmLerentvw3HtkYN4TyiFUqVBy1uaIeq590Ef+G2Zh2RiHQd0SBAWxcvgctxXSf6r
         MwWx61V2TnbaQmFsIc4MWW+Vuyng9Ic4i9kam+vXOxJWge4CJ7fFZdYPuu5gPwWuRJzc
         XD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXBsbS65HV+h6rwNnAeHymWZWe0hqItqrHTbm2PqKWi9y8u3kiNMDt4CceSq6MWCgZNFUx/2REY70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9CXaVnm+brPtteL05+r4YlnL819B8VMqkwrPPXt4UV8+keIm
	fgh6jn9/31PNlDP+NEe45U5LG3VbsEbWG5dix1OTJbkHVRpyq4cGYFB8
X-Gm-Gg: AZuq6aJ4Hbm3BwxbT3se2dLTnLWV8znEUSklR/rF0l1lofnyIL41HyvkWJ5P+85uGJL
	uqZs0Wz4+YKmQ+IW3ksnLzqfb6nwVYUIOLVTketoTnEJGsj1qgBc5LCV6dza/CM8Fe5qX4eHJiu
	tUH3/f4QFiGIYmF0zDKeQlnA4N85BbmNBgG0cInwYbLYVJeF0w08D+E/yOGehGku1L39AKpTrZ6
	eIRAuGTwan0ujoe9Zl/Nsus2iD9RSeACspM/Eow26H3uBIudyBTtKnn931l2WH9H+osuI0EWc9e
	VZc9cwKFshOsg1uf32sPQ5SeR4WK+T445esMIMH0l3TUtYNBRy1FDBg2XsfjFRNUoR7sC3d98nJ
	0AflJ7xTGT5sDb4ZorYskz/WVQQJwilCxZU91wtepkdTWPUFMPdfwJG4LUb9LIuC4zxuWJDSnId
	s39NeOdB+BbLIATN5fxOBaw1QCh4ejVnyynrw=
X-Received: by 2002:a05:6a00:4b06:b0:81f:3f03:6832 with SMTP id d2e1a72fcca58-82317e1e716mr4465903b3a.44.1769222750757;
        Fri, 23 Jan 2026 18:45:50 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318644989sm3279598b3a.13.2026.01.23.18.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 18:45:50 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v3 3/3] dmaengine: dw-axi-dmac: Remove not useful void return function statements
Date: Sat, 24 Jan 2026 10:45:39 +0800
Message-ID: <20260124024539.21110-4-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260124024539.21110-1-karom.9560@gmail.com>
References: <20260124024539.21110-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8470-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F0A237C3F6
X-Rspamd-Action: no action

scripts/checkpatch.pl --strict throws
void function return statements are not generally useful:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:598

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
Changes in v3:
	- Split the patch into smaller patches according type
	  of warning.
Changes in v2:
	- rebase on top of 3c8a86ed002a "dmaengine: xilinx: xdma: use
	  sg_nents_for_dma() helper"
	- refactor the commit title

Reference to v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e59725376f8e..c124ac6c8df6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -593,8 +593,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
-
-	return;
 }
 
 /*
-- 
2.43.0


