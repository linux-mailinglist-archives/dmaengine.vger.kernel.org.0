Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6537640CF
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGZU6B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGZU6A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 16:58:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A888F19B6
        for <dmaengine@vger.kernel.org>; Wed, 26 Jul 2023 13:57:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Ola0qS53LHI6nOla0q3IeG; Wed, 26 Jul 2023 22:57:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690405078;
        bh=Z2kLlpLkEgZtP7izpTTUI1ROGL8wQ9hwKLInZOYxV6g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=G9LhEvggbzF6efKkV3h/E9ejYFTDdoBVLn75M1NELKiJ6FbpHxdn9vnV6TsqljgiD
         JV09lLrS2rh7O5w+nctS/aqZCTBHInbro3x14E+kj73YlB3RC01RUtNWsVgSlV4Mp5
         XyzhlmQ2zUzVwQYmoVR3FkH3U5N+VavCtrj0H306SZAMmyvxHQUf211af7fqnrZw0f
         qnmKz6yKUkb+CwCb8rGkObbV6z5XbVYT7o12o08KgP7pfzSQiNBN0CU5gD1TzbaNDv
         2n1RVf/xBs4Lp+VpyfAxie5NH65toq9ljYVIFjjDkCR6LI6mbOj4zFBaMFFmTuvIaI
         YD10S6csiRsKA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Jul 2023 22:57:58 +0200
X-ME-IP: 86.243.2.178
Message-ID: <5125e39b-0faf-63fc-0c51-982b2a567e21@wanadoo.fr>
Date:   Wed, 26 Jul 2023 22:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dmaengine: xgene: Fix potential deadlock on &chan->lock
Content-Language: fr
To:     Chengfeng Ye <dg573847474@gmail.com>, vkoul@kernel.org,
        rsahu@apm.com, lho@apm.com, allen.lkml@gmail.com,
        romain.perier@gmail.com, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726111630.25670-1-dg573847474@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230726111630.25670-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 26/07/2023 à 13:16, Chengfeng Ye a écrit :
> As xgene_dma_cleanup_descriptors() is invoked by both tasklet
> xgene_dma_tasklet_cb() under softirq context and
> xgene_dma_free_chan_resources() callback that executed under process
> context, the lock aquicision of &chan->lock inside
> xgene_dma_cleanup_descriptors() should disable irq otherwise deadlock
> could happen if the tasklet softirq preempts the execution of process
> context code while the lock is held in process context on the same CPU.
> 
> Possible deadlock scenario:
> xgene_dma_free_chan_resources()
>      -> xgene_dma_cleanup_descriptors()
>      -> spin_lock(&chan->lock)
>          <tasklet softirq>
>          -> xgene_dma_tasklet_cb()
>          -> xgene_dma_cleanup_descriptors()
>          -> spin_lock(&chan->lock) (deadlock here)
> 
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock.

Hi,

first of all, for what I've seen from your numerous recent patches, all 
this look real great ! :)
And your experimental tool looks really promising.


Even if I'm not always confident with my understanding of locking and 
related subtilities, I wonder if in the cases of <tasklet softirq>, like 
above, using spin_lock_bh() would be enough?
It should be less agressive than spin_lock_irqsave() but still handle 
the use case you have spotted.


Just my 2c.

CJ


> 
> The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
> plx_dma_process_desc() to disable irq while lock is held.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>   drivers/dma/xgene-dma.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> index 3589b4ef50b8..e766511badcf 100644
> --- a/drivers/dma/xgene-dma.c
> +++ b/drivers/dma/xgene-dma.c
> @@ -689,11 +689,12 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
>   	struct xgene_dma_desc_sw *desc_sw, *_desc_sw;
>   	struct xgene_dma_desc_hw *desc_hw;
>   	struct list_head ld_completed;
> +	unsigned long flags;
>   	u8 status;
>   
>   	INIT_LIST_HEAD(&ld_completed);
>   
> -	spin_lock(&chan->lock);
> +	spin_lock_irqsave(&chan->lock, flags);
>   
>   	/* Clean already completed and acked descriptors */
>   	xgene_dma_clean_completed_descriptor(chan);
> @@ -762,7 +763,7 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
>   	 */
>   	xgene_chan_xfer_ld_pending(chan);
>   
> -	spin_unlock(&chan->lock);
> +	spin_unlock_irqrestore(&chan->lock, flags);
>   
>   	/* Run the callback for each descriptor, in order */
>   	list_for_each_entry_safe(desc_sw, _desc_sw, &ld_completed, node) {

