Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0174503CA
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 12:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKOLxG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKOLxC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Nov 2021 06:53:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09981C061746;
        Mon, 15 Nov 2021 03:50:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A4AB9CA;
        Mon, 15 Nov 2021 12:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1636977002;
        bh=8re/QsV/3GPHXV9j74dqu0H+3pTypCailVuz8uMMvrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTtRDp36OT7fx+mEQdB5Q6I6Uf3svTjc7O60k3oZ4d4LDZwX9gRNLXKCFKYdS58b6
         iochdzQTE6K7vejlHf4MMrQFHA3VGrfZCRSuARACO154L7RPOUcQFEq3FEieaAnbP9
         1Q/7byArzgxRl2K9AECFy7SDhkfUFmq2YmZNiRrQ=
Date:   Mon, 15 Nov 2021 13:49:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [PATCH 08/11] dmaengine: xilinx_dpdma: stop using slave_id field
Message-ID: <YZJJVA/92KYH8hQL@pendragon.ideasonboard.com>
References: <20211115085403.360194-1-arnd@kernel.org>
 <20211115085403.360194-9-arnd@kernel.org>
 <YZIk6cVb7XibrMjf@pendragon.ideasonboard.com>
 <CAK8P3a1Fu11-e0CK2of8u3ebdjom84UKuXhBKi5FUs5ZPPdOVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Fu11-e0CK2of8u3ebdjom84UKuXhBKi5FUs5ZPPdOVA@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

On Mon, Nov 15, 2021 at 11:21:30AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 15, 2021 at 10:14 AM Laurent Pinchart wrote:
> > On Mon, Nov 15, 2021 at 09:54:00AM +0100, Arnd Bergmann wrote:
> > > @@ -1285,11 +1287,13 @@ static int xilinx_dpdma_config(struct dma_chan *dchan,
> > >       spin_lock_irqsave(&chan->lock, flags);
> > >
> > >       /*
> > > -      * Abuse the slave_id to indicate that the channel is part of a video
> > > -      * group.
> > > +      * Abuse the peripheral_config to indicate that the channel is part
> >
> > Is it still an abuse, or is this now the right way to pass custom data
> > to the DMA engine driver ?
> 
> It doesn't make the driver any more portable, but it's now being
> more explicit about it. As far as I can tell, this is the best way
> to pass data that cannot be expressed through the regular interfaces
> in DT and the dmaengine API.
> 
> Ideally there would be a generic way to pass this flag, but I couldn't
> figure out what this is actually doing, or whether there is a better
> way. Maybe Vinod has an idea.

I don't think we need a generic API in this case. The DMA engine is
specific to the display device, I don't foresee a need to mix-n-match.

> I'll change s/Abuse/Use/ for the moment until I get a definite answer.
> 
> > > +      * of a video group.
> > >        */
> > > -     if (chan->id <= ZYNQMP_DPDMA_VIDEO2)
> > > -             chan->video_group = config->slave_id != 0;
> > > +     pconfig = config->peripheral_config;
> >
> > This could be moved to the variable declaration above, up to you.
> 
> I considered that but since it doesn't fit in a normal 80-column
> line, it seemed best to do it here.
> 
> > > +     if (chan->id <= ZYNQMP_DPDMA_VIDEO2 &&
> > > +         config->peripheral_size == sizeof(*pconfig))
> >
> > Silently ignoring a size mismatch isn't nice. Could we validate the size
> > at the beginning of the function and return an error ?
> 
> Yes, good idea. Since this would mean a bug in another driver,
> I'll add a WARN_ON() as well to make it clear which driver caused it.
> This is what I have now, let me know if you have any further suggestions:
> 
>         /*
>          * Use the peripheral_config to indicate that the channel is part
>          * of a video group. This requires matching use of the custom
>          * structure in each driver.
>          */
>         pconfig = config->peripheral_config;
>         if (WARN_ON(config->peripheral_size != 0 &&
>                     config->peripheral_size != sizeof(*pconfig)))
>                 return -EINVAL;

How about

 	if (WARN_ON(config->peripheral_config &&
		    config->peripheral_size != sizeof(*pconfig)))

> 
>         spin_lock_irqsave(&chan->lock, flags);
>         if (chan->id <= ZYNQMP_DPDMA_VIDEO2 &&
>             config->peripheral_size == sizeof(*pconfig))

And here you can test pconfig != NULL.

>                 chan->video_group = pconfig->video_group;
>         spin_unlock_irqrestore(&chan->lock, flags);
> 
>         return 0;
> 
> > With these issues addressed,
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
