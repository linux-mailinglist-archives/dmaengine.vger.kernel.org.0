Return-Path: <dmaengine+bounces-7869-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE3CD8E05
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16C5730022C6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCC346AF2;
	Tue, 23 Dec 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVGc223b"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FA318144
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485986; cv=none; b=IEKUt58UcZ2iCMSyE+oDqCnChhJDH5MIKQEtUrXHSQ9TfPztv2g4+yK4K9fY96m64K1hKlNbppugdO0c12Qg2Rg0cXUX3Z/Bdy7o3Tmg7xi7/wVQYmyl59IhX9Fsk7gKyyqqp0DZYF1ltZQFwYo1GVz8IGMswyShNKAQBsApdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485986; c=relaxed/simple;
	bh=BTtTGrvO7gm4RUzf0z9zAbW6WpRvjIeRkEiBPm/ufYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG7buEH3G98JFBlJKTEBk0klN+CwAF5wfxY+m1jUgzSnMxtETA6W6OfMcuexl3rMGbnyFewHCxVFILllVaNX72FreIZ7ev+LxTHrmpon+EV3e59I9DSw5MNDTCiQTtDW8ip6M3ctI0xWp9u01pA9JMs3Hwh1TEfCG/Z3cPMOiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVGc223b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B653C113D0;
	Tue, 23 Dec 2025 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766485985;
	bh=BTtTGrvO7gm4RUzf0z9zAbW6WpRvjIeRkEiBPm/ufYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVGc223bkrkmCoOdYYyZ2R/vFzpNmH/dlWYdORExDF2d73ggFb1vmRC9wwGvXpLBL
	 mtlKjWstikefy+d0CHMH2wD9wkFZuQTYsWwZFaYNrZ8uKhI+Tr1UtW/m+5uhoUk4EZ
	 Z9Rt1SVC3DFXIQYS4mHR7dZfdLX5oMrkV798m8AdUZqvMkhPXoFCTw8j6hzMpEZPtp
	 iODonCQ23uUI+D9PD0HjJZEjWj3RWyClI+vIwIsxpu8QOLFilmsaeWz7J3FnH4h3z+
	 WpzPo1dMeyaHEMBieeCx76PqJ9n+waxrSgKxEufZuTLPl5IIEjDovYpZviFcwi13uZ
	 n33DWTbFm2MgQ==
Date: Tue, 23 Dec 2025 16:03:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aUpv3fP3PIhJVr9h@vaman>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-4-logang@deltatee.com>
 <aUFHfUFNrDojRoRm@vaman>
 <ab9b7838-09bf-4a1c-9d93-097b3dca0e02@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9b7838-09bf-4a1c-9d93-097b3dca0e02@deltatee.com>

On 19-12-25, 10:42, Logan Gunthorpe wrote:
> 
> 
> On 2025-12-16 04:50, Vinod Koul wrote:
> >> +static dma_cookie_t
> >> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> >> +	__releases(swdma_chan->submit_lock)
> >> +{
> >> +	struct switchtec_dma_chan *swdma_chan =
> >> +		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
> >> +	dma_cookie_t cookie;
> >> +
> >> +	cookie = dma_cookie_assign(desc);
> >> +
> >> +	spin_unlock_bh(&swdma_chan->submit_lock);
> >> +
> >> +	return cookie;
> >> +}
> > 
> > What about the descriptor, you should push into a pending queue or
> > something here?
> 
> There's only the one queue in this driver and it is added to directly by
> switchtec_dma_prep_memcpy(). So there's nothing more to do on the
> hardware's side to submit the job. The jobs added to the queue with the
> prep() function will start to be processed when the sq_tail pointer is
> set in switchtec_dma_issue_pending() below.

That is not really correct dmaengine semantics, please fix that.
We expect the descriptor to be prepared in the prep_xxx call. Then we
expect it to be submitted in a queue and finally pushed to hardware on
issue_pending. 

This is also the expectations from clients, so we would like to see this
behaviour in the driver as well.

> 
> >> +
> >> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> >> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> >> +{
> >> +	struct switchtec_dma_chan *swdma_chan =
> >> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> >> +	enum dma_status ret;
> >> +
> >> +	ret = dma_cookie_status(chan, cookie, txstate);
> >> +	if (ret == DMA_COMPLETE)
> >> +		return ret;
> >> +
> >> +	switchtec_dma_cleanup_completed(swdma_chan);
> > 
> > Why are we doing this on a status query??
> 
> We've answered this question a couple times now. See my detailed
> response here:
> 
> https://lore.kernel.org/all/e759d483-e303-421a-b674-72fd9121750d@deltatee.com/
> 
> Essentially this is the only place we have to do the cleanup when
> running jobs with interrupts disabled (a valid use case). Both PLX and
> IOAT do similar things for good reasons and we'd really rather not have
> the downsides noted in the link above without a more compelling
> technical reason for this being incorrect.

This feels wrong :-) Relying on query to cleanup should not be done. A
client may not issue this. It is not a mandatory thing to do!
I would not suggest enabling interrupts, as you suggested in the link
above. I am sure you are getting at least some completion notices? The
tasklet can then do the cleanup as well. that would be a better reliable
way to do this

We should fix the other two drivers!

> 
> >> +
> >> +	return dma_cookie_status(chan, cookie, txstate);
> > 
> > No setting residue?
> 
> residue is set in switchtec_dma_cleanup_completed() which is called a
> couple lines up.
> 
> >> +
> >> +	spin_lock_bh(&swdma_chan->submit_lock);
> >> +	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
> >> +	spin_unlock_bh(&swdma_chan->submit_lock);
> >> +
> >> +	rcu_read_unlock();
> >> +}
> > 
> > This seems to assume that the channel is idle when issue_pending is
> > invoked. That is not the right assumption, we can be running a txn so you
> > need to check if channel is not running and start if it is idle
> 
> This is just updating the tail pointer for the hardware's submission
> queue. If the channel is idle, it will start processing of a job. But if
> the channel is not idle it informs the hardware there are more elements
> in the queue.  Not doing this if the hardware is not idle would mean the
> hardware never gets informed there are more jobs in the queue. That
> would not be correct.

That is interesting, can you add this in comments here, not very obvious
hardware behaviour

-- 
~Vinod

