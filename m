Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353435392E8
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiEaOC4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiEaOCz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 10:02:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9759C5DE4B;
        Tue, 31 May 2022 07:02:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e24so5127291pjt.0;
        Tue, 31 May 2022 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0Hh7aCIsbmWJUeM91f0XG111LTI0m02XSIDQdP3p8o=;
        b=qIdddx20RRVQsqi2bBon4e5xP53QUVXYAcKla4mKOICMRHf9/YvdsIdxp33VcbGRiw
         sh9QgZfTxntO4UktBd/cdCHjqIGnDtpboKNUJpjtHzJbA+RdudatPcsvIKi5iVQdgvpy
         C5hImeVpMvccnNwwBDyehkIWcWQ6L8QaBRczL8tB0MqbsJy1GNeMAwJXPOpffzjnYAlt
         G7qr7qvEj3OO0wfs7j14zbzWAus4DesU3wcMrtdwnFh2R+b+8itWDftZ+wfUVtnyJCiD
         l0cVftYnizzrpln5/JF0rQVrk9f9/bvbvTbVEnnhkLXr7tB2mymbzGy48K66TydEI/5I
         dQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0Hh7aCIsbmWJUeM91f0XG111LTI0m02XSIDQdP3p8o=;
        b=eRTRlX8Gqd4uOQ4hYggl0OKrc64wXwVz9kyNu+kcvxAl8QZNwFJ5O0VS7xhicznDf9
         cXxI3uh4GX+oDZC+vtqErJTsgHwXxhAHBWUP3TmKSEjpOOEntIvHSACdU6BGJ4fzB95L
         wdtQZIp7uMMPcrohiZLSnZwMbTskCO9XvRaNIWsJapeIXHLieehECo4xeM28AldCwU7l
         ym4towSYhiKBxMt0a6M8nkPae3Bhg45+1DRY1el/LyaUa1A5VoPSUB5B3KVhuZQjnzvv
         rDmwTz9ineRyTAuSwFx8lPS7C/4SlkrVh3Ltn0vWaYDWVnHxKAHmgoNcNJ5NrcZvF7Y9
         Vk5g==
X-Gm-Message-State: AOAM530+CLqUIOXC7J+pkFMMahohq0MWzMNmEoUugDBRlr8Y/Eb74kdj
        JRFajNlsMV7mCN+/l2Frosxz+6BOwsakTt8iTrU=
X-Google-Smtp-Source: ABdhPJyc7OKAhKtBgVceW2S6K5uMqrZZMd7/HcJeOJVW5Jr5QwyQMKFeAyO86lhFCnP21nhfEE8oYp+242DlouIAVK0=
X-Received: by 2002:a17:90b:17c6:b0:1e0:28bf:d429 with SMTP id
 me6-20020a17090b17c600b001e028bfd429mr29302482pjb.239.1654005773933; Tue, 31
 May 2022 07:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220524152159.2370739-1-Frank.Li@nxp.com> <20220525092306.wuansog6fe2ika3b@mobilestation>
 <CAHrpEqSa1JM8sm0QShCSXi++y9gVo9q5TmxPqwWiDADCrptrJw@mail.gmail.com>
In-Reply-To: <CAHrpEqSa1JM8sm0QShCSXi++y9gVo9q5TmxPqwWiDADCrptrJw@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Tue, 31 May 2022 09:02:42 -0500
Message-ID: <CAHrpEqRMpq+-H97Jm2F0c=0ey_3NsqgCvbTiBDA=vz2p4K+uZQ@mail.gmail.com>
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

On Wed, May 25, 2022 at 9:41 AM Zhi Li <lznuaa@gmail.com> wrote:
>
> On Wed, May 25, 2022 at 4:23 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hello Vinod
> >
> > On Tue, May 24, 2022 at 10:21:51AM -0500, Frank Li wrote:
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
> > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > flags (this patch removed at v11 because dma tree already have fixed
> > > patch)
> > >
> > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > ep
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
> > This series has been on review for over three months now. It has got
> > several acks, rb and tb tags from me, Manivannan and Kishon (the last
> > patch in the series). Seeing Gustavo hasn't been active for all that time
> > at all and hasn't performed any review for more than a year the
> > probability of getting his attention soon enough is almost zero. Thus
> > could you please give your acks if you are ok with the series content. Due
> > to having several more patchsets dependent on this one, Bjorn has agreed
> > to merge this series in through the PCI tree:
> > https://lore.kernel.org/linux-pci/20220524155201.GA247821@bhelgaas/
> > So the only thing we need is your ack tags.
> >
> > @Frank. Should there be a new patchset revision could you please add a
> > request to merge the series in to the PCI tree? I am a bit tired repeating
> > the same messages each time the new mailing review lap.)
>
> The key is to need Vinod to say something
>
> Best regards
> Frank Li.

@Vinod Kou:
       These patches were well reviewed by Serge Semin,  Bjorn,
Manivannan Sadhasivam, Kishon Vijay Abraham and tested on 3 platforms.
       Pending on your opinion because it touch file under /driver/dma/dw_edma/*

best regards
Frank Li

>
> >
> > -Sergey
> >
> > >
> > > Frank Li (6):
> > >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > >   dmaengine: dw-edma: Detach the private data and chip info structures
> > >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> > >     dw_edma_chip
> > >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > >     dw_edma_chip
> > >   dmaengine: dw-edma: Add support for chip specific flags
> > >   PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
> > >
> > > Serge Semin (2):
> > >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> > >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> > >     semantics
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
> > >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
> > >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
> > >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
> > >  include/linux/dma/edma.h                      |  59 +++++++-
> > >  9 files changed, 317 insertions(+), 180 deletions(-)
> > >
> > > --
> > > 2.35.1
> > >
