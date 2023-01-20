Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2785F675FD7
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jan 2023 22:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjATV75 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 16:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjATV74 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 16:59:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B63518C8;
        Fri, 20 Jan 2023 13:59:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D3F620A7;
        Fri, 20 Jan 2023 21:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7A5C433D2;
        Fri, 20 Jan 2023 21:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674251994;
        bh=z/TF8HRv18NKO5wlBtXhw5olLLHXMYHPTC7TCEbR49k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IUYh+OaltLchkGETuR6h21sSd+0BxSwtZYzK5ehopkonP7ZB3Da1ckwWZ5AhyHTQp
         jWJ+5XJDXMwJ1eM9cJorReqKpRVB42vV2Uo48FKcZPJcyJb7E4JxPuO55au9a/748q
         ux2xGYy8jmFaGudFF2j7/3xZvmON9A4CXtDvCFa/BRLJhenq5malxO+hYAhCxgs15F
         Y2D4T3qrWjo4lzHu+J2/W41CNqYfIPv0KaYbBvsfWzBFj/agTQVPC9IEDak1XoW6wz
         rpzVZTp1intM8uGKcZC+y9hymQ1TgPSoBhA0HkY0Zds9lXvn1srHIzxsy/0HIS5Jrg
         iEP3wpLOwG1JQ==
Date:   Fri, 20 Jan 2023 15:59:52 -0600
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
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 25/27] PCI: dwc: Set coherent DMA-mask on MSI-address
 allocation
Message-ID: <20230120215952.GA672871@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171409.30470-26-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:14:07PM +0300, Serge Semin wrote:
> The MSI target address requires to be reserved within the lowest 4GB
> memory in order to support the PCIe peripherals with no 64-bit MSI TLPs
> support. Since the allocation is done from the DMA-coherent memory let's
> modify the allocation procedure to setting the coherent DMA-mask only and
> avoiding the streaming DMA-mask modification. Thus at least the streaming
> DMA operations would work with no artificial limitations. It will be
> specifically useful for the eDMA-capable controllers so the corresponding
> DMA-engine clients would map the DMA buffers with no need in the SWIOTLB
> intervention for the buffers allocated above the 4GB memory region.
> 
> While at it let's add a brief comment about the reason of having the MSI
> target address allocated from the DMA-coherent memory limited with the 4GB
> upper bound.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> Changelog v8:
> - This is a new patch added on v8 stage of the series.
>   (@Robin, @Christoph)
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3ab6ae3712c4..e10608af39b4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -366,7 +366,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  						    dw_chained_msi_isr, pp);
>  	}
>  
> -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	/*
> +	 * Even though the iMSI-RX Module supports 64-bit addresses some
> +	 * peripheral PCIe devices may lack the 64-bit messages support. In
> +	 * order not to miss MSI TLPs from those devices the MSI target address
> +	 * has to be reserved within the lowest 4GB.
> +	 * Note until there is a better alternative found the reservation is
> +	 * done by allocating from the artificially limited DMA-coherent
> +	 * memory.
> +	 */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));

We used to restrict both streaming and coherent DMA masks to 32 bits.
Now we will only restrict coherent DMA to 32 bits.

So in essence this change removes a restriction on the streaming DMA
mask, right?

And I guess bt1 is the only driver where this will make a difference
(after the next patch) because no other dwc drivers set their own DMA
masks?

>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>  
> -- 
> 2.39.0
> 
> 
