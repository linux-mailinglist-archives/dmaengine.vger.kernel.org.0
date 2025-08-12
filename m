Return-Path: <dmaengine+bounces-6002-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312CB22DDE
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B10189841E
	for <lists+dmaengine@lfdr.de>; Tue, 12 Aug 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFD2F8BCC;
	Tue, 12 Aug 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hIuBuJ08"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EE2F8BDB;
	Tue, 12 Aug 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016401; cv=none; b=COpvWIsXWqjN8Cye4qJ1K5s2Mwbb5UVIcDZWauIZWL46N4G/YZtVvr5yplt6TT1WcLBeXkFoB5iDc86EBPZF9yK3EKtvorMfECLpIc90koOliua+bBh+pXIPvnM3Yl4RQG0NdU4F18CTJzMvcICTIHI20GW2+AD6VXQr/oN/ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016401; c=relaxed/simple;
	bh=CqpUA8952lLunDQQNYVS/muDqp7cWpzumg59eFcPkH0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=IF1uxAz/qrbuZ123viFmuhAvxqToYWsf4ARxWP5nMkabjvJyxRkJyPLgOF7YLviipvJC6nycEYN+kI8rONUAOxaao+RKuXke8HqexzX1GN2Paubcmkq53FHZSWf6sMgGW554m6zcvD/sBy+EHCva2e8e1Kxb7aeEjx73oww/tPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=hIuBuJ08; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=tIHiI04uLn5Zgoq7yZCDLgPs+9RfpYL/t4+pyEcuJHc=; b=hIuBuJ08hurpstZPnZnFEQJFhx
	BEUE+1fvS/jlBVLTw8NcGCLXjgS7LhD9Mnwlt1Czb0XWNjoxloVIJbc/eHVuf9WX+tEMaciZ7QLBC
	GfYRR5uY3rYF61VAev5/fmGy9fYQmo5nmgx2yDGkgZ9Zz293c1lSbzta9LHXl5K50sWPfieV6MDAh
	fVfUXy3bFBcXwIHNR6pWir1CewFXHuLRVnQV01d/auc+h0Ce3utKpqd9ZLY7VTLgh7oovxgNVCH1k
	aSY2ofKhAC5mJFsdGE01o567sNc5VAH9rL4poL3GYsZDCKB5Yiuuc4TZR7iqhCsQzNMOeu8cXhDCf
	3VigOr0g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1ulrvx-002JNV-2Y;
	Tue, 12 Aug 2025 10:33:10 -0600
Message-ID: <e759d483-e303-421a-b674-72fd9121750d@deltatee.com>
Date: Tue, 12 Aug 2025 10:32:58 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, George.Ge@microchip.com,
 christophe.jaillet@wanadoo.fr, hch@infradead.org
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com> <ZhKPsKFyaXFliJP4@matsya>
 <3baed5bf-8fa1-4ef9-8cb1-58145a6dd37c@deltatee.com> <aJopotHoEEbe6ll3@vaman>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aJopotHoEEbe6ll3@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: vkoul@kernel.org, kelvin.cao@microchip.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, George.Ge@microchip.com, christophe.jaillet@wanadoo.fr, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-08-11 11:34, Vinod Koul wrote:
> On 05-08-25, 13:15, Logan Gunthorpe wrote:
>>> This is *wrong*, you cannot process desc in status API, Please read the
>>> documentation again and if in doubt pls ask
>>
>> I don't see any other way to do this. There's no other place to cleanup
>> the completed descriptors. This is exactly what was done in the plx-dma
>> driver which copied the IOAT driver that began this pattern. There was
>> very similar feedback when I submitted the plx-dma driver[1] and I
>> pointed out there's no other way to do this.
> 
> we should try fixing these
>>
>> I'll rename the function to make this a little clearer, but I can't see
>> any other way to implement the driver without doing this.
> 
> Dont you get a notification from hardware on completion, that should
> trigger this as well as issue_pending calls... 

I dug into this a bit more this morning.

For at least PLX and the new Switchtec drivers, the hardware interrupt
is disabled when DMA_PREP_INTERRUPT is set by the caller. This makes
sense to me seeing if the caller doesn't care to be interrupted quickly
then there's not much point in paying the cost of the interrupt and
tasklet.

However if, for any reason, the caller never sets DMA_PREP_INTERURPT
then the tasklet never fires and the descriptors never have an
opportunity to get cleaned up. Presumably such a caller would be calling
dmaengine_tx_status() to poll for finished jobs and thus it's a natural
place to poll and cleanup descriptors on the ring.

I personally think this is the correct and best way to go about it.
Cleaning up descriptors is fast and if the descriptors were already
handled in the tasklet then it doesn't need to do anything anyway and
there's negligible costs.

There are two other options I can see each with significant costs:

1) Change the DMA driver so that the interrupt and tasklet gets
triggered on every completion even if DMA_PREP_INTERRUPT is not set.
This means the interrupt and tasklet will always run even if the
application says it doesn't want an interrupt. This would increase the
overhead on applications that might want to submit multiple requests and
interrupt only on the last one or simply not use interrupts and poll for
completions. (Though I don't know if any applications like that exist at
the present time).

2) Remove the cleanup in the status() call and keep everything else the
same. This would keep the performance the same but if any application
tries to use the DMA engine without periodically setting
DMA_PREP_INTERRUPT, then the driver will hang as it will never cleanup
the used up entries in the ring.

So, again, I really think the way it is now is the best option and I
personally can not see what the down side is to it.

Logan





