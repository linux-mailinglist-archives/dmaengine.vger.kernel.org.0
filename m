Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD253602F4
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhDOHJ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 03:09:26 -0400
Received: from www381.your-server.de ([78.46.137.84]:55908 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhDOHJZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Apr 2021 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+9H0bKAnx9cQBA5s/McJpnyim7Uc9dhnMfPi4vnqmPU=; b=l0V5ycDFi5UbrKewqM19dWjL2O
        ziJwTXrgX5kzscFQQA8QVkqt9aHftnCMCt8yhQtfhH2UhtT1SN4TJx4rvfztSmmxeJx22PO6a+rza
        M5o448qorKXcOWHN9OWi7Tk8tWW26kHIxpCH8G786Y3IlwNqy+SvTJiZJ4KgqEGIYGlU7PjrNInkh
        VihdhX1qsB4AbHDo2gCVN1P5DU5Y9NxTy/VfiKleyvRTuSNd2YKa2w1zECYZ1dZqbxoOREJ1Agt59
        xGaFQL+0n/vjtdxzEqtptokKo3KjV2gUo8iv1hxNlRRov0b7v+/PN8z8OS6jRTN7XM840LcfvoGmj
        26wimmJQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lWw7X-000D8T-RI; Thu, 15 Apr 2021 09:08:59 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lWw7X-0001ko-KI; Thu, 15 Apr 2021 09:08:59 +0200
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
Message-ID: <ec177886-fc14-b52e-4c98-da523fa711d9@metafoo.de>
Date:   Thu, 15 Apr 2021 09:08:59 +0200
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
This needs to be fixed before this can be merged as it right now will 
break the non AXIDMA variants.
> +		if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
> +			break;
>   		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
>   		    XDMA_TYPE_VDMA)
>   			desc->residue = xilinx_dma_get_residue(chan, desc);


