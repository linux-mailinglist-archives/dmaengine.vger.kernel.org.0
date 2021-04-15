Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270B6360344
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 09:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhDOH01 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 03:26:27 -0400
Received: from www381.your-server.de ([78.46.137.84]:55060 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhDOH01 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Apr 2021 03:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=JDpzUHPwvJUi4l7pHZlnxekRvLlaoqjBNmTiyVlpWkU=; b=T8HYkGXTK925qjbkiDCDS/FcBw
        ccgFCWB2iko70Vm/VaSx2kuxvekw1YFMp/mHDjEZbsyZctyDgLdvv9o7OMTFijiaemifQdA1bQklj
        QqC8tp/EcRF3yD/amyHtBwEAG3pKmIghYz4AN2d71zrRG1V9AfbDa+RT3TVobDqxV2pY1saMLcxWg
        PuuuzxDVKGGXYj14z3YPTZv1qh1KBw69riuj8WSQ12CUYeJST0w0sMfgyBVpuKE328PnvqrkXrszx
        3sObY37GisyjgDxSdWsAJC+MbV6usLto1pQZ3lEEMMxcWg38+DaXOeM29bk8Yd9qei+Tbwb13B2X6
        N3+GczJA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lWwO1-00005F-Ke; Thu, 15 Apr 2021 09:26:01 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lWwO1-000AOI-FK; Thu, 15 Apr 2021 09:26:01 +0200
Subject: Re: [RFC v2 PATCH 5/7] dmaengine: xilinx_dma: Freeup active list
 based on descriptor completion bit
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        vkoul@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-6-git-send-email-radhey.shyam.pandey@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <94a2a053-46b6-77be-7c1f-3ece3a0f9af3@metafoo.de>
Date:   Thu, 15 Apr 2021 09:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617990965-35337-6-git-send-email-radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26140/Wed Apr 14 13:10:01 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/9/21 7:56 PM, Radhey Shyam Pandey wrote:
> AXIDMA IP in SG mode sets completion bit to 1 when the transfer is
> completed. Read this bit to move descriptor from active list to the
> done list. This feature is needed when interrupt delay timeout and
> IRQThreshold is enabled i.e Dly_IrqEn is triggered w/o completing
> interrupt threshold.
>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> - Check BD completion bit only for SG mode.
> - Modify the logic to have early return path.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 890bf46b36e5..f2305a73cb91 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -177,6 +177,7 @@
>   #define XILINX_DMA_CR_COALESCE_SHIFT	16
>   #define XILINX_DMA_BD_SOP		BIT(27)
>   #define XILINX_DMA_BD_EOP		BIT(26)
> +#define XILINX_DMA_BD_COMP_MASK		BIT(31)
>   #define XILINX_DMA_COALESCE_MAX		255
>   #define XILINX_DMA_NUM_DESCS		512
>   #define XILINX_DMA_NUM_APP_WORDS	5
> @@ -1683,12 +1684,18 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
>   static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
>   {
>   	struct xilinx_dma_tx_descriptor *desc, *next;
> +	struct xilinx_axidma_tx_segment *seg;
>   
>   	/* This function was invoked with lock held */
>   	if (list_empty(&chan->active_list))
>   		return;
>   
>   	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> +		/* TODO: remove hardcoding for axidma_tx_segment */
> +		seg = list_last_entry(&desc->segments,
> +				      struct xilinx_axidma_tx_segment, node);
> +		if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
> +			break;
>   		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
>   		    XDMA_TYPE_VDMA)
>   			desc->residue = xilinx_dma_get_residue(chan, desc);

Since not all descriptors will be completed in this function the 
`chan->idle = true;` in xilinx_dma_irq_handler() needs to be gated on 
the active_list being empty.

xilinx_dma_complete_descriptor

