Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781126DFCC8
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLRd1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDLRdZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA340FB;
        Wed, 12 Apr 2023 10:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D50460F35;
        Wed, 12 Apr 2023 17:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C3DC433D2;
        Wed, 12 Apr 2023 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320786;
        bh=lKsHeifIk0MMoix2MaCJURu/5rLXpLLzEOTegL6Fd10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ouoza3hWnGAYOaaiBW5fQlX5v2jsyu/gpNcUyw/SytcgkuVi6QvTRTzb9Pk43EQU2
         dMThLb/MDuiLi6P7G+wWsF6eODq6dckcBxzRUh4dp6T6KpHR2aXb5BxERNBfy3ZB3Y
         YhE9Qe/KPCKKBtqX/4jqmg5U7cnZu7wLeigN8MgT5tJ//kVensYxGqtYcXV/XMraue
         RpRZy2OGQRrI1hGkqAfpks8XjUgC1YtzypxUyml6TAe6zbVwxqltJ6lwzP4fPpsu8K
         pQ11R4696HT17grw+2HRAR7bai7FR7y9uTgxWLNGYEU1J46XCRUwC/XOpB+Qgc4je9
         YOCMxm0cUh0SA==
Date:   Wed, 12 Apr 2023 23:03:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dmaengine: dw-axi-dmac: fix reading register hen
 runtime suspended
Message-ID: <ZDbrTvfPdnvW4Gue@matsya>
References: <20230313170450.897-1-jszhang@kernel.org>
 <20230313170450.897-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313170450.897-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/hen/when..? or something else

On 14-03-23, 01:04, Jisheng Zhang wrote:
> We should runtime resume the device before calling
> axi_chan_is_hw_enable().

why is that can you please explain..

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 7f3a60e28e38..23a10dbdecb7 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -462,13 +462,17 @@ static void dw_axi_dma_synchronize(struct dma_chan *dchan)
>  
>  static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
>  {
> +	int ret;
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  
> +	pm_runtime_get(chan->chip->dev);
> +
>  	/* ASSERT: channel is idle */
>  	if (axi_chan_is_hw_enable(chan)) {
>  		dev_err(chan2dev(chan), "%s is non-idle!\n",
>  			axi_chan_name(chan));
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto err_busy;
>  	}
>  
>  	/* LLI address must be aligned to a 64-byte boundary */
> @@ -478,13 +482,16 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
>  					  64, 0);
>  	if (!chan->desc_pool) {
>  		dev_err(chan2dev(chan), "No memory for descriptors\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_busy;
>  	}
>  	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
>  
> -	pm_runtime_get(chan->chip->dev);
> -
>  	return 0;
> +
> +err_busy:
> +	pm_runtime_put(chan->chip->dev);
> +	return ret;
>  }
>  
>  static void dma_chan_free_chan_resources(struct dma_chan *dchan)
> -- 
> 2.39.2

-- 
~Vinod
