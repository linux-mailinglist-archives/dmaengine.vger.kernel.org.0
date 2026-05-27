Return-Path: <dmaengine+bounces-10983-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFabFrZUF2oPBQgAu9opvQ
	(envelope-from <dmaengine+bounces-10983-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 22:31:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 019AA5EA164
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 22:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B133F303B780
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 20:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A4390CAE;
	Wed, 27 May 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqbclx16"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACF221FC6
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913905; cv=none; b=p/WAFFXe3r8V9w3GvZA3Jq/oDuLV0dAArx6Zas0kP8ttxgsqIQNjOltSTQ4yNzU9Z88M5dc8scmO05nAYJ5BQvYPFb+XVOAC458hM7uv4RXfvuJnn8Jnb3gl93CkTo/QHsV6R/90T8J4VilPrdpwWkQLgbHH/nSTUO3VYlw/DeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913905; c=relaxed/simple;
	bh=n03WGQD2FTWyI7l+8+BAvLXAQDjhiypSJsr08n5cdh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nKhAlkO0HHlSCD5FreaJxQY3jxtGLSm9lLP7aqpAPT0FrLDWHVxco+tLODkfTWzOd/i2GHfhxXyQvnbZOWtwFeJCjlX5Q/5naVM2r6FKxUbXT7s0wfeUD2kQFZHL3/Gi9SjaND5+e6CA1uEBNNY9kl1JsOjup7m6RTV4W71/mZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqbclx16; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2baef9f5ecdso98025715ad.1
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779913904; x=1780518704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rioPEJ0KzynPgjr6B78MS6b4e5+yQGAXGZOz4iEo+eY=;
        b=Oqbclx16OL7AIGcrWiQDAVGna8PX8op3e2LGoajD6rN+e3S1nA51VuQsWw4qRyh/6e
         DoMHQlvhlBUZhELhRvfeuQ7Tobv/hqJpH0On6XruxCZAJ0SaD+J06PHnEIN2YCbb9Me2
         kY0/LvxO8AF7QVjDcG8Gotih+0BVvgrzE04+A7iLQiKD70h7Ie418gHsMOggzz2fPLOb
         z0nsUlEeGlizv4x0eUgZW/kVUcjJq10iiiKGyVrYsAUcSyhie3oSMU3gQeLKpEPutWlZ
         98SRnjW4PLAlsOUdDT4BsGZZnh0xzX9Qig+iB17lFOiUeKjUTEB9ubuL1+zE9RP53EV1
         AKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913904; x=1780518704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rioPEJ0KzynPgjr6B78MS6b4e5+yQGAXGZOz4iEo+eY=;
        b=j+IiyAavGcCX3rxU0bbFQ01PMHQNPvspT3QyzMCJMTgcoFjXqdD11UNAL2qNbqrhxJ
         x7atM1JIShWwe/VSIEkqNI+m996hjCmhRD/KnQba6KM61sdxKNtE7FZyWi3sCQ3CZVWj
         +qLOWYW9kDEuoZKtHeGSgKrKHlueKB6a1cl2X8uYNCaOLn/HO4ftuehFTC+7geFU0lNM
         JDDPe+vMT0GjVOvTbMFOMopccBvUApfo6bbJgMAJCMkaWhLDIvhycqs52RsXlMV/heID
         5tHDQQ+FkCE+Jhvjmu9gtGLBeAx6J1TFs58hwfc2/0thSIpRGQdt+c2ZgUKYx7uzKuWA
         GrMA==
X-Gm-Message-State: AOJu0YzBarPY55yBVBeYH/dBL1C2uMMETAzAggyVJw/gDT+vysfeVDTn
	JDSqBDPilAiyMXq6xiDzcX/I5FzXwFkq1x7+QV+uQCcA/uSGZLBnNdFZXcS5CQ==
X-Gm-Gg: Acq92OE5oVTQyBXHazFpScmDDkRKejMfQyxhyFoa5z6XLamIICoQc3HuQH1OSoAlNRa
	edQ7wPBg21RM3OYupm5hyziqQAoiME+Cnul+dr+rz5ZmugrZKAWJZu/L8lYaIreF6grIU1ApeoL
	ikk1u1FtGylTpZuygpK5efig4aLz2uDo1BbfU/CAWLAa6UfelxHw+k4YJwJ7GTB9BmihxHTcvNQ
	z5CwBAa0a/JF7y0fJLAI2zREJ2D9Phv3W0mOOeycvsta/wvkhKU3Ree1zYhFsOStyylNy53uiim
	OzctBHUs3HhyKynEcxiyKf8BVasgtE5Ik32RogbrVhX/0pwYR5bS75+lHhNiWHcNB5bxQeWXOMQ
	gzMgSH1xOxRVsadH9ronHO9BPERMaHc+qTzYWy3c2wdOHA/RXBoFB5dTRV6yfsuwnW2gunKoflw
	5ALc7GIFD05wUDoaVIvVGQcPWrEdQXEW+3xqVIv+baTeWeSppdfl3T7IvSPQA6PBIMctUPDREkr
	WfvgKnLL2EbvqfTQHyn6JtOwytYe4HBoKT2CXzgNW3Cvg==
X-Received: by 2002:a17:902:e745:b0:2b0:6a22:5165 with SMTP id d9443c01a7336-2beb0631a29mr262237615ad.7.1779913904027;
        Wed, 27 May 2026 13:31:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b19f3sm218422455ad.18.2026.05.27.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:31:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dmaengine: ste_dma40: turn d40_base phy_chans into a flexible array
Date: Wed, 27 May 2026 13:31:26 -0700
Message-ID: <20260527203126.7053-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10983-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 019AA5EA164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the separately-offset phy_chans pointer to a C99 flexible array
member at the end of struct d40_base, and switch the allocation to
struct_size(). The log_chans and memcpy_chans slots continue to live
in the same allocation immediately after phy_chans, indexed via
base->log_chans. This removes the hand-rolled pointer fixup that
recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).

The ALIGN(sizeof(struct d40_base), 4) requirement is met implicitly by the
C compiler when using a flexible array member. With struct d40_chan
phy_chans[] as the last member, the C standard guarantees
sizeof(struct d40_base) includes trailing padding to satisfy the alignment
of the flexible array element type (struct d40_chan). Since struct d40_chan
contains members like spinlock_t, pointers, and struct dma_chan — all with
alignment ≥ 4 — the compiler ensures sizeof(struct d40_base) is already a
multiple of _Alignof(struct d40_chan) >= 4. The struct_size() macro then
computes sizeof(struct d40_base) + sizeof(struct d40_chan) * num_phy_chans,
so phy_chans[0] lands at a properly aligned offset without needing the manual
ALIGN.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: added ALIGN description
 drivers/dma/ste_dma40.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9b803c0aec25..d3e3c4cd43f1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -602,7 +602,6 @@ struct d40_base {
 	struct dma_device		  dma_both;
 	struct dma_device		  dma_slave;
 	struct dma_device		  dma_memcpy;
-	struct d40_chan			 *phy_chans;
 	struct d40_chan			 *log_chans;
 	struct d40_chan			**lookup_log_chans;
 	struct d40_chan			**lookup_phy_chans;
@@ -621,6 +620,7 @@ struct d40_base {
 	u32				 *regs_interrupt;
 	u16				  gcc_pwr_off_mask;
 	struct d40_gen_dmac		  gen_dmac;
+	struct d40_chan			 phy_chans[];
 };

 static struct device *chan2dev(struct d40_chan *d40c)
@@ -3128,6 +3128,7 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	struct clk *clk;
 	void __iomem *virtbase;
 	struct d40_base *base;
+	size_t alloc_size;
 	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
@@ -3197,10 +3198,9 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 		 "hardware rev: %d with %d physical and %d logical channels\n",
 		 rev, num_phy_chans, num_log_chans);

-	base = devm_kzalloc(dev,
-		ALIGN(sizeof(struct d40_base), 4) +
-		(num_phy_chans + num_log_chans + num_memcpy_chans) *
-		sizeof(struct d40_chan), GFP_KERNEL);
+	alloc_size = struct_size(base, phy_chans, num_phy_chans);
+	alloc_size += sizeof(*base->log_chans) * (num_log_chans + num_memcpy_chans);
+	base = devm_kzalloc(dev, alloc_size, GFP_KERNEL);

 	if (!base)
 		return -ENOMEM;
@@ -3213,7 +3213,6 @@ static int __init d40_hw_detect_init(struct platform_device *pdev,
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
 	base->dev = dev;
-	base->phy_chans = ((void *)base) + ALIGN(sizeof(struct d40_base), 4);
 	base->log_chans = &base->phy_chans[num_phy_chans];

 	if (base->plat_data->num_of_phy_chans == 14) {
--
2.54.0


