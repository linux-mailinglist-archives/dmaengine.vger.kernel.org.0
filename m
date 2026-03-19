Return-Path: <dmaengine+bounces-9527-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMMjNGkfvGnQswIAu9opvQ
	(envelope-from <dmaengine+bounces-9527-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:08:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE702CE647
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63CA330D73BE
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEB3E92B3;
	Thu, 19 Mar 2026 15:55:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0B3E3165;
	Thu, 19 Mar 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935734; cv=none; b=oz87tAfLu7RxgDsCoMz3Yuz+fwueeq2bYNboS90ILhOPeEIOzyisMZ+57xRiGkBDiZGusY/iypv22PYlC/ml6/Mxsfwnwhy/OMqylIe37GSpwaIVFqNbyLiyc2PKpcFUVQ1uHZHJdAwrh2fAQGD0u4wqqHazyFlNYZTpdJ85MTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935734; c=relaxed/simple;
	bh=D1SxVx/NovE4mVqL7CRPWG12P1m0PWzlzknGr5qNHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwS3pAiqNn74kkTTEFWF96/r+4ope7Yj+yNfYtCSA4VEpXDZ+VCNpZBlkDSyK9AbBFTi9mEJhDk9P2Fyk7ioFb2yePu7XDczXwFNat2q2rNLY4k63okQRn/hz+zXpjI5Y2wJm+QZVTKxo1XcDEddATEq6LNmtr291C8RdYc858E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: qTtFXDT6SN6Efg7qGNScTQ==
X-CSE-MsgGUID: gS+yZpz/TEmdxvkqMknL3g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2026 00:55:31 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8CB44401B2FD;
	Fri, 20 Mar 2026 00:55:23 +0900 (JST)
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
Subject: [PATCH 05/22] irqchip/renesas-rzv2h: Add DMA ACK signal routing support
Date: Thu, 19 Mar 2026 16:53:17 +0100
Message-ID: <20260319155334.51278-6-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9527-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.655];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8AE702CE647
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals (mainly from audio module) found on RZ/G3E SoCs
require explicit ACK signal routing through the ICU via the ICU_DMACKSELk
registers.

Add rzv2h_icu_register_dma_ack() to configure this routing.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c       | 36 +++++++++++++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h |  5 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index ce790590f7ca..4d10b19f7e09 100644
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
@@ -188,6 +194,36 @@ void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_index,
 }
 EXPORT_SYMBOL_GPL(rzv2h_icu_register_dma_req);
 
+/**
+ * rzv2h_icu_register_dma_ack - Configure DMA ACK signal routing
+ * @icu_dev: ICU platform device
+ * @dmac_index: DMAC instance index (0-4)
+ * @dmac_channel: DMAC channel number (0-15), or RZV2H_ICU_DMAC_ACK_NO_DEFAULT to clear
+ * @ack_no: Peripheral ACK number (0-88), used as index into ICU_DMACKSELk
+ *
+ * Routes the DMAC channel's ACK signal to the peripheral specified by ack_no,
+ * or clears the entry when dmac_channel is RZV2H_ICU_DMAC_ACK_NO_DEFAULT.
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


