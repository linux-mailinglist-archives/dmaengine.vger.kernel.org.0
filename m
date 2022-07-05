Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6577A5679B6
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiGEVxB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGEVws (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:52:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA55193CA
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so10086495wmc.1
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btfD2ddLZTsrkxXM+5X0SlRWCSAFkc3crudlByDnEUI=;
        b=R2ZH0gVpmULNTv6IJcLMhpWIi94ZX23K1txij23UvjFeSzC3TosPXLd2Xl8x/lj8HQ
         9Y+0cd3VifBNPS8rtQtjRQbPZHdvl/w4dhwDPWCg0IXB58BUR6JYHlX9ZP1O+AhRmMgu
         B8d/QnrymSEjCT1MzHxmsr77lUPEBwyrqAC5UCUuROQwCAY/g7zB8dSBkrmbVIZd8gTU
         LjBB8oMchg8USlhrITWohYgE19TDziCHl77VuySNrjC2NTXP/bzmxACDHZEouWmEiU0B
         1v7K3pQ5V1polgAp3q7tYlG4glWe6iedMPE5oJAkp24Ur4XhLIAuE8ditoMQgWPaJojK
         TtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btfD2ddLZTsrkxXM+5X0SlRWCSAFkc3crudlByDnEUI=;
        b=fq2IJqHgLnzqtRzxgvShLcNA5i62WLFKNTNZ8VcN+xgpPpDFVcKk5rZa6Ap5QCdiDy
         RY5nfiCisnBi7S4FUj5vPTYzA2u+c0gy8A+OvRy84mXVkb/CDG3Djog7+xxOBTl2TVLm
         fROewVxFpveosdlAJLBiCG/foyOEGvA+/f0CnmzpBrUN/yrgr3AyeLStwdZu2VVp1Sdy
         wrIgNi6HhInDGT5ISxHrnOMyG51KXLgKl/MBU4DyqJJ4ybvNGHDIpD9DcMlzC9jjPGj3
         8UYHGC7ev98Svof6HEHyX0rBfbczQnKkO66PUmVKGi9EX99ae/HI9YFep2h4uDrWkCFS
         Z6hw==
X-Gm-Message-State: AJIora9e9S+3iG9boI8wSYFx4DsWIKu4ctNPGEMdxo5O8meBESu6uQ9V
        SnrjIr0/Xz+qCYciNJd+jaAWgA==
X-Google-Smtp-Source: AGRyM1uXxyzForUKTAh74BBZRKGne5xPz5YmmHzkkj1xxpM+GNVio6fhXm02YyxzMkM3fk0zBgZL5g==
X-Received: by 2002:a7b:cd0d:0:b0:3a1:8f1e:cb2f with SMTP id f13-20020a7bcd0d000000b003a18f1ecb2fmr24066595wmj.10.1657057956434;
        Tue, 05 Jul 2022 14:52:36 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:36 -0700 (PDT)
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
Subject: [PATCH v5 09/13] riscv: dts: canaan: use custom compatible for k210 i2s
Date:   Tue,  5 Jul 2022 22:52:10 +0100
Message-Id: <20220705215213.1802496-10-mail@conchuod.ie>
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

The devicetrees using the Canaan k210 all have a sound-dai-cells value
of 1, whereas the standard binding example for the DesignWare i2s and
other use cases suggest 0. Use a k210 specific compatible which
supports this difference.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 72f70128d751..900dc629a945 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -251,7 +251,7 @@ spi2: spi@50240000 {
 			};
 
 			i2s0: i2s@50250000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50250000 0x200>;
 				interrupts = <5>;
 				clocks = <&sysclk K210_CLK_I2S0>;
@@ -260,7 +260,7 @@ i2s0: i2s@50250000 {
 			};
 
 			i2s1: i2s@50260000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50260000 0x200>;
 				interrupts = <6>;
 				clocks = <&sysclk K210_CLK_I2S1>;
@@ -269,7 +269,7 @@ i2s1: i2s@50260000 {
 			};
 
 			i2s2: i2s@50270000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50270000 0x200>;
 				interrupts = <7>;
 				clocks = <&sysclk K210_CLK_I2S2>;
-- 
2.37.0

