Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2B4B6B77
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 12:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiBOLsB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 06:48:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiBOLsA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 06:48:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01D6F48D
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 03:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A03BC61591
        for <dmaengine@vger.kernel.org>; Tue, 15 Feb 2022 11:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2638BC340EB;
        Tue, 15 Feb 2022 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644925670;
        bh=wbWy8trJ1U7Sd68EmR4yiCyDXpLdjeOqj5teEzXZpk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miELMk7/n+hsmSoE26HDAOcOZlw3Q9LriswBU/G3njZc+70SYZE4XxlcXrHDuuqf4
         9YAW3BvHe3ZiOHI5MS6sMLZzkb+8A38qRKue1fwJ0aHBHYPzHxbW3PodzI4mW1M4a/
         mo0+EV5ExZc5ORIRtMDPZut/qhGgcUcTN1qco1hxi+uJyJRmsxaY477uOO9hX1Bk+u
         TmPqPXKQCrXeTAPGbOlKVsh+bdylew5S7LcZJKVivOTzcj/v9Wof3p3P0Pi+gYjbi4
         arT3fFVu4luI9+sJwRDAYGyvJuA5GauKqXRsK860yjU/3gL+WrYEW0R2GZat0aExZI
         gaYijgGtfpVWw==
Date:   Tue, 15 Feb 2022 17:17:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH 2/4] dmaengine: at_hdmac: In atc_prep_dma_memset,
 treat value as a single byte
Message-ID: <YguS4m1dRci/nBmz@matsya>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
 <20220128183948.3924558-3-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128183948.3924558-3-benjamin.walker@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-01-22, 11:39, Ben Walker wrote:
> The value passed in to .prep_dma_memset is to be treated as a single
> byte repeating pattern.
> 
> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/dma/at_hdmac.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 30ae36124b1db..6defca514a614 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -942,6 +942,7 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
>  	struct at_desc		*desc;
>  	void __iomem		*vaddr;
>  	dma_addr_t		paddr;
> +	unsigned char		fill_pattern;
>  
>  	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
>  		&dest, value, len, flags);
> @@ -963,7 +964,14 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
>  			__func__);
>  		return NULL;
>  	}
> -	*(u32*)vaddr = value;
> +
> +	/* Only the first byte of value is to be used according to dmaengine */
> +	fill_pattern = (unsigned char)value;

why cast as unsigned?

> +
> +	*(u32*)vaddr = (fill_pattern << 24) |
> +		       (fill_pattern << 16) |
> +		       (fill_pattern << 8) |
> +		       fill_pattern;
>  
>  	desc = atc_create_memset_desc(chan, paddr, dest, len);
>  	if (!desc) {
> -- 
> 2.33.1

-- 
~Vinod
