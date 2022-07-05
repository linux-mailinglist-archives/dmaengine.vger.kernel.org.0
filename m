Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C663956799E
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiGEVwf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiGEVwd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:52:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C922718E1E
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d16so13066032wrv.10
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqL0tHq3yutxZ8W44fi30XmUjbkhUDTMtwglXCEjHME=;
        b=TUD6u63i7P5kQA0tnLQjnxdzGdOqtSUW2eq4KqCx6pcbCMXUPWKNUj6YsetPT7YpfH
         /lKPlH2c+aILPHcMN+I7U2pkHsahJeoNYsD8BHnczcTzFzn1rBKqCJJ1sHZVQKckdOUV
         C1vMht16NUB2XhkbGAIgF560SO+H5q+u2ITntpWIcEuYmFqJUYeCZylaQkNH0DfdMH8o
         l4JU7weKZOktwSkx0fr1qsLtna94Sezgdu3IielxiXD2b6tY+l2rIT2sICejdRztjM75
         7hcOt9iqgxnp9PCshmE6ZwAvCe5LTKMI+sgYK/F/ex3c7FbCUOJ15AfA67GwkIiem2bF
         0qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqL0tHq3yutxZ8W44fi30XmUjbkhUDTMtwglXCEjHME=;
        b=5enjUIRyHn4UiiC+k+2afBzvR3fPKOKlxVQA1F9eTzolXgyLXsU99qVAO0ECYpcNnY
         LQ6gPL1+iA6Hhx3oaje+LPow76p9R7Sj693iFNTjdZg4nDLM7E0dJJWWtJrS0NNMUfvT
         74Ezyary80ACxhSEzuL4BaUg+4L83Cy3lpZFZnvWwHwVsLLQzbbVNmV6zjbnpTWgeqZr
         EWyx4vx+l1u4ykEyoSdHcp8tVd4lGO8rYfqNPVfD0dBy+Zi7VDY7hERoN36r2FnzHkZU
         qtymEEIQOdZl8tL4+l7l27woyzb+vVm9hA9j+VlQB+wX/erxf3qwKffVMreaN0SdBkgN
         1zHA==
X-Gm-Message-State: AJIora+5zM0U8jY9Em7KFkg/FuaWoW/bfRUSubyr976XUyA4IOtiwdLl
        QkU5Eg+HQsQIkSPCX1/RTlYPNg==
X-Google-Smtp-Source: AGRyM1t75bZl88GDvO4WahOzUUxgWngI0hl2R4SCexxJGzyeHIswkpPqzcGl4w65l4Bi7Mmu9kKLHA==
X-Received: by 2002:a05:6000:1701:b0:21b:bfd5:c910 with SMTP id n1-20020a056000170100b0021bbfd5c910mr34193799wrc.363.1657057952380;
        Tue, 05 Jul 2022 14:52:32 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:31 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 06/13] riscv: dts: canaan: fix the k210's timer nodes
Date:   Tue,  5 Jul 2022 22:52:07 +0100
Message-Id: <20220705215213.1802496-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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
2.37.0

