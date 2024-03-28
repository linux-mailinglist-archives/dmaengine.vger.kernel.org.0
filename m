Return-Path: <dmaengine+bounces-1620-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205EF89027F
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2531C25A3C
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656D78626D;
	Thu, 28 Mar 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pSI293zi"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402E80027
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638033; cv=none; b=aXO1fFFn1OwAXiPSXA8Zyb2hjlU2GLunHYvZzrvgTs1pcQY/yvFr6810NMF/XyRN3xHl6LDITusNA2npl8LFyOq5YTfSgWLXMYXgPr85E5lSAlGHH8SwwslZxFQ8WbJ0meVYanblLxVD+1BBeVuouEeLpihKSoumZFPhXcH/QcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638033; c=relaxed/simple;
	bh=QcYao87vHK3QJ3Zezb5WiwzKOnj5m0Xji4J1XJL6zKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjGbwewhFax+s7zhHuDDMtNU8NlNLeOHccakUWi0gt/dJxc204/61bloxuYt9ymAPtuWD+4z7sw0KnkHgYdEYlgMWty3x4Xuz+y8AM81zwaHP9dEQHZaPJIfv/w1k+Oqy4UVCCGQ9Vs7/BboTdJtmPXGr8yJPC+i/mgp4/6kF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pSI293zi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6a8c1c8-258a-447b-b6cd-199f33199388@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711638028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnqQ84/rMjC+/rcGQR2+/HXsL+AxeYk9jECNf55kBHU=;
	b=pSI293ziwMZM/xh2IUz27+6/EZ2rERRrKJz2IlDn3Ql42kY6xoKt0zIee6GNFz3GAUN66I
	vh1yg2NdG+pSoEk3BktZGUQE+cNSoB2L5EsSOV5xH6Tz4jIXj1Cby7JYJHB+6R+G0cJaHh
	wk2zMItRX3y+JW8JpXDmSxILAzEWIIk=
Date: Thu, 28 Mar 2024 11:00:24 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] dma: xilinx_dpdma: Remove unnecessary use of
 irqsave/restore
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
 <20240308210034.3634938-3-sean.anderson@linux.dev>
 <0652c82f-b0a2-4881-ac51-38399b180ad4@ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <0652c82f-b0a2-4881-ac51-38399b180ad4@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/27/24 08:27, Tomi Valkeinen wrote:
> Hi,
> 
> On 08/03/2024 23:00, Sean Anderson wrote:
>> xilinx_dpdma_chan_done_irq and xilinx_dpdma_chan_vsync_irq are always
>> called with IRQs disabled from xilinx_dpdma_irq_handler. Therefore we
>> don't need to save/restore the IRQ flags.
> 
> I think this is fine, but a few thoughts:
> 
> - Is spin_lock clearly faster than the irqsave variant, or is this a pointless optimization? It's safer to just use irqsave variant, instead of making sure the code is always called from the expected contexts.

It's not an optimization. Technically this will save a few instructions,
but...

> - Is this style documented/recommended anywhere? Going through docs, I only found docs telling to use irqsave when mixing irq and non-irq contexts.

The purpose is mainly to make it clear that this is meant to be called
in IRQ context. With irqsave, there's an implication that this could be
called in non-IRQ context, which it never is.

> - Does this cause issues on PREEMPT_RT?

Why would it?

--Sean

> 
>  Tomi
> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>   drivers/dma/xilinx/xilinx_dpdma.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
>> index eb0637d90342..36bd4825d389 100644
>> --- a/drivers/dma/xilinx/xilinx_dpdma.c
>> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
>> @@ -1043,9 +1043,8 @@ static int xilinx_dpdma_chan_stop(struct xilinx_dpdma_chan *chan)
>>   static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
>>   {
>>       struct xilinx_dpdma_tx_desc *active;
>> -    unsigned long flags;
>>   -    spin_lock_irqsave(&chan->lock, flags);
>> +    spin_lock(&chan->lock);
>>         xilinx_dpdma_debugfs_desc_done_irq(chan);
>>   @@ -1057,7 +1056,7 @@ static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
>>                "chan%u: DONE IRQ with no active descriptor!\n",
>>                chan->id);
>>   -    spin_unlock_irqrestore(&chan->lock, flags);
>> +    spin_unlock(&chan->lock);
>>   }
>>     /**
>> @@ -1072,10 +1071,9 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
>>   {
>>       struct xilinx_dpdma_tx_desc *pending;
>>       struct xilinx_dpdma_sw_desc *sw_desc;
>> -    unsigned long flags;
>>       u32 desc_id;
>>   -    spin_lock_irqsave(&chan->lock, flags);
>> +    spin_lock(&chan->lock);
>>         pending = chan->desc.pending;
>>       if (!chan->running || !pending)
>> @@ -1108,7 +1106,7 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
>>       spin_unlock(&chan->vchan.lock);
>>     out:
>> -    spin_unlock_irqrestore(&chan->lock, flags);
>> +    spin_unlock(&chan->lock);
>>   }
>>     /**
> 

