Return-Path: <dmaengine+bounces-7868-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC4CD8CBB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12582300DC94
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235A315D3E;
	Tue, 23 Dec 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flVO9maY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9673126D4
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485603; cv=none; b=jhx2oLaTd/jASkyARQ1+w8KvfW36Ynx/3vBbr5xMRWa2cKYbqsfUbq3Nr/ev2MKhIFzCpEG6tw86RuaxeykI6HRm/timSvmyhnzE4ElAnBTbXg+MPs9VLbwWVyAlL1mJbe74R16nAVEyjkeqCQlyv2vLU7SMWzg448Lhm98zOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485603; c=relaxed/simple;
	bh=YVwAgujR9NOc+IYyDzM5KSQjfLkhSIOv57djO/pjGF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtGGbWttBNt6AKte5n+q2hb1g8gzDHNDesTCM+qgJduwM4bo1SwkpROQq2pyY6TZwOE5D1DlSPpJw023XGmbm+4IbuTMYiB/byBJBO1ybpzFlPhqEd+LU6RaZFvQImrB9Kcxdav7dvnXBI3YmPk6CfuW0yiPfxLKNvNWZC1H1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flVO9maY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4CBC116B1;
	Tue, 23 Dec 2025 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766485603;
	bh=YVwAgujR9NOc+IYyDzM5KSQjfLkhSIOv57djO/pjGF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flVO9maYiKW7mcJXVBxYktLv9G/x7tvtD/inuWSqMd6g+ATrhpXMyNgMeCoTbsU7p
	 o2n9bR8GwVZyDmCuOlbciqeL5in+79naWIR+GundPala0Cyzsrt1juvRWmXO59kQ8Q
	 7i1jJF18Grk6IasPlz//P3AcFzODPcSv9Uwdrj/iswSr5IObNSSQ9wEwRy0pz5Hdbb
	 aEjNmyK0+YSLLX0mTeVesHO2JAzA9ZY8shDh9BcqezRcNr2CjVykiVMH0mjiDk7/ev
	 DLR4WsAsUHboqNvnAJfF/ym8oU2SfUJyaBjsPKfT4P/mV4j3MwoAsE+kVjHZ11tCXB
	 ELCf4xNcZ3Yig==
Date: Tue, 23 Dec 2025 15:56:39 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
Message-ID: <aUpuXwb1h6rtlfoB@vaman>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-3-logang@deltatee.com>
 <aUE7zahyYgsls-Ic@vaman>
 <eeda026b-bfe1-42ba-a062-ca90b5f03ee6@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeda026b-bfe1-42ba-a062-ca90b5f03ee6@deltatee.com>

On 19-12-25, 10:19, Logan Gunthorpe wrote:
> Hi Vinod,
> 
> Thanks for reviewing this. I've queued up a bunch of changes based on
> your feedback, but I have some questions and notes.
> 
> On 2025-12-16 04:00, Vinod Koul wrote:
> >> +	struct switchtec_dma_desc **desc_ring;
> > 
> > This is bit interesting. Any reason why you choose double pointer here.
> > If you take a look at other driver, they follow similar approach but
> > dont use double pointer for this.
> > 
> 
> The ring size has had to be quite large. It is currently set to 32K in
> order to be able to get maximum performance in some work loads. While
> each element is only 104 bytes, the total array is more than 3MB which
> is too much for a single allocation. The PLX dma driver this is based on
> does the same thing even though it's queue size is only 2048.

Ring size is fine, the question is about use of a double pointer instead
of a single pointer

> >> +		if (swdma_chan->cq_tail == 0)
> >> +			swdma_chan->phase_tag = !swdma_chan->phase_tag;
> >> +
> >> +		/*  Out of order CE */
> >> +		if (se_idx != tail) {
> >> +			spin_unlock_bh(&swdma_chan->complete_lock);
> >> +			continue;
> >> +		}
> >> +
> >> +		do {
> >> +			dma_cookie_complete(&desc->txd);
> >> +			dma_descriptor_unmap(&desc->txd);
> >> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> >> +			desc->txd.callback = NULL;
> >> +			desc->txd.callback_result = NULL;
> > 
> > Not filling results?
> 
> I'm not sure the question here. This code calls the callback with the
> result and then clears the callback for the next use of the descriptor.
> 
> >> +			desc->completed = false;
> > 
> > ?
> > 
> 
> The completed flag is used to track which requests in the ring have been
> completed. It is set to true when it's completed and then cleared here
> when they have been cleaned up again for reuse in a subsequent
> transaction. The completions can happen out of order but they are
> cleaned up in order before they can be reused.
> >> @@ -127,9 +1140,13 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
> >>  {
> >>  	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
> >>  
> >> +	switchtec_dma_chans_release(pdev, swdma_dev);
> >> +
> >>  	rcu_assign_pointer(swdma_dev->pdev, NULL);
> >>  	synchronize_rcu();
> >>  
> >> +	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> >> +
> > 
> > This is good. But what about the tasklet, that needs to be quiesced too
> > 
> 
> I'm not sure what you are looking for, I couldn't find any explicit
> quiesce function that is commonly used on teardown in other drivers.
> Clearing the pdev pointer above and synchronizing the RCU should ensure
> there are no other jobs in progress or tasklets running.
> 
> Note: I have tested teardown while running dmatest and have not found
> any issues.

The tasklet can be schedule and then you free irq which creates a racy
situation, so I always recommend to kill the tasklet after freeing the
irq!

-- 
~Vinod

