Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD515074C
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBCNcs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 08:32:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38693 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgBCNcs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 08:32:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so10890529oii.5;
        Mon, 03 Feb 2020 05:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8a77+R58LAe2xXbMwZGt5F1KqF29qhEEgIiu5hvCV0=;
        b=IKZjN3TyHGpqzNf2xzFfp2+EkVgfU3rNJIMOXhZLcjIqnKMB/+xsakj5Igol8nv5To
         wFF6YdYXH0JN9YuqQDEnpjH+nrpBq3VujbwL0/IIGBMvJwEy0Uw2i2bb9F1a4fBeDVgf
         HD199wQNEyF6kV6FX/5hZ2TE5bXlUZDAfD1MD+n3EjGr9t9yhADVt6IYq1+2fj34b4Dy
         iXQRuynJpuui0hFdv6fjiSwqLCSyGMmyx/andR9yHBtZAu2IqY8r6y2b1IKW4dB1ZYEp
         XkURyqYnsrjA/n4Js0+C2gDo38lEYc8CbbvFr+yfJhqvwS9Am6YcMniIOOPKUhmVj8cK
         8UgQ==
X-Gm-Message-State: APjAAAWmoe61y0oqFpbP3IOA8qYJxthrK66ZkBnF94BObr7XtM/A+4i3
        8xe+scESk5WSpSFY5ApOlsYLtpXYgi2gSZt/RVM=
X-Google-Smtp-Source: APXvYqyRJiH/1Qcj8aUeQeozGzHCPtNftoPVo7qflSkX4WA3sZYULTlbZxKTd5bnObw2ce+CmK026N210WC5uhGFItw=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr14052076oia.148.1580736767514;
 Mon, 03 Feb 2020 05:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
In-Reply-To: <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Feb 2020 14:32:35 +0100
Message-ID: <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Mon, Feb 3, 2020 at 1:49 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 03/02/2020 13.16, Andy Shevchenko wrote:
> > On Mon, Feb 3, 2020 at 12:59 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 03/02/2020 12.37, Andy Shevchenko wrote:
> >>> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>>> Advise users of dma_request_slave_channel() and
> >>>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> >>>
> >>> How? There are legacy ARM boards you have to care / remove before.
> >>> DMAengine subsystem makes a p*s off decisions
> >>
> >> The dma_slave_map support is added few years back for the legacy ARM
> >> boards, because we do care.
> >> daVinci, OMAP1, pxa, s3cx4xx and even m68k/coldfire moved over.
> >
> > Then why simple not to convert (start converting) those few drivers to
> > new API and simple remove the old one?
>
> _if_ the dma_request_slave_channel_compat() is really falling back after
> dma_request_chan() - this is what it calls first, then it is not a
> simple convert to a new API.
> 1. The arch needs to define the dma_slave_map for the SoC.
> 2. The dma driver needs few lines to add it to DMAengine core (+pdata
> change).
> After this the _compat() can be replaced with dma_request_chan()
>
> In most cases I do not have access to documentation and boards to test.
>
> Looking at the output of 'git grep dma_request_slave_channel_compat':
> drivers/mmc/host/renesas_sdhi_sys_dmac.c
> drivers/spi/spi-pxa2xx-dma.c
> drivers/spi/spi-rspi.c
> drivers/spi/spi-sh-msiof.c
> drivers/tty/serial/8250/8250_dma.c
>
> From these rspi boots only in DT and I'm not sure about the others.

Both rspi and sh-msiof have users on legacy SH (i.e. without DT):

    arch/sh/kernel/cpu/sh4a/setup-sh7757.c: .name   = "rspi",
    arch/sh/boards/mach-ecovec24/setup.c:   .name           = "spi_sh_msiof",

The former seems to be used with drivers/dma/sh/shdmac.c:

    arch/sh/include/cpu-sh4/cpu/sh7757.h:   SHDMA_SLAVE_RSPI_TX,
    arch/sh/include/cpu-sh4/cpu/sh7757.h:   SHDMA_SLAVE_RSPI_RX,
    arch/sh/kernel/cpu/sh4a/setup-sh7757.c:         .slave_id       =
SHDMA_SLAVE_RSPI_TX,
    arch/sh/kernel/cpu/sh4a/setup-sh7757.c:         .slave_id       =
SHDMA_SLAVE_RSPI_RX,

but I have no idea if it still works (and no hardware).

The latter doesn't seem to be used with DMA on ecovec24/sh7724, so
probably we can just drop the _compat() from sh-sh-msiof.c.

BTW, we no longer support non-legacy DMA in drivers/tty/serial/sh-sci.c
(DMA was completely broken in that driver when I added DT suppport),
but it seems it was used at some point on various SH, cfr. e.g.
arch/sh/kernel/cpu/sh4a/setup-sh7724.c still setting up the channels.
Which might be a motivation for just dropping _compat() from spi-rspi.c,
too? ;-)

Anyone who cares for DMA on SuperH?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
