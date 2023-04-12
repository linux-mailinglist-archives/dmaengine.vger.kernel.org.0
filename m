Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6968A6DFC9D
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjDLRXc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLRXb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BB01726;
        Wed, 12 Apr 2023 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 838CD631A2;
        Wed, 12 Apr 2023 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687D7C433EF;
        Wed, 12 Apr 2023 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320209;
        bh=wMn7qeUFacSworH32ghtZecf85ca3gEEa1FOPqctaOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtCKNUkJ1fWxyC3Ue+qYiqPBVuXsOtAJBrv6CAyb19WO6wRiD55elkG5mecRp41Lm
         GS1sFGz9igYMfsGC1Vd0zivXoEqjILDQPp2i9fyrKd+KmZIe4T9lVKtuS2nPo7+Ys+
         0/ZPgDNtiQcUb/ONHlQ24q1iT2BJ4t3zTZaQzPwpcL7t+BLt9hNGGXimubXbPU9+pc
         pgAl1ZOEphhvIuG6WXH242+8x3cZ6Vce3cajzsSX0DM2FW5gwziq0P/49CWqtUsu0r
         PriJDV3vvgo4XR+5PWpf+g4ZtC7ocEV63DnrrdkHDQOIFVel/ppvrgRmIL73vv6Trz
         DoJjzZvfsu01w==
Date:   Wed, 12 Apr 2023 22:53:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 01/11] dmaengine: Add API function
 dmaengine_prep_slave_dma_array()
Message-ID: <ZDbpDptOcuBLFctc@matsya>
References: <20230403154800.215924-1-paul@crapouillou.net>
 <20230403154800.215924-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403154800.215924-2-paul@crapouillou.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-04-23, 17:47, Paul Cercueil wrote:
> This function can be used to initiate a scatter-gather DMA transfer
> where the DMA addresses and lengths are located inside arrays.
> 
> The major difference with dmaengine_prep_slave_sg() is that it supports
> specifying the lengths of each DMA transfer; as trying to override the
> length of the transfer with dmaengine_prep_slave_sg() is a very tedious
> process. The introduction of a new API function is also justified by the
> fact that scatterlists are on their way out.

Do we need a new API for this? why not use device_prep_interleaved_dma?

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
> v3: New patch
> ---
>  include/linux/dmaengine.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c3656e590213..62efa28c009a 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -912,6 +912,11 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
>  		struct dma_chan *chan, unsigned long flags);
>  
> +	struct dma_async_tx_descriptor *(*device_prep_slave_dma_array)(
> +		struct dma_chan *chan, dma_addr_t *addrs,
> +		size_t *lengths, size_t nb,
> +		enum dma_transfer_direction direction,
> +		unsigned long flags);
>  	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
> @@ -974,6 +979,17 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
>  						  dir, flags, NULL);
>  }
>  
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_dma_array(
> +	struct dma_chan *chan, dma_addr_t *addrs, size_t *lengths,
> +	size_t nb, enum dma_transfer_direction dir, unsigned long flags)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_slave_dma_array)
> +		return NULL;
> +
> +	return chan->device->device_prep_slave_dma_array(chan, addrs, lengths,
> +							 nb, dir, flags);
> +}
> +
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
>  	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
>  	enum dma_transfer_direction dir, unsigned long flags)
> -- 
> 2.39.2

-- 
~Vinod
