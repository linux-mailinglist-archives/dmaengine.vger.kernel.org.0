Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FDF3A9476
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFPHzE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 03:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhFPHzD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 03:55:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F9C60FDB;
        Wed, 16 Jun 2021 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623829978;
        bh=CwVhy/XtNtzhNeGQ44S4VfDUyl2kVZR4eIdRTYD1qsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0ZNKkTRz1bxdxBJABJqVaaig8Gnc8FVCedUxfBWT01gFpdiaPzH7YP1zN9v9jo4c
         JnpndnOGvzpWqkyMrzfSvvo1oroCuWJ4rMpUeNYM/J2ZjFGylrLdUAzZIqff24lJ7f
         YZ8ZggpFGZGBO1OcyPX99YZhmL+8OPCXDDZuz2RvRDEWtnagqxPBK8FH4lol5e+KfU
         xJ1LI/005LzBeC7QYP+pRp2qsrWnyJPVkrd4g+QAHflPLy0PcgCAiafTUMixNou83E
         SNl36kmWOBJk++cmOiD2RW7HPs3Jcuz+KDnWgFrNNsErnAklNIboIcAifTEMRDL9hO
         caJO/JfgQdghQ==
Date:   Wed, 16 Jun 2021 13:22:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YMmt1qhC1dIiYx7O@vkoul-mobl>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl>
 <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl>
 <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
 <YMmXPMy7Lz9Jo89j@kroah.com>
 <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ff7989-c89d-d220-da23-c13ddc53384e@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-21, 12:27, Sanjay R Mehta wrote:
> 
> 
> On 6/16/2021 11:46 AM, Greg KH wrote:
> > [CAUTION: External Email]
> > 
> > On Wed, Jun 16, 2021 at 10:24:52AM +0530, Sanjay R Mehta wrote:
> >>
> >>
> >> On 6/16/2021 9:45 AM, Vinod Koul wrote:
> >>> [CAUTION: External Email]
> >>>
> >>> On 15-06-21, 16:50, Sanjay R Mehta wrote:
> >>>
> >>>>>> +static struct pt_device *pt_alloc_struct(struct device *dev)
> >>>>>> +{
> >>>>>> +     struct pt_device *pt;
> >>>>>> +
> >>>>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
> >>>>>> +
> >>>>>> +     if (!pt)
> >>>>>> +             return NULL;
> >>>>>> +     pt->dev = dev;
> >>>>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
> >>>>>
> >>>>> What is the use of this number?
> >>>>>
> >>>>
> >>>> There are eight similar instances of this DMA engine on AMD SOC.
> >>>> It is to differentiate each of these instances.
> >>>
> >>> Are they individual device objects?
> >>>
> >>
> >> Yes, they are individual device objects.
> > 
> > Then what is "ord" for?  Why are you using an atomic variable for this?
> > What does this field do?  Why doesn't the normal way of naming a device
> > come into play here instead?
> > 
> 
> Hi Greg,
> 
> The value of "ord" is incremented for each device instance and then it
> is used to store different name for each device as shown in below snippet.
> 
> 	pt->ord = atomic_inc_return(&pt_ordinal);
> 	snprintf(pt->name, MAX_PT_NAME_LEN, "pt-%u", pt->ord);

Okay why not use device->name ?

Trying to unroll further, who creates pt_device? who creates the dev
object under this..?

Thanks
-- 
~Vinod
