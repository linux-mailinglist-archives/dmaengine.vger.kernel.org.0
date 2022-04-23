Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E550C9BA
	for <lists+dmaengine@lfdr.de>; Sat, 23 Apr 2022 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiDWLwz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 23 Apr 2022 07:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiDWLwy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 23 Apr 2022 07:52:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9DBE0E
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 04:49:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j6so8086045pfe.13
        for <dmaengine@vger.kernel.org>; Sat, 23 Apr 2022 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bD0I91RPtpUdTHW6YTFj3yI+VIqkefD+3QomXi2VfVk=;
        b=TOLGF7/a34UPIzjT4NYmnYmSmnQy6P1Xud04wVFEIYZnynWB3Lo2ry+ki4VVwreVfT
         fIaFzk3B8nIqpTla5jxOQ9v65YaTu/7aQp5/no9BL3AZsc3EqiwhTNrefDOh9JqhieQU
         uK4+0H8gsjGoYSTaIikO6uuHjqDsmZFNjD4EBAjN8vVP8ShZ7Cs8c72HmUOVIc39YdaQ
         OaMEmZPXhsgV5PnQTRKKotIAZLhKkdixxAdfDeXZE15evyUvLQJbjwLX83wz7LL7SZwA
         z9T2jVK8Zq8ivlVFA8DRmy3SBV2bwCrU8rNw6ivSg3Y0GpRPARV3ioaf3qQ9pJ5ruuHk
         Qn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bD0I91RPtpUdTHW6YTFj3yI+VIqkefD+3QomXi2VfVk=;
        b=nzA3s3GB+WA+Eos4yHE79RhABdNFaVmq7On7DsDrJnrizmiJNV8L9VZXK5nwWDtYlA
         BDq3FOoxHuCOGb9qfPBa/2dftQffT+lXRW8Uyy+5w8dZIvJ0NdqduKsnihDVR6pqYbPf
         t0ZHyPm4PCXcn1oabf5bpHyNstKx6ZQkIbdetnlyMzqk9Fi/tkNJoXSAQzGVp62VfM3L
         iWeYCF3Ph5OXEJi4gBby7DrbZNs6UfIzeVfRsn818EIqvpLACdgZ/qIX01Ps+maD9Mao
         XC6NKHy1ySGPh0XJR0YlarGOhs4KliI1sJsEsycozQR5hz23XmU+y5gXL630rsYRUCEU
         QPHg==
X-Gm-Message-State: AOAM533bU1RfkCnZ0DuEKF4nDKN4XMR0ZneIEfcvkmspFMqzJQiM31i3
        vW7hTIp9JLHQ9A0GqwuaaM8F
X-Google-Smtp-Source: ABdhPJzSURchGfaoJkNECcT5mOvpxRf+IxN+aW3buOd2vagZyevAWhQeB6vxCJI5OqauQAlvKoSw1w==
X-Received: by 2002:a63:7d49:0:b0:378:907d:1fc7 with SMTP id m9-20020a637d49000000b00378907d1fc7mr7718345pgn.252.1650714597019;
        Sat, 23 Apr 2022 04:49:57 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id x71-20020a62864a000000b0050ad2c24a39sm5852337pfd.205.2022.04.23.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:49:56 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:19:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 1/9] dmaengine: dw-edma: Remove unused field irq in
 struct dw_edma_chip
Message-ID: <20220423114949.GD374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:35AM -0500, Frank Li wrote:
> irq of struct dw_edma_chip was never used.
> It can be removed safely.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> Change from v7 to v9
>  - None
> Change from v6 to v7
>  - move to 1st patch
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
> index 44f6e09bdb531..b8f52ca10fa91 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -231,7 +231,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dw = dw;
>  	chip->dev = dev;
>  	chip->id = pdev->devfn;
> -	chip->irq = pdev->irq;
>  
>  	dw->mf = vsec_data.mf;
>  	dw->nr_irqs = nr_irqs;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index cab6e18773dad..d4333e721588d 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -18,13 +18,11 @@ struct dw_edma;
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> - * @irq:		 irq line
>   * @dw:			 struct dw_edma that is filed by dw_edma_probe()
>   */
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> -	int			irq;
>  	struct dw_edma		*dw;
>  };
>  
> -- 
> 2.35.1
> 
