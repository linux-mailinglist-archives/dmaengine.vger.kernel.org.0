Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A408950820B
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbiDTH1Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359794AbiDTH1F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 03:27:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BF83AA7A;
        Wed, 20 Apr 2022 00:23:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq30so1262093lfb.3;
        Wed, 20 Apr 2022 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlYu7CLCIlvnXgwdVuw5kR+o9QvGV69fVVvz2+18z50=;
        b=O6twioPQZQWwKv/SApo4FCXy5e0FOMwWPqz2EgXOU97Oa+vC9ucwQ6DuzrlLPb0pND
         jCsT6ighSy8ZHzRrzx11wrlfYx20R13ChzpEcK+Se253OlrluxkqwQsmu109pFtcaRM9
         6Ls5FfR1BT4z6XJ8xCNXa1w+hXsd72HOCnzvfvaz0uO0h9NVD6aa99YElNLhIR3LxVCk
         HO6BGO1WVquu5wRcyysbOM4Uul9DS7uO6Z8zPx4OuqOqoab3ivQ4h1XI5yiypi0MvT54
         OwZ44XmTosPr2sOfuQhaS8Jlfk6rsQEmZVrGe+WoZqSNyimSobdkdpB7sTY5vQWIC1M4
         LPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlYu7CLCIlvnXgwdVuw5kR+o9QvGV69fVVvz2+18z50=;
        b=jUJSyKiJB3C3OpWYqKonoS/hKARlQ6W5/sTBnMjm6DpsT5Glf1xRctrP9hUc7T5cid
         UQxY7iO1sVwP1vg7TTKaCIBpg/gF3Mswq/K75UaM02IhvPf1XKsmxGjfTo/ghoAYlMga
         HAC0TL3Nu3pU+d7okaYH6Nk4uk3oh8i9x72J2Wx31jq30rSacA0wlo+mwuXfgFoBQd2v
         dq5uOMXGOmxb9W1aRvef4WfeRTSu7KCUIJ7AcjPV2kgPEqgBc8OznjjJv7OOs0lE80iG
         0ng27e/Rp3lysS1i6ixMWRz+QXMiaX6p3jaJQKaQEFitlfltHnFqd9lq7o2LXo4KAYsf
         xqIg==
X-Gm-Message-State: AOAM533Ph4wAkXDMOBzIsXhflCiziKyS+TY8NMkBiboOv+cSsbTSSEFL
        9mMkE0Y5yFM5ZN8A58GWPbagprntiPZdvQ==
X-Google-Smtp-Source: ABdhPJy13qzctarAkZBPPDaNCw5SFMjZ4CUcwmXRG5Wlax7sGxTYRtaPCfHdedqOKaQRiX1FnZ6QeQ==
X-Received: by 2002:a05:6512:228e:b0:471:9022:c4d3 with SMTP id f14-20020a056512228e00b004719022c4d3mr9432310lfu.513.1650439428358;
        Wed, 20 Apr 2022 00:23:48 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512029200b00470db6bd345sm1178300lfp.270.2022.04.20.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:23:47 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:23:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v7 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI
 for chip specific flags
Message-ID: <20220420072345.vbni6gz5qazlwpqv@mobilestation>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
 <20220414233709.412275-9-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414233709.412275-9-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 14, 2022 at 06:37:08PM -0500, Frank Li wrote:
> DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
> allows only 32bit access to the DBI region.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v6 to v7
> - none
> Change from v5 to v6
> - use enum instead of define
> New patch at v5
> - fix kernel test robot build error

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
>  include/linux/dma/edma.h              |  2 ++
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 30f8bfe6e5712..b2b2cbe75fe4f 100644
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
> index 5232d3d198f88..85df746659c0d 100644
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
