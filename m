Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80706560954
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiF2Sok (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 14:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2Soj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 14:44:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966824BF9
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so179145wmb.3
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujlFidKBYN3+gnt+1Wkvol7kmUwt+TJSsn/V9xvehgY=;
        b=FOsaCOs4FhntcBVLVzvRAs2gDZxoyx3YHWEOhRh45yswt/+jKUwE/J0wNxaZ37V6Uc
         zuxSruVBSYWJDtgARcDoe5RocT823Ey0njk5JlleU3d0qYwcgqh6fodDsvAnnvbvV7Rm
         PY3MlPeU1iH3j3/ZPjhi8DaO/OfWsUbzBea7z+PFQC921e9IBleQBh66fo7u2hKhyarj
         5uvUGrXTVCRqFYQUTptcKkWgRxYwWQNU4qoXt5ehOXJMh8e1gGppyJaQ2eRKydUR+3Ht
         l5p4BtxvL9zi+7zSv32N5RRgYtbMdTeb2fbubnUmSY4CPVXLHJ7NbZqjxV/soVbvVz+r
         yCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujlFidKBYN3+gnt+1Wkvol7kmUwt+TJSsn/V9xvehgY=;
        b=lCdvChRBiHZhl6zYtGYuYLW7OtiXDYrnOXJxqUbcCk+FoOoidGBAZi/syIpjyjrGrP
         doRtCCdLmzO4bBzWzkWXOu3cd4aq7TLUEKsP6j2TVu8Uq+pVWNEBHfreloW1QQA94egq
         BMZFerittgemInNu+weP8WvqplWMWDls+tro7DxebHso75UVCZRkUOPaIQPfwe3MQw+v
         6oXEtNoW+nVdvXMoYb1MJzU5iM4esSqRBGDXh7z5aIM1KrQwBtEYtSHqZcHdn4YxUK7o
         ANItDEb6PhZbQRlnn8Px85b1P5AWLcSU0KDUlovHGe5plvJjam+QqX3BXQw551sKLy+2
         TA/w==
X-Gm-Message-State: AJIora/fip8CudRppHdcL2P+3G4/Z2qRRZ5cHOs0FbA1oWWlKTEvl9US
        bAeov1t/mBCvztf8Zvs2gioBZQ==
X-Google-Smtp-Source: AGRyM1vkI72xwUrVzdm01K07LqtX2m50dz3LRYbM6zcBvoybVSkmTwAhtiBUgec39zvaIkLF0EZJrg==
X-Received: by 2002:a05:600c:3516:b0:39c:8091:31b6 with SMTP id h22-20020a05600c351600b0039c809131b6mr7587210wmq.164.1656528276189;
        Wed, 29 Jun 2022 11:44:36 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:35 -0700 (PDT)
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
Subject: [PATCH v3 00/15] Canaan devicetree fixes
Date:   Wed, 29 Jun 2022 19:43:29 +0100
Message-Id: <20220629184343.3438856-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
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

Hey all,
This series should rid us of dtbs_check errors for the RISC-V Canaan k210
based boards. To make keeping it that way a little easier, I changed the
Canaan devicetree Makefile so that it would build all of the devicetrees
in the directory if SOC_CANAAN.

I *DO NOT* have any Canaan hardware so I have not tested any of this in
action. Since I sent v1, I tried to buy some since it's cheap - but could
out of the limited stockists none seemed to want to deliver to Ireland :(
I based the series on next-20220617.

Thanks,
Conor.

Changes since v2:
- i2s: added clocks maxItems
- dma: unconditionally extended the interrupts & dropped canaan
  compatible
- timer: as per Sergey, split the timer dts nodes in 2 & drop the
  binding patch
- ili9341: add a canaan specific compatible to the binding and dts

Changes since v1:
- I added a new dt node & compatible for the SRAM memory controller due
  Damien's wish to preserve the inter-op with U-Boot.
- The dw-apb-ssi binding now uses the default rx/tx widths
- A new patch fixes bus {ranges,reg} warnings
- Rearranged the patches in a slightly more logical order

Conor Dooley (15):
  dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
  dt-bindings: display: ili9341: document canaan kd233's lcd
  ASoC: dt-bindings: convert designware-i2s to dt-schema
  spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width
  dt-bindings: dma: dw-axi-dmac: extend the number of interrupts
  dt-bindings: memory-controllers: add canaan k210 sram controller
  riscv: dts: canaan: fix the k210's memory node
  riscv: dts: canaan: fix the k210's timer nodes
  riscv: dts: canaan: fix mmc node names
  riscv: dts: canaan: fix kd233 display spi frequency
  riscv: dts: canaan: use custom compatible for k210 i2s
  riscv: dts: canaan: remove spi-max-frequency from controllers
  riscv: dts: canaan: fix bus {ranges,reg} warnings
  riscv: dts: canaan: add specific compatible for kd233's LCD
  riscv: dts: canaan: build all devicetress if SOC_CANAAN

 .../bindings/display/ilitek,ili9341.txt       | 27 ------
 .../display/panel/ilitek,ili9341.yaml         | 49 +++++++---
 .../bindings/dma/snps,dw-axi-dmac.yaml        |  4 +-
 .../memory-controllers/canaan,k210-sram.yaml  | 52 ++++++++++
 .../bindings/sound/designware-i2s.txt         | 35 -------
 .../bindings/sound/snps,designware-i2s.yaml   | 94 +++++++++++++++++++
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  6 --
 arch/riscv/boot/dts/canaan/Makefile           | 10 +-
 arch/riscv/boot/dts/canaan/canaan_kd233.dts   |  6 +-
 arch/riscv/boot/dts/canaan/k210.dtsi          | 76 ++++++++++-----
 .../riscv/boot/dts/canaan/sipeed_maix_bit.dts |  2 +-
 .../boot/dts/canaan/sipeed_maix_dock.dts      |  2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts |  2 +-
 .../boot/dts/canaan/sipeed_maixduino.dts      |  2 +-
 14 files changed, 253 insertions(+), 114 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml


base-commit: 07dc787be2316e243a16a33d0a9b734cd9365bd3
-- 
2.36.1

