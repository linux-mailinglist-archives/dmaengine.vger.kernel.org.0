Return-Path: <dmaengine+bounces-9915-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yccWDVUK1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9915-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:44:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BC3AF64B
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5A43109A33
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B461ADC83;
	Tue,  7 Apr 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iTSeG/8J"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1383B8950
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568953; cv=none; b=W+2/gQKqCrPoYh3V29u9haaMQHBuuXfo0ehXEM/Qtd6YvM7Z7bBNPE3RkkXPUpbuEZBdmtrnYsiI5Uj69qu9OdsBvAHeGQq+2HqBYN06EY5vRjC1ZVYILmNakBXx1K3vzAV7huyJsyr6R6z6mjgmjyJwO9wrguUru/W3t7C6MMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568953; c=relaxed/simple;
	bh=q6oRXOaJk8L7LPyGO0Tyfzj+SUjE/1LBugvyTQiyfxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGuJjrmHRHRI/nbtPwrj9WJwRG2m/XuTOswxMA+9Nxr2T5UTbQdMFlpUx3lNZlUuj9li3nEfQVdQqEVya2Tfo97NRt3pTARwVcaXPSOyjFJssWvXe/yexDAWhy2v33pEYuONOF+KZwmU1PNY3t6VwJIHpp+g6tC5oqlAoM6bMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iTSeG/8J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso45002835e9.1
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568945; x=1776173745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrYQrHbvnZn1N2MhGkB4fAR6VCs+0IvT3ATvQcESfxg=;
        b=iTSeG/8Ju+t5Hyb2A/nc0BgLmUYgBlwmZtRUgietPfS6e4fTgpKy1Jpo0lmGqAWv3y
         2DzcQEI63P0wZw59H8iskJ0WZXw+yWvTNjK6SB4Mo3ydyH0mdnWy9Yyt9v5azHjK1P2w
         CX45fLd0N8vmbza3zkGR32FP42Maro5l9ApK8cJuF0M0GcpggRwB+ikYc1vBM0w6AdBM
         B1gPcYnxBv+4tLoCCzBqh0Yv7rDvoZ+rdoAe6LRYvNqUjOfOIeRAeicBmST/OR221x5j
         7iXL8lloZzQ6/4nL3PGfnsyPv+jrr+qq+uBwOikVBvOe/p+OZYw9yNC/AIHArXnNv1vz
         3xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568945; x=1776173745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrYQrHbvnZn1N2MhGkB4fAR6VCs+0IvT3ATvQcESfxg=;
        b=DU+2KEsNHLZFe20JqMVu6JeBCrDISyJy3IxcPfUSZwjEslrnX4KXcRm02fvqbMSyBu
         J8m/CKnFlvymLZ5+r6gJgBc5JjSTg7LWfhHBog87tMCu11hQHSxzWg/+O1RixSbUnaNd
         2/bqasqxui1hHxgpMbMh2iuQkfGRjphUjNnaS47oupxA6kwGA7LU/39mUieAGdys4Bk7
         QS9cAgxhEihIee3imyY8/TJR/QP1kFMsiTwA6ZTfSV5D6rl2Qgie4uNi7yYC1Njz5gis
         SL0eJLfz0PYM2Zof8LY8h1bgAwpzQDS1SiD0GtZ70jbyTaLMuqMwcnGBcO7xg707ifq0
         IKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCURQHMnnQ3pKPoJOj7Inw7lHDw2jg9D5EQKy6b424rIutCx2dOOgSPHAdKtWOpnLe5u59TgxQDP8hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzewNfWpp7FxMpr4Lpw0pgXWFLyPKNal8QsLfqLCjMh9rosCtMc
	dREFzMSWPTNbxXnBs0hzENyO7QeIviNP+2ReYbaEgT9HxmOLUmbSRYrV4Y6DIPoK02A=
X-Gm-Gg: AeBDieveRpbrcFefOVeajU7MYSMAtbSv4RJ+xGukdhHzctifU3corsb2LpxXsAimywN
	or169zdV6vUonpe/eYY9fOTC37jQ+K3IaL2UdMIDgAqKBEIHJCl5vR9N0BXcy2chCoE/Dt6OPTz
	uTejJs8SNSNXZjA+Y0eLY+Y48PUinRNS/PXdIeH2JNnsGozHhzHJYFig5/8OYSfbDun4EdnwWG/
	qv9OBkMm8IXxPImZ2cuwqRoWNlxTdh4mpRznHTLoCXeo95o3BLgT/RLqTeRDT4mCpXz57mh7/bo
	3jZS475wsNoXi3U3Qpd9hMdE4wXKUqrN00XmNrCfj690tX5E35LgIiPOBtwid1aKGqlU5zxuqHK
	akWbQ3+Qj+IuVf0367jS/q+o0mKgsEVEsVkr2kXyuM1QcchV8G5TWcUB4XJY88H+G5MJE6AdLCH
	HhSKH9o9kzDdiTewMiPDSBEO/pNtshthZYo+Z16CmnzoAUShfyBFec
X-Received: by 2002:a05:600c:6098:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-4889fb73b1amr209462685e9.28.1775568945398;
        Tue, 07 Apr 2026 06:35:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 10/15] dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with CHCTRL_SETEN
Date: Tue,  7 Apr 2026 16:35:02 +0300
Message-ID: <20260407133507.887404-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9915-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B1BC3AF64B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
struct rz_dmac_chan::chctrl with this bit in
rz_dmac_prepare_desc_for_memcpy() and rz_dmac_prepare_descs_for_slave_sg()
is unnecessary in the current code base. Moreover, it conflicts with the
configuration sequence that will be used for cyclic DMA channels during
suspend to RAM. Cyclic DMA support will be introduced in subsequent
commits.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- fixed typos in patch title and patch description

 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index bacde5e28616..8fbccabc94e4 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -377,7 +377,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 
 	channel->chcfg = chcfg;
-	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
+	channel->chctrl = CHCTRL_STG;
 }
 
 static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
@@ -427,8 +427,6 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
-
-	channel->chctrl = CHCTRL_SETEN;
 }
 
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
-- 
2.43.0


