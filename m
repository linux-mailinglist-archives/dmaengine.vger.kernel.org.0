Return-Path: <dmaengine+bounces-1338-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5D878FC4
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 09:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F1B21244
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8DF77653;
	Tue, 12 Mar 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="C7Qz3kig"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD16996B;
	Tue, 12 Mar 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232420; cv=none; b=j6qdDCLGezoB2kHDgcvQPIa31Yw+8FRDvcGOwWjaI379S3HIZYV4TOqmkrvfM+nx3J+9R8JCKZLsvX59WBj+IzqLgpUWbS0qd/UmdV64Hvw7zDuA49o7ROi6Hqh/5bcg3Uxq8SVOQXWvp4rSiTbSmrTLd4XQL9J8MoGegbk3ltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232420; c=relaxed/simple;
	bh=F4FI4TEPmW6HpghVEUhvigjPs95L9pRHfmQ3RJKOSKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeoFEYRm+Qllfxnyj7lTatbCLe+k3LGAKd7U2KS3xCvTu5UUqBmPdPrcSieWs+zJapovo419bBtU4VIqaWsvTGEzSUFHW5MLvuSiqPGZEZ5d3TwO8f8RQPf1HfEirFc2g/EbTgqjdjHsOHQhBhqHVR1oXsg75s74zEP8VRSZvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=C7Qz3kig; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0EAC593;
	Tue, 12 Mar 2024 09:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710232394;
	bh=F4FI4TEPmW6HpghVEUhvigjPs95L9pRHfmQ3RJKOSKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C7Qz3kigD9GNZy34kDrQUh7pe9knNdMvGCsHIFWupmNT9euyeNzhRPLokgcAwjYSe
	 xv7OeALkvDippmDwvpecImnh5KIZJc+mmuRSKnV2sIqpZPPBdulCXJShiKd2APNpd2
	 FClD5W0J3NGLwG645fprzZvc3nNWX2XxqZbKEV/I=
Message-ID: <b08c99fe-c221-4eb8-9b1a-1420cb5c32f3@ideasonboard.com>
Date: Tue, 12 Mar 2024 10:33:32 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: xilinx: dpdma: Fix race condition in
 vsync IRQ
Content-Language: en-US
To: Vishal Sagar <vishal.sagar@amd.com>, laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org
Cc: michal.simek@amd.com, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 varunkumar.allagadapa@amd.com
References: <20240228042124.3074044-1-vishal.sagar@amd.com>
 <20240228042124.3074044-2-vishal.sagar@amd.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240228042124.3074044-2-vishal.sagar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28/02/2024 06:21, Vishal Sagar wrote:
> From: Neel Gandhi <neel.gandhi@xilinx.com>
> 
> The vchan_next_desc() function, called from
> xilinx_dpdma_chan_queue_transfer(), must be called with
> virt_dma_chan.lock held. This isn't correctly handled in all code paths,
> resulting in a race condition between the .device_issue_pending()
> handler and the IRQ handler which causes DMA to randomly stop. Fix it by
> taking the lock around xilinx_dpdma_chan_queue_transfer() calls that are
> missing it.
> 
> Signed-off-by: Neel Gandhi <neel.gandhi@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>
> 
> Link: https://lore.kernel.org/all/20220122121407.11467-1-neel.gandhi@xilinx.com
> ---
>   drivers/dma/xilinx/xilinx_dpdma.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

This fixes a lockdep warning:

WARNING: CPU: 1 PID: 466 at drivers/dma/xilinx/xilinx_dpdma.c:834

Afaics, this issue has been around since the initial commit, in v5.10, 
and the fix applies on top of v5.10. I have tested this on v6.2, which 
is where the DP support was added to the board I have.

So I think you can add:

Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx 
DisplayPort DMA engine driver")

  Tomi

> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b82815e64d24..28d9af8f00f0 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1097,12 +1097,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
>   	 * Complete the active descriptor, if any, promote the pending
>   	 * descriptor to active, and queue the next transfer, if any.
>   	 */
> +	spin_lock(&chan->vchan.lock);
>   	if (chan->desc.active)
>   		vchan_cookie_complete(&chan->desc.active->vdesc);
>   	chan->desc.active = pending;
>   	chan->desc.pending = NULL;
>   
>   	xilinx_dpdma_chan_queue_transfer(chan);
> +	spin_unlock(&chan->vchan.lock);
>   
>   out:
>   	spin_unlock_irqrestore(&chan->lock, flags);
> @@ -1264,10 +1266,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
>   	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&chan->vchan.lock, flags);
> +	spin_lock_irqsave(&chan->lock, flags);
> +	spin_lock(&chan->vchan.lock);
>   	if (vchan_issue_pending(&chan->vchan))
>   		xilinx_dpdma_chan_queue_transfer(chan);
> -	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +	spin_unlock(&chan->vchan.lock);
> +	spin_unlock_irqrestore(&chan->lock, flags);
>   }
>   
>   static int xilinx_dpdma_config(struct dma_chan *dchan,
> @@ -1495,7 +1499,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
>   		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
>   
>   	spin_lock_irqsave(&chan->lock, flags);
> +	spin_lock(&chan->vchan.lock);
>   	xilinx_dpdma_chan_queue_transfer(chan);
> +	spin_unlock(&chan->vchan.lock);
>   	spin_unlock_irqrestore(&chan->lock, flags);
>   }
>   


