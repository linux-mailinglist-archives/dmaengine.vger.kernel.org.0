Return-Path: <dmaengine+bounces-7846-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A4DCD1403
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 18:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92642311C320
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48D3446BE;
	Fri, 19 Dec 2025 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="UXZWqOVm"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0A344040
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166162; cv=none; b=AApLCOpxkPTY//jk2wNsREtb9HSHISr/ZCWfbdQouXBipr3sQV4Uip5+F4C1APoFhY+kxp4+Zk+wk+sPr1kffCRNkXBqno8JXvfeo91O9KJGKFz0i9M7tHyNXLa35wvmUcI6BW6lr35aVx83alQNxBVfw1RYmIozCYWprUh4MrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166162; c=relaxed/simple;
	bh=RpX7n+4ZZkiXSpud5wp+/ekCaq+Nh8sWtCd8zg4Z1AQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=gZG+5Um0R48CiJDMt99dNg1mgcVKjjuu0LNCnGeisDZV0JNaweHLQo1XsbWxqo9N34Xy1b5RqGvBDba66ihk8Sx46bYQtHplYTSW5mWL61SwfzWctWG21vYn84iVbleGsLHdC/rRB4kTHc8y5ixhLedJV91c70VMzR5S1sk/b1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=UXZWqOVm; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=avo63WFAFKlREy9jj7wGGOhpEzFVJ0iyBJ+ViT6hof0=; b=UXZWqOVmCDzbkizMHWmMO8CHYY
	J6exEoPjiEQXuxcaGpbX+Noatrl+o74OHnAIQYr+5hwuzAThCDZHummQftYHprHbAbjN7r8IySoTv
	4fpN+p0inK6FrZTl+QQDnbsAvsvi3IjxDO5Pbi9UuqYmqTJLTKzZ9ydQ2HylRznaV6GhoHh5YCn/D
	k73c/9uBHr8IiRp8Or4w855IWyAh+uHXDfzuljDr1FZWSXjG0wsb8ehOx+JBQClv/Aq2krMrzYFcJ
	fqA9gxtZ+fhonQigJ8X6LScb5nVRsnvZ/pnQb3wtulLu1SQGqCvD9iI/bu8T+pM8PrzBPWVTAkl4o
	v90DkWOg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vWeUx-00000006Cpp-0AC4;
	Fri, 19 Dec 2025 10:42:39 -0700
Message-ID: <ab9b7838-09bf-4a1c-9d93-097b3dca0e02@deltatee.com>
Date: Fri, 19 Dec 2025 10:42:38 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, Kelvin Cao <kelvin.cao@microchip.com>,
 George Ge <George.Ge@microchip.com>, Christoph Hellwig <hch@infradead.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Christoph Hellwig <hch@lst.de>
References: <20251215181649.2605-1-logang@deltatee.com>
 <20251215181649.2605-4-logang@deltatee.com> <aUFHfUFNrDojRoRm@vaman>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aUFHfUFNrDojRoRm@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, dmaengine@vger.kernel.org, kelvin.cao@microchip.com, George.Ge@microchip.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v11 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-12-16 04:50, Vinod Koul wrote:
>> +static dma_cookie_t
>> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
>> +	__releases(swdma_chan->submit_lock)
>> +{
>> +	struct switchtec_dma_chan *swdma_chan =
>> +		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
>> +	dma_cookie_t cookie;
>> +
>> +	cookie = dma_cookie_assign(desc);
>> +
>> +	spin_unlock_bh(&swdma_chan->submit_lock);
>> +
>> +	return cookie;
>> +}
> 
> What about the descriptor, you should push into a pending queue or
> something here?

There's only the one queue in this driver and it is added to directly by
switchtec_dma_prep_memcpy(). So there's nothing more to do on the
hardware's side to submit the job. The jobs added to the queue with the
prep() function will start to be processed when the sq_tail pointer is
set in switchtec_dma_issue_pending() below.

>> +
>> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
>> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
>> +{
>> +	struct switchtec_dma_chan *swdma_chan =
>> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
>> +	enum dma_status ret;
>> +
>> +	ret = dma_cookie_status(chan, cookie, txstate);
>> +	if (ret == DMA_COMPLETE)
>> +		return ret;
>> +
>> +	switchtec_dma_cleanup_completed(swdma_chan);
> 
> Why are we doing this on a status query??

We've answered this question a couple times now. See my detailed
response here:

https://lore.kernel.org/all/e759d483-e303-421a-b674-72fd9121750d@deltatee.com/

Essentially this is the only place we have to do the cleanup when
running jobs with interrupts disabled (a valid use case). Both PLX and
IOAT do similar things for good reasons and we'd really rather not have
the downsides noted in the link above without a more compelling
technical reason for this being incorrect.

>> +
>> +	return dma_cookie_status(chan, cookie, txstate);
> 
> No setting residue?

residue is set in switchtec_dma_cleanup_completed() which is called a
couple lines up.

>> +
>> +	spin_lock_bh(&swdma_chan->submit_lock);
>> +	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
>> +	spin_unlock_bh(&swdma_chan->submit_lock);
>> +
>> +	rcu_read_unlock();
>> +}
> 
> This seems to assume that the channel is idle when issue_pending is
> invoked. That is not the right assumption, we can be running a txn so you
> need to check if channel is not running and start if it is idle

This is just updating the tail pointer for the hardware's submission
queue. If the channel is idle, it will start processing of a job. But if
the channel is not idle it informs the hardware there are more elements
in the queue.  Not doing this if the hardware is not idle would mean the
hardware never gets informed there are more jobs in the queue. That
would not be correct.

Thanks,

Logan

