Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD26855DA70
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiF0TmD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbiF0Tlq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 15:41:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D382317E34
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso1857154wms.1
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7fNGijI+hr0dTmXMpnscpCDFPOlTGyo8sAtxEfEzZU=;
        b=GerFAD3YrJ4xNZUZH9wuFBjhPGLtwU4LMQ9xLZDfyPgID9HmkvjLT2X70Dv7RK45sE
         Rl7UcLZKjjBEXn6gMFFPFGKqGU8YKteSUBRZgT3q2KCTELbPxEugPVPhsRUTxI6EEFTP
         U7pEG27DbQT4d6LjDNzc6tWTonPRp0kqfUVnKPpDnLikqRJRWZ9vVsU6JuLkkdfI6FCf
         DH8VhTtnOJRQfz2jcXuMHBAiiw2x3DbsLEgNHmVpboCY7IizIW/K+BGFbjzLsujm+vCI
         IHgUW86u00ZgFljJlptTSCnVffs7mtC3wTbTmAl0NcpYIRCtY2jbecDSSyPjyUsCLT2h
         rnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7fNGijI+hr0dTmXMpnscpCDFPOlTGyo8sAtxEfEzZU=;
        b=Gvb7sSZ7/cYGOeSDXgCAeIlYhIPFq/xArLKcZ8+lm6FXa6ECmH2lubhp1T1a78nIuh
         a4T5iClKS4zFyuTpcCGxRacjbaiR7uqNK2+JH9s/Xu7Ucv3PL0KllEgL0E5Z5ibH/fCt
         DzZtGzBdQxJ/ST1BIiOLy0E8jERd+Z3gm50b3m3QA6isADXUH5Zjt/PILwfkEV+P3nBI
         adDvMkSFp1/iNlF+IokzEOzkCJBkNEYB/RmWTDdQeJHWTJqX0BPEZkwfRemOV24X4NQa
         xErNTn6tj3XJFn/in+tfsoLLasea19Tr5vRfGyahQOMvu4KgWZrdZWRpwafBA801+zs5
         6BdQ==
X-Gm-Message-State: AJIora/wMZ8DyJOMAtzTFEqoVdUFHiD93Z0T+3cNs5YN/ISPRD0xO+Jz
        42N4UnBLJM2AOHNYTBS+u8RE7Q==
X-Google-Smtp-Source: AGRyM1vfR8BzEtMkEDzJdyFBjP72bU2FypIWvUEsm3mPIw919lu8Jm/Nyc6yvHG4q/vyYSVc9E5JZg==
X-Received: by 2002:a05:600c:1c04:b0:3a0:512f:b9e5 with SMTP id j4-20020a05600c1c0400b003a0512fb9e5mr333292wms.85.1656358901364;
        Mon, 27 Jun 2022 12:41:41 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:40 -0700 (PDT)
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
Subject: [PATCH v2 14/16] riscv: dts: canaan: remove spi-max-frequency from controllers
Date:   Mon, 27 Jun 2022 20:40:02 +0100
Message-Id: <20220627194003.2395484-15-mail@conchuod.ie>
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

spi-max-frequency is a device, not a controller  property and should be
removed.

Link: https://lore.kernel.org/lkml/20220526014141.2872567-1-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 10c2a1417deb..84a7ab363d72 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -421,7 +421,6 @@ spi0: spi@52000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI0>;
 				reset-names = "spi";
-				spi-max-frequency = <25000000>;
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
@@ -437,7 +436,6 @@ spi1: spi@53000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI1>;
 				reset-names = "spi";
-				spi-max-frequency = <25000000>;
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
@@ -453,8 +451,7 @@ spi3: spi@54000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI3>;
 				reset-names = "spi";
-				/* Could possibly go up to 200 MHz */
-				spi-max-frequency = <100000000>;
+
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
-- 
2.36.1

