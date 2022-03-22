Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1690A4E491C
	for <lists+dmaengine@lfdr.de>; Tue, 22 Mar 2022 23:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiCVW0y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Mar 2022 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCVW0x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Mar 2022 18:26:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557B5FDA;
        Tue, 22 Mar 2022 15:25:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o6so25911508ljp.3;
        Tue, 22 Mar 2022 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ub9+GmQtO4ElyxIM/HBqz0vmDY/f82GSxtAGW4llrc4=;
        b=djH7ehmWwQ++1iKri0Q61AKBweWBAAxX0XvYT2GYQMPEJrkNY7aWBwF33JYw1moz/h
         S6jaMEGxUbJss9sw5pLtV3e/2FwMo4VEgPfU6BPwVsAAD1mK1Yrca+avCjtoTLpCkdg1
         +Zd1l06PfU0pDJumjaslFRzOYKCwG9PnFqyzgOQhN+PND2/dnST+6RLDmK9H2MMMugPc
         MIHKEqc7QFNG/UtdrnmTQ+XrnCHwo7QxjkdB+gIU0qJeQp99qlUa6O7G3GWCXO30WI/2
         ECS6qiWFkeyuDL8AlltbGsCg9BMrxZX8gawwKefW8vLLrxe5MT6W+KXB+7YL0F1E2wf0
         6aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ub9+GmQtO4ElyxIM/HBqz0vmDY/f82GSxtAGW4llrc4=;
        b=CcN7IEQxYMbdu9FldSgqBI7Bwyh9fy1Gfk9yXfi4aEpCg4bcxeDhrjU6QK/6B0AXOO
         g1f76+va03jGGas/WpfT8yapsVYKQEPbd9Gq5DiSrCjLxodItS3ayjNIolZHS3RLoXW/
         FrrPyR8mgZ5BD36gpHr/RRteuP6qH3TjgVreAaZ0HeyllFAKSXmTcIhlnb+Zg7OR/zT5
         wp12x85MWR2fY4vZOICaROfGK1DQWHogLO2b8UPgRRpYbiUI497REvAOHPTsSeFRBRCF
         biqsr32kPD2kAJU+rekYwKEbWHPT/MeyFONPPGrPnM6DfgYieqR+WWW9VXyZWdzWacxi
         HeLw==
X-Gm-Message-State: AOAM531BNQI0UGI7Hu40o9RvuQInSdoJbnJXQar0P1zKRl1nM5WS7IQf
        LwXlQ/fomzdKobvWaahpz8c=
X-Google-Smtp-Source: ABdhPJwaVq+ZZZJzsTMvAqDNWalSWddSNTotq9hACWuOTLw5WXYanQhPMcA0HoRpjmplMhtRWMPVNw==
X-Received: by 2002:a2e:b529:0:b0:249:23a9:3294 with SMTP id z9-20020a2eb529000000b0024923a93294mr20765248ljm.255.1647987922639;
        Tue, 22 Mar 2022 15:25:22 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id v2-20020ac258e2000000b004483faeb6f6sm2317551lfo.280.2022.03.22.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:25:22 -0700 (PDT)
Date:   Wed, 23 Mar 2022 01:25:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220322222520.3jgrfghnfxcb4etx@mobilestation>
References: <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation>
 <20220312053720.GA4356@thinkpad>
 <20220314083340.244dfwo4v3uuhkkm@mobilestation>
 <20220318180605.GB4922@thinkpad>
 <20220318181911.7dujoioqc7iqwtsz@mobilestation>
 <20220320231639.ymfdhy2pkjy7jmbq@mobilestation>
 <CAHrpEqQ+TFkx5u=TKydT5uQ1V4P7w1dDYkp9dEksu-nxM65jYw@mail.gmail.com>
 <20220322140310.micuffgksnst67cv@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322140310.micuffgksnst67cv@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 22, 2022 at 05:03:13PM +0300, Serge Semin wrote:
> On Tue, Mar 22, 2022 at 08:55:49AM -0500, Zhi Li wrote:
> > On Sun, Mar 20, 2022 at 6:16 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > >
> > > On Fri, Mar 18, 2022 at 09:19:13PM +0300, Serge Semin wrote:
> > > > On Fri, Mar 18, 2022 at 11:36:05PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Mar 14, 2022 at 11:33:40AM +0300, Serge Semin wrote:
> > > > > > On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > > > > > > > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> > > > > >
> > > > > > [nip]
> > > > > >
> > > > > > > >
> > > > > > > > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > > > > > > > access to it happens over PCIe bus or by the local CPU.
> > > > > > > >
> > > > > > > > Not fully correct. Root Ports can also have eDMA embedded. In that
> > > > > > > > case the eDMA can be only accessible from the local CPU. At the same
> > > > > > > > time the DW PCIe End-point case is the IP-core synthesize parameters
> > > > > > > > specific. It's always possible to access the eDMA CSRs from local
> > > > > > > > CPU, but a particular End-point BAR can be pre-synthesize to map
> > > > > > > > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > > > > > > > perform a full End-point configuration. Anyway the case if the eDMA
> > > > > > > > functionality being accessible over the PCIe wire doesn't really make
> > > > > > > > much sense with no info regarding the application logic hidden behind
> > > > > > > > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > > > > > > > initialized with an address from the local (application) memory space.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> > > > > > > earlier commits...
> > > > > > >
> > > > > > > > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > > > > > > > part of the Root Port/End-point and only local CPU is supposed to have
> > > > > > > > it accessed and configured.
> > > > > > > >
> > > > > > > > I can resend this patch with my fix to the problem. What do you think?
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > > > Yes, please do.
> > > > > >
> > > > > > Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
> > > > > > Could you please hold on with respinning the series for a few days?
> > > > > > I'll send out some of my patches then with a note which one of them
> > > > > > could be picked up by you and merged into this series.
> > > > > >
> > > > >
> > > >
> > >
> > > > > Any update on your patches?
> > > >
> > > > No worries. The patches are ready. But since Frank was on vacation I
> > > > decided to rebase all of my work on top of his series. I'll finish it
> > > > up shortly and send out my patchset till Monday for review. Then Frank
> > > > will be able to pick up two patches from there so to close up his
> > > > patchset (I'll give a note which one of them is of Frank' interes).
> > > > My series will be able to be merged in after Frank's series is reviewed
> > > > and accepted.
> > >
> > > Folks, couldn't make it this weekend. Too much sidework to do. Terribly
> > > sorry about that. Will send out the series tomorrow or at most in a day
> > > after tomorrow. Sorry for the inconvenience.
> > 
> 

> > Any update on your patches?
> 
> The patches are ready. Writing cover-letters and sending them out this
> night. Sorry for the delay.

Ah, couldn't finish the letters this night. Will send it tomorrow at
midday. Sorry one more time.

-Sergey

> 
> -Sergey
> 
> > 
> > best regards
> > Frank Li
> > 
> > >
> > > -Sergey
> > >
> > > >
> > > > >
> > > > > Btw, my colleage worked on merging the two dma devices used by the eDMA core
> > > > > for read & write channels into one. Initially I thought that was not needed as
> > > > > he did that for devicetree integration, but looking deeply I think that patch is
> > > > > necessary irrespective of DT.
> > > > >
> > > > > One standout problem is, we can't register debugfs directory under "dmaengine"
> > > > > properly because, both read and write dma devices share the same parent
> > > > > chip->dev.
> > > >
> > > > Right, my series fixes that and some other problems too. So please be
> > > > patient for a few more days.
> > > >
> > > > -Sergey
> > > >
> > > > >
> > > > > Thanks,
> > > > > Mani
> > > > >
> > > > > > -Sergey
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Mani
> > > > > > >
> > > > > > > > -Sergey
> > > > > > > >
> > > > > > > > >
> > > > > > > > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > > > > > > > already merged:
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Mani
> > > > > > > > >
> > > > > > > > > > -Sergey
> > > > > > > > > >
> > > > > > > > > > > +                *
> > > > > > > > > > > +                ****************************************************************/
> > > > > > > > > > > +
> > > > > > > > > >
> > > > > > > > > > > +               if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > > > > > > +                   (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > > > > > > +                       read = true;
> > > > > > > > > >
> > > > > > > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > > > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > > > > > > redundant.
> > > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +               /* Program the source and destination addresses for DMA read/write */
> > > > > > > > > > > +               if (read) {
> > > > > > > > > > >                         burst->sar = src_addr;
> > > > > > > > > > >                         if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > > > > > > >                                 burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > > > > > > --
> > > > > > > > > > > 2.24.0.rc1
> > > > > > > > > > >
