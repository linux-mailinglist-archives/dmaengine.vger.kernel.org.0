Return-Path: <dmaengine+bounces-7514-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E82CA82B8
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55752323F9AD
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8734677B;
	Fri,  5 Dec 2025 15:14:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9B33DEC4;
	Fri,  5 Dec 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947654; cv=none; b=N926WPB1RQZg/yGRhlQjTh5TMQLxFjf0Q1Kkv+jVl3K7UzYep+eJsost6ZgY7JbovPT2qvcRWo7EFQJ/IHXEBKsk77lfuekUWddD4bzeNp0LXrT7HMvD41do73Ja3reLXpLI284KT6F/cuLd6ty+VNpqQdmTTl+kgefcrkQXEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947654; c=relaxed/simple;
	bh=Cz20XkiM+P8nczxVeOAeZHCzIkyeCTB3xpUqIz6Tg/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCTsOyGt3LwGE4UVAKx5QfA8PIu9tPiJB7h5gjyZ16ApUfcFyCsUgPpwnQGAHRPHM5pBzMp3MvIRH7Ej2zZob1GHg/fyuPOQK1nbA+lulzubAuJeIsiX/cSrf7lSSxXjfZY7MR79nlWoZujUc8wkYxNUL6jo250RXCBaildyN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: byJsjLt4SP6ypJgqnYA/mw==
X-CSE-MsgGUID: QxDbWAbwSimkeun2Jkv2ZQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2025 00:13:59 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.202])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF5224005E29;
	Sat,  6 Dec 2025 00:13:54 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 2/6] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
Date: Fri,  5 Dec 2025 17:12:50 +0200
Message-ID: <20251205151254.2970669-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
completely different ICU unit compared to RZ/V2H, which requires a
separate implementation.

To prepare for adding support for these SoCs, add a chip-specific
structure and put a pointer to the rzv2h_icu_register_dma_req() function
in the .register_dma_req field of the chip-specific structure to allow
for other implementations. Do the same for the default request value,
RZV2H_ICU_DMAC_REQ_NO_DEFAULT, and place it into .dma_req_no_default.

While at it, factor out the logic that calls .register_dma_req() or
rz_dmac_set_dmars_register() into a separate function to remove some
code duplication.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * replace -1 with direct usage of dma_req_no_default and remove the
   check inside rz_dmac_set_dma_req_no()

V2:
 * remove notes

 drivers/dma/sh/rz-dmac.c | 65 ++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 20a5c1766a58..e4b369f13cbc 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -95,9 +95,16 @@ struct rz_dmac_icu {
 	u8 dmac_index;
 };
 
+struct rz_dmac_info {
+	void (*register_dma_req)(struct platform_device *icu_dev, u8 dmac_index,
+				 u8 dmac_channel, u16 req_no);
+	u16 dma_req_no_default;
+};
+
 struct rz_dmac {
 	struct dma_device engine;
 	struct rz_dmac_icu icu;
+	const struct rz_dmac_info *info;
 	struct device *dev;
 	struct reset_control *rstc;
 	void __iomem *base;
@@ -106,8 +113,6 @@ struct rz_dmac {
 	unsigned int n_channels;
 	struct rz_dmac_chan *channels;
 
-	bool has_icu;
-
 	DECLARE_BITMAP(modules, 1024);
 };
 
@@ -319,6 +324,16 @@ static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
 	rz_dmac_ext_writel(dmac, dmars32, dmars_offset);
 }
 
+static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int index,
+				   int req_no)
+{
+	if (dmac->info->register_dma_req)
+		dmac->info->register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
+					     index, req_no);
+	else
+		rz_dmac_set_dmars_register(dmac, index, req_no);
+}
+
 static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -336,13 +351,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index,
-					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->dma_req_no_default);
 
 	channel->chcfg = chcfg;
 	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
@@ -393,12 +402,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	channel->lmdesc.tail = lmdesc;
 
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index, channel->mid_rid);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
 
 	channel->chctrl = CHCTRL_SETEN;
 }
@@ -671,13 +675,7 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index,
-					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->dma_req_no_default);
 }
 
 /*
@@ -868,14 +866,13 @@ static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 	uint32_t dmac_index;
 	int ret;
 
-	ret = of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
-	if (ret == -ENOENT)
+	if (!dmac->info->register_dma_req)
 		return 0;
+
+	ret = of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args);
 	if (ret)
 		return ret;
 
-	dmac->has_icu = true;
-
 	dmac->icu.pdev = of_find_device_by_node(args.np);
 	of_node_put(args.np);
 	if (!dmac->icu.pdev) {
@@ -930,6 +927,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (!dmac)
 		return -ENOMEM;
 
+	dmac->info = device_get_match_data(&pdev->dev);
 	dmac->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
 
@@ -947,7 +945,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	if (!dmac->has_icu) {
+	if (!dmac->info->register_dma_req) {
 		dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(dmac->ext_base))
 			return PTR_ERR(dmac->ext_base);
@@ -1067,9 +1065,18 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static const struct rz_dmac_info rz_dmac_v2h_info = {
+	.register_dma_req = rzv2h_icu_register_dma_req,
+	.dma_req_no_default = RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
+};
+
+static const struct rz_dmac_info rz_dmac_common_info = {
+	.dma_req_no_default = 0,
+};
+
 static const struct of_device_id of_rz_dmac_match[] = {
-	{ .compatible = "renesas,r9a09g057-dmac", },
-	{ .compatible = "renesas,rz-dmac", },
+	{ .compatible = "renesas,r9a09g057-dmac", .data = &rz_dmac_v2h_info },
+	{ .compatible = "renesas,rz-dmac", .data = &rz_dmac_common_info },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
-- 
2.52.0

