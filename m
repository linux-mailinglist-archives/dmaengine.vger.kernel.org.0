Return-Path: <dmaengine+bounces-5992-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9472B2134D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64601A21A9B
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4029BDB8;
	Mon, 11 Aug 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkgBjIgG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF7311C16;
	Mon, 11 Aug 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933672; cv=none; b=MzimQE6BH99g2lxKVQAHggkO0HJwlu8ooVfPmk+WXXa/GylmcCdveUGRwjtaQFHP9NMpxtORYO+YOmE8uS0VdLnFbH+zaZHknlt7H5W/qj2CI6t7nID8BKzNg9QFd6944LZfGCZkhHcmimZKDq1ExroETJp/BBXTG4WbFAfYA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933672; c=relaxed/simple;
	bh=usRhq1yBbjEaPIH65c1XCFLp4LJl4vDVuaTnS09+2Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4mlx1KureL6j7Y9F0DyFNtc4XNpExGdshYgF2+T9LPQFieFr9iBd57qjXjl0/gE3+5qgJV2AxvJOXGL8oxRZP8/zjF3SDfI5pzu8FJ+HAj5Hb8zXnq4Ypf/TmFQ2J+AGWBdzlBDy1pCnBCO1GNIjN+LKMJqwQVBgoX9G34fKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkgBjIgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F00C4CEED;
	Mon, 11 Aug 2025 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933671;
	bh=usRhq1yBbjEaPIH65c1XCFLp4LJl4vDVuaTnS09+2Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkgBjIgG8Po9jF2tT6pl78A5OHJRRjIKOgN4l4JS8y3aY9sUa6ksMn8Z4I3fmTveq
	 i8pAf1aof6GZE2drpHrSmrbA4izs+ATYp4vIqJJdilznBH8SIaERkH4/eeWhoL1EAp
	 a7jyhkz1mlB6DGb/WzwYeH8NN6A3Otz+Ek9m9Tydgk/KBO6cJf+gtond9juLVpkPDM
	 UKNVFoooCDgz5fkG5JVkoq8vOmRr9KSHjf6esmVhbkAwseBH6goc0xx+zsoZb8XeB8
	 n5MwACoGLSRJLokF6PJYXGXPYybGRPVdMFQN/W0Gv2HoMod7UUGqT2i/c4eRh+qmXL
	 buiEUCgBXqFKA==
Date: Mon, 11 Aug 2025 23:04:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Kelvin Cao <kelvin.cao@microchip.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, George.Ge@microchip.com,
	christophe.jaillet@wanadoo.fr, hch@infradead.org
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <aJopotHoEEbe6ll3@vaman>
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com>
 <ZhKPsKFyaXFliJP4@matsya>
 <3baed5bf-8fa1-4ef9-8cb1-58145a6dd37c@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3baed5bf-8fa1-4ef9-8cb1-58145a6dd37c@deltatee.com>

On 05-08-25, 13:15, Logan Gunthorpe wrote:
> Hi Vinod,
> 
> Kelvin has asked me to take over the upstreaming of the switchtec_dma
> driver. It's been over a year since the last posting but we intend on
> sending a new version shortly after the merge window. I've fixed a
> number of issues and gone through the bulk of the changes requested but
> there are two points that I'm going to have to push back on.
> 
> This driver shares a lot of similarities with the plx_dma driver I wrote
> a few years ago and had similar issues.
> 
> On 2024-04-07 06:21, Vinod Koul wrote:
> > On 18-03-24, 09:33, Kelvin Cao wrote:
> >> +static dma_cookie_t
> >> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> >> +	__releases(swdma_chan->submit_lock)
> >> +{
> >> +	struct switchtec_dma_chan *swdma_chan =
> >> +		to_switchtec_dma_chan(desc->chan);
> >> +	dma_cookie_t cookie;
> >> +
> >> +	cookie = dma_cookie_assign(desc);
> >> +
> >> +	spin_unlock_bh(&swdma_chan->submit_lock);
> > 
> > I was expecting desc to be pushing to pending list?? where is that done
> 
> The driver maintains a pending list in DMA coherent memory. The pending
> list is written directly in switchtec_dma_prep_desc(). So there's
> nothing the hardware needs done when a new operation is submitted to the
> queue. When switchtec_dma_issue_pending() is called, the sq_tail pointer
> is updated which will signal the hardware to start pulling all the
> queued requests. I don't see any other way this could be done in the
> dmaengine framework.
> 
> > Also consider using virt-dma for desc management, you dont need to
> > handle that on your own
> 
> I looked into this and a virtual queue does not make sense to me for
> this device. The driver maintains it's own queue that hardware reads
> directly so there would be no benefit in having another queue that then
> needs to be copied to the queue the hardware reads from.
> 
> >> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> >> +					       dma_cookie_t cookie,
> >> +					       struct dma_tx_state *txstate)
> >> +{
> >> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> >> +	enum dma_status ret;
> >> +
> >> +	ret = dma_cookie_status(chan, cookie, txstate);
> >> +	if (ret == DMA_COMPLETE)
> >> +		return ret;
> >> +
> >> +	switchtec_dma_process_desc(swdma_chan);
> > 
> > This is *wrong*, you cannot process desc in status API, Please read the
> > documentation again and if in doubt pls ask
> 
> I don't see any other way to do this. There's no other place to cleanup
> the completed descriptors. This is exactly what was done in the plx-dma
> driver which copied the IOAT driver that began this pattern. There was
> very similar feedback when I submitted the plx-dma driver[1] and I
> pointed out there's no other way to do this.

we should try fixing these
> 
> I'll rename the function to make this a little clearer, but I can't see
> any other way to implement the driver without doing this.

Dont you get a notification from hardware on completion, that should
trigger this as well as issue_pending calls... 

-- 
~Vinod

