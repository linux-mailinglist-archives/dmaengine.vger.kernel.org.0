Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37E5A79ED
	for <lists+dmaengine@lfdr.de>; Wed, 31 Aug 2022 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiHaJRk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Aug 2022 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHaJRj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Aug 2022 05:17:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97BE77C53B;
        Wed, 31 Aug 2022 02:17:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA65ED1;
        Wed, 31 Aug 2022 02:17:44 -0700 (PDT)
Received: from [10.57.15.237] (unknown [10.57.15.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8023F71A;
        Wed, 31 Aug 2022 02:17:35 -0700 (PDT)
Message-ID: <7a035b29-fca6-2650-c3c1-eedb3904c32d@arm.com>
Date:   Wed, 31 Aug 2022 10:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND v5 22/24] dmaengine: dw-edma: Bypass dma-ranges
 mapping for the local setup
Content-Language: en-GB
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220822185332.26149-23-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-08-22 19:53, Serge Semin wrote:
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

No, this is nonsense. If the DMA engine is on the host side of the 
bridge then it should not have anything to do with the PCI device at 
all, it should be associated with the platform device, and thus any 
range mapping on the bridge itself would be irrelevant anyway.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-By: Vinod Koul <vkoul@kernel.org>
> 
> ---
> 
> Changelog v2:
> - Fix the comment a bit to being clearer. (@Manivannan)
> 
> Changelog v3:
> - Conditionally set dchan->dev->device.dma_coherent field since it can
>    be missing on some platforms. (@Manivannan)
> - Remove Manivannan' rb and tb tags since the patch content has been
>    changed.
> ---
>   drivers/dma/dw-edma/dw-edma-core.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 6a8282eaebaf..4f56149dc8d8 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -716,6 +716,26 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>   	if (chan->status != EDMA_ST_IDLE)
>   		return -EBUSY;
>   
> +	/* Bypass the dma-ranges based memory regions mapping for the eDMA
> +	 * controlled from the CPU/Application side since in that case
> +	 * the local memory address is left untranslated.
> +	 */
> +	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +		dchan->dev->chan_dma_dev = true;
> +
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> +		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
> +#endif
> +
> +		dma_coerce_mask_and_coherent(&dchan->dev->device,
> +					     dma_get_mask(chan->dw->chip->dev));
> +		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
> +	} else {
> +		dchan->dev->chan_dma_dev = false;
> +	}

NAK. Don't try to poke into DMA API internals and copy random partial 
pieces between devices, it doesn't work properly (I can guess that your 
system doesn't have an IOMMU...) and having to deal with ugly mess like 
this in drivers just makes it harder for us to maintain the DMA API itself.

Fair enough if you have good reason to create logical child devices to 
represent individual DMA channels, but the correct way to handle that is 
to keep the real parent device pointer around and use that for DMA API 
calls.

Robin.

> +
>   	pm_runtime_get(chan->dw->chip->dev);
>   
>   	return 0;
