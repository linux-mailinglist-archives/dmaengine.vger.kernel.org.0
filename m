Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3A69EAD2
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 00:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBUXBA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 18:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjBUXA7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 18:00:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD2558A;
        Tue, 21 Feb 2023 15:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424CA6120E;
        Tue, 21 Feb 2023 23:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C303C433EF;
        Tue, 21 Feb 2023 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677020456;
        bh=8bmVqzYdGSQJBrlI/va5oEWARaelMvmFIsQmXscWXQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FhhSoLiOKfneaQLehBw4QHqvStnUSYRmqfUWsoDGeslX5+756eTVPXUDE2BT6NNQS
         NR9a91w5naG9e2IqwUfg7gIIpmLGyeb1pDFDYAy3NqJtHSnXrY2o6SP2Ob46/55LaR
         ip0j5QmOgvWYtj9nH7FDNcUsS6C+9doGAqrIWgmmUKDRrCKq97xFvAnub2hUFrn8zH
         3STdD38F4JOaIdWhU+BQwxclp9sZC+RZ9Th6NWksBknbTxXsmPGBv7Od8TpZU4p1Ep
         Y7fvGHKcXIBDd8nC8gx3u5TRwd2JtksKMaXKrWQXcurK6RFYUDf8fVY12VUeS7tEyb
         oY9NjwWo3I+IA==
Date:   Tue, 21 Feb 2023 17:00:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
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
        linux-kernel@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v9 23/27] dmaengine: dw-edma: Add mem-mapped LL-entries
 support
Message-ID: <20230221230054.GA3736402@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171409.30470-24-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:14:05PM +0300, Serge Semin wrote:
> Currently the DW eDMA driver only supports the linked lists memory
> allocated locally with respect to the remote eDMA engine setup. It means
> the linked lists will be accessible by the CPU via the MMIO space only. If
> eDMA is embedded into the DW PCIe Root Ports or local End-points (which
> support will be added in one of the following up commits) the linked lists
> are supposed to be allocated in the CPU memory. In that case the
> LL-entries can be directly accessed meanwhile the former case implies
> using the MMIO-accessors for that.
> 
> In order to have both cases supported by the driver the dw_edma_region
> descriptor should be fixed to contain the MMIO-backed and just
> memory-based virtual addresses. The linked lists initialization procedure
> will use one of them depending on the eDMA device nature. If the eDMA
> engine is embedded into the local DW PCIe RP/EP controllers then the list
> entries will be directly accessed by referencing the corresponding
> structure fields.  Otherwise the MMIO accessors usage will be preserved.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Hi Vinod, I just realized that I didn't solicit your ack for this
patch and the following one (which I ended up splitting into two), and
I hate to ask Linus to pull them without your OK.

Here are the current versions in the PCI tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=b47364a83054
  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=157ce95927c1
  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=536e6529e975

If you ack them, I will update them to reflect that.

Thanks,
  Bjorn

> Changelog v9:
> - This is a new patch added on v9 stage of the series.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 32 ++++++-------
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 69 +++++++++++++++++----------
>  include/linux/dma/edma.h              |  5 +-
>  3 files changed, 64 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3f9dadc73854..2b40f2b44f5e 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -240,20 +240,20 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
>  		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
>  
> -		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
> -		if (!ll_region->vaddr)
> +		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
> +		if (!ll_region->vaddr.io)
> ...
