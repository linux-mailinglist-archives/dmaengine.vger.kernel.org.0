Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3809D3D89B5
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 10:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhG1IXz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 04:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235070AbhG1IXz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 04:23:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C665A6052B;
        Wed, 28 Jul 2021 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627460633;
        bh=JoL5rq4g2TYiFcHdBW5n8r5L+GbGCJK1HloPFAw/yUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOAhwpI1yPbejtEhoQx7rMG5w0ynfAtNeucI9UbyeChRmeQVvakqDG1A44DWowXGJ
         wZ+sZtaUi3E2gdgtPeBn49xdLz3LRpqnpeB4z/RDeT+JysJgLKv4nheODa+m+1MiV2
         kEGwDolaplwBmgxM8VETT2V0mF9REOyEi8ykMxNk4egw+kI++oJD67gmzPoLuOIH2N
         MTP5TiPJvsM6sXxThfwlOIc5MxRIGBLDEGWuxpVUR48WLnk1kfwqFADsML0ao33JDq
         PXeW6Rny1ggVRPV4QEQdiORxCKoP9D6q/5DzrqwUgqFrWfkaNQ2BVm2FGPHmSJb9RT
         jEVdaFNFOtpHg==
Date:   Wed, 28 Jul 2021 13:53:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: use module_platform_driver
Message-ID: <YQEUFADKhGtzz++g@matsya>
References: <20210625090042.17085-1-clement.leger@bootlin.com>
 <YQD/skGeS0rzYS5P@matsya>
 <20210728093831.27430737@fixe.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728093831.27430737@fixe.home>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-07-21, 09:38, Clément Léger wrote:
> Le Wed, 28 Jul 2021 12:26:50 +0530,
> Vinod Koul <vkoul@kernel.org> a écrit :
> 
> > On 25-06-21, 11:00, Clément Léger wrote:
> > > The driver was previously probed with platform_driver_probe. This
> > > does not allow the driver to be probed again later if probe function
> > > returns -EPROBE_DEFER. This patch replace the use of
> > > platform_driver_probe with module_platform_driver which allows that.
> > > 
> > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > > ---
> > >  drivers/dma/at_xdmac.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > > index 64a52bf4d737..109a4c0895f4 100644
> > > --- a/drivers/dma/at_xdmac.c
> > > +++ b/drivers/dma/at_xdmac.c
> > > @@ -2238,11 +2238,7 @@ static struct platform_driver
> > > at_xdmac_driver = { }
> > >  };
> > >  
> > > -static int __init at_xdmac_init(void)
> > > -{
> > > -	return platform_driver_probe(&at_xdmac_driver,
> > > at_xdmac_probe); -}
> > > -subsys_initcall(at_xdmac_init);
> > > +module_platform_driver(at_xdmac_driver);  
> > 
> > You are also changing the init call here, there is a reason why
> > dmaengine drivers are subsys_initcall.. have you tested this?
> > 
> 
> I understood that the subsys initcall was there to probe the DMA driver
> earlier than other drivers (at least I guess this was the reason). I

That is correct

> also tested it and can confirm you this works as expected on my
> platform (sama5d2_xplained and sama5d27_som1).
> 
> In my configuration, the clocks are provided using SCMI and the SCMI
> driver probes them later than other drivers. 

Heh, clocks should get probed even earlier

> With the current subsys_initcall, platform_driver_probe calls
> __platform_driver_probe which will eventually calls platform_probe.
> This one will fails because SCMI clocks are not available at this time.
> And as said in the kernel doc, __platform_driver_probe is incompatible
> with deferred probing. This leads to failure of all drivers that needs
> DMA channels provbided by at_xdmac.
> 
> With module_platform_driver, the at_xdmac driver is correctly probed
> again later and all drivers that depends on DMA channels provided by
> this one are also correctly probed. The deferred probing mechanism seems
> to do its job correctly (at least in my case).

OK would then recommend making it like module_platform_driver ie remove
platform_driver_probe, so the defer probe would work, but keep the init
at subsys level. That should work for you while keeping this sane for
folks that dont need this

-- 
~Vinod
