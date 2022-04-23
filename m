Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4C50C9D8
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 14:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiDWMTa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 08:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiDWMT3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 08:19:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B97C174
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:16:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h12so12894021plf.12
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HwSk2H4dqscLgH2eo3OjcJBSCbVMhC1aUnugP3Fxxio=;
        b=BtJH0mf9eROjuYoiJ4iblRUcYQ86uqqqJIaDXjlvbvt5rpu0QBIojQtmtVxYdM7skB
         sbEPEi5w7fUjKdR5NF+mDfcMorHibzfgpaFdza5zLhRB1qNy0jnDJdZBG4FdePTat1qK
         kVk6/1HXFqFXNk7bYQynO4Xhg/cpFhywp+3bCAhEluGX+k0AXzhMXNBjjunAa9WZe849
         dfmw7uEyYRlDBhesGDphr5x1McyEkEZjcvNrhUV6+gk7FB+Ii6awLOJIYlWnJPjuJi8g
         DruJRjpCoCoQ/OaR+m88XtkYXBBRNev+QfytC/VaJCYH84zbuWHqd44hymfKlk4DcA13
         3xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwSk2H4dqscLgH2eo3OjcJBSCbVMhC1aUnugP3Fxxio=;
        b=NCoQ2ugyP4zpmEFkVcBcuPWEjVJ3N/D+poI4Coji1lPnY4eGXYXDVv0nsk40pEsm2k
         bzfI9K4kRb0Q+Ouaj3GzutqB6ylTaUkrJCr70T44BBas6VMzn0YTk3McqqTvKXDj7AFe
         BSMckQL7hPPWBGbcIxRLUAktTNXBMNmdP6OrRQ1R7/tgBPg2hh+UiW43uFX5wpxueVMS
         O7Bhvi4lQdE+jQcffUwSqoJf/+vhi0HdnGI5pbgaEB/Zq8bH0gdPkgGprkWSRe5SRtsx
         I1Y2vHY8cqfClAWauj2xCL4ME7U9TbOjk/MK56KD6s7HdRjCZjSzGglBLXa3Yre2tm0y
         b7IQ==
X-Gm-Message-State: AOAM5316KHyXsLjcOseGE82b+7MTdnbr1geDngoHicRDsxvnwDx/f8C6
        G6G9mdlMCNWfROsxN07U/X5G
X-Google-Smtp-Source: ABdhPJxVnmX3el4cwNBzL70Fx+vyfLhhc5Gi3700HjEkUiZ41AmoIxi/1/Qv1cG0cDK0NRHRBhr2iQ==
X-Received: by 2002:a17:90a:8c09:b0:1cb:97a2:3d5f with SMTP id a9-20020a17090a8c0900b001cb97a23d5fmr10432358pjo.108.1650716192518;
        Sat, 23 Apr 2022 05:16:32 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm6235886pfl.148.2022.04.23.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:16:31 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:46:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI
 for chip specific flags
Message-ID: <20220423121624.GI374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-9-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-9-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:42AM -0500, Frank Li wrote:
> DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
> allows only 32bit access to the DBI region.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> Change from v6 to v9
> - none
> Change from v5 to v6
> - use enum instead of define
> New patch at v5
> - fix kernel test robot build error
> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
>  include/linux/dma/edma.h              |  2 ++
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 2ab1059a3de1e..2d3f74ccc340a 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -417,15 +417,18 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
> -		#ifdef CONFIG_64BIT
> -			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> -				  chunk->ll_region.paddr);
> -		#else /* CONFIG_64BIT */
> +		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> +		    !IS_ENABLED(CONFIG_64BIT)) {
>  			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>  				  lower_32_bits(chunk->ll_region.paddr));
>  			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  				  upper_32_bits(chunk->ll_region.paddr));
> -		#endif /* CONFIG_64BIT */
> +		} else {
> +		#ifdef CONFIG_64BIT
> +			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> +				  chunk->ll_region.paddr);
> +		#endif
> +		}
>  	}
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index fbd05a7284934..8b134896c9edb 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -36,9 +36,11 @@ enum dw_edma_map_format {
>  /**
>   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
>   * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> + * @DW_EDMA_CHIP_32BIT_DBI	Only support 32bit DBI register access
>   */
>  enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> +	DW_EDMA_CHIP_32BIT_DBI	= BIT(1),
>  };
>  
>  /**
> -- 
> 2.35.1
> 
