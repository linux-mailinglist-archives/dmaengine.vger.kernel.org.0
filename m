Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F24FF344
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiDMJWv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiDMJW1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 05:22:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D624630F71;
        Wed, 13 Apr 2022 02:20:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c15so1403068ljr.9;
        Wed, 13 Apr 2022 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/4zVYAHyGyGtCNqOb63ZwPnLj2YzivcL6eNa5YDJEw=;
        b=CJV/ya2sre81JQ+0JH3xwSYP3QLHfE1UdwsEo/zSkaEe3XFZ+ETCMZNx7fz1zo86lc
         g5ZCFShAeKfHERax+ipw52N5gVXuAhbgVSXDW1E2CyARCsAnB8Cz8ku38dVg7HrrP05B
         EAZvdz9oN3RcN9RBG1k1RR2KP5l0vRrqfh/wEjdhXTbT/Y86uPKPGVXLVIi60tP5qME5
         0jIUDAUPjxkHpqLXuyi0j/29UtXD0IskMzIqSZPUTMBjySLGrpcwENR5bDZXKm4GF7vK
         fi3NMBNSzEGb8BZ+k59AkC13WgTlhWpZu8heteDc8k+SIuu0ZgVZt6nu7QGjLvSzENhd
         x+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/4zVYAHyGyGtCNqOb63ZwPnLj2YzivcL6eNa5YDJEw=;
        b=NSb7OSFQvydLJBnO2NWwjrGiXkSIMZMxemxlTmUC/BT1WbbID32Coklflwcc0p1he8
         38zY/mfQaHqpIcMORqAkSsEthWmZTIfhw0nQoEZ55n81vNwtqjbNRzVv31+xuDnHvP+j
         qoWiMXK3CRsRE5Uwlmu+/WXcZHtCt9xuZUEmK8SyLYs97qOP7gmwwBOGMEM/nXjtJ6vs
         uiV7D/BByi42hrCtrtJRf//ANE7V0jNO8UQmgyvFyhPqp6wuF7V/UBJYJz1ayFLsmeP3
         wfukig996t1XUt8v3ensgI+dn0mesb6I0S2TMSTt8o71ehafFs9aXLo7yK0F9r7cmPo4
         6Ptw==
X-Gm-Message-State: AOAM532To9bEgp3Uslw5PpnmD8vf+TO4e+KllQE68TKYx7U5P1EYvU/7
        lIGqlftto6iEbl9VnD5E4fA=
X-Google-Smtp-Source: ABdhPJxyrFLDX04srfNYu1YpPGsjA0u6fLZB8ZpFXMtLiMX9PMAiPC9lh/U8OLymyN705QJH/nU2TA==
X-Received: by 2002:a2e:90d6:0:b0:246:e44:bcf6 with SMTP id o22-20020a2e90d6000000b002460e44bcf6mr25263266ljg.501.1649841603512;
        Wed, 13 Apr 2022 02:20:03 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id j4-20020a05651231c400b0044ac20061ecsm4046740lfe.128.2022.04.13.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:20:03 -0700 (PDT)
Date:   Wed, 13 Apr 2022 12:20:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v6 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI
 for chip specific flags
Message-ID: <20220413092001.cvcuvt3whe7bclg4@mobilestation>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
 <20220406152347.85908-9-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406152347.85908-9-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 06, 2022 at 10:23:46AM -0500, Frank Li wrote:
> DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
> allows only 32bit access to the DBI region.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
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
> index bec444e2939b2..dc353a33a4a25 100644
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

Please see my comment to "[PATCH v6 7/9] dmaengine: dw-edma: Add
support for chip specific flags" regarding the anonymous enumeration
here.

-Sergey

>  };
>  
>  /**
> -- 
> 2.35.1
> 
