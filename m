Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACA1C3D06
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEDO3m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 10:29:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35423 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgEDO3m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 10:29:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id k110so4504853otc.2;
        Mon, 04 May 2020 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qmNWbZEWGK3APAzYwIeRF7N4Ey8Oknk1ZvcU1u1ZqU=;
        b=N1oXyP7br7VE+24jMnpp//tEsI2I9XMyipiwrWkWyV0WlxffaFdZWcngd8JXS1pXP4
         /6ighEpGKEP276G12e4Pu0JNaLUnWjHgTK6cbnaqvYkYNnROtka1WSFPI+u631GQpSWo
         j/qX4TSs7AWDXwKmOOK5MCtz/OcYRe+prCpD9/QFZNd7+gcGnJfVIwENZ2Sg00uMeVzh
         lZ2mBJ8OxZtgGMNJHj4DQxSq6Txc+7+ppz3xhoAhNlsx5Rf6YAVaxwZ/MqKzJsuEYJNX
         5GGcBolqiK1c5HVmUvZ5chSXUv+OKPPXa1+Y5KZYL1/eEbU27l6ZKz1WvUwwQjtKjDBV
         IvvA==
X-Gm-Message-State: AGi0PuYY/E3WPj86DYzI8Lv6+XTmM+aw9qLH865psgy4eTdcKEb2H2hi
        npNwSZIpNgFJft8rgPTu77NOvfq5q98kkxjqZbo=
X-Google-Smtp-Source: APiQypIl5oeOYwC1jEI/m9PhRtWzOpl25bOP4xHlOC6xhIPb9atAy1P1nyb7qKk0U0HPJufqUAievgfEuM+jpmQcYow=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr14016322otm.145.1588602579133;
 Mon, 04 May 2020 07:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXv1kW4BeEt4tGBwp9gmRUOJ1X_7-Gu2h=m+On8+RjZ2A@mail.gmail.com> <CA+V-a8vqC90BgGjZKcMArOf4-F9PS4jXoVQbNQ81V6p4knsx=A@mail.gmail.com>
In-Reply-To: <CA+V-a8vqC90BgGjZKcMArOf4-F9PS4jXoVQbNQ81V6p4knsx=A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 16:29:28 +0200
Message-ID: <CAMuHMdX6_zOVXStgRRCYonZF2XUowsm0T=3L3+xmqhyGCqMi6Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H
 Qseven SOM
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Mon, May 4, 2020 at 4:20 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, May 4, 2020 at 2:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, May 3, 2020 at 11:48 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add support for iWave RZ/G1H Qseven System On Module.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
> > > @@ -0,0 +1,53 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Device Tree Source for the iWave RZ/G1H Qseven SOM
> > > + *
> > > + * Copyright (C) 2020 Renesas Electronics Corp.
> > > + */
> > > +
> > > +#include "r8a7742.dtsi"
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +
> > > +/ {
> > > +       compatible = "iwave,g21m", "renesas,r8a7742";
> > > +
> > > +       memory@40000000 {
> > > +               device_type = "memory";
> > > +               reg = <0 0x40000000 0 0x40000000>;
> > > +       };
> > > +
> > > +       memory@200000000 {
> > > +               device_type = "memory";
> > > +               reg = <2 0x00000000 0 0x20000000>;
> >
> > According to the schematics, the second bank is also 1 GiB, so the
> > reg length should be 0x40000000.
> >
> Agreed will fix that.

Thanks for the confirmation.  I can fix that while applying.

> > > +       };
> >
> > > +&pfc {
> > > +       mmc1_pins: mmc1 {
> > > +               groups = "mmc1_data4", "mmc1_ctrl";
> > > +               function = "mmc1";
> > > +       };
> > > +};
> > > +
> > > +&mmcif1 {
> > > +       pinctrl-0 = <&mmc1_pins>;
> > > +       pinctrl-names = "default";
> > > +
> > > +       vmmc-supply = <&reg_3p3v>;
> > > +       bus-width = <4>;
> > > +       non-removable;
> > > +       status = "okay";
> > > +};
> >
> > The eMMC has an 8-bit data path.  Is there any specific reason you use
> > bus-width = <4>, and the "mmc1_data4" pin group?
> >
> MMC1_DATA7 is shared with VI1_CLK, so instead of limiting to only one
> device when using 8-bit just switched to 4bit mode so that both the
> peripherals can be used.

OK.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.8 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
