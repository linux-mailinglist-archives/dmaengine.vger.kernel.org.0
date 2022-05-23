Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA112531E61
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 00:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiEWWNF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiEWWNE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 18:13:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5C6D4FC;
        Mon, 23 May 2022 15:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69D86B8162C;
        Mon, 23 May 2022 22:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0C7C385A9;
        Mon, 23 May 2022 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653343979;
        bh=Gq6/ogshPsYUwPCvTRXNWWqK4TyGka7lK9XAediz65E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iEQnHzwhPdgWsC8TzguL8LLfXK6cWzyt0y+LEAFunO3MxYNFCNStvMa4trJCGw1d8
         85k5ZuSQwJoOjKp4GSjIwJb4XeiasdJpH5onHHs0ho8xSKlKkG8nFDpoXiurR/VQMI
         PB2tIxvuXVybS7xOEYUGI0gWkScB1gVBxan7noHynJzE55KNGtJosz4FlPfV15OskE
         y3ET9uQ2p7LJIBZobpt3skiSENQcRrDvwYxbTEMsneM2ll4Q3IHQo+bQ0AorInQPzZ
         7UI4h4KFiy19nSEu9uPus6vpyPGVq8uYxBg/we7Bp2zA3L3oFvHSkKWg2+/pF2BRpX
         jWNvxvAyrsnRg==
Date:   Mon, 23 May 2022 17:12:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
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
Message-ID: <20220523221256.GA221421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqR9dXg-4pRFA89ggv4CHXXwU-pWeTb082YRdCzmOTUjVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 23, 2022 at 01:41:48PM -0500, Zhi Li wrote:
> On Mon, May 23, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, May 23, 2022 at 02:06:47PM +0300, Serge Semin wrote:
> > > Hello Vinod,
> > >
> > > On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> > > > Default Designware EDMA just probe remotely at host side.
> > > > This patch allow EDMA driver can probe at EP side.
> > > >
> > > > 1. Clean up patch
> > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > >
> > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > patch)
> > > >
> > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > ep
> > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > >
> > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > >    PCI: endpoint: Add embedded DMA controller test
> > > >
> > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > controller driver.
> > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > >
> > > The series has been hanging out on review for over three months now.
> > > It has got to v11 and has been tested on at least two platforms. The
> > > original driver maintainer has been silent for all that time (most
> > > likely Gustavo dropped the driver maintaining role). Could you please
> > > merge it in seeing no comments have been posted for the last several
> > > weeks? The PCI Host/EP controller drivers maintainer suggested to get
> > > this series via the DMA-engine tree:
> > > https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
> > > which is obviously right seeing it mainly concerns the DW eDMA driver.
> > > Though after that Lorenzo disappeared as quickly as popped up.)
> > >
> > > There is one more series depending on the changes in this
> > > patchset:
> > > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > > Me and Frank already settled all the conflicts and inter-dependencies,
> > > so at least his series is more than ready to be merged in into the
> > > kernel repo. It would be very good to get it accepted on this merge
> > > window so to have the kernel v5.19 with all this changes available.
> >
> > Since the v5.19 merge window is already open, it seems doubtful that
> > anybody would merge this so late in the cycle.
> >
> > If Gustavo isn't available or willing to merge it, it looks like Vinod
> > (maintainer of drivers/dma) would be the next logical candidate.
> 
> I think the last patch should not block other patches from merging.
> The last patch about pci-epf-test.c is totally independent from other patches.
> 
> I prefer to merge all the dma patches first.

Absolutely.  

Given an ack from Kishon, it would make sense for Vinod to merge them
all together since they're logically related, but I have no objection
to merging any of the drivers/dma patches separately.

Bjorn
