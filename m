Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B0305542
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhA0IHx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 03:07:53 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41599 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhA0IFJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 03:05:09 -0500
Received: by mail-oi1-f173.google.com with SMTP id m13so1282630oig.8;
        Wed, 27 Jan 2021 00:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfyRLzMlIoi5X9bZM312ztK9szh1Uoj2MAF1xDhQS7U=;
        b=S9sJowijfjfMSXl1D7wws47kLVOOhyXp+82GYqGuXqnR6+oiBefwwqgL841ixa74Vf
         uByG0snUfWC/cusWFyfMRMhuM21DkKoNbRVVjNzHL9owjmY3gI2+XC1HJCymOIFnDnn1
         D87IeBm3lsoZTjATr+KXgKtm5eaxBbnIhw1+ioAc1QvNMy5zQrytiqnbO3UQpLhcdgSL
         DBBFo51WY+UbYb+GquoDQEaLL3Dd/uDWNkEwEorZp83VHuNTnXGX+sLio21sRqz4B5hu
         g/d39G+5I9j3AqddFLrKZFkqqmWjjdv8qWMzSAk/KE0TQdiiv/8GXAzx4Vc8pVdzXTev
         zRQw==
X-Gm-Message-State: AOAM533S7MVM5iIbI/M8WI+VIys4IZcEO1rrzbBupu7lIpYHqphxrBGW
        SEU3ViRRNQo/6qrpWpMOJR98qOwch/FUdHtyYFAS/Fe7
X-Google-Smtp-Source: ABdhPJyQk+t/A9YKLA2LqVfKqKypKtLzXPHN3IoCxXpEFRU4g2uVJpYn7UJ6W85zp4YH2b4RCWqBZ10Q9spNLMqH93w=
X-Received: by 2002:aca:4d8d:: with SMTP id a135mr2327538oib.153.1611734299722;
 Tue, 26 Jan 2021 23:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-3-geert+renesas@glider.be> <YBCPoOKGRZYkdfPn@pendragon.ideasonboard.com>
In-Reply-To: <YBCPoOKGRZYkdfPn@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 08:58:08 +0100
Message-ID: <CAMuHMdVD_g2HW4PBup4Si8H5kJ12PzUHXnZcHp7O_He-MHvtmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan()
 helper
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

On Tue, Jan 26, 2021 at 10:55 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Jan 25, 2021 at 03:24:29PM +0100, Geert Uytterhoeven wrote:
> > Add and helper macro for iterating over all DMAC channels, taking into
>
> s/and helper/a helper/

Oops.

> > account the channel mask.  Use it where appropriate, to simplify code.
> >
> > Restore "reverse Christmas tree" order of local variables while adding a
> > new variable.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/dma/sh/rcar-dmac.c
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -209,6 +209,10 @@ struct rcar_dmac {
> >
> >  #define to_rcar_dmac(d)              container_of(d, struct rcar_dmac, engine)
> >
> > +#define for_each_rcar_dmac_chan(i, chan, dmac)                                               \
>
> I would have placed the iterator (chan) after the container being
> iterated (dmac), but it seems there are some for_each_* macros doing it
> the other way around (they may be older though).

Makes sense.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
