Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98DC532DD9
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiEXPwI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiEXPwI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4267D24;
        Tue, 24 May 2022 08:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA0F0B818F6;
        Tue, 24 May 2022 15:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EB3C34113;
        Tue, 24 May 2022 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653407524;
        bh=aANtB2VFy3kLWkMIrxf8EgF5z6n+payClVQAtLR5X0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ux1d7/V7UbkGf3o4bRqyJIZD/eyUN3Px6A/rwzhXzldjOha+8roAFf+Qgv13B5rZt
         GlU0agPLlIgCND7PDj8j5zX33R1WzoS8/X4afpicUAHCIcqjWGET4ZKQkt6NyPXGNl
         Jy/VKjxdAPfRevNg41HQOz0zugrIY3MlvTFR4EmhH9pD+HzGo/8CZeUgw2fU9hXvJp
         JOAMUBLClZ2+OQ67lqvFAxOqVta0aTo7GLL9w8c2cw0PEaF0K9AfsuRWFsaw2BW7Km
         YMTAbVz20fFjNqU3KPcD+GnBm7C1XCicfN199TGJyy4fokWtw2Y3XwTzHe+hTeDMwo
         Fk5ef7NNvq2vw==
Date:   Tue, 24 May 2022 10:52:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Zhi Li <lznuaa@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220524155201.GA247821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524054850.vrchh6icwfriszhn@mobilestation>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 24, 2022 at 08:48:50AM +0300, Serge Semin wrote:
> On Mon, May 23, 2022 at 05:12:56PM -0500, Bjorn Helgaas wrote:
> > On Mon, May 23, 2022 at 01:41:48PM -0500, Zhi Li wrote:
> > > On Mon, May 23, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, May 23, 2022 at 02:06:47PM +0300, Serge Semin wrote:
> > > > > Hello Vinod,
> > > > >
> > > > > On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> > > > > > Default Designware EDMA just probe remotely at host side.
> > > > > > This patch allow EDMA driver can probe at EP side.
> > > > > >
> > > > > > 1. Clean up patch
> > > > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > > > >
> > > > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > > > patch)
> > > > > >
> > > > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > > > ep
> > > > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > > > >
> > > > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > > > >    PCI: endpoint: Add embedded DMA controller test
> > > > > >
> > > > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > > > controller driver.
> > > > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > > > >
> > > > > The series has been hanging out on review for over three months now.
> > > > > It has got to v11 and has been tested on at least two platforms. The
> > > > > original driver maintainer has been silent for all that time (most
> > > > > likely Gustavo dropped the driver maintaining role). Could you please
> > > > > merge it in seeing no comments have been posted for the last several
> > > > > weeks? The PCI Host/EP controller drivers maintainer suggested to get
> > > > > this series via the DMA-engine tree:
> > > > > https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
> > > > > which is obviously right seeing it mainly concerns the DW eDMA driver.
> > > > > Though after that Lorenzo disappeared as quickly as popped up.)
> > > > >
> > > > > There is one more series depending on the changes in this
> > > > > patchset:
> > > > > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > > > > Me and Frank already settled all the conflicts and inter-dependencies,
> > > > > so at least his series is more than ready to be merged in into the
> > > > > kernel repo. It would be very good to get it accepted on this merge
> > > > > window so to have the kernel v5.19 with all this changes available.
> > > >
> 
> > > > Since the v5.19 merge window is already open, it seems doubtful that
> > > > anybody would merge this so late in the cycle.
> 
> In this case it would be safer to merge this whole series through your
> repo. See my series:
> "[PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA controllers support"
> https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> depends in the Frank' patchset. Meanwhile my patchset is also based on the
> DW PCIe modifications introduced in the set of the series:
> "[PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support"
> https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> and
> "[PATCH v3 00/13] PCI: dwc: Various fixes and cleanups"
> https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
> 
> So to speak in order to have more coherent repos with least merge,
> logical problems the next order of the merging would be preferable:
> 1) Frank's patchset (ready to be merged in):
> [PATCH v11 0/8] Enable designware PCI EP EDMA locally
> https://lore.kernel.org/linux-pci/20220517151915.2212838-1-Frank.Li@nxp.com
> 2) My series (ready to be merged in):
> [PATCH v3 00/13] PCI: dwc: Various fixes and cleanups
> https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
> 3) My series (still in review, I need to fix some Rob' and Manivannan' notes)
> [PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> 4) Me series (ready to be merged in, but depends on the prev patchsets):
> https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> 
> Seeing the Frank patches won't make it into the mainline repo on
> this merge window, it would be great to collect all the changes in a
> single repository. Seeing Lorenzo disappeared as fast as popped up
> your repo is the best candidate since the DW eDMA block is a part of
> the DW PCIe controller.

I'll be happy to merge this via the PCI tree, given acks from Gustavo
and/or Vinod.

Bjorn
