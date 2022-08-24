Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C72B59FCBF
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiHXOIH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiHXOIF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 10:08:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0F44542;
        Wed, 24 Aug 2022 07:08:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so15115611lfb.7;
        Wed, 24 Aug 2022 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=E0CG0DrryLpU+UCEBU22L4+M6TrrPgcC3P/2h/Fu7l8=;
        b=VEe+xsJ7cCsGLe8UqPwgQ3JHIeCU6nI5x71EURgUpemhL3JLwbv3WDs+2TlisnsstG
         Ck9ObEcg2VJywOM3Q1UqPHxMJIKERFj8AOW2rXVxeHKrJDsKildhkte7zNmZ1Yq1l/W9
         su/SORAWmeLtyI4F/uo275YYZ6iHlQPwpoeDhRRXJudqGoEMGcxVdXIsRyUBgspVA200
         HM9P5HMSjMuZ0JTZ2c6dgEc+uKKwThD1OQfQsWBeJli4K28svAYyH6zpiOx6OPAK3+Je
         Oz4kbanGGuCMAYz3+DXYkiGJqK+oBOrLaaKeKqddQfO0YWIfTyiYDrqY1n4jOmMYmnz1
         VJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=E0CG0DrryLpU+UCEBU22L4+M6TrrPgcC3P/2h/Fu7l8=;
        b=Ne60S+AaJ4a44FNMiAE6L5Zw2T1QEtcfNB6kwbehfdVXD1OIb1mOy5ZrtaqZnfXQ4z
         uxhFpt82mWIsC4iIz+QHDd6wJ1CdF+tjSscr+H98/3S4hhLGfufgxkpEhmrZA5Glb7ct
         /i3eFMVC2DJCKDLe2DnRyMt4gcryjoc6J6gPesaoXU5Yuw+7PNFICC/PYjl30eLo/jL5
         YfiWHwkPduT6nxUeTx1AVXVchugY2ep4XXqHvab7YOG0Af4errX1GucEA7E5+F0Pew82
         rxSyzYQoqE63uZl2fULWXbDAGRSqm+Vys7H5mjVOQRASotiBW8rZGw9IRjt8LnzJvd5B
         mxAg==
X-Gm-Message-State: ACgBeo2kO6HaruwaH/ziJ8vq2Qcg3AfiYnGZXisi8yRLldV52IXlVrqh
        5YkmjBk9ZoN/BDp/t6E2Obk=
X-Google-Smtp-Source: AA6agR7eBGS0t8bAtmMG9kR2mnycCtyHLzZ+k4T63f69rE09XNDjJ+uKAvFR1vg8kJQDxDZ4Dw0zvQ==
X-Received: by 2002:a05:6512:3503:b0:481:4470:4134 with SMTP id h3-20020a056512350300b0048144704134mr10007806lfs.42.1661350081733;
        Wed, 24 Aug 2022 07:08:01 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e8384000000b00261cd70e41asm1543356ljg.32.2022.08.24.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:08:01 -0700 (PDT)
Date:   Wed, 24 Aug 2022 17:07:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220824140759.7gg7t53z2xi7jxaj@mobilestation>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220823154526.GB6371@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823154526.GB6371@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 23, 2022 at 09:15:26PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:
> > This is a final patchset in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: Done v5] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> > Merged: kernel 6.0-rc1
> > [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> > Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
> > Merged: kernel 6.0-rc1
> > [3: In-review v5] PCI: dwc: Add generic resources and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
> > [4: Done v5] dmaengine: dw-edma: Add RP/EP local DMA support
> > Link: ---you are looking at it---
> > 
> > Note it is very recommended to merge the patchsets in the same order as
> > they are listed in the set above in order to have them applied smoothly.
> > Nothing prevents them from being reviewed synchronously though.
> > 
> > Please note originally this series was self content, but due to Frank
> > being a bit faster in his work submission I had to rebase my patchset onto
> > his one. So now this patchset turns to be dependent on the Frank' work:
> > 
> > Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/
> > 
> > Here is a short summary regarding this patchset. The series starts with
> > fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
> > initializes the LL/DT base addresses for the platforms with not matching
> > CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
> > method to get a correct base address. After that you can find a series of
> > the interleaved xfers fixes. It turned out the interleaved transfers
> > implementation didn't work quite correctly from the very beginning for
> > instance missing src/dst addresses initialization, etc. In the framework
> > of the next two patches we suggest to add a new platform-specific
> > callback - pci_address() and use it to convert the CPU address to the PCIe
> > space address. It is at least required for the DW eDMA remote End-point
> > setup on the platforms with not-matching CPU/PCIe address spaces. In case
> > of the DW eDMA local RP/EP setup the conversion will be done automatically
> > by the outbound iATU (if no DMA-bypass flag is specified for the
> > corresponding iATU window). Then we introduce a set of the patches to make
> > the DebugFS part of the code supporting the multi-eDMA controllers
> > platforms. It starts with several cleanup patches and is closed joining
> > the Read/Write channels into a single DMA-device as they originally should
> > have been. After that you can find the patches with adding the non-atomic
> > io-64 methods usage, dropping DT-region descriptors allocation, replacing
> > chip IDs with the device name. In addition to that in order to have the
> > eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
> > dma-ranges-based memory ranges mapping since in case of the root port DT
> > node it's applicable for the peripheral PCIe devices only. Finally at the
> > series closure we introduce a generic DW eDMA controller support being
> > available in the DW PCIe Root Port/Endpoint driver.
> > 
> 

> I've tested this series on Qualcomm SM8450 SoC based dev board. So,
> 
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Thanks.

> Not sure what is the merging strategy for this one but this series should get
> merged into a single tree. Since the PCI patch is touching the designware
> driver, merging the series into dmaengine tree might result in conflict later.

Right, the series
[PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
is supposed to be merged in first. Then this one will get to be
applied with no conflicts. That's what I imply in the head of the
cover-letter.

-Sergey

> 
> Thanks,
> Mani
> 
> > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Drop the patches:
> >   [PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   [PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
> >   since they are going to be merged in in the framework of the
> >   Frank's patchset.
> > - Add a new patch: "dmaengine: dw-edma: Release requested IRQs on
> >   failure."
> > - Drop __iomem qualifier from the struct dw_edma_debugfs_entry instance
> >   definition in the dw_edma_debugfs_u32_get() method. (@Manivannan)
> > - Add a new patch: "dmaengine: dw-edma: Rename DebugFS dentry variables to
> >   'dent'." (@Manivannan)
> > - Slightly extend the eDMA name array size. (@Manivannan)
> > - Change the specific DMA mapping comment a bit to being
> >   clearer. (@Manivannan)
> > - Add a new patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
> >   method."
> > - Don't fail eDMA detection procedure if the DW eDMA driver couldn't probe
> >   device. That happens if the driver is disabled. (@Manivannan)
> > - Add "dma" registers resource mapping procedure. (@Manivannan)
> > - Move the eDMA CSRs space detection into the dw_pcie_map_detect() method.
> > - Remove eDMA on the dw_pcie_ep_init() internal errors. (@Manivannan)
> > - Remove eDMA in the dw_pcie_ep_exit() method.
> > - Move the dw_pcie_edma_detect() method execution to the tail of the
> >   dw_pcie_ep_init() function.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - Conditionally set dchan->dev->device.dma_coherent field since it can
> >   be missing on some platforms. (@Manivannan)
> > - Drop the patch: "PCI: dwc: Add generic iATU/eDMA CSRs space detection
> >   method". A similar modification has been done in another patchset.
> > - Add more comprehensive and less regression prune eDMA block detection
> >   procedure.
> > - Drop the patch: "dma-direct: take dma-ranges/offsets into account in
> >   resource mapping". It will be separately reviewed.
> > - Remove Manivannan tb tag from the modified patches.
> > - Rebase onto the kernel v5.18.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru
> > Changelog v4:
> > - Rabase onto the laters Frank Li series:
> > Link: https://lore.kernel.org/all/20220524152159.2370739-1-Frank.Li@nxp.com/
> > - Add Vinod' Ab-tag.
> > - Rebase onto the kernel v5.19-rcX.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru
> > Changelog v5:
> > - Just resend.
> > - Rebase onto the kernel v6.0-rc2.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-By: Vinod Koul <vkoul@kernel.org>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (24):
> >   dmaengine: Fix dma_slave_config.dst_addr description
> >   dmaengine: dw-edma: Release requested IRQs on failure
> >   dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
> >   dmaengine: dw-edma: Fix missing src/dst address of the interleaved
> >     xfers
> >   dmaengine: dw-edma: Don't permit non-inc interleaved xfers
> >   dmaengine: dw-edma: Fix invalid interleaved xfers semantics
> >   dmaengine: dw-edma: Add CPU to PCIe bus address translation
> >   dmaengine: dw-edma: Add PCIe bus address getter to the remote EP
> >     glue-driver
> >   dmaengine: dw-edma: Drop chancnt initialization
> >   dmaengine: dw-edma: Fix DebugFS reg entry type
> >   dmaengine: dw-edma: Stop checking debugfs_create_*() return value
> >   dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
> >   dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
> >   dmaengine: dw-edma: Rename DebugFS dentry variables to 'dent'
> >   dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
> >   dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
> >   dmaengine: dw-edma: Join Write/Read channels into a single device
> >   dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
> >   dmaengine: dw-edma: Use non-atomic io-64 methods
> >   dmaengine: dw-edma: Drop DT-region allocation
> >   dmaengine: dw-edma: Replace chip ID number with device name
> >   dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
> >   dmaengine: dw-edma: Skip cleanup procedure if no private data found
> >   PCI: dwc: Add DW eDMA engine support
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c            | 216 +++++-----
> >  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  60 +--
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 372 ++++++++----------
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  12 +-
> >  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
> >  drivers/pci/controller/dwc/pcie-designware.c  | 186 +++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  20 +
> >  include/linux/dma/edma.h                      |  18 +-
> >  include/linux/dmaengine.h                     |   2 +-
> >  13 files changed, 583 insertions(+), 356 deletions(-)
> > 
> > -- 
> > 2.35.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
