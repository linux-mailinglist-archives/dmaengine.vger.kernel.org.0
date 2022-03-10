Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5845C4D4720
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 13:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbiCJMiW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 07:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiCJMiW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 07:38:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA23148667;
        Thu, 10 Mar 2022 04:37:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h14so9132251lfk.11;
        Thu, 10 Mar 2022 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RobMDDfWnOz5yZ1PGRtJSSc4jJfiehWVeo3eirprMYY=;
        b=ct8mM04AZqcYsxCik7J35JjhMHpThFjyOpv7I+XBSR+hom58EvLYQ3otdLNeqa47MP
         lKEBdnAU3ro7zBi+/HRtJyANhGw/jYLsBklwcLMj//UqIXK+DUdqE5UA0wMyYQmVaP3n
         uXqHNPIwX3Xj4n7NCdHA3Jw4YvuWFLmXEbOqVLjiBAdN5be/hbepaUdVskHK4SdQFXOC
         yIyby5c6PuUEGQx7E0R9KtEBN5WgRgidiIQLH+IIORkhkdcAMzt2L2tOxKInx8ES4Czo
         /TKgl38dF+qFWY/ESKgSn3lkEoXvqL3d2HqK1JFXCrTKEHdnRbE0LEu89hKHpAD3swB7
         lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RobMDDfWnOz5yZ1PGRtJSSc4jJfiehWVeo3eirprMYY=;
        b=aTnTIkFdJBgG9BJ8EFkXhXrD2RDe2FrqyjsPt4pNf41diktC8jLuPJ0fJ84CX6GiKM
         gCadysN5x3Tz+SWg6CLyYAX3iJOfj5r3ixbelcfH60S+Dui0LxVYlv83xJN7RaG4Upvx
         BGCicjKTXor/abc+DAUnaLXzS7j/SeRmYBavIwXi2E8iy32XYSnabL41jUCQJkEEu8v+
         w6BCtN5iW+bS2qIyz6WfCcuVYP/32iI0aESlmb+ZWvLy6x+RLLKIaZZDpJvvl5WFeUND
         eD3cGh3I0vFJRzJ9W8hQgZfZ+JFbKXVv+vCJCA1cFwIY76sLYR0yXTpGJaeTyJvoFvIY
         Jt9Q==
X-Gm-Message-State: AOAM533mAgfMek9fL4nFFLVsYa2JihTacN9Lk+Qds1k6i6C+RFWSDo39
        C1pNGPxPhrWKMmhGL7FxSvk=
X-Google-Smtp-Source: ABdhPJxCodS5d3x300XwibiSnbD5ZFWN9D3hPoAyqRtPGga8kWk8xT9KIdBCp3HikQHLTI1VBpALBw==
X-Received: by 2002:a05:6512:104a:b0:448:46f1:776c with SMTP id c10-20020a056512104a00b0044846f1776cmr2979259lfb.473.1646915839003;
        Thu, 10 Mar 2022 04:37:19 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id y17-20020a2e95d1000000b002463d2595f0sm1036534ljh.135.2022.03.10.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 04:37:18 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:37:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 4/8] dmaengine: dw-edma: rename wr(rd)_ch_cnt to
 ll_wr(rd)_cnt in struct dw_edma_chip
Message-ID: <20220310123716.z6zh72ybevze3nk2@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 03:12:00PM -0600, Frank Li wrote:
> There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
> write(read) channel number from register, then save these into dw_edma.
> Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
> are avaiable in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
> ll_wr(rd)_cnt to indicate actual usage.

Hmm, I am not sure you are right here. AFAICS the
drivers/dma/dw-edma/dw-edma-pcie.c driver either uses a statically
defined number or Rd/Wr channels or just gets the number from the
specific vsec PCIe capability. Then based on that the driver just
redistributes the BARs memory amongst all the detected channels in
accordance with the statically defined snps_edda_data structure.
Basically the BARs memory serves as the Local/CPU/Application memory
for the case if the controller is embedded into the PCIe Host/EP
controller. See the patches which implicitly prove that:
31fb8c1ff962 ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
da6e0dd54135 ("dmaengine: dw-edma: Change linked list and data blocks offset and sizes")

(That's why the logic of the DEV_TO_MEM/MEM_TO_DEV is inverted for the
the drivers/dma/dw-edma/dw-edma-pcie.c platform.)

So basically the wr_ch_cnt/rd_ch_cnt fields have been and is used as
the number of actually available channels, not linked-list. While the
notation suggested by you can be confusing, since the ll-memory allocated for
each channel can be split up and initialized with numerous linked lists
each of which is used one after another.

I don't really see a well justified reason to additionally have the
@wr_ch_cnt and @rd_ch_cnt fields in the dw_edma_chip seeing the number
of channels can be auto-detected from the corresponding registers, except
that to workaround a bogus hardware. So we can keep it, but please no
renaming. It will only cause additional confusion.

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> new patch at v4
> 
>  drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
>  drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
>  include/linux/dma/edma.h           |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 1abf41d49f75b..66dc650577919 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -918,11 +918,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	raw_spin_lock_init(&dw->lock);
>  
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
> 2.24.0.rc1
> 
