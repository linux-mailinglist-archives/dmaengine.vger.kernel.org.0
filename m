Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D455C328
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiF0TmE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiF0Tlq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 15:41:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133918381
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i25so8975202wrc.13
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AQ9wIHwlRmT7tO1Hd8om5LpzXV8vNgzmPbgMU2oiknY=;
        b=B5C/Gw1koJ2gCfNSuN+oniQsxKz/C0BbgCMWl8rQMBYqrHqfXovlJGRG6EhbKDmSUI
         YMrDLvEKPR9I0xmZ6/f2UkBdvxHfzIFOCu/+tXXA400uNFasRF2Y5Rw3V4t8exfluRsl
         pDrVCx2/y3GyUEYGpK1TCxM/gQf1o4TtNjiohPthJ+tyggDe+vxCZqFMZp1iemAhJKUy
         KSoBOo6zKZnIFSTr/b+WCGZwNY/WRUWR4JU5U/op5XzoBDI7nlRb87RvgWMkI41Uf2mC
         De6OwVU/r5tClMepVijT6V+kPZ/riqI+R5m1lGoFaN+/TWN3PGYd3lIy7cYtXlUQ7b2n
         ouTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AQ9wIHwlRmT7tO1Hd8om5LpzXV8vNgzmPbgMU2oiknY=;
        b=v5tI75o5XtTuqh0GulGT75wz7LHqLiAqTxuQXEQCbk/uUI0BXOSaCdeU9jvsH5ubxT
         aL4zs5IkpyaOTJb0z0KpmQnDCD5fbGd1V/53UOgGo2kbPGToFdqIGxN3ivBggknAUbzb
         57kmGUk4TQ5SQ31Vs04jJDry50avgV4dNAS8OGxU16Z7iKDfdMCbXCBweoxMb+X4nrSg
         nXMrnv0BNcN3SoeSlCC8Audga1rYAMKXOYYEoTm77tDUV35ceIT69nPmb9nZu7noUs+j
         r4aS3h2E0F+rfSwlxq4kzvCWH9nqHM0gllK3iN1Gufs8m2NMN39ndByefa4neTrKRhXT
         WvZQ==
X-Gm-Message-State: AJIora8lgf8QYiVxTI5lnZPHcMHKoymrT8H3yBrw1wTT7XErYLZRoDSS
        wVXb/qXQfz4pUE2ATTQchKtsgw==
X-Google-Smtp-Source: AGRyM1v27GhUxgqPtyg8Cu4ponuVEz4YhpnLDi4l6+vjZ86LHo5Wws49r6JewDbqir0IgLXBgCXSdg==
X-Received: by 2002:a5d:6883:0:b0:21b:9408:8ba0 with SMTP id h3-20020a5d6883000000b0021b94088ba0mr14086640wru.419.1656358903073;
        Mon, 27 Jun 2022 12:41:43 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:42 -0700 (PDT)
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
Subject: [PATCH v2 15/16] riscv: dts: canaan: fix bus {ranges,reg} warnings
Date:   Mon, 27 Jun 2022 20:40:03 +0100
Message-Id: <20220627194003.2395484-16-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
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

The k210 devicetrees warn about missing/empty reg and/or ranges
properties:
arch/riscv/boot/dts/canaan/k210.dtsi:408.22-460.5: Warning (unit_address_vs_reg): /soc/bus@52000000: node has a unit name, but no reg or ranges property
arch/riscv/boot/dts/canaan/k210.dtsi:352.22-406.5: Warning (simple_bus_reg): /soc/bus@50400000: missing or empty reg/ranges property

Add reg and ranges properties that naively cap the buses after the
allocation of their last devices.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 84a7ab363d72..337ce2b879e7 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -163,7 +163,8 @@ apb0: bus@50200000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			regs = <0x50200000 0x200000>;
+			ranges = <0x50200000 0x50200000 0x200000>;
 			clocks = <&sysclk K210_CLK_APB0>;
 
 			gpio1: gpio@50200000 {
@@ -352,7 +353,8 @@ apb1: bus@50400000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			regs = <0x50400000 0x40100>;
+			ranges = <0x50400000 0x50400000 0x40100>;
 			clocks = <&sysclk K210_CLK_APB1>;
 
 			wdt0: watchdog@50400000 {
@@ -407,7 +409,8 @@ apb2: bus@52000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			regs = <0x52000000 0x2000200>;
+			ranges = <0x52000000 0x52000000 0x2000200>;
 			clocks = <&sysclk K210_CLK_APB2>;
 
 			spi0: spi@52000000 {
-- 
2.36.1

