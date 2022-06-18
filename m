Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7E5504B7
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiFRMds (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiFRMc2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E141DA71
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s21-20020a1cf215000000b0039ee8149524so2033158wmc.5
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pg5EtL0V3UHrid7YbhvB+3zhrduzQGisX4A0SVhhM0E=;
        b=Pu1M106xN55HI9pfnOZNoRrDpjX1i4VH9bR0a4BhQ0DJdKnxN33JrDSsp8oMDBO6jp
         LVQ1VI+4atrButRPKUPNqCrIEigfT0IM8RSE/TM7b+yFCd8/4+xiDRZ3O7NsK9REtRLv
         84xM29eeccO+uGrixFZq0EZFXZEdycBvA0ECOB3ZQETpwQOJCmoI57SPRa91RH4Ybiwn
         DHwH4ld25Q7R0o4T9qzfzLsKmjYB53l8b9saZnSz3GnJD24tqYxXVFcv/kp23HP9PpCH
         I+j/f4rZISdty/aA/Vg0TKDsifyuWEt2DZv8kvr86VvPeWNfHBmzINiITLTKs1DLpX1a
         cUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pg5EtL0V3UHrid7YbhvB+3zhrduzQGisX4A0SVhhM0E=;
        b=YZm2xYaUWY2soialJvK9NjvcF4vduz9kzvRvTJez341a7Bkmk2C7cTWQ4eOHAkCBZi
         QGlOzF7Rqhykn8RTE8ZQDykgVWO8fTJSf5VjYFBIOdYvi0e6hfUYg9NGUVUBu47QZSz1
         4A6Tn7vdWY/nLakTJ1wpP1/BGI8M6A0Rqqydl2ybO/GssgNF8OOkQMwpCIYvxdk2ixxl
         o8y/FeSN/+o8uYSy0WBdjezN/zm+FDvg6XV7g6E/3qxhF9GqxSdpXGwO3nFDZrystq4E
         BnQxCSQKqyLkjPXZANhFn2ZLdgG1/bcdxEnooc16qe2a6oqUkL5U/u94ImHkxuiCVj2p
         eVIg==
X-Gm-Message-State: AJIora+13c/cua7yiii7VJlvLKd9B0XBv63jC5zIWAYxMf8fOVSNyyVi
        WgLD1Yk60Uv/8j+BzofAO6FVdA==
X-Google-Smtp-Source: AGRyM1t+D1hSYvVv2lyhJXTM8fnBYLleL1Z3z4M3dP8UVmVZwbcohvWxMo8SxFiBx5Zo6H6ulo6zQw==
X-Received: by 2002:a05:600c:3553:b0:39c:63a3:f54a with SMTP id i19-20020a05600c355300b0039c63a3f54amr15447271wmq.61.1655555543356;
        Sat, 18 Jun 2022 05:32:23 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:22 -0700 (PDT)
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
Subject: [PATCH 13/14] riscv: dts: canaan: remove spi-max-frequency from controllers
Date:   Sat, 18 Jun 2022 13:30:35 +0100
Message-Id: <20220618123035.563070-14-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
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

spi-max-frequency is a device, not a controller  property and should be
removed.

Link: https://lore.kernel.org/lkml/20220526014141.2872567-1-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 5eb6b69c1170..ec290db4705c 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -413,7 +413,6 @@ spi0: spi@52000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI0>;
 				reset-names = "spi";
-				spi-max-frequency = <25000000>;
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
@@ -429,7 +428,6 @@ spi1: spi@53000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI1>;
 				reset-names = "spi";
-				spi-max-frequency = <25000000>;
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
@@ -445,8 +443,7 @@ spi3: spi@54000000 {
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

