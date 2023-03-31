Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5546D2052
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCaMcH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCaMcC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768461FD11;
        Fri, 31 Mar 2023 05:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2F162879;
        Fri, 31 Mar 2023 12:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51BBC433EF;
        Fri, 31 Mar 2023 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265920;
        bh=xDeV8f0TEKOX3TAt7OH5XdT/qpqhkv0mAzx7oLIiWoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRoO/xRgSK1KGiLiZHjm6Sz6KEqFcOqHdPZnGQUqyxE0viO6/LTofzx6Q4FeHC10m
         /R8/D0nHa4USOV7jLQAGcsC+QU3n504aJMP1IOu74FOqkj1fr8P9krdr1YEpK2rBdG
         IOXstEG/TU/uv5vaNAIOkYovcGDAHWKhbTa+DBIuM+5P9aqolm93RWfWWPgTu2yP6+
         GMPuSgeC6T9CAvRsuhDhahK+7AJLrBVxYiLa2G1BC7R1KVdw6JAZdbWW9odpuU6y24
         gogUtsxuePehASUMjJPI1XUi/7XAweLEUObm8YxQR4DbtPSRunaZ3bxYKwpNn0Oojh
         6YHi/JRV+pCNg==
Date:   Fri, 31 Mar 2023 18:01:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bestcomm: Use of_address_to_resource()
Message-ID: <ZCbSvGkz5hqA2sWT@matsya>
References: <20230319163222.226377-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319163222.226377-1-robh@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-03-23, 11:32, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().

Applied, thanks

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/dma/bestcomm/sram.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/bestcomm/sram.c b/drivers/dma/bestcomm/sram.c
> index c465758e7193..103174cbda65 100644
> --- a/drivers/dma/bestcomm/sram.c
> +++ b/drivers/dma/bestcomm/sram.c
> @@ -38,7 +38,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
>  {
>  	int rv;
>  	const u32 *regaddr_p;
> -	u64 regaddr64, size64;
> +	struct resource res;
>  	unsigned int psize;
>  
>  	/* Create our state struct */
> @@ -56,21 +56,18 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
>  	}
>  
>  	/* Get address and size of the sram */
> -	regaddr_p = of_get_address(sram_node, 0, &size64, NULL);
> -	if (!regaddr_p) {
> +	rv = of_address_to_resource(sram_node, 0, &res);
> +	if (rv) {
>  		printk(KERN_ERR "%s: bcom_sram_init: "
>  			"Invalid device node !\n", owner);
> -		rv = -EINVAL;
>  		goto error_free;
>  	}
>  
> -	regaddr64 = of_translate_address(sram_node, regaddr_p);
> -
> -	bcom_sram->base_phys = (phys_addr_t) regaddr64;
> -	bcom_sram->size = (unsigned int) size64;
> +	bcom_sram->base_phys = res.start;
> +	bcom_sram->size = resource_size(&res);
>  
>  	/* Request region */
> -	if (!request_mem_region(bcom_sram->base_phys, bcom_sram->size, owner)) {
> +	if (!request_mem_region(res.start, resource_size(&res), owner)) {
>  		printk(KERN_ERR "%s: bcom_sram_init: "
>  			"Couldn't request region !\n", owner);
>  		rv = -EBUSY;
> @@ -79,7 +76,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
>  
>  	/* Map SRAM */
>  		/* sram is not really __iomem */
> -	bcom_sram->base_virt = (void*) ioremap(bcom_sram->base_phys, bcom_sram->size);
> +	bcom_sram->base_virt = (void*) ioremap(res.start, resource_size(&res));
>  
>  	if (!bcom_sram->base_virt) {
>  		printk(KERN_ERR "%s: bcom_sram_init: "
> @@ -120,7 +117,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
>  	return 0;
>  
>  error_release:
> -	release_mem_region(bcom_sram->base_phys, bcom_sram->size);
> +	release_mem_region(res.start, resource_size(&res));
>  error_free:
>  	kfree(bcom_sram);
>  	bcom_sram = NULL;
> -- 
> 2.39.2

-- 
~Vinod
