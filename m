Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2600D4E3FE8
	for <lists+dmaengine@lfdr.de>; Tue, 22 Mar 2022 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiCVN5c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Mar 2022 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiCVN5b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Mar 2022 09:57:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6734186F4;
        Tue, 22 Mar 2022 06:56:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o10so17615485ejd.1;
        Tue, 22 Mar 2022 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m64q3hTcapImMubOd29PORSwjMosMvdpyxO3AbNue3A=;
        b=XNWh3vpFWmSVhMxuG+J7wOR9z+GfOrocxYG8KjWFpWqURde0uuJZAY9bz729tkzGJ3
         gzDM4dmnYnXJgu4qciZZoGcfPwwQ1MNxNfPAHuNwGITdXkji7EpD+8J4386Ho/Sqw2VW
         R0yZj2wMdOwIckmuOMa7RiCunX+gvGCezWws7nGVuub/8bQPLJAvo1q+tUbNqwTRDhWU
         xg8LuYEY16IJb8tmbz6y8PEO3VB4CnegWEp6pn48yjhMB1/HDFjoFdv3SDY+X6fyBzMO
         hTUtpmiuroWa/RP1g+J2+FZrbAiLeQ+ynHMfZynXTJpvm4rOYz3Fx2o+sHGVAw7IAyiD
         70qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m64q3hTcapImMubOd29PORSwjMosMvdpyxO3AbNue3A=;
        b=8GnHIfcpTQkafldOf4CllQ5ptBROwWYQrvgcgIxNZksTUqHAYP9KsD42MCqy2XkqP3
         UpiyHv4QU7AbPrlp6GBmi3suYCliHSBPTOXDrMPgfq/q8UYunSovS0rdZTrLMpoiDVtj
         QFFDW6j8NiOmPz+hnjyvUfMWl4QMApr154E1/Yx+nMBgF8383qhvSorZgLG7BhnZgLYw
         ZybADDmVumYRP2YJVTDQI79AFoyJKQggbz55ngnyA6tOdQ142VvvQPv3QdJ0PneGraXs
         NrjsrGbFejQe8lvhhkk5NgKVG2N86Aw+ytBx1XlKXqOuDlpeXEtdA+5hClEdgvar9rzZ
         Ijag==
X-Gm-Message-State: AOAM5330cSwG5W6Cfkd23mZ8zEsx/CQKfVjRMP9BWlKOsUIYTpc05pi2
        aRh2j2agigwo1FsSOq0y+rOjkdL0Zy1l/zouvoI=
X-Google-Smtp-Source: ABdhPJw+GWdoldErHGr1In18Rt1XcSg3UdqjeT0Tfa2PJm9kltQ6KlelcVRbu06mgDIb8TNYTiJ5VXVMwYeEBLVZ9T8=
X-Received: by 2002:a17:907:1606:b0:6df:f528:4033 with SMTP id
 hb6-20020a170907160600b006dff5284033mr12731653ejc.433.1647957361078; Tue, 22
 Mar 2022 06:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220309211204.26050-1-Frank.Li@nxp.com> <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation> <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation> <20220312053720.GA4356@thinkpad>
 <20220314083340.244dfwo4v3uuhkkm@mobilestation> <20220318180605.GB4922@thinkpad>
 <20220318181911.7dujoioqc7iqwtsz@mobilestation> <20220320231639.ymfdhy2pkjy7jmbq@mobilestation>
In-Reply-To: <20220320231639.ymfdhy2pkjy7jmbq@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Tue, 22 Mar 2022 08:55:49 -0500
Message-ID: <CAHrpEqQ+TFkx5u=TKydT5uQ1V4P7w1dDYkp9dEksu-nxM65jYw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
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

On Sun, Mar 20, 2022 at 6:16 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Fri, Mar 18, 2022 at 09:19:13PM +0300, Serge Semin wrote:
> > On Fri, Mar 18, 2022 at 11:36:05PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 14, 2022 at 11:33:40AM +0300, Serge Semin wrote:
> > > > On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > > > > > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> > > >
> > > > [nip]
> > > >
> > > > > >
> > > > > > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > > > > > access to it happens over PCIe bus or by the local CPU.
> > > > > >
> > > > > > Not fully correct. Root Ports can also have eDMA embedded. In that
> > > > > > case the eDMA can be only accessible from the local CPU. At the same
> > > > > > time the DW PCIe End-point case is the IP-core synthesize parameters
> > > > > > specific. It's always possible to access the eDMA CSRs from local
> > > > > > CPU, but a particular End-point BAR can be pre-synthesize to map
> > > > > > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > > > > > perform a full End-point configuration. Anyway the case if the eDMA
> > > > > > functionality being accessible over the PCIe wire doesn't really make
> > > > > > much sense with no info regarding the application logic hidden behind
> > > > > > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > > > > > initialized with an address from the local (application) memory space.
> > > > > >
> > > > >
> > > > > Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> > > > > earlier commits...
> > > > >
> > > > > > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > > > > > part of the Root Port/End-point and only local CPU is supposed to have
> > > > > > it accessed and configured.
> > > > > >
> > > > > > I can resend this patch with my fix to the problem. What do you think?
> > > > > >
> > > > >
> > > >
> > > > > Yes, please do.
> > > >
> > > > Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
> > > > Could you please hold on with respinning the series for a few days?
> > > > I'll send out some of my patches then with a note which one of them
> > > > could be picked up by you and merged into this series.
> > > >
> > >
> >
>
> > > Any update on your patches?
> >
> > No worries. The patches are ready. But since Frank was on vacation I
> > decided to rebase all of my work on top of his series. I'll finish it
> > up shortly and send out my patchset till Monday for review. Then Frank
> > will be able to pick up two patches from there so to close up his
> > patchset (I'll give a note which one of them is of Frank' interes).
> > My series will be able to be merged in after Frank's series is reviewed
> > and accepted.
>
> Folks, couldn't make it this weekend. Too much sidework to do. Terribly
> sorry about that. Will send out the series tomorrow or at most in a day
> after tomorrow. Sorry for the inconvenience.

Any update on your patches?

best regards
Frank Li

>
> -Sergey
>
> >
> > >
> > > Btw, my colleage worked on merging the two dma devices used by the eDMA core
> > > for read & write channels into one. Initially I thought that was not needed as
> > > he did that for devicetree integration, but looking deeply I think that patch is
> > > necessary irrespective of DT.
> > >
> > > One standout problem is, we can't register debugfs directory under "dmaengine"
> > > properly because, both read and write dma devices share the same parent
> > > chip->dev.
> >
> > Right, my series fixes that and some other problems too. So please be
> > patient for a few more days.
> >
> > -Sergey
> >
> > >
> > > Thanks,
> > > Mani
> > >
> > > > -Sergey
> > > >
> > > > >
> > > > > Thanks,
> > > > > Mani
> > > > >
> > > > > > -Sergey
> > > > > >
> > > > > > >
> > > > > > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > > > > > already merged:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Mani
> > > > > > >
> > > > > > > > -Sergey
> > > > > > > >
> > > > > > > > > +                *
> > > > > > > > > +                ****************************************************************/
> > > > > > > > > +
> > > > > > > >
> > > > > > > > > +               if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > > > > +                   (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > > > > +                       read = true;
> > > > > > > >
> > > > > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > > > > redundant.
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +               /* Program the source and destination addresses for DMA read/write */
> > > > > > > > > +               if (read) {
> > > > > > > > >                         burst->sar = src_addr;
> > > > > > > > >                         if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > > > > >                                 burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > > > > --
> > > > > > > > > 2.24.0.rc1
> > > > > > > > >
