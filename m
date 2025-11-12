Return-Path: <dmaengine+bounces-7140-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F9C524CE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 13:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DC93A3445
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C89330B33;
	Wed, 12 Nov 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oO/1YPJ8"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFB3128C0;
	Wed, 12 Nov 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951064; cv=none; b=su5LY57098VQgXkMdS/SFg7lV+mB+/DVh7BrViYPm+0/IFofGzqYhX8Fq/6NJk2/cpzCyOt+2Oyc/TRal8LwIJrp1ffQIv7SryKrFFPWegIRN0H2rfO2KIOPOAEXN9lMDXxsgKycm/uJELnL0YOep0z6dnA9mPkSRV3uvNKb/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951064; c=relaxed/simple;
	bh=OFL1MHh9EP1Ayrenr3ugXZ12uDSrH6U5EdxfZGv0WxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8EmpiD/dC8oxPJ+bSy2ujseGtUGBsZWVFy17UlOM/Ak4l2/Wozhbt4MN+VzpqmbEIDyftv07O7CIY2gVMHfDZTtiqLCPEcUwD21UXo4xuvY5soPnzPAXhdpdw3jFE8FnMO03WFuS+W5Nw5ixa//JaNrHX8/6McekKltxqy309s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oO/1YPJ8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDC5CE77;
	Wed, 12 Nov 2025 13:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762950941;
	bh=OFL1MHh9EP1Ayrenr3ugXZ12uDSrH6U5EdxfZGv0WxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oO/1YPJ8GdeejSKlgcE8s2eDYRE6ZmJYdJRXbYf3ExQGK7BxRYbKN9BuJaQUuOO6a
	 GPaaYnU0wN7uRP6C7g5bWLYTMV9UXF6v++obtm2lbOnrHdPJ/lU98IFrtirlQ1kxJb
	 Y6BAI1xMHGkS2vtpfGnO6HA5o5AAcc4J3PYAE/mU=
Message-ID: <21cf712a-8418-4351-928a-c5246430cc16@ideasonboard.com>
Date: Wed, 12 Nov 2025 14:37:37 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: xilinx_dma: Enable IRQs for AXIDMA in
 start_transfer
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, Vinod Koul <vkoul@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Sagar, Vishal" <vishal.sagar@amd.com>
References: <20251111-xilinx-dma-fix-v1-1-066c158bc18e@ideasonboard.com>
 <SA1PR12MB6798CC79FE8DA14ED2614771C9CCA@SA1PR12MB6798.namprd12.prod.outlook.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <SA1PR12MB6798CC79FE8DA14ED2614771C9CCA@SA1PR12MB6798.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/11/2025 14:22, Gupta, Suraj wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> Sent: Tuesday, November 11, 2025 8:37 PM
>> To: Vinod Koul <vkoul@kernel.org>; Simek, Michal <michal.simek@amd.com>
>> Cc: dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Sagar, Vishal <vishal.sagar@amd.com>; Tomi
>> Valkeinen <tomi.valkeinen@ideasonboard.com>
>> Subject: [PATCH] dmaengine: xilinx_dma: Enable IRQs for AXIDMA in
>> start_transfer
>>
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> A single AXIDMA controller can have one or two channels. When it has two
>> channels, the reset for both are tied together: resetting one channel
>> resets the other as well. This creates a problem where resetting one
>> channel will reset the registers for both channels, including clearing
>> interrupt enable bits for the other channel, which can then lead  to
>> timeouts as the driver is waiting for an interrupt which never comes.
>>
>> The driver currently has a probe-time work around for this: when a
>> channel is created, the driver also resets and enables the
>> interrupts. With two channels the reset for the second channel will
>> clear the interrupt enables for the first one. The work around in the
>> driver is just to manually enable the interrupts again in
>> xilinx_dma_alloc_chan_resources().
>>
>> This workaround only addresses the probe-time issue. When channels are
>> reset at runtime (e.g., in xilinx_dma_terminate_all() or during error
>> recovery), there's no corresponding mechanism to restore the other
>> channel's interrupt enables. This leads to one channel having its
>> interrupts disabled while the driver expects them to work, causing
>> timeouts and DMA failures.
>>
>> A proper fix is a complicated matter, as we should not reset the other
>> channel when it's operating normally. So, perhaps, there should be some
>> kind of synchronization for a common reset, which is not trivial to
>> implement. To add to the complexity, the driver also supports other DMA
>> types, like VDMA, CDMA and MCDMA, which don't have a shared reset.
>>
>> However, when the two-channel AXIDMA is used in the (assumably) normal
>> use case, providing DMA for a single memory-to-memory device, the
>> common
>> reset is a bit smaller issue: when something bad happens on one channel,
>> or when one channel is terminated, the assumption is that we also want
>> to terminate the other channel. And thus resetting both at the same time
>> is "ok".
>>
>> With that line of thinking we can implement a bit better work around
>> than just the current probe time work around: let's enable the
>> AXIDMA interrupts at xilinx_dma_start_transfer() instead.
>> This ensures interrupts are enabled whenever a transfer starts,
>> regardless of any prior resets that may have cleared them.
>>
>> This approach is also more logical: enable interrupts only when needed
>> for a transfer, rather than at resource allocation time, and, I think,
>> all the other DMA types should also use this model, but I'm reluctant to
>> do such changes as I cannot test them.
>>
>> The reset function still enables interrupts even though it's not needed
>> for AXIDMA anymore, but it's common code for all DMA types (VDMA, CDMA,
>> MCDMA), so leave it unchanged to avoid affecting other variants.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
> 
> A warning has long been included in the PG stating that multichannel support for AXI DMA will be discontinued. Please refer 2022.1 AXIDMA PG:
>  https://www.amd.com/content/dam/xilinx/support/documents/ip_documentation/axi_dma/v7_1/pg021_axi_dma.pdf : Product Specification/Multichannel DMA support.
> Therefore, it's unnecessary to make changes for multiple channel support.

A warning in a document doesn't help the users who use AXI DMA with
multichannel, and have the kernel driver time-outing.

The multichannel AXI DMA is supported in the latest Vivado release. And
even if it wasn't, in my experience people often use older Vivado
releases. And even if they didn't, the IP has been out there for a long
time, so there are existing FPGA bitstreams with multichannel AXI DMA in
use.

I realized this patch should say it's a fix in the subject line, and
have a Fixes tag, so I'll send a v2.

 Tomi

> 
>>  drivers/dma/xilinx/xilinx_dma.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index a34d8f0ceed8..50dd93ce6741 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1216,14 +1216,6 @@ static int xilinx_dma_alloc_chan_resources(struct
>> dma_chan *dchan)
>>
>>         dma_cookie_init(dchan);
>>
>> -       if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
>> -               /* For AXI DMA resetting once channel will reset the
>> -                * other channel as well so enable the interrupts here.
>> -                */
>> -               dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
>> -                             XILINX_DMA_DMAXR_ALL_IRQ_MASK);
>> -       }
>> -
>>         if ((chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) &&
>> chan->has_sg)
>>                 dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
>>                              XILINX_CDMA_CR_SGMODE);
>> @@ -1572,6 +1564,7 @@ static void xilinx_dma_start_transfer(struct
>> xilinx_dma_chan *chan)
>>                              head_desc->async_tx.phys);
>>         reg  &= ~XILINX_DMA_CR_DELAY_MAX;
>>         reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
>> +       reg |= XILINX_DMA_DMAXR_ALL_IRQ_MASK;
>>         dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>>
>>         xilinx_dma_start(chan);
>>
>> ---
>> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
>> change-id: 20251111-xilinx-dma-fix-bc26a6e9be5a
>>
>> Best regards,
>> --
>> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>
> 


