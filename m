Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CFE6B6BDB
	for <lists+dmaengine@lfdr.de>; Sun, 12 Mar 2023 22:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCLVsG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Mar 2023 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCLVsF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Mar 2023 17:48:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37876B7;
        Sun, 12 Mar 2023 14:48:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n2so13330969lfb.12;
        Sun, 12 Mar 2023 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678657681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5y4jRO3tvVEIPg+bJu5nAZMjU2RPtX65wVjqo5C+Lo=;
        b=CP8bFj64K+DtQdYb4okIlrNP0nzhMCGnx7StzsM2nNPS+oZhfuu67dbiticE7wTAjg
         57HxjqwwuBEpc4J5GrpocXs2RtQNxmuBU3eyNgtWCxfb+S48E2eQTJ0Ep0AVQD2gtnyk
         UaqHeB5G/1XI1XDU15tCEZMW8YJJwdq7i/nrqPQ0zG/EIBLUDTI6lu4HkyZ7TggACmaX
         ppwVDHtHZHgD7j1ghf60Avj63gXZeDFebYnNXI9zavhqsf4P9rwZmP4Uwrqs/045jxOO
         IGr/7RWav/r7kuNRj+yjIWrj+EmId2TGBExLfrxcHJE+2CGhiAa+6xvM/UADAKzNGHDp
         HZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678657681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5y4jRO3tvVEIPg+bJu5nAZMjU2RPtX65wVjqo5C+Lo=;
        b=EJ6RiQVZxawfYCYjpu53IlWkpy1MofvZYMAmbu102C0j2Uq1cpOHVtg6fmEarM/rge
         bguwOPqDka87lFDAs4AcVhXZlrzSnRZ/Wf10jlE/regCvDKSMmDXsEnnypoc/b0VhR7x
         HoGe9NFndUckuZCvxvY+Ui+umxDtkccNb2A6ie7RU/RSKZgceGvRTzn3Chz38/v+Lr0V
         79WUBlxVihqZruEjlLk0VJ6o+VzRl/eyekeZ6XVUP2BSzDXOwgg7HCJTvfVEgIGF0OIe
         rDUaTrL5ppLPCS1wWwkiN881ApM8Q9ApLT1HWQx7PQvUvILAPSRY/r4pyuuFxNRkQAvN
         tjnQ==
X-Gm-Message-State: AO0yUKUJlKaya+Tav9DJPOiozSHENw4cBWgQnqR2hDW7um4G1mglm1y8
        MkzM4Uhlk0Eeoddc/usvI5s=
X-Google-Smtp-Source: AK7set8V8uz3tGUo7Fyp2Dbk0KDBJduMR7t8w0zfqzjPWhvVc973B2Sz5O5lhERxkbt2qLb5gxLaAA==
X-Received: by 2002:a05:6512:38c6:b0:4db:387f:a3af with SMTP id p6-20020a05651238c600b004db387fa3afmr8165964lft.4.1678657680821;
        Sun, 12 Mar 2023 14:48:00 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id j6-20020a19f506000000b004d2199ea23dsm766039lfb.0.2023.03.12.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:47:59 -0700 (PDT)
Date:   Mon, 13 Mar 2023 00:47:57 +0300
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
Subject: Re: [PATCH v6 1/5] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <20230312214757.i2nzjgxfm3jvvrbb@mobilestation>
References: <20230310032342.17395-1-cai.huoqing@linux.dev>
 <20230310032342.17395-2-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310032342.17395-2-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 10, 2023 at 11:23:34AM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 

> Rename dw_edma_core_ops structure to dw_edma_plat_ops, the ops is platform
> specific operations: the DMA device environment configs like IRQs,
> address translation, etc.

Drop this

> 
> The dw_edma_core_ops structure contains a set of the operations:
> device IRQ numbers getter, CPU/PCI address translation. Based on the
> functions semantics the structure name "dw_edma_plat_ops" looks more
> descriptive since indeed the operations are platform-specific. The
> "dw_edma_core_ops" name shall be used for a structure with the IP-core
> specific set of callbacks in order to abstract out DW eDMA and DW HDMA
> setups. Such structure will be added in one of the next commit in the
> framework of the set of changes adding the DW HDMA device support.
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

Drop this

Other than that looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> ---
> v5->v6:
>   1.Change the commit log to explain dw_edma_core_ops structure.
>   2.Revert the instance dw_edma_pcie_plat_ops.
> 
> v5 link:
> 	https://lore.kernel.org/lkml/20230303124642.5519-2-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c           | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  include/linux/dma/edma.h                     | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
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
> index d2638d9259dc..ed401c965a87 100644
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
> @@ -80,7 +80,7 @@ enum dw_edma_chip_flags {
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
