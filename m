Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF866BAF2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jan 2023 10:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjAPJx0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Jan 2023 04:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAPJwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Jan 2023 04:52:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11417177;
        Mon, 16 Jan 2023 01:52:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586FA60F2D;
        Mon, 16 Jan 2023 09:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B50CC433D2;
        Mon, 16 Jan 2023 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673862757;
        bh=98jxD3QqmDyydD9UoxzBOhPgaFRKkzyxHlZHzs6MtW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrb7DTo9A05liQcs2TydLyXGszCtNsYy8C9cAUfxvoOmqUhJBCYcVSKHE1kG1OskM
         6ek5Hy4v5ZJCqQnV6UaAAMro2HTVxu6qTll2fcV7/wMxvbeOAbFNxVKhY/MD3eIyQf
         0H4MTi2MvE7oOP06zX58/51xs5X56OFfHogACXEQrftRLyrE+wIZCfR/LeTjbNNDY6
         maQCY1E6csiLdnAMIvtoGn1ovCSeb8KE+3kgzf4Y5LwtpxVJDg8qHB0RF8KtMJkH/U
         jlXJ2IGNI2Gp3JoX7CnFhtIYpo9tfKxZOT/BcTE8Z1DH/GmzZgavU7evkgNSfezVGq
         lpToTQ74CRffQ==
Date:   Mon, 16 Jan 2023 10:52:29 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
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
Subject: Re: [PATCH v9 00/27] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <Y8UeXRUnLVtl1unZ@lpieralisi>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:13:42PM +0300, Serge Semin wrote:
> This is a final patchset in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: Done v5] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [3: Done v7] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.2-rc1
> [4: In-review v9] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> Link: ---you are looking at it---
> 
> Note it is very recommended to merge the patchsets in the same order as
> they are listed in the set above in order to have them applied smoothly.
> Since the patchsets 1-3 have already been merged into the mainline kernel
> this series can be applied via any DMA-engine or PCI repos.
> 
> Here is a short summary regarding this patchset. The series starts with
> fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
> initializes the LL/DT base addresses for the platforms with not matching
> CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
> method to get a correct base address. After that you can find a series of
> the interleaved xfers fixes. It turned out the interleaved transfers
> implementation didn't work quite correctly from the very beginning for
> instance missing src/dst addresses initialization, etc. In the framework
> of the next two patches we suggest to add a new platform-specific
> callback - pci_address() and use it to convert the CPU address to the PCIe
> space address. It is at least required for the DW eDMA remote End-point
> setup on the platforms with not-matching CPU/PCIe address spaces. In case
> of the DW eDMA local RP/EP setup the conversion will be done automatically
> by the outbound iATU (if no DMA-bypass flag is specified for the
> corresponding iATU window). Then we introduce a set of the patches to make
> the DebugFS part of the code supporting the multi-eDMA controllers
> platforms. It starts with several cleanup patches and is closed joining
> the Read/Write channels into a single DMA-device as they originally should
> have been. After that you can find the patches with adding the non-atomic
> io-64 methods usage, dropping DT-region descriptors allocation, replacing
> chip IDs with the device name. In addition to that in order to have the
> eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
> dma-ranges-based memory ranges mapping since in case of the root port DT
> node it's applicable for the peripheral PCIe devices only. Finally at the
> series closure we introduce a generic DW eDMA controller support being
> available in the DW PCIe Root Port/Endpoint driver.
> 
> Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Drop the patches:
>   [PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   [PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
>   since they are going to be merged in in the framework of the
>   Frank's patchset.
> - Add a new patch: "dmaengine: dw-edma: Release requested IRQs on
>   failure."
> - Drop __iomem qualifier from the struct dw_edma_debugfs_entry instance
>   definition in the dw_edma_debugfs_u32_get() method. (@Manivannan)
> - Add a new patch: "dmaengine: dw-edma: Rename DebugFS dentry variables to
>   'dent'." (@Manivannan)
> - Slightly extend the eDMA name array size. (@Manivannan)
> - Change the specific DMA mapping comment a bit to being
>   clearer. (@Manivannan)
> - Add a new patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
>   method."
> - Don't fail eDMA detection procedure if the DW eDMA driver couldn't probe
>   device. That happens if the driver is disabled. (@Manivannan)
> - Add "dma" registers resource mapping procedure. (@Manivannan)
> - Move the eDMA CSRs space detection into the dw_pcie_map_detect() method.
> - Remove eDMA on the dw_pcie_ep_init() internal errors. (@Manivannan)
> - Remove eDMA in the dw_pcie_ep_exit() method.
> - Move the dw_pcie_edma_detect() method execution to the tail of the
>   dw_pcie_ep_init() function.
> 
> Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - Conditionally set dchan->dev->device.dma_coherent field since it can
>   be missing on some platforms. (@Manivannan)
> - Drop the patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
>   method". A similar modification has been done in another patchset.
> - Add more comprehensive and less regression prune eDMA block detection
>   procedure.
> - Drop the patch: "dma-direct: take dma-ranges/offsets into account in
>   resource mapping". It will be separately reviewed.
> - Remove Manivannan tb tag from the modified patches.
> - Rebase onto the kernel v5.18.
> 
> Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru
> Changelog v4:
> - Rabase onto the laters Frank Li series:
> Link: https://lore.kernel.org/all/20220524152159.2370739-1-Frank.Li@nxp.com/
> - Add Vinod' Ab-tag.
> - Rebase onto the kernel v5.19-rcX.
> 
> Link: https://lore.kernel.org/linux-pci/20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru
> Changelog v5:
> - Just resend.
> - Rebase onto the kernel v6.0-rc2.
> 
> Link: https://lore.kernel.org/linux-pci/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru
> Changelog v6:
> - Fix some patchlog and in-line comments misspells. (@Bjorn)
> - Directly call *_dma_configure() method on the DW eDMA channel child
>   device used for the DMA buffers mapping. (@Robin)
> - Explicitly set the DMA-mask of the child device in the channel
>   allocation proecedure. (@Robin)
> - Rebase onto the kernel v6.1-rc3.
> 
> Link: https://lore.kernel.org/linux-pci/20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v7:
> - Activate the mapping auto-detection procedure for IP-cores older than
>   5.40a. The viewport-based access has been removed since that
>   version. (@Yoshihiro)
> - Drop the patch
>   [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
>   since the problem has been fixed in the commit f1ad5338a4d5 ("of: Fix
>   "dma-ranges" handling for bus controllers"). (@Robin)
> - Add a new patch:
>   [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data allocation
>   (@Robin)
> - Add a new patch:
>   [PATCH v7 24/25] PCI: bt1: Set 64-bit DMA-mask
>   (@Robin)
> 
> Link: https://lore.kernel.org/linux-pci/20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v8:
> - Add a new patch:
>   [PATCH v8 23/26] dmaengine: dw-edma: Relax driver config settings
>   (@tbot)
> - Replace the patch
>   [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data allocation
>   with a new one:
>   [PATCH v8 24/26] PCI: dwc: Set coherent DMA-mask on MSI-address allocation
>   (@Robin, @Christoph)
> 
> Link: https://lore.kernel.org/linux-pci/20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v9:
> - Add a new patch:
>   [PATCH v9 23/27] dmaengine: dw-edma: Add mem-mapped LL-entries support
>   (@tbot)
> - Rebase onto the kernel 6.2-rc3.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: caihuoqing <caihuoqing@baidu.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pci@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (27):
>   dmaengine: Fix dma_slave_config.dst_addr description
>   dmaengine: dw-edma: Release requested IRQs on failure
>   dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
>   dmaengine: dw-edma: Fix missing src/dst address of the interleaved
>     xfers
>   dmaengine: dw-edma: Don't permit non-inc interleaved xfers
>   dmaengine: dw-edma: Fix invalid interleaved xfers semantics
>   dmaengine: dw-edma: Add CPU to PCIe bus address translation
>   dmaengine: dw-edma: Add PCIe bus address getter to the remote EP
>     glue-driver
>   dmaengine: dw-edma: Drop chancnt initialization
>   dmaengine: dw-edma: Fix DebugFS reg entry type
>   dmaengine: dw-edma: Stop checking debugfs_create_*() return value
>   dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
>   dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
>   dmaengine: dw-edma: Rename DebugFS dentry variables to 'dent'
>   dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
>   dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
>   dmaengine: dw-edma: Join Write/Read channels into a single device
>   dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
>   dmaengine: dw-edma: Use non-atomic io-64 methods
>   dmaengine: dw-edma: Drop DT-region allocation
>   dmaengine: dw-edma: Replace chip ID number with device name
>   dmaengine: dw-edma: Skip cleanup procedure if no private data found
>   dmaengine: dw-edma: Add mem-mapped LL-entries support
>   dmaengine: dw-edma: Relax driver config settings
>   PCI: dwc: Set coherent DMA-mask on MSI-address allocation
>   PCI: bt1: Set 64-bit DMA-mask
>   PCI: dwc: Add DW eDMA engine support
> 
>  drivers/dma/dw-edma/Kconfig                   |   5 +-
>  drivers/dma/dw-edma/dw-edma-core.c            | 196 ++++-----
>  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  56 ++-
>  drivers/dma/dw-edma/dw-edma-v0-core.c         | 121 +++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 372 ++++++++----------
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
>  drivers/pci/controller/dwc/pcie-bt1.c         |   4 +
>  .../pci/controller/dwc/pcie-designware-ep.c   |  12 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  24 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 195 +++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  21 +
>  include/linux/dma/edma.h                      |  25 +-
>  include/linux/dmaengine.h                     |   2 +-
>  15 files changed, 652 insertions(+), 397 deletions(-)

Should I take the series in the PCI tree or do you prefer me acking
the relevant patches ?

Thanks,
Lorenzo
