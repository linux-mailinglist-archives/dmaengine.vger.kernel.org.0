Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F35560979
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiF2Soz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiF2Sov (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 14:44:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D6275FF
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so19850425wrh.3
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Juzz+Ngk10Ta05//fxfH00O+jv/gMrP+Bqb9Q3jKosQ=;
        b=ZA8y7P8hKKrPtisjdtqQq+qA1CID6TRmuw8f26eSBGt1WTJeML7gtXTyV7fNJDHMK3
         uuo7s6uFAg+bbTdr6RVne+0z6egOsvto5QiZ6mK0zZwxu/+Wi7VHR3Sih2KhTPitJxxv
         lTfuAXeyZvMxoG6sYUHkPFi0QiV+MOFey0wVpULURsN00zFfHAxuzQa2wJRk2MJYufak
         ZBER6WKxnutHozCshebTmqJ5yG6ZaDruFHXsj5/te+pMua81k77zKXbcbZvi+jh9fqcm
         2tlxPmKfOjotnkDLVyD5TXiHh4tRn3SOWxgppXhFA3DURAdXDHGX1ICJCnx8LDK9p3Ha
         1wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Juzz+Ngk10Ta05//fxfH00O+jv/gMrP+Bqb9Q3jKosQ=;
        b=v3TUYij/jg0cssvuFNz9uNMZJfmOYu2NpX03O22PsGBmt8+denyUIJdRY+BH4zOWzW
         ISYlgjDeTGqP/Iwsfx4Gt1NoS86oR3+Jzi9VWBK7GyQ2A41sFjR1QPqODx8Spx6gquMe
         HxJhds4UfOBhutNz+V5GE9zo/HEkzSGGu0o6in/q93QfyMhGn/yAKRoxUmUvuInlZuCi
         4WkJcucdmDnlepA8+F5TFc7Xc1VoBQL7GVcV9XnTe2TgZV1dNthz2YTQcRaP41/yESs6
         7AP979h+eicMjSLUyLr0nqWRYcjn+AHpgQ44FBksBff4muYdsFmLVQHtdf4nHcSi/wq8
         9GcQ==
X-Gm-Message-State: AJIora9iMxXn39oUc762kTbSJgtnWtnIfcrPdWFxV+1PzvccYC9vAb9h
        d+hrh/P2UeLC10PWzQYWffM+rA==
X-Google-Smtp-Source: AGRyM1s0I5FJ4BJCXP+3NEy7+7xMkTJben+77vrmXua6sh2SuaEOzmm9e8Tj0lFsY/ZmuWdd66mstA==
X-Received: by 2002:a5d:6d45:0:b0:21a:2f43:cb76 with SMTP id k5-20020a5d6d45000000b0021a2f43cb76mr4604259wri.254.1656528289159;
        Wed, 29 Jun 2022 11:44:49 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:48 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 08/15] riscv: dts: canaan: fix the k210's timer nodes
Date:   Wed, 29 Jun 2022 19:43:37 +0100
Message-Id: <20220629184343.3438856-9-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The timers on the k210 have non standard interrupt configurations,
which leads to dtbs_check warnings:

k210_generic.dtb: timer@502d0000: interrupts: [[14], [15]] is too long
From schema: Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml

Split the timer nodes in two, so that the second timer in the IP block
can actually be accessed & in the process solve the dtbs_check warning.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 46 +++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index cd4eae82d8b2..72f70128d751 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -319,28 +319,58 @@ fpioa: pinmux@502b0000 {
 
 			timer0: timer@502d0000 {
 				compatible = "snps,dw-apb-timer";
-				reg = <0x502D0000 0x100>;
-				interrupts = <14>, <15>;
+				reg = <0x502D0000 0x14>;
+				interrupts = <14>;
 				clocks = <&sysclk K210_CLK_TIMER0>,
 					 <&sysclk K210_CLK_APB0>;
 				clock-names = "timer", "pclk";
 				resets = <&sysrst K210_RST_TIMER0>;
 			};
 
-			timer1: timer@502e0000 {
+			timer1: timer@502d0014 {
 				compatible = "snps,dw-apb-timer";
-				reg = <0x502E0000 0x100>;
-				interrupts = <16>, <17>;
+				reg = <0x502D0014 0x14>;
+				interrupts = <15>;
+				clocks = <&sysclk K210_CLK_TIMER0>,
+					 <&sysclk K210_CLK_APB0>;
+				clock-names = "timer", "pclk";
+				resets = <&sysrst K210_RST_TIMER0>;
+			};
+
+			timer2: timer@502e0000 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x502E0000 0x14>;
+				interrupts = <16>;
 				clocks = <&sysclk K210_CLK_TIMER1>,
 					 <&sysclk K210_CLK_APB0>;
 				clock-names = "timer", "pclk";
 				resets = <&sysrst K210_RST_TIMER1>;
 			};
 
-			timer2: timer@502f0000 {
+			timer3: timer@502e0014 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x502E0014 0x114>;
+				interrupts = <17>;
+				clocks = <&sysclk K210_CLK_TIMER1>,
+					 <&sysclk K210_CLK_APB0>;
+				clock-names = "timer", "pclk";
+				resets = <&sysrst K210_RST_TIMER1>;
+			};
+
+			timer4: timer@502f0000 {
+				compatible = "snps,dw-apb-timer";
+				reg = <0x502F0000 0x14>;
+				interrupts = <18>;
+				clocks = <&sysclk K210_CLK_TIMER2>,
+					 <&sysclk K210_CLK_APB0>;
+				clock-names = "timer", "pclk";
+				resets = <&sysrst K210_RST_TIMER2>;
+			};
+
+			timer5: timer@502f0014 {
 				compatible = "snps,dw-apb-timer";
-				reg = <0x502F0000 0x100>;
-				interrupts = <18>, <19>;
+				reg = <0x502F0014 0x14>;
+				interrupts = <19>;
 				clocks = <&sysclk K210_CLK_TIMER2>,
 					 <&sysclk K210_CLK_APB0>;
 				clock-names = "timer", "pclk";
-- 
2.36.1

