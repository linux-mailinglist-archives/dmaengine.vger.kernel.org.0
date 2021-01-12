Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEF2F34BD
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 16:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbhALPzI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 10:55:08 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35714 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbhALPzI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 10:55:08 -0500
Received: by mail-oi1-f180.google.com with SMTP id s2so2802771oij.2;
        Tue, 12 Jan 2021 07:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U6LVScLXHoB8xUsah24PjHQDUF29LidNJfNcbgchho=;
        b=dSsU3RAgRRnCzBs0yReaC0YK24/ywxRO+0sIUrpkJNsdGjaSxxbVwEPGp4z6FYRiez
         J8Yloe1PagdlbvptQp7d6+VxcjqByZtKjvJLafYt2Rt/wqBcfTZG56d9spam3viXipg6
         rkKTLBBOte9CDVRGKFcA2tNoXfcrPOUy2L4eND4mLGO0LEmVv0SZChtodPw3GQeocsJ6
         Mjo3XS/W9h4iTlb8ih489kPkgdzng0c4ZE8C8h97TkyW1L3vz/u4fdOvaalJySoEiL6+
         DJZXMSuboahvOMXbo7ogM6EnQpxgT9DsTFzDd7Q7JjwEFaSVAGFn632hQfkhtw2KOA6u
         gDcw==
X-Gm-Message-State: AOAM532UewWdutu+yS7MlrlYWqynR4OmVIk3kyG/kF49QpdxYys8vcYA
        g+ZUb1ojGvFok+u2PpcMU1VdKo+Sn79AQQqjaNAlQOs3L8g=
X-Google-Smtp-Source: ABdhPJyAzJf0gkgRoLKOXbFskQnHfxoIk9N6v//40rMfC3cuDzc/LchqJZHq4nmROg/z9MHGEqpBkxH6sZbvyUmTGNs=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr2678560oia.148.1610466867451;
 Tue, 12 Jan 2021 07:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-5-geert+renesas@glider.be> <20210112103648.GL2771@vkoul-mobl>
In-Reply-To: <20210112103648.GL2771@vkoul-mobl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 16:54:16 +0100
Message-ID: <CAMuHMdUiQkP4W17ovot29NGRPa0rYgpsDC7zVC2KxxxDfVsd+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Tue, Jan 12, 2021 at 11:36 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> > The DMACs (both SYS-DMAC and RT-DMAC) on R-Car V3U differ slightly from
> > the DMACs on R-Car Gen2 and other R-Car Gen3 SoCs:
> >   1. The per-channel registers are located in a second register block.
> >      Add support for mapping the second block, using the appropriate
> >      offsets and stride.
> >   2. The common Channel Clear Register (DMACHCLR) was replaced by a
> >      per-channel register.
> >      Update rcar_dmac_chan_clear{,_all}() to handle this.
> >      As rcar_dmac_init() needs to clear the status before the individual
> >      channels are probed, channel index and base address initialization
> >      are moved forward.
> >
> > Inspired by a patch in the BSP by Phong Hoang
> > <phong.hoang.wz@renesas.com>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/dma/sh/rcar-dmac.c
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -189,7 +189,7 @@ struct rcar_dmac_chan {
> >   * struct rcar_dmac - R-Car Gen2 DMA Controller
> >   * @engine: base DMA engine object
> >   * @dev: the hardware device
> > - * @iomem: remapped I/O memory base
> > + * @iomem: remapped I/O memory bases (second is optional)
> >   * @n_channels: number of available channels
> >   * @channels: array of DMAC channels
> >   * @channels_mask: bitfield of which DMA channels are managed by this driver
> > @@ -198,7 +198,7 @@ struct rcar_dmac_chan {
> >  struct rcar_dmac {
> >       struct dma_device engine;
> >       struct device *dev;
> > -     void __iomem *iomem;
> > +     void __iomem *iomem[2];
>
> do you forsee many more memory regions, if not then why not add second

No I don't. TBH, I didn't foresee this change either; you never know
what the hardware people have on their mind for the next SoC ;-)

> region, that way changes in this patch will be lesser..?

I did consider that option.  However, doing so would imply that (a) the
code to map the memory regions can no longer be a loop, but has to be
unrolled manually, and (b) rcar_dmac_of_data.chan_reg_block can no
longer be used to index iomem[], but needs a conditional expression or
statement.

> and it would be better to refer to a region by its name rather than
> iomem[1]..

    - * @iomem: remapped I/O memory base
    + * @common_base: remapped common or combined I/O memory base
    + * @channel_base: remapped optional channel I/O memory base

    -     void __iomem *iomem;
    +     void __iomem *common_base;
    +     void __iomem *channel_base;

If you still think this is worthwhile, I can make these changes.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
