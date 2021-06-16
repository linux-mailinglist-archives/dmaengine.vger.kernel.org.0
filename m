Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3C3A91BE
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhFPGSj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 02:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhFPGSi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 02:18:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 402DD613C2;
        Wed, 16 Jun 2021 06:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623824192;
        bh=n0MaySor92vcaSlNHggYCZWNY0gOnL+3Y3j8NPusdX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwcoYXSkOGqTJqizPHMafPo0S6zRL8Bn9H6cp3rJRUf9UZfsmH+fVWt4Fw3WYzs5w
         xNX3Fy4k8dgu27JdIWcpPx18SaODiHVC0mDwZkQ4H+vzNgvGcqW0qVsDpiBA5ft0Iz
         J53J3ykibbibiNO446wiPDMEbMS5WKSpeU3ZYnAg=
Date:   Wed, 16 Jun 2021 08:16:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dmaengine: ptdma: Initial driver for the AMD PTDMA
Message-ID: <YMmXPMy7Lz9Jo89j@kroah.com>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-2-git-send-email-Sanju.Mehta@amd.com>
 <YL+rUBGUJoFLS902@vkoul-mobl>
 <94bba5dd-b755-81d0-de30-ce3cdaa3f241@amd.com>
 <YMl6zpjVHls8bk/A@vkoul-mobl>
 <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc4e249-b8ce-1d92-ddde-b763667a0bcb@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 16, 2021 at 10:24:52AM +0530, Sanjay R Mehta wrote:
> 
> 
> On 6/16/2021 9:45 AM, Vinod Koul wrote:
> > [CAUTION: External Email]
> > 
> > On 15-06-21, 16:50, Sanjay R Mehta wrote:
> > 
> >>>> +static struct pt_device *pt_alloc_struct(struct device *dev)
> >>>> +{
> >>>> +     struct pt_device *pt;
> >>>> +
> >>>> +     pt = devm_kzalloc(dev, sizeof(*pt), GFP_KERNEL);
> >>>> +
> >>>> +     if (!pt)
> >>>> +             return NULL;
> >>>> +     pt->dev = dev;
> >>>> +     pt->ord = atomic_inc_return(&pt_ordinal);
> >>>
> >>> What is the use of this number?
> >>>
> >>
> >> There are eight similar instances of this DMA engine on AMD SOC.
> >> It is to differentiate each of these instances.
> > 
> > Are they individual device objects?
> > 
> 
> Yes, they are individual device objects.

Then what is "ord" for?  Why are you using an atomic variable for this?
What does this field do?  Why doesn't the normal way of naming a device
come into play here instead?

thanks,

greg k-h
