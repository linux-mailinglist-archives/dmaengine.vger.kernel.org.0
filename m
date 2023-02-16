Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF32699602
	for <lists+dmaengine@lfdr.de>; Thu, 16 Feb 2023 14:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBPNmY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Feb 2023 08:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBPNmX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Feb 2023 08:42:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65A55291;
        Thu, 16 Feb 2023 05:42:01 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s8so1989749ljp.2;
        Thu, 16 Feb 2023 05:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZYjJggXOXL46dSil1ea0yixaiqpsLjMvxrmPaE0WG0=;
        b=oKTFXsstpnYaCaBevgN8Lj1oymM/nUslVw1Nw1lQuomTN4jqn4lowPuakc7+zPjmMp
         gE1cYP5ZdDzNKmKmIq4yZ93xQg/3mbY1sIVgzbSOhhI5+EDTOPyycnChCyeTRIFfal+J
         +I+a6/l1YkjPCxlR/TGIbLO3+qRJmnRi/SolFzeM8CDDklqRx1ymPGrQOyh3arXQg2lD
         cs75LTnR2e+vBlt4lrAOgtcvjJikDiq/utimAKGXbuqzgZc+SCZWQZbNDtJ1Qg6/Blqd
         GirM4+l25D4GHg+jYIjh6eFp2YKntDrC9IVFbEeV7feSbFAqMm/EDht7yOKLlXpP/l+D
         tmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZYjJggXOXL46dSil1ea0yixaiqpsLjMvxrmPaE0WG0=;
        b=XiNZ8cppHM1aQfAOMB+sA0SthYapGgc3DRNqHYZYbbH1wS8wKMWxFfYoQ0ABzbnq41
         /uXLNPqSxH3bS/PZZnabfKthTkQ+2oPPEYjRbDeRco4TJ6yUEruh/Tyc01G2AS/q6Dy7
         md6LAP0ivlKvm/GQhmqi66EtsOehFn5JhYwcZIG+5u7SiINwA3DF8HX1XGB4sEdgaYlK
         50LeU3lTSaXOQvJq2q27snl7sfqVIsG73xCy730v1wD1AJweVKF7V/scVG4N1zWZxUFx
         gXMTA4WlQ3o5NrMLuOkn88OzE8AoJ/FNAOf/QOhZXmTgw2QucpzanNfKguysix84O3d/
         0wAQ==
X-Gm-Message-State: AO0yUKXckvJQ5n59ZGlYYPApGlI/Q2VHAT915GRfnTzbRe/J043/Wn/T
        HX5lCw4N0poI8bEDjC6tjP4=
X-Google-Smtp-Source: AK7set8Za8XwYW7+bDk0HqpPPwan/LM87m2COo8k54tL9H4vaOF2w1WtsouEynf8foe7MZ+9SE31Fw==
X-Received: by 2002:a2e:550:0:b0:294:6d2d:c18c with SMTP id 77-20020a2e0550000000b002946d2dc18cmr231543ljf.36.1676554919729;
        Thu, 16 Feb 2023 05:41:59 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id l14-20020a2e868e000000b0029328acc669sm205131lji.75.2023.02.16.05.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 05:41:59 -0800 (PST)
Date:   Thu, 16 Feb 2023 16:41:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <20230216134156.enjanyzwfhamve6q@mobilestation>
References: <20230213132411.65524-1-cai.huoqing@linux.dev>
 <20230213132411.65524-2-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213132411.65524-2-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 13, 2023 at 09:24:06PM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> Rename dw_edma_core_ops structure to dw_edma_plat_ops, the ops is platform
> specific operations: the DMA device environment configs like IRQs,
> address translation, etc.
> 

> The dw_edma_pcie_plat_ops name was supposed to refer to the platform which

s/dw_edma_pcie_plat_ops/dw_edma_plat_ops
* The main goal is to update the structure name.

> the DW eDMA engine is embedded to, like PCIe end-point (accessible via
> the PCIe bus) or a PCIe root port (directly accessible by CPU).
> Needless to say that for them the IRQ-vector and PCI-addresses are
> differently determined. The suggested name has a connection with the
> kernel platform device only as a private case of the eDMA/hDMA embedded
> into the DW PCI Root ports, though basically it was supposed to refer to
> any platform in which the DMA hardware lives.
> 
> Anyway the renaming was necessary to distinguish two types of
> the implementation callbacks:
> 1. DW eDMA/hDMA IP-core specific operations: device-specific CSR
> setups in one or another aspect of the DMA-engine initialization.
> 2. DW eDMA/hDMA platform specific operations: the DMA device
> environment configs like IRQs, address translation, etc.
> 

> dw_edma_pcie_core_ops is supposed to be used for the case 1, and
> dw_edma_pcie_plat_ops - for the case 2.

ditto

> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c           | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  include/linux/dma/edma.h                     | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2b40f2b44f5e..1c6043751dc9 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  	return region.start;
>  }
>  
> -static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> +static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
>  	.irq_vector = dw_edma_pcie_irq_vector,
>  	.pci_address = dw_edma_pcie_address,
>  };
> @@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	chip->mf = vsec_data.mf;
>  	chip->nr_irqs = nr_irqs;
> -	chip->ops = &dw_edma_pcie_core_ops;
> +	chip->ops = &dw_edma_pcie_plat_ops;
>  
>  	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..44e90b71d429 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -828,7 +828,7 @@ static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
>  	return platform_get_irq_byname_optional(pdev, name);
>  }
>  
> -static struct dw_edma_core_ops dw_pcie_edma_ops = {
> +static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index d2638d9259dc..b2f3dd5e7e1a 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -40,7 +40,7 @@ struct dw_edma_region {
>   *			iATU windows. That will be done by the controller
>   *			automatically.
>   */
> -struct dw_edma_core_ops {
> +struct dw_edma_plat_ops {
>  	int (*irq_vector)(struct device *dev, unsigned int nr);
>  	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
>  };
> @@ -48,7 +48,8 @@ struct dw_edma_core_ops {
>  enum dw_edma_map_format {
>  	EDMA_MF_EDMA_LEGACY = 0x0,
>  	EDMA_MF_EDMA_UNROLL = 0x1,
> -	EDMA_MF_HDMA_COMPAT = 0x5
> +	EDMA_MF_HDMA_COMPAT = 0x5,

> +	EDMA_MF_HDMA_NATIVE = 0x7
                                 ^
Please add a comma here ---------+

Thus if there is a new entry is added to the enum list in future the
update will consist of a single-line change. It's a common practice in
kernel to terminate the last entry in enums or struct initializers if
there is a possibility to add new entries to the list afterwards.

>  };
>  
>  /**
> @@ -80,7 +81,7 @@ enum dw_edma_chip_flags {
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			nr_irqs;

> -	const struct dw_edma_core_ops   *ops;
> +	const struct dw_edma_plat_ops   *ops;
                                     \ /
                                      ^
These are just three white-spaces ----+
Please replace them with either a tab or with a single space.

-Serge(y)

>  	u32			flags;
>  
>  	void __iomem		*reg_base;
> -- 
> 2.34.1
> 
