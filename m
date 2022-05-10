Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D423052233C
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiEJSHJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiEJSHH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 14:07:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A5FF1;
        Tue, 10 May 2022 11:03:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so17406329plg.13;
        Tue, 10 May 2022 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=henuGRivP0qW8juYvQlbKQyNxZ/ZaU8p9MZf2KSFaxc=;
        b=D4uYNZ7VyfLuT0wfZfipTbmgCZ4SchKHu5vt3x8ArDRO9j+C/ifCxMXp0VE4VRSse7
         cVTczaktaNgm2yiBcrfBV51RQmWAj9zaB9vU6EdNPkEC0W/f5K8eeCJquxjoknCLZuRi
         DWJZHCxmSRxTjAmsjMMHyKbgcVrhQMc3MpvaO81iJsj2VL3u87WMAKxm4mm1DHMh6jMb
         zG7XXz5IoYICRMX+umw0bWlfFqtox8oj/aP7ElYxmT2EPg0/UtkU3SfE1d0WF/1RIMrM
         UXBYK1tB59xJaBEO3K29qrjQmzmrqbpm0VvV/5pBXLNBppkCHoICPuuq/jmyXz+DBW7t
         1QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=henuGRivP0qW8juYvQlbKQyNxZ/ZaU8p9MZf2KSFaxc=;
        b=RspbddSUv9/MNI4K7oJysI8x0UBfi8jz2mhTPCqBgGQrwnGcGh9phROFufbl6/jVSM
         wSmaOh3/MddmZx4esVwviiAr5OtlcVljhmjzQS9cgbNagqnF6TPMZYzEbWoynPz/jSAc
         TyCO0QlJDzlh5kafKu3Hmln5TOt3J1X1nAYhAxmoDTG+O7XkcawVqBLF95pKSSJ3H3rO
         GS88YJLxeoRbVa2NN7be5cfe55klAc557ovkYegEoHQ4XPnqgOh6KGjUUgEOrvFuHoxj
         sTq76Wk5YhHTWwudFVKo6rH3L1iO4+yqIIPBAJFHytuR3Ot1VAKtf8l4/RfNJLXXED3D
         uUJw==
X-Gm-Message-State: AOAM531uaCIo9G+BtzHHmeQKQ72U9cZz8ZkSan/PnjF1XoR+ygyv4Eys
        yENIdN5KmcBcy3dvxuae8OqbocKAH3Ujsgb1IHs=
X-Google-Smtp-Source: ABdhPJwlpQ/w1VZPoTgh8+oYdrMztwnLexVLrtWCYlcfDmJoGuYjkzgfpUKd3s3Lt5YxmlbdkDUBCBF8oVWH1oBC2zg=
X-Received: by 2002:a17:903:32c2:b0:15e:c1cc:2410 with SMTP id
 i2-20020a17090332c200b0015ec1cc2410mr22179151plr.127.1652205789439; Tue, 10
 May 2022 11:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220503005801.1714345-1-Frank.Li@nxp.com> <20220503231806.w2x4o2b3xymbwn74@mobilestation>
 <YnqlRShJzvma2SKM@lpieralisi>
In-Reply-To: <YnqlRShJzvma2SKM@lpieralisi>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Tue, 10 May 2022 13:02:58 -0500
Message-ID: <CAHrpEqRspZKtiwxBBu7qWmdv9N_5tC_7BwZx-EdOs1Y6+QJVEw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Enable designware PCI EP EDMA locally
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 10, 2022 at 12:47 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, May 04, 2022 at 02:18:06AM +0300, Serge Semin wrote:
> > On Mon, May 02, 2022 at 07:57:52PM -0500, Frank Li wrote:
> > > Default Designware EDMA just probe remotely at host side.
> > > This patch allow EDMA driver can probe at EP side.
> > >
> > > 1. Clean up patch
> > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > >
> > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > >    dmaengine: dw-edma: Add support for chip specific flags
> > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> > >
> > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > >    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > >
> > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > >    PCI: endpoint: Add embedded DMA controller test
> > >
> > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > upstream yet. So below patch show how probe eDMA driver at EP
> > > controller driver.
> > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> >
> > As I have already said in my comment to v9, @Lorenzo, @Rob, @Vinod,
> > my patchset:
> > Link: https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru
> > is based on this one. In its turn my series depends on the other
> > patchsets:
> > [PATCH v3 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > Link: https://lore.kernel.org/linux-pci/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> > [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
> > [PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> > which are currently on review. I am very much eager to get my patches
> > merged in before the next merge windows. But in order to preserve the
> > consistency of the corresponding repo with my patchsets the repo needs
> > to have the @Frank' patches. Seeing aside with @Frank's series my changes
> > depend on the changes in the clk and pci subsystems, could you please
> > consider choosing a single repository for merging all my and @Frank
> > patches in? Since the changes mostly concern the DW PCIe controller I
> > suggest to use the 'pci/dwc' branch of the
> > 'kernel/git/lpieralisi/pci.git' repository. What do you think?
> > @Lorenzo?
> >
>
> Sorry for the delay in replying. I think @Frank's series will
> go via the DMA engine tree,

Thanks. I think that except for the last one patch "PCI: endpoint: Add
embedded DMA controller test" needs
go through the pci tree.  The good thing is that it is totally independent.

best regards
Frank Li

>I will do my best to review your
> DWC changes:
>
> [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
>
> but I can't guarantee they will make v5.19 and after that I will
> be AFK for two months, which is not good either, I will coordinate
> with Bjorn to see what can we do on this, I am sorry but that's
> all I have to offer at this stage.
>
> Thanks,
> Lorenzo
>
> > -Sergey
> >
> > >
> > >
> > > Frank Li (7):
> > >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > >   dmaengine: dw-edma: Detach the private data and chip info structures
> > >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> > >     dw_edma_chip
> > >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > >     dw_edma_chip
> > >   dmaengine: dw-edma: Add support for chip specific flags
> > >   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> > >   PCI: endpoint: Enable DMA controller tests for endpoints with DMA
> > >     capabilities
> > >
> > > Serge Semin (2):
> > >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> > >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> > >     semantics
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
> > >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
> > >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
> > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
> > >  include/linux/dma/edma.h                      |  61 +++++++-
> > >  9 files changed, 323 insertions(+), 185 deletions(-)
> > >
> > > --
> > > 2.35.1
> > >
