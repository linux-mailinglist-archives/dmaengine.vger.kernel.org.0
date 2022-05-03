Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991015182A2
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiECK5N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiECK5L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 06:57:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF143389C;
        Tue,  3 May 2022 03:53:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1327C1F43E31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575215;
        bh=DOmjN0rIyrLrzlWHjHQiavdG+fuRwNEWPLPHorvQTtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDMc302w1OAhW9kbsJulrPFYSr/a9+Z4wAAI2QGfXGNs/J3TySQw600gYSv1f2Htm
         1R+lPVPTRaT5jv5DuHOBuRMerlYcvry+DumksFA1MwxKwpWDpTvCYi173ITFPbMYAI
         7b2XRialKZwUxFg2gLhtWHhgu9Ne32TRy6q80cjTtOrqtvdyln++76+W2YVnJ4Msrf
         6BnA8ImlAhDZpHrx4phkmpkr46U3pIGfgVpOzFsR4Q8s6Ex6cs1pHjgS60H+cFjGir
         aTPBL4vTy/6FbtopOIy4KpYhIGGy/Y+hBljKtnk0QJZ11YHGWiBZVd9CcmsqFQZw2A
         nVdSW7cdiK8SQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] dmaengine: mediatek-cqdma: Add support for MediaTek MT6795
Date:   Tue,  3 May 2022 12:53:28 +0200
Message-Id: <20220503105328.54755-3-angelogioacchino.delregno@collabora.com>
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

Add a compatible string and platform data for the Helio X10 MT6795 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 7d8c54da3d58..5f8f44d37037 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -756,8 +756,14 @@ static const struct mtk_cqdma_plat_data cqdma_mt6765 {
 	.reg_src2 = 0x60,
 };
 
+static const struct mtk_cqdma_plat_data cqdma_mt6795 {
+	.reg_dst2 = 0x44,
+	.reg_src2 = 0x40,
+};
+
 static const struct of_device_id mtk_cqdma_match[] = {
 	{ .compatible = "mediatek,mt6765-cqdma", .data = &cqdma_mt6765 },
+	{ .compatible = "mediatek,mt6795-cqdma", .data = &cqdma_mt6795 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
-- 
2.35.1

