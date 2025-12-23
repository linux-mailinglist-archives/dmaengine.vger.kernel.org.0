Return-Path: <dmaengine+bounces-7913-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E74CDA4A9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 19:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06788302AFB1
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D9933FE08;
	Tue, 23 Dec 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="iK82Uqj8"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360627B340
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766515265; cv=none; b=tuGJJQjxSDMjcMRHHRbH9lazHsyfz6Ip7n0kk9cdW+limELcO36qHYkfE5swr5PT6Ox4+7uSjzrwF+K0tYs4jhxtfX9HuWC55NvkmuRge0kGxfG2Im+mkKcM9PZiwR6CTWTA6StkdbjUjVIhZt3E+Xfk5pBKBdtxcL2htjOSxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766515265; c=relaxed/simple;
	bh=08S+ppuKSSoXIrnhy4sRHIsllmsVwWklIO3XAeN/cUo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=DMBXCcOcEC+DL8PY6PvMmiw0OTzGyKmxgjZue43I0TEO2X0olL8Cg17UEvT8fYMBsLB3DOmovSRe5hSjxI6pPTJ4nZersNt/sNRWy9QiitEbJ+01OI2kP8eu4ZLJoNye9xOIe7Z2eMxv7Y52ZL36O5X5gTokN2fdkFu71yqPJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=iK82Uqj8; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=RqxUPiMEAVU3f1j/Wu9JVAnLlowg0yNtqssNEqsE73o=; b=iK82Uqj8z2sCXGMLLuS9gjMbto
	iD0TLGjdu1H3SZNKeCuI+pi3iXOhr/mm+BEwoG71N4oOnb0Y+KijxAKMusCknFwIxeATIF5REboRt
	fT5UMWpgYG3qdqrVXL4GOSAXMyTi/qvEWMv7pUV4q4BUva1k6aS4QD2sDA7bjLKmfrgX1jZhqP2hY
	AyAU/Mvsmqx0+cWsnnGUlGa3cmFkT6utqddPdKYQMcrqAh3c5Q5B+zRwzDSRjROOCrgtv4fHb0H7S
	r7JeGufIDUEretBZqxrPl3fqSyyl4xJH1zEeDL868LbqQ/EHSrrNKTgd/qoQ09G6KQ65Fvz0CgZYk
	F0Q6PXDQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vY7JW-000000099ql-3oXJ;
	Tue, 23 Dec 2025 11:40:55 -0700
Message-ID: <297aaeb1-9b83-41d9-96bb-5c71d94ca9d7@deltatee.com>
Date: Tue, 23 Dec 2025 11:40:38 -0700
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
 <ab9b7838-09bf-4a1c-9d93-097b3dca0e02@deltatee.com> <aUpv3fP3PIhJVr9h@vaman>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aUpv3fP3PIhJVr9h@vaman>
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



On 2025-12-23 03:33, Vinod Koul wrote:
> On 19-12-25, 10:42, Logan Gunthorpe wrote:
>> On 2025-12-16 04:50, Vinod Koul wrote:
>>> What about the descriptor, you should push into a pending queue or
>>> something here?
>>
>> There's only the one queue in this driver and it is added to directly by
>> switchtec_dma_prep_memcpy(). So there's nothing more to do on the
>> hardware's side to submit the job. The jobs added to the queue with the
>> prep() function will start to be processed when the sq_tail pointer is
>> set in switchtec_dma_issue_pending() below.
> 
> That is not really correct dmaengine semantics, please fix that.
> We expect the descriptor to be prepared in the prep_xxx call. Then we
> expect it to be submitted in a queue and finally pushed to hardware on
> issue_pending. 

Ok, I was digging into this. The PLX driver this was based on is a bit
different, the switchtec one is actually closer to the IOAT driver. Both
have a ring queue with a head index that gets incremented for each entry.

As best as I can tell the IOAT driver increments a produce value after a
prep_xxx call and then in tx_submit function it copies the the produce
value to the actual head value. The switchtec driver, unlike IOAT, only
ever "produces" one reqeust at a time, but I think if we move the head
increment from the prep command into the tx_submit() call it will be
correct.
>> We've answered this question a couple times now. See my detailed
>> response here:
>>
>> https://lore.kernel.org/all/e759d483-e303-421a-b674-72fd9121750d@deltatee.com/
>>
>> Essentially this is the only place we have to do the cleanup when
>> running jobs with interrupts disabled (a valid use case). Both PLX and
>> IOAT do similar things for good reasons and we'd really rather not have
>> the downsides noted in the link above without a more compelling
>> technical reason for this being incorrect.
> 
> This feels wrong :-) Relying on query to cleanup should not be done. A
> client may not issue this. It is not a mandatory thing to do!
> I would not suggest enabling interrupts, as you suggested in the link
> above. I am sure you are getting at least some completion notices? The
> tasklet can then do the cleanup as well. that would be a better reliable
> way to do this
> 
> We should fix the other two drivers!

Yes, it is not mandatory to call tx_status() nor is it mandatory to be
called with the IOAT, PLX and Swithctec drivers as they are currently
written. The only "completion notice" the hardware can send is the
hardware interrupt and if we want to disable that interrupt for a polled
mode of operation then the completions need to be processed somewhere
and the only place to do that is in tx_status().

The way I read things is there are two ways to operate: with or without
interrupts.

1) If interrupts are used (DMA_PREP_INTERRUPT is set), then the tasklet
will be triggered by the hardware interrupt and the tasklet will handle
the cleanup. The tasklet calls the callback which signals the user. In
this situation *if* tx_status() is called, the dma cookie will likely
already be set and the function will return early without calling
cleanup(). If tx_status() doesn't get called, the tasklet would process
the completion and call the callback and everything works fine. If
tx_status() happens to be called before the interrupt occurs, then
cleanup() would be called but chances are nothing will be done; or it
could cleanup a descriptor before the tasklet if the timing is just
right (but that would not be a problem either).

2) If interrupts are not used (DMA_PREP_INTERRUPT is not set), then no
interrupt will occur and thus the tasklet will never run. The only way
for the user to know if a job is done is by calling tx_status(). In
which case, the driver must query the hardware for pending completions
during the tx_status() call. There is no other place to process the
completions.

The only option we have to remove the cleanup() call from tx_status()
would be to essentially ignore DMA_PREP_INTERRUPT and thus the hardware
interrupt will always occur for every request regardless of whether the
user needs to be interrupted or not. This means applications that don't
need the interrupt will incur extra hardware interrupts when they aren't
really needed. I personally think that is a bad choice: it is much
better to disable the hardware interrupt if nothing is waiting for it
and process the completions in tx_status() when it is polled.

Logan

