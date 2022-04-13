Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3774FF2C8
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiDMI5h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiDMI5g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 04:57:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60243FBE2;
        Wed, 13 Apr 2022 01:55:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r2so1330889ljd.10;
        Wed, 13 Apr 2022 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oUjxDGpMSkInlKORYG16mjbNvdLT3MpGChtdXa8hc84=;
        b=O6FY031bK51ok/IBOPbt0voVqHJqxDTS24BFJuzABu89y9hwLHsTOqkYKQOhvte68i
         TQWhP7YEkXYGq3HrkTcBqcyIXwziP/bW/TFgvtW9fvxMnfJmH2SRuLd5aq7M8eXqIktV
         lbpOD0WuTtT1za6o3sRZW0W+BZLcwQZlIEMOETAx5/6nfbGXt39VeJySrcWPyL1Jwkfd
         g9uC7TCDZtQ0UsuIRvudXt8ZpLiK/oVgvUoN96OS9KxCG/VTfMmq2XXtg6QaZxB/wMSm
         z7o7fswD27XknkpEh0k2muErXPkWlvWHhsyzjXGxPFYZg0tFtUJeVV7pjMOmsLXqFVgH
         YxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUjxDGpMSkInlKORYG16mjbNvdLT3MpGChtdXa8hc84=;
        b=YGHw14HEril15HtaTPY5yMmGzBFCmLirQJt6QlrskemXSq+c+FCzIhW7rCb+lZAXzY
         BzhvMWz+PJz/F9FSurcbMslEJrDIZCPr5dInCYBDtpDu32F06BRAcoEVsFar1pNRO3rw
         Xo4/xtHegWAsS5+raifLDBzzY5Oa2ndiG3rSP2mWOc5o6DgpbWuGlIA7MUsdRkep8B11
         p6X+qS7tETu/MIIF5GmXBWxAWsqK0zhv/kSIHWkn9aXYTn61ZGxN44EZiJZHgCi0QN66
         87rdrV8MDHlB46w4o05sg2V4hpxXh+PZl73iLk9dsglkp8uPHacpTfC2RGXq8NCM+xVX
         wT8A==
X-Gm-Message-State: AOAM533UD1s77yLm+ut1E4f0eT4e79g1SvMfNE0BzuZngWhIwKRiTubc
        m1p1AdOvaQ1cbfo6AE1GKlg=
X-Google-Smtp-Source: ABdhPJz8WLIQMVjMN0xUfrD1v1vHHv6Yu4kN3QpqdUdnM7Nz4rvgODhpfO9tVJ89y6HIMQmKs7bcRQ==
X-Received: by 2002:a2e:a54e:0:b0:249:8cad:ec8 with SMTP id e14-20020a2ea54e000000b002498cad0ec8mr26320167ljn.362.1649840114095;
        Wed, 13 Apr 2022 01:55:14 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id e19-20020a196913000000b0046ba7a50e5dsm989110lfc.222.2022.04.13.01.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:55:13 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:55:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v6 2/9] dmaengine: dw-edma: Remove unused field irq in
 struct dw_edma_chip
Message-ID: <20220413085511.gc3ao4uvlzfcd7ez@mobilestation>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
 <20220406152347.85908-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406152347.85908-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 06, 2022 at 10:23:40AM -0500, Frank Li wrote:
> irq of struct dw_edma_chip was never used.
> It can be removed safely.

As I said in my comment to the patch "dmaengine: dw-edma: Detach the
private data and chip info structures" of this series, please move
this patch to being applied before that one and completely drop the
irq field in the framework of this modification. Otherwise the change
in both of these patches seem intermixed and don't represent a single
modification.

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v5 to v6
>  - s/remove/Remove/ at subject
> Change from v4 to v5
>  - none
> new patch at v4
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
>  include/linux/dma/edma.h           | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 21c8c59e09c23..2c1c5fa4e9f28 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -225,7 +225,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Data structure initialization */
>  	chip->dev = dev;
>  	chip->id = pdev->devfn;
> -	chip->irq = pdev->irq;
>  
>  	chip->mf = vsec_data.mf;
>  	chip->nr_irqs = nr_irqs;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index a9bee4aeb2eee..6fd374cc72c8e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -37,7 +37,6 @@ enum dw_edma_map_format {
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> - * @irq:		 irq line
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
>   * @wr_ch_cnt		 DMA write channel number
> @@ -51,7 +50,6 @@ enum dw_edma_map_format {
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> -	int			irq;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
>  
> -- 
> 2.35.1
> 
