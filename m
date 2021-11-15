Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97272450489
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 13:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhKOMlV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 07:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhKOMlU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 07:41:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FE1761B4B;
        Mon, 15 Nov 2021 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636979905;
        bh=0vPaiFLUq2SXWicOiHJ0dTL68j+HqvYqhdUUZpm4Lbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I+1x2XZxjf0LcgW3lMmbiJPZ71Bi+3kqOGuAZRKXN1JfNBFrZaiB21OzI8/74f0h0
         Qq9j3mNJNww5Ebh37UUU7T73Uy/xgxrT9Cch7mYImOv2H/bbOmofM9xkajEGTkGGUU
         hGAI73KgAeiXM888w+zysyYQTZ4yYyjDXcXqXXwQJ8IyYB0pf/b0pqA/XCjqw9IpRl
         yCWpvb6UA7WovNrxde2iEzHRITt42AWtZE7nvXGbJMW3vN4eAR3DyqEs1DZrNZzLk2
         tuMyHLag1K86+X0psZqBhLcvq1czh8i8zV/S46+iyDlDN0sbFnwCD3e9XH7d1GqYQT
         IxYpNW3g9oKFg==
Received: by mail-wm1-f41.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso15686264wmc.2;
        Mon, 15 Nov 2021 04:38:25 -0800 (PST)
X-Gm-Message-State: AOAM531TynSq29gOG8Yx2rvTe95pr5hI6jMuD2bTYFDKmBoXEexgKA2Y
        3MbVHo8r39mS3vN+vOFnFD3yBU9BpiR7cxPhag0=
X-Google-Smtp-Source: ABdhPJwFTprJJd11s9duELVend6oLQx+lemeU4w9vOaJiXxZUrLq0sghW72KOFAqYJMNV8KCFht4GWVIPZFIhNgyYas=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr58047076wmi.173.1636979903584;
 Mon, 15 Nov 2021 04:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-1-arnd@kernel.org> <20211115085403.360194-9-arnd@kernel.org>
 <YZIk6cVb7XibrMjf@pendragon.ideasonboard.com> <CAK8P3a1Fu11-e0CK2of8u3ebdjom84UKuXhBKi5FUs5ZPPdOVA@mail.gmail.com>
 <YZJJVA/92KYH8hQL@pendragon.ideasonboard.com>
In-Reply-To: <YZJJVA/92KYH8hQL@pendragon.ideasonboard.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Nov 2021 13:38:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27rPBVbU-PrYR0BE4KV2DyJk7FoXaeDS=FU1=_RSwoQQ@mail.gmail.com>
Message-ID: <CAK8P3a27rPBVbU-PrYR0BE4KV2DyJk7FoXaeDS=FU1=_RSwoQQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] dmaengine: xilinx_dpdma: stop using slave_id field
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        dmaengine@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 15, 2021 at 12:49 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Nov 15, 2021 at 11:21:30AM +0100, Arnd Bergmann wrote:
> > On Mon, Nov 15, 2021 at 10:14 AM Laurent Pinchart wrote:
> > > On Mon, Nov 15, 2021 at 09:54:00AM +0100, Arnd Bergmann wrote:
> > > > @@ -1285,11 +1287,13 @@ static int xilinx_dpdma_config(struct dma_chan *dchan,
> > > >       spin_lock_irqsave(&chan->lock, flags);
> > > >
> > > >       /*
> > > > -      * Abuse the slave_id to indicate that the channel is part of a video
> > > > -      * group.
> > > > +      * Abuse the peripheral_config to indicate that the channel is part
> > >
> > > Is it still an abuse, or is this now the right way to pass custom data
> > > to the DMA engine driver ?
> >
> > It doesn't make the driver any more portable, but it's now being
> > more explicit about it. As far as I can tell, this is the best way
> > to pass data that cannot be expressed through the regular interfaces
> > in DT and the dmaengine API.
> >
> > Ideally there would be a generic way to pass this flag, but I couldn't
> > figure out what this is actually doing, or whether there is a better
> > way. Maybe Vinod has an idea.
>
> I don't think we need a generic API in this case. The DMA engine is
> specific to the display device, I don't foresee a need to mix-n-match.


Right. I wonder if there is even a point in using the dmaengine API
in that case, I think for other single-purpose drivers we tend to just
integrate the functionality in the client driver. No point changing this
now of course, but it does feel odd.

From my earlier reading of the driver, my impression was that this
is just a memory-to-memory device, so it could be used that way
as well, but does need a flag when working on the video memory.
I couldn't quite make sense of that though.

> >         /*
> >          * Use the peripheral_config to indicate that the channel is part
> >          * of a video group. This requires matching use of the custom
> >          * structure in each driver.
> >          */
> >         pconfig = config->peripheral_config;
> >         if (WARN_ON(config->peripheral_size != 0 &&
> >                     config->peripheral_size != sizeof(*pconfig)))
> >                 return -EINVAL;
>
> How about
>
>         if (WARN_ON(config->peripheral_config &&
>                     config->peripheral_size != sizeof(*pconfig)))
>
> >
> >         spin_lock_irqsave(&chan->lock, flags);
> >         if (chan->id <= ZYNQMP_DPDMA_VIDEO2 &&
> >             config->peripheral_size == sizeof(*pconfig))
>
> And here you can test pconfig != NULL.

Good idea. Changed now, using 'if (pconfig)' without the '!= NULL'
in both expressions.

        Arnd
