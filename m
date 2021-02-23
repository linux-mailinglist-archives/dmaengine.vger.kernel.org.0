Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB94E32310E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhBWSym (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhBWSyk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 13:54:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93091C061786
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 10:54:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d2so26987137edq.10
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qa04iB1rBohTTuBMdnxUAMzY3V/z1UDw3hp6JPcdtpc=;
        b=jOGNSmdl1jqlIAeeig/4sKqaVHCyymR/0sy10mG2IhXWcnDpHcDjGMrJiUIJUi4O3G
         uSCzUlKmdcU5XMyQ6oyzLK/o2KMPJ7CwsIYZO9gOvWxwzzJwadaCNbU9pmC/UG93Wgb7
         gu0FkiuSMc6BPYjawf06wbvW94BM9R8F0r5gWG7krZve0lXr/jA20N6wqcVC9WtpOy+K
         /xMnCTlFjFYQVexkiAgVmIQv1QzAawSJCsGCL4d+fWqAZXQBQRSiaHoBqls8BpEbdGCA
         KrziXUNRkRhNvb56zas0lFkgf4UxyuNuPPqeMdN17y7qGKZP11rACGa0fAG1cptqMTlB
         JsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qa04iB1rBohTTuBMdnxUAMzY3V/z1UDw3hp6JPcdtpc=;
        b=FU/trtxeUrYQdTRGG8i4mr3vU6df/i8zJyVbez1SQc6gBQIE3W8dP4mSysl1XgNse7
         UgEpxWXbvudnF1epAdWiZ1KLsUsdLq0Wog4jOdnIYvwaEGsUhv1QTqDsMdhS2F/sNb1U
         ZaQgk6khPN52UCVn9cIt5V38Gg8KtPXnd7nXjgGF4EwyNVuxqjxvqXjgDF4lir8mac1w
         5C53N1RpClNmBPGN6M0+Lku/m+/4zuhXPiD51LbDopl5GQo2jiYOkJrp3mFU8sK0fhsX
         qjhMLMcXAAA4kLpuGoyQnkcz2dNB0riv15e6EbP3l1WTAbr4WNCDs2uq3eqJRCJd9VcZ
         9D1w==
X-Gm-Message-State: AOAM531cgy6MjwV2HXOt8U8mc0TkAB2/4d69nQCJdQqQwFbd90hSolG7
        EqvxoWBmA8HfNDHczjTk7rc/m2LoeY3SA5+WtcFB5g==
X-Google-Smtp-Source: ABdhPJxy1sH95P0pwhX3GJg7skTcWTGaITrSrwfRoWh8eUJLI+fn9KoGQVyy6fAdMtPTY4hdEzfoFAnuPKWOE2JTWbM=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr29057734edc.97.1614106438366;
 Tue, 23 Feb 2021 10:53:58 -0800 (PST)
MIME-Version: 1.0
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com> <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com> <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com> <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
 <592ad3c7-1fc8-537d-a491-5013759109e1@intel.com>
In-Reply-To: <592ad3c7-1fc8-537d-a491-5013759109e1@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 10:53:54 -0800
Message-ID: <CAPcyv4h2UTVuM1XOgQw1H0HgSdEcu3ZgRgRVtcB_pVg=seUUMQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 10:42 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
> On 2/23/2021 11:30 AM, Dan Williams wrote:
> > On Tue, Feb 23, 2021 at 10:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >> On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
> >>> On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>> On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> >>>>> On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> >>>>>> On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> >>>>>>> Remove devm_* allocation of memory of 'struct device' objects.
> >>>>>>> The devm_* lifetime is incompatible with device->release() lifetime.
> >>>>>>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> >>>>>>> functions for each component in order to free the allocated memory at
> >>>>>>> the appropriate time. Each component such as wq, engine, and group now
> >>>>>>> needs to be allocated individually in order to setup the lifetime properly.
> >>>>>> I really don't understand why idxd has so many struct device objects.
> >>>>>>
> >>>>>> Typically I expect a simple driver to have exactly one, usually
> >>>>>> provided by its subsystem.
> >>>>>>
> >>>>>> What is the purpose?
> >>>>> When we initially designed this, Dan suggested to tie the device and
> >>>>> workqueue enabling to the Linux device model so that the enabling/disabling
> >>>>> can be done via bind/unbind of the sub drivers. So that's how we ended up
> >>>>> with all the 'struct device' under idxd and one for each configurable
> >>>>> component of the hardware device.
> >>>> IDXD created its own little bus just for that?? :\
> >>> Yes, for the dynamic configurability of the queues and engines it was
> >>> either a pile of ioctls, configfs, or a dynamic sysfs organization. I
> >>> did dynamic sysfs for libnvdimm and suggested idxd could use the same
> >>> model.
> >>>
> >>>> It is really weird that something called a workqueue would show up in
> >>>> the driver model at all.
> >>> It's a partition of the hardware functionality.
> >> But to what end? What else are you going to do with a slice of the
> >> IDXD device other than assign it to the IDXD driver?
> > idxd, unlike other dmaengines, has a dynamic relationship between
> > backend hardware engines and frontend submission queues. The
> > assignment of resources to queues is managed via sysfs. I think this
> > would be clearer if there were some more upstream usage examples
> > beyond dmaengine. However, consider one exploratory usage of
> > offloading memory copies in the pmem driver. Each pmem device could be
> > given a submission queue even if all pmem devices shared an engine on
> > the backend.
> >
> >> Is it for vfio? If so then why doesn't the vfio just bind to the WQ -
> >> why does it have an aux device??
> > Hmm, Dave? Couldn't there be an alternate queue driver that attached
> > vfio? At least that's how libnvdimm and dax devices change
> > personality, they just load a different driver for the same device.
>
> Would that work for a queue that's shared between multiple mdevs? And
> wasn't the main reason of pushing an aux dev under VFIO is so putting
> the code under the right maintainer for code review?

It's just a device with a vfio driver. Whether the device is idxd-dev
or aux-dev shouldn't matter. Just removes a level of indirection to
run vfio on idxd native devices since they're already there. I should
have made that connection myself.

That said, now that I look the bus probe arch for idxd does too much
in the core, I would expect much of that logic to be pushed out to the
per driver probe in the leaf drivers, and I don't understand why "iax"
and "dsa" need their own bus types?
