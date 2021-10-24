Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59D6438B5E
	for <lists+dmaengine@lfdr.de>; Sun, 24 Oct 2021 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhJXSWG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Oct 2021 14:22:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:60094 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJXSWF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Oct 2021 14:22:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="210309997"
X-IronPort-AV: E=Sophos;i="5.87,178,1631602800"; 
   d="scan'208";a="210309997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 11:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.87,178,1631602800"; 
   d="scan'208";a="446362501"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.85.248]) ([10.255.85.248])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 11:19:42 -0700
Message-ID: <2570ae0c-c085-1e4e-cec6-6efab8106281@intel.com>
Date:   Sun, 24 Oct 2021 11:19:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] dmaengine: dmaengine_desc_callback_valid(): Check for
 `callback_result`
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org
References: <20211023134101.28042-1-lars@metafoo.de>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20211023134101.28042-1-lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/23/2021 6:41 AM, Lars-Peter Clausen wrote:
> Before the `callback_result` callback was introduced drivers coded their
> invocation to the callback in a similar way to:
>
> 	if (cb->callback) {
> 		spin_unlock(&dma->lock);
> 		cb->callback(cb->callback_param);
> 		spin_lock(&dma->lock);
> 	}
>
> With the introduction of `callback_result` two helpers where introduced to
> transparently handle both types of callbacks. And drivers where updated to
> look like this:
>
> 	if (dmaengine_desc_callback_valid(cb)) {
> 		spin_unlock(&dma->lock);
> 		dmaengine_desc_callback_invoke(cb, ...);
> 		spin_lock(&dma->lock);
> 	}
>
> dmaengine_desc_callback_invoke() correctly handles both `callback_result`
> and `callback`. But we forgot to update the dmaengine_desc_callback_valid()
> function to check for `callback_result`. As a result DMA descriptors that
> use the `callback_result` rather than `callback` don't have their callback
> invoked by drivers that follow the pattern above.
>
> Fix this by checking for both `callback` and `callback_result` in
> dmaengine_desc_callback_valid().
>
> Fixes: f067025bc676 ("dmaengine: add support to provide error result from a DMA transation")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/dmaengine.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 1bfbd64b1371..53f16d3f0029 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -176,7 +176,7 @@ dmaengine_desc_get_callback_invoke(struct dma_async_tx_descriptor *tx,
>   static inline bool
>   dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
>   {
> -	return (cb->callback) ? true : false;
> +	return cb->callback || cb->callback_result;
>   }
>   
>   struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
