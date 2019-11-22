Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CED106051
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVFjZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:39:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34241 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVFjZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Nov 2019 00:39:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id i7so513415edt.1;
        Thu, 21 Nov 2019 21:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um/vn9bBYtf12y/Lgwvm7NJKYttcP2/tI6ziOTvhmjI=;
        b=d67RED8w1bdDQ9XDuvT9H80V0hS5Rsp3CAFAXqJjJXNb+KkTKg7MMs+PUMmzk4nnsK
         uIwbw5Y6KYlAv6DKFjufsTLOrYVlPZN0/Zh+QJ5YC17QeXERUF/xAOpIfvoonvhvfp2O
         fzUDZttHcPf2LRvFURX+HV/wECLykQsrs1frAkazUNuqlxSFrnoNplf9ZMo3/asIaVS6
         yFUB2fKKqflOK89aubwSqvRy0CP1JW+2SaOHqAH1jsldTcs90ska+S+ZN516F+YJup20
         BZ+OklhMWlfKbZjFgf4MXJfnUWosAdbSF9dm0XGPj9WXHQX7+3yAoe49H0KvKxR8zPlO
         5S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um/vn9bBYtf12y/Lgwvm7NJKYttcP2/tI6ziOTvhmjI=;
        b=jN8OeuKwsGKIWYMLIElwSBcZwaFwMEmaDjn110hWmM4BIMfCFl/5WnguuZ355Cyd0j
         HQgUoKLg1a51GyImbx6ZhDoLr0f7YVFAtVAxqM2DZh6cADiplK8IoD072mPrW3oTJrAH
         oP5o5Zktd/RzQA6xfoH1oq/pwykdC8O9oJAGdGndrepN5aIPqNhZ0l8oZSOrhKQwIMmd
         UAI5cz2Y4zIbaCGOVxGuC7qZ2h0Y9k972DSeLvMAtkZnbM/DK5U7InbNeubKHqM6iyOj
         HeOQgi0ChXwDIH0l2DbSmXdY2yeXQfd/bJggNkUU1eDZ/UTLm8X79vTQlcFrRSlmrnzs
         Z7xw==
X-Gm-Message-State: APjAAAWTgKHI+U4e12E244/0TvqokzG/Kus+r/SgzcWhXe9N+q9JXErh
        iiM+m5TAARJnJsBDQthbj9ki6NgQVfWpYm4fLIg=
X-Google-Smtp-Source: APXvYqzcBSa9R45ssY+bmqXE4fR9Zg8VJJinlweHbT+4/6Djl+F/FaW0a+KMitUWqytA1jl4y2PAftiwvQ3nP1yqIek=
X-Received: by 2002:a17:906:6b01:: with SMTP id q1mr19481961ejr.162.1574401161025;
 Thu, 21 Nov 2019 21:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20191118073728.28366-1-hslester96@gmail.com> <20191122052320.GQ82508@vkoul-mobl>
In-Reply-To: <20191122052320.GQ82508@vkoul-mobl>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 22 Nov 2019 13:39:10 +0800
Message-ID: <CANhBUQ0FdCjRfbQAN6ZpygYmi8T5i24rP4_Rb-LKevcPD6CFkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: ti: edma: add missed pm_runtime_disable
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 22, 2019 at 1:23 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 18-11-19, 15:37, Chuhong Yuan wrote:
> > The driver forgets to call pm_runtime_disable in probe failure and
> > remove.
> > Add the calls and modify probe failure handling to fix it.
> >
> > Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/dma/ti/edma.c | 43 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 28 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> > index ba7c4f07fcd6..8be32fd9f762 100644
> > --- a/drivers/dma/ti/edma.c
> > +++ b/drivers/dma/ti/edma.c
> > @@ -2282,16 +2282,18 @@ static int edma_probe(struct platform_device *pdev)
> >       ret = pm_runtime_get_sync(dev);
> >       if (ret < 0) {
> >               dev_err(dev, "pm_runtime_get_sync() failed\n");
> > -             return ret;
> > +             goto err_disable_pm;
>
> Why would you disable here when sync has returned error?
>

Since pm_runtime_enable is called before sync, we cannot directly return
without disabling it as the original implementation does.

> >       }
> >
> >       ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >       if (ret)
> > -             return ret;
> > +             goto err_disable_pm;
> >
> >       ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
> > -     if (!ecc)
> > -             return -ENOMEM;
> > +     if (!ecc) {
> > +             ret = -ENOMEM;
> > +             goto err_disable_pm;
> > +     }
> >
> >       ecc->dev = dev;
> >       ecc->id = pdev->id;
> > @@ -2306,30 +2308,37 @@ static int edma_probe(struct platform_device *pdev)
> >               mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >               if (!mem) {
> >                       dev_err(dev, "no mem resource?\n");
> > -                     return -ENODEV;
> > +                     ret = -ENODEV;
> > +                     goto err_disable_pm;
> >               }
> >       }
> >       ecc->base = devm_ioremap_resource(dev, mem);
> > -     if (IS_ERR(ecc->base))
> > -             return PTR_ERR(ecc->base);
> > +     if (IS_ERR(ecc->base)) {
> > +             ret = PTR_ERR(ecc->base);
> > +             goto err_disable_pm;
> > +     }
> >
> >       platform_set_drvdata(pdev, ecc);
> >
> >       /* Get eDMA3 configuration from IP */
> >       ret = edma_setup_from_hw(dev, info, ecc);
> >       if (ret)
> > -             return ret;
> > +             goto err_disable_pm;
> >
> >       /* Allocate memory based on the information we got from the IP */
> >       ecc->slave_chans = devm_kcalloc(dev, ecc->num_channels,
> >                                       sizeof(*ecc->slave_chans), GFP_KERNEL);
> > -     if (!ecc->slave_chans)
> > -             return -ENOMEM;
> > +     if (!ecc->slave_chans) {
> > +             ret = -ENOMEM;
> > +             goto err_disable_pm;
> > +     }
> >
> >       ecc->slot_inuse = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_slots),
> >                                      sizeof(unsigned long), GFP_KERNEL);
> > -     if (!ecc->slot_inuse)
> > -             return -ENOMEM;
> > +     if (!ecc->slot_inuse) {
> > +             ret = -ENOMEM;
> > +             goto err_disable_pm;
> > +     }
> >
> >       ecc->default_queue = info->default_queue;
> >
> > @@ -2368,7 +2377,7 @@ static int edma_probe(struct platform_device *pdev)
> >                                      ecc);
> >               if (ret) {
> >                       dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> > -                     return ret;
> > +                     goto err_disable_pm;
> >               }
> >               ecc->ccint = irq;
> >       }
> > @@ -2384,7 +2393,7 @@ static int edma_probe(struct platform_device *pdev)
> >                                      ecc);
> >               if (ret) {
> >                       dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> > -                     return ret;
> > +                     goto err_disable_pm;
> >               }
> >               ecc->ccerrint = irq;
> >       }
> > @@ -2392,7 +2401,8 @@ static int edma_probe(struct platform_device *pdev)
> >       ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
> >       if (ecc->dummy_slot < 0) {
> >               dev_err(dev, "Can't allocate PaRAM dummy slot\n");
> > -             return ecc->dummy_slot;
> > +             ret = ecc->dummy_slot;
> > +             goto err_disable_pm;
> >       }
> >
> >       queue_priority_mapping = info->queue_priority_mapping;
> > @@ -2473,6 +2483,8 @@ static int edma_probe(struct platform_device *pdev)
> >
> >  err_reg1:
> >       edma_free_slot(ecc, ecc->dummy_slot);
> > +err_disable_pm:
> > +     pm_runtime_disable(dev);
> >       return ret;
> >  }
> >
> > @@ -2503,6 +2515,7 @@ static int edma_remove(struct platform_device *pdev)
> >       if (ecc->dma_memcpy)
> >               dma_async_device_unregister(ecc->dma_memcpy);
> >       edma_free_slot(ecc, ecc->dummy_slot);
> > +     pm_runtime_disable(dev);
> >
> >       return 0;
> >  }
> > --
> > 2.24.0
>
> --
> ~Vinod
