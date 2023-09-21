Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19877A9FF5
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjIUU3W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 16:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjIUU3H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 16:29:07 -0400
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275579E07;
        Thu, 21 Sep 2023 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sw-optimization.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uWSGtFxKnBKnhVYiDE/lsVnxy+izTRoeGGy7oLS7gp0=; b=o9g3g1Ww8VyAo3/Fq3eApNecfT
        eN2lYgN12+FcwHgtVLUWAq44WebW9FCgj+5rjbmY5BYlaDpI2M29+/uxQYi9Gb8ie1ZaAtBdSu5J5
        VfMHifOsRBFtLlFaRKlnART7OkX/1o4Lgva4w+GyjIdc98pJGu9IXCpPtaXkXbhsViuE=;
Received: from [195.192.57.194] (helo=[192.168.0.20])
        by mx01lb.world4you.com with esmtpa (Exim 4.96)
        (envelope-from <eas@sw-optimization.com>)
        id 1qjJOm-0000JQ-0B;
        Thu, 21 Sep 2023 15:07:16 +0200
Message-ID: <22402987-305b-024b-044e-53db17037d90@sw-optimization.com>
Date:   Thu, 21 Sep 2023 15:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
To:     Olivier Dautricourt <olivierdautricourt@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>
References: <20230920200636.32870-3-olivierdautricourt@gmail.com>
Content-Language: de-DE
From:   Eric Schwarz <eas@sw-optimization.com>
In-Reply-To: <20230920200636.32870-3-olivierdautricourt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Olivier,

thanks for following up on my comment first. I really appreciate. - I 
don't have access to the hardware anymore, so I cannot test changes myself.

This patch addresses IMHO three fixes. - Shouldn't it be split up into 
three small junks so one could also later work w/ git bisect / separate 
ack's? - That way it is an all or nothing thing. Please regard this 
remark as cosmetics.

Am 20.09.2023 um 21:58 schrieb Olivier Dautricourt:
> Sparse complains because we first take the lock in msgdma_tasklet -> move
> locking to msgdma_chan_desc_cleanup.
> In consequence, move calling of msgdma_chan_desc_cleanup outside of the
> critical section of function msgdma_tasklet.
> 
> Use spin_unlock_irqsave/restore instead of just spinlock/unlock to keep
> state of irqs while executing the callbacks.

What about the locking in the IRQ handler msgdma_irq_handler() itself? - 
Shouldn't spin_unlock_irqsave/restore() be used there as well instead of 
just spinlock/unlock()?

> Remove list_del call in msgdma_chan_desc_cleanup, this should be the role
> of msgdma_free_descriptor. In consequence replace list_add_tail with
> list_move_tail in msgdma_free_descriptor. This fixes the path:
> msgdma_free_chan_resources -> msgdma_free_descriptors ->
> msgdma_free_desc_list -> msgdma_free_descriptor
> which does __not__ seems to free correctly the descriptors as firsts nodes
> where not removed from the specified list.
>
s/__not__/_not_/
s/seems/seem/
s/firsts/first/ => Actually I would omit it.
s/where/were/

"Fixes: <12 digits git hash> ("commit-message")" is missing [1] isn't it?

[1] 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
> ---
> Following Eric Schwarz comments on altera-msgdma driver not having some
> of the fixes made to zynqmp-dma driver (which msgdma driver is based on):
> This patch should address at least the spinlock part, it __has not__ been
> tested yet so please don't accept it right away. I'm in the process of
> getting a new hardware to test with. Meanwhile it is open to reviews
> and even better if someone is able to test it.
> 
>   drivers/dma/altera-msgdma.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 4153c2edb049..c39937bfcdf1 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -233,7 +233,7 @@ static void msgdma_free_descriptor(struct msgdma_device *mdev,
>   	struct msgdma_sw_desc *child, *next;
>   
>   	mdev->desc_free_cnt++;
> -	list_add_tail(&desc->node, &mdev->free_list);
> +	list_move_tail(&desc->node, &mdev->free_list);
>   	list_for_each_entry_safe(child, next, &desc->tx_list, node) {
>   		mdev->desc_free_cnt++;
>   		list_move_tail(&child->node, &mdev->free_list);
> @@ -583,22 +583,25 @@ static void msgdma_issue_pending(struct dma_chan *chan)
>   static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
>   {
>   	struct msgdma_sw_desc *desc, *next;
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&mdev->lock, irqflags);
>   
>   	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
>   		struct dmaengine_desc_callback cb;
>   
> -		list_del(&desc->node);
> -
>   		dmaengine_desc_get_callback(&desc->async_tx, &cb);
>   		if (dmaengine_desc_callback_valid(&cb)) {
> -			spin_unlock(&mdev->lock);
> +			spin_unlock_irqrestore(&mdev->lock, irqflags);
>   			dmaengine_desc_callback_invoke(&cb, NULL);
> -			spin_lock(&mdev->lock);
> +			spin_lock_irqsave(&mdev->lock, irqflags);
>   		}
>   
>   		/* Run any dependencies, then free the descriptor */
>   		msgdma_free_descriptor(mdev, desc);
>   	}
> +
> +	spin_unlock_irqrestore(&mdev->lock, irqflags);
>   }
>   
>   /**
> @@ -713,10 +716,11 @@ static void msgdma_tasklet(struct tasklet_struct *t)
>   		}
>   
>   		msgdma_complete_descriptor(mdev);
> -		msgdma_chan_desc_cleanup(mdev);
>   	}
>   
>   	spin_unlock_irqrestore(&mdev->lock, flags);
> +
> +	msgdma_chan_desc_cleanup(mdev);
>   }
>   
>   /**
