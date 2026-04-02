Return-Path: <dmaengine+bounces-9829-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJGtMx0yzmnIlQYAu9opvQ
	(envelope-from <dmaengine+bounces-9829-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:08:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B373867E5
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B47E03078734
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729C343D91;
	Thu,  2 Apr 2026 09:07:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DE30CD85;
	Thu,  2 Apr 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120855; cv=none; b=XT6dMlN+oyRigdE6F5cs1Sw9X4wCwjnfdYv7dq8adc+N0tuz7Q7liJ2zSZKmEXndzjZzm8bZLqlGcwyktC4GaV4sN4HZJmn29OsKAVb6PvtmHi43IPA751rqyLXTLnzaEozdI1pYkGEz10NglBYNEVOuSGSX40ZMuXHzqgOPsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120855; c=relaxed/simple;
	bh=bW+iaug0FNMiG9tj0x7pjPK2zNnlGCyzRzkO9NxK7A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCpQ2r4nlrPMDk+rymZwGMm3qwBI67PV+Kh9cxzJEBy0iBrFeSCShqclCrG2htVd0IXxH9vlskHQ6o/oPtV2E/U3z7qTRdp6lI3ZPVCbM2ssXsGVA6fwPHWdVEnkWSrCzgwVgjiaQdlR4HzHIoGrBE8pY8gWni2cNqRfBq6jAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: kQlYuit7SKWvd1gIdCODkQ==
X-CSE-MsgGUID: JrcOUulOR6SK9AO+OY6nOg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2026 18:07:33 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 439E2413E676;
	Thu,  2 Apr 2026 18:07:23 +0900 (JST)
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
Subject: [PATCH v2 03/24] irqchip/renesas-rzv2h: Add DMA ACK signal routing support
Date: Thu,  2 Apr 2026 11:05:02 +0200
Message-ID: <20260402090524.9137-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9829-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 75B373867E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC) require
explicit ACK signal routing through the ICU via the ICU_DMACKSELk
registers for level-based DMA handshaking.

Add rzv2h_icu_register_dma_ack() to configure ICU_DMACKSELk, routing
a DMAC channel's ACK signal to the specified peripheral.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: No changes

 drivers/irqchip/irq-renesas-rzv2h.c       | 40 +++++++++++++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h |  5 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 330c6ae87d71..ce0cf4c4074a 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -151,6 +151,12 @@ struct rzv2h_hw_info {
 #define ICU_DMAC_PREP_DMAREQ(sel, up)		(FIELD_PREP(ICU_DMAC_DkRQ_SEL_MASK, (sel)) \
 						 << ICU_DMAC_DMAREQ_SHIFT(up))
 
+/* DMAC ACK routing - 4 x 7-bit fields per 32-bit register, 8-bit spacing */
+#define ICU_DMAC_DACK_SEL_MASK			GENMASK(6, 0)
+#define ICU_DMAC_DACK_SHIFT(n)			((n) * 8)
+#define ICU_DMAC_DACK_FIELD_MASK(n)		(ICU_DMAC_DACK_SEL_MASK << ICU_DMAC_DACK_SHIFT(n))
+#define ICU_DMAC_PREP_DACK(val, n)		(((val) & ICU_DMAC_DACK_SEL_MASK) << ICU_DMAC_DACK_SHIFT(n))
+
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
  * @base:	Controller's base address
@@ -188,6 +194,40 @@ void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index,
 }
 EXPORT_SYMBOL_GPL(rzv2h_icu_register_dma_req);
 
+/**
+ * rzv2h_icu_register_dma_ack - Configure DMA ACK signal routing
+ * @icu_dev:      ICU platform device
+ * @dmac_index:   DMAC instance index (0-4)
+ * @dmac_channel: DMAC channel number (0-15), or RZV2H_ICU_DMAC_ACK_NO_DEFAULT
+ *                to disconnect routing for a given ack_no
+ * @ack_no:       Peripheral ACK number (0-88) per RZ/G3E manual Table 4.6-28,
+ *                used as index into ICU_DMACKSELk
+ *
+ * Routes the ACK signal of the peripheral identified by @ack_no to DMAC
+ * channel @dmac_channel of instance @dmac_index. When @dmac_channel is
+ * RZV2H_ICU_DMAC_ACK_NO_DEFAULT the field is reset, disconnecting any
+ * previously configured routing for that peripheral.
+ */
+void rzv2h_icu_register_dma_ack(struct platform_device *icu_dev, u8 dmac_index,
+				u8 dmac_channel, u16 ack_no)
+{
+	struct rzv2h_icu_priv *priv = platform_get_drvdata(icu_dev);
+	u8 reg_idx = ack_no / 4;
+	u8 field_idx = ack_no & 0x3;
+	u8 dmac_ack_src = (dmac_channel == RZV2H_ICU_DMAC_ACK_NO_DEFAULT) ?
+			  RZV2H_ICU_DMAC_ACK_NO_DEFAULT :
+			  (dmac_index * 16 + dmac_channel);
+	u32 val;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+
+	val = readl(priv->base + ICU_DMACKSELk(reg_idx));
+	val &= ~ICU_DMAC_DACK_FIELD_MASK(field_idx);
+	val |= ICU_DMAC_PREP_DACK(dmac_ack_src, field_idx);
+	writel(val, priv->base + ICU_DMACKSELk(reg_idx));
+}
+EXPORT_SYMBOL_GPL(rzv2h_icu_register_dma_ack);
+
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
 {
 	return data->domain->host_data;
diff --git a/include/linux/irqchip/irq-renesas-rzv2h.h b/include/linux/irqchip/irq-renesas-rzv2h.h
index 618a60d2eac0..4ffa898eaaf2 100644
--- a/include/linux/irqchip/irq-renesas-rzv2h.h
+++ b/include/linux/irqchip/irq-renesas-rzv2h.h
@@ -11,13 +11,18 @@
 #include <linux/platform_device.h>
 
 #define RZV2H_ICU_DMAC_REQ_NO_DEFAULT		0x3ff
+#define RZV2H_ICU_DMAC_ACK_NO_DEFAULT		0x7f
 
 #ifdef CONFIG_RENESAS_RZV2H_ICU
 void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index, u8 dmac_channel,
 				u16 req_no);
+void rzv2h_icu_register_dma_ack(struct platform_device *icu_dev, u8 dmac_index,
+				u8 dmac_channel, u16 ack_no);
 #else
 static inline void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index,
 					      u8 dmac_channel, u16 req_no) { }
+static inline void rzv2h_icu_register_dma_ack(struct platform_device *icu_dev, u8 dmac_index,
+					      u8 dmac_channel, u16 ack_no) { }
 #endif
 
 #endif /* __LINUX_IRQ_RENESAS_RZV2H */
-- 
2.25.1


