Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936EB5504A6
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiFRMch (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiFRMcW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF21DA60
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c21so8820614wrb.1
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmSWtWUd+mMy8ZYoZTgQjYDztLIGNDdvta+tk149+dY=;
        b=dM4LDKg5XtY0Inv2LgZSsQ50IPuzGfCzEsvHlFQ/2NLIm/6++fbLLGSB9koJgwMTjp
         07IF9XMy4P4HaeMA1yfSnaPY3CYXQ+u0Kv6ZrDa4GjATk93Wx2p5DeaQw29BenmArCiz
         I6simFjZ6ZTWhMpFS4z5vR9LZUvOOE+DqLAunuoSePBDY5dNABj/iCXgooJ7JUM1Gx2w
         oJTVRWFtg+XkkdFP3+9IwXZt69jucggKlNwGuChB7WxmXKdl5k9lj8f8ITLIpfckoFQS
         YaBPUVjvUVp7mpO9D9wZzFoEi6tceysbIOAoKo4R7lpk7QqiW4+Bkh5CqE2X/nDML5P4
         Wj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmSWtWUd+mMy8ZYoZTgQjYDztLIGNDdvta+tk149+dY=;
        b=nQGNx6xusmIC6sbQfR5tJQDNozgFybJCv9ONZnpLnMzE12O6yD+qrF/KwmB5zPBdB7
         ytaB6em8i9soKtuxxMcqThbC2H5AnrCCdAuzAbRsgqUoytfCXxj+NQ+aCMZ+ZZ+QnKLh
         ZbSRbFerSXT1hpopcwl2GXggy+WVyj4Bb97piw0YHDmhuQSi/K4xLq6c+w/3dM6h/KFA
         oPcTKpoh4CZb9GapN2UcRI3fGyrQCSU1wVLzfPizOn8SHDyPnlWQqCn9xcazQzorttsy
         Tv8hqh5fc3R7uW1SBvp700bvSqT75HqJ/fkDGvVgenG3WYZDW/g9lSNCa7VippMx/Sgg
         kl/A==
X-Gm-Message-State: AJIora+Nkf9E0zrfLxdqNQrQgx3MBt6qZf+zZbgZ4TpovO+CVql1FF3t
        MW1R24ZNhzmw0PtZEXjIYzDDAw==
X-Google-Smtp-Source: AGRyM1sfPQ5XTH8REWSlcNVbh+KVLu6pjXz8b6gchhSbSGxDuCamFh0CMH0mba5q/rzWCUN22eIJUA==
X-Received: by 2002:a05:6000:1b03:b0:210:3372:2bd9 with SMTP id f3-20020a0560001b0300b0021033722bd9mr14215037wrz.704.1655555531747;
        Sat, 18 Jun 2022 05:32:11 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:11 -0700 (PDT)
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
Subject: [PATCH 07/14] riscv: dts: canaan: fix the k210's memory node
Date:   Sat, 18 Jun 2022 13:30:29 +0100
Message-Id: <20220618123035.563070-8-mail@conchuod.ie>
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

The k210 memory node has a compatible string that does not match with
any driver or dt-binding & has several non standard properties.
Replace the reg names with a comment and delete the rest.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 44d338514761..287ea6eebe47 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -69,15 +69,9 @@ cpu1_intc: interrupt-controller {
 
 	sram: memory@80000000 {
 		device_type = "memory";
-		compatible = "canaan,k210-sram";
 		reg = <0x80000000 0x400000>,
 		      <0x80400000 0x200000>,
 		      <0x80600000 0x200000>;
-		reg-names = "sram0", "sram1", "aisram";
-		clocks = <&sysclk K210_CLK_SRAM0>,
-			 <&sysclk K210_CLK_SRAM1>,
-			 <&sysclk K210_CLK_AI>;
-		clock-names = "sram0", "sram1", "aisram";
 	};
 
 	clocks {
-- 
2.36.1

