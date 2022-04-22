Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9E50BF2E
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiDVSDb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 14:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiDVSAl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 14:00:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A710C884;
        Fri, 22 Apr 2022 10:57:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q1so11282330plx.13;
        Fri, 22 Apr 2022 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJfCLUeU0/vSvqxtQyJd1uJXb31rJ+/FjE/L4qf+9sQ=;
        b=Nw2jNs3dkdIwKIhz1viJhHrg1vNlUtto7PaVglNRBoR40GVDv7IsxlImBLMDl5PwE1
         sla4VlJDbXFVuV0OTCaVP1k0Nj54XLamO8UD+22KcIwQnbXQoYymqcaqtCy8faspqUMb
         kSroNpKkWsXmT1uR3us9ZotWueY8LBxpnLJP7SZXHLSoxICMF/dxkgsl6Y6fJ/9zKGmQ
         e5VwmmgVpeEOoYsulQY/GmsmsHnQqAaRbUmEvMIXIHZ0ae5CqSfWjD4vxxmS57uZkfAT
         kXw4UbLaDi5KWNDsEsx1npJltF1OsGYU4PlezncCg24lP2lvH4cWEhkp+c7Ea/SMkaSb
         rEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJfCLUeU0/vSvqxtQyJd1uJXb31rJ+/FjE/L4qf+9sQ=;
        b=ZwebMhbyHownCzN5lnIxwKKOqVI/kTiDfnYG18Sj9psorGU0y6Ew4Xoizc+pzL1oks
         jhJrTk1r/DORD/rDQLmFtwAcG1wQ4ZIuXpC3fuWLWYv/V/BMmEig5PSDL/YwejvUMhvK
         0UT+emNoXD9drrHQf6X64QPvx3hplH6C554txB16Plfjiyq7VmUoLpLPvcndxQaLX9LC
         /aaslsIELLMSfiMnRhFszFJGF4Jqb0VkEGtge41NllxdOPiIHW05DLxf834ZP8//VNP4
         XeVdY5WbNos6FbphdT1fcf8LQ0q6KuOn0RCKD027F2r93ujdy9uuSgYlDxEq6PmbuFrl
         jzuw==
X-Gm-Message-State: AOAM531rw/990fUNdGIKUg7R7SvNBxwF9LJxH/AtBBvobZddAV6pbN7W
        DL05tIgSv4Ea+b7qppXVkFM/scARS5okIh1261HxHT0nhukNXg==
X-Google-Smtp-Source: ABdhPJwH74Mi4jw47TZRarh5h9J0OZnwpeY2cB4qCda802GJeRwG2ledeHMXeeguvMQJ0dcQlYfdW2E66aWfjUapVcM=
X-Received: by 2002:a17:902:e881:b0:159:828:b6dd with SMTP id
 w1-20020a170902e88100b001590828b6ddmr5900239plg.127.1650650263480; Fri, 22
 Apr 2022 10:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220422143643.727871-1-Frank.Li@nxp.com> <20220422175335.ucs2nmfq44tmcbn3@mobilestation>
In-Reply-To: <20220422175335.ucs2nmfq44tmcbn3@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Fri, 22 Apr 2022 12:57:32 -0500
Message-ID: <CAHrpEqR4DiShMXsWeJ=1WKoFCyNc+Oeb79DXumkzSNL9DRX-4A@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] Enable designware PCI EP EDMA locally
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 12:53 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello folks,
>
> My review is finally over. Aside with that I've tested the series on
> Baikal-T1 SoC, which has DW PCIe Host controller v4.60 and DW eDMA
> embedded. A test was performed on kernel v5.18-rc3 by a simple driver
> copying random data from system memory to SM768 framebuffer and
> vise-versa. So @Frank feel free to add my tag to the entire series:
>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

Thanks. I think the maintainer can add this when they pick up the patches.
I will add it if patches need to be respin.

best regards
Frank Li

>
> @Lorenzo, @Rob, @Vinod, my patchset:
> Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru
> is based on this one. In its turn my series depends on the other
> patchsets:
> [PATCH v2 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> Link: [https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru
> [PATCH 00/12] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru
> [PATCH 00/16] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru
> which are currently on review. (BTW @Rob I am waiting for your
> responses there to go on with v2 re-spin.) I am very much eager to get
> my patches ready before the next merge windows. But in order to
> preserve the consistency of the corresponding repo with my patchsets
> it needs to have the @Frank' patches. Seeing aside with @Frank's
> series my changes depends on the changes in the clk and pci
> subsystems, could you please consider choosing a single repository for
> merging all my and @Frank patches in. Since the changes mostly concern
> the DW PCIe controller I suggest to use the 'pci/dwc' branch of the
> 'kernel/git/lpieralisi/pci.git' repository. What do you think?
> @Lorenzo?
>
> -Sergey
>
> On Fri, Apr 22, 2022 at 09:36:34AM -0500, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> >
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> >
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> >
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: Add embedded DMA controller test
> >
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> >
> > Frank Li (7):
> >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >   dmaengine: dw-edma: Detach the private data and chip info structures
> >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Add support for chip specific flags
> >   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> >   PCI: endpoint: Add embedded DMA controller test
> >
> > Serge Semin (2):
> >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> >     semantics
> >
> >  drivers/dma/dw-edma/dw-edma-core.c            | 139 +++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
> >  include/linux/dma/edma.h                      |  59 +++++++-
> >  8 files changed, 312 insertions(+), 176 deletions(-)
> >
> > --
> > 2.35.1
> >
