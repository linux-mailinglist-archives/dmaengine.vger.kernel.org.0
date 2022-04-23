Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD750C9CE
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiDWMP0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiDWMPX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 08:15:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0A229ED5
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:12:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q19so9465368pgm.6
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h4H94cnstVyc24L19XTX/CUnoz98R15K3kwXXREBV2w=;
        b=mvx95rEBLSNhXXy92QpGQUl9H0d4ram5yUpX3ITC5HqUOe6EC/B7uo9jxlC3ySM0aA
         b/nY7xdt8kpGDndjfmFjrL14lgpQ5QOXAzrt/cRsxztTD8ktgFzygIw5gnPaIs7rrUMq
         kSAij9ANrlhtANq9T10cgylxYOGaKJTH4YzaMR4LDsd3J1FPsjzBsvZv2r1ilN0drbVh
         tOo7AHWyrOZVUIJ/P1dYGtxpAd97tTe6zPaMlKP5uGwjStkGmlBGP5LgG0pU6yHwCA8T
         a6ZzWzvxk+1PULsz+ESewO4qkpVgfqZx/nZUsGvx0MV+QfF5gIn4sqoDVg3aV3CPsqgZ
         B+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4H94cnstVyc24L19XTX/CUnoz98R15K3kwXXREBV2w=;
        b=R73STFobc+pQZI9mU1jOpoYZFaYc+QyNKnNC7JC3ZV8oYhVt4OlxEIyQWeVVE1w/Fv
         0zirNZBSy0RnXukAqNGvmJSggaXO8NFHy4+nwq053fHzkRz+Tzs1jqIb6jr155juL6um
         s5FHuNaT/Phu3jDofJPx6anoxEQOT4oyi9/eb84ZfTQcoU3E5cFA7V8a88WbdDPWay+T
         8w0+pBvVN4vT/4bOmfQhL8UUQhzxAXfWdb4jVKAPeHgjrI5kQttyHfgU7FqmslkmPzt9
         YUkw4Cwpvue3aqxYUhuAZccH6gDvRaw6TI900T3aO5xAeJ2p/hmKXd6tthJsARDJdVvG
         DQkw==
X-Gm-Message-State: AOAM532qbYbR0/BJj1J7LhiV/QZc6AlLStnJAuPTQfLNE6NzS8rK04+h
        kjDcTuXYxSQssGL+/V7sPMQ3
X-Google-Smtp-Source: ABdhPJzEVgZqiZtOTZj+7UEvjSCSIz0Hf4ig56QZ5KFxal4eaAtTxlzqH6uVidtVtd821C+oDP3SRA==
X-Received: by 2002:a63:a66:0:b0:373:c36b:e500 with SMTP id z38-20020a630a66000000b00373c36be500mr7714877pgk.419.1650715945808;
        Sat, 23 Apr 2022 05:12:25 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a390500b001cd4989ff50sm9171627pjb.23.2022.04.23.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:12:25 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:42:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to
 ll_wr(rd)_cnt in struct dw_edma_chip
Message-ID: <20220423121218.GG374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:38AM -0500, Frank Li wrote:
> There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
> write(read) channel number from register, then save these into dw_edma.
> Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
> are available in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
> ll_wr(rd)_cnt to indicate actual usage.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One minor comment below,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> Change from v6 to v9
>  - none
> Change from v5 to v6
>  - s/rename/Rename/ at subject
> new patch at v4
> 
>  drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
>  drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
>  include/linux/dma/edma.h           |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 435e4f2ab6575..1a0a98f6c5515 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -919,11 +919,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  
>  	raw_spin_lock_init(&dw->lock);
>  
> -	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
> +	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
>  	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
>  
> -	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
> +	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
>  	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
>  
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index ae42bad24dd5a..7732537f96086 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -230,14 +230,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_core_ops;
>  
> -	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
> -	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
> +	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
> +	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
>  
>  	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < chip->wr_ch_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
> @@ -262,7 +262,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		dt_region->sz = dt_block->sz;
>  	}
>  
> -	for (i = 0; i < chip->rd_ch_cnt; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
> @@ -302,7 +302,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		chip->reg_base);
>  
>  
> -	for (i = 0; i < chip->wr_ch_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_wr[i].bar,
>  			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> @@ -314,7 +314,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
>  	}
>  
> -	for (i = 0; i < chip->rd_ch_cnt; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_rd[i].bar,
>  			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index e9ce652b88233..c2039246fc08c 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -40,8 +40,8 @@ enum dw_edma_map_format {
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
>   * @reg_base		 DMA register base address
> - * @wr_ch_cnt		 DMA write channel number
> - * @rd_ch_cnt		 DMA read channel number
> + * @ll_wr_cnt		 DMA write link list number
> + * @ll_rd_cnt		 DMA read link list number

DMA linked list write/read memory regions?

Thanks,
Mani

>   * @rg_region		 DMA register region
>   * @ll_region_wr	 DMA descriptor link list memory for write channel
>   * @ll_region_rd	 DMA descriptor link list memory for read channel
> @@ -56,8 +56,8 @@ struct dw_edma_chip {
>  
>  	void __iomem		*reg_base;
>  
> -	u16			wr_ch_cnt;
> -	u16			rd_ch_cnt;
> +	u16			ll_wr_cnt;
> +	u16			ll_rd_cnt;
>  	/* link list address */
>  	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
>  	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> -- 
> 2.35.1
> 
