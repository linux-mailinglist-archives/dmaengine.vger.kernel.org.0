Return-Path: <dmaengine+bounces-10902-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJQvBEReFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10902-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:48:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E775D2A2E
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC421300B2BA
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED433CEBAA;
	Tue, 26 May 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC6qd64I"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E473CDBD3;
	Tue, 26 May 2026 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785268; cv=none; b=E0otGNcpvcyut/HS2ycp1AIC47ScajoYIdBbhKIAYgANug9hjj/T2nOiEAKV2Zc6MSXMl8GCSMWT5pJqdypuWJi3kVeg7O+V84aAEIx3CA7kIlFos1Fi4Eur32hHpFgYOSFz2ekRMLqf+UlQVA855pwkqhhoEW5iNYkeHwbxvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785268; c=relaxed/simple;
	bh=3+WQEB1tCHft4J06EvUiUd460PHjj8UHaQXaNA31Up4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMhWXnSM7zZpQOUqt9/YwafSI+tdM29c2hCay/6e9ODROqYrCt2JlIOOEV7H47s/bdVr6v4Xmq7mf4af2h0a9SiyT3ow6BepGPByzWB0f8mlE77IRoRp6UM6amv6035HmsqpFZP7OeSnqS4WrFLap79mr1Buq6Ndhl02pfSAMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC6qd64I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33041F000E9;
	Tue, 26 May 2026 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785266;
	bh=u38Mn20jaBcjJJKPeB5LG08OBQ5jyQmIULL1EIPQ35c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mC6qd64Iz8Gz70qgPxl31HWr4Z+G1NFuB6Ed9k5SJb6VxIQUudONfqcXFISbbPOSZ
	 /sBTGFdxgeeavVk97m8yBA/52f0An+nkNx8yXse+CO7nm5AGrUgxe3i4X7CeC+LyHr
	 GSVl+VYja9jzwLbCNkVv39HNUhYY3Wj0Y7J3TUtQj13tNAAG8GqNlrRCPehFgJko75
	 26mrp13eMBzJR0hCXJm4yKjJlwqIB0vUMvQ7XHWVnUbYlFxC4BCtwNDffEiDC/q03d
	 +tJV+XUDJU8fICijgiZKpqHVgqcaNBi1mFqSmh8qy9BPybCJu0ZjxVPYk6YfS7C7rZ
	 R5YlFxMVhaaoA==
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
Subject: [PATCH v6 05/18] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
Date: Tue, 26 May 2026 11:46:57 +0300
Message-ID: <20260526084710.3491480-6-claudiu.beznea@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10902-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 36E775D2A2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a the rz_dmac_lmdesc_addr() helper function to compute the lmdesc
address, to make the code easier to understand. The helper will be used in
subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- updated patch description
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 40ddf534c094..c48858b68dee 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -259,6 +259,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *channel,
  * Descriptors preparation
  */
 
+static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmdesc *lmdesc)
+{
+	return channel->lmdesc.base_dma +
+	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
@@ -284,9 +290,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 
 	rz_dmac_lmdesc_recycle(channel);
 
-	nxla = channel->lmdesc.base_dma +
-		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
-					     channel->lmdesc.base));
+	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (!(chstat & CHSTAT_EN)) {
-- 
2.43.0


