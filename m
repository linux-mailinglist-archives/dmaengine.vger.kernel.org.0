Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F143669684
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjAMMMN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 07:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjAMML3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 07:11:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7A7A922;
        Fri, 13 Jan 2023 04:04:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCCC261704;
        Fri, 13 Jan 2023 12:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2589AC433EF;
        Fri, 13 Jan 2023 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673611496;
        bh=nPr/NKAEqyB20pLfjVKLni1cuewC0KvKd5eN/llyWns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7FUc2QJpGJnlOx4rfsced8r/HOCpDzS3QQOaPDoQg9LADymB2vk3ARBxRiEnDBAA
         c1v6olylFVeJ+cOfFk81yvZOSlmF2KguuPIn3iuO/ApAj7coA573QYODJytEd/rtSa
         T5NBqscqDnPaf3aKS75mxwdn9XB2NfSp8jZOVeA2kBF/zZusEfbZ+vEWlIaoJ2j0pE
         ruJIgVvGtD28YOVFI9JJesKOCzZItINFs48c1v2ZRSr5GJs7GyPc4zqVq0bdcXvx2D
         xXGJ8YR8K8L35fjnQ/83kpeq6Q+l9xv0rZ1CRoKEDs/qQvt92Q6amL0FQoNZfWlIo4
         BrOPwW5VlB4tQ==
Date:   Fri, 13 Jan 2023 13:04:46 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 24/25] PCI: bt1: Set 64-bit DMA-mask
Message-ID: <Y8FI3m0Yare5gCeM@lpieralisi>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214235305.31744-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Dec 15, 2022 at 02:53:04AM +0300, Serge Semin wrote:
> The DW PCIe RC IP-core is synthesized with the 64-bits AXI address bus.
> Since the device is also equipped with the eDMA engine we need to
> explicitly set the device DMA-mask so the DMA-engine clients would be able
> to allocate the data buffers from the DMA-able memory space.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v7:
> - This is a new patch added on v7 stage of the series. (@Robin)
> ---
>  drivers/pci/controller/dwc/pcie-bt1.c | 4 ++++
>  1 file changed, 4 insertions(+)

Hi Robin,

are you OK with this change ? I think that's the last (PCI) bit we
need to take the series.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> index 8b6c7d544d9a..04aa58348aa5 100644
> --- a/drivers/pci/controller/dwc/pcie-bt1.c
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -583,6 +583,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
>  	struct device *dev = &btpci->pdev->dev;
>  	int ret;
>  
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return ret;
> +
>  	btpci->dw.version = DW_PCIE_VER_460A;
>  	btpci->dw.dev = dev;
>  	btpci->dw.ops = &bt1_pcie_ops;
> -- 
> 2.38.1
> 
> 
