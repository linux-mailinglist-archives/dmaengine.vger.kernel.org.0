Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66791E6CAA
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbgE1UfN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388955AbgE1UfI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 16:35:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583EC08C5C6;
        Thu, 28 May 2020 13:35:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t8so93627pju.3;
        Thu, 28 May 2020 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVkhfDZvk3ofHA+hc3cdGBgGSC3cOVs1givhIYHdY58=;
        b=GPahTx1vQaoKj92+KlPzRf45xBabahpJ31smgBmXf/iPzD1MfkyFHZHqsWOuzHCVCK
         dwKI4XD1YVxYlChv08O93FlHCaPMERp8lzwz4686CK+AaGRGfsWyntgmbyadMpZCNmS3
         WfarWY5PcOKN40z2CYrHKN5B2RuhlcNyg0jJ0cUNF1OifJx3WubpeM36vnECk2tKTWqR
         xTTAHAhjPA8Q0DEVKaj9rBiu4wDPXBuq1rMXtdPsTiWWntaJHFkamnK3b9FxQJdkHtBS
         KpCj86njgAtzt4yxo5COnolRUCgloi+qo7JgKUUA7MAatSI9aWTtnNPPS/pOILmTaFeZ
         Up8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVkhfDZvk3ofHA+hc3cdGBgGSC3cOVs1givhIYHdY58=;
        b=FCknJbQKG/ZSY5cuJDuUyyEGkFctTCjGVY3CFGRiuS39rOzIpuv+GbzSd9ntivIbKA
         KPUfkwQkY1Ej6MRA1Z4672XxANsWv86BSormPydsLzcbiAAOM9q1G0+vkXjxyLaL2BCN
         3noenk3JepSurWOGEF3J5qlpJeMhtMMdI3bhKPLwR3NZzk5oTYiuMhVKor/04ab+Jvd5
         X0vtUtI5TfBtF/+RNkOYN7SMsAGLpesMnTLB7ckY/3N3W7ZNFE1U54QjVGZ70+dAaGlU
         Zt8u6dWk6pyQIwuqLYcLh9Ev/igYADzH1eTUCmRitsghr71IdJb4lDH7OOTF5C95SrX0
         AUjg==
X-Gm-Message-State: AOAM531GdvesKgriM3eyP+msMR2oheJHIxD61dDMSWxNtvC9P4FCua+c
        ukKvsZ+xqPtRNjYvj/BRzdT5vIgb7FGzde96cF0=
X-Google-Smtp-Source: ABdhPJxiq65ETqEjbkblg6sCIOUSCsFRbS3IqDB/IUANc6WuNjXrm7f3lj3wkHzRpe+cdob7YAStIUo18VJKaou1qBA=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr5881332pjb.228.1590698108362;
 Thu, 28 May 2020 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-6-Sergey.Semin@baikalelectronics.ru>
 <20200528144257.GS1634618@smile.fi.intel.com> <20200528151902.vemr7aolvtean2f3@mobilestation>
In-Reply-To: <20200528151902.vemr7aolvtean2f3@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 May 2020 23:34:52 +0300
Message-ID: <CAHp75Ve5Rf6ioYFULLGLWTaGdWNQikaPAFOoWjwXxmCbJ7tsyQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] dmaengine: Introduce DMA-device device_caps callback
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 28, 2020 at 6:23 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Thu, May 28, 2020 at 05:42:57PM +0300, Andy Shevchenko wrote:
> > On Wed, May 27, 2020 at 01:50:16AM +0300, Serge Semin wrote:

...

> > > +   if (device->device_caps)
> > > +           device->device_caps(chan, caps);
> > > +
> > >     return 0;
> >
> > I dunno why this returns int, but either we get rid of this returned value
> > (perhaps in the future, b/c it's not directly related to this series), or
> > something like
> >
> >       if (device->device_caps)
> >               return device->device_caps(chan, caps);
>
> It returns int because dma_get_slave_caps() check parameters and some other
> stuff.
>
> Regarding device_caps() callback having a return value. IMO it's redundant.
> The only thing what the callback should do is to update the caps and device
> is supposed to know it' capabilities, otherwise who else should know? So I
> don't see why device_caps would be needed.

It might be useful in some (weird?) cases, when you would like to
override a parameter which device provides to relax it (my common
sense tells me that device on global level should not be restrictive,
rather permissive), which might be considered as an error (we would
like to set return capability out of the boundaries of global ones
which provided on device level).

But okay, up to you and Vinod.

-- 
With Best Regards,
Andy Shevchenko
