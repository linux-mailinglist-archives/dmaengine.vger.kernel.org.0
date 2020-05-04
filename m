Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA01C3CDA
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgEDOUp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEDOUo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 10:20:44 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECAEC061A0E;
        Mon,  4 May 2020 07:20:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i13so6729055oie.9;
        Mon, 04 May 2020 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dFZhnDWS7Tizxu2OEo0qs58jGqBEpce/n1a/aPfM+M=;
        b=gmyLFN/nYCg1n7UscEV+5jC9u6q5GYu3AHv3+aU7Fjjw9dTfo4ARG/9m1ro0M5MMEi
         a6bbASvcxqmY5LPFOrLCWtelWFHBnP8G3vtjnzAvkga9NRi0IL3PeSl35vT8irzanSP7
         X+adc0ebp2xGHjsH9mb4tf/IzHTWObBo2I2ZP2UjPtUS/4L3KuKXlSnSPiFyQ8Tu9e/Q
         pudQRvc7xxjSRZOVRJk+Pic34GazJCjrGWIT/nmq0uzN7hZoiMNg9CHV+yOCxHj0ykdo
         jdd5G56/uWvfqtOWfoDIRb3/KOQuKt2WJCeEQCsPAViF+sp9GuGwQQNKwS+CjKNeyMSA
         Qqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dFZhnDWS7Tizxu2OEo0qs58jGqBEpce/n1a/aPfM+M=;
        b=sRBmZzi/tNu6/JlWqS5W/yZS+/oqRUqHThbrOoR9GtEWGJHuyKQj0uV2podLIFl54k
         RKEXCC9KbTWgAX4VuQy00LuQThFAE2cnWClq5YNSuGFN1tqeqacZsxC/Gl2uAlY1V7W1
         WSry1yfnGDuaEyv9h074zLh6ZbrLjGwnsKthNoi3XlPFa2YCCFn2ngTV5vGr5XTDzefI
         7/F8lOL4xH8Pc4S7j7DTn48tkybjqkPQdrWxZ3Z7DYBv+HA3F2REMjv98yAft7opRvQ1
         IbtL3MqHnBMn+GbZJQKl9BMi/Lsvo3lGfngvL9LDIF384T7L8tb10/RCxH3fVVQ5xdyl
         OVgg==
X-Gm-Message-State: AGi0PuaVKdTFHfZCW8jBM5Q8Ax3InWv/srlPCuX/FC+GFvMmPJqPYw2R
        6yJrqAe9OFMgnmTtanuoSycgN1jEa5m5kll0LIU=
X-Google-Smtp-Source: APiQypJJNLmN9IdSWfIrtoFcumitqYdjMlQ/xm3GpcuUQNKTnSGBHyQMIaQNzSPDuLIDwjYVOaixm5qG87Uq7o+MR6w=
X-Received: by 2002:aca:b783:: with SMTP id h125mr9088932oif.62.1588602043656;
 Mon, 04 May 2020 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXv1kW4BeEt4tGBwp9gmRUOJ1X_7-Gu2h=m+On8+RjZ2A@mail.gmail.com>
In-Reply-To: <CAMuHMdXv1kW4BeEt4tGBwp9gmRUOJ1X_7-Gu2h=m+On8+RjZ2A@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 May 2020 15:20:17 +0100
Message-ID: <CA+V-a8vqC90BgGjZKcMArOf4-F9PS4jXoVQbNQ81V6p4knsx=A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H
 Qseven SOM
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thank you for the review.

On Mon, May 4, 2020 at 2:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Sun, May 3, 2020 at 11:48 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add support for iWave RZ/G1H Qseven System On Module.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for the iWave RZ/G1H Qseven SOM
> > + *
> > + * Copyright (C) 2020 Renesas Electronics Corp.
> > + */
> > +
> > +#include "r8a7742.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +       compatible = "iwave,g21m", "renesas,r8a7742";
> > +
> > +       memory@40000000 {
> > +               device_type = "memory";
> > +               reg = <0 0x40000000 0 0x40000000>;
> > +       };
> > +
> > +       memory@200000000 {
> > +               device_type = "memory";
> > +               reg = <2 0x00000000 0 0x20000000>;
>
> According to the schematics, the second bank is also 1 GiB, so the
> reg length should be 0x40000000.
>
Agreed will fix that.

> > +       };
>
> > +&pfc {
> > +       mmc1_pins: mmc1 {
> > +               groups = "mmc1_data4", "mmc1_ctrl";
> > +               function = "mmc1";
> > +       };
> > +};
> > +
> > +&mmcif1 {
> > +       pinctrl-0 = <&mmc1_pins>;
> > +       pinctrl-names = "default";
> > +
> > +       vmmc-supply = <&reg_3p3v>;
> > +       bus-width = <4>;
> > +       non-removable;
> > +       status = "okay";
> > +};
>
> The eMMC has an 8-bit data path.  Is there any specific reason you use
> bus-width = <4>, and the "mmc1_data4" pin group?
>
MMC1_DATA7 is shared with VI1_CLK, so instead of limiting to only one
device when using 8-bit just switched to 4bit mode so that both the
peripherals can be used.

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
