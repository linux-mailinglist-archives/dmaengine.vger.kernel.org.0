Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D245504B5
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiFRMdr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiFRMc0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0314D1DA64
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g4so8782581wrh.11
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xINpJVKkZcc5JKohFXfQpBMJJJBAJkhRdFvXLAdWINc=;
        b=V5PCq8ERofmOM5w5PRA0gL0n8OYBdm40lWb/asUOIntNfey82bGRsIn/7z+pxrNbjf
         4HTP30/j7DUAESFSB807hhF4Bn26V6IuYZIKFHoYEcp2foIsgjbMA8wAurn/dzRXLewU
         52ItLX9xQP38z8uMvLEfCM20A/gU6lUTh3j5F2TLw9cN7r3egdv+mFSv6ttkSKGiktCM
         4cZy3+rmKIWV13Hk4eddQtK9JA4//kbz9TiLmNmn6H/45fTkDeYaDf5zd/9LWbt7E4MA
         qvUYvHicfErpLqf59Y2120u88J/KmXmj/YaQstAYe0YdqaXfHU8uztd1zwCarccd64Pm
         J8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xINpJVKkZcc5JKohFXfQpBMJJJBAJkhRdFvXLAdWINc=;
        b=5gF9DcAa2E+tWKD+Tj8lyWcy1G9yqI/QvJMu9bQKchroTQNLbY6T6rJcrEsZrjuVHO
         UZNlYHj+gvGuEiC/V6o/DsSOVTq9Un3TyH9wovBPu0INjZjxmxMmWIq0AZNbIoaFnQBJ
         I1Cxjvn8DsmW54eqhB5mTbriCy9+2EzTMUhXzrE/FL5pza5o0YmFN0atJAjSKJy7szwv
         wEdtH3VW/7XjTt5IKgoBXjlH4c3FUoc3XdyWK4dX8+F2+ULNkFhtg53ojCK6+gvtAUHQ
         dRGjyTNtBXceyySE/RLqmqBeef1add4RtrRkXePjPQ49ybgXCK1oPcqJNPqsVzbUCY75
         MTgQ==
X-Gm-Message-State: AJIora9HI7/494gK0ESj6Ugn4w5D+zbNK8egjHjkx1zYEZM3ka7SbGZp
        i01IDSV1nWqXWYpGvVndsopgoA==
X-Google-Smtp-Source: AGRyM1v9n76uzuiNQWIsMBMB4JQ7qpatVYHsEQGM4nI7CyfeZc8UgP+B/KjNDavOA6Fd5fJcVw4QCQ==
X-Received: by 2002:a05:6000:1b03:b0:216:43b4:82f1 with SMTP id f3-20020a0560001b0300b0021643b482f1mr13888381wrz.232.1655555541458;
        Sat, 18 Jun 2022 05:32:21 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:20 -0700 (PDT)
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
Subject: [PATCH 12/14] riscv: dts: canaan: use custom compatible for k210 i2s
Date:   Sat, 18 Jun 2022 13:30:34 +0100
Message-Id: <20220618123035.563070-13-mail@conchuod.ie>
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

The devicetrees using the Canaan k210 all have a sound-dai-cells value
of 1, whereas the standard binding example for the DesignWare i2s and
other use cases suggest 0. Use a k210 specific compatible which
supports this difference.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index ef46ddf3c00c..5eb6b69c1170 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -243,7 +243,7 @@ spi2: spi@50240000 {
 			};
 
 			i2s0: i2s@50250000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50250000 0x200>;
 				interrupts = <5>;
 				clocks = <&sysclk K210_CLK_I2S0>;
@@ -252,7 +252,7 @@ i2s0: i2s@50250000 {
 			};
 
 			i2s1: i2s@50260000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50260000 0x200>;
 				interrupts = <6>;
 				clocks = <&sysclk K210_CLK_I2S1>;
@@ -261,7 +261,7 @@ i2s1: i2s@50260000 {
 			};
 
 			i2s2: i2s@50270000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50270000 0x200>;
 				interrupts = <7>;
 				clocks = <&sysclk K210_CLK_I2S2>;
-- 
2.36.1

