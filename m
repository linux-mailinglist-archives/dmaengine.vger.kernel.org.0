Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADA747E4B
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGEHc0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 03:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGEHcZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 03:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E310C3;
        Wed,  5 Jul 2023 00:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CC461459;
        Wed,  5 Jul 2023 07:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B20C433C8;
        Wed,  5 Jul 2023 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688542334;
        bh=rrKS9XlbWXtXv9/M+AGV0hoVPd4VwC9NnkejaVVNV/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PebVrMnxOd9dYXNZ9uEZx40XeASe4nHkgzQwy6WsR4jV1HuOvzMR+ZEGb6xxZ1oZT
         p7el+iseuVSvWgraRwCdSnkns/vJu0mecsLNlmhfiLgIQRvUD7ff/TXoSQa/fQZDSN
         A5R8NP0hAPxSu6j2HWUy1j/Yv8rOewaCaC0+6IFE5xvEpztYPqCoevRyadmjy3412D
         7eLTsKKGSYdxhOoyG1UWfLTDRvWuuuEnKd1Ug4xvkxxl73C6E07i5RbiFXUxOsGmAD
         A5KAdpNxnsrEgPBAFK1zx2ykBOiWT4Z2PtBDamrCcd4s765Or75qhXPRgGg0kjC5bh
         /2hSsvRTvxPlw==
Date:   Wed, 5 Jul 2023 13:02:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Robert Baldyga <r.baldyga@samsung.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Tresidder <rtresidd@electromag.com.au>,
        stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: Return DMA_PAUSED when transaction is
 paused
Message-ID: <ZKUceu9iJuAAeYYT@matsya>
References: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-05-23, 13:54, Ilpo Järvinen wrote:
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

Have you noticed the comment in the code which reads:

/*
 * We don't support DMA_RESUME command because of hardware
 * limitations, so after pausing the channel we cannot restore
 * it to active state. We have to terminate channel and setup
 * DMA transfer again. This pause feature was implemented to
 * allow safely read residue before channel termination.
 */

So driver just stops when in pause.

Now the commit 57e9af7831dc returns when in progress state, so am not
sure how returning Paused would help here?

> 
> Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
> Tested-by: Richard Tresidder <rtresidd@electromag.com.au>
> Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-serial/f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au/
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
> -- 
> 2.30.2

-- 
~Vinod
