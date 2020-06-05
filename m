Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029401F0035
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFETFQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgFETFP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jun 2020 15:05:15 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80161C08C5C2;
        Fri,  5 Jun 2020 12:05:15 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id v26so1164977oof.7;
        Fri, 05 Jun 2020 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qs9QY5b17T4Lq7hXEjIEKo/PvUm237YC2CaO1E2diG8=;
        b=VFJHWNkvJmJX90giuV61jQ7kiccmFLdEVVLKXu4PxdWYurrYFYiz8lZuwxQWZ0n7Wc
         yqhbt4czbepmBIz1HVMw2BU/xHofgVZYcZm0m0aVuYOen8J93WMKJpwRqnhpQwseb4iP
         nTFIBviunhhNqVx4bUpLna4pcFh6INqif/J0SF3SC+uoE8WFCRj2qscO9r/1vfsmztE3
         o7wjoeaB2YtJa4j9v5pgS8XhcZUXkTN99tYl0TCs6fCTmvGrocK2Mq38lJW1pjm8rDWH
         UN4rar2FhGwgjKTcGmzkuz1GVOX1F7W+0aC+6XQe/gtufZf02nh1NDaa2YE7hsg6x5mN
         130w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qs9QY5b17T4Lq7hXEjIEKo/PvUm237YC2CaO1E2diG8=;
        b=TldVy0fnyLJPvGIiWrUizTZ9+bIIuaPwSkDB8wesOC2zE+HWvyT8R3/28vcFIQriM5
         y1gvwowYvkDK/nqgXiWJNdmszB6z48do0/PXmuPmfhe6r7G4tKsA6CsPxrTO6S/oO8e7
         xQWCBBuZScLEoc617x7ZL3S0lVortx88gdzFwG8jMOM31fnHpsvox2hjSOqUGoKIXtXd
         QxPmP7SMiZcS+OfGoKl+/KXb1H8AyQbhj+XxpQNU8AMtOhbT2xs//V8NwgXPfqB/MEQc
         LgeXS3qYUPTauw81bSvhQMHEXGQO1Xl2RxaSJUjm3fZKPCba1DLTSCtsXEWkMO7aHk9n
         LL5g==
X-Gm-Message-State: AOAM532x30ZhCouE1J8abR888VZie9+WiJSR+1xL3uXZdSLsP2DBjsn0
        iGjX5OG13egn2NvM1TMd9o3fSl6hwWYNvLCz0Kw=
X-Google-Smtp-Source: ABdhPJzW6MwzWQBJS+ULgHeL/swNJlQvIM9FQrimswHIkx7+3vzQXKk44yBXf+5Rg347qSGB5Q2c1/W7jwgGKQuIKYI=
X-Received: by 2002:a4a:98c7:: with SMTP id b7mr8842755ooj.42.1591383914796;
 Fri, 05 Jun 2020 12:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXgSWHd-w_vgv-2mrYwJ2trcdDNniKFGCDGbn3ts-CkjA@mail.gmail.com>
In-Reply-To: <CAMuHMdXgSWHd-w_vgv-2mrYwJ2trcdDNniKFGCDGbn3ts-CkjA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 5 Jun 2020 20:04:48 +0100
Message-ID: <CA+V-a8skA0Gf+bnWJA_TaVsX2uLCrdGqVkZnioW0X0XULVeDrg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: dts: r8a7742-iwg21d-q7: Add support for
 iWave G21D-Q7 board based on RZ/G1H
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

On Fri, Jun 5, 2020 at 1:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add support for iWave RainboW-G21D-Qseven board based on RZ/G1H.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> > @@ -0,0 +1,37 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for the iWave-RZ/G1H Qseven board
> > + *
> > + * Copyright (C) 2020 Renesas Electronics Corp.
> > + */
> > +
> > +/dts-v1/;
> > +#include "r8a7742-iwg21m.dtsi"
> > +
> > +/ {
> > +       model = "iWave Systems RainboW-G21D-Qseven board based on RZ/G1H";
> > +       compatible = "iwave,g21d", "iwave,g21m", "renesas,r8a7742";
> > +
> > +       aliases {
> > +               serial2 = &scifa2;
> > +       };
> > +
> > +       chosen {
> > +               bootargs = "ignore_loglevel root=/dev/mmcblk0p1 rw rootwait";
> > +               stdout-path = "serial2:115200n8";
> > +       };
> > +};
> > +
> > +&pfc {
> > +       scifa2_pins: scifa2 {
> > +               groups = "scifa2_data_c";
>
> Upon second look, I think this group is wrong.  While labeled SCIFA2 in
> the SOM schematics, these signals seem to be connected to a debugging
> interface.
>
> The real UART2 seems to be present on the camera daughter board.  Those
> signals are labeled "SCIFA2" in the camera board schematics, but "SCIF2"
> in the SOM schematics.  This is OK, as "scif2_data" and "scifa2_data"
> share the same pins, so you can choose either SCIF2 or SCIFA2 to drive
> them.
>
> If I'm right, please change the group, and move all serial2 descriptions
> to the camera board DTS.
>
I took a closer look at the schematics, SCIFA2 is connected to the
debug interface similarly on G1M where SCIF0 is connected to the debug
interface.

I will send the user guide privately which should clarify the serial
interfaces on the board.

Cheers,
--Prabhakar


> > +               function = "scifa2";
> > +       };
> > +};
> > +
> > +&scifa2 {
> > +       pinctrl-0 = <&scifa2_pins>;
> > +       pinctrl-names = "default";
> > +
> > +       status = "okay";
> > +};
>
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
