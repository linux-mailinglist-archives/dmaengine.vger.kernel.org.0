Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401154D41FB
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 08:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiCJHpO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 02:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiCJHpN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 02:45:13 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0F12E768
        for <dmaengine@vger.kernel.org>; Wed,  9 Mar 2022 23:44:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id p8so4412520pfh.8
        for <dmaengine@vger.kernel.org>; Wed, 09 Mar 2022 23:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mA64enYxLq3zseRQ+2fYx/3wapRLhJpfmGCU7piIK+8=;
        b=yEzG/0SaB4eSq2xrhup4aaW8cXddpTUWeaGsTSwpQFzXFOW9S2BMjJpODdQGZXoaQt
         2tbor+p3e+JPabvaDVtARaIXl6qrrtvRG6OaKcBfkHz4OZLO1FHGAPSmLAXdpe+aBDMJ
         h2qa2iSskNsFiQ4Qibc89igbXV/AcrpnjYJqL3NowuzG7a1iEaveCJHr516Bi+ZUbXxC
         1fKabhq1ZipzoXc0gXK9Rj/O08cgin341V86yBJSJv2Bsc7+mUB+e8iRISqseexu7MoK
         qGQhuRc3zWaWgxP3bwIL0ps1Vpbxezyoq7gxOEFR7ieb/d37Gqu6FaUbw1kPctxOuzIZ
         seFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mA64enYxLq3zseRQ+2fYx/3wapRLhJpfmGCU7piIK+8=;
        b=t1aHVrk6N6xMXRj4jOUvNIbezhV+2W4ulnl7NZxZYERD8s45SuUlGW5KBXMsZOGa2v
         uv4G1NmOkOS4mAPDZMawzVTI7Z8C05t4R/kE8xckCSvhdJWSAzW9jieNrWXqfm6Cwcn/
         /AF7YFkrC3RpcMRi88YN4TrGXHi6QkTNrhN+bYA51q0wDL8YC3ovG1yoCTpG8f+IF8Hr
         xBzyrBZEvNCf0YgztsSnbqM1SUggZuX8sZQWFYtmsYOXR/TG4TMdAp3ngGUyxfSyl+TW
         KqU2GO6AaxXq3C6eYcnxFaup/bh9LXhIhOdBFOvKBAUTmcSL/q9L3UCArNWfIsgghB7j
         SQNg==
X-Gm-Message-State: AOAM532FU9Fxaldmlcw49IpQ8rPpmrpHg/qydUOdkZmVLrmyecezOHio
        UwEUyhZo6/+8gx5mtAwx/tHC
X-Google-Smtp-Source: ABdhPJwj2IJydq3SbqiuB/7BgQi2xWyWjJdouCR8fz/bpZWq27WuG6G69HmLuerG4sIe3TD4JnwMLg==
X-Received: by 2002:a05:6a00:2485:b0:4f7:37cd:d040 with SMTP id c5-20020a056a00248500b004f737cdd040mr3655431pfv.55.1646898247634;
        Wed, 09 Mar 2022 23:44:07 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090a02d700b001bf6ef9daafsm4968622pjd.38.2022.03.09.23.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 23:44:07 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:14:00 +0530
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
Message-ID: <20220310074400.GC4869@thinkpad>
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

On Mon, Mar 07, 2022 at 04:47:49PM -0600, Frank Li wrote:
> Allow PCI EP probe DMA locally and prevent use of remote MSI
> to remote PCI host.
> 
> Add option to force 32bit DBI register access even on
> 64-bit systems. i.MX8 hardware only allowed 32bit register
> access.
> 
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

How about using an enum for defining the flags? This would help us organize the
flags in a more coherent way and also will give the benefit of kdoc.

/**
 * enum dw_edma_chip_flags - Flags specific to an eDMA chip
 * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
 * @DW_EDMA_CHIP_32BIT_DBI:	eDMA only supports 32bit DBI access
 */
enum dw_edma_chip_flags {
	DW_EDMA_CHIP_LOCAL = BIT(0),
	DW_EDMA_CHIP_32BIT_DBI = BIT(1),
};

>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -40,6 +46,8 @@ enum dw_edma_map_format {
>   * @nr_irqs:		 total dma irq number
>   * reg64bit		 if support 64bit write to register
>   * @ops			 DMA channel to IRQ number mapping
> + * @flags		 - DW_EDMA_CHIP_LOCAL
> + *			 - DW_EDMA_CHIP_32BIT_DBI

No need to mention the flags here if you use the enum I suggested above.

>   * @wr_ch_cnt		 DMA write channel number
>   * @rd_ch_cnt		 DMA read channel number
>   * @rg_region		 DMA register region
> @@ -53,6 +61,7 @@ struct dw_edma_chip {
>  	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
> +	u32			flags;

	enum dw_edma_chip_flags	flags;

Thanks,
Mani

>  
>  	void __iomem		*reg_base;
>  
> -- 
> 2.24.0.rc1
> 
