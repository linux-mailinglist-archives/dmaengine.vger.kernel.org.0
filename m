Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1786E2F368B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392201AbhALRFD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 12:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392195AbhALRFC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 12:05:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB7AD2311B;
        Tue, 12 Jan 2021 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610471062;
        bh=3zLZTJjl+cuqKALn9XVgoMNl2Si0kGfx+HWjg+6BsW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cA8e9J2Ta/8Zow76R90Gf5BL0OA6nZNVk+UnrY+OJ2C5mHzNz55DH0t1DiEn7iq5G
         DpsDx9a0DXu6H1Dbbo5R1asGhuhHpXMy1lpa9JsxjV/dmysg1VEZwaCh5HJixD4p/N
         ar2wEixOa34S9qt1uYLi5UpEHT1XNF+SPPvir71myHYLo7YvAFm3gNVEruJEsYTw5B
         b0MVKE3/x6koT+bWHe5J8NYOPRYHWZIUJCeFh8CHrLa6gU3kOEh//RRohMgBzmPTfF
         uIYt1ySIkGEtf4PKwBJADl8q60Rd11QWJJD4Ffz1STmryalvYUjljXh62DizRPZ/97
         Pb9rpLih4uQWw==
Date:   Tue, 12 Jan 2021 22:34:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Message-ID: <20210112170415.GU2771@vkoul-mobl>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-5-geert+renesas@glider.be>
 <20210112103648.GL2771@vkoul-mobl>
 <CAMuHMdUiQkP4W17ovot29NGRPa0rYgpsDC7zVC2KxxxDfVsd+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUiQkP4W17ovot29NGRPa0rYgpsDC7zVC2KxxxDfVsd+w@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-01-21, 16:54, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Tue, Jan 12, 2021 at 11:36 AM Vinod Koul <vkoul@kernel.org> wrote:
> > On 07-01-21, 19:15, Geert Uytterhoeven wrote:
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
> > > @@ -189,7 +189,7 @@ struct rcar_dmac_chan {
> > >   * struct rcar_dmac - R-Car Gen2 DMA Controller
> > >   * @engine: base DMA engine object
> > >   * @dev: the hardware device
> > > - * @iomem: remapped I/O memory base
> > > + * @iomem: remapped I/O memory bases (second is optional)
> > >   * @n_channels: number of available channels
> > >   * @channels: array of DMAC channels
> > >   * @channels_mask: bitfield of which DMA channels are managed by this driver
> > > @@ -198,7 +198,7 @@ struct rcar_dmac_chan {
> > >  struct rcar_dmac {
> > >       struct dma_device engine;
> > >       struct device *dev;
> > > -     void __iomem *iomem;
> > > +     void __iomem *iomem[2];
> >
> > do you forsee many more memory regions, if not then why not add second
> 
> No I don't. TBH, I didn't foresee this change either; you never know
> what the hardware people have on their mind for the next SoC ;-)
> 
> > region, that way changes in this patch will be lesser..?
> 
> I did consider that option.  However, doing so would imply that (a) the
> code to map the memory regions can no longer be a loop, but has to be
> unrolled manually, and (b) rcar_dmac_of_data.chan_reg_block can no
> longer be used to index iomem[], but needs a conditional expression or
> statement.
> 
> > and it would be better to refer to a region by its name rather than
> > iomem[1]..
> 
>     - * @iomem: remapped I/O memory base
>     + * @common_base: remapped common or combined I/O memory base
>     + * @channel_base: remapped optional channel I/O memory base
> 
>     -     void __iomem *iomem;
>     +     void __iomem *common_base;
>     +     void __iomem *channel_base;
> 
> If you still think this is worthwhile, I can make these changes.

Either way suits me, TBH it is not a deal breaker, so i would leave it
upto you :)

-- 
~Vinod
