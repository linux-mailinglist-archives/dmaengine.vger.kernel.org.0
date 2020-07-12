Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEDC21CA93
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2020 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgGLRLI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jul 2020 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgGLRLI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jul 2020 13:11:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D419C061794
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2020 10:11:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so4941579pgg.10
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2020 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igw9GVyJc+KlF33JTbERsix7Ehy8t85Hnf+jPnF/w8o=;
        b=clY5g1aQZUPDZ/vSlzPF599afT4jBIa5OIbLR3QPv+x18l7IYP33BludhEGcN/555C
         nc1iavAtbtIKMwIFiQtHm7pYIgMx/1j7CWd/12MbkV0Gp3gPV37XRiQl2HvVRt2sJK6B
         tP9+TT5pWm7ICVYH0LP9idhcWKr6u1Ti8Wml/olbjDzV1BjE2GNF3LvIbmUzgFRa/zYZ
         kBatqF9SgeTAbZbCbbWSr6AH5zHB96otkaxOfUJuH2JwvV/nTfTVicBBoNXJIcNN4gE0
         JUYxEhV3Nzc38Br98r0ktkrI9Zu/wHEd+o2h9lIDzCl2Z8AzaiBwNFdjoDYCuyXYAiAr
         1+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igw9GVyJc+KlF33JTbERsix7Ehy8t85Hnf+jPnF/w8o=;
        b=lRoB5L5PtGjla5C6CxrklsPmQkuKgoDRIgSmkHWH7uOvI30pLQjr0RyS0DVboKKiiq
         klroPj1Y1eR1RRVUX1FkTmPy7T4/RelsdPhD3+U0WC3Hsxf0j5hPKTMP/hQSF93R7GMt
         2smG8PMYhO4AKYx+unxy5kU7XMoLwkn5o79bW1hl1LBoDUvNVS0wN7eGd7aNBQi9vxxE
         S1LX4qH5YA53EFRjctZHwMC3lnh2hQC73wlgPGLapu8kNfgS6tH6gzDjmRct4DiB725j
         SFb4t0YnVrMH+BiKvbRH1hT+Pgprpp9iuDDW1qYlFgGk/FStphj9eUA9/kuW1PwNqgUH
         hADw==
X-Gm-Message-State: AOAM531/CYuoAtjYebZRFWVjUz2rveIWtoX1LvcRc5cEHsLkV4IJutDx
        dSl73U8RgHqpJrpPcfriEPn9
X-Google-Smtp-Source: ABdhPJxEme+SN0RD5XTVuwq4YqxKc83MjOpzMzYq4rR72d80EG4HSPCgC0B2mPmyMkJoV40Qn8Ga1A==
X-Received: by 2002:a63:5c55:: with SMTP id n21mr63123519pgm.27.1594573867172;
        Sun, 12 Jul 2020 10:11:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id mu17sm13231248pjb.53.2020.07.12.10.11.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:11:06 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:41:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, vkoul@kernel.org, afaerber@suse.de,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 02/10] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200712171100.GE6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-3-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-3-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:48PM +0530, Amit Singh Tomar wrote:
> At the moment, Driver uses bit fields to describe registers of the DMA
> descriptor structure that makes it less portable and maintainable, and
> Andre suugested(and even sketched important bits for it) to make use of
> array to describe this DMA descriptors instead. It gives the flexibility
> while extending support for other platform such as Actions S700.
> 
> This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> uses array to describe DMA descriptor.
> 
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes since v4:
> 	* Reordered it from 01/10 to 02/10.
> Changes since v3:
>         * Added description for enum fields.
>         * Restored the old comment.
>         * Added detailed comment about, the way FLEN
>           and FCNT values are filled.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * Defined macro for frame count value.
>         * Introduced llc_hw_flen() from patch 2/9.
>         * Removed the unnecessary line break.
> Changes since rfc:
>         * No change.
> ---
>  drivers/dma/owl-dma.c | 98 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 66ef70b00ec0..948d1bead860 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -120,30 +120,33 @@
>  #define BIT_FIELD(val, width, shift, newshift)	\
>  		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
>  
> +/* Frame count value is fixed as 1 */
> +#define FCNT_VAL				0x1
> +
>  /**
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
> + * owl_dmadesc_offsets - Describe DMA descriptor, hardware link
> + * list for dma transfer
> + * @OWL_DMADESC_NEXT_LLI: physical address of the next link list
> + * @OWL_DMADESC_SADDR: source physical address
> + * @OWL_DMADESC_DADDR: destination physical address
> + * @OWL_DMADESC_FLEN: frame length
> + * @OWL_DMADESC_SRC_STRIDE: source stride
> + * @OWL_DMADESC_DST_STRIDE: destination stride
> + * @OWL_DMADESC_CTRLA: dma_mode and linklist ctrl config
> + * @OWL_DMADESC_CTRLB: interrupt config
> + * @OWL_DMADESC_CONST_NUM: data for constant fill
>   */
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
> @@ -153,7 +156,7 @@ struct owl_dma_lli_hw {
>   * @node: node for txd's lli_list
>   */
>  struct owl_dma_lli {
> -	struct  owl_dma_lli_hw	hw;
> +	u32			hw[OWL_DMADESC_SIZE];
>  	dma_addr_t		phys;
>  	struct list_head	node;
>  };
> @@ -318,6 +321,11 @@ static inline u32 llc_hw_ctrlb(u32 int_ctl)
>  	return ctl;
>  }
>  
> +static u32 llc_hw_flen(struct owl_dma_lli *lli)
> +{
> +	return lli->hw[OWL_DMADESC_FLEN] & GENMASK(19, 0);
> +}
> +
>  static void owl_dma_free_lli(struct owl_dma *od,
>  			     struct owl_dma_lli *lli)
>  {
> @@ -349,8 +357,9 @@ static struct owl_dma_lli *owl_dma_add_lli(struct owl_dma_txd *txd,
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
> @@ -363,8 +372,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  				  struct dma_slave_config *sconfig,
>  				  bool is_cyclic)
>  {
> -	struct owl_dma_lli_hw *hw = &lli->hw;
> -	u32 mode;
> +	u32 mode, ctrlb;
>  
>  	mode = OWL_DMA_MODE_PW(0);
>  
> @@ -405,22 +413,28 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
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
> +	lli->hw[OWL_DMADESC_NEXT_LLI] = 0; /* One link list by default */
> +	lli->hw[OWL_DMADESC_SADDR] = src;
> +	lli->hw[OWL_DMADESC_DADDR] = dst;
> +	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
> +	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> +	/*
> +	 * Word starts from offset 0xC is shared between frame length
> +	 * (max frame length is 1MB) and frame count, where first 20
> +	 * bits are for frame length and rest of 12 bits are for frame
> +	 * count.
> +	 */
> +	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
> +	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
>  
>  	return 0;
>  }
> @@ -752,7 +766,7 @@ static u32 owl_dma_getbytes_chan(struct owl_dma_vchan *vchan)
>  			/* Start from the next active node */
>  			if (lli->phys == next_lli_phy) {
>  				list_for_each_entry(lli, &txd->lli_list, node)
> -					bytes += lli->hw.flen;
> +					bytes += llc_hw_flen(lli);
>  				break;
>  			}
>  		}
> @@ -783,7 +797,7 @@ static enum dma_status owl_dma_tx_status(struct dma_chan *chan,
>  	if (vd) {
>  		txd = to_owl_txd(&vd->tx);
>  		list_for_each_entry(lli, &txd->lli_list, node)
> -			bytes += lli->hw.flen;
> +			bytes += llc_hw_flen(lli);
>  	} else {
>  		bytes = owl_dma_getbytes_chan(vchan);
>  	}
> -- 
> 2.7.4
> 
