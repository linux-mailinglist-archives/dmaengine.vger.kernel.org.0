Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072E1BF9F3
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgD3Ntb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:49:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39240 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3Nta (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:49:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id m10so5241960oie.6;
        Thu, 30 Apr 2020 06:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjrzO+MFhCxKv5bAtNJEkkZ3+0bygxPZ8Xsyxb6NgPo=;
        b=mDjuEXlnoEV+mzDCJO25nafMr2d5g5Wu+2lZGKiiSoBU55DgFl92jc5iO3aQ85sMG4
         Ti6dd24snDqO9DeWpTHgvwgTIL0QozeW5x2GsAmULoG1TR5tloMQDwX+OlqaydXJDf9a
         jKgzsq/hy1REwN9eQW7JFjooaw93PwV8Jfoi82DOnB4FRBHRTJt3mj896qbnjUcA8ixq
         450qaPfHtlUZOXWKv+Ol4zb+n02v2H2Se+Phq0ixsSjORkZks0nSmzfz5tKJCHO/SMPt
         WDZZkEr++oj1IKlGa0zzj+tR9p7BglaV0yD/dbmmi7qUmUm0RgnaCwxMdt1xhcZWc4g3
         m6CQ==
X-Gm-Message-State: AGi0PubNweEegZZF7/K8BYd2cdBPTaBDfR2EXx63GFPTFyUs4CSsMW+W
        Ulum02gGf/5XAEIl0f/QPUrOzpCNU4uN5G+nhZk=
X-Google-Smtp-Source: APiQypLKYEdDONP0TBzThQv78/9Ygy1b6alSM4Yc0B+LRdJxCQZdxj0F0voJal5X/EWZDKQ3nzYUXD+H8+a8j7LvATM=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr1837989oig.54.1588254569157;
 Thu, 30 Apr 2020 06:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:49:17 +0200
Message-ID: <CAMuHMdU90pqCVd=jombH-JMomoCDe1tA8Lq=m0urACK67ZNYuw@mail.gmail.com>
Subject: Re: [PATCH 07/18] ARM: dts: r8a7742: Initial SoC device tree
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Basic support for the RZ/G1H (R8A7742) SoC. Added placeholders
> for the peripherals supported by the SoC which will be filled up
> by incremental patches.

Please remove the placeholders, as there is nothing that depends on their
presence.

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7742.dtsi
> @@ -0,0 +1,715 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the r8a7742 SoC
> + *
> + * Copyright (C) 2020 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/r8a7742-cpg-mssr.h>
> +#include <dt-bindings/power/r8a7742-sysc.h>
> +
> +/ {
> +       compatible = "renesas,r8a7742";
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       /*
> +        * The external audio clocks are configured as 0 Hz fixed frequency
> +        * clocks by default.
> +        * Boards that provide audio clocks should override them.
> +        */
> +       audio_clk_a: audio_clk_a {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +       };
> +
> +       audio_clk_b: audio_clk_b {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +       };
> +
> +       audio_clk_c: audio_clk_c {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +       };
> +
> +       /* External CAN clock */
> +       can_clk: can {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board. */
> +               clock-frequency = <0>;
> +       };

Please drop the audio and CAN clocks for now, as they are not used.

> +       /* External root clock */
> +       extal_clk: extal {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board. */
> +               clock-frequency = <0>;
> +       };
> +
> +       /* External PCIe clock - can be overridden by the board */
> +       pcie_bus_clk: pcie_bus {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +       };

Please drop the PCI clock for now, as it is not used.

> +
> +       /* External SCIF clock */
> +       scif_clk: scif {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board. */
> +               clock-frequency = <0>;
> +       };

This should be used (see below).

> +
> +       /* External USB clock - can be overridden by the board */
> +       usb_extal_clk: usb_extal {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <48000000>;
> +       };
> +
> +       cpus {

Please sort nodes by unit-address (if present) per type, or alphabetically.

> +       soc {

> +               scifa2: serial@e6c60000 {
> +                       reg = <0 0xe6c60000 0 0x40>;
> +                       /* placeholder */
> +               };

I prefer to see a real node for the serial console, so the system can at
least be boot tested to a console prompt.
Note that this requires adding a minimal board DTS, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
