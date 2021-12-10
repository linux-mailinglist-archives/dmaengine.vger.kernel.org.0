Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD494703BA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhLJPZj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbhLJPZj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 10:25:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A95C061746;
        Fri, 10 Dec 2021 07:22:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l22so18661185lfg.7;
        Fri, 10 Dec 2021 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=y2wlAkLc46MvzmRHMqz5RslYjHdyHxmej5ddjvDnjbE=;
        b=QhoXIlI9EmqT534B8RS3erKAUUg5TawFnFLHIhewWEk4NFd6l0nlav/2u2xEJKi0U0
         FQP26RQuFE6vWpaDW4ZIQasCDOhh1JdVzSTxCS327Y+IoGB4vj87G+J0J6dRKHa+UayN
         De0a29BzwUoRL4TkO4kn+vBRI5V0CUcrlps4LnqKikj+k1d6IUpC8jEoULJl7HOA44Fb
         4XSNIbyLtwWxvndqKuiA5VWuo/7WVjKGnbI35hq8gd2Cu9bhvLjFmd+FX5GxxWZHPHId
         UMe8uYgkriynu76ofiicjYOafw0rYxdFclIY3ZjrB1UGw8/wzfLDddfYyJx8CPU1hibD
         3e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=y2wlAkLc46MvzmRHMqz5RslYjHdyHxmej5ddjvDnjbE=;
        b=uxzxhMP/bfkwH4geu8NFRG7teOvpBKfzJfuqz5rK2mJMMC5kkNU8vp1fv7cqNyJJph
         DbLNJagu9KbOREi4cImZ6i6fpqXb6j1P6207hiZN0CKf1UpOTZdcdyVwYupSYoFCKkr9
         qRbdQVYxhURrv3fL5rft0+a1FItwihC042Cg8daY95W1/oXd0HlbFq+yAdXmmXUKf73I
         1x1cqb9mUNSw1FJ4etPuYOt86SFV2RKgUDOHdrcTwn23Us7GTy8ZfzMsAFRX/EwFHd6S
         LrqMtifcsduUsoSrh9GqylhjM3YKFAHrWvhIao8Q1bzphObmXSdHVydeDxVYnqVV+mkj
         n0PQ==
X-Gm-Message-State: AOAM531GmUJk717O/WQyN7dyUL+qZ3nkZqVi8/jXWv9esEEOZ45bOMdk
        LzMy2L3lVZ19l7gy6DqT5i4=
X-Google-Smtp-Source: ABdhPJze5s3Linx+vYhJRAsRmEmCicLs3RiGgBI/SYevzn/zT2PeFc0pfAudH4fC6oa13ou0MAYSHQ==
X-Received: by 2002:ac2:446a:: with SMTP id y10mr12583510lfl.585.1639149722268;
        Fri, 10 Dec 2021 07:22:02 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id m13sm337921lfl.131.2021.12.10.07.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 07:22:01 -0800 (PST)
Message-ID: <a76fcbd1-20fa-fb16-bca4-68dd90031787@gmail.com>
Date:   Fri, 10 Dec 2021 17:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20211209180715.27998-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Workaround errata i2234
In-Reply-To: <20211209180715.27998-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vignesh,

On 09/12/2021 20:07, Vignesh Raghavendra wrote:
> Per [1], UDMA TR15 transactions may hang if ICNT0 is less than 64B
> Work around is to set EOL flag is to 1 for ICNT0.
> 
> Since, there is no performance penalty / side effects of setting EOL
> flag event ICNTO > 64B, just set the flag for all UDMAP TR15
> descriptors.

PDMAs and CSI does not send EOL? If you set it the EOL to one then when
it arrives the remaining icnt0 is skipped...

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

the correct expression is: (1 << CPPI5_TR_CSF_EOL_ADV_SHIFT)
as EOL = 1 is what you want to set.
EOL = 2 will clear icnt0 and 1 on EOL.
3 will do the same for icnt 0, 1 and 2
4 will skip the remainin tr.

>  #define   CPPI5_TR_CSF_EOP			BIT(7)
>  
>  /**
> 

-- 
Péter
