Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FAE4E9C8D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243271AbiC1QqO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbiC1QqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EED20220C4;
        Mon, 28 Mar 2022 09:44:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8D61D1E493A;
        Thu, 24 Mar 2022 04:48:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8D61D1E493A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086518;
        bh=ckQ87WPTnxT61AdGkyIyqSu26w060GYud1Srpg67xm4=;
        h=From:To:CC:Subject:Date:From;
        b=he4V38X6dd//0y+FYKe4vGFADj13n3EASg9+bLhxKdCjTRJMit7YnSaSbYRJSZDtT
         iy3LC4cDfQHtdZjiJIoWZCW4YSqg2G3HXApFq7HiyBQuvB/ppDokCGcmo6oGIPPLrQ
         sl6COO0bZAZ4+AotOv9FDl4H3Zzzy27b1XQIXENs=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/25] dmaengine: dw-edma: Add RP/EP local DMA controllers support
Date:   Thu, 24 Mar 2022 04:48:11 +0300
Message-ID: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is a final patchset in the series created in the framework of
my Baikal-T1 PCIe/eDMA-related work:

[1: In-progress] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
Link: --submitted--
[2: In-progress] PCI: dwc: Various fixes and cleanups
Link: --submitted--
[3: In-progress] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
Link: --submitted--
[4: In-progress] dmaengine: dw-edma: Add RP/EP local DMA controllers support
Link: --you are looking at it--

Note it is recommended to merge the last patchset after the former ones in
order to prevent merge conflicts. @Bjorn could you merge in this patchset
through your PCIe repo? After getting all the ack'es of course.

Please note originally this series was self content, but due to Frank
being a bit faster in his work submission I had to rebase my patchset onto
his one. So now this patchset turns to be dependent on the Frank' work:
Link: https://lore.kernel.org/dmaengine/20220310192457.3090-1-Frank.Li@nxp.com/
So please review and merge his series first before applying this one.

@Frank, @Manivannan as we agreed here:
Link: https://lore.kernel.org/dmaengine/20220309211204.26050-6-Frank.Li@nxp.com/
this series contains two patches with our joint work. Here they are:
[PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
[PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
@Frank, could you please pick them up and add them to your series in place
of the patches:
[PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
Link: https://lore.kernel.org/dmaengine/20220310192457.3090-7-Frank.Li@nxp.com/
[PATCH v5 5/9] dmaengine: dw-edma: Fix programming the source & dest addresses for ep
Link: https://lore.kernel.org/dmaengine/20220310192457.3090-6-Frank.Li@nxp.com/
respectively?

@Frank please don't forget to fix your series so the chip->dw field is
initialized after all the probe() initializations are done. For that sake
you also need to make sure that the dw_edma_irq_request(),
dw_edma_channel_setup() and dw_edma_v0_core_debugfs_on() methods take
dw_edma structure pointer as a parameter.

Here is a short summary regarding this patchset. The series starts with
fixes patches. The very first two patches have been modified based on
discussion with @Frank and @Manivannan as I noted in the previous
paragraph. They concern fixing the Read/Write channels xfer semantics.
See the patches description for more details. After that goes the fix of
the dma_direct_map_resource() method, which turned out to be not working
correctly for the case of having devive.dma_range_map being non-empty
(non-empty dma-ranges DT property). Then we discovered that the
dw-edma-pcie.c driver incorrectly initializes the LL/DT base addresses for
the platforms with not matching CPU and PCIe memory spaces. It is fixed by
using the pci_bus_address() method to get a correct base address. After
that you can find a series of interleaved xfers fixes. It turned out the
interleaved transfers implementation didn't work quite correctly from the
very beginning for instance missing src/dst addresses initialization, etc.
In the framework of the next two patches we suggest to add a new
platform-specific callback - pci_addrees() and use to convert the CPU
address to the PCIe space address. It is at least required for the DW eDAM
remote End-point setup on the platforms with not-matching address spaces.
In case of the DW eDMA local RP/EP setup the conversion will be done
automatically by the outbound iATU (if no DMA-bypass flag is specified for
the corresponding iATU window). Then we introduce a set of patches to make
the DebugFS part of the code supporting the multi-eDMA controllers
platforms. It starts with several cleanup patches and is closed joining
the Read/Write channels into a single DMA-device as they originally should
have been. After that you can find the patches with adding the non-atomic
io-64 methods usage, dropping DT-region descriptors allocation, replacing
chip IDs with device name. In addition to that in order to have the eDMA
embedded into the DW PCIe RP/EP supported we need to bypass the
dma-ranges-based memory ranges mapping since in case of the root port DT
node it's applicable for the peripheral PCIe devices only. Finally at the
series closure we introduce a generic DW eDMA controller support being
available in the DW PCIe Host/End-point driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: linux-pci@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (25):
  dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
    semantics
  dma-direct: take dma-ranges/offsets into account in resource mapping
  dmaengine: Fix dma_slave_config.dst_addr description
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

 drivers/dma/dw-edma/dw-edma-core.c            | 249 +++++++------
 drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
 drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  76 ++--
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 350 ++++++++----------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
 .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
 .../pci/controller/dwc/pcie-designware-host.c |  13 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  23 +-
 include/linux/dma/edma.h                      |  18 +-
 include/linux/dmaengine.h                     |   2 +-
 kernel/dma/direct.c                           |   2 +-
 14 files changed, 598 insertions(+), 367 deletions(-)

-- 
2.35.1

