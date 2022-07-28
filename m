Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E85841D9
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiG1Ohd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiG1OfP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:15 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193B84504B
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:34 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id DF9F716D6;
        Thu, 28 Jul 2022 17:31:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com DF9F716D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018669;
        bh=UD+YzLh1bBZUGL3w7/OnY2t1g0oejpNemYf5S8H4z+U=;
        h=From:To:CC:Subject:Date:From;
        b=DDFDUxYiwP+JqkeWBhafE9f/ItxfWnR6oPk1/ZPJ3V89O8nUmHJDVmOQJboMY8jrS
         14bPNzWL1JG82NtOeBg0DyWT0oT4cLXgSJUAmkSrwZnFsx8MKBepU5qIU1L+UyMWI9
         TmN0C2emCtiQkN/yNh9M8A94HOkii8J++dvYfHjA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:28:43 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 00/24] dmaengine: dw-edma: Add RP/EP local DMA controllers support
Date:   Thu, 28 Jul 2022 17:28:17 +0300
Message-ID: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is a final patchset in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: Done v5] PCI: dwc: Various fixes and cleanups
Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
Link: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/ctrl/dwc-fixes
[2: Done v4] PCI: dwc: Add hw version and dma-ranges support
Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
[3: In-review v3] PCI: dwc: Add generic resources and Baikal-T1 support
Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
[4: Done v4] dmaengine: dw-edma: Add RP/EP local DMA support
Link: ---you are looking at it---

Note it is very recommended to merge the patchsets in the same order as
they are listed in the set above in order to have them applied smoothly.
Nothing prevents them from being reviewed synchronously though.

@Bjorn, as we agreed here:
Link: https://lore.kernel.org/linux-pci/20220616163533.GA1094478@bhelgaas
could you please merge this series into the 'pci/edma' branch of your repo:
Link: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/edma
Thanks.

Please note originally this series was self content, but due to Frank
being a bit faster in his work submission I had to rebase my patchset onto
his one. So now this patchset turns to be dependent on the Frank' work:

Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/

So please merge Frank' series first before applying this one (it's already
available in the 'pci/edma' branch of the @Bjorn' development repo).

Here is a short summary regarding this patchset. The series starts with
fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
initializes the LL/DT base addresses for the platforms with not matching
CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
method to get a correct base address. After that you can find a series of
the interleaved xfers fixes. It turned out the interleaved transfers
implementation didn't work quite correctly from the very beginning for
instance missing src/dst addresses initialization, etc. In the framework
of the next two patches we suggest to add a new platform-specific
callback - pci_address() and use it to convert the CPU address to the PCIe
space address. It is at least required for the DW eDMA remote End-point
setup on the platforms with not-matching CPU/PCIe address spaces. In case
of the DW eDMA local RP/EP setup the conversion will be done automatically
by the outbound iATU (if no DMA-bypass flag is specified for the
corresponding iATU window). Then we introduce a set of the patches to make
the DebugFS part of the code supporting the multi-eDMA controllers
platforms. It starts with several cleanup patches and is closed joining
the Read/Write channels into a single DMA-device as they originally should
have been. After that you can find the patches with adding the non-atomic
io-64 methods usage, dropping DT-region descriptors allocation, replacing
chip IDs with the device name. In addition to that in order to have the
eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
dma-ranges-based memory ranges mapping since in case of the root port DT
node it's applicable for the peripheral PCIe devices only. Finally at the
series closure we introduce a generic DW eDMA controller support being
available in the DW PCIe Root Port/Endpoint driver.

Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
Changelog v2:
- Drop the patches:
  [PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  [PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
  since they are going to be merged in in the framework of the
  Frank's patchset.
- Add a new patch: "dmaengine: dw-edma: Release requested IRQs on
  failure."
- Drop __iomem qualifier from the struct dw_edma_debugfs_entry instance
  definition in the dw_edma_debugfs_u32_get() method. (@Manivannan)
- Add a new patch: "dmaengine: dw-edma: Rename DebugFS dentry variables to
  'dent'." (@Manivannan)
- Slightly extend the eDMA name array size. (@Manivannan)
- Change the specific DMA mapping comment a bit to being
  clearer. (@Manivannan)
- Add a new patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
  method."
- Don't fail eDMA detection procedure if the DW eDMA driver couldn't probe
  device. That happens if the driver is disabled. (@Manivannan)
- Add "dma" registers resource mapping procedure. (@Manivannan)
- Move the eDMA CSRs space detection into the dw_pcie_map_detect() method.
- Remove eDMA on the dw_pcie_ep_init() internal errors. (@Manivannan)
- Remove eDMA in the dw_pcie_ep_exit() method.
- Move the dw_pcie_edma_detect() method execution to the tail of the
  dw_pcie_ep_init() function.

Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
Changelog v3:
- Conditionally set dchan->dev->device.dma_coherent field since it can
  be missing on some platforms. (@Manivannan)
- Drop the patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
  method". A similar modification has been done in another patchset.
- Add more comprehensive and less regression prune eDMA block detection
  procedure.
- Drop the patch: "dma-direct: take dma-ranges/offsets into account in
  resource mapping". It will be separately reviewed.
- Remove Manivannan tb tag from the modified patches.
- Rebase onto the kernel v5.18.

Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru
Changelog v4:
- Rabase onto the laters Frank Li series:
Link: https://lore.kernel.org/all/20220524152159.2370739-1-Frank.Li@nxp.com/
- Add Vinod' Ab-tag.
- Rebase onto the kernel v5.19-rcX.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: linux-pci@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (24):
  dmaengine: Fix dma_slave_config.dst_addr description
  dmaengine: dw-edma: Release requested IRQs on failure
  dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
  dmaengine: dw-edma: Fix missing src/dst address of the interleaved
    xfers
  dmaengine: dw-edma: Don't permit non-inc interleaved xfers
  dmaengine: dw-edma: Fix invalid interleaved xfers semantics
  dmaengine: dw-edma: Add CPU to PCIe bus address translation
  dmaengine: dw-edma: Add PCIe bus address getter to the remote EP
    glue-driver
  dmaengine: dw-edma: Drop chancnt initialization
  dmaengine: dw-edma: Fix DebugFS reg entry type
  dmaengine: dw-edma: Stop checking debugfs_create_*() return value
  dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
  dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
  dmaengine: dw-edma: Rename DebugFS dentry variables to 'dent'
  dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
  dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
  dmaengine: dw-edma: Join Write/Read channels into a single device
  dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
  dmaengine: dw-edma: Use non-atomic io-64 methods
  dmaengine: dw-edma: Drop DT-region allocation
  dmaengine: dw-edma: Replace chip ID number with device name
  dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
  dmaengine: dw-edma: Skip cleanup procedure if no private data found
  PCI: dwc: Add DW eDMA engine support

 drivers/dma/dw-edma/dw-edma-core.c            | 216 +++++-----
 drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
 drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  68 +---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 372 ++++++++----------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
 .../pci/controller/dwc/pcie-designware-ep.c   |  12 +-
 .../pci/controller/dwc/pcie-designware-host.c |  13 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 186 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  20 +
 include/linux/dma/edma.h                      |  18 +-
 include/linux/dmaengine.h                     |   2 +-
 13 files changed, 583 insertions(+), 364 deletions(-)

-- 
2.35.1

