Return-Path: <dmaengine+bounces-1350-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7D879AD0
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F68428529F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A221386B9;
	Tue, 12 Mar 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hp/GvCMy"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6B1384B8
	for <dmaengine@vger.kernel.org>; Tue, 12 Mar 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265609; cv=none; b=nCz4YlF8FKwvF6ytjpySEUjyJ/Ifz1wQmiwX/42Zy7sYaISt9KLuw7KDmmFE7mLH1rH7xRgAsVFp8U5d7zorxkhrjaHHP+Cea0g6iE8wnjTkNhNtDAXJSNngbIW2i+wYW0vpGi6/8LON37yhZiGOfboJeJ9v1DH4qfOeRvGtya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265609; c=relaxed/simple;
	bh=rPfGN5w2HwyLrxgDW8705e7jnqF6QYY783ggHhVlM+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYwXn43WwGsw25koB935Vb6qw9rER4g4sQ7m3NHjeVprHCwE/KtmChxrqw/ypvj8F5XWxpsTqA+v7bTliWc7KYUqF9Z7zn1Vq4UF8Eh2+PvCxs+oXECCDDGzsmsavUW2l/blpN+cGL1comJJ1ZQU7pzgX95zsgUS2rx4gfV/dxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hp/GvCMy; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1684c53c-05b6-4098-b80f-d7d3de15b393@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710265604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIl/8fsjmUJ+Og5Be9zzqTrcqB0qVzN1neR02nmTM7g=;
	b=Hp/GvCMyTBwsj+Vl2sUT+N4TWlN6+mDejoQl8jHCvEs3fDvpdRmgIRhbhZE+6iBh50nkn1
	5lFLIEtRaGi8KxL97BKcxAITnty/0+t4Tx9y7cq3EGLH5LrE0wLibNvjPvzGjHiT0Firsl
	m/+TiMp96v79b86qE3u/DhUtxLy8MYg=
Date: Tue, 12 Mar 2024 13:46:40 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240228042124.3074044-2-vishal.sagar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Vishal,

On 2/27/24 23:21, Vishal Sagar wrote:
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
> Link: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fall%2f20220122121407.11467%2d1%2dneel.gandhi%40xilinx.com&umid=a486940f-2fe3-47f4-9b3f-416e59036eab&auth=d807158c60b7d2502abde8a2fc01f40662980862-a75e22540e8429d70f26093b45d38995a0e6e1e8
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b82815e64d24..28d9af8f00f0 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1097,12 +1097,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
>          * Complete the active descriptor, if any, promote the pending
>          * descriptor to active, and queue the next transfer, if any.
>          */
> +       spin_lock(&chan->vchan.lock);
>         if (chan->desc.active)
>                 vchan_cookie_complete(&chan->desc.active->vdesc);
>         chan->desc.active = pending;
>         chan->desc.pending = NULL;
> 
>         xilinx_dpdma_chan_queue_transfer(chan);
> +       spin_unlock(&chan->vchan.lock);
> 
>  out:
>         spin_unlock_irqrestore(&chan->lock, flags);
> @@ -1264,10 +1266,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
>         struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
>         unsigned long flags;
> 
> -       spin_lock_irqsave(&chan->vchan.lock, flags);
> +       spin_lock_irqsave(&chan->lock, flags);
> +       spin_lock(&chan->vchan.lock);
>         if (vchan_issue_pending(&chan->vchan))
>                 xilinx_dpdma_chan_queue_transfer(chan);
> -       spin_unlock_irqrestore(&chan->vchan.lock, flags);
> +       spin_unlock(&chan->vchan.lock);
> +       spin_unlock_irqrestore(&chan->lock, flags);
>  }
> 
>  static int xilinx_dpdma_config(struct dma_chan *dchan,
> @@ -1495,7 +1499,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
>                     XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
> 
>         spin_lock_irqsave(&chan->lock, flags);
> +       spin_lock(&chan->vchan.lock);
>         xilinx_dpdma_chan_queue_transfer(chan);
> +       spin_unlock(&chan->vchan.lock);
>         spin_unlock_irqrestore(&chan->lock, flags);
>  }

I also ran into this issue and came up with the same fix [1].

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

[1] https://lore.kernel.org/dmaengine/20240308210034.3634938-2-sean.anderson@linux.dev/

