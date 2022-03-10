Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7754D4772
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 13:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiCJM5s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 07:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCJM5r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 07:57:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98656149B93;
        Thu, 10 Mar 2022 04:56:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z11so9192779lfh.13;
        Thu, 10 Mar 2022 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y+6UK50+1RtnrOaVu7w4moimbhX5SN6HBffXgHYQxds=;
        b=QZ6lt/CqliDwvDrEgteLdMcVfXaHWcl3F8jMxL6fyl8W0El2WE+Sczfp16suFOTkmy
         KlCEzj3C1ZS81NAt6DzahEY6EuI+LYRgvCEr2OpI6XaiTyw/gGzAl/N3IPP7M78ERdhT
         B8K7aGPw65WvQHgFr412EtxUkOzSrWHf02lwCGdtz4mbS/mea/iwhz2jm6zg/r6I0RzS
         f6YmWTMfIgxlPhuJQnNlCifgQeexhzAm6oxJPbU2aELwGSS09W2qT+s+YP7Yq81RO6Zy
         zsdhUPr+LhJ1krGNDypWE1G+4cB7SvpVpU4h6SDzz9E5hPCU4Rg0GwL8ycWQTQ4hiNTV
         2d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+6UK50+1RtnrOaVu7w4moimbhX5SN6HBffXgHYQxds=;
        b=WkBY4AfONYD+6n1OYe2UDbnAXcb1INan3NJ86GHXwxC/26JRqSQd8vo6QyuYM/hfIR
         pHuVv8dyPgSIO6ICuaoOjJtuMFrSY5XE9EBfuRutEqStc47YKZ3QOeTA97dxVBQOhHf1
         QByYxu2P5/89W9wL6qyo76Eg9rJQ4vwaD/q+ylxjqc2xjMSqcgZPHvMmGfg+83TE6Nha
         mechGbmyDj2f4F5Mw0O0XZr1lCMOlxyEyBfZGgMgt3+TkStRrKJCu/AAUDC8iUnkArAq
         s+0at8eC62j2WUHcJjMua6A6rkXDOb7wPef0vnRLfgNlWUmEhtPjrNQ3xyDQ+dDfQKqP
         0O1A==
X-Gm-Message-State: AOAM531dWCgetc3NgRTUhsXBqSJ4zTFLEQ/HLAMe9zGaB8INTRcIPy3l
        lAY6S4T2/7yPHFrOLZPgiHQ=
X-Google-Smtp-Source: ABdhPJwBx+lYh8FGKBTqTmszuDN3N2+oYz8vAb2TWLvuBgs6SyMC3FXFWkwGPGWds1sbWFbEF+MArw==
X-Received: by 2002:a05:6512:1322:b0:448:410d:a85a with SMTP id x34-20020a056512132200b00448410da85amr2898663lfu.67.1646917004978;
        Thu, 10 Mar 2022 04:56:44 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id m20-20020a194354000000b0044829b151b2sm964422lfj.222.2022.03.10.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 04:56:44 -0800 (PST)
Date:   Thu, 10 Mar 2022 15:56:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 3/8] dmaengine: dw-edma: change rg_region to reg_base
 in struct dw_edma_chip
Message-ID: <20220310125642.lcmwt3ojulk7cc43@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 03:11:59PM -0600, Frank Li wrote:
> struct dw_edma_region rg_region included virtual address, physical
> address and size informaiton. But only virtual address is used by EDMA
> driver. Change it to void __iomem *reg_base to clean up code.

Right, the driver doesn't use neither physical address nor size of the
CSRs MMIO region, and most likely will never start using it. They are
just redundant for the CSR space.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> New patch at v4
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 6 +++---
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 2 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
>  include/linux/dma/edma.h                 | 3 ++-
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2c1c5fa4e9f28..ae42bad24dd5a 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -233,8 +233,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
>  	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
>  
> -	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> -	if (!chip->rg_region.vaddr)
> +	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> +	if (!chip->reg_base)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < chip->wr_ch_cnt; i++) {
> @@ -299,7 +299,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
>  		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> -		chip->rg_region.vaddr);
> +		chip->reg_base);
>  
>  
>  	for (i = 0; i < chip->wr_ch_cnt; i++) {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index e507e076fad16..35f2adac93e46 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -25,7 +25,7 @@ enum dw_edma_control {
>  
>  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  {
> -	return dw->chip->rg_region.vaddr;
> +	return dw->chip->reg_base;
>  }
>  
>  #define SET_32(dw, name, value)				\
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index edb7e137cb35a..3a899f7f4e8d8 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return;
>  
> -	regs = dw->chip->rg_region.vaddr;
> +	regs = dw->chip->reg_base;
>  	if (!regs)
>  		return;
>  
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 6fd374cc72c8e..e9ce652b88233 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -39,6 +39,7 @@ enum dw_edma_map_format {
>   * @id:			 instance ID
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
> + * @reg_base		 DMA register base address
>   * @wr_ch_cnt		 DMA write channel number
>   * @rd_ch_cnt		 DMA read channel number
>   * @rg_region		 DMA register region
> @@ -53,7 +54,7 @@ struct dw_edma_chip {
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
>  
> -	struct dw_edma_region	rg_region;
> +	void __iomem		*reg_base;
>  
>  	u16			wr_ch_cnt;
>  	u16			rd_ch_cnt;
> -- 
> 2.24.0.rc1
> 
