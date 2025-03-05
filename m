Return-Path: <dmaengine+bounces-4648-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B419A4F272
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 01:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EAA3AB764
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717652629F;
	Wed,  5 Mar 2025 00:21:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3611E521;
	Wed,  5 Mar 2025 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134116; cv=none; b=hQg/s7/3SA81YsyY4aIbISX6sQO/EMUjmGjHmB2eDsgDvf4tt689OzUu/6HBbkpt/GEwrPvjjQ4CcBL31FMb4Cmu9L8SZz9HhksMChKY6ittwes920umc7D4TJqKZQ5FG6XW5AVjmAdJNCrIHnVuo3NLGolE+mNDktaJpc+2Xyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134116; c=relaxed/simple;
	bh=kgDBEw7j9SvJ8VpIyO+OgTZnD+6Tpqz2ywQCjuQ7k0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=me7HthxMx/cc/OukbIymbBSB/i1NL7CPpHZ57gLYP2shr+7CVMz0beDBQ/rS2fuNSoqWVUvpK0GYzPsCn2qFHRgMP47pQn20PX1AE76hszFlAJz9GRWwAeCV7GUOqHcyxRl0rFZQkZaY/jg1ngDyKFCMPPWjwcH/eJwX29GqLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 1iaMKynURxCUYpMiGVajpQ==
X-CSE-MsgGUID: WkrqKR1NTLmnKxKFieDtFA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Mar 2025 09:21:45 +0900
Received: from mulinux.home (unknown [10.226.92.17])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6B0F6404D874;
	Wed,  5 Mar 2025 09:21:42 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Date: Wed,  5 Mar 2025 00:21:11 +0000
Message-Id: <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
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
* Instead of using MID/IRD it uses REQ No
* It is connected to the Interrupt Control Unit (ICU)
* On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5

Add specific support for the Renesas RZ/V2H(P) family of SoC by
tackling the aforementioned differences.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v4->v5:
* Reused RZ/G2L cell specification (with REQ No in place of MID/RID).
* Dropped ACK No.
* Removed mid_rid/req_no/ack_no union and reused mid_rid for REQ No.
* Other small improvements.
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
 drivers/dma/sh/rz-dmac.c | 81 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d7a4ce28040b..1f687b08d6b8 100644
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
@@ -89,8 +90,14 @@ struct rz_dmac_chan {
 
 #define to_rz_dmac_chan(c)	container_of(c, struct rz_dmac_chan, vc.chan)
 
+struct rz_dmac_icu {
+	struct platform_device *pdev;
+	u8 dmac_index;
+};
+
 struct rz_dmac {
 	struct dma_device engine;
+	struct rz_dmac_icu icu;
 	struct device *dev;
 	struct reset_control *rstc;
 	void __iomem *base;
@@ -99,6 +106,8 @@ struct rz_dmac {
 	unsigned int n_channels;
 	struct rz_dmac_chan *channels;
 
+	bool has_icu;
+
 	DECLARE_BITMAP(modules, 1024);
 };
 
@@ -167,6 +176,9 @@ struct rz_dmac {
 #define RZ_DMAC_MAX_CHANNELS		16
 #define DMAC_NR_LMDESC			64
 
+/* RZ/V2H ICU related */
+#define RZV2H_MAX_DMAC_INDEX		4
+
 /*
  * -----------------------------------------------------------------------------
  * Device access
@@ -324,7 +336,13 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (dmac->has_icu) {
+		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					   channel->index,
+					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
+	} else {
+		rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	}
 
 	channel->chcfg = chcfg;
 	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
@@ -375,7 +393,13 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	channel->lmdesc.tail = lmdesc;
 
-	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	if (dmac->has_icu) {
+		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					   channel->index, channel->mid_rid);
+	} else {
+		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+	}
+
 	channel->chctrl = CHCTRL_SETEN;
 }
 
@@ -647,7 +671,13 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	if (dmac->has_icu) {
+		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					   channel->index,
+					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
+	} else {
+		rz_dmac_set_dmars_register(dmac, channel->index, 0);
+	}
 }
 
 /*
@@ -824,6 +854,38 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return 0;
 }
 
+static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
+{
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	uint32_t dmac_index;
+	int ret;
+
+	ret = of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
+	if (ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+
+	dmac->has_icu = true;
+
+	dmac->icu.pdev = of_find_device_by_node(args.np);
+	of_node_put(args.np);
+	if (!dmac->icu.pdev) {
+		dev_err(dev, "ICU device not found.\n");
+		return -ENODEV;
+	}
+
+	dmac_index = args.args[0];
+	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
+		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
+		return -EINVAL;
+	}
+	dmac->icu.dmac_index = dmac_index;
+
+	return 0;
+}
+
 static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -840,7 +902,7 @@ static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
 		return -EINVAL;
 	}
 
-	return 0;
+	return rz_dmac_parse_of_icu(dev, dmac);
 }
 
 static int rz_dmac_probe(struct platform_device *pdev)
@@ -874,9 +936,11 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
@@ -991,9 +1055,12 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	platform_device_put(dmac->icu.pdev);
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {
+	{ .compatible = "renesas,r9a09g057-dmac", },
 	{ .compatible = "renesas,rz-dmac", },
 	{ /* Sentinel */ }
 };
-- 
2.34.1


