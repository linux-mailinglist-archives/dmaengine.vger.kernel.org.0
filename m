Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD736524F80
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355055AbiELOL3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354771AbiELOL0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 10:11:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AEC6129C
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 07:11:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so5897312pjb.1
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7DM0fhozyxZfRm0O8cuYidMQN4EUbzqJzK7mBi/zq5g=;
        b=qQmcFeR2f/ZJ3GrSdy0gqIiC2l2t+wMUw0hwEEUDyJzba7YXHy0ob48OgB4jOh1Oyo
         WL/4Hj+Zwo7vVaoTRRNMHaVpZcvxCxP46e77mTy7/dNjzPmWM5GtKex/6cbfvYMoWV9J
         HU1STEHgs0MNCkAZh0JBsC9qSDm5KqWTQWBj70NlRUZ8/k7mybkyoUzmFIdu/cOQ20Yc
         ZzDzfI1K6huZEVOT5weWb82c0Sg3BnEg0t7qiYMjRhFZ83DtJmUwew4oQzjBe0dan0R/
         XgSkGszjXY2an95D+Li4KzWQyYK3MgOJIFAuhUKlf/BPTgiZx1H7f8+a2Bs3mmE5Tam8
         DSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7DM0fhozyxZfRm0O8cuYidMQN4EUbzqJzK7mBi/zq5g=;
        b=IluMNkKmGGCfQ47GUUkiaFl9dw9knqbD0xCsKPfMrALXjFg1waCivBkJEkG3uvTxZV
         IX35DJipeSPm6aSn17nAZRIxRZCuVVTzgrFFdhMoIfJEPqrG7NNzddDh+IDL2KS3FNkQ
         E2K5gU7CEnwqso1wb2WbeSDlml0KHIXjGoFlhwV1i12Gw13cN+NN88OANSL33CS4kqsQ
         iPW+NC25AOI1z9nXmFVFEFCOg1qphObVKv/fkEWeleXayZ2u2Ci2FgReryc5GFVXkO3L
         q7ZILZ3OZB9i4mJxRL+IHCa8QZjUDO/ugUQVIBLuB5pV35UV+xcA7jXLjwENK9cRavmG
         hS8A==
X-Gm-Message-State: AOAM533cHbk+0dkzU1c49R0L8BGEZYtuW4oqxUB4lyOhHsmHuV1x54wn
        FoiV/XjUrLIRSGy1crcPG+nF
X-Google-Smtp-Source: ABdhPJzFOCbGXcIm00mYaykwWZp+4Y22f7p6HRgUZHN0vZ452HnzpGCGO7+t52pJ9lz9aEdAeDz6AQ==
X-Received: by 2002:a17:902:e353:b0:15d:4ca:90c3 with SMTP id p19-20020a170902e35300b0015d04ca90c3mr30015312plc.171.1652364684141;
        Thu, 12 May 2022 07:11:24 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ada0400b001cd4989fecesm1885043pjv.26.2022.05.12.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:11:23 -0700 (PDT)
Date:   Thu, 12 May 2022 19:41:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220512141115.GE35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:38AM +0300, Serge Semin wrote:
> This is a final patchset in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: In-progress v3] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> [2: In-progress v2] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
> [3: In-progress v2] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> [4: In-progress v2] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> Link: --you are looking at it--
> 

I rebased my Qcom specific changes on top of the above patches and tested
on SM8450 based dev board. After fixing couple of issues (shared those in the
respective patch postings), everything seems to work fine.

So feel free to add my Tested-by tag for dwc/edma patches after fixing those
issues.

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Note it is recommended to merge this patchset after the former ones in
> order to prevent merge conflicts. @Lorenzo could you merge in this
> patchset through your PCIe repo? After getting all the ack'es of course
> and after merging in the @Frank' series? (See the next paragraph for more
> details.)
> 
> Please note originally this series was self content, but due to Frank
> being a bit faster in his work submission I had to rebase my patchset onto
> his one. So now this patchset turns to be dependent on the Frank' work:
> Link: https://lore.kernel.org/linux-pci/20220503005801.1714345-1-Frank.Li@nxp.com/
> So please merge Frank' series first before applying this one.
> 
> Here is a short summary regarding this patchset. The series starts with
> fixes patches. The very first patch fixes the dma_direct_map_resource()
> method, which turned out to be not working correctly for the case of
> having devive.dma_range_map being non-empty (non-empty dma-ranges DT
> property). Then we discovered that the dw-edma-pcie.c driver incorrectly
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
> available in the DW PCIe Host/End-point driver.
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
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: linux-pci@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (26):
>   dma-direct: take dma-ranges/offsets into account in resource mapping
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
>   dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
>   dmaengine: dw-edma: Skip cleanup procedure if no private data found
>   PCI: dwc: Add generic iATU/eDMA CSRs space detection method
>   PCI: dwc: Add DW eDMA engine support
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 211 +++++-----
>  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  76 ++--
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 372 ++++++++----------
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
>  .../pci/controller/dwc/pcie-designware-ep.c   |  16 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  17 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 251 ++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  23 +-
>  include/linux/dma/edma.h                      |  18 +-
>  include/linux/dmaengine.h                     |   2 +-
>  kernel/dma/direct.c                           |   2 +-
>  14 files changed, 628 insertions(+), 400 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
