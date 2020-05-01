Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD121C0F43
	for <lists+dmaengine@lfdr.de>; Fri,  1 May 2020 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgEAIPc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 May 2020 04:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgEAIPb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 May 2020 04:15:31 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D2C035494;
        Fri,  1 May 2020 01:15:31 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r66so2137485oie.5;
        Fri, 01 May 2020 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67PD+4N6OTeLQfdVEtLP8JgZsz239nlSbqS4Vkr8Dyw=;
        b=kLDxDqPs9e69GaVMoTLIbt5TvwRXfennTnwhak3ZePa6Iw3AisJOdncZZtD5a3g+Iz
         YF/82TokyreEFFn60NinKIGrC0hy0MwKvtZHCwyFrC85V4U2jf51couuP4yBrXn/TQAF
         BLDeJG+s/qPBOdTUrh7x2jcV6xVGy1+FRUZAegp4jwA+7qmCYzGGJ8QUhZmEy9zXIWNo
         4ih3ouFd+mP1Pnx96vHgtEw/r/WzELYEDu6LsgVwa5zBqJ8pQ7R2iM4deN5x8o+RZIB7
         SHmgCDIJ9rKhPh32VzsySTwtLpGAnFTGMg9KICJnlJ2oJyqVxCkOIRyzEPpya8Ja6m5g
         TOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67PD+4N6OTeLQfdVEtLP8JgZsz239nlSbqS4Vkr8Dyw=;
        b=WIcdiBzxE2XIWJHgLQiPkHuf8HZ2i+gNO65heAlRZJ0ehtVSDnJc1EIRnniRNE9Qu8
         kSmYz+7YCEnAzs6NNWrFQ3K+G/I+uyIsZMjhdtKIyBRlSyc6/GIXpg/fLTevNnGTLTjO
         Z+6K70L7iLSyFpRqCtFjvxVBXvfyKgPhTnlSa6FjeXoZi7ST6HQty+6BcJx5NhfFRICE
         cB2HKTZ7p2/QdKPIUht9CJUmlSAILqa+zfw3RUjc/9hc5LU0AaZkUsDjlqge9txCqTn8
         7VgsHabVmM5O77570LF0yHQduswaDz44VpMks1DByPAOskY/uyTLb/iZqDwQMceGaZYq
         p6kA==
X-Gm-Message-State: AGi0PubnK+2j/xYC4PYs+LdIx9FBVkyr7fj/Yzb1znqm+hg1uoUTM2Sd
        6a9xKLByN5Z+N4y0eVG3iPwSVH97FbJZMuaXJzI=
X-Google-Smtp-Source: APiQypIgr6pyF8u5FiRXk8vY7iTPFETvjGXZfjd03HJ7Sse1ymzPq5v9ms+GEMVAq9d2o2xjZGdRdTbFSnFcUHZk+Yk=
X-Received: by 2002:aca:b783:: with SMTP id h125mr2296549oif.62.1588320931075;
 Fri, 01 May 2020 01:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdU90pqCVd=jombH-JMomoCDe1tA8Lq=m0urACK67ZNYuw@mail.gmail.com>
In-Reply-To: <CAMuHMdU90pqCVd=jombH-JMomoCDe1tA8Lq=m0urACK67ZNYuw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 May 2020 09:15:04 +0100
Message-ID: <CA+V-a8sMKWD_FMcEhm-gAOPx2Xdr-4wRdgaiumWLA4vRBUkMMg@mail.gmail.com>
Subject: Re: [PATCH 07/18] ARM: dts: r8a7742: Initial SoC device tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
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

Hi Geert,

Thank you for the review.

On Thu, Apr 30, 2020 at 2:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Basic support for the RZ/G1H (R8A7742) SoC. Added placeholders
> > for the peripherals supported by the SoC which will be filled up
> > by incremental patches.
>
> Please remove the placeholders, as there is nothing that depends on their
> presence.
>
Sure will drop that.

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a7742.dtsi
> > @@ -0,0 +1,715 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for the r8a7742 SoC
> > + *
> > + * Copyright (C) 2020 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/r8a7742-cpg-mssr.h>
> > +#include <dt-bindings/power/r8a7742-sysc.h>
> > +
> > +/ {
> > +       compatible = "renesas,r8a7742";
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       /*
> > +        * The external audio clocks are configured as 0 Hz fixed frequency
> > +        * clocks by default.
> > +        * Boards that provide audio clocks should override them.
> > +        */
> > +       audio_clk_a: audio_clk_a {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <0>;
> > +       };
> > +
> > +       audio_clk_b: audio_clk_b {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <0>;
> > +       };
> > +
> > +       audio_clk_c: audio_clk_c {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <0>;
> > +       };
> > +
> > +       /* External CAN clock */
> > +       can_clk: can {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               /* This value must be overridden by the board. */
> > +               clock-frequency = <0>;
> > +       };
>
> Please drop the audio and CAN clocks for now, as they are not used.
>
OK.

> > +       /* External root clock */
> > +       extal_clk: extal {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               /* This value must be overridden by the board. */
> > +               clock-frequency = <0>;
> > +       };
> > +
> > +       /* External PCIe clock - can be overridden by the board */
> > +       pcie_bus_clk: pcie_bus {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <0>;
> > +       };
>
> Please drop the PCI clock for now, as it is not used.
>
OK

> > +
> > +       /* External SCIF clock */
> > +       scif_clk: scif {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               /* This value must be overridden by the board. */
> > +               clock-frequency = <0>;
> > +       };
>
> This should be used (see below).
>
> > +
> > +       /* External USB clock - can be overridden by the board */
> > +       usb_extal_clk: usb_extal {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <48000000>;
> > +       };
> > +
> > +       cpus {
>
> Please sort nodes by unit-address (if present) per type, or alphabetically.
>
Sure will take care of it.

> > +       soc {
>
> > +               scifa2: serial@e6c60000 {
> > +                       reg = <0 0xe6c60000 0 0x40>;
> > +                       /* placeholder */
> > +               };
>
> I prefer to see a real node for the serial console, so the system can at
> least be boot tested to a console prompt.
> Note that this requires adding a minimal board DTS, too.
>
OK so in that case Ill enable scifa2 and SDHI interface so it can be bootable.

Cheers,
--Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
