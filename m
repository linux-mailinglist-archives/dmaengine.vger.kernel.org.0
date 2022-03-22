Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E9E4E4000
	for <lists+dmaengine@lfdr.de>; Tue, 22 Mar 2022 15:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiCVOEw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Mar 2022 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiCVOEu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Mar 2022 10:04:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3476E25E8C;
        Tue, 22 Mar 2022 07:03:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m3so17991931lfj.11;
        Tue, 22 Mar 2022 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDa0+lmRqQyn3y9UD7SBBFCvq5AF8778Gd9CGISsBNw=;
        b=cow1jFfFIP1UUFfBpm6t1scKWUDz04PIRIZ8F547J8tYvltYSKhItt6xpnyHjfzx8q
         IV+mGLPHmhYnX8oY2+BiiOkAjhinOSOR/fliSSZbdnb+WtrouXWra41j2LEJxSjx9ZrC
         Kgr3LdTAW5PLZbqcVaGwBs/kKggWwYy+zAVfGuQtx1z6P1EZAOJKNdeEd/Fh8Yq4/JqO
         RbLsFDsD581O/gvv4+idXUlilVes7FzP9xO+SZKJQ6DwHB+rjq1VpPVw6XdkW3XFuw3D
         I4QOTT2Oj0inO+/IM/AzZJpjZwCMt61kBP2mP09+NnB2CC1Vs0VKlNjbZzwocv9ibR3S
         BlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDa0+lmRqQyn3y9UD7SBBFCvq5AF8778Gd9CGISsBNw=;
        b=uZJh2LH9GU1PsJWePGEBHSbNaq9TBEGm2lyvvWu1ARJAsax4qkTyuFmQgXH4VZXfZN
         H9lLXzb4oHJ+QvAVoTCVB2ATtpAFIpbhBkPbLX4Om96WUHDi8RD7lVBODYNlm1oQM+6a
         dyVwlbqznTALD47i32PIrGRmHHNHAwnqL/zgfaWWPTvlfC0wpUEBWlBmjCpLzgbT10nN
         fKHnETblTm92bnYjiFeDw/o3p3cCNNSPwna0eO5h9QL0hs34pX8GOoFCv9zIaaB1PDNd
         8Zxf4yZkJfQxwAkD3Oggy4yD0o+ya2gbZU1Zc/Ma4RaoN3wEj6KQ/Nzc8fDr9p4XLe7U
         b5nQ==
X-Gm-Message-State: AOAM53135b8Z0J9IRsp1mwTIKbO9NYQpt6/uxi6IboQi+Xlf62RPukOJ
        UOpJ2fwbClV70wI8XGc4eZk=
X-Google-Smtp-Source: ABdhPJyVLm8AE4ueSba++zWYXsGTpwGOyb0d622nQFIQBKifsBEPTJ78ILaoL3NZmEOs+ksniLfdGA==
X-Received: by 2002:a05:6512:158e:b0:44a:12b5:7fea with SMTP id bp14-20020a056512158e00b0044a12b57feamr12159730lfb.411.1647957793321;
        Tue, 22 Mar 2022 07:03:13 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea366000000b00248073ae9a2sm2486720ljn.84.2022.03.22.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:03:12 -0700 (PDT)
Date:   Tue, 22 Mar 2022 17:03:10 +0300
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
Message-ID: <20220322140310.micuffgksnst67cv@mobilestation>
References: <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation>
 <20220312053720.GA4356@thinkpad>
 <20220314083340.244dfwo4v3uuhkkm@mobilestation>
 <20220318180605.GB4922@thinkpad>
 <20220318181911.7dujoioqc7iqwtsz@mobilestation>
 <20220320231639.ymfdhy2pkjy7jmbq@mobilestation>
 <CAHrpEqQ+TFkx5u=TKydT5uQ1V4P7w1dDYkp9dEksu-nxM65jYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqQ+TFkx5u=TKydT5uQ1V4P7w1dDYkp9dEksu-nxM65jYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 22, 2022 at 08:55:49AM -0500, Zhi Li wrote:
> On Sun, Mar 20, 2022 at 6:16 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Fri, Mar 18, 2022 at 09:19:13PM +0300, Serge Semin wrote:
> > > On Fri, Mar 18, 2022 at 11:36:05PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Mar 14, 2022 at 11:33:40AM +0300, Serge Semin wrote:
> > > > > On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > > > > > > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> > > > >
> > > > > [nip]
> > > > >
> > > > > > >
> > > > > > > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > > > > > > access to it happens over PCIe bus or by the local CPU.
> > > > > > >
> > > > > > > Not fully correct. Root Ports can also have eDMA embedded. In that
> > > > > > > case the eDMA can be only accessible from the local CPU. At the same
> > > > > > > time the DW PCIe End-point case is the IP-core synthesize parameters
> > > > > > > specific. It's always possible to access the eDMA CSRs from local
> > > > > > > CPU, but a particular End-point BAR can be pre-synthesize to map
> > > > > > > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > > > > > > perform a full End-point configuration. Anyway the case if the eDMA
> > > > > > > functionality being accessible over the PCIe wire doesn't really make
> > > > > > > much sense with no info regarding the application logic hidden behind
> > > > > > > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > > > > > > initialized with an address from the local (application) memory space.
> > > > > > >
> > > > > >
> > > > > > Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> > > > > > earlier commits...
> > > > > >
> > > > > > > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > > > > > > part of the Root Port/End-point and only local CPU is supposed to have
> > > > > > > it accessed and configured.
> > > > > > >
> > > > > > > I can resend this patch with my fix to the problem. What do you think?
> > > > > > >
> > > > > >
> > > > >
> > > > > > Yes, please do.
> > > > >
> > > > > Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
> > > > > Could you please hold on with respinning the series for a few days?
> > > > > I'll send out some of my patches then with a note which one of them
> > > > > could be picked up by you and merged into this series.
> > > > >
> > > >
> > >
> >
> > > > Any update on your patches?
> > >
> > > No worries. The patches are ready. But since Frank was on vacation I
> > > decided to rebase all of my work on top of his series. I'll finish it
> > > up shortly and send out my patchset till Monday for review. Then Frank
> > > will be able to pick up two patches from there so to close up his
> > > patchset (I'll give a note which one of them is of Frank' interes).
> > > My series will be able to be merged in after Frank's series is reviewed
> > > and accepted.
> >
> > Folks, couldn't make it this weekend. Too much sidework to do. Terribly
> > sorry about that. Will send out the series tomorrow or at most in a day
> > after tomorrow. Sorry for the inconvenience.
> 

> Any update on your patches?

The patches are ready. Writing cover-letters and sending them out this
night. Sorry for the delay.

-Sergey

> 
> best regards
> Frank Li
> 
> >
> > -Sergey
> >
> > >
> > > >
> > > > Btw, my colleage worked on merging the two dma devices used by the eDMA core
> > > > for read & write channels into one. Initially I thought that was not needed as
> > > > he did that for devicetree integration, but looking deeply I think that patch is
> > > > necessary irrespective of DT.
> > > >
> > > > One standout problem is, we can't register debugfs directory under "dmaengine"
> > > > properly because, both read and write dma devices share the same parent
> > > > chip->dev.
> > >
> > > Right, my series fixes that and some other problems too. So please be
> > > patient for a few more days.
> > >
> > > -Sergey
> > >
> > > >
> > > > Thanks,
> > > > Mani
> > > >
> > > > > -Sergey
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Mani
> > > > > >
> > > > > > > -Sergey
> > > > > > >
> > > > > > > >
> > > > > > > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > > > > > > already merged:
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Mani
> > > > > > > >
> > > > > > > > > -Sergey
> > > > > > > > >
> > > > > > > > > > +                *
> > > > > > > > > > +                ****************************************************************/
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > > +               if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > > > > > +                   (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > > > > > +                       read = true;
> > > > > > > > >
> > > > > > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > > > > > redundant.
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +               /* Program the source and destination addresses for DMA read/write */
> > > > > > > > > > +               if (read) {
> > > > > > > > > >                         burst->sar = src_addr;
> > > > > > > > > >                         if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > > > > > >                                 burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > > > > > --
> > > > > > > > > > 2.24.0.rc1
> > > > > > > > > >
