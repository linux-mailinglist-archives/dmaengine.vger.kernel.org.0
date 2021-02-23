Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6932303B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhBWSGt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 13:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhBWSGo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Feb 2021 13:06:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453AEC061574
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 10:06:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hs11so35987975ejc.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Feb 2021 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtnhXrqiLeXyrdnPuoyV7CuG1+Rjg8GTNmPWVNs4GWs=;
        b=Hw2H48GvOqhbMeJ7CT3iQJ8gu76ID5kogF2nqfDF9vzT0wkM3LCgAMiMktvlkW2Zwp
         G3FKF8evj7aVCPGIikqYM9zBiYlwabourb2HPB+ceULeMLsaMsVIfEdD7XYe9jceZoVp
         qNLKDlgf0bRrWxExPipUYjLB3Jn4dCAmMS+ABK+V1pt9TmFntpxQqp3Xjqx2UXoruT6Z
         JVzmbUfgZ0LeI07sjGzouzKQskh87Ef9faiXhCVZKnvjhP8r4T/fAlWfuXvxboPsRm57
         N72+dXiLBPj9+1iIpeyDcCaBhfyomvRKezkFWN9xgm10K43KmjYkauGcn/5dsP9Y6uB7
         3AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtnhXrqiLeXyrdnPuoyV7CuG1+Rjg8GTNmPWVNs4GWs=;
        b=moqNS2OH0H5OSRNGJ4GSAnNITKoFhFqu4MC+DU2YqhS4aQmlOzytuo1zISGYEZDFow
         oooDETxCAtUA+8lAsMwhqFrdEa/CKmEJpM9a8ZuyHfuTkobCqVbboN1g1obxZUV4F8zU
         S8+0DHQOKh4oACUuqQekQbssqVQ7pifUI1nHfHBbXAwGOmnG34m50mPetjvTCr8ImpbZ
         e0jx7k/ttyC/R5aKQLB3I+QdOgAYUlXEI9d9VffhMo4ZBfjKS+49WobGzHzcPXirhtgR
         grj5yssKKyct4KRAautxSFEGheV/+SVLxmEEPR35DHVCi8ZNkOMiUHE5l9GivXQPt26A
         w1Hg==
X-Gm-Message-State: AOAM533XJ3p5jDKzSluUykA9UVSI29Hc29Vf/r28ziNlYLdV0fn+n1ps
        ekDiyK+edvFYnYLnBpbCg0UWbbwGqjMeUTQGYnasmQ==
X-Google-Smtp-Source: ABdhPJwAllPLVSsk16fTVF45ZOHXpDubC6vgNYEvKKNdF+phOx0B4O1hHik7qAZr32oau/GIWGmMLrYeW0J8px01GHk=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr26565306ejr.264.1614103563048;
 Tue, 23 Feb 2021 10:06:03 -0800 (PST)
MIME-Version: 1.0
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com> <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
 <20210223170851.GZ4247@nvidia.com>
In-Reply-To: <20210223170851.GZ4247@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 10:05:58 -0800
Message-ID: <CAPcyv4j3RTBqVmAKSRVOzdQ8yZVMU0_yunSGSiV93rYwHBEx9Q@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 23, 2021 at 9:09 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Feb 23, 2021 at 08:27:46AM -0700, Dave Jiang wrote:
> >
> > On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> > > On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
> > > > Remove devm_* allocation of memory of 'struct device' objects.
> > > > The devm_* lifetime is incompatible with device->release() lifetime.
> > > > Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
> > > > functions for each component in order to free the allocated memory at
> > > > the appropriate time. Each component such as wq, engine, and group now
> > > > needs to be allocated individually in order to setup the lifetime properly.
> > > I really don't understand why idxd has so many struct device objects.
> > >
> > > Typically I expect a simple driver to have exactly one, usually
> > > provided by its subsystem.
> > >
> > > What is the purpose?
> >
> > When we initially designed this, Dan suggested to tie the device and
> > workqueue enabling to the Linux device model so that the enabling/disabling
> > can be done via bind/unbind of the sub drivers. So that's how we ended up
> > with all the 'struct device' under idxd and one for each configurable
> > component of the hardware device.
>
> IDXD created its own little bus just for that?? :\

Yes, for the dynamic configurability of the queues and engines it was
either a pile of ioctls, configfs, or a dynamic sysfs organization. I
did dynamic sysfs for libnvdimm and suggested idxd could use the same
model.

> It is really weird that something called a workqueue would show up in
> the driver model at all.

It's a partition of the hardware functionality.
