Return-Path: <dmaengine+bounces-11417-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HNUjI0gxKmpsjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11417-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:53:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612866E0D2
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:53:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OWRQAF6c;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11417-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11417-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5450F302DE3B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F033BBBA;
	Thu, 11 Jun 2026 03:53:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483333260B
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149995; cv=none; b=Tl4PgPNX5Mj4vJ4MNAAuwn1ifyrc8S2yIJ+Cz+miLk3Y03wBb1JEjSBAe51WvAXaNqrg0jQgUCCNvHIDFuXLutIBeyY16tNjSvUSZbq5aAqDbEWMGsvBJS1LaR4+eOunj/lHM8D6LgeNwlOW+HGe0+wKa0vajTgDJqdKHxEcZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149995; c=relaxed/simple;
	bh=hpFYqVe6ysg9za0CJbNVYYOl7z3o1IuEZ7WBoGNTegg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lALALOuD12MWhUddnndqBEuHySVRS79pr/T3MecLEygEEGJ4S9wDEArwE3Sv0hTVDZc10TZaiOuH99vYPuHLLJ60wi351BqBbMYXaTcKz+bcpxgXZzvnuG6PuL9lonpOol/rWCYVkNM0zxGEzwOtMeyA9qAe51AJ7TPB+WoSL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWRQAF6c; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b8d414666so4196510a91.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149988; x=1781754788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U4fRir7cY7WmN1QFR3JHwmFXZxM36Et4Gv4EjzBgmY=;
        b=OWRQAF6cIJE+8kFar8W0K/P3Ac4He8NpzIzdvFwKSPZMXJSAeXSmXYUDveVuFJOhSD
         E3EHIoOBoyTViFrNgCVr3++4u7jaWvbS8ep3y43e05B1OuVNltU+AjQ2e1dNFIsHWrsy
         6hYpwiNB9WGKXLT/ZsA7odqVJMq0qc3s/rRXnbHIKP9Ze+bRckXLf3Odv0wzdyUazSR9
         BUYz9v8zvW5D7y/HI/PzgdqmjerXwe41AZtraOBfV5bt4BsemCRkTDOWBhkHEDgy7nY3
         AYwmcUI8wYrtW5E6FiM+o1Yq6wVeEhJa6BKjK7E5vjhvxeKg/wMn37G9Jv0EN8JpI7qe
         uy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149988; x=1781754788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/U4fRir7cY7WmN1QFR3JHwmFXZxM36Et4Gv4EjzBgmY=;
        b=d9awEO2XoHuNf7g65G7+DqHpDKs5aKwmyllDGB1UMDY60TcBiy2T3LoiDyAp/I6oIx
         +tld6GObVx1h52oV18zzJG5SKLfmohLdJRWu1gbi7fo3XYZ5Xdb2OTazPicoFM66hwaJ
         OS/0I6A9Sk87AU/jsAPfb0+duub0zmDBkCYNUX0BTiqEnPdypd13f/yvrP6hSdY3Y9CU
         di2RmoW9/JK/zweNAChJa87LAmuOTViIyCihPLBXB8a5qeQZey76FKBjy9iTNgEeZDmc
         jCTeYaK/JJyZ9dltbn3vkwXYcaApod31USS0QRW+pYPtHM3/ee5Egqf8oC7Yl/F2yX+a
         MN/g==
X-Gm-Message-State: AOJu0Yxo+/NU6d9vgeqZh6O9nR9+60mTmBtna2wG9kao4Q3fiyabgsje
	GpX9HQPbT9t5mzKNi/VuFV/qOCGSKglohbPl8fuoTNqXZbNoHGOqGr1w06/Lig==
X-Gm-Gg: Acq92OG7Kqw6GdnkwSqLOsC8m4+JtN536ufDO09Xkt4zHHTEkCaBx0VV44qbiJgXy9a
	B22ue/YdOCdP6q1fU8jJPlmo1T7v31O9QOzZOMaQgdRuiDYpv+Oi3ZqVS6HGYqN5tm06k6eKQba
	7GRoAku1zVBmjpg2HtzuOO/fqP6NM28WM5JRILM3y6lAirveIY/b0COjxS7xzVJDjvu1OEmwz4J
	EWiFolMrBRXwhrZ7nNaWBjoSXkvSnGnWjNMke4CXN4F8/hv2yVnX2nMl7WFSbO6tkBxSyRExS+7
	xcv7Izai8SAbQZqNqC8pPROPJ/0CPWFD5vzLtxCx8Q9Jc1VO/CXurJ+fcVNeB2w1d+yx+UuexV7
	6F/eozAnYyL9YVUX58l978mNdbM+oz3KnO44WgeZtlqzi1grLQErReMrfE6/2xDKcHNLtLKYMtc
	PlvmRXYQxUg9QeD/DCKkJvsAFmwmejBVS2koJL4ack62RE9uhK6elt2KaQUlTHa4Il9llAtT/j0
	DnmenZ3lXY8gj0ELAmN7nLjbwjkJy/bWUi0ICxNaxfBSA==
X-Received: by 2002:a17:90b:3f50:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-377a870982emr1259378a91.22.1781149988448;
        Wed, 10 Jun 2026 20:53:08 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:07 -0700 (PDT)
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
Subject: [PATCHv4 03/15] dmaengine: fsldma: halt DMA engine before freeing resources
Date: Wed, 10 Jun 2026 20:52:33 -0700
Message-ID: <20260611035245.13439-4-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11417-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2612866E0D2

When a channel is released (fsl_dma_free_chan_resources) or the driver is
unbound (fsl_dma_chan_remove), the descriptor pool and channel resources
are freed without stopping the DMA hardware first.  An active transfer
could continue executing in the background, fetching descriptors or
writing data to physical memory pages that have already been freed.

Fix by calling dma_halt() in both paths before cleaning up, matching
the pattern already used in fsl_dma_device_terminate_all().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsldma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 455d21d738de..1ba10d065278 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -748,6 +748,7 @@ static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
 
 	chan_dbg(chan, "free all channel resources\n");
 	spin_lock_bh(&chan->desc_lock);
+	dma_halt(chan);
 	fsldma_cleanup_descriptors(chan);
 	fsldma_free_desc_list(chan, &chan->ld_pending);
 	fsldma_free_desc_list(chan, &chan->ld_running);
@@ -1207,6 +1208,10 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 {
+	spin_lock_bh(&chan->desc_lock);
+	dma_halt(chan);
+	spin_unlock_bh(&chan->desc_lock);
+
 	tasklet_kill(&chan->tasklet);
 	irq_dispose_mapping(chan->irq);
 	list_del(&chan->common.device_node);
-- 
2.54.0


