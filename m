Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962E52231C
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbiEJRv5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343652AbiEJRv4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 13:51:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A32E759B8A;
        Tue, 10 May 2022 10:47:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7598312FC;
        Tue, 10 May 2022 10:47:58 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.5.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226DE3F73D;
        Tue, 10 May 2022 10:47:56 -0700 (PDT)
Date:   Tue, 10 May 2022 18:47:49 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v10 0/9] Enable designware PCI EP EDMA locally
Message-ID: <YnqlRShJzvma2SKM@lpieralisi>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
 <20220503231806.w2x4o2b3xymbwn74@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503231806.w2x4o2b3xymbwn74@mobilestation>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 02:18:06AM +0300, Serge Semin wrote:
> On Mon, May 02, 2022 at 07:57:52PM -0500, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> > 
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > 
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> > 
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > 
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: Add embedded DMA controller test
> > 
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> 
> As I have already said in my comment to v9, @Lorenzo, @Rob, @Vinod,
> my patchset:
> Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
> is based on this one. In its turn my series depends on the other
> patchsets:
> [PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
> [PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> which are currently on review. I am very much eager to get my patches
> merged in before the next merge windows. But in order to preserve the
> consistency of the corresponding repo with my patchsets the repo needs
> to have the @Frank' patches. Seeing aside with @Frank's series my changes
> depend on the changes in the clk and pci subsystems, could you please
> consider choosing a single repository for merging all my and @Frank
> patches in? Since the changes mostly concern the DW PCIe controller I
> suggest to use the 'pci/dwc' branch of the
> 'kernel/git/lpieralisi/pci.git' repository. What do you think?
> @Lorenzo?
> 

Sorry for the delay in replying. I think @Frank's series will
go via the DMA engine tree, I will do my best to review your
DWC changes:

[PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/

but I can't guarantee they will make v5.19 and after that I will
be AFK for two months, which is not good either, I will coordinate
with Bjorn to see what can we do on this, I am sorry but that's
all I have to offer at this stage.

Thanks,
Lorenzo

> -Sergey
> 
> > 
> > 
> > Frank Li (7):
> >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >   dmaengine: dw-edma: Detach the private data and chip info structures
> >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Add support for chip specific flags
> >   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> >   PCI: endpoint: Enable DMA controller tests for endpoints with DMA
> >     capabilities
> > 
> > Serge Semin (2):
> >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> >     semantics
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
> >  include/linux/dma/edma.h                      |  61 +++++++-
> >  9 files changed, 323 insertions(+), 185 deletions(-)
> > 
> > -- 
> > 2.35.1
> > 
