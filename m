Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B28955C652
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiF0TlT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 15:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiF0TlS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 15:41:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81AC15A3A
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f190so5764829wma.5
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIsRfhdQMUkP3ryaWA3tv1Mq4oyLE45ECuiu3trpN00=;
        b=B9k2d87DXty7I8E8LE+438emVeZlup2sIzCEsaWM1/EJIZIIppoNtZkCPt2B28TvB1
         fdKtH1VPlJ16WyEMx1xIBZTokOGXYXJAfUsriSAw/CpgnU/+PGc/DWxZ7qOcSPbfaeGR
         rM1s3NrexWkt4JIzMD25YQaH95anZDeTxbULdV8w7TEGkH8RBATcyyLwr/sjLesRwRcy
         0U9RvCUP+tg6PUtyUgz0XndXRLxU9I3XVPAehNBfQE275chl7nDU8XSSIbYZ6ThnJBeb
         RD/AeP34/mdXcNfB37IJm17xr1DNsnhqVVkZHleXi5mgtiwiFAN6khWnFjFTaYy47kFf
         W8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIsRfhdQMUkP3ryaWA3tv1Mq4oyLE45ECuiu3trpN00=;
        b=bQh1CeHiAuo2QaFJrJe7gyDVDmL5PergzhXAgFALz+bfessCouG7DgZfyWVRZiZSc7
         OHpAngFGze5ekF0X6cZyAQoKhZ4IUw3vR7phI2GTpmLaaK0Ojk90bhzdSDcjyO3Bq2aX
         Mk63ZFQvjhSjK9jpnNLhrm5Fd2AVEItzJefUAFwjpfH7h15PXSIsIB1JBkeAOjK0FF21
         M0XNe3iOx10KEeElLpqcaF1F0zcKk1ee4VZ7qQxDSy0TQ/9u++SWukMKHMYQvz2OtdSL
         3iI5cn1D3PKFQwSzsp8TSPsihspx4XmVyJtr/quLG2ZOh7qgnORUuq5w30fL5LOVdihr
         BJhQ==
X-Gm-Message-State: AJIora9JmVmj3R0pIgkTOb1EvB+oJzqHqpQ59oWj4neUispBfaXqSd88
        YhqkrS7c0HDNHITebxxBJy/FtA==
X-Google-Smtp-Source: AGRyM1tvTVBKfByGAdgX8FjccMcjonG0JFKRVmUJw6/qO5b6Hes7fhYw0GHyt2p7jd1AwDC9JUm25Q==
X-Received: by 2002:a05:600c:4f15:b0:39c:7eaf:97e7 with SMTP id l21-20020a05600c4f1500b0039c7eaf97e7mr22218520wmq.199.1656358875365;
        Mon, 27 Jun 2022 12:41:15 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:14 -0700 (PDT)
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
Subject: [PATCH v2 00/16] Canaan devicetree fixes
Date:   Mon, 27 Jun 2022 20:39:48 +0100
Message-Id: <20220627194003.2395484-1-mail@conchuod.ie>
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

For the bindings, I am never sure about which of {unevaluated,additional}
Properties is correct to use, but the if statements in the binding didn't
work with additional so I used unevaluated...

@Mark, for your ASoC binding I was not sure about the properties that I
made depend on the compatible, but I looked in tree and was not able to
find other users to contradict what's in the Canaan devicetrees nor did
I get that much help from their docs.

@Serge, I dropped your R-b since I changed the enum.

@Rob, <N days ago>'s removal of ilitek,ili9341.txt is moved to ths series
since I was editing the dt-schema binding anyway.

Thanks,
Conor.

Changes since v1:
- I added a new dt node & compatible for the SRAM memory controller due
  Damien's wish to preserve the inter-op with U-Boot.
- The dw-apb-ssi binding now uses the default rx/tx widths
- A new patch fixes bus {ranges,reg} warnings
- Rearranged the patches in a slightly more logical order

Conor Dooley (16):
  dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
  dt-bindings: display: panel: allow ilitek,ili9341 in isolation
  ASoC: dt-bindings: convert designware-i2s to dt-schema
  spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width
  dt-bindings: dma: add Canaan k210 to Synopsys DesignWare DMA
  dt-bindings: timer: add Canaan k210 to Synopsys DesignWare timer
  dt-bindings: memory-controllers: add canaan k210 sram controller
  riscv: dts: canaan: fix the k210's memory node.
  riscv: dts: canaan: add a specific compatible for k210's dma
  riscv: dts: canaan: add a specific compatible for k210's timers
  riscv: dts: canaan: fix mmc node names
  riscv: dts: canaan: fix kd233 display spi frequency
  riscv: dts: canaan: use custom compatible for k210 i2s
  riscv: dts: canaan: remove spi-max-frequency from controllers
  riscv: dts: canaan: fix bus {ranges,reg} warnings
  riscv: dts: canaan: build all devicetress if SOC_CANAAN

 .../bindings/display/ilitek,ili9341.txt       | 27 ------
 .../display/panel/ilitek,ili9341.yaml         | 60 ++++++++----
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 35 +++++--
 .../memory-controllers/canaan,k210-sram.yaml  | 53 +++++++++++
 .../bindings/sound/designware-i2s.txt         | 35 -------
 .../bindings/sound/snps,designware-i2s.yaml   | 93 +++++++++++++++++++
 .../bindings/spi/snps,dw-apb-ssi.yaml         |  6 --
 .../bindings/timer/snps,dw-apb-timer.yaml     | 28 ++++--
 arch/riscv/boot/dts/canaan/Makefile           | 10 +-
 arch/riscv/boot/dts/canaan/canaan_kd233.dts   |  4 +-
 arch/riscv/boot/dts/canaan/k210.dtsi          | 38 ++++----
 .../riscv/boot/dts/canaan/sipeed_maix_bit.dts |  2 +-
 .../boot/dts/canaan/sipeed_maix_dock.dts      |  2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts |  2 +-
 .../boot/dts/canaan/sipeed_maixduino.dts      |  2 +-
 15 files changed, 269 insertions(+), 128 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml

-- 
2.36.1

