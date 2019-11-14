Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF9DFBEC4
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 05:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNE4C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Nov 2019 23:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfKNE4C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Nov 2019 23:56:02 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8851C206EF;
        Thu, 14 Nov 2019 04:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573707361;
        bh=LE6qCswHlWOHnxEJs8IN+lZrqjVOccPKEwov1WrEzbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWfimNONXDwf2ajvcX+OY6WZbWg6+7vV1V+GrVwZ5R+0r0DvWhuZDbyWnKXFBqOeH
         c/8chMm4fpmkZk1F8I3J+5I7wbLM0QI/RJqLHXhzjcWB8Sr/X4G1RBUGo6xBPkKXgG
         4iSO+pWDaYV1gxK2FP3y6yoLTMZnffn/1XVyYtRM=
Date:   Thu, 14 Nov 2019 10:25:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
Message-ID: <20191114045555.GJ952516@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-11-19, 09:45, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-11 10:56 p.m., Vinod Koul wrote:
> > On 11-11-19, 09:50, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-11-09 10:18 a.m., Vinod Koul wrote:
> >>> Hi Logan,
> >>>
> >>> Sorry for delay in reply!
> >>>
> >>> On 22-10-19, 15:46, Logan Gunthorpe wrote:
> >>>> dma_chan_to_owner() dereferences the driver from the struct device to
> >>>> obtain the owner and call module_[get|put](). However, if the backing
> >>>> device is unbound before the dma_device is unregistered, the driver
> >>>> will be cleared and this will cause a NULL pointer dereference.
> >>>
> >>> Have you been able to repro this? If so how..?
> >>>
> >>> The expectation is that the driver shall unregister before removed.
> >>
> >> Yes, with my new driver, if I do a PCI unbind (which unregisters) while
> >> the DMA engine is in use, it panics. The point is the underlying driver
> >> can go away before the channel is removed.
> > 
> > and in your driver remove you do not unregister? When unbind is invoked
> > the driver remove is invoked by core and you should unregister whatever
> > you have registered in your probe!
> >
> > Said that, if someone is using the dmaengine at that point of time, it
> > is not a nice thing to do and can cause issues, but on idle it should
> > just work!
> 
> But that's the problem. We can't expect our users to be "nice" and not
> unbind when the driver is in use. Killing the kernel if the user
> unexpectedly unbinds is not acceptable.

And that is why we review the code and ensure this does not happen and
behaviour is as expected

> >> I suspect this is less of an issue for most devices as they wouldn't
> >> normally be unbound while in use (for example there's really no reason
> >> to ever unbind IOAT seeing it's built into the system). Though, the fact
> >> is, the user could unbind these devices at anytime and we don't want to
> >> panic if they do.
> > 
> > There are many drivers which do modules so yes I am expecting unbind and
> > even a bind following that to work
> 
> Except they will panic if they unbind while in use, so that's a
> questionable definition of "work".

dmaengine core has module reference so while they are being used they
won't be removed (unless I complete misread the driver core behaviour)

-- 
~Vinod
