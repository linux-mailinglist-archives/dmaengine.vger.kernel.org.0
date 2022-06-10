Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7945461D9
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiFJJY1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 05:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349237AbiFJJXT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 05:23:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAA66CB0;
        Fri, 10 Jun 2022 02:21:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g25so28894948ljm.2;
        Fri, 10 Jun 2022 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UR+RqvdxNC/6O7vnxiLh6+/xafLghKRExkkKTPqRGok=;
        b=Lemye8FYmKBZkgHBMFKit5bSNWAlRuFMQ5mtgZ2v9GLhUs3YUE/FrhbmX/mqVhKCc8
         q+GbXGYpY2vWhrQL58jcWNfW4BqcADEuovdSXRXifLvHXnI/ymUoIRY4JoS/iKf5QUr+
         7CQ4XurcYfzrKHHkcxLw1016rmTmFvvhaDUV/4Cj88hBFAar8p6LROdOK4ZGRqRgXPrE
         y3DG3/0z5qPeqYthiSHt5FTVeoq7CQre0iGfWR7/wOkKT8kjcOE1gJiIogFj+EaWjFdb
         L8OT7Ult70n63foxo7E6OChcUKy0utmxL9j3Hh4t/tiun61dtUTctX7J6W07ae8lA/4I
         GVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UR+RqvdxNC/6O7vnxiLh6+/xafLghKRExkkKTPqRGok=;
        b=RBWM8AgYKMfcZHK4Wgmyrz9Y9srWbeWi7IafChHg+Vl9T3L8pdkZ+5UOCeddXBZ7ij
         q6mTseHwG1LHS5uk4ELVlVq1Ko0f0OMh6eSnraDtd6+OztWwwHHtqdOIh+I6nrkvJxpG
         9rK/Jkm6WLvUacnv7NM1JJXKnFRavOy4T6LdmvSHNE9mmFHCsl56+YuCB4lwMmmNnXKZ
         ZBhlVMKc7WjXahW+0rZ+DFrYNqkA78daKMEc/Fa2DJKZeRggNDgnJifzE17sY4f29Ga6
         QsdD52EjLuJerqmUyO8L1QI1y7LexTwhrOMdb04cyDllu+7zPLh00f/3kobAEhN/HNIk
         Hl8g==
X-Gm-Message-State: AOAM533JPu0pdliNDD4zQrywKpjXko9hi7+i41J3xnfOVug+k13cdlBe
        F38mYhFPvxXXTnZNrnmASVg=
X-Google-Smtp-Source: ABdhPJw3MKJdThzbGUpdJQ///v3bRel6K997WxVQzU+PBQkLl/kRHZlA0iKYR52uOu+eW7ysimhHqw==
X-Received: by 2002:a2e:9b58:0:b0:255:95c0:c610 with SMTP id o24-20020a2e9b58000000b0025595c0c610mr14363089ljj.311.1654852895817;
        Fri, 10 Jun 2022 02:21:35 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id q17-20020ac246f1000000b004790105d0cfsm4654552lfo.16.2022.06.10.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:21:35 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:21:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220610092133.uhsu5gphhvjhe2jm@mobilestation>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 10, 2022 at 12:14:35PM +0300, Serge Semin wrote:
> This is a final patchset in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: In-progress v4] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> [3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> Link: ---you are looking at it---
> 
> Note it is very recommended to merge the patchsets in the same order as
> they are listed in the set above in order to have them applied smoothly.
> Nothing prevents them from being reviewed synchronously though.
> 
> Please note originally this series was self content, but due to Frank
> being a bit faster in his work submission I had to rebase my patchset onto
> his one. So now this patchset turns to be dependent on the Frank' work:
> 
> Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/
> 
> So please merge Frank' series first before applying this one.
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

@Mani, several patches have been changed. Could you have a look at the
series one more time?

-Sergey

> - Rebase onto the kernel v5.18.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: linux-pci@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (24):
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
>   PCI: dwc: Add DW eDMA engine support
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 216 +++++-----
>  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  76 ++--
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 372 ++++++++----------
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
>  .../pci/controller/dwc/pcie-designware-ep.c   |  12 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 186 +++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  20 +
>  include/linux/dma/edma.h                      |  18 +-
>  include/linux/dmaengine.h                     |   2 +-
>  13 files changed, 589 insertions(+), 366 deletions(-)
> 
> -- 
> 2.35.1
> 
