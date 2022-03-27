Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C24E8A46
	for <lists+dmaengine@lfdr.de>; Sun, 27 Mar 2022 23:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiC0VnC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Mar 2022 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0VnA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Mar 2022 17:43:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07C633A13;
        Sun, 27 Mar 2022 14:41:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w7so21710379lfd.6;
        Sun, 27 Mar 2022 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bmEK1Kxpl0XlATDB3PjeWdnvGtZF39wnbbmUHSnsVOE=;
        b=IN1nFvSkg/9GK4aUgeTH/8ambguEzr+WPQjfGNpiw5xieoM4jqvMVQNqr8479CQ9e7
         KW0mc8Q5gORzpfExuKsFMFZExxy1yGvofHsSe/IZIx4MseeiY/2jxNVfOfdbSzji3uP4
         /ch4aI1TCCgOfqQlinWCYlucf3Ph4T+xsngpMTxZJout2+T3XvQa0JA0GadtwwjHS4yK
         8HcBeEMd0vSqGzWBCxjkDKUjs/mWS6P3oNtmylOT3FqxN0dHR9EGnhgdY8eXf5Y2sXPs
         4gr8yacPNdpCfSEoNSnwVDkO/RGrjBj5tq5lXp5T9cYNBkQ4SeDV0u+83yfHC6HPXgwG
         daAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bmEK1Kxpl0XlATDB3PjeWdnvGtZF39wnbbmUHSnsVOE=;
        b=4ONe75jJ/hkJIV/QZxmx00wIpkRicaiCJyanwSiVZs0c9T7vyw2tpNLF1Vg3iLcFKa
         dDtquFl4DFKWLdtj160mpTAr0YK27i5UFz0ZLweohGtNgxDEtyhg4pt6ntADAyNzgIK1
         dcOzeVIl3S2rYV5Er+YfXZ6JgPmdQRInjutLyw/FaBd+AfW0V44qnRPPgXttMgIPzIZq
         RTgMgnY/nqKYDluSZaUQuvPYHH6d9090tFYxoRfG4IcOameWlYUf6rOXgfNvqt7AJ1CY
         122lCUK/hvPiDbsGuzJZR1kD+CqMdF86NZBp/CRziXEP6asThRvTThgeGF/1rskJLdOY
         g3Ow==
X-Gm-Message-State: AOAM530LOf3vtQBc9gnsVZRjhACiJ/Nx7UdlmNcvUO/RXmSNeuBSbM/b
        IbIMHAGYtG2/ktxrQdbjGBo=
X-Google-Smtp-Source: ABdhPJxMYioCRkCFW8DvOH7MUhBRFoH/i7M5Rdnufy2CRsL7C0efrbHJcK9G5YzoRGrxZxml540+2g==
X-Received: by 2002:a05:6512:11eb:b0:448:8cd0:7d7e with SMTP id p11-20020a05651211eb00b004488cd07d7emr16773121lfs.593.1648417278987;
        Sun, 27 Mar 2022 14:41:18 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id t24-20020a2e9d18000000b0024986ae8972sm1518985lji.0.2022.03.27.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 14:41:18 -0700 (PDT)
Date:   Mon, 28 Mar 2022 00:41:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <frank.li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/25] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220327214116.b6ku7sc2xvc6swlq@mobilestation>
References: <PAXPR04MB9186C220089D1480CD5C4826881A9@PAXPR04MB9186.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB9186C220089D1480CD5C4826881A9@PAXPR04MB9186.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Frank,

On Fri, Mar 25, 2022 at 02:52:53PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Sent: Wednesday, March 23, 2022 8:48 PM
> > To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>; Vinod Koul
> > <vkoul@kernel.org>; Jingoo Han <jingoohan1@gmail.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; Serge Semin
> > <fancer.lancer@gmail.com>; Alexey Malahov
> > <Alexey.Malahov@baikalelectronics.ru>; Pavel Parkhomenko
> > <Pavel.Parkhomenko@baikalelectronics.ru>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > Wilczyński <kw@linux.com>; linux-pci@vger.kernel.org;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [EXT] [PATCH 00/25] dmaengine: dw-edma: Add RP/EP local DMA
> > controllers support
> > 
> > Caution: EXT Email
> > 
> > This is a final patchset in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: In-progress] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > Link: --submitted--
> > [2: In-progress] PCI: dwc: Various fixes and cleanups
> > Link: --submitted--
> > [3: In-progress] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > Link: --submitted--
> > [4: In-progress] dmaengine: dw-edma: Add RP/EP local DMA controllers
> > support
> > Link: --you are looking at it--
> > 
> > Note it is recommended to merge the last patchset after the former ones in
> > order to prevent merge conflicts. @Bjorn could you merge in this patchset
> > through your PCIe repo? After getting all the ack'es of course.
> > 
> > Please note originally this series was self content, but due to Frank
> > being a bit faster in his work submission I had to rebase my patchset onto
> > his one. So now this patchset turns to be dependent on the Frank' work:
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kern
> > el.org%2Fdmaengine%2F20220310192457.3090-1-
> > Frank.Li%40nxp.com%2F&amp;data=04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e402d4
> > 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378368332
> > 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3wsUdFo2TpBCVe8haYoFMxPyY78D4yABM
> > B%2Bz0QHkE3Q%3D&amp;reserved=0
> > So please review and merge his series first before applying this one.
> > 
> > @Frank, @Manivannan as we agreed here:
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kern
> > el.org%2Fdmaengine%2F20220309211204.26050-6-
> > Frank.Li%40nxp.com%2F&amp;data=04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e402d4
> > 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378368332
> > 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UwV79KHJWWhHZ9dYuqrBP8%2B5n6xonLU
> > bK5wqduuSg%2FM%3D&amp;reserved=0
> > this series contains two patches with our joint work. Here they are:
> > [PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field
> > usage
> > [PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> > semantics
> > @Frank, could you please pick them up and add them to your series in place
> > of the patches:
> > [PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "direction"
> > member
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kern
> > el.org%2Fdmaengine%2F20220310192457.3090-7-
> > Frank.Li%40nxp.com%2F&amp;data=04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e402d4
> > 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378368332
> > 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=G2Q2BTfp4vt0yiyHbPnn9kKBDfOx6QBmE
> > ypOREcWq4g%3D&amp;reserved=0
> > [PATCH v5 5/9] dmaengine: dw-edma: Fix programming the source & dest
> > addresses for ep
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kern
> > el.org%2Fdmaengine%2F20220310192457.3090-6-
> > Frank.Li%40nxp.com%2F&amp;data=04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e402d4
> > 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378368332
> > 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UppQMqEDobyEN2JU05MS6k%2FuXeS6%2B
> > skrr%2BeN%2FeQzPk8%3D&amp;reserved=0
> > respectively?
> > 
> > @Frank please don't forget to fix your series so the chip->dw field is
> > initialized after all the probe() initializations are done. For that sake
> > you also need to make sure that the dw_edma_irq_request(),
> > dw_edma_channel_setup() and dw_edma_v0_core_debugfs_on() methods take
> > dw_edma structure pointer as a parameter.
> > 
> > Here is a short summary regarding this patchset. The series starts with
> > fixes patches. The very first two patches have been modified based on
> > discussion with @Frank and @Manivannan as I noted in the previous
> > paragraph. They concern fixing the Read/Write channels xfer semantics.
> > See the patches description for more details. After that goes the fix of
> > the dma_direct_map_resource() method, which turned out to be not working
> > correctly for the case of having devive.dma_range_map being non-empty
> > (non-empty dma-ranges DT property). Then we discovered that the
> > dw-edma-pcie.c driver incorrectly initializes the LL/DT base addresses for
> > the platforms with not matching CPU and PCIe memory spaces. It is fixed by
> > using the pci_bus_address() method to get a correct base address. After
> > that you can find a series of interleaved xfers fixes. It turned out the
> > interleaved transfers implementation didn't work quite correctly from the
> > very beginning for instance missing src/dst addresses initialization, etc.
> > In the framework of the next two patches we suggest to add a new
> > platform-specific callback - pci_addrees() and use to convert the CPU
> > address to the PCIe space address. It is at least required for the DW eDAM
> > remote End-point setup on the platforms with not-matching address spaces.
> > In case of the DW eDMA local RP/EP setup the conversion will be done
> > automatically by the outbound iATU (if no DMA-bypass flag is specified for
> > the corresponding iATU window). Then we introduce a set of patches to make
> > the DebugFS part of the code supporting the multi-eDMA controllers
> > platforms. It starts with several cleanup patches and is closed joining
> > the Read/Write channels into a single DMA-device as they originally should
> > have been. After that you can find the patches with adding the non-atomic
> > io-64 methods usage, dropping DT-region descriptors allocation, replacing
> > chip IDs with device name. In addition to that in order to have the eDMA
> > embedded into the DW PCIe RP/EP supported we need to bypass the
> > dma-ranges-based memory ranges mapping since in case of the root port DT
> > node it's applicable for the peripheral PCIe devices only. Finally at the
> > series closure we introduce a generic DW eDMA controller support being
> > available in the DW PCIe Host/End-point driver.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (25):
> >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> >     semantics
> >   dma-direct: take dma-ranges/offsets into account in resource mapping
> >   dmaengine: Fix dma_slave_config.dst_addr description
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
> 

> Why I can't see your patch in https://www.spinics.net/lists/linux-pci/
> But there are Manivannan's reply in https://www.spinics.net/lists/linux-pci/

That might be connected with the domain. I'll resend the patchsets
from my personal email after getting all the comments
addressed/discussed. Regarding the patches you are the most interested
in I'll speed the discussion up around them and send them out to you
directly so not to block your series any longer.

-Sergey

> 
> Best regards
> Frank Li
> 
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c            | 249 +++++++------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  76 ++--
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 350 ++++++++----------
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
> >  .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
> >  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
> >  drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  23 +-
> >  include/linux/dma/edma.h                      |  18 +-
> >  include/linux/dmaengine.h                     |   2 +-
> >  kernel/dma/direct.c                           |   2 +-
> >  14 files changed, 598 insertions(+), 367 deletions(-)
> > 
> > --
> > 2.35.1
> 
