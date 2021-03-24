Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E95347D66
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhCXQOB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhCXQNt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 12:13:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D2C061763
        for <dmaengine@vger.kernel.org>; Wed, 24 Mar 2021 09:13:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k10so33849817ejg.0
        for <dmaengine@vger.kernel.org>; Wed, 24 Mar 2021 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4w08T4uvz2D0xbYLh/HvXVZ/CqqaSfQ0cR8uid27WHY=;
        b=Vmv/RjNb0rDsh0rrYMfsRJ4XjeG8dLthIue9j8vi6iuJUYPP3aSLpJFCLwAYLpiGHR
         lXfnDH7nlV06mQ4DCflgTKkGkQ9hfLJZubV6iSdLK0stQ8xxKCdYmt2oq0qf8oN2L5Hs
         eHC2aIac5Zm6byAE0WWe8t1Hqd/RerDG7X9bederPRdHGvJkgdoBk/HC95HhM4PyFV72
         lu316wKEl8ZMLr0Y0kmPJLd9gqy808uK+iNYbdgR9P9Oe9DHzMuVesyWRENcMxvml1kZ
         KhAp2mG8y4P1ayxohVepchWCtg5UAlikl4G/Sf4zP3nvmxP/NFe+vMXxretYqLszpAST
         xZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4w08T4uvz2D0xbYLh/HvXVZ/CqqaSfQ0cR8uid27WHY=;
        b=RXspJ/aGvT6uaiBertyK3DaAWGhLAUyPMDt2x8G1w1mJYmu2H4jwis24xZ7FM5y+Yu
         GpkWqUh1vyfWQ6WUx4IwYDy6Sus2rvpTDUKZRacYjA3jCf9Tdytxi8ZINKH1vsDXRWZi
         h3RUzbPJ3O3K54AFqji0Fhy9WoH/EzlKMxYW5Lo5nXrCHKiChGQRhwNSV2b4fQV3VEnH
         m7tllkr/xdZ/5xyFLjxJB//jQW48sSpzvyZ7qX0oHGKzjlfigp6ItfugmygULrPOoCHu
         0O4WxsRLqxzQX7hoMdPZLucX3rhwz348MZ09EaBF4+1BUUR3iP0aEd4/sbqHqtoWMICu
         JWVA==
X-Gm-Message-State: AOAM532eTGF5hOJ5E/cUDJPiaViHH2JxNuRFTW2cT6Ri0zJcCrFNhs+9
        Jn1sppp8p+x0Pjb9SqWFt9jTTzzkhyp2cZcDysWWkA==
X-Google-Smtp-Source: ABdhPJx9KNWdIWjfBSSsawY00yaac7hp35ER8AtH/UV6nvlxXkIF3HrMnENgfcp+GVxWz25Y7Q3gk1B10If4VHrIRZY=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr4575130ejg.418.1616602426768;
 Wed, 24 Mar 2021 09:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com> <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
In-Reply-To: <20210324115645.GS2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 09:13:35 -0700
Message-ID: <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 24, 2021 at 5:33 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 23, 2021 at 10:07:46PM -0700, Dan Williams wrote:
> > On Thu, Mar 4, 2021 at 10:04 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Mar 03, 2021 at 07:56:30AM -0700, Dave Jiang wrote:
> > > > Remove devm_* allocation of memory of 'struct device' objects.
> > > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > > functions for each component in order to free the allocated memory at
> > > > the appropriate time. Each component such as wq, engine, and group now
> > > > needs to be allocated individually in order to setup the lifetime properly.
> > > > In the process also fix up issues from the fallout of the changes.
> > > >
> > > > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> > > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > v5:
> > > > - Rebased against 5.12-rc dmaengine/fixes
> > > > v4:
> > > > - fix up the life time of cdev creation/destruction (Jason)
> > > > - Tested with KASAN and other memory allocation leak detections. (Jason)
> > > >
> > > > v3:
> > > > - Remove devm_* for irq request and cleanup related bits (Jason)
> > > > v2:
> > > > - Remove all devm_* alloc for idxd_device (Jason)
> > > > - Add kref dep for dma_dev (Jason)
> > > >
> > > >  drivers/dma/idxd/cdev.c   |   32 +++---
> > > >  drivers/dma/idxd/device.c |   20 ++-
> > > >  drivers/dma/idxd/dma.c    |   13 ++
> > > >  drivers/dma/idxd/idxd.h   |    8 +
> > > >  drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
> > > >  drivers/dma/idxd/irq.c    |    6 +
> > > >  drivers/dma/idxd/sysfs.c  |   77 +++++++++----
> > > >  7 files changed, 290 insertions(+), 127 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > > > index 0db9b82ed8cf..1b98e06fa228 100644
> > > > +++ b/drivers/dma/idxd/cdev.c
> > > > @@ -259,6 +259,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
> > > >               return -ENOMEM;
> > > >
> > > >       dev = idxd_cdev->dev;
> > > > +     device_initialize(dev);
> > > >       dev->parent = &idxd->pdev->dev;
> > > >       dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
> > > >                    idxd->id, wq->id);
> > >
> > > dev_set_name() can fail
> >
> > Something bubbled up in my mind several hours after the fact looking
> > at Dave's lifetime reworks...
> >
> > As long as there are no error returns between dev_set_name() and
> > device_{add,register}() then those will abort with a "name_error:"
> > exit and require put_device() to clean up the name.
>
> IMHO, that is gross. We should not rely on implicit error handling like
> this, it is too easy to make later change and not realize that
> dev_set_name() can't be moved.
>
> > I'd much rather drivers depend on proper dev_set_name() ordering
> > relative to device_add() than pollute drivers with pedantic
> > dev_set_name() error
>
> I want to go the other direction and add a WARN_ON to dev_set_name()
> if device_initialize() hasn't been called yet.
>
> IMHO the initialize and add pattern is a bad idea just to save 1 line
> of code. Look at how many mistakes are in IDXD alone. Lots of places
> get the very tricky switch to put not kfree after register fails wrong
> as well.
>
> > handling. Unhandled dev_set_name() followed by device_{add,register}()
> > is the predominant registration pattern and it isn't broken afaics.
>
> It is very fragile, and IMHO, wrong. As a general pattern drivers
> should be setting the name very early so they can start using things
> like dev_dbg().
>
> > Only buses that expressly want to avoid fallback to a bus provided
> > dev_name() would need to make sure that dev_set_name() is successful.
>
> Yuk, now it is bus dependent if the shortcut works?
>
> People need to code this stuff robustly! Call device_initialize()
> early, check the error from dev_set_name(), do not call
> device_register()
>
> I *constantly* see drivers using these APIs wrong. Look at how many
> bugs are in IDXD around this area alone.
>
> Making it more subtle to save LOC is the wrong direction.

I came to that conclusion after the prospect of going to fix all the
other call sites that got this wrong made me balk.

The other option I was considering was moving the name into some
initialization helper, something like:

device_setup(struct device *dev, const char *fmt, ...)

Which is just:

device_initialize()
dev_set_name()

...then the name is set as early as the device is ready to filled in
with other details. Just checking for dev_set_name() failures does not
move the api forward in my opinion.
