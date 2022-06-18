Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0041855048E
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiFRMc2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiFRMcX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C121E3D2
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so3546174wms.3
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCkvd1rq89W/6SrEihtrV93zPOh8bp4EvU/AesUDp5c=;
        b=aHjW5VkiLOJuMraDAkim12MSrvxYtcnkUa+6XugCv/phW+l8JDcGEqmFOjtiPLghjo
         iDjWHIMizesLDejsxE38i+OtY7WWj3x11BBfb0BRUdXpK4pu3MkmLgAa5dvPF4Y79U7L
         UBw2DK7UQ4hfNaYZxuStYUEYkp5i7TbAmelLvl2Ui/7w8TkzozVKIQaX5ZY57N429Zl0
         xgWDMpxIW3ayHXhWUHqQjQuXwVBfy/ElkaLVd2hLdCEkKi4zy0N/eTrZ8OwQ4dltk65u
         J4kCuiGGXyE3akVz8UzRk2HQ3opmwMzKwoXk0plpXwMqySPXygB+SYToa/Kb5HF8Q3nD
         BP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCkvd1rq89W/6SrEihtrV93zPOh8bp4EvU/AesUDp5c=;
        b=t4VZDipjhe9jVOda75uk83VHQ9fp2euwXi14tnTvN3EJE4C+QnEcar+FGSr30OlzD/
         12Nu/njhBTql86S3Oq99vAnDYCyGHpaeaTScfhYbWQb7EwKtZuM0JW8SYQKDEWMqPAWz
         GZ5d6DEWRsQlW/uXAu+0DnzNHTkIuNbYt/nWs6gU8Tin/hiBTEUi9lFAu1C8qJPJ3rYy
         02McuwsBzH6312npsuSsHsMJYu2fJ0IavRkFhgygw9vn7lnGHVmvoWm/tzKHDN0NMJX2
         8MPWY/82fwydaJK+wXFvRKjMwe/TZn9TBOhZhh98UimvxnyqwKDg+hBqRiALYMqIYhqD
         zWkg==
X-Gm-Message-State: AJIora9Ghe/+LHPksDrwhdLwF9MxBmtzR75oQtAHV1lbpdZvXw5oMosO
        PNtNM45aO9DfleR3Ja79dcNWiQ==
X-Google-Smtp-Source: AGRyM1s4BntBiZAtPtsynxF7uq+efiHJQnjp6f4ztefKsZzCsrAEC1MDiI+wsPar7tnOzz3WAfpCIg==
X-Received: by 2002:a05:600c:1906:b0:39c:8573:f330 with SMTP id j6-20020a05600c190600b0039c8573f330mr15063952wmq.5.1655555533520;
        Sat, 18 Jun 2022 05:32:13 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:12 -0700 (PDT)
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
Subject: [PATCH 08/14] riscv: dts: canaan: add a specific compatible for k210's dma
Date:   Sat, 18 Jun 2022 13:30:30 +0100
Message-Id: <20220618123035.563070-9-mail@conchuod.ie>
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

The DMAC on the k210 has a non standard interrupt configuration, which
leads to dtbs_check warnings:

k210_generic.dtb: dma-controller@50000000: interrupts: [[27], [28], [29], [30], [31], [32]] is too long
From schema: linux/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml

Update the binding to use a custom compatible to avoid the warning.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 287ea6eebe47..314f6da5d7f6 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -135,7 +135,7 @@ gpio0: gpio-controller@38001000 {
 		};
 
 		dmac0: dma-controller@50000000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "canaan,k210-axi-dma", "snps,axi-dma-1.01a";
 			reg = <0x50000000 0x1000>;
 			interrupts = <27>, <28>, <29>, <30>, <31>, <32>;
 			#dma-cells = <1>;
-- 
2.36.1

