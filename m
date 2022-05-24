Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A2532B14
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiEXNUK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiEXNUH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 09:20:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C0980B1
        for <dmaengine@vger.kernel.org>; Tue, 24 May 2022 06:20:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x143so16405712pfc.11
        for <dmaengine@vger.kernel.org>; Tue, 24 May 2022 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pm+h7FgyVcw6FPu3neF0tg9OqCxJcsWM13fqLtMUno0=;
        b=UXHnnKdtJR4P3hgd5fy87XVQuGpu+aVdjYst1hUquXXNO6dN72wfptvsmsBQ2vc3n7
         yhVIW7t0z1QEn6Fe3GSOTOd6F40orO3V9x4ReJXaD9/lyEVZTi/EXHdWqUqoAEETVetm
         jMTZNDFGNv/yK7d14Alt+JIDFL09lXrAeYjzFOxljiYwX8b46+h5LKCPwy8QNWM8P4Rg
         +Py8A2R0Ob9Rs6M6tI1raCbtUrFQEFZRh4h6cZch3ypIn65VUKdYm1F2yk9Vcq3twX5J
         gShHWl6Lt6R9U/6eP3N77qWekZrvmU42r501kslBgworqEx0+HsGPyp3L202yXMKMXR0
         ZUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pm+h7FgyVcw6FPu3neF0tg9OqCxJcsWM13fqLtMUno0=;
        b=2BG1uPnK91eESURTR5HAVQevRnTIR5I4B9tja5MbR6bYraqu5R/00UiynsHG0ohKBA
         /xgvCAgyL9l16RYVTD8lTuJ3aWaMqf2Jo7euOhVkLAZb87/hAST+R/6VzKY0uTgW5LEV
         iTLSOzMNptTC6LhurQplGXW/KWfmqpgpKIoyzqDs4DIxMV/Gd3ChFWQriKr+a+D47cuJ
         4OEDynR66aJZ+ssYTCBIeyEI5f5l6jAEw9kHUXl6qXeQj9UvknIwPsnT8ozqG4foQWD7
         XAChr1BQiBdziLoxUPnFJ+eAU/1hfaqLRe2x9sDSEYevmgSPhs330cmE8EbyjlowEvTR
         YE5A==
X-Gm-Message-State: AOAM532J/oQK6Gxt/SfFyWlXyTCuwkOY5nBk+oQ5wQodJ2jycaN+fGjh
        dfhgMiyLL3HGlAewNOPEix+c
X-Google-Smtp-Source: ABdhPJzejR8mK2jCqzKVM5D8tPWy+Bu4JMl9VEjAKH1ffnsi36QNt8JkxUSKliUpKMYN3iLUUFgz4Q==
X-Received: by 2002:a62:5c3:0:b0:50d:4274:4e9d with SMTP id 186-20020a6205c3000000b0050d42744e9dmr28513554pff.54.1653398406431;
        Tue, 24 May 2022 06:20:06 -0700 (PDT)
Received: from thinkpad ([59.92.99.145])
        by smtp.gmail.com with ESMTPSA id k22-20020a17090a591600b001cd4989ff62sm1703763pji.41.2022.05.24.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 06:20:06 -0700 (PDT)
Date:   Tue, 24 May 2022 18:49:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/26] dmaengine: dw-edma: Bypass dma-ranges mapping
 for the local setup
Message-ID: <20220524131959.GA5745@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-24-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-24-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:51:01AM +0300, Serge Semin wrote:
> DW eDMA doesn't perform any translation of the traffic generated on the
> CPU/Application side. It just generates read/write AXI-bus requests with
> the specified addresses. But in case if the dma-ranges DT-property is
> specified for a platform device node, Linux will use it to map the CPU
> memory regions into the DMAable bus ranges. This isn't what we want for
> the eDMA embedded into the locally accessed DW PCIe Root Port and
> End-point. In order to work that around let's set the chan_dma_dev flag
> for each DW eDMA channel thus forcing the client drivers to getting a
> custom dma-ranges-less parental device for the mappings.
> 
> Note it will only work for the client drivers using the
> dmaengine_get_dma_device() method to get the parental DMA device.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> ---
> 
> Changelog v2:
> - Fix the comment a bit to being clearer. (@Manivannan)
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 6a8282eaebaf..908607785401 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -716,6 +716,21 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>  
> +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> +	 * controlled from the CPU/Application side since in that case
> +	 * the local memory address is left untranslated.
> +	 */
> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +		dchan->dev->chan_dma_dev = true;
> +
> +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;

I happen to test this series on Qcom ARM32 machine and it errors out during the
compilation due to "dma_coherent" not available on !SWIOTLB ARM32 configs.

Thanks,
Mani

> +		dma_coerce_mask_and_coherent(&dchan->dev->device,
> +					     dma_get_mask(chan->dw->chip->dev));
> +		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
> +	} else {
> +		dchan->dev->chan_dma_dev = false;
> +	}
> +
>  	pm_runtime_get(chan->dw->chip->dev);
>  
>  	return 0;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
