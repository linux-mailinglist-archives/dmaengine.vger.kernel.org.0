Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F943470A4
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 06:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhCXFHz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhCXFHz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Mar 2021 01:07:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D6BC061763
        for <dmaengine@vger.kernel.org>; Tue, 23 Mar 2021 22:07:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so26054312edu.10
        for <dmaengine@vger.kernel.org>; Tue, 23 Mar 2021 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkOm8TzBvXHvaBrJ3ZltRm9dFaZn4nsynemj35eRm2U=;
        b=F0xzCy+tdMMaJ05EFx6iI4K6L5cNG1noW5ELut/UJnl+utVZMOF9+YqqfBUzF7v6wK
         eJDS+91gUKbt9PHh5pSQIZImovVE7kVUekMi8zkD2Q+FJkRV8MHQWFAJdpIwDrQsX464
         kXqjBlAC9WBflr9M6fJqRuFUxWpxQAmCfZeEcP66p8v/7OVhfcKT+fhnx4dnqJ2nCF0r
         Hg7tbMMyMSrMFtLXhNT73XP9bXOk2sSPzgKbCHTu60c2wqukPOMBsFMVhO84gRWxrplx
         BjDJCGHZsnW9zjb2kSavOxdfXrzPllqB/MotM69nqrP54DOL9AjmBwvfU6ZO3NslBdoe
         TLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkOm8TzBvXHvaBrJ3ZltRm9dFaZn4nsynemj35eRm2U=;
        b=A8yDfRut7ECAA/DvTlEdbmNC9JMES7ppI7AFeT+Sd4zM+63pAgSpMk8/vlXts1e7Sj
         XTkbYTgxBtEqbmGDbCea5sk8ltEIDsY8xndwmUCxSNR5TQMflNrNuUK4bZc8PcCq8t6J
         anGpTzGfolmRwr+ixBNdk/WQqxc//Q6W7WpfD4Dl/rf40i31XGKK7df6eAmqqhyztvE4
         e/XnjWwmZRGIsXHjUTtf5t5q1KuxNfx56sEb+OOK0KoGwjcw1f3vTtHicWiv0A0IFQfz
         GA/sEw5TJcOpZQqVwsyivQ0ZwUXkbMhfW0wlaR9vi7Jxh9K7m3YEoR5zG+MwzaobE3UA
         3gqg==
X-Gm-Message-State: AOAM531Qd9m5+/saqTIdES4ywXlmNKyy5QTLbaTqxf0kWv9ECE8emhxJ
        nSZfeE2XFYqzH9wwvzSfPyoMKbYSf+T4tSsyB8i5Hg==
X-Google-Smtp-Source: ABdhPJzehiwdjpWTCXJqIv71SIl6uAVI1EkMVzVHXrImBdrqQ9NDHqqlY1ImBs8QRdfO6XEHWnhQB33SCSUnZwjXtxA=
X-Received: by 2002:a50:e607:: with SMTP id y7mr1472719edm.18.1616562474014;
 Tue, 23 Mar 2021 22:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
In-Reply-To: <20210304180308.GH4247@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Mar 2021 22:07:46 -0700
Message-ID: <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 4, 2021 at 10:04 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Mar 03, 2021 at 07:56:30AM -0700, Dave Jiang wrote:
> > Remove devm_* allocation of memory of 'struct device' objects.
> > The devm_* lifetime is incompatible with device->release() lifetime.
> > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > functions for each component in order to free the allocated memory at
> > the appropriate time. Each component such as wq, engine, and group now
> > needs to be allocated individually in order to setup the lifetime properly.
> > In the process also fix up issues from the fallout of the changes.
> >
> > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > v5:
> > - Rebased against 5.12-rc dmaengine/fixes
> > v4:
> > - fix up the life time of cdev creation/destruction (Jason)
> > - Tested with KASAN and other memory allocation leak detections. (Jason)
> >
> > v3:
> > - Remove devm_* for irq request and cleanup related bits (Jason)
> > v2:
> > - Remove all devm_* alloc for idxd_device (Jason)
> > - Add kref dep for dma_dev (Jason)
> >
> >  drivers/dma/idxd/cdev.c   |   32 +++---
> >  drivers/dma/idxd/device.c |   20 ++-
> >  drivers/dma/idxd/dma.c    |   13 ++
> >  drivers/dma/idxd/idxd.h   |    8 +
> >  drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
> >  drivers/dma/idxd/irq.c    |    6 +
> >  drivers/dma/idxd/sysfs.c  |   77 +++++++++----
> >  7 files changed, 290 insertions(+), 127 deletions(-)
> >
> > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > index 0db9b82ed8cf..1b98e06fa228 100644
> > +++ b/drivers/dma/idxd/cdev.c
> > @@ -259,6 +259,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
> >               return -ENOMEM;
> >
> >       dev = idxd_cdev->dev;
> > +     device_initialize(dev);
> >       dev->parent = &idxd->pdev->dev;
> >       dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
> >                    idxd->id, wq->id);
>
> dev_set_name() can fail

Something bubbled up in my mind several hours after the fact looking
at Dave's lifetime reworks...

As long as there are no error returns between dev_set_name() and
device_{add,register}() then those will abort with a "name_error:"
exit and require put_device() to clean up the name. I'd much rather
drivers depend on proper dev_set_name() ordering relative to
device_add() than pollute drivers with pedantic dev_set_name() error
handling. Unhandled dev_set_name() followed by device_{add,register}()
is the predominant registration pattern and it isn't broken afaics.

Only buses that expressly want to avoid fallback to a bus provided
dev_name() would need to make sure that dev_set_name() is successful.

I don't think Dave needs to respin for this, but as I went to
investigate why those changes rubbed me the wrong way it led me back
here.
