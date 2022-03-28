Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A334E9926
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbiC1ORL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbiC1ORK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 10:17:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19DB27B2E
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 07:15:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t5so12761299pfg.4
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+agYA5Wfpr3oRXHHdc3m044GK5pIZW4dUBOUb2k/nL0=;
        b=kK8i557EBWokeFDt0lh1lYr/F9uMxmRYa5yTmsI8JNyAOlu90zmuPWX3QMxirY8Ddh
         1L5Ta707gh05dY2IqUyTaE4aeSSJuJg623auU5Fe9D4YXhOCS52YRxJYK1ZvrETHNUVB
         mUWuNTxaSfQYWfer7GDcoejogcyN3B2eFOiscot5xsWEiovCe6okXL75bCzRSFd6NMTm
         sNdhY16rq3ffwfjWmCaWFZM065Y7o+HI689z4X6bpHaciwfqHHGiLVznGmh/ljPzgXi5
         j5K+2fk7alHXgrpP5V0yYxLr/3hhcMLErGe7cC4PcmquOY989cKPccK4FTSQIwO/Bvh5
         IjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+agYA5Wfpr3oRXHHdc3m044GK5pIZW4dUBOUb2k/nL0=;
        b=bgpxKzBMC+oSM0Hw0OXx7YtvV4LLceWSjnYQsF0JjDyzW7ic+Ata+iEEhmKlc9YXG8
         CKNPqUpfW/UFW8tKuXkMOFaoPe9DEUX2ajKfMTsk4+U1DaLEDsLmq90P5HOiE6+4kyNc
         7n4L045hHYuQZxvrKql2XhG9gtUPiH+EcuyUneNpwqFQMApTK2JDL/EnIYGocRi+emTJ
         0XrVSkik7SooEa+q48JKf+loCXfqBoOogJMSPIg+/c7IEEJrSTDqTgiPm14v50BCUg3y
         zTPXkWP91xEdB8u+KozZ+B209Bzv8KAX95uns8WlYeHbTKKN73M2WL9ubZasMZgzp00K
         VUpw==
X-Gm-Message-State: AOAM53373ekQWFMcxMUMuQvsxJ0xelwxySsl2SUMoypGi31FkQss73ob
        LO/OA0eVk30nzpi3230I44wm
X-Google-Smtp-Source: ABdhPJxdKd2W/Ra1ix05qS0iOJUnrZhqO2JGuz2YZOuIYJgqCJAaKXn8FWeLw6dk3xaEdaw65KX1PA==
X-Received: by 2002:a65:6a08:0:b0:382:1af5:a4cb with SMTP id m8-20020a656a08000000b003821af5a4cbmr10265544pgu.398.1648476929266;
        Mon, 28 Mar 2022 07:15:29 -0700 (PDT)
Received: from thinkpad ([220.158.159.124])
        by smtp.gmail.com with ESMTPSA id z16-20020aa78890000000b004fad8469f88sm16253605pfe.38.2022.03.28.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:15:28 -0700 (PDT)
Date:   Mon, 28 Mar 2022 19:45:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/25] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220328141521.GA17663@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:36AM +0300, Serge Semin wrote:
> Since the DW eDMA driver now supports eDMA controllers embedded into the
> locally accessible DW PCIe Root Ports and End-points, we can use the
> updated interface to register DW eDMA as DMA engine device if it's
> available. In order to successfully do that the DW PCIe core driver need
> to perform some preparations first. First of all it needs to find out the
> eDMA controller CSRs base address, whether they are accessible over the
> Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
> the eDMA controller availability and number of it's read/write channels.
> If none was found the procedure will just silently halt with no error
> returned. Secondly the platform is supposed to provide either combined or
> per-channel IRQ signals. If no valid IRQs set is found the procedure will
> also halt with no error returned so to be backward compatible with
> platforms where DW PCIe controllers have eDMA embedded but lack of the
> IRQs defined for them. Finally before actually probing the eDMA device we
> need to allocate LLP items buffers. After that the DW eDMA can be
> registered. If registration is successful the info-message regarding the
> number of detected Read/Write eDMA channels will be printed to the system
> log in the same way as it's done for iATU settings.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
>  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  23 ++-
>  4 files changed, 225 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 23401f17e8f0..b2840d1a5b9a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -712,6 +712,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	ret = dw_pcie_edma_detect(pci);
> +	if (ret)
> +		return ret;
> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
>  		return -EINVAL;

eDMA needs to be removed on error path

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 715a13b90e43..048b452ee4f3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -405,14 +405,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> -	ret = dw_pcie_setup_rc(pp);
> +	ret = dw_pcie_edma_detect(pci);
>  	if (ret)
>  		goto err_free_msi;
>  
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_edma_remove;
> +
>  	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
>  		ret = pci->ops->start_link(pci);
>  		if (ret)
> -			goto err_free_msi;
> +			goto err_edma_remove;
>  	}
>  
>  	/* Ignore errors, the link may come up later */
> @@ -430,6 +434,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (pci->ops && pci->ops->stop_link)
>  		pci->ops->stop_link(pci);
>  
> +err_edma_remove:
> +	dw_pcie_edma_remove(pci);
> +
>  err_free_msi:
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
> @@ -452,6 +459,8 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
>  	if (pci->ops && pci->ops->stop_link)
>  		pci->ops->stop_link(pci);
>  
> +	dw_pcie_edma_remove(pci);
> +
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4a95a7b112e9..dbe39a7ecb71 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c

[...]

> +int dw_pcie_edma_detect(struct dw_pcie *pci)
> +{
> +	int ret;
> +
> +	pci->edma.dev = pci->dev;
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +
> +	pci->edma_unroll_enabled = dw_pcie_edma_unroll_enabled(pci);

Is is possible to continue the unroll path for eDMA if iATU unroll is enabled?

> +	if (pci->edma_unroll_enabled && pci->iatu_unroll_enabled) {
> +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> +		if (pci->atu_base != pci->dbi_base + DEFAULT_DBI_ATU_OFFSET)
> +			pci->edma.reg_base = pci->atu_base + PCIE_DMA_UNROLL_BASE;
> +		else
> +			pci->edma.reg_base = pci->dbi_base + DEFAULT_DBI_DMA_OFFSET;

This assumption won't work on all platforms. Atleast on our platform, the
offsets vary. So I'd suggest to try getting the reg_base from DT first and use
these offsets as a fallback as we do for iATU.

> +	} else {
> +		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> +		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> +	}
> +
> +	ret = dw_pcie_edma_detect_channels(pci);
> +	if (ret) {
> +		dev_err(pci->dev, "Unexpected NoF eDMA channels found\n");
> +		return ret;
> +	}
> +
> +	/* Skip any further initialization if no eDMA found */

Should we introduce a new Kconfig option for enabling eDMA? My concern here is,
if eDMA is really needed for an usecase and if the platform support is broken
somehow (DT issues?), then we'll just simply go ahead without probe failure and
it may break somewhere else.

And we are returning errors if something wrong happens during eDMA probe. This
might annoy the existing users who don't care about eDMA but turning those
errors to debug will affect the real users of eDMA.

For these reasons, I think it'd be better to probe eDMA only if the Kconfig
option is enabled (which would be disabled by default). And properly return the
failure.

Thanks,
Mani
