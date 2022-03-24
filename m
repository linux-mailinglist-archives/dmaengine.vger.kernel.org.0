Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78E4E67C2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352258AbiCXR1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352245AbiCXR1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 13:27:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0DAA9958
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 10:26:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e5so5456896pls.4
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0mJjHBJTkqZcOIirK3ZwecAliSrcR7zrlWYhs3ogbow=;
        b=aJeKCC4or3w6Ev7MU7tqFxQK8ZE1KuHaPNUhynDNRMKBxmE+fvAyR2BZBgy5Vq+w0u
         ZFnPAbaW8R3AHaAqUs8hvC5k1BJKbjxmXHATc0q6eLnokaafp9tuYlgNotbEF9AeKsCl
         pJvegaGUVV3KOGJKbDpiwmsCAUGXlFGBW89cuFdrVb34oLxl+V3oaveiW5mfDykPB9E3
         w3nE9cQuVhbi07iRuF/lexi7+fTol7MUJShAxpxMPDoKSrMc6ES7AwgwBaTHc7acam0Q
         PbAZfls5yljev6Jw+cuq0ZwMryPPyxxRFNFMBm7o948CwLp+8Yk4KWEPQWPWPWHEr0xN
         krCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0mJjHBJTkqZcOIirK3ZwecAliSrcR7zrlWYhs3ogbow=;
        b=Zc8iDnIraiq5DoSZnKNARMzwxE4YC9m6tv87GAi49XXUwzJBMwWeFiKhZ3JebZmatX
         UYPLsE95OivK09SyqtRQWBzDgJNujUildM1jKUmUMYczfXGwlEVBrmIMYPwGHVH4yr9u
         16/UcuRMKqiconqNeIVPFjlT0VTe00vjn7TA/gv8koddg0yiaffhJADTW9H/QEhj1n+V
         BnvTalk2rGMP3kV5oVwqm67OlQI1phfzXxHzzWGcSeSwQr5UJCDno5MU3eU7CU3ZZkuP
         FlBhi4caRdF4iXvQoseQjWMUZ6Yx9Evz71ZsLTMYUg7ELibozxxORg1dKchElF3E+3M8
         uy6A==
X-Gm-Message-State: AOAM532Rm6oFNtWXurlxiT4RlHznpQUqIznYKEhGEfK+qJUUVO8SMKIN
        4TPpVZDkHFVStU0mCwDO9GcM
X-Google-Smtp-Source: ABdhPJwPe1MKGIP/Gs/Zjeasyw9s/FQMIYYnPnHM/QJvBePTmWpP3ucDYPiSrIV+3oxnnMP/m87LQg==
X-Received: by 2002:a17:902:8b87:b0:14d:7920:e54a with SMTP id ay7-20020a1709028b8700b0014d7920e54amr6976857plb.140.1648142762660;
        Thu, 24 Mar 2022 10:26:02 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090a521700b001bbfc181c93sm9691528pjh.19.2022.03.24.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:26:02 -0700 (PDT)
Date:   Thu, 24 Mar 2022 22:55:54 +0530
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
Subject: Re: [PATCH 09/25] dmaengine: dw-edma: Add CPU to PCIe bus address
 translation
Message-ID: <20220324172554.GR2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-10-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:20AM +0300, Serge Semin wrote:
> Starting from commit 9575632052ba ("dmaengine: make slave address
> physical") the source and destination addresses of the DMA-slave device
> have been converted to being defined in CPU address space. It's DMA-device
> driver responsibility to properly convert them to the reachable DMA bus
> spaces. In case of the DW eDMA device, the source or destination
> peripheral (slave) devices reside PCIe bus space. Thus we need to perform
> the PCIe Host/EP windows-based (i.e. ranges DT-property) addresses
> translation otherwise the eDMA transactions won't work as expected (or can
> be even harmful) in case if the CPU and PCIe address spaces don't match.
> 
> Note 1. Even though the DMA interleaved template has both source and
> destination addresses declared of dma_addr_t type only CPU memory range is
> supposed to be mapped in a way so to be seen by the DMA device since it's
> a subject of the DMA getting towards the system side. The device part must
> not be mapped since slave device resides in the PCIe bus space, which
> isn't affected by IOMMUs or iATU translations. DW PCIe eDMA generates
> corresponding MWr/MRd TLPs on its own.
> 
> Note 2. This functionality is mainly required for the remote eDMA setup
> since the CPU address must be manually translated into the PCIe bus space
> before being written to LLI.{SAR,DAR}. If eDMA is embedded into the
> locally accessible DW PCIe RP/EP software-based translation isn't required
> since it will be done by hardware by means of the Outbound iATU as long as
> the DMA_BYPASS flag is cleared. If the later flag is set or there is no
> Outbound iATU entry found to which the SAR or DAR falls in (for Read and
> Write channel respectfully), there won't be any translation performed but
> DMA will proceed with the corresponding source/destination address as is.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++++++++++++-
>  include/linux/dma/edma.h           | 15 +++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 97743fe44ebf..418b201fef67 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -40,6 +40,17 @@ struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
>  	return container_of(vd, struct dw_edma_desc, vd);
>  }
>  
> +static inline
> +u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
> +{
> +	struct dw_edma_chip *chip = chan->dw->chip;
> +
> +	if (chip->ops->pci_address)
> +		return chip->ops->pci_address(chip->dev, cpu_addr);
> +
> +	return cpu_addr;
> +}
> +
>  static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *burst;
> @@ -328,11 +339,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
>  	enum dma_transfer_direction dir = xfer->direction;
> -	phys_addr_t src_addr, dst_addr;
>  	struct scatterlist *sg = NULL;
>  	struct dw_edma_chunk *chunk;
>  	struct dw_edma_burst *burst;
>  	struct dw_edma_desc *desc;
> +	u64 src_addr, dst_addr;
>  	size_t fsz = 0;
>  	u32 cnt = 0;
>  	int i;
> @@ -407,6 +418,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		dst_addr = chan->config.dst_addr;
>  	}
>  
> +	if (dir == DMA_DEV_TO_MEM)
> +		src_addr = dw_edma_get_pci_address(chan, (phys_addr_t)src_addr);
> +	else
> +		dst_addr = dw_edma_get_pci_address(chan, (phys_addr_t)dst_addr);
> +
>  	if (xfer->type == EDMA_XFER_CYCLIC) {
>  		cnt = xfer->xfer.cyclic.cnt;
>  	} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 5abac9640a4e..5cc87cfdd685 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -23,8 +23,23 @@ struct dw_edma_region {
>  	size_t		sz;
>  };
>  
> +/**
> + * struct dw_edma_core_ops - platform-specific eDMA methods
> + * @irq_vector:		Get IRQ number of the passed eDMA channel. Note the
> + *                      method accepts the channel id in the end-to-end
> + *                      numbering with the eDMA write channels being placed
> + *                      first in the row.
> + * @pci_address:	Get PCIe bus address corresponding to the passed CPU
> + *			address. Note there is no need in specifying this
> + *			function if the address translation is performed by
> + *			the DW PCIe RP/EP controller with the DW eDMA device in
> + *			subject and DMA_BYPASS isn't set for all the outbound
> + *			iATU windows. That will be done by the controller
> + *			automatically.
> + */
>  struct dw_edma_core_ops {
>  	int (*irq_vector)(struct device *dev, unsigned int nr);
> +	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
>  };
>  
>  enum dw_edma_map_format {
> -- 
> 2.35.1
> 
