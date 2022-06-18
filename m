Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BD55048F
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiFRMc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbiFRMcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF51E3D7
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m1so1046169wrb.2
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANXJKxbxI6u0tRhbN1AR4RFN+HN2j5iiePXGo5syCSs=;
        b=ErRXmSLorMjbdC5xWyP7urzRERR22/20eLl2XT0de71YUvLq9olsxJGpQ3PYt53udC
         MVVWn2OjFLzgo73dqk3/65ggchSO1J6/nfMBeW38N005pku7I4zSrpTv/zuaPfLKqJXk
         qjB07OxZX64wGSSlEDl91/abWVL2GYNDo4+scSLK83C9i4JROcieRdmp2gRhc8Fbnv7b
         b+9kOPXlfRJAEYkP1FzaLttvE+ReKggwoO5cB1Sf7ynv7N/LnmCtOMTXn+ccH3yxMsLw
         zDc7cjrPkXazBBOkKzNLuqxuVA3FOYoudEVTiel9Zmf2Ygdp7uXNnHjAvJ2fnRfqPbuk
         SpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANXJKxbxI6u0tRhbN1AR4RFN+HN2j5iiePXGo5syCSs=;
        b=EDIof5zuf1DEPRFszu2Y/QypnLP6KvM0kAmZyAGApf6IRRyMejm7u30BB/rzRWVu/Y
         KC6Ye4ecO8HL/In6pwXx+dHwnByGCCsM5DBQhWthvaYfPv7ZYDKm+KypIuURX6kjYbWc
         Er9LBRktoI5dlUF1CUYRzegBCxazJ/Slo2tCELI0uxg/LmxjowXf7AAQsztxvv+jJgUL
         rPujGib37nIb7+H4HC5bYKeciw1ro5oYMAPGWfeleA+PWtwNjXUQRYVkz5qdu0nuAh81
         JThdAhNyn4E3F5f3eXdytZSa0dp+1Z268iYK8lQpzpVyZ+RWqDFZ+soVKx9DylMAR/Vf
         F8dg==
X-Gm-Message-State: AJIora948pDvU4fHJ/DqTVfxM62JVNxvi4wU/UZK3Ksi8GkoEW3pA8iA
        v59X+biSKzYNYxUyC+PiNidrSA==
X-Google-Smtp-Source: AGRyM1tbrkXYGfjWsBsEjmtzpjiA7Ap83fqu9IJcwCnfQzpYaSuFuxLt2MogvQUzBnMlTPtFn6izqg==
X-Received: by 2002:a5d:584d:0:b0:216:a2a9:5f2c with SMTP id i13-20020a5d584d000000b00216a2a95f2cmr14168978wrf.184.1655555535278;
        Sat, 18 Jun 2022 05:32:15 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:14 -0700 (PDT)
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
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 09/14] riscv: dts: canaan: add a specific compatible for k210's timers
Date:   Sat, 18 Jun 2022 13:30:31 +0100
Message-Id: <20220618123035.563070-10-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
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

Change to using the newly added canaan k210 specific binding to avoid
the warning.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 314f6da5d7f6..ef46ddf3c00c 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -310,7 +310,7 @@ fpioa: pinmux@502b0000 {
 			};
 
 			timer0: timer@502d0000 {
-				compatible = "snps,dw-apb-timer";
+				compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
 				reg = <0x502D0000 0x100>;
 				interrupts = <14>, <15>;
 				clocks = <&sysclk K210_CLK_TIMER0>,
@@ -320,7 +320,7 @@ timer0: timer@502d0000 {
 			};
 
 			timer1: timer@502e0000 {
-				compatible = "snps,dw-apb-timer";
+				compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
 				reg = <0x502E0000 0x100>;
 				interrupts = <16>, <17>;
 				clocks = <&sysclk K210_CLK_TIMER1>,
@@ -330,7 +330,7 @@ timer1: timer@502e0000 {
 			};
 
 			timer2: timer@502f0000 {
-				compatible = "snps,dw-apb-timer";
+				compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
 				reg = <0x502F0000 0x100>;
 				interrupts = <18>, <19>;
 				clocks = <&sysclk K210_CLK_TIMER2>,
-- 
2.36.1

