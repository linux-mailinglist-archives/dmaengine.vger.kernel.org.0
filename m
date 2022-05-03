Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E24F518623
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiECOKJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbiECOKH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 10:10:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F28E25C40;
        Tue,  3 May 2022 07:06:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9E4131F42D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651586794;
        bh=ql/BpN5lmzD9fjXlRsrtZEO7EafrENS8JYhlrsgfa9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0aP5kkhB5SMqHgPYSnFLijiVJZju399eRbkzol8dkKVWSU5JdVC/QpR0wBPg3ERr
         +dg2XnGkoN1kzHHnVSuuRR3rPjC5DcC3SdZOcZZKC2auMfT3EuLoTIIAWLloSjvWw4
         7uG54PQmRy3SwkiC+t8m3q8yJ/aPgZeItomK8xKsnPfPWO+K3U76mI3tdg+8q1a16H
         wK46wl3qDYICe9w7uTE9pFgFCbogl7atCtdnunKxeWXErHtD/uJV6aIlKV7ULZBR4y
         keXYBT4n3x7e8PKHylfLdE/oXXP14rOFr4h92kwNefb6e+LEEfdn4Wg8MVUu1lHzQr
         0kFo7HztB2I/Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] dmaengine: mediatek-cqdma: Add support for MediaTek MT6795
Date:   Tue,  3 May 2022 16:06:24 +0200
Message-Id: <20220503140624.117213-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503140624.117213-1-angelogioacchino.delregno@collabora.com>
References: <20220503140624.117213-1-angelogioacchino.delregno@collabora.com>
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
index a2fb538d9483..e1772dbf50d5 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -757,8 +757,14 @@ static const struct mtk_cqdma_plat_data cqdma_mt6765 = {
 	.reg_src2 = 0x60,
 };
 
+static const struct mtk_cqdma_plat_data cqdma_mt6795 = {
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

