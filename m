Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189121529EC
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 12:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBELcB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 06:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBELcB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 5 Feb 2020 06:32:01 -0500
Received: from localhost (unknown [122.178.239.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CC22072B;
        Wed,  5 Feb 2020 11:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580902320;
        bh=PFVOCoulyejpN6mvZgVTk5pxnaukban7QLyDFO77WfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ynQt/JGSz9QiJeFwzdoIo5Lu3mZYK4JHHr73L7Q3xz3HP++C72Tasj3hjstGaK0ZH
         E6I6/kFHVqHJN7upIyo5b3zB1vDEHcq3sFsVdXKIKN0tkDf8kBhZOd1o3VpQ37mOP0
         luK0OQha7EXiuCibsLDJz5qdwSQbswM/lcova95M=
Date:   Wed, 5 Feb 2020 17:01:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
Message-ID: <20200205113155.GE2618@vkoul-mobl>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <20200204062118.GS2841@vkoul-mobl>
 <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
 <20200205044352.GC2618@vkoul-mobl>
 <13dcf3d9-06ca-d793-525d-12f6d7cd27c1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13dcf3d9-06ca-d793-525d-12f6d7cd27c1@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 05-02-20, 10:10, Peter Ujfalusi wrote:
> Vinod,
> 
> On 05/02/2020 6.43, Vinod Koul wrote:
> > On 04-02-20, 13:21, Andy Shevchenko wrote:
> >> On Tue, Feb 4, 2020 at 8:21 AM Vinod Koul <vkoul@kernel.org> wrote:
> >>>
> >>> On 03-02-20, 12:37, Andy Shevchenko wrote:
> >>>> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>>>
> >>>>> dma_request_slave_channel_reason() no longer have user in mainline, it
> >>>>> can be removed.
> >>>>>
> >>>>> Advise users of dma_request_slave_channel() and
> >>>>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> >>>>
> >>>> How? There are legacy ARM boards you have to care / remove before.
> >>>> DMAengine subsystem makes a p*s off decisions without taking care of
> >>>> (I'm talking now about dma release callback, for example) end users.
> >>>
> >>> Can you elaborate issue you are seeing with dma_release callback?
> >>
> >>
> >> [    7.980381] intel-lpss 0000:00:1e.3: WARN: Device release is not
> >> defined so it is not safe to unbind this driver while in use
> > 
> > Yes that is expected but is not valid in your case.
> 
> In which case it is valid?

It is valid for cases where device can be hotplugged. We didnt handle
that very well earlier. TBH we never had a reason as most of the
embedded cases that is not really doable.

> > Anyway this will be turned off before the release.
> 
> Looking at the commit which added it and I still don't get the point.
> If any of the channel is in use then we should not allow the DMA driver
> to go away at all.

Not really, if the device is already gone, we cant do much about it. We
have to handle that gracefully rather than oopsing

The important part is that the device is gone. Think about a device on
PCI card which is yanked off or a USB device unplugged. Device is
already gone, you can't communicate with it anymore. So all we can do is
handle the condition and exit, hence the new method to let driver know.

> Imho there should be a function to check if we can proceed with the
> .remove of the driver and fail it if any of the channels are in use.
> 
> Hrm, base/dd.c __device_release_driver() does not check the .remove's
> return value, so it can not fail.
> 
> What is expected if the .remove returns with OK but we still have
> channels in use?
> 
> After the remove all sorts of things got yanked which might makes the
> still in use channels cause issues down the road.
> 
> I'm curious why it is a good thing to remotely try to support unbind
> when the driver is in use.
> It is like one wants to support ext4 removal even when your rootfs is ext4.
> 
> I think krefing the DMA driver for channel request/release is just fine,
> if user wants to break the system we should not assist...
> 
> >> It's not limited to that driver, but actually all I'm maintaining.
> >>
> >> Users are not happy!
> >>
> >> -- 
> >> With Best Regards,
> >> Andy Shevchenko
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
