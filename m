Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F554D271
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiFOUXt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 16:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiFOUXs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 16:23:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F814FC45;
        Wed, 15 Jun 2022 13:23:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d13so11317573plh.13;
        Wed, 15 Jun 2022 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8R5wkbZD5wZONN+h5D0aBjo4LSrB4lxzGhWSHOloRM=;
        b=dS58LuwnCBY84xcngeX1qBATP+ApeouKJOm/qDXgFfp2B93n34gH94kQC7vljQbiC3
         dEY7q27TDvxHZCb8flJ9S3obqQJ7bXOaL2I48dGiSPXZOeXdWlgBl9EKKTQF7+Rv3O4B
         cdfzKZrxEjEXwdRtSfq7mDGj8F6RKKMRLA8DD/ztMrQWFYFCI9vRn8P68bY/8VtO8kVs
         1NDhpCFmxs/e1GNYOXDG6mD3M/ZnXW1mBnuda8ijgTCfLG8Jetfb5OFs6bFH49+tz8J8
         wTdxSO5mtlrN5T4VCd0XgEhtn0HNWVfG5F8B/sYk813Bbc3Dj6Vo8fUflb6XHvIOGFB5
         vPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8R5wkbZD5wZONN+h5D0aBjo4LSrB4lxzGhWSHOloRM=;
        b=NNPL+V6cfdfnwdFRFgnlxw1nwV66IiMhDfL0NgT3dM7cDzYXI2uBjuLtUSl0hgOMx/
         0nbhMsVHMj26TI2U556P9c8FeNgs6Gi2zs+SLmBDKkVD+EGnaTEowI+ZvntMbIAbd9Tn
         McXex9naOOrBsxcjR48+gGdoidPJ/gXY7iAR8/cHjYShX+xYWMUghxz9qFcmssgEZTWT
         yE2VeTJpbKjIXy9DjGdh0iRNxD3K9a7n6r3umuvfw+7/gQLCLTRW88LF5UYFpkMHDZls
         VSzszhtnrKt6cnfEsubIQhRwPvpcQ9yHprqG9tpzhXDZuanGF28qit3xphCZyXhEFfw6
         DFVw==
X-Gm-Message-State: AJIora/pj9AMC5j9mmNwnKYx0LySxJHfwzAaojPfmGGbtdyub2kSyIoj
        kjSX5OYNxxSzj6DH0yE6hHzE1iy1oV44aUbEg6g=
X-Google-Smtp-Source: AGRyM1vP5vP5DaQBNyi/UoS78+PNNUPHfdApS1HLqVaZov4JkRrQCkAscCX4mkcI2aQNoH49DCQBhibPI7/UcAYpqT0=
X-Received: by 2002:a17:903:22d0:b0:164:ec0:178c with SMTP id
 y16-20020a17090322d000b001640ec0178cmr1330595plg.127.1655324627035; Wed, 15
 Jun 2022 13:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220524152159.2370739-1-Frank.Li@nxp.com> <20220525092306.wuansog6fe2ika3b@mobilestation>
 <CAHrpEqSa1JM8sm0QShCSXi++y9gVo9q5TmxPqwWiDADCrptrJw@mail.gmail.com> <CAHrpEqRMpq+-H97Jm2F0c=0ey_3NsqgCvbTiBDA=vz2p4K+uZQ@mail.gmail.com>
In-Reply-To: <CAHrpEqRMpq+-H97Jm2F0c=0ey_3NsqgCvbTiBDA=vz2p4K+uZQ@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 15 Jun 2022 15:23:36 -0500
Message-ID: <CAHrpEqTpo8FS9NmOUQ3Lknr4QO0vgDFxTY-R4vn_gL4KM8_-OQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

On Tue, May 31, 2022 at 9:02 AM Zhi Li <lznuaa@gmail.com> wrote:
>
> On Wed, May 25, 2022 at 9:41 AM Zhi Li <lznuaa@gmail.com> wrote:
> >
> > On Wed, May 25, 2022 at 4:23 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > >
> > > Hello Vinod
> > >
> > > On Tue, May 24, 2022 at 10:21:51AM -0500, Frank Li wrote:
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
> > > This series has been on review for over three months now. It has got
> > > several acks, rb and tb tags from me, Manivannan and Kishon (the last
> > > patch in the series). Seeing Gustavo hasn't been active for all that time
> > > at all and hasn't performed any review for more than a year the
> > > probability of getting his attention soon enough is almost zero. Thus
> > > could you please give your acks if you are ok with the series content. Due
> > > to having several more patchsets dependent on this one, Bjorn has agreed
> > > to merge this series in through the PCI tree:
> > > https://lore.kernel.org/linux-pci/20220524155201.GA247821@bhelgaas/
> > > So the only thing we need is your ack tags.
> > >
> > > @Frank. Should there be a new patchset revision could you please add a
> > > request to merge the series in to the PCI tree? I am a bit tired repeating
> > > the same messages each time the new mailing review lap.)
> >
> > The key is to need Vinod to say something
> >
> > Best regards
> > Frank Li.
>
> @Vinod Kou:
>        These patches were well reviewed by Serge Semin,  Bjorn,
> Manivannan Sadhasivam, Kishon Vijay Abraham and tested on 3 platforms.
>        Pending on your opinion because it touch file under /driver/dma/dw_edma/*

@vinod kou:
      friendly ping.

>
> best regards
> Frank Li
>
> >
> > >
> > > -Sergey
> > >
> > > >
> > > > Frank Li (6):
> > > >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > >   dmaengine: dw-edma: Detach the private data and chip info structures
> > > >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > >     dw_edma_chip
> > > >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > >     dw_edma_chip
> > > >   dmaengine: dw-edma: Add support for chip specific flags
> > > >   PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
> > > >
> > > > Serge Semin (2):
> > > >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> > > >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> > > >     semantics
> > > >
> > > >  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
> > > >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> > > >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> > > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
> > > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
> > > >  include/linux/dma/edma.h                      |  59 +++++++-
> > > >  9 files changed, 317 insertions(+), 180 deletions(-)
> > > >
> > > > --
> > > > 2.35.1
> > > >
