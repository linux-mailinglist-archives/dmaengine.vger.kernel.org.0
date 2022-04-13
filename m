Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD644FF33E
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiDMJVC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 05:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMJVB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 05:21:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197D52B00;
        Wed, 13 Apr 2022 02:18:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h11so1426420ljb.2;
        Wed, 13 Apr 2022 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/WvyXghWmZtYDEh5YM4qmhOcuu61Zjd+f2xXSl/GwE=;
        b=UaPhTUnm9y77HEgyzilknUAhjjV3PzLWtlcU45K3E7a6MYhHDMI91wDDDia/yZ9NF5
         KwFEXnmTjg6O/TgBEKXOkK3nPvSkXkWhaC0S2ndEZN8K3xGkhg2zvTwV32iAXCDIFOr5
         /8bcxePQXTaGd2cKHHM8TaFV8MJTtQPNP3ygGcQxfsEhp8w5Blt+qLNar4WF/JxvPcP7
         td/kXV3TyHyF2+6hePNadvSs93w2zvzsCE0EqzEplzQLFOZYaxWb02kICALvZno5n4G9
         G/5/EJx+yHLcyxDYAQ+RM+6WGfI+jpGRMknDVzqr9G23zauQ0+Uwx0FI0lXgpuwzHaqU
         uFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/WvyXghWmZtYDEh5YM4qmhOcuu61Zjd+f2xXSl/GwE=;
        b=KgkU447ipF/yCjOwMQ33xl6DJpRdklLPS9ToaW8yhMawUrnGKPP6YtkagiBdjraxS9
         E4A4Ym4xT6ssmxkM8EjGeDwFScUr4YuzwHl+K1gj5S0bF5XQGbbAlJM4Bi9abMdaEBr5
         D8XlsPabn4C2xhy2rYR8tRU7qZKCnMOhis+dDynhIsp2uf3CDnTgPkiMwRghNs46yVrz
         pPCPh+ORzfrGcT8QfppFXyMgc0v0SKRt+eYdZwyjZmFhLwQdgYW/WoImXKVrOXufy9yL
         QPMoIdSssHVPxjlrvxczFhp/vmGO6ihif//5Dqqka7nasoX06cbfz2UDUXddFcrn2VIQ
         DOew==
X-Gm-Message-State: AOAM5334pmRT3ULQha1V8vXgLPNTgBGT4k/2ZbfbCNYuKINlQLapqcRv
        tt5Rfnh2ysqqCEURqAJJP1A=
X-Google-Smtp-Source: ABdhPJycKp0P5ZaBkvKz+8Zlnv+Re3fv5BV+GV3MRpOT7Z+WQiLTSLnwTKTbHbp31ZCo6Vzl4qzRBw==
X-Received: by 2002:a05:651c:b12:b0:24b:1338:1416 with SMTP id b18-20020a05651c0b1200b0024b13381416mr26386234ljr.92.1649841519509;
        Wed, 13 Apr 2022 02:18:39 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id p20-20020a19f114000000b0046ba6a43d57sm1032404lfh.87.2022.04.13.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:18:39 -0700 (PDT)
Date:   Wed, 13 Apr 2022 12:18:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v6 7/9] dmaengine: dw-edma: Add support for chip specific
 flags
Message-ID: <20220413091837.an75fiqazjhpapf4@mobilestation>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
 <20220406152347.85908-8-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406152347.85908-8-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 06, 2022 at 10:23:45AM -0500, Frank Li wrote:
> Add a "flags" field to the "struct dw_edma_chip" so that the controller
> drivers can pass flags that are relevant to the platform.
> 
> DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
> locally. Local eDMA access doesn't require generating MSIs to the remote.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

> Change from v5 to v6
>  - use enum instead of define

Hm, why have you decided to do that? I don't see a well justified
reason to use the enumeration here, but see my next comment for
details.

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
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 9 ++++++---
>  include/linux/dma/edma.h              | 9 +++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
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
> index c2039246fc08c..bec444e2939b2 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -33,6 +33,14 @@ enum dw_edma_map_format {
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
> @@ -53,6 +61,7 @@ struct dw_edma_chip {
>  	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
> +	enum dw_edma_chip_flags	flags;

There is no point in having the named enumeration here since the flags
field semantics is actually a bitfield rather than a single value. If
you want to stick to the enumerated flags, then please use the
anonymous enum like this:
+enum {
+	DW_EDMA_CHIP_LOCAL	= BIT(0),
+};
and explicit unsigned int type of the flags field.

-Sergey

>  
>  	void __iomem		*reg_base;
>  
> -- 
> 2.35.1
> 
