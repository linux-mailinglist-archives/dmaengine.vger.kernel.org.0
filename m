Return-Path: <dmaengine+bounces-4454-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7AA33244
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 23:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78DE1686D7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23E204C26;
	Wed, 12 Feb 2025 22:13:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1B261579;
	Wed, 12 Feb 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398419; cv=none; b=irIHU9Ik1MVcadquo5I53bvhKBFQAn88a1IBoPpKIVz7dQwhTTPIlXqna3us+4Vo/s1Q3maE4Og3+j14wlizKumuCl/tewkGSnRTZHkDJjC/3lbNkUtCwoF1+PeGezYCBeitwQiduQGXXaOw0xgxSGjNKuJ3/9u+qtvH7DRsmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398419; c=relaxed/simple;
	bh=bA/myihmd5etLQnT0hudcQ1HAKVQHuqnvOhZrB0pBx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1fHunWSZB3Do+sAkn1Hs5OxuE6nr7VGOtjoEyq9TXc4xiWLGkdWSa9uD6MeUA6jrmsdrGlCI77aXylT16noG6l0XxCYHOdHKp8ceR+BNh+fioibsmO0DoyT7Ch+3P/UsZtehuboaLHEKZD4oIpkS+bzxtaZIQbqUv85HguEg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 7Bc8cR0cRTWsyRBY5X2LsA==
X-CSE-MsgGUID: Zux17oMOTQmcO7XbLsY51Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Feb 2025 07:13:36 +0900
Received: from mulinux.example.org (unknown [10.226.93.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 00C4C40AACD7;
	Thu, 13 Feb 2025 07:13:32 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Date: Wed, 12 Feb 2025 22:13:04 +0000
Message-Id: <20250212221305.431716-7-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
References: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
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
v1->v2:
* Switched to new macros for minimum values.
---
 drivers/dma/sh/Kconfig   |   1 +
 drivers/dma/sh/rz-dmac.c | 164 +++++++++++++++++++++++++++++++++++----
 2 files changed, 150 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 6ea5a880b433..020cf941abc7 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -53,6 +53,7 @@ config RZ_DMAC
 	depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
+	select RENESAS_RZV2H_ICU
 	help
 	  This driver supports the general purpose DMA controller typically
 	  found in the Renesas RZ SoC variants.
diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d7a4ce28040b..24a8c6a337d5 100644
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
@@ -28,6 +29,11 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
+enum rz_dmac_type {
+	RZ_DMAC_RZG2L,
+	RZ_DMAC_RZV2H,
+};
+
 enum  rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
@@ -85,20 +91,32 @@ struct rz_dmac_chan {
 		struct rz_lmdesc *tail;
 		dma_addr_t base_dma;
 	} lmdesc;
+
+	/* RZ/V2H ICU related signals */
+	u16 req_no;
+	u8 ack_no;
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
 
+	enum rz_dmac_type type;
+
 	DECLARE_BITMAP(modules, 1024);
 };
 
@@ -167,6 +185,22 @@ struct rz_dmac {
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
+
 /*
  * -----------------------------------------------------------------------------
  * Device access
@@ -324,7 +358,15 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (dmac->type == RZ_DMAC_RZG2L) {
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
@@ -375,7 +417,15 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	channel->lmdesc.tail = lmdesc;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	if (dmac->type == RZ_DMAC_RZG2L) {
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
 
@@ -452,9 +502,15 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 
-	if (channel->mid_rid >= 0) {
-		clear_bit(channel->mid_rid, dmac->modules);
-		channel->mid_rid = -EINVAL;
+	if (dmac->type == RZ_DMAC_RZG2L) {
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
@@ -647,7 +703,15 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (dmac->type == RZ_DMAC_RZG2L) {
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
@@ -727,13 +791,30 @@ static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	struct of_phandle_args *dma_spec = arg;
 	u32 ch_cfg;
+	u16 req_no;
+
+	if (dmac->type == RZ_DMAC_RZG2L) {
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
@@ -769,6 +850,8 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
+	channel->req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
+	channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
 
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
@@ -824,6 +907,40 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return 0;
 }
 
+static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
+{
+	struct device_node *icu_np, *np = dev->of_node;
+	struct of_phandle_args args;
+	uint32_t dmac_index;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
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
@@ -859,6 +976,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 
 	dmac->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
+	dmac->type = (enum rz_dmac_type)of_device_get_match_data(dmac->dev);
 
 	ret = rz_dmac_parse_of(&pdev->dev, dmac);
 	if (ret < 0)
@@ -874,9 +992,15 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(dmac->ext_base))
-		return PTR_ERR(dmac->ext_base);
+	if (dmac->type == RZ_DMAC_RZG2L) {
+		dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(dmac->ext_base))
+			return PTR_ERR(dmac->ext_base);
+	} else {
+		ret = rz_dmac_parse_of_icu(&pdev->dev, dmac);
+		if (ret)
+			return ret;
+	}
 
 	/* Register interrupt handler for error */
 	irq = platform_get_irq_byname(pdev, irqname);
@@ -991,10 +1115,20 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	if (dmac->type == RZ_DMAC_RZV2H)
+		platform_device_put(dmac->icu.pdev);
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {
-	{ .compatible = "renesas,rz-dmac", },
+	{
+		.compatible	= "renesas,r9a09g057-dmac",
+		.data		= (void *) RZ_DMAC_RZV2H
+	},
+	{
+		.compatible	= "renesas,rz-dmac",
+		.data		= (void *) RZ_DMAC_RZG2L
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
-- 
2.34.1


