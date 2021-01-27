Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A4305D75
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 14:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhA0NpM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 08:45:12 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37326 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhA0NpD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 08:45:03 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 069C1240;
        Wed, 27 Jan 2021 14:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611755052;
        bh=4oiDLYDjV/1iW5vbdVFhfngF1nGARyrh6yFVi/JDSDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pm4bcXmupTRF7F9J+jXq9lG/3OsjjCslY5cXy7Dr2D/GYJKmvhGQoQxZR0mq+FpnP
         UONLHPueyFraKMWezd2lPdP0+IfceFXpRGNpdEuR0+o7fUJ/7dnggE7TtgkQvhTREN
         JhV8oABIIHlp1qNVHbwP0AXU+9HUMCHySVj0YZ/8=
Date:   Wed, 27 Jan 2021 15:43:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Message-ID: <YBFuGEdTYbcRFg4f@pendragon.ideasonboard.com>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-5-geert+renesas@glider.be>
 <YBCREUMJ0/LgxDlJ@pendragon.ideasonboard.com>
 <CAMuHMdUqCTvCQUmL-m7C=W0id+Oh5OqPxySutOs9DEdWnzKYEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqCTvCQUmL-m7C=W0id+Oh5OqPxySutOs9DEdWnzKYEg@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On Wed, Jan 27, 2021 at 09:10:40AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 26, 2021 at 11:01 PM Laurent Pinchart wrote:
> > On Mon, Jan 25, 2021 at 03:24:31PM +0100, Geert Uytterhoeven wrote:
> > > The DMACs (both SYS-DMAC and RT-DMAC) on R-Car V3U differ slightly from
> > > the DMACs on R-Car Gen2 and other R-Car Gen3 SoCs:
> > >   1. The per-channel registers are located in a second register block.
> > >      Add support for mapping the second block, using the appropriate
> > >      offsets and stride.
> > >   2. The common Channel Clear Register (DMACHCLR) was replaced by a
> > >      per-channel register.
> > >      Update rcar_dmac_chan_clear{,_all}() to handle this.
> > >      As rcar_dmac_init() needs to clear the status before the individual
> > >      channels are probed, channel index and base address initialization
> > >      are moved forward.
> > >
> > > Inspired by a patch in the BSP by Phong Hoang
> > > <phong.hoang.wz@renesas.com>.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/drivers/dma/sh/rcar-dmac.c
> > > +++ b/drivers/dma/sh/rcar-dmac.c
> > > @@ -189,7 +189,8 @@ struct rcar_dmac_chan {
> > >   * struct rcar_dmac - R-Car Gen2 DMA Controller
> > >   * @engine: base DMA engine object
> > >   * @dev: the hardware device
> > > - * @iomem: remapped I/O memory base
> > > + * @dmac_base: remapped base register block
> > > + * @chan_base: remapped channel register block (optional)
> > >   * @n_channels: number of available channels
> > >   * @channels: array of DMAC channels
> > >   * @channels_mask: bitfield of which DMA channels are managed by this driver
> > > @@ -198,7 +199,8 @@ struct rcar_dmac_chan {
> > >  struct rcar_dmac {
> > >       struct dma_device engine;
> > >       struct device *dev;
> > > -     void __iomem *iomem;
> > > +     void __iomem *dmac_base;
> > > +     void __iomem *chan_base;
> > >
> > >       unsigned int n_channels;
> > >       struct rcar_dmac_chan *channels;
> 
> > > @@ -339,12 +344,23 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
> > >  static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
> > >                                struct rcar_dmac_chan *chan)
> > >  {
> > > -     rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
> > > +     if (dmac->chan_base)
> >
> > Using dmac->chan_base to check if the device is a V3U seems a bit of a
> > hack (especially given that the field is otherwise unused). I'd prefer
> > adding a model field to struct rcar_dmac_of_data and struct rcar_dmac.
> 
> The check is not a check for R-Car V3U in particular, but a check for
> the presence of a separate register block for channel registers.
> I expect to see more SoCs having this, so IMHO checking for this feature,
> instead of checking a model field, makes sense.
> 
> It's indeed unused otherwise, as beyond probe(), where per-channel bases
> are calculated, no access to this pointer is needed anymore, (you can
> blame devm_*() for not needing the pointer ;-)
> Note that a model field would be "otherwise unused", too ;-)

I agree that this isn't a V3U check, but a DMAC
"model/generation/version" check. With V3U as the only SoC we know of
that uses this new DMAC model, it's a bit difficult to come up with a
proper name, but conceptually I think a model check would be better than
checking chan_base.

> > > +             rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
> > > +     else
> > > +             rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
> > >  }
> > >
> > >  static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
> > >  {
> > > -     rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> > > +     struct rcar_dmac_chan *chan;
> > > +     unsigned int i;
> > > +
> > > +     if (dmac->chan_base) {
> > > +             for_each_rcar_dmac_chan(i, chan, dmac)
> > > +                     rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
> > > +     } else {
> > > +             rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> > > +     }
> > >  }
> > >
> > >  /* -----------------------------------------------------------------------------
> > > @@ -1744,7 +1760,6 @@ static const struct dev_pm_ops rcar_dmac_pm = {
> > >
> > >  static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> > >                               struct rcar_dmac_chan *rchan,
> > > -                             const struct rcar_dmac_of_data *data,
> > >                               unsigned int index)
> > >  {
> > >       struct platform_device *pdev = to_platform_device(dmac->dev);
> > > @@ -1753,9 +1768,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> > >       char *irqname;
> > >       int ret;
> > >
> > > -     rchan->index = index;
> > > -     rchan->iomem = dmac->iomem + data->chan_offset_base +
> > > -                    data->chan_offset_stride * index;
> > >       rchan->mid_rid = -EINVAL;
> > >
> > >       spin_lock_init(&rchan->lock);
> > > @@ -1842,6 +1854,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> > >       const struct rcar_dmac_of_data *data;
> > >       struct rcar_dmac_chan *chan;
> > >       struct dma_device *engine;
> > > +     void __iomem *chan_base;
> > >       struct rcar_dmac *dmac;
> > >       unsigned int i;
> > >       int ret;
> > > @@ -1880,9 +1893,24 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> > >               return -ENOMEM;
> > >
> > >       /* Request resources. */
> > > -     dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
> > > -     if (IS_ERR(dmac->iomem))
> > > -             return PTR_ERR(dmac->iomem);
> > > +     dmac->dmac_base = devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(dmac->dmac_base))
> > > +             return PTR_ERR(dmac->dmac_base);
> > > +
> > > +     if (!data->chan_offset_base) {
> > > +             dmac->chan_base = devm_platform_ioremap_resource(pdev, 1);
> > > +             if (IS_ERR(dmac->chan_base))
> > > +                     return PTR_ERR(dmac->chan_base);
> > > +
> > > +             chan_base = dmac->chan_base;
> > > +     } else {
> > > +             chan_base = dmac->dmac_base + data->chan_offset_base;
> > > +     }
> > > +
> > > +     for_each_rcar_dmac_chan(i, chan, dmac) {
> > > +             chan->index = i;
> >
> > Now that chan->indew is set before calling rcar_dmac_chan_probe(), you
> > don't have to pass the index to rcar_dmac_chan_probe() anymore.
> 
> Right, will fix.
> 
> > > +             chan->iomem = chan_base + i * data->chan_offset_stride;
> > > +     }
> > >
> > >       /* Enable runtime PM and initialize the device. */
> > >       pm_runtime_enable(&pdev->dev);
> > > @@ -1929,7 +1957,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> > >       INIT_LIST_HEAD(&engine->channels);
> > >
> > >       for_each_rcar_dmac_chan(i, chan, dmac) {
> > > -             ret = rcar_dmac_chan_probe(dmac, chan, data, i);
> > > +             ret = rcar_dmac_chan_probe(dmac, chan, i);
> > >               if (ret < 0)
> > >                       goto error;
> > >       }
> 
> Thanks for your comments!

-- 
Regards,

Laurent Pinchart
