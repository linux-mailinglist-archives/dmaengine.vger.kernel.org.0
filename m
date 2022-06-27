Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4755CFE0
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiF0GVg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 02:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiF0GVf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 02:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43302BDA;
        Sun, 26 Jun 2022 23:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 602A8612B4;
        Mon, 27 Jun 2022 06:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F07FC341C8;
        Mon, 27 Jun 2022 06:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656310893;
        bh=hk9+mMFsgmDnegzAol0i+gs3JTJRWP8+Fr77+Or2q7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmeHYhyRxDBjlMgOrmLE7ult6qm3mSfK51byhC6Ma5CtFZd/8gVce6GQd8s+VTiIi
         4O0hHnVCQNOuY0srPKLL1Zb+Rf4bUMmehyTvd/5W48BpAqZYsFqTDtLMHNg6a1kCjC
         hnVpis6CkL6RxQZfTAxxTlZCvp23T5dopST+nTlKZzcHvTQqrPJVf9T6igV37Gn3hK
         GBTT7qqEhHLy7dGHayQU9imgIVg6VSClZppi59/1I8Yge/mZQeF7OgSbFnf0Glchzr
         /rP0B29JTl8mW9B5lX4yVkKDv5AYEyVsdChknKPT19R34V+EwfSkOwzGKAWX0UDL5o
         Vk7qGMHn3j9Lw==
Date:   Mon, 27 Jun 2022 11:51:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] dmaengine: hisilicon: Add multi-thread support for a
 DMA channel
Message-ID: <YrlMaasl+ORdDJaN@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220625074422.3479591-4-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625074422.3479591-4-haijie1@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-22, 15:44, Jie Hai wrote:
> When we get a DMA channel and try to use it in multiple threads it
> will cause oops and hanging the system.
> 
> % echo 100 > /sys/module/dmatest/parameters/threads_per_chan
> % echo 100 > /sys/module/dmatest/parameters/iterations
> % echo 1 > /sys/module/dmatest/parameters/run
> [383493.327077] Unable to handle kernel paging request at virtual
> 		address dead000000000108
> [383493.335103] Mem abort info:
> [383493.335103]   ESR = 0x96000044
> [383493.335105]   EC = 0x25: DABT (current EL), IL = 32 bits
> [383493.335107]   SET = 0, FnV = 0
> [383493.335108]   EA = 0, S1PTW = 0
> [383493.335109]   FSC = 0x04: level 0 translation fault
> [383493.335110] Data abort info:
> [383493.335111]   ISV = 0, ISS = 0x00000044
> [383493.364739]   CM = 0, WnR = 1
> [383493.367793] [dead000000000108] address between user and kernel
> 		address ranges
> [383493.375021] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [383493.437574] CPU: 63 PID: 27895 Comm: dma0chan0-copy2 Kdump:
> 		loaded Tainted: GO 5.17.0-rc4+ #2
> [383493.457851] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT
> 		-SSBS BTYPE=--)
> [383493.465331] pc : vchan_tx_submit+0x64/0xa0
> [383493.469957] lr : vchan_tx_submit+0x34/0xa0
> 
> This happens because of data race. Each thread rewrite channels's
> descriptor as soon as device_issue_pending is called. It leads to
> the situation that the driver thinks that it uses the right
> descriptor in interrupt handler while channels's descriptor has
> been changed by other thread.
> 
> With current fixes channels's descriptor changes it's value only
> when it has been used. A new descriptor is acquired from
> vc->desc_issued queue that is already filled with descriptors
> that are ready to be sent. Threads have no direct access to DMA
> channel descriptor. Now it is just possible to queue a descriptor
> for further processing.
> 
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/hisi_dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 0a0f8a4d168a..0385419be8d5 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -271,7 +271,6 @@ static void hisi_dma_start_transfer(struct hisi_dma_chan *chan)
>  
>  	vd = vchan_next_desc(&chan->vc);
>  	if (!vd) {
> -		dev_err(&hdma_dev->pdev->dev, "no issued task!\n");

how is this a fix?

>  		chan->desc = NULL;
>  		return;
>  	}
> @@ -303,7 +302,7 @@ static void hisi_dma_issue_pending(struct dma_chan *c)
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  
> -	if (vchan_issue_pending(&chan->vc))
> +	if (vchan_issue_pending(&chan->vc) && !chan->desc)

This looks good

>  		hisi_dma_start_transfer(chan);
>  
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> @@ -442,11 +441,10 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>  				    chan->qp_num, chan->cq_head);
>  		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
>  			vchan_cookie_complete(&desc->vd);
> +			hisi_dma_start_transfer(chan);

Why should this fix the error reported?

>  		} else {
>  			dev_err(&hdma_dev->pdev->dev, "task error!\n");
>  		}
> -
> -		chan->desc = NULL;
>  	}
>  
>  	spin_unlock(&chan->vc.lock);
> -- 
> 2.33.0

-- 
~Vinod
