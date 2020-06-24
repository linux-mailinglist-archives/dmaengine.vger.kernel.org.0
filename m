Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD7206E60
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbgFXH5F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389965AbgFXH5C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jun 2020 03:57:02 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC0C061573;
        Wed, 24 Jun 2020 00:57:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so1163974ioa.1;
        Wed, 24 Jun 2020 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwsl5Y0blEJP4hTqwqLpH/L66f7CdWeL56/kOIm2dJo=;
        b=O6y+cPs/buepS39s0exMrI3koN/Sen7jwoqQPnmuMWk/wBsZ+cLRFVwOm3nxSCGGJP
         M/fRROA3unTVnVtgq6bgytS8qJ1POHYJ3aWedi/q/8FNB9G/n3n3/oISsY2AJSPKlp+n
         3JDgvM7zQcVccKXGTCrNJ6h+nMPziCzKzm6K/AaLPjmyQf83MOgedijrw+o/nAim1wgy
         rBTWrtxDQ9/lOuKGCMXSyHOmR6VhLTD20F8lp4fRyDaRMRbPQCFa0E44A/zXX5IpiJ0Y
         xlf9nPT4CZgcC6UglwQ3mRBhdSdqM9pclA/K4UnJFFRQOX1W2cSNXuUw03d9zgwYjzYw
         wVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwsl5Y0blEJP4hTqwqLpH/L66f7CdWeL56/kOIm2dJo=;
        b=rLa9WNnRgSUI9fKHa33P5aUfsENln4gKRseEF4wANKHF3vAWoInABi4/YKfJ8ThaeZ
         NoEj3uaa0kgNxf6AWywiHEfEUaAUlNbXnwHkdUqiscVapCMX0HgbdrLu7blnXCfTBTC8
         22ndoxBpGfWMw+0Avn658jpoR2qXxgjVVGPNI8h7n4Vquf0xXwdgKLCqRuqYu6n5GrCK
         Dm7/l/kER9yFiJCB5LkdcFYELQ4M43oPhmbJPdyGkY97Ja9en8EH+2B4itdqHl8vhV8v
         czBkBuPpNZfi85Knu0VxgaG0wZYh+ak+tOQE7HwT65iVcWoYkUK+HF9PAAsoZ7LBAyNA
         gnsA==
X-Gm-Message-State: AOAM530cJ1BlAnjSWbSmQM5LYbyelx4PNyDrVFgqDzQCqYbsB3UbLGd9
        SJxbQ+qGHG7VsA7M6nUNEpfCj1fAFQiQIBUrNdo=
X-Google-Smtp-Source: ABdhPJyFJAP4+TaXCF2Tt+Wk3tGrJYPg7JNM1+dgJ26YdHRQBoShmqhUXw3+uFALNZOy1RB4yAS6Jsq3KbHg3t1PB14=
X-Received: by 2002:a05:6602:2d95:: with SMTP id k21mr30336056iow.59.1592985421897;
 Wed, 24 Jun 2020 00:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200603193648.19190-1-navid.emamdoost@gmail.com> <20200624074015.GP2324254@vkoul-mobl>
In-Reply-To: <20200624074015.GP2324254@vkoul-mobl>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Wed, 24 Jun 2020 02:56:51 -0500
Message-ID: <CAEkB2ERfzxwkixX75CzCMeRRv51v-fM2zo2gpQrjtgaBZ_nNHQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: stm32-dmamux: fix pm_runtime_get_sync fialure cases
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 24, 2020 at 2:40 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 03-06-20, 14:36, Navid Emamdoost wrote:
>
> s/fialure/failure
>
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put_sync if
> > pm_runtime_get_sync fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/dma/stm32-dmamux.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
> > index 12f7637e13a1..ab250d7eed29 100644
> > --- a/drivers/dma/stm32-dmamux.c
> > +++ b/drivers/dma/stm32-dmamux.c
> > @@ -140,6 +140,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> >       ret = pm_runtime_get_sync(&pdev->dev);
> >       if (ret < 0) {
> >               spin_unlock_irqrestore(&dmamux->lock, flags);
> > +             pm_runtime_put_sync(&pdev->dev);
>
> why put_sync()
>
> >               goto error;
> >       }
> >       spin_unlock_irqrestore(&dmamux->lock, flags);
> > @@ -340,8 +341,10 @@ static int stm32_dmamux_suspend(struct device *dev)
> >       int i, ret;
> >
> >       ret = pm_runtime_get_sync(dev);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             pm_runtime_put_sync(dev);
>
> here too

Is put_noidle() better?

>
> >               return ret;
> > +     }
> >
> >       for (i = 0; i < stm32_dmamux->dma_requests; i++)
> >               stm32_dmamux->ccr[i] = stm32_dmamux_read(stm32_dmamux->iomem,
> > --
> > 2.17.1
>
> --
> ~Vinod



-- 
Navid.
