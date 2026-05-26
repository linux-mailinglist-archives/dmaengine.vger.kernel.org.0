Return-Path: <dmaengine+bounces-10900-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCdqOEFeFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10900-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:48:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78B5D2A26
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A78D30300C2
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0CA3CEBB6;
	Tue, 26 May 2026 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa6yauWi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D246D3CE0AF;
	Tue, 26 May 2026 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785257; cv=none; b=nvP3TBY3zKOR387+EvhLj1/18JjZqDO0HyTnfwRqHF6zMf7mSpK4OZv5GemGR2eFm+wzrSC1YHL45agE7RNxhdWvzEeZMyBY0Z0LsbVwtX6PpjwIUOWLEZ5Rb3AhjpGuMCpXQAuhp1BiMuV4AkknUkzYbNONBz9g1uAhnNsVRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785257; c=relaxed/simple;
	bh=dOXXO6smS/hgkgXlh7QjPIQvG5iQs5dkEYEFowcS2zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcAWhBebM5Cy4iSE2uLFV0SUJalNnOKwwT3JPRDnTCjX5jQHuZBR9jgeS0nYTyuNmv4CsbZI/prOloYqCwYBs82Css2CIqJPt5q6I2LTjdeKP8+4eDu6a4dg+P80bHihIZcpjvs5eVY1Pe8TWvOdL8QpAX13tdSCXnJ4dnkedzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa6yauWi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1819D1F00A3A;
	Tue, 26 May 2026 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785256;
	bh=vCNRTrFYWrhBaJRY6mUheb5Drs3QTKVC1HA4HvxgwHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aa6yauWibIfIdDyXDfB8faeaEhzY8fDi6INerRQ3je18j+AGrqpi7tTZ3vM8Oiq8P
	 5urmktaI4VoMkWxdgSztx6g66WaEFl3mRf0xjVuVpq39FStitBr7ilj0B68sOqN70L
	 NJeugFSgaBblc8diT94XX7XlSxFA/BpRb+nZjoicIworG9mqRUShaoTImwRTHMpau+
	 8G2q24b/PoNcrnV/ra4XhOGjCGGAtLXYoL5+QtcmpJzvmtph8nT6w4V3ObYKJ7HcbM
	 ethRZ4OHul3D54a0eMV4C3gSauoAN4N2/cr9xpLsVKOPoRTPDF3LribyDtnpctBLgK
	 ZGqpopHg1lk+w==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v6 03/18] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
Date: Tue, 26 May 2026 11:46:55 +0300
Message-ID: <20260526084710.3491480-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10900-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5E78B5D2A26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use list_first_entry_or_null() instead of open-coding it with a
list_empty() check and list_first_entry(). This simplifies the code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6d80cb668957..1717b407ab9e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -503,11 +503,10 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		__func__, channel->index, &src, &dest, len);
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		if (list_empty(&channel->ld_free))
+		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
+		if (!desc)
 			return NULL;
 
-		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
-
 		desc->type = RZ_DMAC_DESC_MEMCPY;
 		desc->src = src;
 		desc->dest = dest;
@@ -533,11 +532,10 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int i = 0;
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		if (list_empty(&channel->ld_free))
+		desc = list_first_entry_or_null(&channel->ld_free, struct rz_dmac_desc, node);
+		if (!desc)
 			return NULL;
 
-		desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
-
 		for_each_sg(sgl, sg, sg_len, i)
 			dma_length += sg_dma_len(sg);
 
-- 
2.43.0


