Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE164D45C
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 01:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLOAMT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Dec 2022 19:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLOALy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Dec 2022 19:11:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46754344;
        Wed, 14 Dec 2022 16:03:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so13146495lfv.2;
        Wed, 14 Dec 2022 16:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyTRtxLK9nOjvSiLHoGTWK+tByNJjpdgrWmjL9ZEwQc=;
        b=Joxw7UUQke3lmR3h+YHOkfFRovKyevEvAgKjIbriMUPy0B/7YWsVo1iXSCbj/Y0PM8
         0PNh65da1G2U8oVnXsUxcvGjX1J/bXayUvUNkjOrdCBAGAdBiVFbZhtfnWP75PDvHaBT
         es8ZznvU6ExZQE/l5R/89YyAC+UH6NrPmHxDgkjEisFCkY201fhSUo/zV15gVlMi0K5c
         oO+ckDzEaiRFQ1kk5MgCTBjll5vjOHdnuG5W0JdJQ6w/8tJ91Vvz+7znc0aABuYLLSvE
         YdWtVUfQS0w7qS8Yz0qPA57SikPbZYYhhR0QdX+sSEpZziQ7+B8O8wNZJ2DEljHD2dno
         pkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyTRtxLK9nOjvSiLHoGTWK+tByNJjpdgrWmjL9ZEwQc=;
        b=DBeKKc356ZaqfJqWQLqbYaCdDjoeVTgKHiCcYyv46S5HuJfJEdMAsRMrKCyw2Rlx/Y
         Zq7M4ObRb8SYgy836cFP1u1+/IRDl9dX+Z1qvndfvXrVuc+dkhSq9uQOBD8T6rplRSuO
         uFqKcH/JG8aKvw0h/P6xY8vOPghpXmsG0uAHfaxgEXVPzV/uoq0EZsEGbLm/PFpqU5gB
         ALMDGzTMdHC6NcF1+j3kXbHlumstUg2ashv4QgLeKhxQ5MV8Ssc8MZ74Z/6mxZsfhTTg
         ww76EHqY0Bg1xGQjYmfO2JhG/59EZ2ZAQhfjZmV4B9TzIfGYavt5OI4cJfipNpPz53FF
         bhEw==
X-Gm-Message-State: AFqh2krH0hUcty1QVeI+gJSJrEp+82SvFrw5L3KVixpRHBI7YzA6Z5c7
        inD440kMs4cp20N/raSUKA4=
X-Google-Smtp-Source: AMrXdXtt3aEW2Jg//O90nzVhrcgYitUZeQUtYxKsW9jy71g3Vjpd+0i2T5VH5+YXWwQHGEju2kU2+w==
X-Received: by 2002:a05:6512:400d:b0:4bb:70b2:6f50 with SMTP id br13-20020a056512400d00b004bb70b26f50mr303425lfb.52.1671062606848;
        Wed, 14 Dec 2022 16:03:26 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24ac1000000b00498f23c249dsm977465lfp.74.2022.12.14.16.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:03:26 -0800 (PST)
Date:   Thu, 15 Dec 2022 03:03:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Message-ID: <20221215000323.ixqqngxxdm7p2el6@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin

On Thu, Dec 15, 2022 at 02:53:03AM +0300, Serge Semin wrote:
> DW PCIe Root Ports and End-points can be equipped with the DW eDMA engine.
> In that case it is critical to have the platform device pre-initialized
> with a valid DMA-mask so the drivers using the eDMA-engine would be able
> to allocate the DMA-able buffers. The MSI-capable data requires to be
> allocated from the lowest 4GB region. Since that procedure implies the
> DMA-mask change we need to restore the mask set by the low-level drivers
> after the MSI-data allocation is done.

I dropped the patch
[PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
Link: https://lore.kernel.org/linux-pci/20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru/
from the series. It has turned to be useless since your commit
f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus controllers").
Instead I added the patches
[PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data allocation
and
[PATCH v7 24/25] PCI: bt1: Set 64-bit DMA-mask
to this patchset in order to properly handle the DMA-mask.

Could you please give your opinion on these patches?

-Serge(y)

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v7:
> - This is a new patch added on v7 stage of the series. (@Robin)
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 5762bd306261..1a3dae1f6aa2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -326,7 +326,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	u64 *msi_vaddr;
> +	u64 *msi_vaddr, dma_mask;
>  	int ret;
>  	u32 ctrl, num_ctrls;
>  
> @@ -366,6 +366,13 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  						    dw_chained_msi_isr, pp);
>  	}
>  
> +	/*
> +	 * Save and then restore the DMA-mask pre-set by the low-level drivers
> +	 * after allocating the MSI-capable region. The mask might be useful for
> +	 * the controllers with the embedded eDMA engine.
> +	 */
> +	dma_mask = dma_get_mask(dev);
> +
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> @@ -378,6 +385,10 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  		return -ENOMEM;
>  	}
>  
> +	ret = dma_set_mask_and_coherent(dev, dma_mask);
> +	if (ret)
> +		dev_warn(dev, "Failed to re-store DMA-mask\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.38.1
> 
> 
