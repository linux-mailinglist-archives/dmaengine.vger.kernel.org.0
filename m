Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87C10606C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKVFsp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfKVFsp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 00:48:45 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179C220708;
        Fri, 22 Nov 2019 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401723;
        bh=ko2RFeo5TU+AHVfNjkpG7qenzxQ4NHPt+kUd8Cp4/M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFoW/SfT2BI+UFDhNLVVFeHDmuab6aTcK39v22IXsIxj+rX16HetnjGKvuKaPqM4Z
         +4mR8lVYJ/lbNk+w0CLN98iq67FXSFgdXauTJTP7TguxemfXqJyWHKhf3bVPXaitxt
         KBFjQ7Mg5KzFKQpFCCZvoA1W6vIrbgXL158XMzBg=
Date:   Fri, 22 Nov 2019 11:18:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dmaengine: ti: edma: add missed pm_runtime_disable
Message-ID: <20191122054838.GU82508@vkoul-mobl>
References: <20191118073728.28366-1-hslester96@gmail.com>
 <20191122052320.GQ82508@vkoul-mobl>
 <CANhBUQ0FdCjRfbQAN6ZpygYmi8T5i24rP4_Rb-LKevcPD6CFkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhBUQ0FdCjRfbQAN6ZpygYmi8T5i24rP4_Rb-LKevcPD6CFkw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-11-19, 13:39, Chuhong Yuan wrote:
> On Fri, Nov 22, 2019 at 1:23 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 18-11-19, 15:37, Chuhong Yuan wrote:
> > > The driver forgets to call pm_runtime_disable in probe failure and
> > > remove.
> > > Add the calls and modify probe failure handling to fix it.
> > >
> > > Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/dma/ti/edma.c | 43 ++++++++++++++++++++++++++++---------------
> > >  1 file changed, 28 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> > > index ba7c4f07fcd6..8be32fd9f762 100644
> > > --- a/drivers/dma/ti/edma.c
> > > +++ b/drivers/dma/ti/edma.c
> > > @@ -2282,16 +2282,18 @@ static int edma_probe(struct platform_device *pdev)
> > >       ret = pm_runtime_get_sync(dev);
> > >       if (ret < 0) {
> > >               dev_err(dev, "pm_runtime_get_sync() failed\n");
> > > -             return ret;
> > > +             goto err_disable_pm;
> >
> > Why would you disable here when sync has returned error?
> >
> 
> Since pm_runtime_enable is called before sync, we cannot directly return
> without disabling it as the original implementation does.

Ok You should have cced Peter and TI folks on this. get_mainatiner.pl is
your friend, use it!

Peter care to test/review this. 
> 
> > >       }
> > >
> > >       ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > >       if (ret)
> > > -             return ret;
> > > +             goto err_disable_pm;
> > >
> > >       ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> > > -     if (!ecc)
> > > -             return -ENOMEM;
> > > +     if (!ecc) {
> > > +             ret = -ENOMEM;
> > > +             goto err_disable_pm;
> > > +     }
> > >
> > >       ecc->dev = dev;
> > >       ecc->id = pdev->id;
> > > @@ -2306,30 +2308,37 @@ static int edma_probe(struct platform_device *pdev)
> > >               mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >               if (!mem) {
> > >                       dev_err(dev, "no mem resource?\n");
> > > -                     return -ENODEV;
> > > +                     ret = -ENODEV;
> > > +                     goto err_disable_pm;
> > >               }
> > >       }
> > >       ecc->base = devm_ioremap_resource(dev, mem);
> > > -     if (IS_ERR(ecc->base))
> > > -             return PTR_ERR(ecc->base);
> > > +     if (IS_ERR(ecc->base)) {
> > > +             ret = PTR_ERR(ecc->base);
> > > +             goto err_disable_pm;
> > > +     }
> > >
> > >       platform_set_drvdata(pdev, ecc);
> > >
> > >       /* Get eDMA3 configuration from IP */
> > >       ret = edma_setup_from_hw(dev, info, ecc);
> > >       if (ret)
> > > -             return ret;
> > > +             goto err_disable_pm;
> > >
> > >       /* Allocate memory based on the information we got from the IP */
> > >       ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
> > >                                       sizeof(*ecc->slave_chans), GFP_KERNEL);
> > > -     if (!ecc->slave_chans)
> > > -             return -ENOMEM;
> > > +     if (!ecc->slave_chans) {
> > > +             ret = -ENOMEM;
> > > +             goto err_disable_pm;
> > > +     }
> > >
> > >       ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
> > >                                      sizeof(unsigned long), GFP_KERNEL);
> > > -     if (!ecc->slot_inuse)
> > > -             return -ENOMEM;
> > > +     if (!ecc->slot_inuse) {
> > > +             ret = -ENOMEM;
> > > +             goto err_disable_pm;
> > > +     }
> > >
> > >       ecc->default_queue = info->default_queue;
> > >
> > > @@ -2368,7 +2377,7 @@ static int edma_probe(struct platform_device *pdev)
> > >                                      ecc);
> > >               if (ret) {
> > >                       dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> > > -                     return ret;
> > > +                     goto err_disable_pm;
> > >               }
> > >               ecc->ccint = irq;
> > >       }
> > > @@ -2384,7 +2393,7 @@ static int edma_probe(struct platform_device *pdev)
> > >                                      ecc);
> > >               if (ret) {
> > >                       dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> > > -                     return ret;
> > > +                     goto err_disable_pm;
> > >               }
> > >               ecc->ccerrint = irq;
> > >       }
> > > @@ -2392,7 +2401,8 @@ static int edma_probe(struct platform_device *pdev)
> > >       ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
> > >       if (ecc->dummy_slot < 0) {
> > >               dev_err(dev, "Can't allocate PaRAM dummy slot\n");
> > > -             return ecc->dummy_slot;
> > > +             ret = ecc->dummy_slot;
> > > +             goto err_disable_pm;
> > >       }
> > >
> > >       queue_priority_mapping = info->queue_priority_mapping;
> > > @@ -2473,6 +2483,8 @@ static int edma_probe(struct platform_device *pdev)
> > >
> > >  err_reg1:
> > >       edma_free_slot(ecc, ecc->dummy_slot);
> > > +err_disable_pm:
> > > +     pm_runtime_disable(dev);
> > >       return ret;
> > >  }
> > >
> > > @@ -2503,6 +2515,7 @@ static int edma_remove(struct platform_device *pdev)
> > >       if (ecc->dma_memcpy)
> > >               dma_async_device_unregister(ecc->dma_memcpy);
> > >       edma_free_slot(ecc, ecc->dummy_slot);
> > > +     pm_runtime_disable(dev);
> > >
> > >       return 0;
> > >  }
> > > --
> > > 2.24.0
> >
> > --
> > ~Vinod

-- 
~Vinod
