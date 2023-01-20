Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795F1676124
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jan 2023 00:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjATXBC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 18:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjATXBC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 18:01:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7DC138;
        Fri, 20 Jan 2023 15:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288A4620DA;
        Fri, 20 Jan 2023 22:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13245C4339B;
        Fri, 20 Jan 2023 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674255039;
        bh=MEdkFA0CPMoJscWoRwMiBqN7i9caRkJzCfAwCleyJBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cri+LDWeo4rXCVffkOhl0j+sWK07Fp2yQcqaMuEawSDbifPcfQUJZuVEQWJLwa1HD
         c424ZkNCraz6HaYhRNELpNgqjlXO55voAttvTzJ3pUB3I8WZiB5QEl+YiqgHGMHRq7
         tzbemNT+uETzFml8ak36pciA7JA1Arzq9ku0HJ5qlauwJ9q3rSe8VnLOq+dqXYneRR
         fNSEuNUopH8Py9GqYLW+crM1AboGkbO3eTrJDdrjPv6mb3QejrYQzOgaFNICoKwdXj
         kwmolb2aWC5kgblDsSfi1k4a3g2qMD1NYFGeauvNsp7tSGj/rp5CW2scUwxWvSvZh3
         jv019LHBM3XTw==
Date:   Fri, 20 Jan 2023 16:50:36 -0600
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
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230120225036.GA675763@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171409.30470-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:14:06PM +0300, Serge Semin wrote:
> Since the DW PCIe RP/EP driver is about to be updated to register the DW
> eDMA-based DMA-engine the drivers build modes must be synchronized.
> Currently the DW PCIe RP/EP driver is always built as a builtin module.
> Meanwhile the DW eDMA driver can be built as a loadable module. Thus in
> the later case the kernel with DW PCIe controllers support will fail to be
> linked due to lacking the DW eDMA probe/remove symbols. At the same time
> forcibly selecting the DW eDMA driver from the DW PCIe RP/EP kconfig will
> effectively eliminate the tristate type of the former driver fixing it to
> just the builtin kernel module.
> 
> Seeing the DW eDMA engine isn't that often met built into the DW PCIe
> Root-ports and End-points let's convert the DW eDMA driver config to being
> more flexible instead of just forcibly selecting the DW eDMA kconfig. In
> order to do that first the DW eDMA PCIe driver config should be converted
> to being depended from the DW eDMA core config instead of selecting the
> one. Second the DW eDMA probe and remove symbols should be referenced only
> if they are reachable by the caller. Thus the user will be able to build
> the DW eDMA core driver with any type, meanwhile the dependent code will
> be either restricted to the same build type (e.g. DW eDMA PCIe driver if
> DW eDMA driver is built as a loadable module) or just won't be able to use
> the eDMA engine registration/de-registration functionality (e.g. DW PCIe
> RP/EP driver if DW eDMA driver is built as a loadable module).

I'm trying to write the merge commit log, and I understand the linking
issue, but I'm having a hard time figuring out what the user-visible
scenarios are here.

I assume there's something that works when CONFIG_PCIE_DW=y and
CONFIG_DW_EDMA_PCIE=y but does *not* work when CONFIG_PCIE_DW=y and
CONFIG_DW_EDMA_PCIE=m?

If both scenarios worked the same, I would think the existing
dw_edma_pcie_probe() would be enough, and you wouldn't need to call
dw_pcie_edma_detect() from dw_pcie_host_init() and dw_pcie_ep_init().

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v8:
> - This is a new patch added on v8 stage of the series in order to fix
>   the tbot-reported build issues. (@tbot)
> ---
>  drivers/dma/dw-edma/Kconfig | 5 ++++-
>  include/linux/dma/edma.h    | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
> index 7ff17b2db6a1..2b6f2679508d 100644
> --- a/drivers/dma/dw-edma/Kconfig
> +++ b/drivers/dma/dw-edma/Kconfig
> @@ -9,11 +9,14 @@ config DW_EDMA
>  	  Support the Synopsys DesignWare eDMA controller, normally
>  	  implemented on endpoints SoCs.
>  
> +if DW_EDMA
> +
>  config DW_EDMA_PCIE
>  	tristate "Synopsys DesignWare eDMA PCIe driver"
>  	depends on PCI && PCI_MSI
> -	select DW_EDMA
>  	help
>  	  Provides a glue-logic between the Synopsys DesignWare
>  	  eDMA controller and an endpoint PCIe device. This also serves
>  	  as a reference design to whom desires to use this IP.
> +
> +endif # DW_EDMA
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 08833f12b386..c062c8db472c 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -101,7 +101,7 @@ struct dw_edma_chip {
>  };
>  
>  /* Export to the platform drivers */
> -#if IS_ENABLED(CONFIG_DW_EDMA)
> +#if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
>  #else
> -- 
> 2.39.0
> 
> 
