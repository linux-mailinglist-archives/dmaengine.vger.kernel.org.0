Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46551472091
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhLMFgn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMFgm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:36:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C9C06173F;
        Sun, 12 Dec 2021 21:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B839CE0D07;
        Mon, 13 Dec 2021 05:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FEAC00446;
        Mon, 13 Dec 2021 05:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639373798;
        bh=jzxLutXZGBv/idEvgMEI/hlL/bgiM5SpS61mNShrnv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIoq2Ey+J6j+M7bd6ZUOHkKg1gnZYtS8ADckIWjpqfgMSE2vysmUVIbNSrWL2+r4s
         inx+6VKZ04jeHp9glht9+QTiBkVfcL8Pea1qF52UkKJmzpwck8lSHIaeAZcvi4P8pB
         1aigVERESMIaGq2Gt0sUXsPsRwoUMUudMw1yt8YyTmEOTVTg89qCniwM3THlyWH1t3
         62aiw2SZ71YaU9/7rNPXjlnbvIaPFdIuCl+5Y8ykfgR+qfkOh437zRgWoMI586+iVA
         VRzzFmaihcw8bZkh1/h1zfqPKoJ49ZviWzYIl9R6CVWXO8fI7lM3kiYWbk5PeXnVtA
         YB2ESwRSX7Pwg==
Date:   Mon, 13 Dec 2021 11:06:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dma: ti: k3-udma: Workaround errata i2234
Message-ID: <Ybbb4rd95INkPPGN@matsya>
References: <20211209180715.27998-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209180715.27998-1-vigneshr@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-12-21, 23:37, Vignesh Raghavendra wrote:
> Per [1], UDMA TR15 transactions may hang if ICNT0 is less than 64B
> Work around is to set EOL flag is to 1 for ICNT0.
> 
> Since, there is no performance penalty / side effects of setting EOL
> flag event ICNTO > 64B, just set the flag for all UDMAP TR15
> descriptors.

s/dma/dmaengine

> 
> [1] https://www.ti.com/lit/er/sprz455a/sprz455a.pdf
> Errata doc for J721E DRA829/TDA4VM Processors Silicon Revision 1.1/1.0 (Rev. A)
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c     | 48 +++++++++++++++++++-----------------
>  include/linux/dma/ti-cppi5.h |  1 +
>  2 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 6e56d1cef5ee..d65c4cc5fbf7 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2863,6 +2863,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	struct udma_desc *d;
>  	struct cppi5_tr_type1_t *tr_req = NULL;
>  	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> +	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
>  	unsigned int i;
>  	size_t tr_size;
>  	int num_tr = 0;
> @@ -2885,10 +2886,12 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  
>  	d->sglen = sglen;
>  
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
>  		asel = 0;
> -	else
> +		csf |= CPPI5_TR_CSF_EOL_ICNT0;
> +	} else {
>  		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> +	}
>  
>  	tr_req = d->hwdesc[0].tr_req_base;
>  	for_each_sg(sgl, sgent, sglen, i) {
> @@ -2906,7 +2909,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  
>  		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
>  			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
>  
>  		sg_addr |= asel;
>  		tr_req[tr_idx].addr = sg_addr;
> @@ -2919,8 +2922,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
>  				      false, false,
>  				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
>  
>  			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
>  			tr_req[tr_idx].icnt0 = tr1_cnt0;
> @@ -2932,8 +2934,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  		d->residue += sg_dma_len(sgent);
>  	}
>  
> -	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
> -			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
> +	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, csf | CPPI5_TR_CSF_EOP);
>  
>  	return d;
>  }
> @@ -2947,6 +2948,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	struct scatterlist *sgent;
>  	struct cppi5_tr_type15_t *tr_req = NULL;
>  	enum dma_slave_buswidth dev_width;
> +	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
>  	u16 tr_cnt0, tr_cnt1;
>  	dma_addr_t dev_addr;
>  	struct udma_desc *d;
> @@ -3017,6 +3019,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  
>  	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
>  		asel = 0;
> +		csf |= CPPI5_TR_CSF_EOL_ICNT0;
>  	} else {
>  		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
>  		dev_addr |= asel;
> @@ -3040,7 +3043,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  
>  		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15, false,
>  			      true, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
>  		cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
>  				     uc->config.tr_trigger_type,
>  				     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC, 0, 0);
> @@ -3086,8 +3089,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15,
>  				      false, true,
>  				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
>  			cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
>  					     uc->config.tr_trigger_type,
>  					     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC,
> @@ -3131,8 +3133,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  		d->residue += sg_len;
>  	}
>  
> -	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
> -			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
> +	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, csf | CPPI5_TR_CSF_EOP);
>  
>  	return d;
>  }
> @@ -3454,6 +3455,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  	struct cppi5_tr_type1_t *tr_req;
>  	unsigned int periods = buf_len / period_len;
>  	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> +	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
>  	unsigned int i;
>  	int num_tr;
>  
> @@ -3472,11 +3474,13 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  		return NULL;
>  
>  	tr_req = d->hwdesc[0].tr_req_base;
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
>  		period_addr = buf_addr;
> -	else
> +		csf |= CPPI5_TR_CSF_EOL_ICNT0;
> +	} else {
>  		period_addr = buf_addr |
>  			((u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT);
> +	}
>  
>  	for (i = 0; i < periods; i++) {
>  		int tr_idx = i * num_tr;
> @@ -3490,8 +3494,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  		tr_req[tr_idx].dim1 = tr0_cnt0;
>  
>  		if (num_tr == 2) {
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
>  			tr_idx++;
>  
>  			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
> @@ -3505,8 +3508,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
>  		}
>  
>  		if (!(flags & DMA_PREP_INTERRUPT))
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
>  
>  		period_addr += period_len;
>  	}
> @@ -3659,6 +3661,7 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	int num_tr;
>  	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
>  	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> +	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
>  
>  	if (uc->config.dir != DMA_MEM_TO_MEM) {
>  		dev_err(chan->device->dev,
> @@ -3689,13 +3692,15 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	if (uc->ud->match_data->type != DMA_TYPE_UDMA) {
>  		src |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
>  		dest |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
> +	} else {
> +		csf |= CPPI5_TR_CSF_EOL_ICNT0;
>  	}
>  
>  	tr_req = d->hwdesc[0].tr_req_base;
>  
>  	cppi5_tr_init(&tr_req[0].flags, CPPI5_TR_TYPE15, false, true,
>  		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -	cppi5_tr_csf_set(&tr_req[0].flags, CPPI5_TR_CSF_SUPR_EVT);
> +	cppi5_tr_csf_set(&tr_req[0].flags, csf);
>  
>  	tr_req[0].addr = src;
>  	tr_req[0].icnt0 = tr0_cnt0;
> @@ -3714,7 +3719,7 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	if (num_tr == 2) {
>  		cppi5_tr_init(&tr_req[1].flags, CPPI5_TR_TYPE15, false, true,
>  			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[1].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_csf_set(&tr_req[1].flags, csf);
>  
>  		tr_req[1].addr = src + tr0_cnt1 * tr0_cnt0;
>  		tr_req[1].icnt0 = tr1_cnt0;
> @@ -3729,8 +3734,7 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  		tr_req[1].dicnt3 = 1;
>  	}
>  
> -	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags,
> -			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
> +	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags, csf | CPPI5_TR_CSF_EOP);
>  
>  	if (uc->config.metadata_size)
>  		d->vd.tx.metadata_ops = &metadata_ops;
> diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
> index efa2f0309f00..c53c0f6e3b1a 100644
> --- a/include/linux/dma/ti-cppi5.h
> +++ b/include/linux/dma/ti-cppi5.h
> @@ -616,6 +616,7 @@ static inline void *cppi5_hdesc_get_swdata(struct cppi5_host_desc_t *desc)
>  #define   CPPI5_TR_CSF_SUPR_EVT			BIT(2)
>  #define   CPPI5_TR_CSF_EOL_ADV_SHIFT		(4U)
>  #define   CPPI5_TR_CSF_EOL_ADV_MASK		GENMASK(6, 4)
> +#define   CPPI5_TR_CSF_EOL_ICNT0		BIT(4)
>  #define   CPPI5_TR_CSF_EOP			BIT(7)
>  
>  /**
> -- 
> 2.34.1

-- 
~Vinod
