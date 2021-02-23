Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7F323184
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhBWThk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 14:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhBWThj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 14:37:39 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F58C061574
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 11:36:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id do6so36327089ejc.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO+KreOk7wpQiDXA/ym6majB1rdllI+u+y0Ed8XaCWc=;
        b=Vef8qz/LYOW2CQIxAi0O22T0yUZirr73lvsWWGMBcF17SXBSceGjv1UNQGS2Z9HdCT
         06rZZuwqoM43h436lnE1DmbfbP4CnI+FsqQ9A91kpnreXXv7N4jZzox7L5Wr+drcHqLh
         dJM9i5lxD5Qv6IYfjXVTic4SgL0xddMPVaDqz9bCkim7SadmbfzZoK1KTDsdGF2dDXcP
         9/tVhDnJACcWRfUaFBhvOacHUHh26i7yEuMVyqfEea7iH/7VSTWBsxKULRlPaV882cZI
         Z3FYj6APpCE4jKBAVEYkfrXwNIQ3/iQyv1RCO6fUvi+tsUnHOrW1zoc34Pyx1wqhRgDi
         A03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO+KreOk7wpQiDXA/ym6majB1rdllI+u+y0Ed8XaCWc=;
        b=Y54eZlfdymmTSO4QeioV0PFMznNuzv6TNCJXQ9Y8XPPLh/jb/tWzMt7YoqCEXBnDgf
         sh2yoO7s+nzYQe8wle1WqdITB6puPV1JJ3VbDyBy43IDhxzdFWLihe7nrBArojTS/gew
         cllXOpkY2WC4th/h2r0GDdlnPvzYXYldad4Gx+zGhsgzHDfgwPQw0zh71Z5wJwnBxFFI
         v9zx2Isb4BEmMoDzojXGnEa9HyQrsqExf3ON4mSvc9FNtLsYPXWFOS4o8zDzo3YVunCg
         hznNxWXuWMBld707QKg4w+qxAMxV7Tcf9SGzUsNgcClQ+fV+35sBklm2r+01x1DZuGjT
         Ypsw==
X-Gm-Message-State: AOAM531bs5ubq/y87D+HxTLcaCB5yAswwLxePxBmqLufioOe+0+GU7Yi
        Z4J9Gi1ec9v42gAXYepSlqktan7TTu8nib8GvsEiWg==
X-Google-Smtp-Source: ABdhPJwooNINl6WBYiHVVbVp9xRTIg5t2VlaY1AEPL7BzunJYUivRe5lzPMJLgTSRq+dKic/Y3tyN8A+TIE+Lo2ODMU=
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr48958ejc.418.1614109017714;
 Tue, 23 Feb 2021 11:36:57 -0800 (PST)
MIME-Version: 1.0
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com> <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com> <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
 <20210223181015.GC4247@nvidia.com> <CAPcyv4gA8E9ehFQCnUkz72w-Z1qHV=f_Y8XK7O9w-P3_aap65g@mail.gmail.com>
 <592ad3c7-1fc8-537d-a491-5013759109e1@intel.com> <CAPcyv4h2UTVuM1XOgQw1H0HgSdEcu3ZgRgRVtcB_pVg=seUUMQ@mail.gmail.com>
 <7b657d13-16c3-857f-a253-37113a20ff17@intel.com>
In-Reply-To: <7b657d13-16c3-857f-a253-37113a20ff17@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 11:36:53 -0800
Message-ID: <CAPcyv4gKEy9HoZkwdorRP7_7wjjCDBW5SuDiuWA76TPLhp+MBg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 11:18 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
> On 2/23/2021 11:53 AM, Dan Williams wrote:
> > On Tue, Feb 23, 2021 at 10:42 AM Dave Jiang <dave.jiang@intel.com> wrote:
> >>
> >> On 2/23/2021 11:30 AM, Dan Williams wrote:
> >>> On Tue, Feb 23, 2021 at 10:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>> On Tue, Feb 23, 2021 at 10:05:58AM -0800, Dan Williams wrote:
> >>>>> On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>>>> On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> >>>>>>> On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> >>>>>>>> On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> >>>>>>>>> Remove devm_* allocation of memory of 'struct device' objects.
> >>>>>>>>> The devm_* lifetime is incompatible with device->release() lifetime.
> >>>>>>>>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> >>>>>>>>> functions for each component in order to free the allocated memory at
> >>>>>>>>> the appropriate time. Each component such as wq, engine, and group now
> >>>>>>>>> needs to be allocated individually in order to setup the lifetime properly.
> >>>>>>>> I really don't understand why idxd has so many struct device objects.
> >>>>>>>>
> >>>>>>>> Typically I expect a simple driver to have exactly one, usually
> >>>>>>>> provided by its subsystem.
> >>>>>>>>
> >>>>>>>> What is the purpose?
> >>>>>>> When we initially designed this, Dan suggested to tie the device and
> >>>>>>> workqueue enabling to the Linux device model so that the enabling/disabling
> >>>>>>> can be done via bind/unbind of the sub drivers. So that's how we ended up
> >>>>>>> with all the 'struct device' under idxd and one for each configurable
> >>>>>>> component of the hardware device.
> >>>>>> IDXD created its own little bus just for that?? :\
> >>>>> Yes, for the dynamic configurability of the queues and engines it was
> >>>>> either a pile of ioctls, configfs, or a dynamic sysfs organization. I
> >>>>> did dynamic sysfs for libnvdimm and suggested idxd could use the same
> >>>>> model.
> >>>>>
> >>>>>> It is really weird that something called a workqueue would show up in
> >>>>>> the driver model at all.
> >>>>> It's a partition of the hardware functionality.
> >>>> But to what end? What else are you going to do with a slice of the
> >>>> IDXD device other than assign it to the IDXD driver?
> >>> idxd, unlike other dmaengines, has a dynamic relationship between
> >>> backend hardware engines and frontend submission queues. The
> >>> assignment of resources to queues is managed via sysfs. I think this
> >>> would be clearer if there were some more upstream usage examples
> >>> beyond dmaengine. However, consider one exploratory usage of
> >>> offloading memory copies in the pmem driver. Each pmem device could be
> >>> given a submission queue even if all pmem devices shared an engine on
> >>> the backend.
> >>>
> >>>> Is it for vfio? If so then why doesn't the vfio just bind to the WQ -
> >>>> why does it have an aux device??
> >>> Hmm, Dave? Couldn't there be an alternate queue driver that attached
> >>> vfio? At least that's how libnvdimm and dax devices change
> >>> personality, they just load a different driver for the same device.
> >> Would that work for a queue that's shared between multiple mdevs? And
> >> wasn't the main reason of pushing an aux dev under VFIO is so putting
> >> the code under the right maintainer for code review?
> > It's just a device with a vfio driver. Whether the device is idxd-dev
> > or aux-dev shouldn't matter. Just removes a level of indirection to
> > run vfio on idxd native devices since they're already there. I should
> > have made that connection myself.
> >
> > That said, now that I look the bus probe arch for idxd does too much
> > in the core, I would expect much of that logic to be pushed out to the
> > per driver probe in the leaf drivers, and I don't understand why "iax"
> > and "dsa" need their own bus types?
>
> I was wanting /sys/bus/dsa and /sys/bus/iax. I guess it's not necessary
> since /sys/bus/idxd is probably fine. Although now accel-config is
> depending on it. Do you think we should still change that?
>

ABI is unfortunately forever. If there are end user deployments that
depend on this bus proliferation it will take time and compat
libraries to unwind it. For example the conversion of /sys/class/dax
to /sys/bus/dax is reaching the point (~4 years out) where
/sys/class/dax support can finally be removed. I would recommend
deprecating all but one bus for the idxd configuration interface and
try to repair this escape.
