Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE7A4354
	for <lists+dmaengine@lfdr.de>; Sat, 31 Aug 2019 10:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHaIgK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 31 Aug 2019 04:36:10 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49694 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaIgK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 31 Aug 2019 04:36:10 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0DBFD25AD78;
        Sat, 31 Aug 2019 18:36:08 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id E20C7E218F0; Sat, 31 Aug 2019 10:36:05 +0200 (CEST)
Date:   Sat, 31 Aug 2019 10:36:05 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: Use of_data values instead of
 a macro
Message-ID: <20190831083605.t6wf2lu3xzdtiarv@verge.net.au>
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566904231-25486-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdV9pSq1RrXG53=az1krVVnZF3M=F3MiS7t+Z5dMo_iKHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV9pSq1RrXG53=az1krVVnZF3M=F3MiS7t+Z5dMo_iKHg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 27, 2019 at 03:08:16PM +0200, Geert Uytterhoeven wrote:
> Hi Shimoda-san,
> 
> On Tue, Aug 27, 2019 at 1:12 PM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Since we will have changed memory mapping of the DMAC in the future,
> > this patch uses of_data values instead of a macro to calculate
> > each channel's base offset.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/drivers/dma/sh/rcar-dmac.c
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -208,12 +208,20 @@ struct rcar_dmac {
> >
> >  #define to_rcar_dmac(d)                container_of(d, struct rcar_dmac, engine)
> >
> > +/*
> > + * struct rcar_dmac_of_data - This driver's OF data
> > + * @chan_offset_base: DMAC channels base offset
> > + * @chan_offset_coefficient: DMAC channels offset coefficient
> 
> Perhaps "stride" instead of "coefficient"? Or "step"?
> 
> > @@ -1803,10 +1813,15 @@ static int rcar_dmac_probe(struct platform_device *pdev)
> >         unsigned int channels_offset = 0;
> >         struct dma_device *engine;
> >         struct rcar_dmac *dmac;
> > +       const struct rcar_dmac_of_data *data;
> >         struct resource *mem;
> >         unsigned int i;
> >         int ret;
> >
> > +       data = of_device_get_match_data(&pdev->dev);
> > +       if (!data)
> > +               return -EINVAL;
> 
> This cannot fail, as the driver is DT only, and all entries in the match table
> have a data pointer.

It seems to me that not including this check would make the code both more
fragile and less intuitive for a marginal gain in simplicity.

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
> 
