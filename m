Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405B575758
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jul 2022 00:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiGNWEM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Jul 2022 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiGNWEK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Jul 2022 18:04:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAA043E71
        for <dmaengine@vger.kernel.org>; Thu, 14 Jul 2022 15:04:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bf13so2762615pgb.11
        for <dmaengine@vger.kernel.org>; Thu, 14 Jul 2022 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8PAchEXjU/hpKREmMLz/eNhHJ5OIRwF0hugCxV08cb8=;
        b=jvbJ4JpBQsHmD4/EIg81fsqcAB85ED0GPvthGUEz8yEFX3y/GzdRGeLqbl80N410j4
         taurkoZFYu+OyFw0WlUzU4PQjp0mizVPNPuL+Lx2bw6aAE6frJ+tKOUPh59CiYVBCveQ
         UKadKyjkBsaggdv/7xVNFktE5PFWF06kcqSo2JQIeJ0lNXana4QZIpZIhPbmR4b9HzKW
         t5o1wx3DW7pbA/RO1ybpmnosuzneJnshWaJ/oRt7jGe5eVIwoZWqvHlSjLadZCVjXBcz
         b0CvjBdIZd0slBHZ9m1bsPqM8BFJuGuE8unE5L+mr84Niu9gKe6xCStd3Y7mFhCQS5mO
         PtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8PAchEXjU/hpKREmMLz/eNhHJ5OIRwF0hugCxV08cb8=;
        b=JeYZml7/pNSheOzOuVbb4eNEY0iremKC/2uTzYMnxPL431G0bhkZ87Jka2H1kWqzQP
         1p8KW0FYE0uZRmQspX8tkWLV5ujHvg7Z2XW0Ph45XqlVZlzf4dKJSL/JO006T7nTIqmF
         2Y3KuSnzWNCXxy0hcfAsIOIg2J5UImKnkSmRSGfrQPHQ8vGcFkQe1Q+dr3NZ0csEQFUY
         wpeYmopeRGJeAEPOwLC5++yxhfZj+ttkH1/+Xm/fnIypD6i7tZoih4yVeKk0gOMUYw+w
         wW0uR6recgZEd44vWiVkkb2xFQgVfWFk3RYiyh6Vrv0pv234aeKlhVoca3XlSUhiLDI/
         AytA==
X-Gm-Message-State: AJIora/ZC3z50EXQJQj6qGlnKvfoMiZQmVGv60UBLXAKm3V5qL2RFZpf
        t1wHaAPC/8FDUfMBsaLvSehlfg==
X-Google-Smtp-Source: AGRyM1t7Xans7iI60RVbBY+W2WdNd4P9acnFda4kCQfiulDuJ6jzcy+AALghFtn/Vk8z0eOi6QXisA==
X-Received: by 2002:a63:ff66:0:b0:412:6f4c:1e11 with SMTP id s38-20020a63ff66000000b004126f4c1e11mr9323094pgk.396.1657836248087;
        Thu, 14 Jul 2022 15:04:08 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b0016ca0fe6df5sm1957872plg.273.2022.07.14.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:04:07 -0700 (PDT)
Date:   Thu, 14 Jul 2022 15:04:07 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Jul 2022 15:01:38 PDT (-0700)
Subject:     Re: [PATCH v5 00/13] Canaan devicetree fixes
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
CC:     airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com,
        fancer.lancer@gmail.com, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        masahiroy@kernel.org, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     mail@conchuod.ie, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Message-ID: <mhng-85044754-c361-40bc-a6a2-7082f35930bb@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 05 Jul 2022 14:52:01 PDT (-0700), mail@conchuod.ie wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Hey all,
> This series should rid us of dtbs_check errors for the RISC-V Canaan k210
> based boards. To make keeping it that way a little easier, I changed the
> Canaan devicetree Makefile so that it would build all of the devicetrees
> in the directory if SOC_CANAAN.
>
> I *DO NOT* have any Canaan hardware so I have not tested any of this in
> action. Since I sent v1, I tried to buy some since it's cheap - but could
> out of the limited stockists none seemed to want to deliver to Ireland :(
> I based the series on next-20220617.
>
> Thanks,
> Conor.
>
> Changes since v4:
> - add Rob's tags from v3
> - sram: rephrase the binding description
> - ASoC: dropped the applied binding
>
> Changes since v3:
> - dts: drop the bogus "regs" property pointed out by Niklas
> - dma/timer: add Serge's reviews (and expand on the dma interrupt
>   description)
> - dts: add Niklas' T-b where I felt it was suitable. lmk if you think it
>   applies more broadly
> - spi: drop the applied spi dt-binding change. Thanks Mark.
>
> Changes since v2:
> - i2s: added clocks maxItems
> - dma: unconditionally extended the interrupts & dropped canaan
>   compatible
> - timer: as per Sergey, split the timer dts nodes in 2 & drop the
>   binding patch
> - ili9341: add a canaan specific compatible to the binding and dts
>
> Changes since v1:
> - I added a new dt node & compatible for the SRAM memory controller due
>   Damien's wish to preserve the inter-op with U-Boot.
> - The dw-apb-ssi binding now uses the default rx/tx widths
> - A new patch fixes bus {ranges,reg} warnings
> - Rearranged the patches in a slightly more logical order
>
> Conor Dooley (13):
>   dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
>   dt-bindings: display: ili9341: document canaan kd233's lcd
>   dt-bindings: dma: dw-axi-dmac: extend the number of interrupts
>   dt-bindings: memory-controllers: add canaan k210 sram controller
>   riscv: dts: canaan: fix the k210's memory node
>   riscv: dts: canaan: fix the k210's timer nodes
>   riscv: dts: canaan: fix mmc node names
>   riscv: dts: canaan: fix kd233 display spi frequency
>   riscv: dts: canaan: use custom compatible for k210 i2s
>   riscv: dts: canaan: remove spi-max-frequency from controllers
>   riscv: dts: canaan: fix bus {ranges,reg} warnings
>   riscv: dts: canaan: add specific compatible for kd233's LCD
>   riscv: dts: canaan: build all devicetress if SOC_CANAAN
>
>  .../bindings/display/ilitek,ili9341.txt       | 27 -------
>  .../display/panel/ilitek,ili9341.yaml         | 49 +++++++++----
>  .../bindings/dma/snps,dw-axi-dmac.yaml        |  7 +-
>  .../memory-controllers/canaan,k210-sram.yaml  | 52 +++++++++++++
>  arch/riscv/boot/dts/canaan/Makefile           | 10 ++-
>  arch/riscv/boot/dts/canaan/canaan_kd233.dts   |  6 +-
>  arch/riscv/boot/dts/canaan/k210.dtsi          | 73 +++++++++++++------
>  .../riscv/boot/dts/canaan/sipeed_maix_bit.dts |  2 +-
>  .../boot/dts/canaan/sipeed_maix_dock.dts      |  2 +-
>  arch/riscv/boot/dts/canaan/sipeed_maix_go.dts |  2 +-
>  .../boot/dts/canaan/sipeed_maixduino.dts      |  2 +-
>  11 files changed, 159 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml

I'm trying to sort out how to merge this one.  I'm not opposed to taking 
it through the RISC-V tree as Rob's reviewed/acked the bindings, but 
just figured I'd say something before putting anything on for-next to 
try and minimize confusion.

Unless I'm missing something it's just patch 3 that's been taken so far, 
via Vinod's tree.  I've dropped that one and put the rest on 
palmer/riscv-canaan_dt_schema, if that looks good then I'll take it into 
riscv/for-next when this loops back to the top of my queue.

Thanks!
