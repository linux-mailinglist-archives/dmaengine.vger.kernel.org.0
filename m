Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B565D3230C7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhBWSbA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhBWSa7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 13:30:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B2C061786
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 10:30:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d2so26919391edq.10
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUrwB+RhpTOtGzIIT77k5IidVmm3qqCWz/75JL2qOYk=;
        b=TZEQxsLWpiP8bFsfIAC+SeOcvMHXKpS4oY6iqrSSbzCKQ5WKtDJ2mnXyH+MSlkZpib
         OngZcBFVdV4hr9DTg5eMO2bGup/Ox5q1X1tn4hnMrVrCIj2MvIdpYFHJ84ZxBbAsHg2J
         3KJm1VohuEjx/faxRlaxk8S+MXD8c+WxQwU3iYLyPbrI4baHu6bof5xHgrBTzvw3Fju2
         EdD50QS4SOpqUXpS7IX8aTqj3T6rLRFWBwBA/xesXFU1B+FrO8f6cV4ukubgJPve3LXR
         tup7/a78HLIByCn4rU+29zZq9JddnN2zOgafXEYcioeMS6obYr4KMRfUnVps7Rf88oKI
         TEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUrwB+RhpTOtGzIIT77k5IidVmm3qqCWz/75JL2qOYk=;
        b=d4oYp0jk66N4GIKRPBjqJXCt0t5FH1iD0OyjNrUeDUtivvEOZDem6BHt/kitJv0E2Q
         DOdfRwxGgnUQijEcPaUikFvTDnYKfRo/5YBVgDq9R3l627VAvrGz/fKFSYY7NKcA7mUS
         NAJyoPwOxUevIEANPtncSANDfFAGgIkQkhnExTqewgkz+DiD/YgM8NUUW0VZKdT7n6Vk
         ltvTBeEIzLTDrM8ma8lqB1hCVzhgRW2MxYb7eCe7LDxIois3hKkjbmMsTDrb5qXYwPYW
         r3wesW1ZCRNE7LvD/o+i/ZxOfte74WkHA0CvwKJKXea3DT/9uEi0yKd/0jzskpbLqzyE
         pnOw==
X-Gm-Message-State: AOAM530SeAA9sP51bMClpuMVeMVhAfb131lZx4II43ErkaOUAF4/IbXL
        iu8JcVlTlavymltQkp7U9vru6GxnOjP1yrR1kYE8rtHIb4E=
X-Google-Smtp-Source: ABdhPJwznEg5P/0uFfZWuAaeMZzeTEq8W12SHIHUZnB8RbECfIkUuPjJNSpG+WpkpAWPF5f2NMrkk78Pr7ykrGhnx+0=
X-Received: by 2002:a05:6402:26d0:: with SMTP id x16mr1550139edd.52.1614105018124;
 Tue, 23 Feb 2021 10:30:18 -0800 (PST)
MIME-Version: 1.0
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com> <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com> <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com>
In-Reply-To: <20210223181015.GC4247@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 10:30:14 -0800
Message-ID: <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 10:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
> > On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> > > >
> > > > On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> > > > > On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> > > > > > Remove devm_* allocation of memory of 'struct device' objects.
> > > > > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > > > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > > > > functions for each component in order to free the allocated memory at
> > > > > > the appropriate time. Each component such as wq, engine, and group now
> > > > > > needs to be allocated individually in order to setup the lifetime properly.
> > > > > I really don't understand why idxd has so many struct device objects.
> > > > >
> > > > > Typically I expect a simple driver to have exactly one, usually
> > > > > provided by its subsystem.
> > > > >
> > > > > What is the purpose?
> > > >
> > > > When we initially designed this, Dan suggested to tie the device and
> > > > workqueue enabling to the Linux device model so that the enabling/disabling
> > > > can be done via bind/unbind of the sub drivers. So that's how we ended up
> > > > with all the 'struct device' under idxd and one for each configurable
> > > > component of the hardware device.
> > >
> > > IDXD created its own little bus just for that?? :\
> >
> > Yes, for the dynamic configurability of the queues and engines it was
> > either a pile of ioctls, configfs, or a dynamic sysfs organization. I
> > did dynamic sysfs for libnvdimm and suggested idxd could use the same
> > model.
> >
> > > It is really weird that something called a workqueue would show up in
> > > the driver model at all.
> >
> > It's a partition of the hardware functionality.
>
> But to what end? What else are you going to do with a slice of the
> IDXD device other than assign it to the IDXD driver?

idxd, unlike other dmaengines, has a dynamic relationship between
backend hardware engines and frontend submission queues. The
assignment of resources to queues is managed via sysfs. I think this
would be clearer if there were some more upstream usage examples
beyond dmaengine. However, consider one exploratory usage of
offloading memory copies in the pmem driver. Each pmem device could be
given a submission queue even if all pmem devices shared an engine on
the backend.

> Is it for vfio? If so then why doesn't the vfio just bind to the WQ -
> why does it have an aux device??

Hmm, Dave? Couldn't there be an alternate queue driver that attached
vfio? At least that's how libnvdimm and dax devices change
personality, they just load a different driver for the same device.
