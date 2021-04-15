Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22973360372
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhDOHdo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 03:33:44 -0400
Received: from www381.your-server.de ([78.46.137.84]:37058 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHdo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Apr 2021 03:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=uxomR1aNpf7hkRODFDvGe9w7xQUUXiatU5dinFJRbWU=; b=AoiZTr2JLATQNjpwN2q0qW7IjY
        ZWXdeEOKzVxIx7phjcRa6u0Jm1V6dqufsP4wv/aQ5AGYz+lAUUF7DNotppovjj4FQTn62WnQanU0E
        cSWciOm+8V9G9fK17BWKthF8vHd1EjxLsab7SrnzxwIFSh6nZxgWYKOahc5dszt20r0WfaVmwT3F/
        3tihluX370AIqvZ6FghBrYJ/w5TUoW+JIKrtNLzxs84QX5yZ3oPemqLS2RUCdxLrv3VnYjQZgI0SZ
        RIgzHXZrYHF3/OiI4vLHMlBDRekvABBieXvNjcTD6IMPEvE9pZd5ZdLfnaPpYdvHEAguQ5RQO53rH
        /6ywKe8w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lWwV4-0001Z8-FC; Thu, 15 Apr 2021 09:33:18 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lWwV4-000APh-9Y; Thu, 15 Apr 2021 09:33:18 +0200
Subject: Re: [RFC v2 PATCH 7/7] dmaengine: xilinx_dma: Program interrupt delay
 timeout
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        vkoul@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-8-git-send-email-radhey.shyam.pandey@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2985f8ac-ae2c-c142-f2d6-c5051bd6bfb2@metafoo.de>
Date:   Thu, 15 Apr 2021 09:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617990965-35337-8-git-send-email-radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26140/Wed Apr 14 13:10:01 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/9/21 7:56 PM, Radhey Shyam Pandey wrote:
> Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
> the DMA engine to generate an interrupt after the delay time period
> has expired. It enables dmaengine to respond in real-time even though
> interrupt coalescing is configured. It also remove the placeholder
> for delay interrupt and merge it with frame completion interrupt.
> Since by default interrupt delay timeout is disabled this feature
> addition has no functional impact on VDMA and CDMA IP's.

In my opinion this should not come from the devicetree. This setting is 
application specific and should be configured through a runtime API.

For the VDMA there is already xilinx_vdma_channel_set_config() which 
allows to configure the maximum number of IRQs that can be coalesced and 
the IRQ delay. Something similar is probably needed for the AXIDMA.

>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes for v2:
> - Read irq delay timeout value from DT.
> - Merge interrupt processing for frame done and delay interrupt.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a2ea2d649332..0c0dc9882a01 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -173,8 +173,10 @@
>   #define XILINX_DMA_MAX_TRANS_LEN_MAX	23
>   #define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
>   #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
> +#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
>   #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
>   #define XILINX_DMA_CR_COALESCE_SHIFT	16
> +#define XILINX_DMA_CR_DELAY_SHIFT	24
>   #define XILINX_DMA_BD_SOP		BIT(27)
>   #define XILINX_DMA_BD_EOP		BIT(26)
>   #define XILINX_DMA_BD_COMP_MASK		BIT(31)
> @@ -410,6 +412,7 @@ struct xilinx_dma_tx_descriptor {
>    * @stop_transfer: Differentiate b/w DMA IP's quiesce
>    * @tdest: TDEST value for mcdma
>    * @has_vflip: S2MM vertical flip
> + * @irq_delay: Interrupt delay timeout
>    */
>   struct xilinx_dma_chan {
>   	struct xilinx_dma_device *xdev;
> @@ -447,6 +450,7 @@ struct xilinx_dma_chan {
>   	int (*stop_transfer)(struct xilinx_dma_chan *chan);
>   	u16 tdest;
>   	bool has_vflip;
> +	u8 irq_delay;
>   };
>   
>   /**
> @@ -1555,6 +1559,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>   	if (chan->has_sg)
>   		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>   			     head_desc->async_tx.phys);
> +	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> +	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
> +	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>   
>   	xilinx_dma_start(chan);
>   
> @@ -1877,15 +1884,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>   		}
>   	}
>   
> -	if (status & XILINX_DMA_DMASR_DLY_CNT_IRQ) {
> -		/*
> -		 * Device takes too long to do the transfer when user requires
> -		 * responsiveness.
> -		 */
> -		dev_dbg(chan->dev, "Inter-packet latency too long\n");
> -	}
> -
> -	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
> +	if (status & (XILINX_DMA_DMASR_FRM_CNT_IRQ |
> +		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
>   		spin_lock(&chan->lock);
>   		xilinx_dma_complete_descriptor(chan);
>   		chan->idle = true;
> @@ -2802,6 +2802,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>   	/* Retrieve the channel properties from the device tree */
>   	has_dre = of_property_read_bool(node, "xlnx,include-dre");
>   
> +	of_property_read_u8(node, "xlnx,irq-delay", &chan->irq_delay);
> +
>   	chan->genlock = of_property_read_bool(node, "xlnx,genlock-mode");
>   
>   	err = of_property_read_u32(node, "xlnx,datawidth", &value);


