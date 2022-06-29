Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9B5609AB
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiF2SpK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiF2SpE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 14:45:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498472A952
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i1so19294735wrb.11
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNX3NBBxUOgIEO6d1lHfUfaMyrVEXszXHZidwPOOZLs=;
        b=fJt0TNmcrxv1196YlKy+XtUiL3qH5Bi1DNi6jONPKjO1mK09TYQ50TbpaXiImC6SPX
         wM/EbNLO8vHZI1fRyjVLA9dMDJM2IzSkNGcYb8su5xVZty48AsSus2QsfnunOQseVfNv
         26Lk9YDEyevHgKK71onh/RYN+LNvQK+0n0ZCaKB/sLR6D7gNVndjsNGmzxOhOAuKtXzY
         V4yiWGtn92sMUCDzfN2CyLwP/OZPoElHkS8QhNADh2m9p6pJlyepKXQV1JHQMFLnVYJj
         RoZPOLARyx46D/J6WfBlen6szXY1KjfBMMjmyqEFn+lQH6ghSIH4H0/0xAsvL1vPoosm
         JgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNX3NBBxUOgIEO6d1lHfUfaMyrVEXszXHZidwPOOZLs=;
        b=PEHI9RFnzII0ACD0hts0ub2Zv7XRwy9ZcaGZwbKoxVcQFW2NqWHR55jIMSnLxoUFEc
         ZR5UUJerqJeX1adRaCaTHsQpeyYaYLxgLvwhnWvms6wXAmBiEl0PF9LejbXXvGF5YdAp
         nnymv5dtTlTYqMK+YxzDoC7/xzWv7HxRyokK2NtOvcuxHPC21FlAXIzio/q1ntFLGvkK
         WiUrz2CKtHV0dj6Afx3fN06sWhxCDklw+ga9jKdqBXBdrIoCsCIx4PRRJAPfk7w4qGUj
         zjVUKC5slPM4PyBJooxQljv6MDAEn7jItbriOXJ9p+ceFKGSeq1xgpQGa/w22gnMv43z
         kPqw==
X-Gm-Message-State: AJIora8x1bWEUzDuhEdyTn9JrZC29zUybh+WWE7TW1lx/lDJowwChxSD
        26n11PTUlnAHJTF8AGR0XnZFFQ==
X-Google-Smtp-Source: AGRyM1slaB4pDiCS7kZfgH/dw/atIFKm5WMyJcMLooWgGiA6eNc01E7pK2ozv/LYUkHNxKQ7FdQ+ug==
X-Received: by 2002:a5d:518f:0:b0:21b:8a8c:ce4 with SMTP id k15-20020a5d518f000000b0021b8a8c0ce4mr4710896wrv.614.1656528295858;
        Wed, 29 Jun 2022 11:44:55 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:55 -0700 (PDT)
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
Subject: [PATCH v3 12/15] riscv: dts: canaan: remove spi-max-frequency from controllers
Date:   Wed, 29 Jun 2022 19:43:41 +0100
Message-Id: <20220629184343.3438856-13-mail@conchuod.ie>
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

spi-max-frequency is a device, not a controller  property and should be
removed.

Link: https://lore.kernel.org/lkml/20220526014141.2872567-1-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 900dc629a945..948dc235e39d 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -451,7 +451,6 @@ spi0: spi@52000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI0>;
 				reset-names = "spi";
-				spi-max-frequency = <25000000>;
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
@@ -467,7 +466,6 @@ spi1: spi@53000000 {
 				clock-names = "ssi_clk", "pclk";
 				resets = <&sysrst K210_RST_SPI1>;
 				reset-names = "spi";
-				spi-max-frequency = <25000000>;
 				num-cs = <4>;
 				reg-io-width = <4>;
 			};
@@ -483,8 +481,7 @@ spi3: spi@54000000 {
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

