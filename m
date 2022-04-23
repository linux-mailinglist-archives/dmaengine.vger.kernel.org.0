Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EAD50C9BF
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiDWMAL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiDWMAL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 08:00:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE8BC89
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 04:57:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d15so16497618pll.10
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYqHsLDgBz+rDNlUULf9M+2RK9qleRYX7ixWy2IaEN4=;
        b=KJvzEfwMUQkKDHYp3tltVoe5616N3nRMaofpvrxzK3IxHCVnh43KwzKawDqebdt45k
         skYlu7fr02hBdDeHLcmR9jFR2m3vGKrL4zuY2lJz7QYZDf0nrX6lfuQszS/lBQRGC5oo
         UdaSS187inWn3Flq8iUsID3l3/cISnAqKR0wXyI8zsz4LGUiL7aj+mM72Fii0xST8b4d
         t72ehugqj8bP4gkTRve8Z44KiQiw3BwcItp5oXztBRQUKcoNguK6S4MSKcdR2PuD8ywd
         OwWXz+DY/4r1QWF43NiWWWTXOBm0SqpNnB3EwiO1uvGaU5VPyRI6C0Ek4nvcP/+mnBXM
         QWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYqHsLDgBz+rDNlUULf9M+2RK9qleRYX7ixWy2IaEN4=;
        b=cWlDWBPHWmNhATWtyiI2qfylCcfayRjqdGqVnoV33nsQ0LMMMek8T1gE+ATMYI0nC1
         McbSVhAb577WAOHmtYaJmupfDzU1JHM7EdVwF7XgV3uqzvwpJysUamBJ+ope797B4dGT
         +q5PwnS0JnLO0JuskE8P8l3ooSxbHOaOBz6szTidMdNt2Ps3m+4Rk1mG0aZ21tGt+N8J
         iBDbnSYiiWSPOuuvYSBjkMEmTtezsDs8jSOpZ8iqApOTbV2AMpvMw7475ImS/6TIGx2R
         X2GjdAYHhWfxyyv1V9OYX6/KPyz/uA+zWYCQPWbVOk/vi2tPToiSIpHSx6mONStoSJey
         SlxQ==
X-Gm-Message-State: AOAM531KzGMpGrLlMdzNf/LnEnY8T7hMKycstpj1X7T1bMbWr8lqmanA
        jSInsknwZoxzku61QNbYAow6QC+HBipR
X-Google-Smtp-Source: ABdhPJx2veyb4+LQQTxdt+tjLRwEijAgHrZcLWA2FKa6pTx7Itr8yI9Z13TwxwkKjCf7ZFGjRSaetg==
X-Received: by 2002:a17:90b:886:b0:1d9:3a05:3f2a with SMTP id bj6-20020a17090b088600b001d93a053f2amr1748340pjb.53.1650715033728;
        Sat, 23 Apr 2022 04:57:13 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a7f8900b001d899a28d1esm4207084pjl.4.2022.04.23.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:57:13 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:27:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 2/9] dmaengine: dw-edma: Detach the private data and
 chip info structures
Message-ID: <20220423115706.GE374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:36AM -0500, Frank Li wrote:
> "struct dw_edma_chip" contains an internal structure "struct dw_edma" that
> is used by the eDMA core internally. This structure should not be touched
> by the eDMA controller drivers themselves. But currently, the eDMA
> controller drivers like "dw-edma-pci" allocates and populates this
> internal structure then passes it on to eDMA core. The eDMA core further
> populates the structure and uses it. This is wrong!
> 
> Hence, move all the "struct dw_edma" specifics from controller drivers
> to the eDMA core.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

There is a comment below, but other that that:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> Change from v8 to v9
>  - remove chip->ops check at dw_edma_irq_request()
> Change from v7 to v8
>  - Check chip->ops at probe()
>  - use struct edma_dw at dw_edma_v0_debugfs_on/off()
> 
> Change from v6 to v7
>  - Move nr_irqs and chip->ops check into dw_edma_irq_request()
>  - Move dw->irq devm_kcalloc() into dw_edma_irq_request()
>  - Change dw->nr_irqs after request success
>  - Fix wrong use chip->nr_irqs when remove
> 
> Change from v5 to v6
>  - Don't touch chip->nr_irqs
>  - Don't set chip->dw utill everything is okay
>  - dw_edma_channel_setup() and dw_edma_v0_core_debugfs_on/off() methods take
>    dw_edma structure pointer as a parameter
> 
> Change from v4 to v5
>  - Move chip->nr_irqs before allocate dw_edma
> Change from v3 to v4
>  - Accept most suggestions of Serge Semin
> Change from v2 to v3
>  - none
> Change from v1 to v2
>  - rework commit message
>  - remove duplicate field in struct dw_edma
> 
> 
>  drivers/dma/dw-edma/dw-edma-core.c       | 90 +++++++++++++-----------
>  drivers/dma/dw-edma/dw-edma-core.h       | 31 +-------
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 82 +++++++++------------
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 32 ++++-----
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 ++---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  8 +--
>  include/linux/dma/edma.h                 | 44 ++++++++++++
>  8 files changed, 161 insertions(+), 148 deletions(-)
> 

[...]

> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index d4333e721588d..6fd374cc72c8e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -12,17 +12,61 @@
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
>  
> +#define EDMA_MAX_WR_CH                                  8
> +#define EDMA_MAX_RD_CH                                  8
> +
>  struct dw_edma;
>  
> +struct dw_edma_region {
> +	phys_addr_t	paddr;
> +	void __iomem	*vaddr;
> +	size_t		sz;
> +};
> +
> +struct dw_edma_core_ops {
> +	int (*irq_vector)(struct device *dev, unsigned int nr);
> +};
> +
> +enum dw_edma_map_format {
> +	EDMA_MF_EDMA_LEGACY = 0x0,
> +	EDMA_MF_EDMA_UNROLL = 0x1,
> +	EDMA_MF_HDMA_COMPAT = 0x5
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> + * @nr_irqs:		 total dma irq number
> + * @ops			 DMA channel to IRQ number mapping
> + * @wr_ch_cnt		 DMA write channel number
> + * @rd_ch_cnt		 DMA read channel number
> + * @rg_region		 DMA register region
> + * @ll_region_wr	 DMA descriptor link list memory for write channel
> + * @ll_region_rd	 DMA descriptor link list memory for read channel
> + * @mf			 DMA register map format

Not all members added below are documented in kdoc. Please fix.

Thanks,
Mani

>   * @dw:			 struct dw_edma that is filed by dw_edma_probe()
>   */
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> +	int			nr_irqs;
> +	const struct dw_edma_core_ops   *ops;
> +
> +	struct dw_edma_region	rg_region;
> +
> +	u16			wr_ch_cnt;
> +	u16			rd_ch_cnt;
> +	/* link list address */
> +	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> +
> +	/* data region */
> +	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> +
> +	enum dw_edma_map_format	mf;
> +
>  	struct dw_edma		*dw;
>  };
>  
> -- 
> 2.35.1
> 
