Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D03F884A
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 06:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfKLF4Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 00:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLF4Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 00:56:16 -0500
Received: from localhost (unknown [122.167.70.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62F3206BB;
        Tue, 12 Nov 2019 05:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573538175;
        bh=qQNRUDNK9jYEAFayckdbTTiF5Wzvx8FCJHZqCcJ6bH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pPW4eu8VgEiJD2/DUsjjvGzakKD+GeU6ykt12TKzH10NopahnvEWyL1wPyzeuOFK
         WqFZHUMz8N8yxCy0rOjVubcQZi7zeAqCNIQwgnLUjefYkKsOcoV22XBtAMHrptexTu
         8PA/e1uX07cC7EbUF1FjpXPJD8Ogf7OqCgBW70T8=
Date:   Tue, 12 Nov 2019 11:26:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
Message-ID: <20191112055540.GY952516@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl>
 <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-19, 09:50, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-09 10:18 a.m., Vinod Koul wrote:
> > Hi Logan,
> > 
> > Sorry for delay in reply!
> > 
> > On 22-10-19, 15:46, Logan Gunthorpe wrote:
> >> dma_chan_to_owner() dereferences the driver from the struct device to
> >> obtain the owner and call module_[get|put](). However, if the backing
> >> device is unbound before the dma_device is unregistered, the driver
> >> will be cleared and this will cause a NULL pointer dereference.
> > 
> > Have you been able to repro this? If so how..?
> > 
> > The expectation is that the driver shall unregister before removed.
> 
> Yes, with my new driver, if I do a PCI unbind (which unregisters) while
> the DMA engine is in use, it panics. The point is the underlying driver
> can go away before the channel is removed.

and in your driver remove you do not unregister? When unbind is invoked
the driver remove is invoked by core and you should unregister whatever
you have registered in your probe!

Said that, if someone is using the dmaengine at that point of time, it
is not a nice thing to do and can cause issues, but on idle it should
just work!

> I suspect this is less of an issue for most devices as they wouldn't
> normally be unbound while in use (for example there's really no reason
> to ever unbind IOAT seeing it's built into the system). Though, the fact
> is, the user could unbind these devices at anytime and we don't want to
> panic if they do.

There are many drivers which do modules so yes I am expecting unbind and
even a bind following that to work

-- 
~Vinod
