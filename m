Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE89665CD2
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jan 2023 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjAKNlU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Jan 2023 08:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjAKNku (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Jan 2023 08:40:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39EBB11A37;
        Wed, 11 Jan 2023 05:39:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00C9C13D5;
        Wed, 11 Jan 2023 05:40:26 -0800 (PST)
Received: from [10.57.68.138] (unknown [10.57.68.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 067423F71A;
        Wed, 11 Jan 2023 05:39:40 -0800 (PST)
Message-ID: <fa491b99-5e05-b436-9304-32baeb019750@arm.com>
Date:   Wed, 11 Jan 2023 13:39:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 24/26] PCI: dwc: Set coherent DMA-mask on MSI-address
 allocation
Content-Language: en-GB
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru>
 <20221219144658.26620-25-Sergey.Semin@baikalelectronics.ru>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221219144658.26620-25-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-12-19 14:46, Serge Semin wrote:
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

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v8:
> - This is a new patch added on v8 stage of the series.
>    (@Robin, @Christoph)
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3ab6ae3712c4..e10608af39b4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -366,7 +366,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   						    dw_chained_msi_isr, pp);
>   	}
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
>   	if (ret)
>   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>   
