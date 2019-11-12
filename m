Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA36F8864
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 07:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfKLGJ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 01:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfKLGJ0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Nov 2019 01:09:26 -0500
Received: from localhost (unknown [122.167.70.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 516B2206BB;
        Tue, 12 Nov 2019 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573538965;
        bh=fu5hEizNEobs5LXt2r9VbXZsUMilNe/J5wbVvjjQtFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/dofCIcG0ERk2LfUUHDVCvJ9bSHyUW+/GyvLQ1tRE30353KjsfVBErQwTd0KrkRl
         OpGRu8y130HzX6mKcTauvcSCq6++oyx8nfvqgDCbP4Tqg0Nx7zsM1QSptQsn7Ny5+p
         hmXxCPaOKRKn9g0/Wd52eKVVT92e943QFQVpokw8=
Date:   Tue, 12 Nov 2019 11:39:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/5] dmaengine: plx-dma: Introduce PLX DMA engine PCI
 driver skeleton
Message-ID: <20191112060919.GZ952516@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-4-logang@deltatee.com>
 <20191109173510.GG952516@vkoul-mobl>
 <ff43b1f9-c620-17eb-fc6c-4c7d7577250b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff43b1f9-c620-17eb-fc6c-4c7d7577250b@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-19, 10:50, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-09 10:35 a.m., Vinod Koul wrote:
> > On 22-10-19, 15:46, Logan Gunthorpe wrote:
> >> +static irqreturn_t plx_dma_isr(int irq, void *devid)
> >> +{
> >> +	return IRQ_HANDLED;
> > 
> > ??
> 
> Yes, sorry this is more of an artifact of how I chose to split the
> patches up. The ISR is filled-in in patch 4.

lets move this code in all including isr registration in patch 4 then :)

> >> +	 */
> >> +	schedule_work(&plxdev->release_work);
> >> +}
> >> +
> >> +static void plx_dma_put(struct plx_dma_dev *plxdev)
> >> +{
> >> +	kref_put(&plxdev->ref, plx_dma_release);
> >> +}
> >> +
> >> +static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
> >> +{
> >> +	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
> >> +
> >> +	kref_get(&plxdev->ref);
> > 
> > why do you need to do this?
> 
> This has to do with being able to probably unbind while a channel is in
> use. If we don't hold a reference to the struct plx_dma_dev between
> alloc_chan_resources() and free_chan_resources() then it will panic if a
> call back is called after plx_dma_remove(). The way I've done it, once a

which callback?

> device is removed, subsequent calls to dma_prep_memcpy() will fail (see
> ring_active).
> 
> struct plx_dma_dev needs to be alive between plx_dma_probe() and
> plx_dma_remove(), and between calls to alloc_chan_resources() and
> free_chan_resources(). So we use a reference count to ensure this.

and that is why we hold module reference so we don't go away without
cleanup

> >> +static void plx_dma_release_work(struct work_struct *work)
> >> +{
> >> +	struct plx_dma_dev *plxdev = container_of(work, struct plx_dma_dev,
> >> +						  release_work);
> >> +
> >> +	dma_async_device_unregister(&plxdev->dma_dev);
> >> +	put_device(plxdev->dma_dev.dev);
> >> +	kfree(plxdev);
> >> +}
> >> +
> >> +static void plx_dma_release(struct kref *ref)
> >> +{
> >> +	struct plx_dma_dev *plxdev = container_of(ref, struct plx_dma_dev, ref);
> >> +
> >> +	/*
> >> +	 * The dmaengine reference counting and locking is a bit of a
> >> +	 * mess so we have to work around it a bit here. We might put
> >> +	 * the reference while the dmaengine holds the dma_list_mutex
> >> +	 * which means we can't call dma_async_device_unregister() directly
> >> +	 * here and it must be delayed.
> >
> > why is that, i have not heard any complaints about locking, can you
> > elaborate on why you need to do this?
> 
> Per the above explanation, we need to call plx_dma_put() in
> plx_dma_free_chan_resources(); and plx_dma_release() is when we can call
> dma_async_device_unregister() (seeing that's when we know there are no
> longer any active channels).
> 
> However, dma_chan_put() (which calls device_free_chan_resources()) holds
> the dma_list_mutex and dma_async_device_unregister() tries to take the
> dma_list_mutex so, if we call unregister inside free_chan_resources we
> would deadlock.

yes as we are not expecting someone to unregister in
device_free_chan_resources(), that is for freeing up resources.

You are expected to unregister in .remove!

Can you explain me why unregister cant be done in remove? I think I am
still missing some detail for this case.

-- 
~Vinod
