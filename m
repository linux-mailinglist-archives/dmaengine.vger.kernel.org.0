Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA916A89C3
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 20:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBTtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 14:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCBTtS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 14:49:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DA1449D;
        Thu,  2 Mar 2023 11:49:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s22so696640lfi.9;
        Thu, 02 Mar 2023 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/LE1LGKEFbNW8yb5MsEne9MolhQsdckV6+t3w0MY40=;
        b=pEHWQUcCXC1wT7nv16W53c9wZNPj+vvaCcg+81/tsLbo2e7siCi7f6qrgtnl/ZGBq1
         cQvOxShUiaeouwdQS7yc8PaAk8la4zdnODXhh6gTlEhqsqcuXZpMZ+2heA/9sWPzlWJs
         MDbfj5kp5lI59SgxFJtppjC8NdmlW/5rNk7lTvHqUlPwCxnQtCtud54q4EQzV5jaf4al
         lpHOxfoPS9vOkv1aqZ8sDmdt1wd6DmJGbZzFFL0reF3d3RXsX9Or0SnoM8GKyXcdXcto
         Mxw7F2OJDZ6TYbQMNYtd9yTwxrRRIcOR/3k3UalcyRtI7SC7/cCtw+CVX4R0G2FWPuPw
         HprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/LE1LGKEFbNW8yb5MsEne9MolhQsdckV6+t3w0MY40=;
        b=kgqU+mHNFCIFMHrEdkNL5oOn9isy26/9jMf+7lMsrEF0gE3x0S6Lk47Er0rqZjvqYj
         WQJxKd24CdYGH4NhmlFyijOy7MCUl+8YfHLzo/VLWWoka/3n72ZaE8pQmuCHYlDAef2+
         F9LS0fD2DrUFnVoNFmTJbiP9Lj0LR5eW+tkqnIqnGLlB0VNSgjpGKylMCLpyDr2v4H0P
         lxP+V5W9qlSliUXT2mjYezUgxlu9Sf0Ns5PYqcubDObO/ESK30ynBqtlHK6omwgNz8Mh
         FNhJWQlDOa1DqyjG1jQ6WzRI8/Sh17B5tBHYIv/HYHIodxGJ+kSrxuXNdgL6FhvE3Whf
         RxjQ==
X-Gm-Message-State: AO0yUKXgY5sN+NIIjhuXlUJcdJyOGqZ/xUtrHByRzCQrQ0jqLsu5bhcd
        Mj85j6S0CqNqJi+ejpsf+W8=
X-Google-Smtp-Source: AK7set87/ik/bEjLjgTRdV0mt3C5g9aACCnE2d60MrKDFeFtY/SMuDbdYMT24twuhXxcbLERutNFng==
X-Received: by 2002:a19:f505:0:b0:4dd:a565:8b8 with SMTP id j5-20020a19f505000000b004dda56508b8mr2998244lfb.57.1677786554571;
        Thu, 02 Mar 2023 11:49:14 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b004db513b0175sm52604lfl.136.2023.03.02.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:49:14 -0800 (PST)
Date:   Thu, 2 Mar 2023 22:49:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <20230302194911.7qyn3vk3gfbqt5gw@mobilestation>
References: <20230221034656.14476-1-cai.huoqing@linux.dev>
 <20230221034656.14476-2-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221034656.14476-2-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 21, 2023 at 11:46:52AM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> Rename dw_edma_core_ops structure to dw_edma_plat_ops, the ops is platform
> specific operations: the DMA device environment configs like IRQs,
> address translation, etc.
> 
> The dw_edma_plat_ops name was supposed to refer to the platform which
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
> dw_edma_core_ops is supposed to be used for the case 1, and
> dw_edma_plat_ops - for the case 2.
> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> ---
>   v3->v4:
>     [1/4]
>     1.Update the structure name dw_edma_plat_ops in commit log
>     2.Fix code stytle.
> 
>   v3 link:
>   https://lore.kernel.org/lkml/20230213132411.65524-2-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c           | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  include/linux/dma/edma.h                     | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2b40f2b44f5e..798cb0662cef 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  	return region.start;
>  }
> 
 
> -static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> +static const struct dw_edma_plat_ops dw_edma_plat_ops = {

Why have you changed the prefix since v3? The instance was correct
there preserving the local naming convention:
-static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
+static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {

>  	.irq_vector = dw_edma_pcie_irq_vector,
>  	.pci_address = dw_edma_pcie_address,
>  };
> @@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	chip->mf = vsec_data.mf;
>  	chip->nr_irqs = nr_irqs;

> -	chip->ops = &dw_edma_pcie_core_ops;
> +	chip->ops = &dw_edma_plat_ops;

ditto

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
> index d2638d9259dc..3080747689f6 100644
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
> +	EDMA_MF_HDMA_NATIVE = 0x7,

Just noticed that this change isn't related with what the patch log
states. Please move it to [PATCH vX 3/4] "dmaengine: dw-edma: Add
support for native HDMA" of the series which introduces the new
mapping.

-Serge(y)

>  };
>  
>  /**
> @@ -80,7 +81,7 @@ enum dw_edma_chip_flags {
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			nr_irqs;
> -	const struct dw_edma_core_ops   *ops;
> +	const struct dw_edma_plat_ops	*ops;
>  	u32			flags;
>  
>  	void __iomem		*reg_base;
> -- 
> 2.34.1
> 
