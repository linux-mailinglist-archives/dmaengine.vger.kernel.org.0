Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951C511842D
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLJJxd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 04:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfLJJxd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 04:53:33 -0500
Received: from localhost (unknown [106.201.45.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF9B2073B;
        Tue, 10 Dec 2019 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575971612;
        bh=kQ4Yqn5rZEIEiY/c0Ohg3wcxPWdObo1pmjuNVLFurVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYE5RDL/pEvqabyAgmoMjF675Qqla4hiQ+3Gjypdu823XOYNXXj/Nm8GA7A3kW8QU
         hrGAEGOOKxsdqwmi9tJQ5KVqzh51+lFK4vx1IsMJluFx1mHWin5OO/Hi5xUZdl7q47
         zkwGKpxKTN9SbhBRaYh+d25p6g81ORoXp0BvZC08=
Date:   Tue, 10 Dec 2019 15:23:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
Message-ID: <20191210095327.GA2536@vkoul-mobl>
References: <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl>
 <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
 <20191122052010.GO82508@vkoul-mobl>
 <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
 <CAPcyv4iOjSX=Diw3Gs0Xnpe4HmVZ0xxD_13aQcCMomqUJWr58A@mail.gmail.com>
 <dd40f8ff-62bb-648c-eb65-7e335cde6138@deltatee.com>
 <CAPcyv4gnvQsAen0DUW3o4Kv1WPW28Q00+mxBowUN8yMy6Kmgvw@mail.gmail.com>
 <3ae58ea7-5cab-23f9-512f-bec30410ff6f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae58ea7-5cab-23f9-512f-bec30410ff6f@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-11-19, 14:42, Dave Jiang wrote:
> 
> 
> On 11/22/19 2:01 PM, Dan Williams wrote:
> > On Fri, Nov 22, 2019 at 12:56 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> > > 
> > > 
> > > 
> > > On 2019-11-22 1:50 p.m., Dan Williams wrote:
> > > > On Fri, Nov 22, 2019 at 8:53 AM Dave Jiang <dave.jiang@intel.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 11/21/19 10:20 PM, Vinod Koul wrote:
> > > > > > On 14-11-19, 10:03, Logan Gunthorpe wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 2019-11-13 9:55 p.m., Vinod Koul wrote:
> > > > > > > > > But that's the problem. We can't expect our users to be "nice" and not
> > > > > > > > > unbind when the driver is in use. Killing the kernel if the user
> > > > > > > > > unexpectedly unbinds is not acceptable.
> > > > > > > > 
> > > > > > > > And that is why we review the code and ensure this does not happen and
> > > > > > > > behaviour is as expected
> > > > > > > 
> > > > > > > Yes, but the current code can kill the kernel when the driver is unbound.
> > > > > > > 
> > > > > > > > > > > I suspect this is less of an issue for most devices as they wouldn't
> > > > > > > > > > > normally be unbound while in use (for example there's really no reason
> > > > > > > > > > > to ever unbind IOAT seeing it's built into the system). Though, the fact
> > > > > > > > > > > is, the user could unbind these devices at anytime and we don't want to
> > > > > > > > > > > panic if they do.
> > > > > > > > > > 
> > > > > > > > > > There are many drivers which do modules so yes I am expecting unbind and
> > > > > > > > > > even a bind following that to work
> > > > > > > > > 
> > > > > > > > > Except they will panic if they unbind while in use, so that's a
> > > > > > > > > questionable definition of "work".
> > > > > > > > 
> > > > > > > > dmaengine core has module reference so while they are being used they
> > > > > > > > won't be removed (unless I complete misread the driver core behaviour)
> > > > > > > 
> > > > > > > Yes, as I mentioned in my other email, holding a module reference does
> > > > > > > not prevent the driver from being unbound. Any driver can be unbound by
> > > > > > > the user at any time without the module being removed.
> > > > > > 
> > > > > > That sounds okay then.
> > > > > 
> > > > > I'm actually glad Logan is putting some work in addressing this. I also
> > > > > ran into the same issue as well dealing with unbinds on my new driver.
> > > > 
> > > > This was an original mistake of the dmaengine implementation that
> > > > Vinod inherited. Module pinning is distinct from preventing device
> > > > unbind which ultimately can't be prevented. Longer term I think we
> > > > need to audit dmaengine consumers to make sure they are prepared for
> > > > the driver to be removed similar to how other request based drivers
> > > > can gracefully return an error status when the device goes away rather
> > > > than crashing.

Right finally wrapping my head of static dmaengine devices! we can
indeed have devices going away, but me wondering why this should be
handled in subsystems! Should the driver core not be doing this instead?
Would it be not a safe behaviour for unplug to unload the driver and
thus give a chance to unbind from subsystems too...


> > > Yes, but that will be a big project because there are a lot of drivers.
> > 
> > Oh yes, in fact I think it's something that can only reasonably be
> > considered for new consumers.
> > 
> > > But I think the dmaengine common code needs to support removal properly,
> > > which essentially means changing how all the drivers allocate and free
> > > their structures, among other things.
> > > 
> > > The one saving grace is that most of the drivers are for SOCs which
> > > can't be physically removed and there's really no use-case for the user
> > > to call unbind.

yeah only a small set of drivers would need this for now!

> > Yes, the SOC case is not so much my concern as the generic offload use
> > cases, especially if those offloads are in a similar hotplug domain as
> > a cpu.
> 
> It becomes a bigger issue when "channels" can be reconfigured and can come
> and go in a hot plug fashion.

-- 
~Vinod
