Return-Path: <dmaengine+bounces-9871-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJK4ALaYzmkBowYAu9opvQ
	(envelope-from <dmaengine+bounces-9871-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 18:26:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3138BD4E
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E156330B6FBB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFE3D3CEA;
	Thu,  2 Apr 2026 16:23:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74433F075D;
	Thu,  2 Apr 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146985; cv=none; b=S1aP1L7Z0jExIaiZUQe7SkT3W5utmUpJl3ECsnHfrPna2X/70v2EXn+BoxOcV/RUPPVqcvk162XQQnuEcC3HIiEwUjk2Xv/sW5l+HGmfi43SPvt2xENFcYPDxLbIlcarg3a7tQUuYt9STVEfLF24NvlLyn0zdr2f5DBFEFWH3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146985; c=relaxed/simple;
	bh=mTJWwhPgympdcCUC7Wry/f7CLEVbItNtKox26Zfz58A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFY8nn8qInFtHQAjvjublr0W0tKMt8TRSPV2WzbP7GdxdIWZ7JLxkZ86OaymF9FdYkAs06/TNZ3nMM+3BN9e2f3hd69g/ny/mxNC6QsbX8oqF1+t7parUKyLztRLQQah/CmM+7WG0lVfFT4KVZLfGep29D9tUm1Nrom46i90ejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oQdmVZxBSL2zNCsYkFwohA==
X-CSE-MsgGUID: LUu9iKOOSaKtPaW/2b0fgg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Apr 2026 01:23:00 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7B9F44017C4C;
	Fri,  3 Apr 2026 01:22:56 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing support
Date: Thu,  2 Apr 2026 18:22:12 +0200
Message-ID: <20260402162212.12016-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
References: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9871-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[tuxon.dev,bp.renesas.com,renesas.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 72D3138BD4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC, PFC)
require explicit ACK signal routing through the ICU for level-based DMA
handshaking.

Rather than extending the DT binding with an optional second #dma-cells
(which would require all DMA consumers to supply two cells even when ACK
routing is not needed), derive the ACK signal number directly from the
MID/RID request number using the linear mapping defined in RZ/G3E hardware
manual Table 4.6-28:

  PFC external DMA pins (DREQ0..DREQ4):
    req_no 0x000-0x004 -> ACK No. 84-88

  SSIU BUSIFs (ssip00..ssip93):
    req_no 0x161-0x198 -> ACK No. 28-83

  SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
    req_no 0x199-0x1b4 -> ACK No. 0-27

ACK routing is programmed when a channel is prepared for transfer and
cleared when the channel is released or the transfer times out, following
the same pattern as MID/RID request routing.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v3: No changes

v2:
 - Drop DMA ACK second cell from DT specifier
 - Derive ACK signal number in-driver from MID/RID using arithmetic formulas
   per ICU Table 4.6-28 (3 linear peripheral groups)

 drivers/dma/sh/rz-dmac.c | 72 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 95a89c9d2925..bde3da96b37e 100644
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
+	void (*icu_register_dma_ack)(struct platform_device *icu_dev,
+				     u8 dmac_index, u8 dmac_channel, u16 ack_no);
+	u16 default_dma_ack_no;
 	u16 default_dma_req_no;
 };
 
@@ -362,6 +366,60 @@ static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int index,
 		rz_dmac_set_dmars_register(dmac, index, req_no);
 }
 
+/*
+ * Map MID/RID request number (bits[0:9] of DMA specifier) to the ICU
+ * DMA ACK signal number, per RZ/G3E hardware manual Table 4.6-28.
+ *
+ * Three peripheral groups cover all ACK-capable peripherals:
+ *
+ *   PFC external DMA pins (DREQ0..DREQ4):
+ *     req_no 0x000-0x004 -> ACK No. 84-88  (ack = req_no + 84)
+ *
+ *   SSIU BUSIFs (ssip00..ssip93):
+ *     req_no 0x161-0x198 -> ACK No. 28-83  (ack = req_no - 0x145)
+ *
+ *   SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
+ *     req_no 0x199-0x1b4 -> ACK No. 0-27   (ack = req_no - 0x199)
+ */
+static int rz_dmac_get_ack_no(const struct rz_dmac_info *info, u16 req_no)
+{
+	if (!info->icu_register_dma_ack)
+		return -EINVAL;
+
+	switch (req_no) {
+	case 0x000 ... 0x004:
+		/* PFC external DMA pins: ACK No. 84-88 */
+		return req_no + 84;
+	case 0x161 ... 0x198:
+		/* SSIU BUSIFs: ACK No. 28-83 */
+		return req_no - 0x145;
+	case 0x199 ... 0x1b4:
+		/* SPDIF + SCU SRC + DVC: ACK No. 0-27 */
+		return req_no - 0x199;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void rz_dmac_set_dma_ack_no(struct rz_dmac *dmac, unsigned int index,
+				   int ack_no)
+{
+	if (ack_no < 0 || !dmac->info->icu_register_dma_ack)
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
@@ -431,6 +489,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 }
 
 static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
@@ -485,6 +544,7 @@ static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+	rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
 }
 
 static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
@@ -567,6 +627,9 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 		channel->mid_rid = -EINVAL;
 	}
 
+	rz_dmac_reset_dma_ack_no(dmac, channel->dmac_ack);
+	channel->dmac_ack = -EINVAL;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 
 	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
@@ -814,6 +877,7 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 		dev_warn(dmac->dev, "DMA Timeout");
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
+	rz_dmac_reset_dma_ack_no(dmac, channel->dmac_ack);
 }
 
 static struct rz_lmdesc *
@@ -1164,6 +1228,8 @@ static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
 			 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
 
+	channel->dmac_ack = rz_dmac_get_ack_no(dmac->info, channel->mid_rid);
+
 	return !test_and_set_bit(channel->mid_rid, dmac->modules);
 }
 
@@ -1200,6 +1266,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
+	channel->dmac_ack = -EINVAL;
 
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
@@ -1569,6 +1636,9 @@ static int rz_dmac_resume(struct device *dev)
 
 		guard(spinlock_irqsave)(&channel->vc.lock);
 
+		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+		rz_dmac_set_dma_ack_no(dmac, channel->index, channel->dmac_ack);
+
 		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
 			rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
 			continue;
@@ -1601,6 +1671,8 @@ static const struct dev_pm_ops rz_dmac_pm_ops = {
 
 static const struct rz_dmac_info rz_dmac_v2h_info = {
 	.icu_register_dma_req = rzv2h_icu_register_dma_req,
+	.icu_register_dma_ack = rzv2h_icu_register_dma_ack,
+	.default_dma_ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT,
 	.default_dma_req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 };
 
-- 
2.25.1


