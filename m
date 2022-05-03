Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B660F5182A7
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 12:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiECK5N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiECK5L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 06:57:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1061733890;
        Tue,  3 May 2022 03:53:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5428E1F43E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575214;
        bh=/Jtsc9+lw7Coi+SAJWUPtQ7xwVJi5H5h91tGI9sgeIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+sKuHiX7lZEmpgw6/TvHRQfOES1pBdv/6MyMYsKaLuUHrtWbGUBb6QstfsUyUDlO
         EGBgNIRr5UnP8ORrVLc6K1A4busUTbJ02NTFmNokJAL49nmaaoxkVNrP0iu/YPCBW7
         nPat1SfmbRohEeffegyFczus+tGAVbnQG5bMJtD2brNRNpQ1p3V4RFxtsIoSDx+R5p
         Xvm4zufj9gCUinkGfGiBmXVrscHMNZtQQni9nX7Qz9zApyC7tGIeGEe2/cb8xSV1Vf
         ZaAauB59XaulaKMVwfOAEBS3jPSqX0NneQ5CkgxDgv6GdxlrpRXXSnrNcqOHy7axW1
         6OVjPekA8RJew==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] dmaengine: mediatek-cqdma: Add SoC-specific match data
Date:   Tue,  3 May 2022 12:53:27 +0200
Message-Id: <20220503105328.54755-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503105328.54755-1-angelogioacchino.delregno@collabora.com>
References: <20220503105328.54755-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On some SoCs the DST2 and SRC2 registers may be at a different offset:
add a match data structure and assign it to mt6765 as a preparation
for adding support for more SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 34 +++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index f8847c48ba03..7d8c54da3d58 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -48,8 +48,6 @@
 #define MTK_CQDMA_DST			0x20
 #define MTK_CQDMA_LEN1			0x24
 #define MTK_CQDMA_LEN2			0x28
-#define MTK_CQDMA_SRC2			0x60
-#define MTK_CQDMA_DST2			0x64
 
 /* Registers setting */
 #define MTK_CQDMA_EN_BIT		BIT(0)
@@ -126,9 +124,20 @@ struct mtk_cqdma_vchan {
 	bool issue_synchronize;
 };
 
+/**
+ * struct mtk_cqdma_plat_data - SoC specific parameters
+ * @reg_dst2:               dst2 register offset
+ * @reg_src2:               src2 register offset
+ */
+struct mtk_cqdma_plat_data {
+	u8 reg_src2;
+	u8 reg_dst2;
+};
+
 /**
  * struct mtk_cqdma_device - The struct holding info describing CQDMA
  *                          device
+ * @plat:                   SoC-specific platform data
  * @ddev:                   An instance for struct dma_device
  * @clk:                    The clock that device internal is using
  * @dma_requests:           The number of VCs the device supports to
@@ -231,6 +240,8 @@ static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
 static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
 			    struct mtk_cqdma_vdesc *cvd)
 {
+	struct mtk_cqdma_device *cqdma = to_cqma_dev(cvd->ch);
+
 	/* wait for the previous transaction done */
 	if (mtk_cqdma_poll_engine_done(pc, true) < 0)
 		dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma wait transaction timeout\n");
@@ -243,17 +254,17 @@ static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
 	/* setup the source */
 	mtk_dma_set(pc, MTK_CQDMA_SRC, cvd->src & MTK_CQDMA_ADDR_LIMIT);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	mtk_dma_set(pc, MTK_CQDMA_SRC2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
+	mtk_dma_set(pc, cqdma->plat->reg_src2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
 #else
-	mtk_dma_set(pc, MTK_CQDMA_SRC2, 0);
+	mtk_dma_set(pc, cqdma->plat->reg_src2, 0);
 #endif
 
 	/* setup the destination */
 	mtk_dma_set(pc, MTK_CQDMA_DST, cvd->dest & MTK_CQDMA_ADDR_LIMIT);
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	mtk_dma_set(pc, MTK_CQDMA_DST2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
+	mtk_dma_set(pc, cqdma->plat->reg_dst2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
 #else
-	mtk_dma_set(pc, MTK_CQDMA_DST2, 0);
+	mtk_dma_set(pc, cqdma->plat->reg_dst2, 0);
 #endif
 
 	/* setup the length */
@@ -740,8 +751,13 @@ static void mtk_cqdma_hw_deinit(struct mtk_cqdma_device *cqdma)
 	pm_runtime_disable(cqdma2dev(cqdma));
 }
 
+static const struct mtk_cqdma_plat_data cqdma_mt6765 {
+	.reg_dst2 = 0x64,
+	.reg_src2 = 0x60,
+};
+
 static const struct of_device_id mtk_cqdma_match[] = {
-	{ .compatible = "mediatek,mt6765-cqdma" },
+	{ .compatible = "mediatek,mt6765-cqdma", .data = &cqdma_mt6765 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
@@ -758,6 +774,10 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 	if (!cqdma)
 		return -ENOMEM;
 
+	cqdma->plat = device_get_match_data(&pdev->dev);
+	if (cqdma->plat)
+		return -EINVAL;
+
 	dd = &cqdma->ddev;
 
 	cqdma->clk = devm_clk_get(&pdev->dev, "cqdma");
-- 
2.35.1

