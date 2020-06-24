Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5678206E4A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbgFXHym (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388655AbgFXHym (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:54:42 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D0E2085B;
        Wed, 24 Jun 2020 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592985281;
        bh=u5bGPxHpfck/MVpaAVun2T5RtLrj3PWfCkxiaVjC2tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUbxlwf7G39+dXkwsQB9wAmXBVX/OxV4FMeuXH3pSxehhaFfL6ituJFd22m2SfM7M
         kRNaK0kf1iLgAqLaX7GPsuQyJ0p3YY/4TWG69FbrQcfSOIPU9VXYI0pgt5cz86VfB0
         14aLRMW8mG2ApfRAs08FVZyiLKjDvj769xv+UN2M=
Date:   Wed, 24 Jun 2020 13:24:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] dmaengine: pl330: Remove the burst limit for
 quirk 'NO-FLUSHP'
Message-ID: <20200624075437.GT2324254@vkoul-mobl>
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
 <1591665267-37713-2-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591665267-37713-2-git-send-email-sugar.zhang@rock-chips.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-06-20, 09:14, Sugar Zhang wrote:
> There is no reason to limit the performance on the 'NO-FLUSHP' SoCs,
> cuz these platforms are just that the 'FLUSHP' instruction is broken.

Lets not use terms like cuz... 'because' is perfect term :)

It can rephrased to:
There is no reason to limit the performance on the 'NO-FLUSHP' SoCs
beacuse 'FLUSHP' instruction is broken on these platforms, so remove the
limit to improve the efficiency


> so, remove the limit to improve the efficiency.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/dma/pl330.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 6a158ee..ff0a91f 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1183,9 +1183,6 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
>  {
>  	int off = 0;
>  
> -	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
> -		cond = BURST;
> -
>  	/*
>  	 * do FLUSHP at beginning to clear any stale dma requests before the
>  	 * first WFP.
> @@ -1231,8 +1228,9 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
>  }
>  
>  /*
> - * transfer dregs with single transfers to peripheral, or a reduced size burst
> - * for mem-to-mem.
> + * only the unaligned bursts transfers have the dregs.
> + * transfer dregs with a reduced size burst to peripheral,
> + * or a reduced size burst for mem-to-mem.

This is not related to broken flush and should be a different patch
explaining why this changes were done

>   */
>  static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
>  		const struct _xfer_spec *pxs, int transfer_length)
> @@ -1247,8 +1245,23 @@ static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
>  	case DMA_MEM_TO_DEV:
>  		/* fall through */
>  	case DMA_DEV_TO_MEM:
> -		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs,
> -			transfer_length, SINGLE);
> +		/*
> +		 * dregs_len = (total bytes - BURST_TO_BYTE(bursts, ccr)) /
> +		 *             BRST_SIZE(ccr)
> +		 * the dregs len must be smaller than burst len,
> +		 * so, for higher efficiency, we can modify CCR
> +		 * to use a reduced size burst len for the dregs.
> +		 */
> +		dregs_ccr = pxs->ccr;
> +		dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
> +			(0xf << CC_DSTBRSTLEN_SHFT));
> +		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
> +			CC_SRCBRSTLEN_SHFT);
> +		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
> +			CC_DSTBRSTLEN_SHFT);
> +		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
> +		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, 1,
> +					BURST);
>  		break;
>  
>  	case DMA_MEM_TO_MEM:
> @@ -2221,9 +2234,7 @@ static bool pl330_prep_slave_fifo(struct dma_pl330_chan *pch,
>  
>  static int fixup_burst_len(int max_burst_len, int quirks)
>  {
> -	if (quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
> -		return 1;
> -	else if (max_burst_len > PL330_MAX_BURST)
> +	if (max_burst_len > PL330_MAX_BURST)
>  		return PL330_MAX_BURST;
>  	else if (max_burst_len < 1)
>  		return 1;
> @@ -3128,8 +3139,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
>  	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> -	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
> -			 1 : PL330_MAX_BURST);
> +	pd->max_burst = PL330_MAX_BURST;
>  
>  	ret = dma_async_device_register(pd);
>  	if (ret) {
> -- 
> 2.7.4
> 
> 

-- 
~Vinod
