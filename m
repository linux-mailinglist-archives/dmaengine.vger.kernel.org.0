Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DEA54CA22
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbiFONrD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbiFONrB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 09:47:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE6D37BCF;
        Wed, 15 Jun 2022 06:46:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z14so7282190pgh.0;
        Wed, 15 Jun 2022 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7wiLKtrbYRb4LChqb9M7QfqXqDg1QDuru9cYf5u4UA=;
        b=lk6rlciQ/XlAfjDBhiScRnwvifz7iOq7uqwhdJ158MX0JEeZAeVye/vST9c+5n66tc
         fNEG6UJhw6nBL9ok0nUJ/GfiJuCiZqH3WSMp7tD4QtDLHl/1RhywXWaD7TvsSV5FzyVc
         vV3D1xK+LHll+B7++R8qDVnJeDPP62dueuR9is4HqyewVCzuX7TpxuZ3pzmq2Ijwq0Qd
         +GMcvtFt5L/QXoCcOpZpzpdQDFE5gD71F81ohNn+AfApBDM+4VLyPgyXAM51mBAVw4n5
         dyMSuhR/bXFpJ4tlgOM7m6tl4Ko97B15BLH93nRALP5oUxNCvlO0aIEo+UyZAd5uLtbA
         KRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7wiLKtrbYRb4LChqb9M7QfqXqDg1QDuru9cYf5u4UA=;
        b=4uy+1rPYldFhpv59pX4Fs6I1EFk9jBab6fElQhafp7PjXvH8RYeK0iM+CTxQY96gP3
         Z2W99uOiRN6RFs8pAPyy7gIPwtQO6PdfwDLCvRiMk91dF87U5x/xV65IwVAZJSyNDsJG
         bO6Im45PWr4c1Md1AV/Zys1zqUA1Xvo0tUqQITs0exAoMKR+oj4T8ZciBiPRdsQFXGBR
         ipQ6aoEUMdGrjO5Lbb8qAaLBeKj89ecBo/9wPiw+pfuPERqEPcMl5k6OfTVbcYJPJuAi
         V/ITmc+BpEjtrzvIJNXGRffuvfRKDOhzTDoluGIOywyeY3QWECYUqUUzeS0ytvEz3YZ6
         WXtQ==
X-Gm-Message-State: AOAM532D54/95d+GrFmH029rjRmkFbzoF3Mr5RChA9fGDGtqzRlLAkNB
        meV1p65QISZz1JRdblp5dUxhgzZseYRjWrMfwnbwXdbuTns=
X-Google-Smtp-Source: ABdhPJx5hraGjg59gdJ6yqSZh8nhK9bcbnJ+0XEwejVU1XGwK1tEXT7K0Dt1Sp2d0NPn5jqpG2duHymU51ZBqanik8g=
X-Received: by 2002:a63:1d62:0:b0:3fd:ebcd:13a4 with SMTP id
 d34-20020a631d62000000b003fdebcd13a4mr9179935pgm.151.1655300815069; Wed, 15
 Jun 2022 06:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220524054850.vrchh6icwfriszhn@mobilestation>
 <20220524155201.GA247821@bhelgaas> <20220525090710.4oleicw7xin6taxl@mobilestation>
In-Reply-To: <20220525090710.4oleicw7xin6taxl@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 15 Jun 2022 08:46:44 -0500
Message-ID: <CAHrpEqRDj5z2hVq54x9Z2PvOy5XeX9OiW7xSoiB0mq5dyP8E+w@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
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

On Wed, May 25, 2022 at 4:07 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Tue, May 24, 2022 at 10:52:01AM -0500, Bjorn Helgaas wrote:
> > On Tue, May 24, 2022 at 08:48:50AM +0300, Serge Semin wrote:
> > > On Mon, May 23, 2022 at 05:12:56PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, May 23, 2022 at 01:41:48PM -0500, Zhi Li wrote:
> > > > > On Mon, May 23, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Mon, May 23, 2022 at 02:06:47PM +0300, Serge Semin wrote:
> > > > > > > Hello Vinod,
> > > > > > >
> > > > > > > On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> > > > > > > > Default Designware EDMA just probe remotely at host side.
> > > > > > > > This patch allow EDMA driver can probe at EP side.
> > > > > > > >
> > > > > > > > 1. Clean up patch
> > > > > > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > > > > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > > > > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > > > > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > > > > > >
> > > > > > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > > > > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > > > > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > > > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > > > > > patch)
> > > > > > > >
> > > > > > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > > > > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > > > > > ep
> > > > > > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > > > > > >
> > > > > > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > > > > > >    PCI: endpoint: Add embedded DMA controller test
> > > > > > > >
> > > > > > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > > > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > > > > > controller driver.
> > > > > > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > > > > > >
> > > > > > > The series has been hanging out on review for over three months now.
> > > > > > > It has got to v11 and has been tested on at least two platforms. The
> > > > > > > original driver maintainer has been silent for all that time (most
> > > > > > > likely Gustavo dropped the driver maintaining role). Could you please
> > > > > > > merge it in seeing no comments have been posted for the last several
> > > > > > > weeks? The PCI Host/EP controller drivers maintainer suggested to get
> > > > > > > this series via the DMA-engine tree:
> > > > > > > https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
> > > > > > > which is obviously right seeing it mainly concerns the DW eDMA driver.
> > > > > > > Though after that Lorenzo disappeared as quickly as popped up.)
> > > > > > >
> > > > > > > There is one more series depending on the changes in this
> > > > > > > patchset:
> > > > > > > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > > > > > > Me and Frank already settled all the conflicts and inter-dependencies,
> > > > > > > so at least his series is more than ready to be merged in into the
> > > > > > > kernel repo. It would be very good to get it accepted on this merge
> > > > > > > window so to have the kernel v5.19 with all this changes available.
> > > > > >
> > >
> > > > > > Since the v5.19 merge window is already open, it seems doubtful that
> > > > > > anybody would merge this so late in the cycle.
> > >
> > > In this case it would be safer to merge this whole series through your
> > > repo. See my series:
> > > "[PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA controllers support"
> > > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > > depends in the Frank' patchset. Meanwhile my patchset is also based on the
> > > DW PCIe modifications introduced in the set of the series:
> > > "[PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support"
> > > https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> > > and
> > > "[PATCH v3 00/13] PCI: dwc: Various fixes and cleanups"
> > > https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
> > >
> > > So to speak in order to have more coherent repos with least merge,
> > > logical problems the next order of the merging would be preferable:
> > > 1) Frank's patchset (ready to be merged in):
> > > [PATCH v11 0/8] Enable designware PCI EP EDMA locally
> > > https://lore.kernel.org/linux-pci/20220517151915.2212838-1-Frank.Li@nxp.com
> > > 2) My series (ready to be merged in):
> > > [PATCH v3 00/13] PCI: dwc: Various fixes and cleanups
> > > https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
> > > 3) My series (still in review, I need to fix some Rob' and Manivannan' notes)
> > > [PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> > > https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
> > > 4) Me series (ready to be merged in, but depends on the prev patchsets):
> > > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > >
> > > Seeing the Frank patches won't make it into the mainline repo on
> > > this merge window, it would be great to collect all the changes in a
> > > single repository. Seeing Lorenzo disappeared as fast as popped up
> > > your repo is the best candidate since the DW eDMA block is a part of
> > > the DW PCIe controller.
> >
>
> > I'll be happy to merge this via the PCI tree, given acks from Gustavo
> > and/or Vinod.

@Vinod Koul
Friendly ping Vinod?

>
> Great! Thanks. I'll add my note regarding this to the v12 patchset
> thread. Alas Gustavo hasn't shown any sign of activity for more than a
> year (last commit on Feb 2021 and no more acks and rb tags afterwards).
> So we need to wait for the Vinod' ack.
>
> -Sergey
>
> >
> > Bjorn
