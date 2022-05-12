Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7E524154
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 02:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349530AbiELAEo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349559AbiELAEk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 20:04:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC3149DA3;
        Wed, 11 May 2022 17:04:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so6237127lfg.7;
        Wed, 11 May 2022 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4aVwSWkYy1C0gIKEBKLoRYmnXav+Hg29JZ01oz3U0o=;
        b=OQAdLXrZ4GFmFGQN3tAqQTYp/DmDkhHs3AMl5NCXIq/jHODdh7m1DgVkJ2x+rHvFOs
         NYFJ0+rW3eJbyHV6tZmzPfBNUECozkC/TC1Ki71LDzkXd3A5I5y6nqz/VvtGx5l/n1j9
         PGMW9w8Rf56nDrIbUciupajLwIm8pi1UobY6ZS8ZY2AJNkhDmRO1X3Tgqrj2VOje7MGP
         rSkbIt7eT4vEE6kNHVM28gCda83B9Rkj16WFMIDU0yRmolcaZLwmkWoT0kQlUpCFpUxO
         bMHziw1ik9Y8VZVhFrq2w+Mlkfthy9Hq6U0+L5bKe2jrBM8e3yos0yFrGC4cbdQ0S5yi
         UJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a4aVwSWkYy1C0gIKEBKLoRYmnXav+Hg29JZ01oz3U0o=;
        b=uIvcVtmQkhksU27RQtx5js8RV3hArA8PS8JNf0yms2PaOFNMy0hgTcStStKo+l8rWK
         cRBrJfr+ZlvSmKyD8LwWGPafViH8AqzCCrEVYPtSeNg+SEUq17H7LYaO6z/2MIHKjMBs
         y5h4zNPsP1py5ff1hVbtTiuGWc69EOTDLXgtOmNp1jE7cx2y1FttXAq1hUk9RAJx04yl
         JuDYIS3Gf+fZtAWcKZnVDfMoPscby7EvRrrNOwubf8OBlIXTKMQpeeQX1W38ja0Kp/wn
         /bKzy7YxdqjamgoxhJIeNVfQHhAsDvmIf2rW5zC2GYeCZ8+k/5nJ+UDXcURD5GPIk4kD
         rBWQ==
X-Gm-Message-State: AOAM532pDtmLw2xxcgJyQANeuBmhVUF/9/3wbKI0zqsIeOfXCM7TH4KN
        P+SXXOw+KnfJog6L5CE0bGo=
X-Google-Smtp-Source: ABdhPJxUrfrGNyVFr6gtRvtDIxHKCoi35eoxiTdHB60fISye/q43qEvaB2XxIs8DHm0ETUobNEBvOw==
X-Received: by 2002:a05:6512:3087:b0:473:fe9b:ec8d with SMTP id z7-20020a056512308700b00473fe9bec8dmr20392784lfd.167.1652313871908;
        Wed, 11 May 2022 17:04:31 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id n17-20020ac242d1000000b0047255d21108sm508261lfl.55.2022.05.11.17.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:04:31 -0700 (PDT)
Date:   Thu, 12 May 2022 03:04:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, kw@linux.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v10 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220512000429.rpl4agwcjpjuzv5m@mobilestation>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
 <20220503231806.w2x4o2b3xymbwn74@mobilestation>
 <YnqlRShJzvma2SKM@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnqlRShJzvma2SKM@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Lorenzo

On Tue, May 10, 2022 at 06:47:49PM +0100, Lorenzo Pieralisi wrote:
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
> go via the DMA engine tree, I will do my best to review your
> DWC changes:
> 
> [PATCH v2 00/13] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru/
> 
> but I can't guarantee they will make v5.19 and after that I will
> be AFK for two months, which is not good either, I will coordinate
> with Bjorn to see what can we do on this, I am sorry but that's
> all I have to offer at this stage.

This isn't good. Especially the part with leaving the subsystem
unattended for two more months seeing Kishon and Krzysztof haven't
been participating in the review procedure neither.

@Bjorn could you please join the review process of my series and if
they're ok, merge them in together with the @Frank'es patchset through
your repo? As you can see mainly the patchsets have already been
reviewed by @Manivannan. At least the DW PCIe and eDMA parts. There
are still patches waiting for the @Rob ackes though.

Seeing the native PCIe host subsystem will be left unattended for some
time I can help with looking for the DWC PCIe part of it:
drivers/pci/controller/dwc/*. If nobody minds.

-Sergey

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
