Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82426E3953
	for <lists+dmaengine@lfdr.de>; Sun, 16 Apr 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDPOfy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Apr 2023 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDPOfr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Apr 2023 10:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87D10FB;
        Sun, 16 Apr 2023 07:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72ED86115C;
        Sun, 16 Apr 2023 14:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E5C433D2;
        Sun, 16 Apr 2023 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655745;
        bh=oYi/kfI630Qf+lLXMqcP2QjSxuZ+vYcX7yZzqhjWWPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qXG8251jqoVWUSrV51sLs1oSzzzzC7T5MtiNgDOESqs5+OgUn50TkoCMIDGbrY7zw
         0MwCsOSE+IHg+WnBoq/rbXZ9T5W1VTUs+NlAqaVB7xoTpqOL4nBcvQ6+mvqKdxiRss
         fgI13c9cODMUip2h0xLk0MkAC0bhKvca6iC1ALoV33Q3mryHq7oa69z42ztWG42/xh
         yV21inZTVYosbfM5GtForpPhe5w79bw5gq3JXjzFPqDfTocfFalD0xVknUY5MeliM0
         5QhN1+1HLRaYXnCXWVn5DUSSLmXl524KN1R0GlUF72fWS0Dsr0a/bhFvc1aHJCLVj8
         hwWKe+48vTCaA==
Date:   Sun, 16 Apr 2023 15:35:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v3 05/11] iio: buffer-dmaengine: Support specifying
 buffer direction
Message-ID: <20230416153546.63290206@jic23-huawei>
In-Reply-To: <20230403154800.215924-6-paul@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
        <20230403154800.215924-6-paul@crapouillou.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon,  3 Apr 2023 17:47:54 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Update the devm_iio_dmaengine_buffer_setup() function to support
> specifying the buffer direction.
> 
> Update the iio_dmaengine_buffer_submit() function to handle input
> buffers as well as output buffers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Just one trivial question inline.

Jonathan

> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 5f85ba38e6f6..592d2aa9044c 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -64,14 +64,25 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  	struct dmaengine_buffer *dmaengine_buffer =
>  		iio_buffer_to_dmaengine_buffer(&queue->buffer);
>  	struct dma_async_tx_descriptor *desc;
> +	enum dma_transfer_direction dma_dir;
> +	size_t max_size;
>  	dma_cookie_t cookie;
>  
> -	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
> -	block->bytes_used = round_down(block->bytes_used,
> -			dmaengine_buffer->align);
> +	max_size = min(block->size, dmaengine_buffer->max_size);
> +	max_size = round_down(max_size, dmaengine_buffer->align);
> +
> +	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
> +		block->bytes_used = max_size;
> +		dma_dir = DMA_DEV_TO_MEM;
> +	} else {
> +		dma_dir = DMA_MEM_TO_DEV;
> +	}
> +
> +	if (!block->bytes_used || block->bytes_used > max_size)
> +		return -EINVAL;

Two paths to here.  Either DIRECTION_IN in which we just set things
up so conditions being checked are always fine (unless max_size == 0?
Can that happen?), or !DIRECTION_IN.
So why not move this into the else {} branch above?

>  
>  	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> -		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
> +		block->phys_addr, block->bytes_used, dma_dir,
>  		DMA_PREP_INTERRUPT);
>  	if (!desc)
>  		return -ENOMEM;
