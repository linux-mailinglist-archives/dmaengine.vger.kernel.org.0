Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B1533F63
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbiEYOlR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiEYOlR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 10:41:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF612C665;
        Wed, 25 May 2022 07:41:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 202so12409247pfu.0;
        Wed, 25 May 2022 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqyWCcuw6resJt3dcFv8smtgAfhH3RRn9K5xICLuJIs=;
        b=YYzOJd5WsdmRXSVKxp2N5jKtSJyJyDcgLW27+7R4tABBBM0nSvFvZCl6NUwNZGQ4aW
         ApcOuM+8vaa3jSTRFTTGYBewIv5bJxbR/baPKPv5a5ciVTaULzlITt1fynbCIhVm1vJf
         pboEeN55ngZcqNFtmtHlPxeeJvdP9X9ktTv2m1FDww7QavyC6sC6XDGHd76Hzk97HlYM
         u8nvgWzrVXmQdNLouh2FuCQ3f3X7NywUCLk5+t7rng5Z57JUrPGvBquuU7HDOi51I0UW
         bWt1ce4o+VvzWNmuiulh9i6zPz2UoeeMt6OMNZGkOp+Rwb9Xp6ZYhtOlqtPGxvP+vDz9
         jI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqyWCcuw6resJt3dcFv8smtgAfhH3RRn9K5xICLuJIs=;
        b=hDjuqRO63MThnfJGPjZ6KTryiNjTuKBMZnpkssxnwlZhTP71NG1iocD960qgQDG7a2
         eByB/gPg68hG33Ix1EOqzIYDiQ9w2N8yglXadnydBR4A6H1lYacnQ4y0gm0a3adY0gHy
         gWdt33NQ89grnkax3LUSCw/ADa80A3INP3R31jFVwixXxgj6tedlIJTHrRBI0p1wLsyj
         SlP93kY0RE+5Bj9OuISmJIVn/kxRQaS3dKq275gLb78H5MZjYpvQXg1QpgqHuD3oRZzs
         mQ8YnWd5o3Izi++b9PafpYODH1J9z5/QFW6c1ZrJzPjhpl9D/5yhIT3nQHJlttS6VwR/
         FLNA==
X-Gm-Message-State: AOAM530D00O9vKX7IerSy4cqoMjn3Y4Q71xEt4FCZurxjRv2u5pRSFZC
        bVaL3KJgyFxK6oWcCxXUryRvVEwVTjvPRCM9A6k=
X-Google-Smtp-Source: ABdhPJySy9jnDTIo1EhsJGZgSUNIPGPdFe1qEmwBRlGi1vzg5cKDbDc4N78b0y8LKpFiWCMHVUSyPzS4LyLN/2958aM=
X-Received: by 2002:a63:8f51:0:b0:3f6:2298:eaf3 with SMTP id
 r17-20020a638f51000000b003f62298eaf3mr28389400pgn.402.1653489675624; Wed, 25
 May 2022 07:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220524152159.2370739-1-Frank.Li@nxp.com> <20220525092306.wuansog6fe2ika3b@mobilestation>
In-Reply-To: <20220525092306.wuansog6fe2ika3b@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 25 May 2022 09:41:04 -0500
Message-ID: <CAHrpEqSa1JM8sm0QShCSXi++y9gVo9q5TmxPqwWiDADCrptrJw@mail.gmail.com>
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

On Wed, May 25, 2022 at 4:23 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Vinod
>
> On Tue, May 24, 2022 at 10:21:51AM -0500, Frank Li wrote:
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
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > flags (this patch removed at v11 because dma tree already have fixed
> > patch)
> >
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> >
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: Add embedded DMA controller test
> >
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
>
> This series has been on review for over three months now. It has got
> several acks, rb and tb tags from me, Manivannan and Kishon (the last
> patch in the series). Seeing Gustavo hasn't been active for all that time
> at all and hasn't performed any review for more than a year the
> probability of getting his attention soon enough is almost zero. Thus
> could you please give your acks if you are ok with the series content. Due
> to having several more patchsets dependent on this one, Bjorn has agreed
> to merge this series in through the PCI tree:
> https://lore.kernel.org/linux-pci/20220524155201.GA247821@bhelgaas/
> So the only thing we need is your ack tags.
>
> @Frank. Should there be a new patchset revision could you please add a
> request to merge the series in to the PCI tree? I am a bit tired repeating
> the same messages each time the new mailing review lap.)

The key is to need Vinod to say something

Best regards
Frank Li.

>
> -Sergey
>
> >
> > Frank Li (6):
> >   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >   dmaengine: dw-edma: Detach the private data and chip info structures
> >   dmaengine: dw-edma: Change rg_region to reg_base in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Add support for chip specific flags
> >   PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
> >
> > Serge Semin (2):
> >   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
> >   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
> >     semantics
> >
> >  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
> >  include/linux/dma/edma.h                      |  59 +++++++-
> >  9 files changed, 317 insertions(+), 180 deletions(-)
> >
> > --
> > 2.35.1
> >
