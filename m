Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1781C36E9
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEDK2x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 06:28:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39690 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgEDK2w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 06:28:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so8434948otf.6;
        Mon, 04 May 2020 03:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKv7KTVNCY3qf6SaspevLCl67DbFuwIyzQmXuV5CMJc=;
        b=I0AYMI1tSLGPGJ99UCVJrMv9onRfDM/2HEphRDWFaK6THqZqtqFRiQKKFbafIwoUE4
         ceb1aUiWmmnrllmswH6FWB3i/vxU66US9M8eg7wYgwM/r7I4RScB6zqwOBu+LSVGZ7bY
         PQly7oB8hF4HLCrjx1xWCfRKA6iCC0u9iqqDDpO9LF4twwHwfGS8S70/mp6upU9jrVtn
         GpkFIWMUcyTxQNKdzEJ+4eCtCCocEaWDZbqjyD1Ik4f3cgtmpdsQDyy3/INhPIir8RB9
         G55HyGfgsbRoSYzaWgwljDLDYP8qomIAJdtT+9VlHvKiYRsDAoN9TxENRWA/fmLt+yz1
         f2sw==
X-Gm-Message-State: AGi0PuYTZo6wguH+j+reyR1uo+jvFiHeIxi5I/yS7mqoieMwxSZTKY/w
        E3FtBsD7RWvPLp/axkvlezE3RFFhppvY43fzUk0=
X-Google-Smtp-Source: APiQypJ8AcvgPl+s7QGZB7Ujkmmo3ahQcK1m2igoHJ4xdGevo7ZCWpn/ZrzgicKDMl5r59Zg5PLowTSrcLvug8HlKd4=
X-Received: by 2002:a9d:564:: with SMTP id 91mr13728187otw.250.1588588131266;
 Mon, 04 May 2020 03:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 12:28:39 +0200
Message-ID: <CAMuHMdW=njc2Vvu+7WHgikWOMtWCWTMmxeYLWLP0Z1TyStiaFg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ARM: dts: r8a7742: Initial SoC device tree
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Prabhakar,

On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> The initial R8A7742 SoC device tree including CPU[0-8], PMU, PFC,
> CPG, RST, SYSC, ICRAM[0-2], SCIFA2, MMC1, DMAC[0-1], GIC, PRR, timer
> and the required clock descriptions.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7742.dtsi

> +               icram2: sram@e6300000 {
> +                       compatible = "mmio-sram";
> +                       reg = <0 0xe6300000 0 0x40000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0 0xe6300000 0x40000>;
> +               };
> +
> +               scifa2: serial@e6c60000 {
> +                       compatible = "renesas,scifa-r8a7742",
> +                                    "renesas,rcar-gen2-scifa", "renesas,scifa";
> +                       reg = <0 0xe6c60000 0 0x40>;
> +                       interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 202>;
> +                       clock-names = "fck";
> +                       dmas = <&dmac0 0x27>, <&dmac0 0x28>,
> +                              <&dmac1 0x27>, <&dmac1 0x28>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
> +                       resets = <&cpg 202>;
> +                       status = "disabled";
> +               };
> +
> +               mmcif1: mmc@ee220000 {
> +                       compatible = "renesas,mmcif-r8a7742",
> +                                    "renesas,sh-mmcif";
> +                       reg = <0 0xee220000 0 0x80>;
> +                       interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 305>;
> +                       dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
> +                              <&dmac1 0xe1>, <&dmac1 0xe2>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
> +                       resets = <&cpg 305>;
> +                       reg-io-width = <4>;
> +                       status = "disabled";
> +                       max-frequency = <97500000>;
> +               };
> +
> +               dmac0: dma-controller@e6700000 {
> +                       compatible = "renesas,dmac-r8a7742",
> +                                    "renesas,rcar-dmac";
> +                       reg = <0 0xe6700000 0 0x20000>;
> +                       interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "error",
> +                                         "ch0", "ch1", "ch2", "ch3",
> +                                         "ch4", "ch5", "ch6", "ch7",
> +                                         "ch8", "ch9", "ch10", "ch11",
> +                                         "ch12", "ch13", "ch14";
> +                       clocks = <&cpg CPG_MOD 219>;
> +                       clock-names = "fck";
> +                       power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
> +                       resets = <&cpg 219>;
> +                       #dma-cells = <1>;
> +                       dma-channels = <15>;
> +               };
> +
> +               dmac1: dma-controller@e6720000 {
> +                       compatible = "renesas,dmac-r8a7742",
> +                                    "renesas,rcar-dmac";
> +                       reg = <0 0xe6720000 0 0x20000>;
> +                       interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "error",
> +                                         "ch0", "ch1", "ch2", "ch3",
> +                                         "ch4", "ch5", "ch6", "ch7",
> +                                         "ch8", "ch9", "ch10", "ch11",
> +                                         "ch12", "ch13", "ch14";
> +                       clocks = <&cpg CPG_MOD 218>;
> +                       clock-names = "fck";
> +                       power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
> +                       resets = <&cpg 218>;
> +                       #dma-cells = <1>;
> +                       dma-channels = <15>;
> +               };

To preserve sort order, the DMAC nodes should be moved up.
No need to resend, will fix up while applying.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
