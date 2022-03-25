Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95E4E7065
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 11:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353697AbiCYKDr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347026AbiCYKDq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 06:03:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A4CFBA4
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 03:02:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id g3so7493983plo.6
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9wI0zrpHRmLcU6l6ReXG7FlwJwxzTl2kn8IaeujIKc=;
        b=AWQTz4Pau2/UbzV0gD4UDl72E2iQJSZearFX+Hzbp0itLTqdtNkCkWEy7/DS7WJoLj
         2BXrDCAFbVhEXn05+g2CnB3aWbBCHT5UpacQfi+eZlhRmP/7g+8ieGH474Yk+aGYfOgd
         r12IaTjcr3vz/rbtEDNCZaWzJmqPCQmplrdhemho8/ghm8wxjm8cfFvEcOLGEMdPgr3E
         ko+IoEIagPDlJBcMHNZWuy35xGp0OCauWpOgsr1FlgQgREyRCk38P1sy/v/uMFs9gI/j
         8KaX32JNUsbUabLJPjCxvhCKhGO6cwDI9bqYqpi/IHJV53kkZ4TTn780VTImrclxq/60
         3XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9wI0zrpHRmLcU6l6ReXG7FlwJwxzTl2kn8IaeujIKc=;
        b=JQYwGOs5TQZrtclQwbJ3olSAyO29UKzRa/zPLjbvs/nWT9OkFQ0KB/G4iF5dAz1Cbi
         DP78VyKnw6H6XU07tzWFaq6GMzWPyHSy2VgTR34tg/a+RcfAIvSbooQaRrUTZdLJwHWn
         wMLjGEZBH/zLeYlj7KEIJNaBB/rBC9p0dqdi1WeSgf1MYdveAt8ynYAcaFXi+pPu2Fix
         ttfZsFZoKUbQj2dvDLn0Rpoc5kHq/HBhQ91CrsI3uMCgW9277+U5TVMwmHsGXckKNrut
         4chaFFP57JGWHT18nVYr798bsZFVT7jtIsEzHH3PoFveg/gGfm0Ivds94G059UERIn1T
         2G4A==
X-Gm-Message-State: AOAM533dkzTujgIV26n4DMHpBiROwDnNVEwU2R9DSMDfs0kyvcpAJOig
        Btk6OgqDwZs4gDvMnkSyfUMd
X-Google-Smtp-Source: ABdhPJxPvoeFfAo6RUxJOiaJWZrNziwqKzEQooxzqe4kW7GIjHjATC/oOEFynNN+CJ2IUuMOlUKfdQ==
X-Received: by 2002:a17:902:9a02:b0:14f:2d93:92f4 with SMTP id v2-20020a1709029a0200b0014f2d9392f4mr11061794plp.160.1648202531847;
        Fri, 25 Mar 2022 03:02:11 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm3062961pfc.214.2022.03.25.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 03:02:11 -0700 (PDT)
Date:   Fri, 25 Mar 2022 15:32:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/25] dmaengine: dw-edma: Replace chip ID number with
 device name
Message-ID: <20220325100204.GJ4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-23-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-23-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:33AM +0300, Serge Semin wrote:
> Using some abstract number as the DW eDMA chip identifier isn't really
> practical. First of all there can be more than one DW eDMA controller on
> the platform some of them can be detected as the PCIe end-points, some of
> them can be embedded into the DW PCIe Root Port/End-point controllers.
> Seeing some abstract number in for instance IRQ handlers list doesn't give
> a notion regarding their reference to the particular DMA controller.
> Secondly current DW eDMA chip id implementation doesn't provide the
> multi-eDMA platforms support for same reason of possibly having eDMA
> detected on different system buses. At the same time re-implementing
> something ida-based won't give much benefits especially seeing the DW eDMA
> chip ID is only used in the IRQ request procedure. So to speak in order to
> preserve the code simplicity and get to have the multi-eDMA platforms
> support let's just use the parental device name to create the DW eDMA
> controller name.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
>  drivers/dma/dw-edma/dw-edma-core.h | 2 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
>  include/linux/dma/edma.h           | 1 -
>  4 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index dbe1119fd1d2..72a51970bfba 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -970,7 +970,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (!dw->chan)
>  		return -ENOMEM;
>  
> -	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
> +	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
> +		 dev_name(chip->dev));
>  
>  	/* Disable eDMA, only to establish the ideal initial conditions */
>  	dw_edma_v0_core_off(dw);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 980adb079182..dc25798d4ba9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -96,7 +96,7 @@ struct dw_edma_irq {
>  };
>  
>  struct dw_edma {
> -	char				name[20];
> +	char				name[30];

I'm not sure if this length is sufficient. Other than this,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

>  
>  	struct dma_device		dma;
>  
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index f530bacfd716..3f9dadc73854 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -222,7 +222,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	/* Data structure initialization */
>  	chip->dev = dev;
> -	chip->id = pdev->devfn;
>  
>  	chip->mf = vsec_data.mf;
>  	chip->nr_irqs = nr_irqs;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 5cc87cfdd685..241c5a97ddf4 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -73,7 +73,6 @@ enum dw_edma_map_format {
>   */
>  struct dw_edma_chip {
>  	struct device		*dev;
> -	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
>  	u32			flags;
> -- 
> 2.35.1
> 
