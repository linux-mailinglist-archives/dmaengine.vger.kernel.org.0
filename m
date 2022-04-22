Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3350BFBE
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiDVS2u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiDVS2Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 14:28:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DA78926;
        Fri, 22 Apr 2022 11:25:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so10664392ljb.2;
        Fri, 22 Apr 2022 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCEI0xibfi+ErWDFF1WNtBszacmur6zxDwM+RRbKA94=;
        b=DEAgLnxy66ZUXAFoSIH4nGkZcLMS2AVKWJbjJ4grkrl4fpXGblal9qwYhjy9XsRnQR
         KbtYg/HZmlprELSMmy64j+L6OiAA96SQgU05J5mOnsszvKN/+zdiFcQc3Jmy2YNKhSFX
         sYdgNQqnIc8LaU2f8oZSLq56CzZafcd8cMY3XlwCa1i+yd+Oxk5OFLwe9da/+vGBNEqF
         8JTUSqUCXEOxqO7/oOo2VJDz6rESCEYV8M9anmhzUmSYJ7CO9yxLrgHWRU0FTbzHSW9s
         XZX3aIDEhmYlXa3SLSjkU7P5Zwbr46VMlT8RBlvctBOiSphAnI7lgwhGtoxu/NB81fkN
         k2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCEI0xibfi+ErWDFF1WNtBszacmur6zxDwM+RRbKA94=;
        b=ValBNwTZnAtQ8yeG4rq9LdAeG+XUqSuKjid99BfjRRwmUzTeNgEyI94IR+RJDFws6m
         SKM7FhtzheDllzLfV9oSUVdgL0snDTLyqKzMl2PdWuApb4ycyJ5dUrhXKV9XG02hJJkJ
         NVbktBTa/1vh7FgXoksNTjCLdF9HZiNt1rRZn2Luj5ke2gwKQZHCLy52OtJzxr4+q9NT
         gu5UbRU0j/Fc2LLxDqjBEw6nN//s9kBn4nIkGJ7HdKoCy1sHuemrM7IAVgqcWCdEzzZH
         k43BapNMtmGCPB4KH4oyx7HTXwJzQOq4XuK8p3zBNvkxlXQ7vExFs6Gx6h0Ms5Y2NUrE
         qQRQ==
X-Gm-Message-State: AOAM5331uE6RhiFb8nURZDN+E+AvwRdS8myRJm7we1VIsIeMv8oN7jr3
        lQAiTvOoWQBeaXH//ODXq/n9j3xdaP7SsQ==
X-Google-Smtp-Source: ABdhPJznP/Quzrk/mpSu3uTzKXknfIWTuaGlr1DqWKhijDqZoOE/ZwcHqEgcvUlZnrwSqbf/SYFmmw==
X-Received: by 2002:a2e:9c43:0:b0:24b:469:2bb6 with SMTP id t3-20020a2e9c43000000b0024b04692bb6mr3731056ljj.248.1650651199037;
        Fri, 22 Apr 2022 11:13:19 -0700 (PDT)
Received: from mobilestation ([95.79.183.147])
        by smtp.gmail.com with ESMTPSA id l6-20020a2e9086000000b0024dbaf0ac5bsm295332ljg.94.2022.04.22.11.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:13:18 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:13:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v9 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220422181316.jlkf4fjt3llbgebc@mobilestation>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422175335.ucs2nmfq44tmcbn3@mobilestation>
 <CAHrpEqR4DiShMXsWeJ=1WKoFCyNc+Oeb79DXumkzSNL9DRX-4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqR4DiShMXsWeJ=1WKoFCyNc+Oeb79DXumkzSNL9DRX-4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 22, 2022 at 12:57:32PM -0500, Zhi Li wrote:
> On Fri, Apr 22, 2022 at 12:53 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hello folks,
> >
> > My review is finally over. Aside with that I've tested the series on
> > Baikal-T1 SoC, which has DW PCIe Host controller v4.60 and DW eDMA
> > embedded. A test was performed on kernel v5.18-rc3 by a simple driver
> > copying random data from system memory to SM768 framebuffer and
> > vise-versa. So @Frank feel free to add my tag to the entire series:
> >
> > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> 

> Thanks. I think the maintainer can add this when they pick up the patches.
> I will add it if patches need to be respin.

Right, 'b4 am -t' does the trick.

-Sergey

> 
> best regards
> Frank Li
> 
> >
> > @Lorenzo, @Rob, @Vinod, my patchset:
> > Link: https://lore.kernel.org/linux-pci/20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru
> > is based on this one. In its turn my series depends on the other
> > patchsets:
> > [PATCH v2 0/4] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> > Link: [https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru
> > [PATCH 00/12] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru
> > [PATCH 00/16] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > https://lore.kernel.org/linux-pci/20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru
> > which are currently on review. (BTW @Rob I am waiting for your
> > responses there to go on with v2 re-spin.) I am very much eager to get
> > my patches ready before the next merge windows. But in order to
> > preserve the consistency of the corresponding repo with my patchsets
> > it needs to have the @Frank' patches. Seeing aside with @Frank's
> > series my changes depends on the changes in the clk and pci
> > subsystems, could you please consider choosing a single repository for
> > merging all my and @Frank patches in. Since the changes mostly concern
> > the DW PCIe controller I suggest to use the 'pci/dwc' branch of the
> > 'kernel/git/lpieralisi/pci.git' repository. What do you think?
> > @Lorenzo?
> >
> > -Sergey
> >
> > On Fri, Apr 22, 2022 at 09:36:34AM -0500, Frank Li wrote:
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
> > >   PCI: endpoint: Add embedded DMA controller test
> > >
> > > Serge Semin (2):
> > >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> > >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> > >     semantics
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c            | 139 +++++++++++-------
> > >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
> > >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
> > >  include/linux/dma/edma.h                      |  59 +++++++-
> > >  8 files changed, 312 insertions(+), 176 deletions(-)
> > >
> > > --
> > > 2.35.1
> > >
