Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B16525333
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiELRGf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347317AbiELRGe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 13:06:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37448E72;
        Thu, 12 May 2022 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652375192; x=1683911192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ybuHoHzAtRBoXiWgwax+YcGH4jG6oU63lubaSD8RYc=;
  b=V+zaATBievH2a1mXSjlWFfkJcYR6dLCH5/tYP5xfrUIorsorLWxakWoo
   zVzaD4F9jRVcy+adqQzfyg3ZICGUi7QiaQnwCaMmGneq3M5Y5kmGwAAGF
   P/TqH8idoY6jECf2K5yKy/+Wxpkfq76sTIH29wd5RTN8Unwe1Y+6HPzWw
   x3myy1h9uiRhAqdRIGTDwYTkyvybCDSn8Dd8ZVLVwLNkzE3kiIe50NWV/
   9bnK8RnZSiq1d6g64C20SQZVYzd6OE0PDs4I9gIb6fJQz7SxqAtZc0FKm
   rgKoJsgMsoII5cyN/sx2skqDwep4kejHtQWaa9qR2R5bcvRkATqOfnLjb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270006497"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="270006497"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:01:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="521037693"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.68.97]) ([10.212.68.97])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:01:37 -0700
Message-ID: <cb3d6542-10a8-22d7-ce09-2956449c02eb@intel.com>
Date:   Thu, 12 May 2022 10:01:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dmaengine: sf-pdma: Add multithread support for a DMA
 channel
Content-Language: en-US
To:     Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
        Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     david.abdurachmanov@sifive.com, linux@yadro.com
References: <20220512091327.349563-1-v.v.mitrofanov@yadro.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220512091327.349563-1-v.v.mitrofanov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/12/2022 2:13 AM, Viacheslav Mitrofanov wrote:
> When we get a DMA channel and try to use it in multiple threads it
> will cause oops and hanging the system.
>
> % echo 64 > /sys/module/dmatest/parameters/threads_per_chan
> % echo 10000 > /sys/module/dmatest/parameters/iterations
> % echo 1 > /sys/module/dmatest/parameters/run
> [   89.480664] Unable to handle kernel NULL pointer dereference at virtual
>                 address 00000000000000a0
> [   89.488725] Oops [#1]
> [   89.494708] CPU: 2 PID: 1008 Comm: dma0chan0-copy0 Not tainted
>                 5.17.0-rc5
> [   89.509385] epc : vchan_find_desc+0x32/0x46
> [   89.513553]  ra : sf_pdma_tx_status+0xca/0xd6
>
> This happens because of data race. Each thread rewrite channels's
> descriptor as soon as device_prep_dma_memcpy() is called. It leads to the
> situation when the driver thinks that it uses right descriptor that
> actually is freed or substituted for other one.
>
> With current fixes a descriptor changes it's value only when it has

With the current fix a descriptor ...

s/it's/its/


> been used. A new descriptor is acquired from vc->desc_issued queue that
> is already filled with descriptors that are ready to be sent. Threads
> have no direct access to DMA channel descriptor, now it is just possible

I suggest a '.' here instead of ','

DJ

> to queue a descriptor for further processing.
>
> Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
> Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
> ---
>   drivers/dma/sf-pdma/sf-pdma.c | 44 ++++++++++++++++++++++++-----------
>   1 file changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index f12606aeff87..70bb032c59c2 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -52,16 +52,6 @@ static inline struct sf_pdma_desc *to_sf_pdma_desc(struct virt_dma_desc *vd)
>   static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
>   {
>   	struct sf_pdma_desc *desc;
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
>   	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
>   	if (!desc)
> @@ -111,7 +101,6 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_addr_t dest, dma_addr_t src,
>   	desc->async_tx = vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
>   
>   	spin_lock_irqsave(&chan->vchan.lock, iflags);
> -	chan->desc = desc;
>   	sf_pdma_fill_desc(desc, dest, src, len);
>   	spin_unlock_irqrestore(&chan->vchan.lock, iflags);
>   
> @@ -170,11 +159,17 @@ static size_t sf_pdma_desc_residue(struct sf_pdma_chan *chan,
>   	unsigned long flags;
>   	u64 residue = 0;
>   	struct sf_pdma_desc *desc;
> -	struct dma_async_tx_descriptor *tx;
> +	struct dma_async_tx_descriptor *tx = NULL;
>   
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   
> -	tx = &chan->desc->vdesc.tx;
> +	list_for_each_entry(vd, &chan->vchan.desc_submitted, node)
> +		if (vd->tx.cookie == cookie)
> +			tx = &vd->tx;
> +
> +	if (!tx)
> +		goto out;
> +
>   	if (cookie == tx->chan->completed_cookie)
>   		goto out;
>   
> @@ -241,6 +236,19 @@ static void sf_pdma_enable_request(struct sf_pdma_chan *chan)
>   	writel(v, regs->ctrl);
>   }
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
>   static void sf_pdma_xfer_desc(struct sf_pdma_chan *chan)
>   {
>   	struct sf_pdma_desc *desc = chan->desc;
> @@ -268,8 +276,11 @@ static void sf_pdma_issue_pending(struct dma_chan *dchan)
>   
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   
> -	if (vchan_issue_pending(&chan->vchan) && chan->desc)
> +	if ((chan->desc == NULL) && vchan_issue_pending(&chan->vchan)) {
> +		/* vchan_issue_pending has made a check that desc in not NULL */
> +		chan->desc = sf_pdma_get_first_pending_desc(chan);
>   		sf_pdma_xfer_desc(chan);
> +	}
>   
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   }
> @@ -298,6 +309,11 @@ static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
>   	spin_lock_irqsave(&chan->vchan.lock, flags);
>   	list_del(&chan->desc->vdesc.node);
>   	vchan_cookie_complete(&chan->desc->vdesc);
> +
> +	chan->desc = sf_pdma_get_first_pending_desc(chan);
> +	if (chan->desc)
> +		sf_pdma_xfer_desc(chan);
> +
>   	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   }
>   
