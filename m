Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0873247221B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 09:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhLMIHd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 03:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhLMIHc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 03:07:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049CBC06173F;
        Mon, 13 Dec 2021 00:07:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB49B80DD7;
        Mon, 13 Dec 2021 08:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE576C00446;
        Mon, 13 Dec 2021 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639382849;
        bh=KBVBYKSOAnpU19r4bh9LFOK0UocsIq+Tk7h75NjXXSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qs/t0Q3udVHvzANavU8aWC1zq9ikbj1GPpzNOrnXS9LgHB51/ecTvnpirt0qLVj/V
         PQJ3naRMp/1PHovJzQXP4sD5WZPt/RcIC28B3gYilubvF78rLUSg/c5WglGEfwmBXP
         eGpq1TVZqgQQktgZIDVpw7638MvngYhEpUUPjcYo2WWtSn/B3BPV9QCw8MBOzFfkU9
         zBdNLixPiHZs08dfR8dI8LfYbvOIXmqg++SJEQeL33OKPjrN2DnEq7Vv+6rFB0rt8d
         JQun5zhQtOQ0zMVJAByoYDlBLpun2Jt+03RijNUs1F3RV65P5JNoBOF4DkQu1j7ZTA
         MRVUQZXdh6tTQ==
Date:   Mon, 13 Dec 2021 13:37:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     ludovic.desroches@microchip.com, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 08/13] dmaengine: at_xdmac: Move the free desc to the
 tail of the desc list
Message-ID: <Ybb/PV5M1Gi59s7I@matsya>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
 <20211125090028.786832-9-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125090028.786832-9-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-11-21, 11:00, Tudor Ambarus wrote:
> So that we don't use the same desc over and over again.

Please use full para in the changelog and not a continuation of the
patch title!

and why is wrong with using same desc over and over? Any benefits of not
doing so?


> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/dma/at_xdmac.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 2cc9af222681..8804a86a9bcc 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -729,7 +729,8 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		if (!desc) {
>  			dev_err(chan2dev(chan), "can't get descriptor\n");
>  			if (first)
> -				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> +				list_splice_tail_init(&first->descs_list,
> +						      &atchan->free_descs_list);
>  			goto spin_unlock;
>  		}
>  
> @@ -817,7 +818,8 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>  		if (!desc) {
>  			dev_err(chan2dev(chan), "can't get descriptor\n");
>  			if (first)
> -				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> +				list_splice_tail_init(&first->descs_list,
> +						      &atchan->free_descs_list);
>  			spin_unlock_irqrestore(&atchan->lock, irqflags);
>  			return NULL;
>  		}
> @@ -1051,8 +1053,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
>  							       src_addr, dst_addr,
>  							       xt, chunk);
>  			if (!desc) {
> -				list_splice_init(&first->descs_list,
> -						 &atchan->free_descs_list);
> +				list_splice_tail_init(&first->descs_list,
> +						      &atchan->free_descs_list);
>  				return NULL;
>  			}
>  
> @@ -1132,7 +1134,8 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		if (!desc) {
>  			dev_err(chan2dev(chan), "can't get descriptor\n");
>  			if (first)
> -				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> +				list_splice_tail_init(&first->descs_list,
> +						      &atchan->free_descs_list);
>  			return NULL;
>  		}
>  
> @@ -1308,8 +1311,8 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  						   sg_dma_len(sg),
>  						   value);
>  		if (!desc && first)
> -			list_splice_init(&first->descs_list,
> -					 &atchan->free_descs_list);
> +			list_splice_tail_init(&first->descs_list,
> +					      &atchan->free_descs_list);
>  
>  		if (!first)
>  			first = desc;
> @@ -1701,7 +1704,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
>  
>  		spin_lock_irq(&atchan->lock);
>  		/* Move the xfer descriptors into the free descriptors list. */
> -		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
> +		list_splice_tail_init(&desc->descs_list,
> +				      &atchan->free_descs_list);
>  		at_xdmac_advance_work(atchan);
>  		spin_unlock_irq(&atchan->lock);
>  	}
> @@ -1850,7 +1854,8 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
>  	/* Cancel all pending transfers. */
>  	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
>  		list_del(&desc->xfer_node);
> -		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
> +		list_splice_tail_init(&desc->descs_list,
> +				      &atchan->free_descs_list);
>  	}
>  
>  	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
> -- 
> 2.25.1

-- 
~Vinod
