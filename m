Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57042F2D0B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhALKjT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbhALKjS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 05:39:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04A12222B3;
        Tue, 12 Jan 2021 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610447917;
        bh=ZGNvCDtW+GlWGGbFJul6XKQnVBKwD5l18BH8rBakqJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/PJa3GrpSSQ4j0/RyX+Cc1H0VbOY4cqgdb2hzJ779gmRTdX9XJMHs2gID3Wk2S5/
         B8GRpfA3njaSmNrRm94tPgPLPygbGUASH4etLV/t2Hz4FGybdEKrpXPKrgi1yWzGQN
         YFzolHwXMsoQPwoQKlU81RS7ERyh+ISQ3F4+zU+cXVsC6n7xZTnB06e0/WqYI+M4lY
         mUWL3DmZRCBuE7Rsa7ApKdstK11bHBZj0+Qs4yb9NvUMtCUFGi3tCPdn6fIce2YEij
         ubT8H6T3+TXkQC8ttO/fn+9PBVG91taKJjunvwJARsZptGyZg8MuB2DXtT8AaGimo/
         SZReH2mv/NvnQ==
Date:   Tue, 12 Jan 2021 16:08:31 +0530
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
Subject: Re: [PATCH 2/4] dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan()
 helper
Message-ID: <20210112103831.GM2771@vkoul-mobl>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-3-geert+renesas@glider.be>
 <20210112101950.GK2771@vkoul-mobl>
 <CAMuHMdXhKpO4RLXVBzVezSnui3ZvgB5oX-n25Mcj7se0PaX78A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXhKpO4RLXVBzVezSnui3ZvgB5oX-n25Mcj7se0PaX78A@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-01-21, 11:26, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Tue, Jan 12, 2021 at 11:19 AM Vinod Koul <vkoul@kernel.org> wrote:
> > On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> > > Add and helper macro for iterating over all DMAC channels, taking into
> > > account the channel mask.  Use it where appropriate, to simplify code.
> > >
> > > Restore "reverse Christmas tree" order of local variables while adding a
> > > new variable.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/drivers/dma/sh/rcar-dmac.c
> > > +++ b/drivers/dma/sh/rcar-dmac.c
> > > @@ -209,6 +209,11 @@ struct rcar_dmac {
> > >
> > >  #define to_rcar_dmac(d)              container_of(d, struct rcar_dmac, engine)
> > >
> > > +#define for_each_rcar_dmac_chan(i, chan, dmac)                                \
> > > +     for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; \
> > > +          i++, chan++)                                                \
> >
> > single line to make it more readable? we have limit of 100 now :)
> 
> Do we have to push the limits?

In cases where it helps, I certainly recommend.. I feel in this case it
makes a better read to have it in a single line..

> BTW, the new punched cards are 96-column wide, not 100-column ;-)
> https://en.wikipedia.org/wiki/Punched_card#IBM_96-column_format

Did we err in choosing 100 :D

-- 
~Vinod
