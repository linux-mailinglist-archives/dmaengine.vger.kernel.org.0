Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C920655CB1C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiF0Tlw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbiF0Tlp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 15:41:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737717E18
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b26so2095945wrc.2
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yX9mBCtyn3dt/LFcnWYLnHjmmtyKFR5605f1mLuzSM=;
        b=AtMYN6PSkLA1y0PqfjVZ9B2anDv7fpdxjk9Z2GEBmdgR3Y/a5AVf7ucMgQk3IvAslk
         Q0FldXcJOm2h1zMZQtoN6HX/VUa9z6V+celDZ6Cf6uyoZ436qN3qrQ4XzyB4kEaC/OCy
         hcHOUjibIOU8Lfa1bhhnNuso3DiXNufNqD3OC3JF6FBFpZWJXFeM2Ph8krHKA6xsWkzO
         fu96DPwW+8Wa2B9/eZ4mV4u23G09Fp5aWq/QeIOVXKmMAqyQFsynIPrm59xnsG6Zk4C0
         oWRHhkY277ATUfplHzV4oeIn1Ke23xrVrGkP/kyz5t1D04Mi19ZmsHObET6qcXxwAAAm
         jXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yX9mBCtyn3dt/LFcnWYLnHjmmtyKFR5605f1mLuzSM=;
        b=OJhDLLuDveBkSrNlJ9bbb016bp4S/i+zcHKnMU6nGFtfbFZALf1rRMTQozaalLnVEE
         X6poNOhyXaBB1XwC9T2knjfQjylbWuRR62PHCNze7C5FfFunrRRsrJYLl8KvJTscq2fh
         3cINsAOm4jr71IZTCWrdYl6wTc5NlUs7rqCsqT/OXhxIO1G7JWI6JEs4r91xNJvW+VRN
         7ZlQQlLTi58UP+IxcAwFEhPcCLU4DWPtUel8FMcI2P0zMgjWAYIVoIoEqpbyDVzY0ujm
         tZTbVhHJPnmYls08yI0agFjLt5x9BQYJpp0oSed3PVgi0kCVqiQDGRxmHeCWUh567i4I
         bcig==
X-Gm-Message-State: AJIora9ZfYPVvptrzGL2IZJQilIHPHWBkWRB6nyWA4d2Mv57tWqnOXiH
        XQHpk377eL3dq8um3h7tqX2K+w==
X-Google-Smtp-Source: AGRyM1v+CiQCqjbnq4vRMZqSCSRDlEuyAPNKkRp+mF7UYQN9jimLW4SxHvA7KTYHLOBZVxNPsqPSbA==
X-Received: by 2002:a5d:584f:0:b0:21b:a557:98fa with SMTP id i15-20020a5d584f000000b0021ba55798famr13392886wrf.462.1656358893163;
        Mon, 27 Jun 2022 12:41:33 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:32 -0700 (PDT)
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
Subject: [PATCH v2 10/16] riscv: dts: canaan: add a specific compatible for k210's timers
Date:   Mon, 27 Jun 2022 20:39:58 +0100
Message-Id: <20220627194003.2395484-11-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
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
index 45ccab36618a..be42c56e770c 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -318,7 +318,7 @@ fpioa: pinmux@502b0000 {
 			};
 
 			timer0: timer@502d0000 {
-				compatible = "snps,dw-apb-timer";
+				compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
 				reg = <0x502D0000 0x100>;
 				interrupts = <14>, <15>;
 				clocks = <&sysclk K210_CLK_TIMER0>,
@@ -328,7 +328,7 @@ timer0: timer@502d0000 {
 			};
 
 			timer1: timer@502e0000 {
-				compatible = "snps,dw-apb-timer";
+				compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
 				reg = <0x502E0000 0x100>;
 				interrupts = <16>, <17>;
 				clocks = <&sysclk K210_CLK_TIMER1>,
@@ -338,7 +338,7 @@ timer1: timer@502e0000 {
 			};
 
 			timer2: timer@502f0000 {
-				compatible = "snps,dw-apb-timer";
+				compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
 				reg = <0x502F0000 0x100>;
 				interrupts = <18>, <19>;
 				clocks = <&sysclk K210_CLK_TIMER2>,
-- 
2.36.1

