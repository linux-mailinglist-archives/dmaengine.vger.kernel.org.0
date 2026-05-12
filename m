Return-Path: <dmaengine+bounces-10346-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBmpCUMZA2p10QEAu9opvQ
	(envelope-from <dmaengine+bounces-10346-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:12:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D277451FDB7
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 876DD302835F
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CE4CA285;
	Tue, 12 May 2026 12:12:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0E4C957B;
	Tue, 12 May 2026 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587956; cv=none; b=j6J7j26/uBugpIHTlcgTyB1yU3MvCJ/DM6lt0xTssOuTyIWdqCp+tR30/qGXioRM3NdpmrO49FAV8IW8X5a/K/ymJLLTWdv5dEpEebKkoA/YtHUrma2dpLNbsGPj2Kd5wZ5Pf4g4JIQS9lfDbt9XRs0deUGH9x18rQiM+7Y0qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587956; c=relaxed/simple;
	bh=NGeh6VbMXJbRCOaAXOFaMvZWqB1dLolk0xEwA2DIvqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+PeI6mPkICOYxbaZt/yrZcCTk073w7wmK0gEI2AQKo5Wh3gD73UpFa2KoV+KijT4OCfU4/3HUj6srib7DEVvABOQ1r2sf2OKsN3zRLKWPmAJMlGB45GzOP1tYNIBvSe/sVUSIOJxinNxF7NCIhMTvNJp8Xddn6ViTz6pFKIMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7EEC2BCB0;
	Tue, 12 May 2026 12:12:31 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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
	fabrizio.castro.jz@renesas.com,
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 02/17] dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()
Date: Tue, 12 May 2026 15:12:03 +0300
Message-ID: <20260512121219.216159-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D277451FDB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10346-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	NEURAL_SPAM(0.00)[0.092];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea.uj@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Action: no action

The list passed as argument to list_first_entry() is expected to be not
empty. Use list_first_entry_or_null() to avoid dereferencing invalid
memory.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9f206a33dcc6..6d80cb668957 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 	u32 crla, crtb, i;
 
 	/* Get current processing virtual descriptor */
-	current_desc = list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc = list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
 
-- 
2.43.0


