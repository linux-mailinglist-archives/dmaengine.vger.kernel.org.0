Return-Path: <dmaengine+bounces-4553-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1881A3DDB1
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 16:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20C71704B3
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF931FC0E4;
	Thu, 20 Feb 2025 15:01:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC011FBEB0;
	Thu, 20 Feb 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063705; cv=none; b=JlILxJPP1EFhk+AWDcyUMNI45Y0HA2XwwKeaDVvufmXzZ2AH082kgEYS0F57MNuIXNeVB/UEFbRf0j7fPk+VgsiwVoMTbdA1jPnwDPy8BBwcdyNoN7qCbW8k2XgRyInTy6S2voO6N464t6vQ5NeW5yLsiPwLEw0Exv7HJafDtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063705; c=relaxed/simple;
	bh=9t8FKBTkuqheAPQov8euo88WraDwEw6t0jucZGpSWQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrgSs1AqwGtDT4m8vYs9ai8ZEQ2DJN8KWMXwkXDMewPhkNBRdDK4owlSa072Y4hpwdeuky/fWkBAskyQo/Zv4UYtuOkJxD1LYx9zl9eHNWdCNZI0xwYhi8aZtQ171K0OCgl/k7MO3PhBFPwZPn9SQlK8jQ2HRb4Yo1OqgkVlmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: sW9Zhu78RSKAED+NOubvGg==
X-CSE-MsgGUID: wHr4YVruSd2LhGJ2L0Hgfw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Feb 2025 00:01:41 +0900
Received: from mulinux.example.org (unknown [10.226.92.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 22E8D42C830B;
	Fri, 21 Feb 2025 00:01:37 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Date: Thu, 20 Feb 2025 15:01:09 +0000
Message-Id: <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
similar to the version found on the Renesas RZ/G2L family of
SoCs, but there are some differences:
* It only uses one register area
* It only uses one clock
* It only uses one reset
* Instead of using MID/IRD it uses REQ NO/ACK NO
* It is connected to the Interrupt Control Unit (ICU)
* On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5

Add specific support for the Renesas RZ/V2H(P) family of SoC by
tackling the aforementioned differences.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v3->v4:
* Fixed an issue with mid_rid/req_no/ack_no initialization
v2->v3:
* Dropped change to Kconfig.
* Replaced rz_dmac_type with has_icu flag.
* Put req_no and ack_no in an anonymous struct, nested under an
  anonymous union with mid_rid.
* Dropped data field of_rz_dmac_match[], and added logic to determine
  value of has_icu flag from DT parsing.
v1->v2:
* Switched to new macros for minimum values.
---
 drivers/dma/sh/rz-dmac.c | 162 +++++++++++++++++++++++++++++++++++----
 1 file changed, 146 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d7a4ce28040b..57a1fdeed734 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -14,6 +14,7 @@
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -73,7 +74,6 @@ struct rz_dmac_chan {
 
 	u32 chcfg;
 	u32 chctrl;
-	int mid_rid;
 
 	struct list_head ld_free;
 	struct list_head ld_queue;
@@ -85,20 +85,36 @@ struct rz_dmac_chan {
 		struct rz_lmdesc *tail;
 		dma_addr_t base_dma;
 	} lmdesc;
+
+	union {
+		int mid_rid;
+		struct {
+			u16 req_no;
+			u8 ack_no;
+		};
+	};
 };
 
 #define to_rz_dmac_chan(c)	container_of(c, struct rz_dmac_chan, vc.chan)
 
+struct rz_dmac_icu {
+	struct platform_device *pdev;
+	u8 dmac_index;
+};
+
 struct rz_dmac {
 	struct dma_device engine;
 	struct device *dev;
 	struct reset_control *rstc;
+	struct rz_dmac_icu icu;
 	void __iomem *base;
 	void __iomem *ext_base;
 
 	unsigned int n_channels;
 	struct rz_dmac_chan *channels;
 
+	bool has_icu;
+
 	DECLARE_BITMAP(modules, 1024);
 };
 
@@ -167,6 +183,23 @@ struct rz_dmac {
 #define RZ_DMAC_MAX_CHANNELS		16
 #define DMAC_NR_LMDESC			64
 
+/* RZ/V2H ICU related */
+#define RZV2H_REQ_NO_MASK		GENMASK(9, 0)
+#define RZV2H_ACK_NO_MASK		GENMASK(16, 10)
+#define RZV2H_HIEN_MASK			BIT(17)
+#define RZV2H_LVL_MASK			BIT(18)
+#define RZV2H_AM_MASK			GENMASK(21, 19)
+#define RZV2H_TM_MASK			BIT(22)
+#define RZV2H_EXTRACT_REQ_NO(x)		FIELD_GET(RZV2H_REQ_NO_MASK, (x))
+#define RZV2H_EXTRACT_ACK_NO(x)		FIELD_GET(RZV2H_ACK_NO_MASK, (x))
+#define RZVH2_EXTRACT_CHCFG(x)		((FIELD_GET(RZV2H_HIEN_MASK, (x)) << 5) | \
+					 (FIELD_GET(RZV2H_LVL_MASK, (x))  << 6) | \
+					 (FIELD_GET(RZV2H_AM_MASK, (x))   << 8) | \
+					 (FIELD_GET(RZV2H_TM_MASK, (x))   << 22))
+
+#define RZV2H_MAX_DMAC_INDEX		4
+#define RZV2H_ICU_PROPERTY		"renesas,icu"
+
 /*
  * -----------------------------------------------------------------------------
  * Device access
@@ -324,7 +357,15 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (!dmac->has_icu) {
+		rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	} else {
+		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
+					       dmac->icu.dmac_index,
+					       channel->index,
+					       RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
+					       RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
+	}
 
 	channel->chcfg = chcfg;
 	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
@@ -375,7 +416,15 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	channel->lmdesc.tail = lmdesc;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	if (!dmac->has_icu) {
+		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	} else {
+		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
+					       dmac->icu.dmac_index,
+					       channel->index, channel->req_no,
+					       channel->ack_no);
+	}
+
 	channel->chctrl = CHCTRL_SETEN;
 }
 
@@ -452,9 +501,15 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 
-	if (channel->mid_rid >= 0) {
-		clear_bit(channel->mid_rid, dmac->modules);
-		channel->mid_rid = -EINVAL;
+	if (!dmac->has_icu) {
+		if (channel->mid_rid >= 0) {
+			clear_bit(channel->mid_rid, dmac->modules);
+			channel->mid_rid = -EINVAL;
+		}
+	} else {
+		clear_bit(channel->req_no, dmac->modules);
+		channel->req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
+		channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
 	}
 
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
@@ -647,7 +702,15 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (!dmac->has_icu) {
+		rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	} else {
+		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
+					       dmac->icu.dmac_index,
+					       channel->index,
+					       RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
+					       RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
+	}
 }
 
 /*
@@ -727,13 +790,30 @@ static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	struct of_phandle_args *dma_spec = arg;
 	u32 ch_cfg;
+	u16 req_no;
+
+	if (!dmac->has_icu) {
+		channel->mid_rid = dma_spec->args[0] & MID_RID_MASK;
+		ch_cfg = (dma_spec->args[0] & CHCFG_MASK) >> 10;
+		channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
+				 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
+
+		return !test_and_set_bit(channel->mid_rid, dmac->modules);
+	}
+
+	req_no = RZV2H_EXTRACT_REQ_NO(dma_spec->args[0]);
+	if (req_no >= RZV2H_ICU_DMAC_REQ_NO_MIN_FIX_OUTPUT)
+		return false;
+
+	channel->req_no = req_no;
+
+	channel->ack_no = RZV2H_EXTRACT_ACK_NO(dma_spec->args[0]);
+	if (channel->ack_no >= RZV2H_ICU_DMAC_ACK_NO_MIN_FIX_OUTPUT)
+		channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
 
-	channel->mid_rid = dma_spec->args[0] & MID_RID_MASK;
-	ch_cfg = (dma_spec->args[0] & CHCFG_MASK) >> 10;
-	channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
-			 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
+	channel->chcfg = RZVH2_EXTRACT_CHCFG(dma_spec->args[0]);
 
-	return !test_and_set_bit(channel->mid_rid, dmac->modules);
+	return !test_and_set_bit(channel->req_no, dmac->modules);
 }
 
 static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
@@ -768,7 +848,12 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	int ret;
 
 	channel->index = index;
-	channel->mid_rid = -EINVAL;
+	if (!dmac->has_icu) {
+		channel->mid_rid = -EINVAL;
+	} else {
+		channel->req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
+		channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
+	}
 
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
@@ -824,6 +909,41 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return 0;
 }
 
+static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
+{
+	struct device_node *icu_np, *np = dev->of_node;
+	struct of_phandle_args args;
+	uint32_t dmac_index;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(np, RZV2H_ICU_PROPERTY, 1, 0, &args);
+	if (ret)
+		return ret;
+
+	icu_np = args.np;
+	dmac_index = args.args[0];
+
+	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
+		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
+		ret = -EINVAL;
+		goto free_icu_np;
+	}
+
+	dmac->icu.pdev = of_find_device_by_node(icu_np);
+	if (!dmac->icu.pdev) {
+		dev_err(dev, "ICU device not found.\n");
+		ret = -ENODEV;
+		goto free_icu_np;
+	}
+
+	dmac->icu.dmac_index = dmac_index;
+
+free_icu_np:
+	of_node_put(icu_np);
+
+	return ret;
+}
+
 static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -840,6 +960,10 @@ static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 		return -EINVAL;
 	}
 
+	dmac->has_icu = of_property_present(np, RZV2H_ICU_PROPERTY);
+	if (dmac->has_icu)
+		return rz_dmac_parse_of_icu(dev, dmac);
+
 	return 0;
 }
 
@@ -874,9 +998,11 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(dmac->ext_base))
-		return PTR_ERR(dmac->ext_base);
+	if (!dmac->has_icu) {
+		dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(dmac->ext_base))
+			return PTR_ERR(dmac->ext_base);
+	}
 
 	/* Register interrupt handler for error */
 	irq = platform_get_irq_byname(pdev, irqname);
@@ -991,9 +1117,13 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	if (dmac->has_icu)
+		platform_device_put(dmac->icu.pdev);
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {
+	{ .compatible = "renesas,r9a09g057-dmac", },
 	{ .compatible = "renesas,rz-dmac", },
 	{ /* Sentinel */ }
 };
-- 
2.34.1


