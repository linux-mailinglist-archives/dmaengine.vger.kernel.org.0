Return-Path: <dmaengine+bounces-9870-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAteJJ6YzmkBowYAu9opvQ
	(envelope-from <dmaengine+bounces-9870-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 18:26:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4738BD29
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C0A33031B17
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360138837A;
	Thu,  2 Apr 2026 16:22:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F52C11DB;
	Thu,  2 Apr 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146975; cv=none; b=tJxIyxLErsrAp1ghrhmC444WhvUJv2/EWQYnAjYP0m06z2bIGeHJsKmsolL48dpaNWAKJX3fo1ibc35cQxnRL+mbl6g8Um7BXfGicbraikaYWQ8J6MJiKyxDt8syiZPJzRzoGgpwNDyqk/4g5pjEvt8TXIeo2OtPbkCvgGcMNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146975; c=relaxed/simple;
	bh=fuMpN0JW72wMxON1aUIARt1YEnKSGGjNsKVOXeJ55jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/v8JsRqOd6G5OJ5D+lvSK8LhcIio/yWsLqPIG197w+IV0q3Rgh9ZpSAmClwRWygC3u/pmMOotqeXYo56pX3jE52HykIKx4EK8XqgY/3+csEvqeGm/q6/B6xMOKhK5yp3Bqk09Zs4GT7iXDTE6RGYKBm01lPIu10BOvEu3IFZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: sBxco8AlTmGtJEkf3ms54Q==
X-CSE-MsgGUID: ocyFkCBIS9S3H2j/1OwYYw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Apr 2026 01:22:53 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 27B344017C4C;
	Fri,  3 Apr 2026 01:22:48 +0900 (JST)
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
Subject: [PATCh v3 1/2] irqchip/renesas-rzv2h: Add DMA ACK signal routing support
Date: Thu,  2 Apr 2026 18:22:11 +0200
Message-ID: <20260402162212.12016-2-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9870-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[tuxon.dev,bp.renesas.com,renesas.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 44E4738BD29
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

v3: No changes
v2: No changes

 drivers/irqchip/irq-renesas-rzv2h.c       | 40 +++++++++++++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h |  5 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 31f191641ff8..4ebcb91c0b6c 100644
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


