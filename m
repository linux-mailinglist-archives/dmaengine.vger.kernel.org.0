Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81170604D71
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJSQbR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJSQbQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A943127BE8;
        Wed, 19 Oct 2022 09:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A1861940;
        Wed, 19 Oct 2022 16:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965E3C433D6;
        Wed, 19 Oct 2022 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666197074;
        bh=RKLFk6GGzypOwZ0Xth2rQW+zmvLO6gk5B04J6dQE6pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLU1KwyaVZ9CFyzpnEedpUa7sxn/IPOqL5Ifs3mwZUtSVR1/Mv+c3oPO8K4UW3EC9
         ktdGDvXJcHB/l5jBkvyxgNIMQq4u1BV84WeNb+h6kSjqGRVmw0dw1z72Pv14WkTn2S
         lPt/ybsNvsm5Ho0Fg0QJhPi61Fj1xw0buzGtsckVZfTjxSeQbnboKVHzqz2gTDXVPX
         aIJosgpJN9EQZZeC+x/fX0WwBtjNbbEMI9wSWKxTAX5kWDkzzo4y1V1RykQ9wano/T
         mRFMX/Qa7Ma05AjmjDMVuOlwFZuPfUiaJzd2cVQsMs5yiifwYuXz9zdOHqZVjDG5KI
         UKFOMAQn+/IuQ==
Date:   Wed, 19 Oct 2022 22:01:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] dmaengine: Add dmaengine_async_is_tx_complete
Message-ID: <Y1AmTaT4oFDAWLLm@matsya>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-4-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829203537.30676-4-benjamin.walker@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-08-22, 13:35, Ben Walker wrote:
> This is the replacement for dma_async_is_tx_complete with two changes:
> 1) The name prefix is 'dmaengine' as per convention
> 2) It no longer reports the 'last' or 'used' cookie

Thanks for this cleanup. This is good :)

But, why should we retain async is API here. I think lets cleanup
properly and rename it dmaengine_is_tx_complete()

we _really_ need to drop async and have everything dmaengine_*

> 
> Drivers should convert to using dmaengine_async_is_tx_complete.
> 
> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> ---
>  Documentation/driver-api/dmaengine/client.rst | 19 ++++---------------
>  .../driver-api/dmaengine/provider.rst         |  6 +++---
>  drivers/dma/dmaengine.c                       |  2 +-
>  drivers/dma/dmatest.c                         |  3 +--
>  include/linux/dmaengine.h                     | 16 ++++++++++++++++
>  5 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index 85ecec2c40005..9ae489a4ca97f 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -259,8 +259,8 @@ The details of these operations are:
>  
>        dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
>  
> -   This returns a cookie can be used to check the progress of DMA engine
> -   activity via other DMA engine calls not covered in this document.
> +   This returns a cookie that can be used to check the progress of a transaction
> +   via dmaengine_async_is_tx_complete().
>  
>     dmaengine_submit() will not start the DMA operation, it merely adds
>     it to the pending queue. For this, see step 5, dma_async_issue_pending.
> @@ -339,23 +339,12 @@ Further APIs
>  
>     .. code-block:: c
>  
> -      enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
> -		dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
> -
> -   This can be used to check the status of the channel. Please see
> -   the documentation in include/linux/dmaengine.h for a more complete
> -   description of this API.
> +      enum dma_status dmaengine_async_is_tx_complete(struct dma_chan *chan,
> +		dma_cookie_t cookie)
>  
>     This can be used with the cookie returned from dmaengine_submit()
>     to check for completion of a specific DMA transaction.
>  
> -   .. note::
> -
> -      Not all DMA engine drivers can return reliable information for
> -      a running DMA channel. It is recommended that DMA engine users
> -      pause or stop (via dmaengine_terminate_all()) the channel before
> -      using this API.
> -
>  5. Synchronize termination API
>  
>     .. code-block:: c
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index ceac2a300e328..1d0da2777921d 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -539,10 +539,10 @@ where to put them)
>  
>  dma_cookie_t
>  
> -- it's a DMA transaction ID that will increment over time.
> +- it's a DMA transaction ID.
>  
> -- Not really relevant any more since the introduction of ``virt-dma``
> -  that abstracts it away.
> +- The value can be chosen by the provider, or use the helper APIs
> +  such as dma_cookie_assign() and dma_cookie_complete().
>  
>  DMA_CTRL_ACK
>  
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c741b6431958c..2816b8f492dab 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -523,7 +523,7 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
>  
>  	dma_async_issue_pending(chan);
>  	do {
> -		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
> +		status = dmaengine_async_is_tx_complete(chan, cookie);
>  		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
>  			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
>  			return DMA_ERROR;
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 9fe2ae7943169..dde7b9b626336 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -831,8 +831,7 @@ static int dmatest_func(void *data)
>  					done->done,
>  					msecs_to_jiffies(params->timeout));
>  
> -			status = dma_async_is_tx_complete(chan, cookie, NULL,
> -							  NULL);
> +			status = dmaengine_async_is_tx_complete(chan, cookie);
>  		}
>  
>  		if (!done->done) {
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 5ae881729b620..0ee21887b3924 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1426,6 +1426,8 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
>   * @last: returns last completed cookie, can be NULL
>   * @used: returns last issued cookie, can be NULL
>   *
> + * Note: This is deprecated. Use dmaengine_async_is_tx_complete instead.
> + *
>   * If @last and @used are passed in, upon return they reflect the most
>   * recently submitted (used) cookie and the most recently completed
>   * cookie.
> @@ -1444,6 +1446,20 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
>  	return status;
>  }
>  
> +/**
> + * dmaengine_async_is_tx_complete - poll for transaction completion
> + * @chan: DMA channel
> + * @cookie: transaction identifier to check status of
> + *
> + */
> +static inline enum dma_status dmaengine_async_is_tx_complete(struct dma_chan *chan,
> +	dma_cookie_t cookie)
> +{
> +	struct dma_tx_state state;
> +
> +	return chan->device->device_tx_status(chan, cookie, &state);
> +}
> +
>  #ifdef CONFIG_DMA_ENGINE
>  struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
>  enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
> -- 
> 2.37.1

-- 
~Vinod
