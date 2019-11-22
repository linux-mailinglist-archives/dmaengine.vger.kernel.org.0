Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DC105F83
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKVFUP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfKVFUP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 00:20:15 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA032068E;
        Fri, 22 Nov 2019 05:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400014;
        bh=hHnjuK8XA/m/8hFJIqEI+WTpjRrY+OpTMEkDT0W9xLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LodpG97AdwfbgKFdBSEwTfhStFASa62n80eMLocrE3UqrIS91btU1TnPmGA9Q7Cd+
         +6E29Uq4yawJy8JlCedM5cDHFQ7/73YQg7+smVqhBaYmZLnMneN3oPTBIq7vesv3tU
         2peqJjAJKwk/C2aA2qQoznP6v0C0AEZRryFYFPfI=
Date:   Fri, 22 Nov 2019 10:50:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
Message-ID: <20191122052010.GO82508@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl>
 <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl>
 <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-11-19, 10:03, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-13 9:55 p.m., Vinod Koul wrote:
> >> But that's the problem. We can't expect our users to be "nice" and not
> >> unbind when the driver is in use. Killing the kernel if the user
> >> unexpectedly unbinds is not acceptable.
> > 
> > And that is why we review the code and ensure this does not happen and
> > behaviour is as expected
> 
> Yes, but the current code can kill the kernel when the driver is unbound.
> 
> >>>> I suspect this is less of an issue for most devices as they wouldn't
> >>>> normally be unbound while in use (for example there's really no reason
> >>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
> >>>> is, the user could unbind these devices at anytime and we don't want to
> >>>> panic if they do.
> >>>
> >>> There are many drivers which do modules so yes I am expecting unbind and
> >>> even a bind following that to work
> >>
> >> Except they will panic if they unbind while in use, so that's a
> >> questionable definition of "work".
> > 
> > dmaengine core has module reference so while they are being used they
> > won't be removed (unless I complete misread the driver core behaviour)
> 
> Yes, as I mentioned in my other email, holding a module reference does
> not prevent the driver from being unbound. Any driver can be unbound by
> the user at any time without the module being removed.

That sounds okay then.
> 
> Essentially, at any time, a user can do this:
> 
> echo 0000:83:00.4 > /sys/bus/pci/drivers/plx_dma/unbind
> 
> Which will call plx_dma_remove() regardless of whether anyone has a
> reference to the module, and regardless of whether the dma channel is
> currently in use. I feel it is important that drivers support this
> without crashing, and my plx_dma driver does the correct thing here.
> 
> Logan

-- 
~Vinod
