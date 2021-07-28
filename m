Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DBB3D89DE
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhG1Ihi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 28 Jul 2021 04:37:38 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43759 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhG1Ihf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jul 2021 04:37:35 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2BE601BF20E;
        Wed, 28 Jul 2021 08:37:33 +0000 (UTC)
Date:   Wed, 28 Jul 2021 10:37:32 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: use module_platform_driver
Message-ID: <20210728103732.3befa390@fixe.home>
In-Reply-To: <YQEUFADKhGtzz++g@matsya>
References: <20210625090042.17085-1-clement.leger@bootlin.com>
        <YQD/skGeS0rzYS5P@matsya>
        <20210728093831.27430737@fixe.home>
        <YQEUFADKhGtzz++g@matsya>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le Wed, 28 Jul 2021 13:53:48 +0530,
Vinod Koul <vkoul@kernel.org> a écrit :

> On 28-07-21, 09:38, Clément Léger wrote:
> > Le Wed, 28 Jul 2021 12:26:50 +0530,
> > Vinod Koul <vkoul@kernel.org> a écrit :
> >   
> > > On 25-06-21, 11:00, Clément Léger wrote:  
> > > > The driver was previously probed with platform_driver_probe.
> > > > This does not allow the driver to be probed again later if
> > > > probe function returns -EPROBE_DEFER. This patch replace the
> > > > use of platform_driver_probe with module_platform_driver which
> > > > allows that.
> > > > 
> > > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > > > ---
> > > >  drivers/dma/at_xdmac.c | 6 +-----
> > > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > > > index 64a52bf4d737..109a4c0895f4 100644
> > > > --- a/drivers/dma/at_xdmac.c
> > > > +++ b/drivers/dma/at_xdmac.c
> > > > @@ -2238,11 +2238,7 @@ static struct platform_driver
> > > > at_xdmac_driver = { }
> > > >  };
> > > >  
> > > > -static int __init at_xdmac_init(void)
> > > > -{
> > > > -	return platform_driver_probe(&at_xdmac_driver,
> > > > at_xdmac_probe); -}
> > > > -subsys_initcall(at_xdmac_init);
> > > > +module_platform_driver(at_xdmac_driver);    
> > > 
> > > You are also changing the init call here, there is a reason why
> > > dmaengine drivers are subsys_initcall.. have you tested this?
> > >   
> > 
> > I understood that the subsys initcall was there to probe the DMA
> > driver earlier than other drivers (at least I guess this was the
> > reason). I  
> 
> That is correct
> 
> > also tested it and can confirm you this works as expected on my
> > platform (sama5d2_xplained and sama5d27_som1).
> > 
> > In my configuration, the clocks are provided using SCMI and the SCMI
> > driver probes them later than other drivers.   
> 
> Heh, clocks should get probed even earlier

Yes, even clocksources might need them... But that's another story.

> 
> > With the current subsys_initcall, platform_driver_probe calls
> > __platform_driver_probe which will eventually calls platform_probe.
> > This one will fails because SCMI clocks are not available at this
> > time. And as said in the kernel doc, __platform_driver_probe is
> > incompatible with deferred probing. This leads to failure of all
> > drivers that needs DMA channels provbided by at_xdmac.
> > 
> > With module_platform_driver, the at_xdmac driver is correctly probed
> > again later and all drivers that depends on DMA channels provided by
> > this one are also correctly probed. The deferred probing mechanism
> > seems to do its job correctly (at least in my case).  
> 
> OK would then recommend making it like module_platform_driver ie
> remove platform_driver_probe, so the defer probe would work, but keep
> the init at subsys level. That should work for you while keeping this
> sane for folks that dont need this
> 

Ok, I'll modify it this way, thanks.



-- 
Clément Léger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
