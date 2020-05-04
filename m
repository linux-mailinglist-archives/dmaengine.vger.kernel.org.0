Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6F1C3B6F
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEDNmT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 09:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726915AbgEDNmS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 09:42:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5226C061A0E;
        Mon,  4 May 2020 06:42:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so6654196oif.2;
        Mon, 04 May 2020 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yo7lqjrRpKwZ/BDaneJUKo3RvZN8MlifDNvVKAk4CjE=;
        b=PdDZKsEBOfRt8wIQ//kOPh6kbtzz7sEyxkmzNU6WgNzHjlIkmK6ZwmCvmWHOVxlve8
         wEBE9482HTapUUXqKsPmR+6LKSRNDKXWqiaWMOXO+3JfJS6t4VH/8IhUDToTm3SX1T2I
         +HhlfuLbB3GnCGwDm36N+7brWKnhuUPqd48100YOvMyjCrZveHD2INxUPgO9ZQDt4nmB
         xPA23ekvcq0Lvm0/89oy4hj4L5+4p60Pll1I2L3p4sGbepbjExnu3STQ39bcPCVdEBJn
         GIa3kwVhp3uNoz78PZ/81SkqEpz23abJdZRpF6V9XwFqTcMJnQu/zKUnOYFDkXbk7svJ
         X8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yo7lqjrRpKwZ/BDaneJUKo3RvZN8MlifDNvVKAk4CjE=;
        b=opD1H1nw+0EpvVGMSdc5dOOE4ZyZrNwb0tzcd/hUsdPFxSqqyVC+96ipC2QxGwGDSH
         HjKiDBGKOzTpZXQ4mMJcQCG+cy2S525B1+ri6Ernl8PqekSt2awbc8XaWK4fVE2ticcY
         pAa2crsJ9313L3d9iW1Pbg+FnTk5aY1OArhMKmDhcTt2MTKUBSEq8urw3yE4OdXSNwV8
         10+VKc4hkFkIyreIOJnpiIsrQhCJeEM/uFkDxMY0py54UoTWS4/b4G34Lkvqjws1LhNC
         JupQgtzUjz1UYz3WiAT+e3hzeLCPGdTxhcFlAcnFrZD1bO11N4/TQGH0s1Hy84xLPlTW
         BZiA==
X-Gm-Message-State: AGi0Pua2dajBjQXR8R4/f0ZKdM5cZdGdJVmtr9hgjNlqbkdX2ZqPNYmE
        7F4IsaL2Rn1s7kh5hCZ2NR+J6glzD2qdaHkmKj4=
X-Google-Smtp-Source: APiQypJHgNbDpSbA0xSTp85gc9Qc7Pc+YWPzbyM+2yuSgkx4lSV8mC7T8pqyRkrc84ajEaWsn122VLgXvcPK1kUETSs=
X-Received: by 2002:a05:6808:5c5:: with SMTP id d5mr9183264oij.8.1588599736738;
 Mon, 04 May 2020 06:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXruqw2pb3pfXNfxNgtc24FmVA376DLBQgubEYSGO7LSA@mail.gmail.com>
In-Reply-To: <CAMuHMdXruqw2pb3pfXNfxNgtc24FmVA376DLBQgubEYSGO7LSA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 May 2020 14:41:50 +0100
Message-ID: <CA+V-a8sEPsDhfEM62MGE1SL8v7ho2bbiB-t0HDYzbnTgVfOoCQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
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

On Mon, May 4, 2020 at 11:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for the update!
>
> On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Renesas RZ/G1H (R8A7742) is pin compatible with R-Car H2 (R8A7790),
> > however it doesn't have several automotive specific peripherals. Add
> > a r8a7790 specific pin groups/functions along with common pin
>
> s/a r8a7790/automotive/?
>
> > groups/functions for supporting both r8a7790 and r8a7742 SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
>
> > @@ -5736,6 +5750,7 @@ static const struct sh_pfc_soc_operations r8a7790_pinmux_ops = {
> >         .pin_to_pocctrl = r8a7790_pin_to_pocctrl,
> >  };
> >
> > +#ifdef CONFIG_PINCTRL_PFC_R8A7790
> >  const struct sh_pfc_soc_info r8a7790_pinmux_info = {
> >         .name = "r8a77900_pfc",
> >         .ops = &r8a7790_pinmux_ops,
> > @@ -5745,13 +5760,38 @@ const struct sh_pfc_soc_info r8a7790_pinmux_info = {
> >
> >         .pins = pinmux_pins,
> >         .nr_pins = ARRAY_SIZE(pinmux_pins),
> > -       .groups = pinmux_groups,
> > -       .nr_groups = ARRAY_SIZE(pinmux_groups),
> > -       .functions = pinmux_functions,
> > -       .nr_functions = ARRAY_SIZE(pinmux_functions),
> > +       .groups = pinmux_groups.common,
> > +       .nr_groups = ARRAY_SIZE(pinmux_groups.common) +
> > +               ARRAY_SIZE(pinmux_groups.automotive),
> > +       .functions = pinmux_functions.common,
> > +       .nr_functions = ARRAY_SIZE(pinmux_functions.common) +
> > +               ARRAY_SIZE(pinmux_functions.automotive),
> > +
> > +       .cfg_regs = pinmux_config_regs,
> > +
> > +       .pinmux_data = pinmux_data,
> > +       .pinmux_data_size = ARRAY_SIZE(pinmux_data),
> > +};
> > +#endif
> > +
> > +#ifdef CONFIG_PINCTRL_PFC_R8A7742
> > +const struct sh_pfc_soc_info r8a7742_pinmux_info = {
> > +       .name = "r8a77420_pfc",
> > +       .ops = &r8a7790_pinmux_ops,
> > +       .unlock_reg = 0xe6060000, /* PMMR */
> > +
> > +       .function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
> > +
> > +       .pins = pinmux_pins,
> > +       .nr_pins = ARRAY_SIZE(pinmux_pins),
> > +       .groups = pinmux_groups.common,
> > +       .nr_groups = ARRAY_SIZE(pinmux_groups.common),
> > +       .functions = pinmux_functions.common,
> > +       .nr_functions = ARRAY_SIZE(pinmux_functions.common),
> >
> >         .cfg_regs = pinmux_config_regs,
> >
> >         .pinmux_data = pinmux_data,
> >         .pinmux_data_size = ARRAY_SIZE(pinmux_data),
> >  };
> > +#endif
>
> The r8a7742 section should be inserted before the r8a7790 section,
> to preserve sort order.
>
> No need to resend, will fix up while applying.
>
Thank you for taking care of it.

Cheers,
--Prabhakar

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in sh-pfc-for-v5.8.
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
