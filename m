Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0654E630
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbiFPPko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiFPPko (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 11:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894037030;
        Thu, 16 Jun 2022 08:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD1F361E61;
        Thu, 16 Jun 2022 15:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB96AC34114;
        Thu, 16 Jun 2022 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655394042;
        bh=Iez/9z60hbRBUaWVFavaSsVzv+FYI3QkVGWNCO7BpqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHP7xi89bBvDkfIFXarzN84U7WZ9FFVatToOfjm4epIbZCvXgQWqVsHbpqgn2myGD
         QHdREtuyxEvotez3BHzDlKpGe0ZR2FQdHyhQjE4iGdBZHycRJKIF1rvsyOIn1P52lY
         t2dzlUTMgoEWn5gXmX5AK3GwmcW1mL1Lx9dACoQbaV7RHiLuiIcwSGMJ0eNcWln8j8
         RHrXHuEbxqNcQS9pZata0mhkxtWHp4qlEOyTMJvoY0a7CUeeLQiUEfxvD52lTXsXIo
         jaRQ3NdJZ26FYiEXgIh2wWSfQSJOLjU3yDkHySNOvuWgmfQovEDTBVA0ay/L9c2YFb
         uiVruXcP33yfQ==
Date:   Thu, 16 Jun 2022 08:40:41 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <YqtO+bOFLlztBUAG@matsya>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
 <Yqs1e4RMpc6ynVDN@matsya>
 <20220616135413.a4jmljwgzgpkp2uc@mobilestation>
 <20220616140157.dghcapsf7i7ccyo2@mobilestation>
 <20220616140314.nyr4owq2m2z4xtcm@mobilestation>
 <Yqs+f7siPc5hJRm5@matsya>
 <20220616152048.gcqacgs2ed66vsl4@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616152048.gcqacgs2ed66vsl4@mobilestation>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-22, 18:20, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 07:30:23AM -0700, Vinod Koul wrote:
> > On 16-06-22, 17:03, Serge Semin wrote:
> > > On Thu, Jun 16, 2022 at 05:02:00PM +0300, Serge Semin wrote:
> > > > On Thu, Jun 16, 2022 at 04:54:13PM +0300, Serge Semin wrote:
> > > > > On Thu, Jun 16, 2022 at 06:51:55AM -0700, Vinod Koul wrote:
> > > > > > On 24-05-22, 10:21, Frank Li wrote:
> > > > > > > Default Designware EDMA just probe remotely at host side.
> > > > > > > This patch allow EDMA driver can probe at EP side.
> > > > > > > 
> > > > > > > 1. Clean up patch
> > > > > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > > > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > > > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > > > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > > > > > 
> > > > > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > > > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > > > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > > > > patch)
> > > > > > > 
> > > > > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > > > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > > > > ep
> > > > > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > > > > > 
> > > > > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > > > > >    PCI: endpoint: Add embedded DMA controller test
> > > > > > > 
> > > > > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > > > > controller driver.
> > > > > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > > > > > 
> > > > > 
> > > > > > Applied to dmaengine-next, thanks
> > > > > 
> > > > 
> > > > > Vinod, this was supposed to be merged in through PCIe repo.( I asked
> > > > > many times of that. Bjorn also agreed to merge it in. Could drop it
> > > > > from yout repo?
> > > > 
> > > 
> > > > I asked it several time including in the framework of this thread:
> > > > https://lore.kernel.org/dmaengine/20220525092306.wuansog6fe2ika3b@mobilestation/
> > > > There are dependencies of my patchsets from this one. Please consider
> > > > dropping it from your dmaengine-next repo while it's still possible
> > > > since taking DW eDMA and PCie patches through the PCie repo would be
> > > > more natural.
> > > 
> > > The only thing we were waiting for was you ack tag...
> > 
> 
> > Is there any dependency, since this has many dmaengine patches and one
> > pcie patch which was acked by Kishon, so can go thru dmaengine tree...
> 
> Right. This one is fully suitable for the DMA-engine tree, but there
> are dependencies of my work from this series. My patchsets in its turn
> concern both PCIe and DMA-engine parts.
> 
> Here is the deal. My work consists of four patchsets:
> [PATCH v4 00/18] PCI: dwc: Various fixes and cleanups
> https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> [PATCH v3 00/15] PCI: dwc: Add hw version and dma-ranges support
> https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> [PATCH v3 00/17] PCI: dwc: Add generic resources and Baikal-T1 support
> https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> [PATCH v3 00/24] dmaengine: dw-edma: Add RP/EP local DMA controllers support
> https://lore.kernel.org/dmaengine/20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru/
> 
> The last patchset depends on the Frank series and my DW PCIe
> patchsets listed above. To cut it shortly here is the
> dependencies graph:
> 
>                 PCIe RP/EP            |               DMA engine
>                     ^                 |                   ^
>                     |                 |                   |
> 1. Semin: [PATCH v4 00/18] "PCI: dwc: |                   |
>    Various fixes and cleanups"        |                   |
>                     ^                 |                   |
>                     |                 |                   |
> 2. Semin: [PATCH v3 00/15] "PCI: dwc: |                   |
>    Add hw version and dma-ranges      |                   |
>    support"                           |                   |
>                     ^                 |                   |
>                     |                 |                   |
> 3. Semin: [PATCH v3 00/17] "PCI: dwc: | 4. Li: [PATCH v12 0/8] "Enable
>    Add generic resources and Baikal-T1|    designware PCI EP EDMA locally"
>    support"                           |                   ^
>                     ^                                     |
>                     |                                     |
>                     +-----------------+-------------------+
>                                       |
>              5. Semin: [PATCH v3 00/24] "dmaengine: dw-edma:
>                 Add RP/EP local DMA controllers support"
> 
> As you can see my series (5) depends on the Frank' series (4). My series
> in its turn depends on the PCI patchsets (3), (2) and (1). So if you get
> to merge the Frank' patchset into your tree we'll need to merge the
> rest of the patchsets through your repo too. Seeing the DW eDMA device
> is implemented as either a separate PCIe device or embedded into the
> DW PCIe RP/EP controller and there are many PCI-related patches in my
> work, it would be more suitable to merge all the patches through the
> PCIe tree. Bjorn already agreed to do that here:
> https://lore.kernel.org/linux-pci/20220524155201.GA247821@bhelgaas/
> We only waited for your ackes. BTW should you have some free time
> please review my series (5) too since it mainly concerns the DW eDMA
> driver (though Mani, in Cc, has already done it and even performed
> the testing).
> 
> > 
> > I can drop if that suits all...
> 
> Yes please. Please drop the Frank' series from your repo, give your
> explicit ack if you are ok with it and let's merge it and the rest of
> the work through the Bjorn' repo. Patchset (1) has been fully reviewed.
> Series (2) and (3) need one more iteration to be finished. So I very
> much hope they will be done in the next few weeks, before the next
> merge window.

Ok dropped now

-- 
~Vinod
