Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9F65758C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiL1LBI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiL1LAy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:00:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF48EB1;
        Wed, 28 Dec 2022 03:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B8AAB8120C;
        Wed, 28 Dec 2022 11:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67951C433D2;
        Wed, 28 Dec 2022 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225249;
        bh=Q/zd1RS/MKwAIMZo6szCGlvWyEUH6//dSmNHq1F4y1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzXgvu56dgzH08op7IJjLyMG99KZYy5mqF0nDDfU8IFfOmxoQ2NeYRENe1TqihUA1
         gM7GxYQCxOIiy0s85AYu5nbafBPw7wmGePXMK0pD8tmp4Esmt3TNFqptAip+ZvAj7i
         0I3BgZp/CY9tLNoF2Cf1XhTZKUTZco+IzXt6tP8CfrzB+xAijtx8KoANCSThMvOIOc
         Fgje4TFEerbRj3WgD3ylD4IB/+MHmxj0uRs/PT+sb/lb025oM7MYgCEfJ6x0wmgQGz
         TuhHWw3pddF+pU3tfULJuZSOiAuiXGgsB8u5jMvwqvyNw5NPiIylCBtRDrNkRdfZYc
         ayTBf8RRZhhXg==
Date:   Wed, 28 Dec 2022 16:30:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, adrianml@alumnos.upm.es,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, radhey.shyam.pandey@amd.com,
        anirudha.sarangi@amd.com, harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH V2 6/6] dmaengine: xilinx_dma: Program interrupt delay
 timeout
Message-ID: <Y6wh3W0S/pzTI4vL@matsya>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-7-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124102745.2620370-7-sarath.babu.naidu.gaddam@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-11-22, 15:57, Sarath Babu Naidu Gaddam wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> Program IRQDelay for AXI DMA. The interrupt timeout mechanism causes
> the DMA engine to generate an interrupt after the delay time period
> has expired. It enables dmaengine to respond in real-time even though
> interrupt coalescing is configured. It also remove the placeholder
> for delay interrupt and merge it with frame completion interrupt.
> Since by default interrupt delay timeout is disabled this feature
> addition has no functional impact on VDMA and CDMA IP's.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index ce0c151d8f61..333d68ee3559 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -173,8 +173,10 @@
>  #define XILINX_DMA_MAX_TRANS_LEN_MAX	23
>  #define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
>  #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
> +#define XILINX_DMA_CR_DELAY_MAX		GENMASK(31, 24)
>  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
>  #define XILINX_DMA_CR_COALESCE_SHIFT	16
> +#define XILINX_DMA_CR_DELAY_SHIFT	24
>  #define XILINX_DMA_BD_SOP		BIT(27)
>  #define XILINX_DMA_BD_EOP		BIT(26)
>  #define XILINX_DMA_COALESCE_MAX		255
> @@ -410,6 +412,7 @@ struct xilinx_dma_tx_descriptor {
>   * @stop_transfer: Differentiate b/w DMA IP's quiesce
>   * @tdest: TDEST value for mcdma
>   * @has_vflip: S2MM vertical flip
> + * @irq_delay: Interrupt delay timeout
>   */
>  struct xilinx_dma_chan {
>  	struct xilinx_dma_device *xdev;
> @@ -448,6 +451,7 @@ struct xilinx_dma_chan {
>  	int (*stop_transfer)(struct xilinx_dma_chan *chan);
>  	u16 tdest;
>  	bool has_vflip;
> +	u8 irq_delay;
>  };
>  
>  /**
> @@ -1560,6 +1564,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (chan->has_sg)
>  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>  			     head_desc->async_tx.phys);
> +	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
> +	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
> +	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>  
>  	xilinx_dma_start(chan);
>  
> @@ -1887,15 +1894,8 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
>  		}
>  	}
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
>  		spin_lock(&chan->lock);
>  		xilinx_dma_complete_descriptor(chan);
>  		chan->idle = true;
> @@ -2822,6 +2822,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  	/* Retrieve the channel properties from the device tree */
>  	has_dre = of_property_read_bool(node, "xlnx,include-dre");
>  
> +	of_property_read_u8(node, "xlnx,irq-delay", &chan->irq_delay);

Same question here too

> +
>  	chan->genlock = of_property_read_bool(node, "xlnx,genlock-mode");
>  
>  	err = of_property_read_u32(node, "xlnx,datawidth", &value);
> -- 
> 2.25.1

-- 
~Vinod
