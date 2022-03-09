Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214FD4D3709
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 18:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiCIR0M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 12:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiCIR0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 12:26:11 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E560FF;
        Wed,  9 Mar 2022 09:25:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so5043366lfh.2;
        Wed, 09 Mar 2022 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kCxJTkJg7wU+lSEyp/2mML+SJzrgIfplySEru8atjsc=;
        b=pCWlY6IVenBE3P5ORheXxQbnpDrJ6U4P2J8eKw/Iwspymoz5x6wN5tT9lt91nwjj1J
         fXkds5D8bgrsHaY37nXfAVbL75ONowAtdMDduZe60MjQDBMEy1DKXColzQsjqq4Bf2pe
         ffunIVHLM1Db2QMDFoJiVWr9TlDP9GuppWGgjbLswNeIRcDQIDeCdKfoDA7XkELbLQZu
         hS2rA7wvrsrVq9TF0mwfgs3aPgkbe/F53TeBg4PL7oGnezo3TLZIA7K8ez++tQc/IgSi
         gCZvxIB0fLaomMCvxqfvA98dPXr/lYIcjfDerN++PLFkcMuOSq37rEh88D7LscgDJSx6
         bskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCxJTkJg7wU+lSEyp/2mML+SJzrgIfplySEru8atjsc=;
        b=n4YJ3xFKp8PVgqlnxiJkWJQ1V9G54fr2WNDybPR6t1uw9+gDamOC9g29vKX57aZJPC
         hKr6kK56lYQ+GRjJU0Qe8hl13kmBmy00We4HQ/pRhXhUQ29CknvDXDxSHjo5faNIOI/5
         lQeSs4QhqYoWBJ6H2cpWBkW4GyCchG5cE9VgWybYvlYVqJRINI3Mhf9OoQfkkX610wOL
         8ePSa81Qewlz/PLaQHmUMZQI2vY4z/3t3YZLpGuM6cNS9JU/t2xUa+qeRIsFrJ/c8duV
         uGl6CS2iG4Bzjqth6csBvCcdzJ1prU6qg8udRMRGvjElcMGRbCIEqfvvyozFxaAWEZxn
         9F/Q==
X-Gm-Message-State: AOAM532FOZykBxqhiccrKLjyv972t53fxrWkCzHEFEfYE9uDcSUN/NnH
        jhA+JI0978XRyeWpSTpdrc4=
X-Google-Smtp-Source: ABdhPJyblse2S0zQDOSXKvEBZXBeetPignovLqveT0zGtnKgvBbA1wk1fuN57QBWNRw4Y2xcv+PDXA==
X-Received: by 2002:a05:6512:2610:b0:448:27fc:a6ab with SMTP id bt16-20020a056512261000b0044827fca6abmr419739lfb.117.1646846708468;
        Wed, 09 Mar 2022 09:25:08 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id x33-20020a0565123fa100b00443d3cffd89sm492580lfa.210.2022.03.09.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:25:07 -0800 (PST)
Date:   Wed, 9 Mar 2022 20:25:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v3 2/6] dmaengine: dw-edma-pcie: don't touch internal
 struct dw_edma
Message-ID: <20220309172506.wdqfx2ds5snmpmt7@mobilestation>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220307224750.18055-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307224750.18055-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 07, 2022 at 04:47:46PM -0600, Frank Li wrote:
> "struct dw_edma" is an internal structure of the eDMA core. This should not be
> used by the eDMA controllers like "dw-edma-pcie" for passing the controller
> specific information to the core.
> 
> Instead, use the fields local to the "struct dw_edma_chip" for passing the
> controller specific info to the core.

Hmm, I've got a feeling that without this patch the kernel won't be
even buildable. Am I right? If so, it must be fixed. As I see it,
you'll need to merge this change into the "[PATCH vX 1/6] dmaengine:
dw-edma: fix dw_edma_probe() can't be call globally" patch. Thus
you'll have a coherent modification, which will leave the kernel
buildable and hopefully problemlessly runnable.

BTW I would have changed the patch title anyway: "[PATCH vX 1/6]
dmaengine: dw-edma: fix dw_edma_probe() can't be call globally". It
doesn't really explains the modification it self, but the purpose why
you need to do what you did. Something like: "[PATCH vX 1/6] 
dmaengine: dw-edma: Detach the private data and chip info structures"

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Resend added dmaengine@vger.kernel.org
> 
> Change from v2 to v3:
>  None
> 
> Change from v1 to v2:
>  - rework commit message
>  - rg_region only use virtual address. using chip->reg_base instead
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c | 83 ++++++++++++------------------
>  1 file changed, 34 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 44f6e09bdb531..7732537f96086 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data vsec_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
> -	struct dw_edma *dw;
>  	int err, nr_irqs;
>  	int i, mask;
>  
> @@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip)
>  		return -ENOMEM;
>  
> -	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> -	if (!dw)
> -		return -ENOMEM;
> -
>  	/* IRQs allocation */
>  	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
>  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
> @@ -228,29 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Data structure initialization */
> -	chip->dw = dw;
>  	chip->dev = dev;
>  	chip->id = pdev->devfn;
> -	chip->irq = pdev->irq;
>  
> -	dw->mf = vsec_data.mf;
> -	dw->nr_irqs = nr_irqs;
> -	dw->ops = &dw_edma_pcie_core_ops;
> -	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
> -	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
> +	chip->mf = vsec_data.mf;
> +	chip->nr_irqs = nr_irqs;
> +	chip->ops = &dw_edma_pcie_core_ops;
>  
> -	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> -	if (!dw->rg_region.vaddr)
> -		return -ENOMEM;

> +	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
> +	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;

Please see my comment to the previous patch regarding these fields
naming.

>  
> -	dw->rg_region.vaddr += vsec_data.rg.off;
> -	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
> -	dw->rg_region.paddr += vsec_data.rg.off;
> -	dw->rg_region.sz = vsec_data.rg.sz;

> +	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];

Please see my comment to the previous patch regarding the reg_base
field introduction. See you've dropped rg_region from the dw_edma
structure in the previous patch, while it's left being used in the
dw-edma-pcie driver. Thus the kernel will fail to build this driver
for sure.

-Sergey

> +	if (!chip->reg_base)
> +		return -ENOMEM;
>  
> -	for (i = 0; i < dw->wr_ch_cnt; i++) {
> -		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
> -		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
> +	for (i = 0; i < chip->ll_wr_cnt; i++) {
> +		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> +		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
>  
> @@ -273,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		dt_region->sz = dt_block->sz;
>  	}
>  
> -	for (i = 0; i < dw->rd_ch_cnt; i++) {
> -		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
> -		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> +		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
>  
> @@ -299,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* Debug info */
> -	if (dw->mf == EDMA_MF_EDMA_LEGACY)
> -		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
> -	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
> -		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
> -	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
> -		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
> +	if (chip->mf == EDMA_MF_EDMA_LEGACY)
> +		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
> +	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
> +		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
> +	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
> +		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
>  	else
> -		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
> +		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
>  
> -	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> +	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
>  		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> -		dw->rg_region.vaddr, &dw->rg_region.paddr);
> +		chip->reg_base);
>  
>  
> -	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_wr[i].bar,
> -			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
> -			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
> +			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> +			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.dt_wr[i].bar,
> -			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
> -			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
> +			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
> +			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
>  	}
>  
> -	for (i = 0; i < dw->rd_ch_cnt; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.ll_rd[i].bar,
> -			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
> -			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
> +			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> +			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
>  			i, vsec_data.dt_rd[i].bar,
> -			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
> -			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
> +			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
> +			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
>  	}
>  
> -	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
> +	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
>  
>  	/* Validating if PCI interrupts were enabled */
>  	if (!pci_dev_msi_enabled(pdev)) {
> @@ -345,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -EPERM;
>  	}
>  
> -	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> -	if (!dw->irq)
> -		return -ENOMEM;
> -
>  	/* Starting eDMA driver */
>  	err = dw_edma_probe(chip);
>  	if (err) {
> -- 
> 2.24.0.rc1
> 
