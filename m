Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8517584F17
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jul 2022 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiG2KpD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiG2KpB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 06:45:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04DC83F19;
        Fri, 29 Jul 2022 03:45:00 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BEC66601B69;
        Fri, 29 Jul 2022 11:44:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659091499;
        bh=FJUOyAwho3bbWQ8PWvLe4wxYoMHlf01l8/jYVjXf2r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWzukmMRpP7N16ie/C/7kSNSqJO07cZHNsvoFBDgJhi6Jjb4ih+LGXpW+zMgi6YPm
         yXEG0q1bVhbdTw4t12e8DySfifvBcCbnizCcFiOC5yi45hG9P4kn9+Y0ENLimm8C53
         RRLXIpVmXy3Qk73sDFdkiSFB8ADTzIGo+VIasHg9KY7c1npOVBFSh1S3aXIFw8JH9h
         IcEIV0LLbzCdUtxCUZ4FLuuNywYyPAZ5ep8d8HAwvGd1vG/DvIZDQjxZkxIzQYVv5V
         nctcrZCXvoNSokM7OGhX4p7WnBHkPA48W3Sng1skXJGNpR4XQmD2IzRZigtGyTjkHg
         HpxjTnK7IDaNA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        hsinyi@chromium.org, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, fparent@baylibre.com,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        long.cheng@mediatek.com, wenbin.mei@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 6/8] arm64: dts: mediatek: mt6795: Add support for eMMC/SD/SDIO controllers
Date:   Fri, 29 Jul 2022 12:44:38 +0200
Message-Id: <20220729104441.39177-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the mmc nodes to support all of the four controllers, used for
eMMC, SD/MicroSD and SDIO storage.
All of these controller nodes are left disabled by default, as
usage is board dependent.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index 687e0ee63503..2548bfcf9755 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -380,5 +380,46 @@ uart3: serial@11005000 {
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt6795-mmc", "mediatek,mt8173-mmc";
+			reg = <0 0x11230000 0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_0>,
+				 <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
+				 <&topckgen CLK_TOP_MSDC50_0_SEL>;
+			clock-names = "source", "hclk", "source_cg";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt6795-mmc", "mediatek,mt8173-mmc";
+			reg = <0 0x11240000 0 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_1>,
+				 <&topckgen CLK_TOP_AXI_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc2: mmc@11250000 {
+			compatible = "mediatek,mt6795-mmc", "mediatek,mt8173-mmc";
+			reg = <0 0x11250000 0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_2>,
+				 <&topckgen CLK_TOP_AXI_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
+
+		mmc3: mmc@11260000 {
+			compatible = "mediatek,mt6795-mmc", "mediatek,mt8173-mmc";
+			reg = <0 0x11260000 0 0x1000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_MSDC30_3>,
+				 <&topckgen CLK_TOP_AXI_SEL>;
+			clock-names = "source", "hclk";
+			status = "disabled";
+		};
 	};
 };
-- 
2.35.1

