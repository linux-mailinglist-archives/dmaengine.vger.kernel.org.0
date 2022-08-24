Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7667859FFD1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiHXQvb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiHXQvW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 12:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F475A80E;
        Wed, 24 Aug 2022 09:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6EEB61A34;
        Wed, 24 Aug 2022 16:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FCFC433D6;
        Wed, 24 Aug 2022 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661359880;
        bh=cGAkc/rrARLF7e7NN9ARyeNoGB0+TSPpMWsWHg5rdfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XLxhRweehd12ykVqcG+n39k19vj8yTvdFthMnpD1PkSFPIUVEHIpad5L6dhkUrhHt
         eevbhB7j8o/zO19pa8RrDcfBI1ZH0rhCJeDsqqRpv1hqAVr5FqxV01iz9AVKVB3L/8
         NsVzAI1cCbvTeasbeeGA0XdLguCDTuKOYSR5uxxhV/NliMS/LMWHV4owCd7uGKcLa3
         p6tFtsnLOxeRAFihWe4iHP8IN1h5AR9j8vKNvvYtl+4iz6sr8xoX9JmbnAooCTGQw1
         jsnjWcjW+Ne+hEu8d7ZNdYcQVL/xeDcVUVxtAo4sOenWWq2LLtny2/g7WzH743OGqe
         5Ib1hR3TRE5Aw==
Date:   Wed, 24 Aug 2022 11:51:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 24/24] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220824165118.GA2785269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822185332.26149-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:
> Since the DW eDMA driver now supports eDMA controllers embedded into the
> locally accessible DW PCIe Root Ports and Endpoints, we can use the
> updated interface to register DW eDMA as DMA engine device if it's
> available. In order to successfully do that the DW PCIe core driver need
> to perform some preparations first. First of all it needs to find out the
> eDMA controller CSRs base address, whether they are accessible over the
> Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
> the eDMA controller availability and number of it's read/write channels.

s/it's//

> If none was found the procedure will just silently halt with no error
> returned. Secondly the platform is supposed to provide either combined or
> per-channel IRQ signals. If no valid IRQs set is found the procedure will
> also halt with no error returned so to be backward compatible with the
> platforms where DW PCIe controllers have eDMA embedded but lack of the
> IRQs defined for them. Finally before actually probing the eDMA device we
> need to allocate LLP items buffers. After that the DW eDMA can be
> registered. If registration is successful the info-message regarding the
> number of detected Read/Write eDMA channels will be printed to the system
> log in the similar way as it's done for the iATU settings.

s/in the similar way as it's done/as is done/

> +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> +
> +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> +	} else if (val != 0xFFFFFFFF) {

Consider PCI_POSSIBLE_ERROR() as an annotation about the meaning of
0xFFFFFFFF and something to grep for.

> +		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> +
> +		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> +	} else {
> +		return -ENODEV;
> +	}

> + * eDMA CSRs. DW PCIe IP-core v4.70a and older had the eDMA registers accessible
> + * over the Port Logic registers space. Afterwords the unrolled mapping was

s/Afterwords/Afterwards/

> + * introduced so eDMA and iATU could be accessed via a dedicated registers
> + * space.
