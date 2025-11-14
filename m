Return-Path: <dmaengine+bounces-7178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B32C5F89A
	for <lists+dmaengine@lfdr.de>; Fri, 14 Nov 2025 23:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA394E12AF
	for <lists+dmaengine@lfdr.de>; Fri, 14 Nov 2025 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206C2DC34E;
	Fri, 14 Nov 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ECKBne5N"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C835898;
	Fri, 14 Nov 2025 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160863; cv=none; b=RDwC1cYQ6DhbUkycoEZBUZNxKSvfW0ad5DZMCflYrXlY5QfcOMKIcZCuqr0b2YHKSDqeD2pGzl35Omk+wuVjd64+aUMZ/ly0AByojsJaRrtZH3vwpn6yQPaPbFJiZ6Cn2+jv/Ll4/m/EiVLNRXl0Wiygu/8GCIyWCx24giHo5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160863; c=relaxed/simple;
	bh=igKZNI7vqFTsNdzNgP3rVjKw6EEDq7mt3q6XNKMYGQE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:References:In-Reply-To:
	 Content-Type:Subject; b=pTRU5YatSfWCH+dj/KGGSkP4wFR4LWRNk9kJ8Jcy1Txxdgn04ujdpcOzXqCwCOKnJo46x0yuasSxPYn2NzFOdkZ0rA3G2qoHfnoJIqY4VtVYeQIBQ4EcKnF9Yx5UIXpxskbjFUeovU1MBUZeQOAygarlMLb44Vldq1MJIKqgIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ECKBne5N; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=rsPfw2Y8oba9FYVlEPQAcLDRGIRHbeiCoqIwZ5CFFuM=; b=ECKBne5NZga+niwLv0x860VE0k
	zPFH+R8hIQ8K1F512KwlHMzfYl43g+Y97wtoXy4C4qLMl6EWmB57qh4Zj07epX2mSQ9cVFYkCPyK0
	hjQW3c8E15jtJc2/C6X1KxQuvHDOaJ7JPnyqJevFOV/q2Vp7rr6GSDw+eJH1LvTyMhG5neLLtFT6w
	7NvI2Ga1aih6IIKoo1XUKHYd5X1UYko6Z2zq5OBw1UDh2uP+E382VPDB2wYPRJbbEUyW4qGliKAQi
	F9AL+1vUc1SLJP8KohJi8GxM83p4Gz8bfKntU2tgSSsWi8+s6DNz+XrtPljhEn/coylBbKrO8wQyc
	4hqTU8VQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.9])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vK2Hd-00000000uqb-0uuN;
	Fri, 14 Nov 2025 15:28:46 -0700
Message-ID: <0970f42e-503b-49e8-9450-cf83c476d580@deltatee.com>
Date: Fri, 14 Nov 2025 15:28:29 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Logan Gunthorpe <logang@deltatee.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, George.Ge@microchip.com,
 christophe.jaillet@wanadoo.fr, hch@infradead.org
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com> <ZhKPsKFyaXFliJP4@matsya>
 <3baed5bf-8fa1-4ef9-8cb1-58145a6dd37c@deltatee.com> <aJopotHoEEbe6ll3@vaman>
 <e759d483-e303-421a-b674-72fd9121750d@deltatee.com>
Content-Language: en-CA
In-Reply-To: <e759d483-e303-421a-b674-72fd9121750d@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: vkoul@kernel.org, kelvin.cao@microchip.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, George.Ge@microchip.com, christophe.jaillet@wanadoo.fr, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-08-12 10:32 a.m., Logan Gunthorpe wro
> On 2025-08-11 11:34, Vinod Koul wrote:
>> On 05-08-25, 13:15, Logan Gunthorpe wrote:
>>
>> Dont you get a notification from hardware on completion, that should
>> trigger this as well as issue_pending calls... 
> 
> I dug into this a bit more this morning.
> 
> For at least PLX and the new Switchtec drivers, the hardware interrupt
> is disabled when DMA_PREP_INTERRUPT is set by the caller. This makes
> sense to me seeing if the caller doesn't care to be interrupted quickly
> then there's not much point in paying the cost of the interrupt and
> tasklet.
> 
> However if, for any reason, the caller never sets DMA_PREP_INTERURPT
> then the tasklet never fires and the descriptors never have an
> opportunity to get cleaned up. Presumably such a caller would be calling
> dmaengine_tx_status() to poll for finished jobs and thus it's a natural
> place to poll and cleanup descriptors on the ring.
> 
> I personally think this is the correct and best way to go about it.
> Cleaning up descriptors is fast and if the descriptors were already
> handled in the tasklet then it doesn't need to do anything anyway and
> there's negligible costs.
> 
> There are two other options I can see each with significant costs:
> 
> 1) Change the DMA driver so that the interrupt and tasklet gets
> triggered on every completion even if DMA_PREP_INTERRUPT is not set.
> This means the interrupt and tasklet will always run even if the
> application says it doesn't want an interrupt. This would increase the
> overhead on applications that might want to submit multiple requests and
> interrupt only on the last one or simply not use interrupts and poll for
> completions. (Though I don't know if any applications like that exist at
> the present time).
> 
> 2) Remove the cleanup in the status() call and keep everything else the
> same. This would keep the performance the same but if any application
> tries to use the DMA engine without periodically setting
> DMA_PREP_INTERRUPT, then the driver will hang as it will never cleanup
> the used up entries in the ring.
> 
> So, again, I really think the way it is now is the best option and I
> personally can not see what the down side is to it.

I've sent the patches for this discussion a couple times now over the
last few months and have not received any response:

https://lore.kernel.org/dmaengine/20251014192239.4770-1-logang@deltatee.com/T/#t

Have the patches been getting through?

Thanks,

LOgan

