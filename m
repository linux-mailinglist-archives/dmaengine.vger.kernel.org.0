Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA72F2CC6
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392780AbhALK1I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:27:08 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34068 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbhALK1I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 05:27:08 -0500
Received: by mail-oi1-f173.google.com with SMTP id s75so1849107oih.1;
        Tue, 12 Jan 2021 02:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNy54YvyEG+MmyMNSknqMIs/iaqY7Dt1qSoRryJi0OY=;
        b=dYwfr/bLujGXNXs3qghhT/QW7ozFPQttyuD5yQExNqMYaDdrDOwGRXdzHPiOUWRZp0
         OM21c4+p8Icly9q9APT2IzJ3Icbj/rdk1zJyBzcdeXWxXrSK/e1HLUXSRsiIb9mw3bRT
         RfRMrbN2i7gYHYSE0QZjAxaI2l4o8u1P158iIj0b8aZ5+TfPUJRJO/VgAJPgtdEfIpTp
         A+MTU7nNYLhA7knGofaYiSk0IbKMK6H9zccYc7oygCJxW6HrkQzjCu2EndhCzMS/bZAL
         kXqXtKRyCfY4vHRmoAOnmhkaD0UOFNoTw1euxFrZ3XhtPc5V8AAPjSMr3l0WVH8aPG5u
         9iqA==
X-Gm-Message-State: AOAM53315c82KgvhR4KgsOASsJ1g2TVP6j3POei9m014gREL7I1QleGC
        mbpcGFi7TKx+Wl/sRLkMe2JHMOT6Z59TYl2lcadi2g8xQaU=
X-Google-Smtp-Source: ABdhPJzYHBdsX45B4kEd9SOIflChVmFlSmzttpTadGUOdiAChH3XKY+LK034WPAeAJPmyVOHHviE4aAisjNOz8AJayA=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr1881850oia.148.1610447187714;
 Tue, 12 Jan 2021 02:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-3-geert+renesas@glider.be> <20210112101950.GK2771@vkoul-mobl>
In-Reply-To: <20210112101950.GK2771@vkoul-mobl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 11:26:16 +0100
Message-ID: <CAMuHMdXhKpO4RLXVBzVezSnui3ZvgB5oX-n25Mcj7se0PaX78A@mail.gmail.com>
Subject: Re: [PATCH 2/4] dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
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

On Tue, Jan 12, 2021 at 11:19 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> > Add and helper macro for iterating over all DMAC channels, taking into
> > account the channel mask.  Use it where appropriate, to simplify code.
> >
> > Restore "reverse Christmas tree" order of local variables while adding a
> > new variable.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/dma/sh/rcar-dmac.c
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -209,6 +209,11 @@ struct rcar_dmac {
> >
> >  #define to_rcar_dmac(d)              container_of(d, struct rcar_dmac, engine)
> >
> > +#define for_each_rcar_dmac_chan(i, chan, dmac)                                \
> > +     for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; \
> > +          i++, chan++)                                                \
>
> single line to make it more readable? we have limit of 100 now :)

Do we have to push the limits?

BTW, the new punched cards are 96-column wide, not 100-column ;-)
https://en.wikipedia.org/wiki/Punched_card#IBM_96-column_format

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
