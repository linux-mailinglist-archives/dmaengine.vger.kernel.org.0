Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F773DE1C
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jun 2023 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFZLuN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jun 2023 07:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFZLuL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jun 2023 07:50:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331411AD;
        Mon, 26 Jun 2023 04:50:06 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qDkjJ-0007Jh-Nv; Mon, 26 Jun 2023 13:50:01 +0200
Message-ID: <6bc3a7cb-4c3b-62e2-75f7-820f3a589029@leemhuis.info>
Date:   Mon, 26 Jun 2023 13:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] dmaengine: pl330: Return DMA_PAUSED when transaction is
 paused
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Tresidder <rtresidd@electromag.com.au>,
        stable@vger.kernel.org
References: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687780206;e6f7ebd4;
X-HE-SMSGID: 1qDkjJ-0007Jh-Nv
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26.05.23 12:54, Ilpo Järvinen wrote:
> pl330_pause() does not set anything to indicate paused condition which
> causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
> DMA flush after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
> DMA Rx rearm race"). The function comment for pl330_pause() claims
> pause is supported but resume is not which is enough for 8250 DMA flush
> to work as long as DMA status reports DMA_PAUSED when appropriate.
> 
> Add PAUSED state for descriptor and mark BUSY descriptors with PAUSED
> in pl330_pause(). Return DMA_PAUSED from pl330_tx_status() when the
> descriptor is PAUSED.
> 
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Tested-by: Richard Tresidder <rtresidd@electromag.com.au>
> Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-serial/f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Ilpo, Vinod, Philipp: what happened to this? It seems this fix for a
regression didn't make any progress since it was posted. Or am I missing
something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> ---
> 
> $ diff -u <(git grep -l -e '\.device_pause' -e '->device_pause') <(git grep -l DMA_PAUSED)
> 
> ...tells there might a few other drivers which do not properly return
> DMA_PAUSED status despite having a pause function.
> 
>  drivers/dma/pl330.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 0d9257fbdfb0..daad25f2c498 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -403,6 +403,12 @@ enum desc_status {
>  	 * of a channel can be BUSY at any time.
>  	 */
>  	BUSY,
> +	/*
> +	 * Pause was called while descriptor was BUSY. Due to hardware
> +	 * limitations, only termination is possible for descriptors
> +	 * that have been paused.
> +	 */
> +	PAUSED,
>  	/*
>  	 * Sitting on the channel work_list but xfer done
>  	 * by PL330 core
> @@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
>  	list_for_each_entry(desc, &pch->work_list, node) {
>  
>  		/* If already submitted */
> -		if (desc->status == BUSY)
> +		if (desc->status == BUSY || desc->status == PAUSED)
>  			continue;
>  
>  		ret = pl330_submit_req(pch->thread, desc);
> @@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *chan)
>  {
>  	struct dma_pl330_chan *pch = to_pchan(chan);
>  	struct pl330_dmac *pl330 = pch->dmac;
> +	struct dma_pl330_desc *desc;
>  	unsigned long flags;
>  
>  	pm_runtime_get_sync(pl330->ddma.dev);
> @@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *chan)
>  	_stop(pch->thread);
>  	spin_unlock(&pl330->lock);
>  
> +	list_for_each_entry(desc, &pch->work_list, node) {
> +		if (desc->status == BUSY)
> +			desc->status = PAUSED;
> +	}
>  	spin_unlock_irqrestore(&pch->lock, flags);
>  	pm_runtime_mark_last_busy(pl330->ddma.dev);
>  	pm_runtime_put_autosuspend(pl330->ddma.dev);
> @@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  		else if (running && desc == running)
>  			transferred =
>  				pl330_get_current_xferred_count(pch, desc);
> -		else if (desc->status == BUSY)
> +		else if (desc->status == BUSY || desc->status == PAUSED)
>  			/*
>  			 * Busy but not running means either just enqueued,
>  			 * or finished and not yet marked done
> @@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  			case DONE:
>  				ret = DMA_COMPLETE;
>  				break;
> +			case PAUSED:
> +				ret = DMA_PAUSED;
> +				break;
>  			case PREP:
>  			case BUSY:
>  				ret = DMA_IN_PROGRESS;
