Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF7584F1F
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jul 2022 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiG2KpH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jul 2022 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiG2KpD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Jul 2022 06:45:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA483F34;
        Fri, 29 Jul 2022 03:45:01 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 805A16601B6A;
        Fri, 29 Jul 2022 11:44:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659091500;
        bh=0QqxLKrVrFujWkJ9DfNf1cxn6EG01MDTs5MXelKFVVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzrBYnrYJGRifz/98IYnmb50FiMX0iJ1APYI8Ev83ulPV5S1YgZdl9urEQa+hqsbb
         d1LGyLGyjbmrMgVT49tTGetbMvtA+Zy8FYqEKW70wuZW1gxpxpO4vEo2CHkbG1gEKS
         WUqpamW3QzPbfyY/zhbQx4C4Vp5k6bTWCV32XXnr6TT/a3gJW/kUKiqmcW39YeVN8J
         E6OR36oigizyIVlIxKbMLk5pgAYYg78X6XyoE/fByCty8wOlm7E9QPC68DTu5+6jqU
         V4pvaBQPukkf8VOAKGrQAXDgKPGt4+YI+P6oBh4VFWKVL34mPADF7VGhOaWv0ngNRr
         n7ACfawIluOQg==
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
Subject: [PATCH 7/7] arm64: dts: mediatek: Add support for MT6795 Sony Xperia M5 smartphone
Date:   Fri, 29 Jul 2022 12:44:39 +0200
Message-Id: <20220729104441.39177-8-angelogioacchino.delregno@collabora.com>
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

Add a basic support for the Sony Xperia M5 (codename "Holly")
smartphone, powered by a MediaTek Helio X10 SoC.

This achieves a console boot.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index af362a085a02..72fd683c9264 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
new file mode 100644
index 000000000000..94d011c4126c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Collabora Ltd
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+/dts-v1/;
+#include "mt6795.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Sony Xperia M5";
+	compatible = "sony,xperia-m5", "mediatek,mt6795";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x1E800000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@43000000 {
+			no-map;
+			reg = <0 0x43000000 0 0x30000>;
+		};
+
+		/* preloader and bootloader regions cannot be touched */
+		preloader-region@44800000 {
+			no-map;
+			reg = <0 0x44800000 0 0x100000>;
+		};
+
+		bootloader-region@46000000 {
+			no-map;
+			reg = <0 0x46000000 0 0x400000>;
+		};
+	};
+};
+
+&pio {
+	uart0_pins: uart0-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO113__FUNC_URXD0>;
+			bias-pull-up;
+			input-enable;
+		};
+		pins-tx {
+			pinmux = <PINMUX_GPIO114__FUNC_UTXD0>;
+			output-high;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO31__FUNC_URXD2>;
+			bias-pull-up;
+			input-enable;
+		};
+		pins-tx {
+			pinmux = <PINMUX_GPIO32__FUNC_UTXD2>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+};
+
+&uart2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
-- 
2.35.1

