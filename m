Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DD53927E
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiEaNwP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbiEaNvt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 09:51:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DA5D5E8
        for <dmaengine@vger.kernel.org>; Tue, 31 May 2022 06:51:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so10706168wrb.0
        for <dmaengine@vger.kernel.org>; Tue, 31 May 2022 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqpZOx3pMkVOAQNQltlh6CmUED1DaV6aOqALQmMhbr0=;
        b=V5KO5uHzp9s6622Du0y0DXZ0jgYSd0RSHF7FMdDNrSpmwaxSJHuvsRsW2VNRNSOrSq
         y1EVTERgqTqh6WCBn2sK+biMlhdwtUOfHkYOUmqXbrQDQq6TzmwMWW4hoY0NxYLMZhO4
         /zUBkAnzYXfWN1Faz2Htht8uMV25t30NN4Rft9LNWCIdxjcP+iALn7dnVGhi6eF+D2Ie
         c1wQwd04xoqHMC6impdpfDG2anes3AqwBdkw3I1EQPe7Sby21LVtVM2SUfcGLlPu8IBe
         xZeuyF2xsIB1Z6TwgmoiwDGkuQVf93OO4xoXfMeL7mSCgqaatv4jXFNKa+ZrohncHNl+
         DqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqpZOx3pMkVOAQNQltlh6CmUED1DaV6aOqALQmMhbr0=;
        b=DFfu+zzQ0xP33guff94aj+aaq2K0K+q+o3Yr4oeFDF+enm6w2p8y41gohkANEBaLwy
         bI7Aq7053OcIcZCIPDllxZrZLAksctAg/ai1MmcwKOtoqWTVjLhMZUys4gBHhT+Q+UkG
         f0cVssaDsp/JGKdCPWY0H7eE4bcUSZKKHC6Z7heUwIKUc3XICB9HquA1+tppdCXWeX+M
         2ZwJl0sQdl1WnKi1ELf83SslBE5Wh6bxRba7iZrHTGNXNTz+WDpsd/v6YFHSNPSoistX
         EEal60z4OMGc43V5ppkqfzyG2J+Xd9WooQt184jH9dFCbnPFCi0OYrF69w4C2dDXUqv8
         aG4Q==
X-Gm-Message-State: AOAM5321QmHKvVGTBS0KnjFAf67e8XEilNyHCsxVMDGDm870rnHQxXg1
        sJi2kz98cjmJZzneTSP3dQfstg==
X-Google-Smtp-Source: ABdhPJwyPR86D46MqBkUm98L4oZz3ngtWZBbWNloc28wZ9CD78yWdvfkf6FMmCABZPC3ef00LuLk6Q==
X-Received: by 2002:adf:f603:0:b0:210:ddf:e04d with SMTP id t3-20020adff603000000b002100ddfe04dmr21311834wrp.463.1654005066904;
        Tue, 31 May 2022 06:51:06 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:51:06 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 15/17] arm64: dts: mediatek: add mt6357 device-tree
Date:   Tue, 31 May 2022 15:50:24 +0200
Message-Id: <20220531135026.238475-16-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device-tree for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt6357.dtsi | 272 +++++++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6357.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
new file mode 100644
index 000000000000..a28010119e69
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020 BayLibre Inc.
+ */
+
+#include <dt-bindings/input/input.h>
+
+&pwrap {
+	mt6357_pmic: pmic {
+		compatible = "mediatek,mt6357";
+
+		regulators {
+			mt6357_vproc_reg: buck-vproc {
+				regulator-name = "vproc";
+				regulator-min-microvolt = <518750>;
+				regulator-max-microvolt = <1312500>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <220>;
+				regulator-always-on;
+			};
+
+			mt6357_vcore_reg: buck-vcore {
+				regulator-name = "vcore";
+				regulator-min-microvolt = <518750>;
+				regulator-max-microvolt = <1312500>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <220>;
+				regulator-always-on;
+			};
+
+			mt6357_vmodem_reg: buck-vmodem {
+				regulator-name = "vmodem";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <220>;
+			};
+
+			mt6357_vs1_reg: buck-vs1 {
+				regulator-name = "vs1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <220>;
+				regulator-always-on;
+			};
+
+			mt6357_vpa_reg: buck-vpa {
+				regulator-name = "vpa";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-ramp-delay = <50000>;
+				regulator-enable-ramp-delay = <220>;
+			};
+
+			mt6357_vfe28_reg: ldo-vfe28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vfe28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vxo22_reg: ldo-vxo22 {
+				regulator-name = "vxo22";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2400000>;
+				regulator-enable-ramp-delay = <110>;
+			};
+
+			mt6357_vrf18_reg: ldo-vrf18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vrf18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <110>;
+			};
+
+			mt6357_vrf12_reg: ldo-vrf12 {
+				compatible = "regulator-fixed";
+				regulator-name = "vrf12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <110>;
+			};
+
+			mt6357_vefuse_reg: ldo-vefuse {
+				regulator-name = "vefuse";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcn33_bt_reg: ldo-vcn33-bt {
+				regulator-name = "vcn33-bt";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcn33_wifi_reg: ldo-vcn33-wifi {
+				regulator-name = "vcn33-wifi";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcn28_reg: ldo-vcn28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vcn28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcn18_reg: ldo-vcn18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcama_reg: ldo-vcama {
+				regulator-name = "vcama";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcamd_reg: ldo-vcamd {
+				regulator-name = "vcamd";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vcamio_reg: ldo-vcamio18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vcamio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vldo28_reg: ldo-vldo28 {
+				regulator-name = "vldo28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vsram_others_reg: ldo-vsram-others {
+				regulator-name = "vsram-others";
+				regulator-min-microvolt = <518750>;
+				regulator-max-microvolt = <1312500>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <110>;
+				regulator-always-on;
+			};
+
+			mt6357_vsram_proc_reg: ldo-vsram-proc {
+				regulator-name = "vsram-proc";
+				regulator-min-microvolt = <518750>;
+				regulator-max-microvolt = <1312500>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <110>;
+				regulator-always-on;
+			};
+
+			mt6357_vaux18_reg: ldo-vaux18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vaux18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vaud28_reg: ldo-vaud28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vaud28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vio28_reg: ldo-vio28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vio18_reg: ldo-vio18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+			};
+
+			mt6357_vdram_reg: ldo-vdram {
+				regulator-name = "vdram";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <3300>;
+			};
+
+			mt6357_vmc_reg: ldo-vmc {
+				regulator-name = "vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <44>;
+			};
+
+			mt6357_vmch_reg: ldo-vmch {
+				regulator-name = "vmch";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <44>;
+			};
+
+			mt6357_vemc_reg: ldo-vemc {
+				regulator-name = "vemc";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <44>;
+				regulator-always-on;
+			};
+
+			mt6357_vsim1_reg: ldo-vsim1 {
+				regulator-name = "vsim1";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vsim2_reg: ldo-vsim2 {
+				regulator-name = "vsim2";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6357_vibr_reg: ldo-vibr {
+				regulator-name = "vibr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <44>;
+			};
+
+			mt6357_vusb33_reg: ldo-vusb33 {
+				regulator-name = "vusb33";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+		};
+
+		mt6357rtc: mt6357rtc {
+			compatible = "mediatek,mt6357-rtc",
+				     "mediatek,mt6358-rtc";
+		};
+
+		mt6357keys: mt6357keys {
+			compatible = "mediatek,mt6357-keys";
+		};
+	};
+};
-- 
2.36.1

