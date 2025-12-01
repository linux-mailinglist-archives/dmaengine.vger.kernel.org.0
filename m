Return-Path: <dmaengine+bounces-7417-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4DDC971C2
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 12:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A8E3A1BFC
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1D2EC542;
	Mon,  1 Dec 2025 11:50:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17792EC09F;
	Mon,  1 Dec 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589814; cv=none; b=YP+EVYI6yCtccKP9H5hy8PeGxHm67cRrwgAPs2zk8rfH5VLFPWt+8fVl8cTV9gdFH2shHifVo/yKCftTCVDwukPTlsu0pZ6Z7b2X8WV7yZSaAFwcPQzIuqwZR5WKuMMOOxpmuOw/jR/FmiGzMsWepP9cehQN7iRvr5oKOEWD6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589814; c=relaxed/simple;
	bh=If5hnNNIs45TLrR10ZXCO1ZIeXFqBLjVtJ6yi6O56wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfjlSRnAtAcMuG5ba6YrsLX5U6IUjb31r7MxggyCUuXpxEXSzMd2hCGuh4lRdd+x/fjO49176x3qELeJ4KrL9pe7FeT8xBU/MyK5hLnnLENxJN1FaHPT0cQ3d13+a5Hl6LdHx07Vk2JF5vcLeJRV2kYaL+rrfTZALH/E4kCVzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: c1vkYOkZRo+8/B1F0TfJ8Q==
X-CSE-MsgGUID: QMTyaJEKTWO0yweQLAx3Rg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 20:50:11 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B31D241F9E1E;
	Mon,  1 Dec 2025 20:50:06 +0900 (JST)
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
Subject: [PATCH 2/6] dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
Date: Mon,  1 Dec 2025 13:49:06 +0200
Message-ID: <20251201114910.515178-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
RZV2H_ICU_DMAC_REQ_NO_DEFAULT.

While at it, factor out the logic that calls .register_dma_req() or
rz_dmac_set_dmars_register() into a separate function to remove some
code duplication. Since the default values are different between the
two, use -1 for designating that the default value should be used.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * add .dma_req_no_default field to the struct rz_dmac_info (to be able
   to use the different define for RZ/T2H ICU)
 * commonize rzv2h_icu_register_dma_req()/rz_dmac_set_dmars_register()
   calls into a separate function, rz_dmac_set_dma_req_no()

 drivers/dma/sh/rz-dmac.c | 68 +++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 20a5c1766a58..f94be3f8e232 100644
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
 
@@ -319,6 +324,19 @@ static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
 	rz_dmac_ext_writel(dmac, dmars32, dmars_offset);
 }
 
+static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int index,
+				   int req_no)
+{
+	if (req_no < 0)
+		req_no = dmac->info->dma_req_no_default;
+
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
@@ -336,13 +354,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	lmdesc->chext = 0;
 	lmdesc->header = HEADER_LV;
 
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index,
-					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, -1);
 
 	channel->chcfg = chcfg;
 	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
@@ -393,12 +405,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
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
@@ -671,13 +678,7 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
 
-	if (dmac->has_icu) {
-		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
-					   channel->index,
-					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
-	} else {
-		rz_dmac_set_dmars_register(dmac, channel->index, 0);
-	}
+	rz_dmac_set_dma_req_no(dmac, channel->index, -1);
 }
 
 /*
@@ -868,14 +869,13 @@ static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
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
@@ -930,6 +930,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (!dmac)
 		return -ENOMEM;
 
+	dmac->info = device_get_match_data(&pdev->dev);
 	dmac->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
 
@@ -947,7 +948,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	if (!dmac->has_icu) {
+	if (!dmac->info->register_dma_req) {
 		dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(dmac->ext_base))
 			return PTR_ERR(dmac->ext_base);
@@ -1067,9 +1068,18 @@ static void rz_dmac_remove(struct platform_device *pdev)
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

