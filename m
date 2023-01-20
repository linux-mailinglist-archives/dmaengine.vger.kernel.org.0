Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E782F676192
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jan 2023 00:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjATX31 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 18:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjATX30 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 18:29:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC7762E0;
        Fri, 20 Jan 2023 15:29:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABAA620DD;
        Fri, 20 Jan 2023 23:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A9DC4339C;
        Fri, 20 Jan 2023 23:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674257362;
        bh=OzMy1pibNfoV7yhVZ0QHEUMQPHCPIA6G8Bauyor+91I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BerBuk9proGIBBa8RkZ4pRzMSZMugrs7axcI6QMTSwpLPqFMCfGYl+h8Bko5U31Z/
         pXNPJEdrVjuE7LXtm6Lr0HlLCF/Cy3ris3Hun6Xc7DBDA7dZV/YAN9BnAi3ehgXCs2
         cG/VhX8tk/eOL2TzZVYpnEL65ptomOkAsFc+KMgGnxqBLvIv9T5Vyh2IG7DU67TNfP
         iV9oXCVvthFy8NfyWbjT8gvL494BUjfUlYuGt1B5i+m3akC2itTGYEPIfl014U1Upm
         MH0gHDjKBmVCmrl8/Ln0iFfv/xulykbAl+/73cgaZYsaigNEV3mStA+xo7Y5zdJkuF
         1Vlg5/M4NuJpw==
Date:   Fri, 20 Jan 2023 17:29:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/27] dmaengine: dw-edma: Add PCIe bus address getter
 to the remote EP glue-driver
Message-ID: <20230120232920.GA681120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171409.30470-9-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:13:50PM +0300, Serge Semin wrote:
> In general the Synopsys PCIe EndPoint IP prototype kit can be attached to
> a PCIe bus with any PCIe Host controller including to the one with
> distinctive from CPU address space. Due to that we need to make sure that
> the source and destination addresses of the DMA-slave devices are properly
> converted to the PCIe bus address space, otherwise the DMA transaction
> will not only work as expected, but may cause the memory corruption with
> subsequent system crash. Let's do that by introducing a new
> dw_edma_pcie_address() method defined in the dw-edma-pcie.c, which will
> perform the denoted translation by using the pcibios_resource_to_bus()
> method.
> 
> Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> 
> ---
> 
> Note this patch depends on the patch "dmaengine: dw-edma: Add CPU to PCIe
> bus address translation" from this series.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 04c95cba1244..f530bacfd716 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -95,8 +95,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  	return pci_irq_vector(to_pci_dev(dev), nr);
>  }
>  
> +static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_bus_region region;
> +	struct resource res = {
> +		.flags = IORESOURCE_MEM,
> +		.start = cpu_addr,
> +		.end = cpu_addr,
> +	};
> +
> +	pcibios_resource_to_bus(pdev->bus, &region, &res);
> +	return region.start;
> +}

This doesn't look DW-specific.  Do you expect other implementations
that are specific, or could this be a generic function that shares
some implementation with pci_bus_address()?

>  static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
>  	.irq_vector = dw_edma_pcie_irq_vector,
> +	.pci_address = dw_edma_pcie_address,
>  };
>  
>  static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> -- 
> 2.39.0
> 
> 
