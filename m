Return-Path: <dmaengine+bounces-1354-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477C87A35A
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 08:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340C92833C6
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412FD15EB0;
	Wed, 13 Mar 2024 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dQ6jdaTG"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EF15EA2;
	Wed, 13 Mar 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314364; cv=none; b=TyxTqLDNAJibTu5rtK5Hu4zQC6e8GKhQr2xaUpv1LBJ7XDovwWEzFbYguQOl2nYKfgr/sCgs13yHDIV/o5mW8ZYd70vpb+GMCqhs5oYMnaFVsNC1YpEkhkJ3HTQvqWy/0b7xER7NckEeFx1A8JGoh4gq9TqMj02imTN8e2uLDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314364; c=relaxed/simple;
	bh=GYwN1DxvV9OB9lJ0HLfmHSRRcrQXaY93Jh/Hv0pXfX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUxudukr4zO7Z8IYXWbVXE8mHjM/nG65QUcM54T/UIIrR8Zu6W2S7JvVHCqpBW61agCmz+4+VCYvDtPmw1bDsWH7NXtVcuq2k/fjVbti/7IYiC2sdedslVK6tEE7xSuXuntRJ3BC7hLNc8wHl0XruO/LcZ2pv+yYTvHFVzQZLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dQ6jdaTG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2FD62720;
	Wed, 13 Mar 2024 08:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710314338;
	bh=GYwN1DxvV9OB9lJ0HLfmHSRRcrQXaY93Jh/Hv0pXfX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dQ6jdaTGjj/IoLkyEXysR7mQ1pmLaPUIi/9yPhzoJh6O17mF8/h0YyJ2qdlfcpf06
	 wM3h1th5NLz92RP/XBsbt68CYtvd4KbnT0ecxpZR/gDp101Aywu3pbpz0cP23NF18w
	 b53aZ6S1amHuprtulw5bZxv6haRPni/anGKlwgJc=
Message-ID: <8439e009-f520-4bf5-8683-50fc82405f93@ideasonboard.com>
Date: Wed, 13 Mar 2024 09:19:17 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dmaengine: xilinx: dpdma: Add support for cyclic
 dma mode
Content-Language: en-US
To: Vishal Sagar <vishal.sagar@amd.com>, laurent.pinchart@ideasonboard.com,
 vkoul@kernel.org
Cc: michal.simek@amd.com, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 varunkumar.allagadapa@amd.com
References: <20240228042124.3074044-1-vishal.sagar@amd.com>
 <20240228042124.3074044-3-vishal.sagar@amd.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240228042124.3074044-3-vishal.sagar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2024 06:21, Vishal Sagar wrote:
> From: Rohit Visavalia <rohit.visavalia@xilinx.com>
> 
> This patch adds support for DPDMA cyclic dma mode,
> DMA cyclic transfers are required by audio streaming.
> 
> Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>
> 
> ---
>   drivers/dma/xilinx/xilinx_dpdma.c | 97 +++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)

This works fine with the DP audio series I posted, so:

Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 28d9af8f00f0..88ad2f35538a 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -669,6 +669,84 @@ static void xilinx_dpdma_chan_free_tx_desc(struct virt_dma_desc *vdesc)
>   	kfree(desc);
>   }
>   
> +/**
> + * xilinx_dpdma_chan_prep_cyclic - Prepare a cyclic dma descriptor
> + * @chan: DPDMA channel
> + * @buf_addr: buffer address
> + * @buf_len: buffer length
> + * @period_len: number of periods
> + * @flags: tx flags argument passed in to prepare function
> + *
> + * Prepare a tx descriptor incudling internal software/hardware descriptors
> + * for the given cyclic transaction.
> + *
> + * Return: A dma async tx descriptor on success, or NULL.
> + */
> +static struct dma_async_tx_descriptor *
> +xilinx_dpdma_chan_prep_cyclic(struct xilinx_dpdma_chan *chan,
> +			      dma_addr_t buf_addr, size_t buf_len,
> +			      size_t period_len, unsigned long flags)
> +{
> +	struct xilinx_dpdma_tx_desc *tx_desc;
> +	struct xilinx_dpdma_sw_desc *sw_desc, *last = NULL;
> +	unsigned int periods = buf_len / period_len;
> +	unsigned int i;
> +
> +	tx_desc = xilinx_dpdma_chan_alloc_tx_desc(chan);
> +	if (!tx_desc)
> +		return (void *)tx_desc;
> +
> +	for (i = 0; i < periods; i++) {
> +		struct xilinx_dpdma_hw_desc *hw_desc;
> +
> +		if (!IS_ALIGNED(buf_addr, XILINX_DPDMA_ALIGN_BYTES)) {
> +			dev_err(chan->xdev->dev,
> +				"buffer should be aligned at %d B\n",
> +				XILINX_DPDMA_ALIGN_BYTES);
> +			goto error;
> +		}
> +
> +		sw_desc = xilinx_dpdma_chan_alloc_sw_desc(chan);
> +		if (!sw_desc)
> +			goto error;
> +
> +		xilinx_dpdma_sw_desc_set_dma_addrs(chan->xdev, sw_desc, last,
> +						   &buf_addr, 1);
> +		hw_desc = &sw_desc->hw;
> +		hw_desc->xfer_size = period_len;
> +		hw_desc->hsize_stride =
> +			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_HSIZE_MASK,
> +				   period_len) |
> +			FIELD_PREP(XILINX_DPDMA_DESC_HSIZE_STRIDE_STRIDE_MASK,
> +				   period_len);
> +		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_PREEMBLE;
> +		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_IGNORE_DONE;
> +		hw_desc->control |= XILINX_DPDMA_DESC_CONTROL_COMPLETE_INTR;
> +
> +		list_add_tail(&sw_desc->node, &tx_desc->descriptors);
> +
> +		buf_addr += period_len;
> +		last = sw_desc;
> +	}
> +
> +	sw_desc = list_first_entry(&tx_desc->descriptors,
> +				   struct xilinx_dpdma_sw_desc, node);
> +	last->hw.next_desc = lower_32_bits(sw_desc->dma_addr);
> +	if (chan->xdev->ext_addr)
> +		last->hw.addr_ext |=
> +			FIELD_PREP(XILINX_DPDMA_DESC_ADDR_EXT_NEXT_ADDR_MASK,
> +				   upper_32_bits(sw_desc->dma_addr));
> +
> +	last->hw.control |= XILINX_DPDMA_DESC_CONTROL_LAST_OF_FRAME;
> +
> +	return vchan_tx_prep(&chan->vchan, &tx_desc->vdesc, flags);
> +
> +error:
> +	xilinx_dpdma_chan_free_tx_desc(&tx_desc->vdesc);
> +
> +	return NULL;
> +}
> +
>   /**
>    * xilinx_dpdma_chan_prep_interleaved_dma - Prepare an interleaved dma
>    *					    descriptor
> @@ -1190,6 +1268,23 @@ static void xilinx_dpdma_chan_handle_err(struct xilinx_dpdma_chan *chan)
>   /* -----------------------------------------------------------------------------
>    * DMA Engine Operations
>    */
> +static struct dma_async_tx_descriptor *
> +xilinx_dpdma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
> +			     size_t buf_len, size_t period_len,
> +			     enum dma_transfer_direction direction,
> +			     unsigned long flags)
> +{
> +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> +
> +	if (direction != DMA_MEM_TO_DEV)
> +		return NULL;
> +
> +	if (buf_len % period_len)
> +		return NULL;
> +
> +	return xilinx_dpdma_chan_prep_cyclic(chan, buf_addr, buf_len,
> +						 period_len, flags);
> +}
>   
>   static struct dma_async_tx_descriptor *
>   xilinx_dpdma_prep_interleaved_dma(struct dma_chan *dchan,
> @@ -1673,6 +1768,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>   
>   	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
>   	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
>   	dma_cap_set(DMA_INTERLEAVE, ddev->cap_mask);
>   	dma_cap_set(DMA_REPEAT, ddev->cap_mask);
>   	dma_cap_set(DMA_LOAD_EOT, ddev->cap_mask);
> @@ -1680,6 +1776,7 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>   
>   	ddev->device_alloc_chan_resources = xilinx_dpdma_alloc_chan_resources;
>   	ddev->device_free_chan_resources = xilinx_dpdma_free_chan_resources;
> +	ddev->device_prep_dma_cyclic = xilinx_dpdma_prep_dma_cyclic;
>   	ddev->device_prep_interleaved_dma = xilinx_dpdma_prep_interleaved_dma;
>   	/* TODO: Can we achieve better granularity ? */
>   	ddev->device_tx_status = dma_cookie_status;


