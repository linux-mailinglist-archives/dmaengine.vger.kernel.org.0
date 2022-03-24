Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058A44E66E6
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 17:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbiCXQYs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348403AbiCXQYq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 12:24:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27E205E9
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 09:23:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c23so5275154plo.0
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jN0efcoohqKl1PIpdMiTp80DLtECdVuZLnKEeBNGgVg=;
        b=ZW86nxdZcCjZpI1mIYCcyifjWGAFZD70ZLNCch9jH9xEBkIFeX4juAT04Q84jf/2Se
         Y0aFQHp1ve+Di+Y4IAD0tKvXlZLJnImBXFlk/VujOyTQCLmH9+lA6d2NtJrRFQz7txm3
         zZVGSQ/dYIdvrul1xg2ReGtce20c2+UJ/8cP8MGlhuz8+7ggf+c5Gtk83nzVkPiM3o3N
         oNslPCBp0dh0Xb2tj5QBS//7fY73aXB+PVE3jiIygjEXhVzErvtCBMmViSrkFdud3fvr
         7d687YmlDV0sOpQTzYKPHFwAEMafzLzDlCS+CnSn7O+ZlDY0PKjmCEwJbYFRA+BaXCEB
         Xsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jN0efcoohqKl1PIpdMiTp80DLtECdVuZLnKEeBNGgVg=;
        b=x6gQYl8CNKTcWWfkkmsrNN6XQ+oXDts+5tnR7dxzBLryyxAQwG7Xds6lJcIW7T/JIe
         qAaZIr9MK7CgQ5jmT6JIp0hIKxt4gllMHmcbVgwMG1yOAcWwxvnzDjl01tW7QvdRmTgn
         +sxWDYr4hlA1XyZnRli6rUwLVFpDC5NdsKwyI53RV1L9RDOspUtj9l2/vbpRyjz+drB4
         UXw3eySC7hiZJWEOY3FjEEZAdojy7+eGxlIzzvQLEDmpS1VeGqEX6gD2zIMtkaUJ5Par
         PdqYESO6MOgf5gRgjKTjSVbLrY4MtsiwquLe4mzoEcxRO1TAqNGkDdcx8LQhy2PnZ8YY
         WVgQ==
X-Gm-Message-State: AOAM532fuX9zANeERiiL+lmNbyfvyuP+KW3LLlR0WBikGfMZpK8Q7CJL
        qx4kpEXfxpTLywOZ9GRi8Yp9
X-Google-Smtp-Source: ABdhPJyCpECIXEL11rXKn1XKFCDSnPX48KjkZQCzRcWGR9PQbrX7SJNHzhSoBkkkppG59q6FnXKHRg==
X-Received: by 2002:a17:902:d504:b0:154:172:3677 with SMTP id b4-20020a170902d50400b0015401723677mr6800285plg.147.1648138990872;
        Thu, 24 Mar 2022 09:23:10 -0700 (PDT)
Received: from thinkpad ([27.111.75.5])
        by smtp.gmail.com with ESMTPSA id g12-20020a63b14c000000b00384332d9026sm2983645pgp.23.2022.03.24.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:23:10 -0700 (PDT)
Date:   Thu, 24 Mar 2022 21:53:04 +0530
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
Subject: Re: [PATCH 05/25] dmaengine: dw-edma: Convert ll/dt phys-address to
 PCIe bus/DMA address
Message-ID: <20220324162304.GO2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-6-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:16AM +0300, Serge Semin wrote:
> In accordance with the dw_edma_region.paddr field semantics it is supposed
> to be initialized with a memory base address visible by the DW eDMA
> controller. If the DMA engine is embedded into the DW PCIe Host/EP
> controller, then the address should belong to the Local CPU/Application
> memory. If eDMA is remotely accessible across the PCIe bus via the PCIe
> memory IOs, then the address needs to be a part of the PCIe bus memory
> space. The later case hasn't been well covered in the corresponding
> glue-driver. Since in general the PCIe memory space doesn't have to match
> the CPU memory space and the pci_dev.resource[] arrays contain the
> resources defined in the CPU memory space, a proper conversion needs to be
> performed, otherwise either the driver won't properly work or much worse
> the memory corruption will happen. The conversion can be done by means of
> the pci_bus_address() method. Let's use it to retrieve the LL, DT and CSRs
> PCIe memory ranges.
> 
> Note in addition to that we need to extend the dw_edma_region.paddr field
> size. The field normally contains a memory range base address to be set in
> the DW eDMA Linked-List pointer register or as a base address of the
> Linked-List data buffer. In accordance with [1] the LL range is supposed
> to be created in the Local CPU/Application memory, but depending on the DW
> eDMA utilization the memory can be created as a part of the PCIe bus
> address space (as in the case of the DW PCIe EP prototype kit). Thus in
> the former case the dw_edma_region.paddr field should have the dma_addr_t
> type, while in the later one - pci_bus_addr_t. Seeing the corresponding
> CSRs are always 64-bits wide let's convert the dw_edma_region.paddr field
> type to be u64 and let the client code logic to make sure it has a valid
> address visible by the DW eDMA controller. For instance the DW eDMA PCIe
> glue-driver initializes the field with the addresses from the PCIe bus
> memory space.
> 
> [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     v.5.40a, March 2019, p.1103
> 
> Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 8 ++++----
>  include/linux/dma/edma.h           | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index d6b5e2463884..04c95cba1244 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -231,7 +231,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		ll_region->vaddr += ll_block->off;
> -		ll_region->paddr = pdev->resource[ll_block->bar].start;
> +		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>  
> @@ -240,7 +240,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		dt_region->vaddr += dt_block->off;
> -		dt_region->paddr = pdev->resource[dt_block->bar].start;
> +		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> @@ -256,7 +256,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		ll_region->vaddr += ll_block->off;
> -		ll_region->paddr = pdev->resource[ll_block->bar].start;
> +		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>  
> @@ -265,7 +265,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		dt_region->vaddr += dt_block->off;
> -		dt_region->paddr = pdev->resource[dt_block->bar].start;
> +		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 8897f8a79b52..5abac9640a4e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -18,7 +18,7 @@
>  struct dw_edma;
>  
>  struct dw_edma_region {
> -	phys_addr_t	paddr;
> +	u64		paddr;
>  	void __iomem	*vaddr;
>  	size_t		sz;
>  };
> -- 
> 2.35.1
> 
