Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81C3A9494
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFPIBl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 04:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhFPIBk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 04:01:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2095261159;
        Wed, 16 Jun 2021 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623830374;
        bh=Vhg66Ki7/0j8GnsT6DdhvYwdwLbPMP4JXdPUPSB5V+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rASKUcxVFn4Dd4Ci7O5O1ymsm83Cqf90kwhdfvqTn/07kBQ0VUgjJ3zWeM8NWWcMo
         zYCy/+pZ2xs2KAbMdBCgtnBAnOqrwEQevpc4WGQG8RP4pbI/Wy+Hle+xRNpaLWASkN
         7HvZTL95GYp2Qkgf+pyPt2mevQCc5Mr7qIzBxqYY=
Date:   Wed, 16 Jun 2021 09:59:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay R Mehta <sanmehta@amd.com>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YMmvZBP9QNc5jf5L@kroah.com>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl>
 <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl>
 <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com>
 <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
 <YMmt1qhC1dIiYx7O@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmt1qhC1dIiYx7O@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 16, 2021 at 01:22:54PM +0530, Vinod Koul wrote:
> On 16-06-21, 12:27, Sanjay R Mehta wrote:
> > 
> > 
> > On 6/16/2021 11:46 AM, Greg KH wrote:
> > > [CAUTION: External Email]
> > > 
> > > On Wed, Jun 16, 2021 at 10:24:52AM +0530, Sanjay R Mehta wrote:
> > >>
> > >>
> > >> On 6/16/2021 9:45 AM, Vinod Koul wrote:
> > >>> [CAUTION: External Email]
> > >>>
> > >>> On 15-06-21, 16:50, Sanjay R Mehta wrote:
> > >>>
> > >>>>>> +static struct pt_device *pt_alloc_struct(struct device *dev)

In looking at this, why are you dealing with a "raw" struct device?
Shouldn't this be a parent pointer?  Why not pass in the real type that
this can be made a child of?


> > >>>>>> +{
> > >>>>>> +     struct pt_device *pt;
> > >>>>>> +
> > >>>>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
> > >>>>>> +
> > >>>>>> +     if (!pt)
> > >>>>>> +             return NULL;
> > >>>>>> +     pt->dev = dev;
> > >>>>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
> > >>>>>
> > >>>>> What is the use of this number?
> > >>>>>
> > >>>>
> > >>>> There are eight similar instances of this DMA engine on AMD SOC.
> > >>>> It is to differentiate each of these instances.
> > >>>
> > >>> Are they individual device objects?
> > >>>
> > >>
> > >> Yes, they are individual device objects.
> > > 
> > > Then what is "ord" for?  Why are you using an atomic variable for this?
> > > What does this field do?  Why doesn't the normal way of naming a device
> > > come into play here instead?
> > > 
> > 
> > Hi Greg,
> > 
> > The value of "ord" is incremented for each device instance and then it
> > is used to store different name for each device as shown in below snippet.
> > 
> > 	pt->ord = atomic_inc_return(&pt_ordinal);
> > 	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);
> 
> Okay why not use device->name ?

Ah, I missed this.  Yes, do not have 2 names for the same structure,
that is wasteful and confusing.

thanks,

greg k-h
