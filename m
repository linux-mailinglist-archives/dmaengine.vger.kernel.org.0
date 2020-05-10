Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71C81CCC0F
	for <lists+dmaengine@lfdr.de>; Sun, 10 May 2020 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgEJPwK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 May 2020 11:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPwK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 May 2020 11:52:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB607C061A0C
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2020 08:52:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b8so2836552plm.11
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2020 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wS2EF5eWwXz+epwYSR1MVGJvkvx3Tj4ljAwoZJaG55M=;
        b=DYVAA5IrBg7w4bhkiFPd9r9cOBkHq/a6W4LMFsJZV4EwgcIEZB8HjzlYuIZ3FEgQ1w
         lHWoSRwUlpOc1M91pVnWjkHIe0Taa28EXKsLNlo2gMYkrdgJSNjYGdeH5gHKOFJLexa5
         7SOvugKmO06RfR5QQyaDtJPmjxPt0KDwP67FnEMiE1GJSkkCcEoYbzNoW98lVelRwkH4
         YzxK1Zvad5dXsIzz7d4ntu1D5/FkHS1LkEsKUeuBjNuwFdEFdltSDx2i0HD7l/5qiHkZ
         +rIobyBkkWuKUFNzmr5BhuhRfm/7ssjYoIAPsDmeVtoT9nv3zOGDguTO3xBSxzoRULou
         kCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wS2EF5eWwXz+epwYSR1MVGJvkvx3Tj4ljAwoZJaG55M=;
        b=O2VHKzmlO3FRBsyxRkxNlk7vtIzoQuhdfGRFjwmpHIRma5Eh2y6ZlLOhIn3Fwxdg4V
         2JJHrs+mIn/5ICLQw/+WTuhU/mMso5SbBvLX0pYphLEIX6r4UXtsBAtPLtrX5RQMstNt
         zL53dLLne03x8SAhmk4IgQOvTrvaP8yBxyt0GMb7C3WLpWbds6NJB32Yt08CZSZoeSei
         2Y+DqGNQ339/mC/y7S++tYIPKY9l+qGO+YcAOlpgGMRF4Hp50xMuWZn1dOijvg4B36dT
         /mm6CMr0WAYJv5qP6pYRhVBPfCyra6uuxAA6AJf4iGu5NMdnvZ34cYGaEKrgiT5N3OAL
         J5tA==
X-Gm-Message-State: AGi0Pub2j+zDi0nPpithtsUY1Dpoejvym/ago1QKTsn4Zg9aQyeSrYxd
        xeArjkdSEG25dqs2m13kfeVk
X-Google-Smtp-Source: APiQypK4YyulG/WyhZuIuIVx/PuP8Uwtt8Cr4PbMU4ZfcH0wHlRtrqBR/xYBP9BGpffVNQiVTtG4tA==
X-Received: by 2002:a17:90a:290f:: with SMTP id g15mr17028947pjd.93.1589125929067;
        Sun, 10 May 2020 08:52:09 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e91:c397:8daa:1f46:6608:df6c])
        by smtp.gmail.com with ESMTPSA id go21sm7772268pjb.45.2020.05.10.08.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 May 2020 08:52:08 -0700 (PDT)
Date:   Sun, 10 May 2020 21:21:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH RFC 1/8] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200510155159.GA27924@Mani-XPS-13-9360>
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-2-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588761371-9078-2-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On Wed, May 06, 2020 at 04:06:03PM +0530, Amit Singh Tomar wrote:
> At the moment, Driver uses bit fields to describe registers of the DMA
> descriptor structure that makes it less portable and maintainable, and
> Andre suugested(and even sketched important bits for it) to make use of
> array to describe this DMA descriptors instead. It gives the flexibility
> while extending support for other platform such as Actions S700.
> 
> This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> uses array to describe DMA descriptor.
> 

I'm in favor of getting rid of bitfields due to its not so defined way of
working (and forgive me for using it in first place) but I don't quite like
the current approach.

Rather I'd like to have custom bitmasks (S900/S700/S500?) for writing to those
fields.

Thanks,
Mani

> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
>  drivers/dma/owl-dma.c | 77 ++++++++++++++++++++++-----------------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index c683051257fd..b0d80a2fa383 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -120,30 +120,18 @@
>  #define BIT_FIELD(val, width, shift, newshift)	\
>  		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
>  
> -/**
> - * struct owl_dma_lli_hw - Hardware link list for dma transfer
> - * @next_lli: physical address of the next link list
> - * @saddr: source physical address
> - * @daddr: destination physical address
> - * @flen: frame length
> - * @fcnt: frame count
> - * @src_stride: source stride
> - * @dst_stride: destination stride
> - * @ctrla: dma_mode and linklist ctrl config
> - * @ctrlb: interrupt config
> - * @const_num: data for constant fill
> - */
> -struct owl_dma_lli_hw {
> -	u32	next_lli;
> -	u32	saddr;
> -	u32	daddr;
> -	u32	flen:20;
> -	u32	fcnt:12;
> -	u32	src_stride;
> -	u32	dst_stride;
> -	u32	ctrla;
> -	u32	ctrlb;
> -	u32	const_num;
> +/* Describe DMA descriptor, hardware link list for dma transfer */
> +enum owl_dmadesc_offsets {
> +	OWL_DMADESC_NEXT_LLI = 0,
> +	OWL_DMADESC_SADDR,
> +	OWL_DMADESC_DADDR,
> +	OWL_DMADESC_FLEN,
> +	OWL_DMADESC_SRC_STRIDE,
> +	OWL_DMADESC_DST_STRIDE,
> +	OWL_DMADESC_CTRLA,
> +	OWL_DMADESC_CTRLB,
> +	OWL_DMADESC_CONST_NUM,
> +	OWL_DMADESC_SIZE
>  };
>  
>  /**
> @@ -153,7 +141,7 @@ struct owl_dma_lli_hw {
>   * @node: node for txd's lli_list
>   */
>  struct owl_dma_lli {
> -	struct  owl_dma_lli_hw	hw;
> +	u32			hw[OWL_DMADESC_SIZE];
>  	dma_addr_t		phys;
>  	struct list_head	node;
>  };
> @@ -351,8 +339,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
>  		list_add_tail(&next->node, &txd->lli_list);
>  
>  	if (prev) {
> -		prev->hw.next_lli = next->phys;
> -		prev->hw.ctrla |= llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
> +		prev->hw[OWL_DMADESC_NEXT_LLI] = next->phys;
> +		prev->hw[OWL_DMADESC_CTRLA] |=
> +					llc_hw_ctrla(OWL_DMA_MODE_LME, 0);
>  	}
>  
>  	return next;
> @@ -365,8 +354,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  				  struct dma_slave_config *sconfig,
>  				  bool is_cyclic)
>  {
> -	struct owl_dma_lli_hw *hw = &lli->hw;
> -	u32 mode;
> +	u32 mode, ctrlb;
>  
>  	mode = OWL_DMA_MODE_PW(0);
>  
> @@ -407,22 +395,22 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  		return -EINVAL;
>  	}
>  
> -	hw->next_lli = 0; /* One link list by default */
> -	hw->saddr = src;
> -	hw->daddr = dst;
> -
> -	hw->fcnt = 1; /* Frame count fixed as 1 */
> -	hw->flen = len; /* Max frame length is 1MB */
> -	hw->src_stride = 0;
> -	hw->dst_stride = 0;
> -	hw->ctrla = llc_hw_ctrla(mode,
> -				 OWL_DMA_LLC_SAV_LOAD_NEXT |
> -				 OWL_DMA_LLC_DAV_LOAD_NEXT);
> +	lli->hw[OWL_DMADESC_CTRLA] = llc_hw_ctrla(mode,
> +						  OWL_DMA_LLC_SAV_LOAD_NEXT |
> +						  OWL_DMA_LLC_DAV_LOAD_NEXT);
>  
>  	if (is_cyclic)
> -		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
> +		ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_BLOCK);
>  	else
> -		hw->ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
> +		ctrlb = llc_hw_ctrlb(OWL_DMA_INTCTL_SUPER_BLOCK);
> +
> +	lli->hw[OWL_DMADESC_NEXT_LLI] = 0;
> +	lli->hw[OWL_DMADESC_SADDR] = src;
> +	lli->hw[OWL_DMADESC_DADDR] = dst;
> +	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
> +	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> +	lli->hw[OWL_DMADESC_FLEN] = len | 1 << 20;
> +	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
>  
>  	return 0;
>  }
> @@ -754,7 +742,8 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
>  			/* Start from the next active node */
>  			if (lli->phys == next_lli_phy) {
>  				list_for_each_entry(lli, &txd->lli_list, node)
> -					bytes += lli->hw.flen;
> +					bytes += lli->hw[OWL_DMADESC_FLEN] &
> +						 GENMASK(19, 0);
>  				break;
>  			}
>  		}
> @@ -785,7 +774,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
>  	if (vd) {
>  		txd = to_owl_txd(&vd->tx);
>  		list_for_each_entry(lli, &txd->lli_list, node)
> -			bytes += lli->hw.flen;
> +			bytes += lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
>  	} else {
>  		bytes = owl_dma_getbytes_chan(vchan);
>  	}
> -- 
> 2.7.4
> 
