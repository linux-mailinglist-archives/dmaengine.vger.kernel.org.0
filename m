Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8366130322E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 03:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbhAYOV7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Jan 2021 09:21:59 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41040 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbhAYOVq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jan 2021 09:21:46 -0500
Received: by mail-oi1-f174.google.com with SMTP id m13so6948588oig.8;
        Mon, 25 Jan 2021 06:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4KyYlby3ix9gWsgIE+54GAeLjjtUdHgSTrB2Z0eyrw=;
        b=LI+ZX9dcYzclLN2m7h7CjvAWfO329p94IC60huk3tMyZpe78aVF1K5vX79OmnJ8QtY
         UFr+OlVYYVKacZs4rLbZd+rRa733PJwthJUvyXGkcglWekwxLH1fwsWx+N+cd2RrlDjH
         1sc25Dizvu1ItjNyQtd6Am2vjp6Sldsoa4kaHakvZ5QxGUEZ4sN8ws01hByRBwV7HCxW
         sZlXYpWptwCHxqTsC01bZFsaDU0cOzC8y3pj94WcrI68dyazZoPI5QlSVZsMG3Ny4iNh
         P6IKR8TQKcOphBC/a/BYyT2BoZOavTXPKkH0nsoX9fkVDArKa9AAgnVU3Dt4hJejHC2f
         9RbQ==
X-Gm-Message-State: AOAM531oSouNuHHMd+XxkZ9J2ZKiAQAK6/xvKMTgFpOVhevLke7bJ+re
        c7nmAbIjwGej/ERAFbK79rHZA30eH0T/CrKyTSw=
X-Google-Smtp-Source: ABdhPJwVtpKcPVKOwYR/zAg3FHVzFS2mssYCbKzz3y5LZbpmHtHzej0Ch/BY6dLBcr0oR62dlxAVLIoJ6k0Quw0KWv4=
X-Received: by 2002:aca:1219:: with SMTP id 25mr274231ois.54.1611584449552;
 Mon, 25 Jan 2021 06:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-5-geert+renesas@glider.be> <20210112103648.GL2771@vkoul-mobl>
 <CAMuHMdUiQkP4W17ovot29NGRPa0rYgpsDC7zVC2KxxxDfVsd+w@mail.gmail.com> <20210112170415.GU2771@vkoul-mobl>
In-Reply-To: <20210112170415.GU2771@vkoul-mobl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jan 2021 15:20:38 +0100
Message-ID: <CAMuHMdWVD4fc9WHLW9L+rDoqPp4YkRzUjWuy=RmndKcqqq-RnQ@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 6:04 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 12-01-21, 16:54, Geert Uytterhoeven wrote:
> > On Tue, Jan 12, 2021 at 11:36 AM Vinod Koul <vkoul@kernel.org> wrote:
> > > On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> > > > The DMACs (both SYS-DMAC and RT-DMAC) on R-Car V3U differ slightly from
> > > > the DMACs on R-Car Gen2 and other R-Car Gen3 SoCs:
> > > >   1. The per-channel registers are located in a second register block.
> > > >      Add support for mapping the second block, using the appropriate
> > > >      offsets and stride.
> > > >   2. The common Channel Clear Register (DMACHCLR) was replaced by a
> > > >      per-channel register.
> > > >      Update rcar_dmac_chan_clear{,_all}() to handle this.
> > > >      As rcar_dmac_init() needs to clear the status before the individual
> > > >      channels are probed, channel index and base address initialization
> > > >      are moved forward.
> > > >
> > > > Inspired by a patch in the BSP by Phong Hoang
> > > > <phong.hoang.wz@renesas.com>.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > --- a/drivers/dma/sh/rcar-dmac.c
> > > > +++ b/drivers/dma/sh/rcar-dmac.c
> > > > @@ -189,7 +189,7 @@ struct rcar_dmac_chan {
> > > >   * struct rcar_dmac - R-Car Gen2 DMA Controller
> > > >   * @engine: base DMA engine object
> > > >   * @dev: the hardware device
> > > > - * @iomem: remapped I/O memory base
> > > > + * @iomem: remapped I/O memory bases (second is optional)
> > > >   * @n_channels: number of available channels
> > > >   * @channels: array of DMAC channels
> > > >   * @channels_mask: bitfield of which DMA channels are managed by this driver
> > > > @@ -198,7 +198,7 @@ struct rcar_dmac_chan {
> > > >  struct rcar_dmac {
> > > >       struct dma_device engine;
> > > >       struct device *dev;
> > > > -     void __iomem *iomem;
> > > > +     void __iomem *iomem[2];
> > >
> > > do you forsee many more memory regions, if not then why not add second
> >
> > No I don't. TBH, I didn't foresee this change either; you never know
> > what the hardware people have on their mind for the next SoC ;-)
> >
> > > region, that way changes in this patch will be lesser..?
> >
> > I did consider that option.  However, doing so would imply that (a) the
> > code to map the memory regions can no longer be a loop, but has to be
> > unrolled manually, and (b) rcar_dmac_of_data.chan_reg_block can no
> > longer be used to index iomem[], but needs a conditional expression or
> > statement.
> >
> > > and it would be better to refer to a region by its name rather than
> > > iomem[1]..
> >
> >     - * @iomem: remapped I/O memory base
> >     + * @common_base: remapped common or combined I/O memory base
> >     + * @channel_base: remapped optional channel I/O memory base
> >
> >     -     void __iomem *iomem;
> >     +     void __iomem *common_base;
> >     +     void __iomem *channel_base;
> >
> > If you still think this is worthwhile, I can make these changes.
>
> Either way suits me, TBH it is not a deal breaker, so i would leave it
> upto you :)

I managed to use named regions at the expense of only 6 more lines of
source code, even reducing the resulting binary size.
So stay ready for v2 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
