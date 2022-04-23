Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0C50C9D3
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiDWMRT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiDWMRS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 08:17:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF106229EEA
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:14:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g9so9461558pgc.10
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJj7CRzeQgE5tU5JZGymolaecplxB4hWP4O6I045pqI=;
        b=rc2SJEkpHSb6uBkYOelbKAcnEqdrj8wpDnrU2+3Kfoy2B/lQAZ6aopjx4po7+0lNYE
         BtEq66ekhn9nH0l3YoeU2x+HDXsNzaCqUy51nGRciYtFOFw6U2vjM45eG2VmNiF9MLWg
         nWOeljcV/bze/cTa4Yh4RYy+rdlhUlpkMVG2f+ASFQmx0KBragR05NLgI3N/8NaqSgFX
         /J+hMYuErSzxOZ0772vsWN/4vPL9f9puv6saH/5H1dvqaogrsky6Hak6OuOyRGL7QUxp
         C+fonwaimTMScZjZG8t+myTPv5HkMxxAzguHP1uknfT0nptWCzEQp+8AhLYpCBRRcUW3
         277Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJj7CRzeQgE5tU5JZGymolaecplxB4hWP4O6I045pqI=;
        b=dzfRBsJiMC4JNq1fcexMFaOwKpfF+ZsB+DudR6Uj93aUDUcKHXdcvuimXgFgLnI8ng
         xD56GeNhXpPP7yzbOpIo2rvh3k3X+aBW0SkMZ/nR500zEYDoM+2UsepzgjWp3vU2jmQF
         ZbT6e3aV1pFsW9VI72zkBuKlmf2CSyfzEeGWqwjUg5V0fZfHkmD0FcTZQxYLhF1o9I4n
         CUxUfXs8NhnKB4bbJKGvSTYxgZYyp7Ubwp9oCrP0EFNUCOMQjEdiwojM3WaJpHnuAn9f
         WL7lXrNvXR4xRNZVDwQkQwKBAScFIoIWASeqUmv1a2MfWjRUrLhvW3NsPsufacOn5g6J
         Xu7Q==
X-Gm-Message-State: AOAM533iGYfPRhs8ILDUlH7jXHuc2RjAYGlyd95yKGszuhi3p5F4loYK
        yafugPrsdwfIFK43D+7ncSU6QOmsOo1p
X-Google-Smtp-Source: ABdhPJyarlF3Uxl8Gs20s4rXeUO6b/id05Lpnny73hQNPTL59D01YXVMe9z5gWNEiuDkVfvrB2bxhQ==
X-Received: by 2002:a05:6a00:2186:b0:4f7:5544:1cc9 with SMTP id h6-20020a056a00218600b004f755441cc9mr9557217pfi.62.1650716061434;
        Sat, 23 Apr 2022 05:14:21 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm6351128pfh.143.2022.04.23.05.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:14:20 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:44:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 7/9] dmaengine: dw-edma: Add support for chip specific
 flags
Message-ID: <20220423121413.GH374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-8-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-8-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:41AM -0500, Frank Li wrote:
> Add a "flags" field to the "struct dw_edma_chip" so that the controller
> drivers can pass flags that are relevant to the platform.
> 
> DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
> locally. Local eDMA access doesn't require generating MSIs to the remote.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Change from v7 to v9
>  -none
> Change from v6 to v7
>  - dw_edma_chip_flags to u32
> Change from v5 to v6
>  - use enum instead of define
> 
> Change from v4 to v5
>  - split two two patch
>  - rework commit message
> Change from v3 to v4
> none
> Change from v2 to v3
>  - rework commit message
>  - Change to DW_EDMA_CHIP_32BIT_DBI
>  - using DW_EDMA_CHIP_LOCAL control msi
>  - Apply Bjorn's comments,
>         if (!j) {
>                control |= DW_EDMA_V0_LIE;
>                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
>                                control |= DW_EDMA_V0_RIE;
>         }
> 
>         if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
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
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  9 ++++++---
>  include/linux/dma/edma.h              | 10 ++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index c59e23b9f9fdb..2ab1059a3de1e 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
>  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> +	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma_v0_lli __iomem *lli;
>  	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control = 0, i = 0;
> @@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	j = chunk->bursts_alloc;
>  	list_for_each_entry(child, &chunk->burst->list, list) {
>  		j--;
> -		if (!j)
> -			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> -
> +		if (!j) {
> +			control |= DW_EDMA_V0_LIE;
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +				control |= DW_EDMA_V0_RIE;
> +		}
>  		/* Channel control */
>  		SET_LL_32(&lli[i].control, control);
>  		/* Transfer size */
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index c2039246fc08c..fbd05a7284934 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -33,12 +33,21 @@ enum dw_edma_map_format {
>  	EDMA_MF_HDMA_COMPAT = 0x5
>  };
>  
> +/**
> + * enum dw_edma_chip_flags - Flags specific to an eDMA chip
> + * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> + */
> +enum dw_edma_chip_flags {
> +	DW_EDMA_CHIP_LOCAL	= BIT(0),
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
> + * @flags		 dw_edma_chip_flags
>   * @reg_base		 DMA register base address
>   * @ll_wr_cnt		 DMA write link list number
>   * @ll_rd_cnt		 DMA read link list number
> @@ -53,6 +62,7 @@ struct dw_edma_chip {
>  	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
> +	u32			flags;
>  
>  	void __iomem		*reg_base;
>  
> -- 
> 2.35.1
> 
