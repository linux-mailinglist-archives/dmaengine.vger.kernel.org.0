Return-Path: <dmaengine+bounces-9528-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AArYNqsdvGnzsgIAu9opvQ
	(envelope-from <dmaengine+bounces-9528-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:00:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEE2CE2FD
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AB27304B8ED
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344E3E9F73;
	Thu, 19 Mar 2026 15:55:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322D3E9F69;
	Thu, 19 Mar 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935744; cv=none; b=dtysFWSYQREJue/kgduF0qLo3/FqOPdFISddFxQSuYXkF+1XkHUNy6XOsPVVZmtqe3Euq2RXhdU6QkOnTu7uvq/g5UyvG70vmURH7ooMqULyzM268CMuxbUMVcFyE1rKkxJyh6xDoCkgynFT+7GntK248yxHNycMIH8/B+VMMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935744; c=relaxed/simple;
	bh=8Zc6OScGYb+5AvQgNfZdnReDdkm0l7MnThx/FKQQlXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCi/ZFkw8wxr6Dq6tugnFnoH5XLXAyo7IAScv2EaCw8JH07KZ8LdYYL31kjWYVYA3gpeal2Qrr5/LdTxRHh2bilRrnUeFxRVgRZblNfa2ugZ5Egjdm9q1nj4mZCmua6njJ61Fo8ZTC8GV7IV/oEy3U0Y+I98nd26bj6Tl0z3YiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: iKDvIp6eQS6mGUie7p6U6A==
X-CSE-MsgGUID: gjoqKmIDTFSnk/wIw57Zwg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2026 00:55:41 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 90E41401B2E9;
	Fri, 20 Mar 2026 00:55:32 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 06/22] dma: sh: rz-dmac: Add DMA ACK signal routing support
Date: Thu, 19 Mar 2026 16:53:18 +0100
Message-ID: <20260319155334.51278-7-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9528-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.611];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5AFEE2CE2FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals, mainly from the audio subsystem, on RZ/V2H and RZ/G3E
SoCs require explicit ACK signal routing through the ICU.

Extend the driver to support an optional second DMA specifier cell that
contains the ACK signal number. When present, program the ICU accordingly
during channel configuration. This maintains backward compatibility with
single-cell DMA specifiers.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 240c318b5753..d4a8cc95b871 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -97,6 +97,7 @@ struct rz_dmac_chan {
 	u32 chcfg;
 	u32 chctrl;
 	int mid_rid;
+	int dmac_ack;
 
 	struct {
 		u32 nxla;
@@ -124,6 +125,9 @@ struct rz_dmac_icu {
 struct rz_dmac_info {
 	void (*icu_register_dma_req)(struct platform_device *icu_dev,
 				     u8 dmac_index, u8 dmac_channel, u16 req_no);
+	void (*icu_register_dma_ack)(struct platform_device *icu_dev, u8 dmac_index,
+				     u8 dmac_channel, u16 ack_no);
+	u16 default_dma_ack_no;
 	u16 default_dma_req_no;
 };
 
@@ -362,6 +366,25 @@ static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int index,
 		rz_dmac_set_dmars_register(dmac, index, req_no);
 }
 
+static void rz_dmac_set_dma_ack_no(struct rz_dmac *dmac, unsigned int index,
+				   u16 ack_no)
+{
+	if (!dmac->info->icu_register_dma_ack)
+		return;
+
+	dmac->info->icu_register_dma_ack(dmac->icu.pdev, dmac->icu.dmac_index,
+					 index, ack_no);
+}
+
+static void rz_dmac_reset_dma_ack_no(struct rz_dmac *dmac, int ack_no)
+{
+	if (ack_no < 0 || !dmac->info->icu_register_dma_ack)
+		return;
+
+	dmac->info->icu_register_dma_ack(dmac->icu.pdev, dmac->icu.dmac_index,
+					 dmac->info->default_dma_ack_no, ack_no);
+}
+
 static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -431,6 +454,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 }
 
 static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
@@ -485,6 +509,7 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 }
 
 static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
@@ -567,6 +592,9 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 		channel->mid_rid = -EINVAL;
 	}
 
+	rz_dmac_reset_dma_ack_no(dmac, channel->dmac_ack);
+	channel->dmac_ack = -EINVAL;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 
 	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
@@ -814,6 +842,7 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 		dev_warn(dmac->dev, "DMA Timeout");
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
+	rz_dmac_reset_dma_ack_no(dmac, channel->dmac_ack);
 }
 
 static struct rz_lmdesc *
@@ -1164,6 +1193,10 @@ static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
 			 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
 
+	/* ACK signal number from optional second cell */
+	if (dma_spec->args_count == 2 && dmac->info->icu_register_dma_ack)
+		channel->dmac_ack = FIELD_GET(GENMASK(6, 0), dma_spec->args[1]);
+
 	return !test_and_set_bit(channel->mid_rid, dmac->modules);
 }
 
@@ -1172,7 +1205,8 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
 {
 	dma_cap_mask_t mask;
 
-	if (dma_spec->args_count != 1)
+	/* Accept 1 cell (basic) or 2 cells (with ACK signal) */
+	if (dma_spec->args_count < 1 || dma_spec->args_count > 2)
 		return NULL;
 
 	/* Only slave DMA channels can be allocated via DT */
@@ -1200,6 +1234,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
+	channel->dmac_ack = -EINVAL;
 
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
@@ -1568,6 +1603,7 @@ static int rz_dmac_resume(struct device *dev)
 		guard(spinlock_irqsave)(&channel->vc.lock);
 
 		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+		rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 
 		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
 			rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
@@ -1599,6 +1635,8 @@ static const struct dev_pm_ops rz_dmac_pm_ops = {
 
 static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.icu_register_dma_req = rzv2h_icu_register_dma_req,
+	.icu_register_dma_ack = rzv2h_icu_register_dma_ack,
+	.default_dma_ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT,
 	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 };
 
-- 
2.25.1


