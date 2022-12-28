Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEF657589
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiL1LAb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1LA3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:00:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5663821A4;
        Wed, 28 Dec 2022 03:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E782861473;
        Wed, 28 Dec 2022 11:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EDEC433D2;
        Wed, 28 Dec 2022 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225227;
        bh=jzevZx+qSV+yOu13jDzYW67NkOEMTPVP/kbAVMGqs1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpH1Biu/yj7QOaRwsUUK4iDVe2jXmQfOvTlAOCYFim5y912CuM7loWazDakwa4954
         udaZgpZW/zia5pLDUZTxWuCBMeSU/OH+oCUXLsPCM0tlDDfDR7X7CEe/yw4AdIEmhV
         gIae7OfU2MQ/tVWCgKAp4LGhWwgq/zFA3MqKa01kSu750zZScPUAJRF7jQiyvw64xk
         l7NECXRsObO/QN/ZAhOWCtxFvZ2tBcWBLo14YrwAIucPtvLMsJQVVtkEKDzhiyhrgs
         1xVOhxvRMi3rzVtAdbTHyD/yWE2cBkrBXaLsLEEC/VUFHQfeP+qneVIGShd5l73ied
         ZlvCTS+Oh0U6Q==
Date:   Wed, 28 Dec 2022 16:30:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, adrianml@alumnos.upm.es,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, radhey.shyam.pandey@amd.com,
        anirudha.sarangi@amd.com, harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH V2 3/6] dmaengine: xilinx_dma: Pass AXI4-Stream control
 words to dma client
Message-ID: <Y6whxpN7bgjU7ZvL@matsya>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-4-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124102745.2620370-4-sarath.babu.naidu.gaddam@amd.com>
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
> Read DT property to check if AXI DMA is connected to streaming IP
> i.e axiethernet. If connected pass AXI4-Stream control words to
> dma client using metadata_ops dmaengine API.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 37 +++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 8cd4e69dc7b4..f783ba86cb09 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -493,6 +493,7 @@ struct xilinx_dma_config {
>   * @s2mm_chan_id: DMA s2mm channel identifier
>   * @mm2s_chan_id: DMA mm2s channel identifier
>   * @max_buffer_len: Max buffer length
> + * @has_axistream_connected: AXI DMA connected to AXI Stream IP
>   */
>  struct xilinx_dma_device {
>  	void __iomem *regs;
> @@ -511,6 +512,7 @@ struct xilinx_dma_device {
>  	u32 s2mm_chan_id;
>  	u32 mm2s_chan_id;
>  	u32 max_buffer_len;
> +	bool has_axistream_connected;
>  };
>  
>  /* Macros */
> @@ -623,6 +625,29 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
>  	}
>  }
>  
> +/**
> + * xilinx_dma_get_metadata_ptr- Populate metadata pointer and payload length
> + * @tx: async transaction descriptor
> + * @payload_len: metadata payload length
> + * @max_len: metadata max length
> + * Return: The app field pointer.
> + */
> +static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
> +					 size_t *payload_len, size_t *max_len)
> +{
> +	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
> +	struct xilinx_axidma_tx_segment *seg;
> +
> +	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> +	seg = list_first_entry(&desc->segments,
> +			       struct xilinx_axidma_tx_segment, node);
> +	return seg->hw.app;
> +}
> +
> +static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
> +	.get_ptr = xilinx_dma_get_metadata_ptr,
> +};
> +
>  /* -----------------------------------------------------------------------------
>   * Descriptors and segments alloc and free
>   */
> @@ -2219,6 +2244,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
>  		segment->hw.control |= XILINX_DMA_BD_EOP;
>  	}
>  
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;

This is an optional property which is added now, what will happen if you
are on a system with older DT? This wont work there..

> +
>  	return &desc->async_tx;
>  
>  error:
> @@ -3065,6 +3093,11 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> +		xdev->has_axistream_connected =
> +			of_property_read_bool(node, "xlnx,axistream-connected");
> +	}
> +
>  	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
>  		err = of_property_read_u32(node, "xlnx,num-fstores",
>  					   &num_frames);
> @@ -3090,6 +3123,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	else
>  		xdev->ext_addr = false;
>  
> +	/* Set metadata mode */
> +	if (xdev->has_axistream_connected)
> +		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
> +
>  	/* Set the dma mask bits */
>  	err = dma_set_mask_and_coherent(xdev->dev, DMA_BIT_MASK(addr_width));
>  	if (err < 0) {
> -- 
> 2.25.1

-- 
~Vinod
