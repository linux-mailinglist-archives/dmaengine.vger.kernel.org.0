Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA85054E2F7
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376878AbiFPOHQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiFPOHP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:07:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F864969C
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 07:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7B4EB82416
        for <dmaengine@vger.kernel.org>; Thu, 16 Jun 2022 14:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C54C34114;
        Thu, 16 Jun 2022 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655388431;
        bh=16okSKwQyYdUogP8BwLCK0IJ4Ef4iv5X6ziEJVEAc+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M13zlSccSFZfCsXINT7OwdJZ7vRs4P6FAmiXagArimoi6Z8Zv7XCcfUBvvLE5jW5X
         5tyzflWVFVLMlPj/drsMtmVsZt3IyNM4rP8JSMMkCpUgbkDFhi9kBWMLm10w7aCr1r
         L96ew5GO8y5kzlIJCQiN7TH7Vr7lrtQcZmIVVWdEO1O0zAihmR6Iak4dFRnVYs2icJ
         V2J5Pcjd75GluiY6hjqjQRiOjBDcn0WqoopATUIB9jMrswarbGV6dEPqplLvHBNRe5
         97N/uy1dc/iKDeHLxI8mvtVnb8yQP7I4Fn5s1YxA0Y1hmKYkWpZSMHCDXIDhc3Zj0w
         t83ktFT8C5hXQ==
Date:   Thu, 16 Jun 2022 07:07:10 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Cc:     dmaengine@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH RESEND] dmaengine: sf-pdma: Add multithread support for a
 DMA channel
Message-ID: <Yqs5DrfTMyxoE6+K@matsya>
References: <20220614084009.70694-1-v.v.mitrofanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614084009.70694-1-v.v.mitrofanov@yadro.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-22, 11:40, Viacheslav Mitrofanov wrote:
> When we get a DMA channel and try to use it in multiple threads it
> will cause oops and hanging the system.
> 
> % echo 64 > /sys/module/dmatest/parameters/threads_per_chan
> % echo 10000 > /sys/module/dmatest/parameters/iterations
> % echo 1 > /sys/module/dmatest/parameters/run
> [   89.480664] Unable to handle kernel NULL pointer dereference at virtual
>                address 00000000000000a0
> [   89.488725] Oops [#1]
> [   89.494708] CPU: 2 PID: 1008 Comm: dma0chan0-copy0 Not tainted
>                5.17.0-rc5
> [   89.509385] epc : vchan_find_desc+0x32/0x46
> [   89.513553]  ra : sf_pdma_tx_status+0xca/0xd6
> 
> This happens because of data race. Each thread rewrite channels's
> descriptor as soon as device_prep_dma_memcpy() is called. It leads to the
> situation when the driver thinks that it uses right descriptor that
> actually is freed or substituted for other one.
> 
> With current fixes a descriptor changes its value only when it has
> been used. A new descriptor is acquired from vc->desc_issued queue that
> is already filled with descriptors that are ready to be sent. Threads
> have no direct access to DMA channel descriptor. Now it is just possible
> to queue a descriptor for further processing.
> 
> Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
> Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 44 ++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index f12606aeff87..70bb032c59c2 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -52,16 +52,6 @@ static inline struct sf_pdma_desc *to_sf_pdma_desc(struct virt_dma_desc *vd)
>  static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
>  {
>  	struct sf_pdma_desc *desc;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&chan->lock, flags);
> -
> -	if (chan->desc && !chan->desc->in_use) {
> -		spin_unlock_irqrestore(&chan->lock, flags);
> -		return chan->desc;
> -	}
> -
> -	spin_unlock_irqrestore(&chan->lock, flags);
>  
>  	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
>  	if (!desc)
> @@ -111,7 +101,6 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_addr_t dest, dma_addr_t src,
>  	desc->async_tx = vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>  
>  	spin_lock_irqsave(&chan->vchan.lock, iflags);
> -	chan->desc = desc;
>  	sf_pdma_fill_desc(desc, dest, src, len);
>  	spin_unlock_irqrestore(&chan->vchan.lock, iflags);
>  
> @@ -170,11 +159,17 @@ static size_t sf_pdma_desc_residue(struct sf_pdma_chan *chan,
>  	unsigned long flags;
>  	u64 residue = 0;
>  	struct sf_pdma_desc *desc;
> -	struct dma_async_tx_descriptor *tx;
> +	struct dma_async_tx_descriptor *tx = NULL;
>  
>  	spin_lock_irqsave(&chan->vchan.lock, flags);
>  
> -	tx = &chan->desc->vdesc.tx;
> +	list_for_each_entry(vd, &chan->vchan.desc_submitted, node)
> +		if (vd->tx.cookie == cookie)
> +			tx = &vd->tx;
> +
> +	if (!tx)
> +		goto out;
> +
>  	if (cookie == tx->chan->completed_cookie)
>  		goto out;
>  
> @@ -241,6 +236,19 @@ static void sf_pdma_enable_request(struct sf_pdma_chan *chan)
>  	writel(v, regs->ctrl);
>  }
>  
> +static struct sf_pdma_desc *sf_pdma_get_first_pending_desc(struct sf_pdma_chan *chan)
> +{
> +	struct virt_dma_chan *vchan = &chan->vchan;
> +	struct virt_dma_desc *vdesc;
> +
> +	if (list_empty(&vchan->desc_issued))
> +		return NULL;
> +
> +	vdesc = list_first_entry(&vchan->desc_issued, struct virt_dma_desc, node);
> +
> +	return container_of(vdesc, struct sf_pdma_desc, vdesc);
> +}
> +
>  static void sf_pdma_xfer_desc(struct sf_pdma_chan *chan)
>  {
>  	struct sf_pdma_desc *desc = chan->desc;
> @@ -268,8 +276,11 @@ static void sf_pdma_issue_pending(struct dma_chan *dchan)
>  
>  	spin_lock_irqsave(&chan->vchan.lock, flags);
>  
> -	if (vchan_issue_pending(&chan->vchan) && chan->desc)
> +	if ((chan->desc == NULL) && vchan_issue_pending(&chan->vchan)) {

you dont need second pair of parentheses for (chan->desc == NULL)

Also consider writing as !chan->desc for NULL comparison

> +		/* vchan_issue_pending has made a check that desc in not NULL */
> +		chan->desc = sf_pdma_get_first_pending_desc(chan);
>  		sf_pdma_xfer_desc(chan);
> +	}
>  
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
> @@ -298,6 +309,11 @@ static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
>  	spin_lock_irqsave(&chan->vchan.lock, flags);
>  	list_del(&chan->desc->vdesc.node);
>  	vchan_cookie_complete(&chan->desc->vdesc);
> +
> +	chan->desc = sf_pdma_get_first_pending_desc(chan);
> +	if (chan->desc)
> +		sf_pdma_xfer_desc(chan);
> +
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
>  
> -- 
> 2.25.1

-- 
~Vinod
