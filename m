Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00CE305586
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 09:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhA0IV5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 03:21:57 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:43305 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA0IUa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 03:20:30 -0500
Received: by mail-yb1-f169.google.com with SMTP id y128so1217145ybf.10
        for <dmaengine@vger.kernel.org>; Wed, 27 Jan 2021 00:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/iQz33kgh6xnvFreqr2JBmntO4WEFL9xyCLy3xIbC0=;
        b=tzT2FVLTJYrfxe9JlgTT0W7gbl2i7+RC/AiAC3Y3SK40OsXJLjW0sDbgxbt1YUjhrI
         gZ0x7XNC3jjaG3hBh6YPgnfPGqktfX841mjfrtxTNMz6sCuf/ZIx7AIPUPBSfS/qI4eq
         0D9ShbC9x0+cjGq+tcP8d5Zl0YsnwCvwgNzEswozOkj4fwF4yS8/G2Q4YK+Hfn8ilKlZ
         bYbvAsodSOUI0w8IstZ3uUYPBiGZlLRpLwb6JMXXnhuAAEbNkH6XlaK0inDoCJFvKxuL
         KnGIhRQdJotpZPkgGvWZBgP6eij2v7RAk/2LpIVkMPVGHHBlscXn8Qpc/bJ38c7gKOlH
         2uIQ==
X-Gm-Message-State: AOAM531owS2b8xsTh4z8Q7ktmlkGXuG1w8ZGSUmJUqYkc+o4cb0PlUHD
        wyjHnHC9pV3cYm7GUvsBi4dWKNNPbTbNYAmYPxVQgsTHjdc=
X-Google-Smtp-Source: ABdhPJwVJ5QU5cyczh35eHMkHRGaSDc7rqd/vvSHWfq2Q98yCiYxVmsxiAo478eNiF+zbFazNblMbwe+/6t4Iz2fDp0=
X-Received: by 2002:a05:6830:1489:: with SMTP id s9mr6101130otq.250.1611735051520;
 Wed, 27 Jan 2021 00:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-5-geert+renesas@glider.be> <YBCREUMJ0/LgxDlJ@pendragon.ideasonboard.com>
In-Reply-To: <YBCREUMJ0/LgxDlJ@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 09:10:40 +0100
Message-ID: <CAMuHMdUqCTvCQUmL-m7C=W0id+Oh5OqPxySutOs9DEdWnzKYEg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On Tue, Jan 26, 2021 at 11:01 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Jan 25, 2021 at 03:24:31PM +0100, Geert Uytterhoeven wrote:
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
> > @@ -189,7 +189,8 @@ struct rcar_dmac_chan {
> >   * struct rcar_dmac - R-Car Gen2 DMA Controller
> >   * @engine: base DMA engine object
> >   * @dev: the hardware device
> > - * @iomem: remapped I/O memory base
> > + * @dmac_base: remapped base register block
> > + * @chan_base: remapped channel register block (optional)
> >   * @n_channels: number of available channels
> >   * @channels: array of DMAC channels
> >   * @channels_mask: bitfield of which DMA channels are managed by this driver
> > @@ -198,7 +199,8 @@ struct rcar_dmac_chan {
> >  struct rcar_dmac {
> >       struct dma_device engine;
> >       struct device *dev;
> > -     void __iomem *iomem;
> > +     void __iomem *dmac_base;
> > +     void __iomem *chan_base;
> >
> >       unsigned int n_channels;
> >       struct rcar_dmac_chan *channels;

> > @@ -339,12 +344,23 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
> >  static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
> >                                struct rcar_dmac_chan *chan)
> >  {
> > -     rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
> > +     if (dmac->chan_base)
>
> Using dmac->chan_base to check if the device is a V3U seems a bit of a
> hack (especially given that the field is otherwise unused). I'd prefer
> adding a model field to struct rcar_dmac_of_data and struct rcar_dmac.

The check is not a check for R-Car V3U in particular, but a check for
the presence of a separate register block for channel registers.
I expect to see more SoCs having this, so IMHO checking for this feature,
instead of checking a model field, makes sense.

It's indeed unused otherwise, as beyond probe(), where per-channel bases
are calculated, no access to this pointer is needed anymore, (you can
blame devm_*() for not needing the pointer ;-)
Note that a model field would be "otherwise unused", too ;-)

> > +             rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
> > +     else
> > +             rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
> >  }
> >
> >  static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
> >  {
> > -     rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> > +     struct rcar_dmac_chan *chan;
> > +     unsigned int i;
> > +
> > +     if (dmac->chan_base) {
> > +             for_each_rcar_dmac_chan(i, chan, dmac)
> > +                     rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
> > +     } else {
> > +             rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> > +     }
> >  }
> >
> >  /* -----------------------------------------------------------------------------
> > @@ -1744,7 +1760,6 @@ static const struct dev_pm_ops rcar_dmac_pm = {
> >
> >  static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> >                               struct rcar_dmac_chan *rchan,
> > -                             const struct rcar_dmac_of_data *data,
> >                               unsigned int index)
> >  {
> >       struct platform_device *pdev = to_platform_device(dmac->dev);
> > @@ -1753,9 +1768,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> >       char *irqname;
> >       int ret;
> >
> > -     rchan->index = index;
> > -     rchan->iomem = dmac->iomem + data->chan_offset_base +
> > -                    data->chan_offset_stride * index;
> >       rchan->mid_rid = -EINVAL;
> >
> >       spin_lock_init(&rchan->lock);
> > @@ -1842,6 +1854,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> >       const struct rcar_dmac_of_data *data;
> >       struct rcar_dmac_chan *chan;
> >       struct dma_device *engine;
> > +     void __iomem *chan_base;
> >       struct rcar_dmac *dmac;
> >       unsigned int i;
> >       int ret;
> > @@ -1880,9 +1893,24 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> >               return -ENOMEM;
> >
> >       /* Request resources. */
> > -     dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
> > -     if (IS_ERR(dmac->iomem))
> > -             return PTR_ERR(dmac->iomem);
> > +     dmac->dmac_base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(dmac->dmac_base))
> > +             return PTR_ERR(dmac->dmac_base);
> > +
> > +     if (!data->chan_offset_base) {
> > +             dmac->chan_base = devm_platform_ioremap_resource(pdev, 1);
> > +             if (IS_ERR(dmac->chan_base))
> > +                     return PTR_ERR(dmac->chan_base);
> > +
> > +             chan_base = dmac->chan_base;
> > +     } else {
> > +             chan_base = dmac->dmac_base + data->chan_offset_base;
> > +     }
> > +
> > +     for_each_rcar_dmac_chan(i, chan, dmac) {
> > +             chan->index = i;
>
> Now that chan->indew is set before calling rcar_dmac_chan_probe(), you
> don't have to pass the index to rcar_dmac_chan_probe() anymore.

Right, will fix.

> > +             chan->iomem = chan_base + i * data->chan_offset_stride;
> > +     }
> >
> >       /* Enable runtime PM and initialize the device. */
> >       pm_runtime_enable(&pdev->dev);
> > @@ -1929,7 +1957,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> >       INIT_LIST_HEAD(&engine->channels);
> >
> >       for_each_rcar_dmac_chan(i, chan, dmac) {
> > -             ret = rcar_dmac_chan_probe(dmac, chan, data, i);
> > +             ret = rcar_dmac_chan_probe(dmac, chan, i);
> >               if (ret < 0)
> >                       goto error;
> >       }

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
