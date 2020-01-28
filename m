Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4C14B3B9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 12:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgA1Ls1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 06:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgA1Ls1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Jan 2020 06:48:27 -0500
Received: from localhost (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68ADE214AF;
        Tue, 28 Jan 2020 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580212106;
        bh=pw5kYxZm9G8bLsY3E+NaT8ov/Ppi5g63BufSTp34Tfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0h/gYA/u6HIRlJ7o3pXP+37TtCWwpA8DryUtLo44fX5Z4bWwBOHorFe5AW1eb5g7
         vs5FZjNdvDTynpU+BYumheXcWNXgbeLZAX3gcwFA8UEqY3Yn94Ru4LSrifU+7x8UhN
         Qqb6PGWJAzLagNA3T2ePUMC6bAwD/mEwqYKVwpKs=
Date:   Tue, 28 Jan 2020 17:18:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com, vigneshr@ti.com
Subject: Re: [PATCH for-next 1/4] dmaengine: ti: k3-udma: Use
 ktime/usleep_range based TX completion check
Message-ID: <20200128114820.GS2841@vkoul-mobl>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <20200127132111.20464-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127132111.20464-2-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-01-20, 15:21, Peter Ujfalusi wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> In some cases (McSPI for example) the jiffie and delayed_work based
> workaround can cause big throughput drop.
> 
> Switch to use ktime/usleep_range based implementation to be able
> to sustain speed for PDMA based peripherals.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 80 ++++++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ea79c2df28e0..fb59c869a6a7 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
> @@ -169,7 +170,7 @@ enum udma_chan_state {
>  
>  struct udma_tx_drain {
>  	struct delayed_work work;
> -	unsigned long jiffie;
> +	ktime_t tstamp;
>  	u32 residue;
>  };
>  
> @@ -946,9 +947,10 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>  	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
>  	bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
>  
> +	/* Transfer is incomplete, store current residue and time stamp */
>  	if (peer_bcnt < bcnt) {
>  		uc->tx_drain.residue = bcnt - peer_bcnt;
> -		uc->tx_drain.jiffie = jiffies;
> +		uc->tx_drain.tstamp = ktime_get();

Any reason why ktime_get() is better than jiffies..?

>  		return false;
>  	}
>  
> @@ -961,35 +963,59 @@ static void udma_check_tx_completion(struct work_struct *work)
>  					    tx_drain.work.work);
>  	bool desc_done = true;
>  	u32 residue_diff;
> -	unsigned long jiffie_diff, delay;
> +	ktime_t time_diff;
> +	unsigned long delay;
> +
> +	while (1) {
> +		if (uc->desc) {
> +			/* Get previous residue and time stamp */
> +			residue_diff = uc->tx_drain.residue;
> +			time_diff = uc->tx_drain.tstamp;
> +			/*
> +			 * Get current residue and time stamp or see if
> +			 * transfer is complete
> +			 */
> +			desc_done = udma_is_desc_really_done(uc, uc->desc);
> +		}
>  
> -	if (uc->desc) {
> -		residue_diff = uc->tx_drain.residue;
> -		jiffie_diff = uc->tx_drain.jiffie;
> -		desc_done = udma_is_desc_really_done(uc, uc->desc);
> -	}
> -
> -	if (!desc_done) {
> -		jiffie_diff = uc->tx_drain.jiffie - jiffie_diff;
> -		residue_diff -= uc->tx_drain.residue;
> -		if (residue_diff) {
> -			/* Try to guess when we should check next time */
> -			residue_diff /= jiffie_diff;
> -			delay = uc->tx_drain.residue / residue_diff / 3;
> -			if (jiffies_to_msecs(delay) < 5)
> -				delay = 0;
> -		} else {
> -			/* No progress, check again in 1 second  */
> -			delay = HZ;
> +		if (!desc_done) {
> +			/*
> +			 * Find the time delta and residue delta w.r.t
> +			 * previous poll
> +			 */
> +			time_diff = ktime_sub(uc->tx_drain.tstamp,
> +					      time_diff) + 1;
> +			residue_diff -= uc->tx_drain.residue;
> +			if (residue_diff) {
> +				/*
> +				 * Try to guess when we should check
> +				 * next time by calculating rate at
> +				 * which data is being drained at the
> +				 * peer device
> +				 */
> +				delay = (time_diff / residue_diff) *
> +					uc->tx_drain.residue;
> +			} else {
> +				/* No progress, check again in 1 second  */
> +				schedule_delayed_work(&uc->tx_drain.work, HZ);
> +				break;
> +			}
> +
> +			usleep_range(ktime_to_us(delay),
> +				     ktime_to_us(delay) + 10);
> +			continue;
>  		}
>  
> -		schedule_delayed_work(&uc->tx_drain.work, delay);
> -	} else if (uc->desc) {
> -		struct udma_desc *d = uc->desc;
> +		if (uc->desc) {
> +			struct udma_desc *d = uc->desc;
> +
> +			uc->bcnt += d->residue;
> +			udma_start(uc);
> +			vchan_cookie_complete(&d->vd);
> +			break;
> +		}
>  
> -		uc->bcnt += d->residue;
> -		udma_start(uc);
> -		vchan_cookie_complete(&d->vd);
> +		break;
>  	}
>  }
>  
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
