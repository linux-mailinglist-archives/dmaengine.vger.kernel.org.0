Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEF5632E7
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 13:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiGALvG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGALvE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 07:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4267B357;
        Fri,  1 Jul 2022 04:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A6BB6256A;
        Fri,  1 Jul 2022 11:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F6C3411E;
        Fri,  1 Jul 2022 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656676262;
        bh=4eMF5Lv45+x+6vXGYFITbqtwdsOKmSrLzeWgO58065k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUKFi9fe5DBtdRq6Qb4O6OaF7+MWx3eUynAU8vnQ7Ql6FITsDA7gczurAbCqtvrUI
         OwYq36ofXp8c1g8RNh7Py4ZMN2DoW0fK50k6/0oLXmHDAcoBOtdzN7MNBqigkpLayc
         X/Le+IzAJLRQribUxp13THCe5hEL7G25gKPsxQr4RjPITx7LSDqwAgDe7xZCRnyqXU
         d7hCzWZC5k0sgE4U2qKxxpzOBDWhN59yqwK5839UzBNdZmOWvF+/5GjuJyUpFdL/Mn
         bzZBxWvfh8OYWZS2I7G7yQco4DJaDebZj5uKJzsfiecBk/dqEP/VASok8/rE2nuN3a
         DimAYn8nKxg1A==
Date:   Fri, 1 Jul 2022 17:20:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swati Agarwal <swati.agarwal@xilinx.com>
Cc:     lars@metafoo.de, adrianml@alumnos.upm.es, libaokun1@huawei.com,
        marex@denx.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harini.katakam@xilinx.com, radhey.shyam.pandey@xilinx.com,
        michal.simek@xilinx.com
Subject: Re: [PATCH 1/2] dmaengine: xilinx_dma: Fix probe error cleanup
Message-ID: <Yr7fou17VkqOYV0V@matsya>
References: <20220624063539.18657-1-swati.agarwal@xilinx.com>
 <20220624063539.18657-2-swati.agarwal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624063539.18657-2-swati.agarwal@xilinx.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-22, 12:05, Swati Agarwal wrote:
> When probe fails remove dma channel resources and disable clocks in
> accordance with the order of resources allocated .

Ok this looks fine and the changes below..
> 
> Add missing cleanup in devm_platform_ioremap_resource(), xlnx,num-fstores
> property.

Where is this part?

> 
> Signed-off-by: Swati Agarwal <swati.agarwal@xilinx.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index cd62bbb50e8b..fbf341e8c36f 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -3160,8 +3160,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  
>  	/* Request and map I/O memory */
>  	xdev->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(xdev->regs))
> -		return PTR_ERR(xdev->regs);
> +	if (IS_ERR(xdev->regs)) {
> +		err = PTR_ERR(xdev->regs);
> +		goto disable_clks;
> +	}
>  
>  	/* Retrieve the DMA engine properties from the device tree */
>  	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
> @@ -3190,7 +3192,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  		if (err < 0) {
>  			dev_err(xdev->dev,
>  				"missing xlnx,num-fstores property\n");
> -			return err;
> +			goto disable_clks;
>  		}
>  
>  		err = of_property_read_u32(node, "xlnx,flush-fsync",
> @@ -3259,7 +3261,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	for_each_child_of_node(node, child) {
>  		err = xilinx_dma_child_probe(xdev, child);
>  		if (err < 0)
> -			goto disable_clks;
> +			goto error;
>  	}
>  
>  	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
> @@ -3294,12 +3296,12 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -disable_clks:
> -	xdma_disable_allclks(xdev);
>  error:
>  	for (i = 0; i < xdev->dma_config->max_channels; i++)
>  		if (xdev->chan[i])
>  			xilinx_dma_chan_remove(xdev->chan[i]);
> +disable_clks:
> +	xdma_disable_allclks(xdev);
>  
>  	return err;
>  }
> -- 
> 2.17.1

-- 
~Vinod
