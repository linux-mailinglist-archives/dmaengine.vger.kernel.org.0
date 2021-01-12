Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C182F2D30
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbhALKtT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:49:19 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34536 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbhALKtT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 05:49:19 -0500
Received: by mail-ot1-f54.google.com with SMTP id a109so1858695otc.1;
        Tue, 12 Jan 2021 02:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxaoSb3PjXzlAj8ecx6MMWJ7sUQbD4SSImbDVCX9Ilw=;
        b=gdNnI5qKtNO2j4hJo/hYPyIndguJRppoC2fjaPw63qanKFKX00tdQAOByLziSe6byR
         Z+AX0fqWR9FHQS2KsYVISMbjIhDEQ0TJSQhFJ74MJffaX9OT2fm34ygzQvpDa3bhDBN7
         a7Zrx9f53XGF+16AH4O7KdmPA42t7uQ9XDcfDFb3GW+OIMTM9XcaSLAGWsq9YZ2v4SrM
         aZpHrhDFfkqPnEex8zOsfdMhtiPrzUbhpMY8/oDEZ4vW5uEL4ayVkCc+NquNEe4fvCgL
         1Sp96FHry8QWFzkTYGn0gtjpQ7JF6q9ga5NvMMKQ3kFFbe5yRbJcoMQInfuHa2tmfE5W
         JjpA==
X-Gm-Message-State: AOAM53008xCFTijWA7bP9AUlzre7SNXoJoygSgjTWoDgZwqyasO5VzDI
        jQD/bayVFH5PWUWB6MoI3sGTjBqFqwPpSW5LEQcXfHjQ
X-Google-Smtp-Source: ABdhPJwKCUIIt+SLP419JvmRvcECIu9CcevrYHPbBN7ZEbhylHr0hsS0Xd8TKfUFzeBWLP9AOiY7iAT9SPUTCklO4cU=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr2337938otc.145.1610448518033;
 Tue, 12 Jan 2021 02:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-3-geert+renesas@glider.be> <20210112101950.GK2771@vkoul-mobl>
 <CAMuHMdXhKpO4RLXVBzVezSnui3ZvgB5oX-n25Mcj7se0PaX78A@mail.gmail.com> <20210112103831.GM2771@vkoul-mobl>
In-Reply-To: <20210112103831.GM2771@vkoul-mobl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 11:48:27 +0100
Message-ID: <CAMuHMdX0DMBcdfQbx5jc_3keMdF2YjefLHhF69kEhJuCqsYQ+w@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 11:38 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 12-01-21, 11:26, Geert Uytterhoeven wrote:
> > On Tue, Jan 12, 2021 at 11:19 AM Vinod Koul <vkoul@kernel.org> wrote:
> > > On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> > > > Add and helper macro for iterating over all DMAC channels, taking into
> > > > account the channel mask.  Use it where appropriate, to simplify code.
> > > >
> > > > Restore "reverse Christmas tree" order of local variables while adding a
> > > > new variable.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > --- a/drivers/dma/sh/rcar-dmac.c
> > > > +++ b/drivers/dma/sh/rcar-dmac.c
> > > > @@ -209,6 +209,11 @@ struct rcar_dmac {
> > > >
> > > >  #define to_rcar_dmac(d)              container_of(d, struct rcar_dmac, engine)
> > > >
> > > > +#define for_each_rcar_dmac_chan(i, chan, dmac)                                \
> > > > +     for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; \
> > > > +          i++, chan++)                                                \
> > >
> > > single line to make it more readable? we have limit of 100 now :)
> >
> > Do we have to push the limits?
>
> In cases where it helps, I certainly recommend.. I feel in this case it
> makes a better read to have it in a single line..

OK, will fix.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
