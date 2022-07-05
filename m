Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1B5679B0
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiGEVw5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiGEVws (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:52:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94119192A2
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cl1so19400340wrb.4
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16q/8fFGCPAcRAarL+3aLoNygoSrExqmYVpC1bRjl2o=;
        b=YYFaUee7gy1W5prTWT0BCaYi4Agi4K/fZPz3HzSu/Bx3zMLRlN6iPr3QbkHb8nmHa1
         OB4MbShSJ6pV3jSxnG3fgJKUgLhGQ98A6yUS6Hr1g5f9oo/CqzYerhyHeDMtY/8/V6h2
         SNh8FrwHsBKxWQIetyAjLLN19P4VrMSyseVBVDmhxS7g75q2gULyOALP1sxruDhkHN2N
         35BCcbcEZn0ZTeLrU+J2Zfur2nhAuZcdZvyFXbL1ZSzObDc51rZ3/tBedaYwAr+Csgr2
         2BkluY0+l9Tx3ndW35NGgpStoxtOrR+02ao1YhadHBLpWQbGp6cMjwnv6DxdGW1rVIR0
         V4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16q/8fFGCPAcRAarL+3aLoNygoSrExqmYVpC1bRjl2o=;
        b=D03pWbD/1VF3gjFllYpKCZVm91gk/ojiCyhcgWaM5ZruowtkeC0lkH5RJ2ukSpUZoY
         o1fAhRzqAsK7zIeWBKkuwnGsjjbpK2AGuA0qtKFz167xW6B0NsiE+E77mt8KsN4YoVus
         5JAWUK/GsIEyk3dFz47a0/DeSQSnJmRuoaqH4tSvq2Q14h3u7dW1so60Ukm3BsiCeRyE
         BlXZ1hjeDqnk5H6tr77GKSktnzxuL38oV0yL5MQNf16mcS/Tgnxtl8znh3T6IfK4VBxr
         1ay5HYaNidQVEMsKP2d1xtslrDjLnVtpPONZxh7eOEd14RnuErMDxwKhZgahtlWYK+BD
         K+Ag==
X-Gm-Message-State: AJIora+6+7wqKGwSAtPV4uW+3EIlkuh0sjU/PDKTfI6fsc6x1wZrR9Q3
        lWdA3TWf7h7vG7mHVEde5QHNGg==
X-Google-Smtp-Source: AGRyM1t6QNd/sm2WCxNG6Wr6I2YHwVTbjh9TXka92SSnVrAIhc+jsCS3/FhjvWlhLqMVSAqFGD6QKg==
X-Received: by 2002:a05:6000:381:b0:21b:9a20:6543 with SMTP id u1-20020a056000038100b0021b9a206543mr32493151wrf.127.1657057955085;
        Tue, 05 Jul 2022 14:52:35 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:34 -0700 (PDT)
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
Subject: [PATCH v5 08/13] riscv: dts: canaan: fix kd233 display spi frequency
Date:   Tue,  5 Jul 2022 22:52:09 +0100
Message-Id: <20220705215213.1802496-9-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
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

The binding for the ili9341 specifies a const spi-max-frequency of 10
MHz but the kd233 devicetree entry has it listed at 15 Mhz.
Align the devicetree with the value in the binding.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 40992d495aa8..4a540158f287 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -130,7 +130,7 @@ panel@0 {
 		compatible = "ilitek,ili9341";
 		reg = <0>;
 		dc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
-		spi-max-frequency = <15000000>;
+		spi-max-frequency = <10000000>;
 		status = "disabled";
 	};
 };
-- 
2.37.0

