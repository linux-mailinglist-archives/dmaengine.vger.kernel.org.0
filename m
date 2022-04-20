Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53CE5081E2
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 09:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbiDTHVd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 03:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359633AbiDTHV3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 03:21:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180E3AA61;
        Wed, 20 Apr 2022 00:18:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so1203580lfa.10;
        Wed, 20 Apr 2022 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qGPhATCxDg9uurm0fD/+a8NJaWF54v6kljsE0gjCGzA=;
        b=HuTN9TbvTNvYkh9LNymRymhZFeryXJ9lyPRocvdr48vOuje061GLPgPUrF8aeJmq4A
         C84eLMJpVMkPQnr7DfU8dSwvurPLqYyw6qxjLNg8LSLAEuSa26TGpKFFyh+T4fj4R/RK
         pPmFt1Z4psT4wZo2k/SwBErhZreeL6zG2VZCBCXu/XzrTot/SNGnqou+NHuZ/dnx0Yr5
         zFISaXFwkiju11aocEOxBvSe6VmeOKWtUVe2Mk71wYkCXN5HMqwv1sP50L3q38stEICp
         AeKbmdlQYH95iDLa5s7b18+L8VFUI8BRBZqIGisvxmWD0BLsSbgHNCDRISkDH3hq2GDA
         eBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGPhATCxDg9uurm0fD/+a8NJaWF54v6kljsE0gjCGzA=;
        b=7oOuTdsZAkrK16zq/s/XcVq81iCWL9mo6X7ZZZiC3MqrudhXhM3osJJZW9Zay2LGiG
         WGDY2zAvcHOFnxNw3VhYiBV4XdXp4wsjy78VcngotuCUt0iXYMfVq2ge2dzEcxFUH92i
         rb14qmsyJhVXRfy+2EZYKGp/OBlxlnBons7Nbb2yovZ1kPfGIngJhlPoWKuv3ndBthuQ
         /Bqu1+aVPmCAZop9JGbrvqxmAYhHr9/gk0nwL1IBGa/Uryxofhccb2iRZMaDmZUEsTKg
         ycSTq/pz5u1/T8sq1DaVoSRhCqTg6DquUpJOz7B9Iqa7Kt1TnCljhoU3j9P3rKYJfW+7
         ri/g==
X-Gm-Message-State: AOAM532to7cLkLxRSh1QaOYpGQK9vQSuSG7OGjrPIN4RmaMskTI1MW2G
        1rUppxdLNDoD9SVhr9jZyKI=
X-Google-Smtp-Source: ABdhPJyyBhiu2FlLDUG6ysrGERISCFQEEhalzgao7Ao06KmLaFrjWqQGIbcB7UG9W+dkg+RRAVJWwg==
X-Received: by 2002:a05:6512:128a:b0:471:b3fa:221c with SMTP id u10-20020a056512128a00b00471b3fa221cmr2953203lfs.169.1650439119003;
        Wed, 20 Apr 2022 00:18:39 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm1730905lfb.302.2022.04.20.00.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:18:38 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:18:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v7 7/9] dmaengine: dw-edma: Add support for chip specific
 flags
Message-ID: <20220420071836.fawjwhhmmse5v3v6@mobilestation>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
 <20220414233709.412275-8-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414233709.412275-8-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 14, 2022 at 06:37:07PM -0500, Frank Li wrote:
> Add a "flags" field to the "struct dw_edma_chip" so that the controller
> drivers can pass flags that are relevant to the platform.
> 
> DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
> locally. Local eDMA access doesn't require generating MSIs to the remote.

Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
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
> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  9 ++++++---
>  include/linux/dma/edma.h              | 10 ++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 8ddc537d11fd6..30f8bfe6e5712 100644
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
> index c2039246fc08c..5232d3d198f88 100644
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
> + * #flags		 dw_edma_chip_flags
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
