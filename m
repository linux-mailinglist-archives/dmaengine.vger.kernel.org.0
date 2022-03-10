Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A14C4D4212
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 08:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiCJH4s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 02:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiCJH4r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 02:56:47 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD2132964
        for <dmaengine@vger.kernel.org>; Wed,  9 Mar 2022 23:55:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q19so4064329pgm.6
        for <dmaengine@vger.kernel.org>; Wed, 09 Mar 2022 23:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OQBsjCcejQbyJJGyzapc2EGUZYnB0tQO4FtR1E/5QlY=;
        b=GhQ4NDFBdbHmPzn70Bbfq/QEou1xcdng/QxmvueRqE+ox1zfZRwlsNcWZomP1sfJ9U
         NWMWYoLmGWHiSPvhCUSrq37wrrj3fXrXYpz1odZrGMpEvGHQDBWPWnH8GJKRIqJxqbzm
         LkpSwuwaRvzQyLB08TThzFcP7WojEAgMLzFauCbmA9sSM2esuaJ/UokAXQpin0hzrZx/
         LPPKLrySfBObDXrDVzjmi1ggAO30dOUKzrmAL/QrMxn/DmDofvNctwTB+QOJfzxe8ffj
         JCg6cZImb9IGyyAQfzezdSF3uBJy22fE7383I5h2gwJ+6t5n0P2DlbJkc9DMHafmgt2b
         2bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQBsjCcejQbyJJGyzapc2EGUZYnB0tQO4FtR1E/5QlY=;
        b=QsfaLZqzTjCOhxND5J40JQ5/jplZvi+oU10DRWKIFOtVUlpFHdq8AdcY8RkKLFhwVG
         Y8KpKQAKgLH5nY7tZ7nbORarB1t9NNP1I2UvMvJhoi4by4iGVwLcmvl7HuRcPf59IK7G
         QeCzxBoA+YzFxjxgY+4LuVLXRP4LUxpV2QiaS7R6PnKpQvqvXgoJDa1tcqqaPYp4WnHe
         YbojzqxBnM6oE+7Jpbp1hZDEr3jmkg8Bn9cYeX6ePVMfK2+KL2VcK2GsxKcfEj3+c+SB
         kXu+E7Z6U5Z+PBCqsX/KdE79HLLiv/N2v/eBFAJk3A4m8bf0Bua+XNTkFi1wJTbD87b3
         w1cw==
X-Gm-Message-State: AOAM530ebXKjg+MvyAm/+ziHxXnFoc3GHnpGh/9Luf8pzhV9uD8riOfg
        JoQ15IgaapceGkJPz7osNyJL
X-Google-Smtp-Source: ABdhPJyi2jrr7yFXTP9/Gv1viZ6ABjSTsWguBqXmbav4mBYvPbfBOFr2FipuQHbHhZiMUfIeNSLRGg==
X-Received: by 2002:a05:6a00:16ce:b0:4ce:118f:8e4f with SMTP id l14-20020a056a0016ce00b004ce118f8e4fmr3800334pfc.56.1646898946452;
        Wed, 09 Mar 2022 23:55:46 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id t1-20020a634441000000b00372cb183243sm4812028pgk.1.2022.03.09.23.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 23:55:46 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:25:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 5/6] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220310075539.GD4869@thinkpad>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220307224750.18055-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307224750.18055-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Subject could be:

dmaengine: dw-edma: Add support for chip specific flags

On Mon, Mar 07, 2022 at 04:47:49PM -0600, Frank Li wrote:
> Allow PCI EP probe DMA locally and prevent use of remote MSI
> to remote PCI host.
> 
> Add option to force 32bit DBI register access even on
> 64-bit systems. i.MX8 hardware only allowed 32bit register
> access.
> 

Add a "flags" field to the "struct dw_edma_chip" so that the controller drivers
can pass flags that are relevant to the platform. Currently 2 flags are
defined:

1. DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA locally.
Local eDMA access doesn't require generating MSIs to the remote.

2. DW_EDMA_CHIP_32BIT_DBI - Used by the controller drivers like i.MX8 that
allows only 32bit access to the DBI region.

Thanks,
Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Resend added dmaengine@vger.kernel.org
> 
> Change from v2 to v3
>  - rework commit message
>  - Change to DW_EDMA_CHIP_32BIT_DBI
>  - using DW_EDMA_CHIP_LOCAL control msi
>  - Apply Bjorn's comments, 
> 	if (!j) {
>                control |= DW_EDMA_V0_LIE;
>                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
>                                control |= DW_EDMA_V0_RIE;
>         }
> 
> 	if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
>               !IS_ENABLED(CONFIG_64BIT)) {
>           SET_CH_32(...);
>           SET_CH_32(...);
>        } else {
>           SET_CH_64(...);
>        }
> 
> 
> Change from v1 to v2
> - none
> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
>  include/linux/dma/edma.h              |  9 +++++++++
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 6e2f83e31a03a..081cd7997348d 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -307,6 +307,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
>  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> +	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma_v0_lli __iomem *lli;
>  	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control = 0, i = 0;
> @@ -320,9 +321,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	j = chunk->bursts_alloc;
>  	list_for_each_entry(child, &chunk->burst->list, list) {
>  		j--;
> -		if (!j)
> -			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> -
> +		if (!j) {
> +			control |= DW_EDMA_V0_LIE;
> +			if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> +				control |= DW_EDMA_V0_RIE;
> +		}
>  		/* Channel control */
>  		SET_LL_32(&lli[i].control, control);
>  		/* Transfer size */
> @@ -420,15 +423,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
> -		#ifdef CONFIG_64BIT
> -			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> -				  chunk->ll_region.paddr);
> -		#else /* CONFIG_64BIT */
> +		if ((chan->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> +		    !IS_ENABLED(CONFIG_64BIT)) {
>  			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
>  				  lower_32_bits(chunk->ll_region.paddr));
>  			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
>  				  upper_32_bits(chunk->ll_region.paddr));
> -		#endif /* CONFIG_64BIT */
> +		} else {
> +			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> +				  chunk->ll_region.paddr);
> +		}
>  	}
>  	/* Doorbell */
>  	SET_RW_32(chip, chan->dir, doorbell,
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index fcfbc0f47f83d..4321f6378ef66 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -33,6 +33,12 @@ enum dw_edma_map_format {
>  	EDMA_MF_HDMA_COMPAT = 0x5
>  };
>  
> +/* Probe EDMA engine locally and prevent generate MSI to host side*/
> +#define DW_EDMA_CHIP_LOCAL	BIT(0)
> +
> +/* Only support 32bit DBI register access */
> +#define DW_EDMA_CHIP_32BIT_DBI	BIT(1)
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -40,6 +46,8 @@ enum dw_edma_map_format {
>   * @nr_irqs:		 total dma irq number
>   * reg64bit		 if support 64bit write to register
>   * @ops			 DMA channel to IRQ number mapping
> + * @flags		 - DW_EDMA_CHIP_LOCAL
> + *			 - DW_EDMA_CHIP_32BIT_DBI
>   * @wr_ch_cnt		 DMA write channel number
>   * @rd_ch_cnt		 DMA read channel number
>   * @rg_region		 DMA register region
> @@ -53,6 +61,7 @@ struct dw_edma_chip {
>  	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
> +	u32			flags;
>  
>  	void __iomem		*reg_base;
>  
> -- 
> 2.24.0.rc1
> 
