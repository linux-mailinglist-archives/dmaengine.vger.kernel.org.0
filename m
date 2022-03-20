Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910B4E1E3A
	for <lists+dmaengine@lfdr.de>; Mon, 21 Mar 2022 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbiCTXSI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Mar 2022 19:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiCTXSH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Mar 2022 19:18:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0344F329C;
        Sun, 20 Mar 2022 16:16:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w27so22125408lfa.5;
        Sun, 20 Mar 2022 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3qf4U37WdvGH1xot8tLXiIVPtYvjsXskqDgkPybObY8=;
        b=ZES6Oh5q8WZ83K+9K0ggVX7E5epnJd79t3/QuYINzbk1S8g5yX7J6F6BAYPT3a6DzF
         pfBlzfDZeaG7f3h+yq5nox6/ET71uRDHQrq7+M/trhbtcX4P/aeBvxxN21rq8BB+cinH
         S+GUx6Wjl9B+m3+YSGiUFhczbRTLYX884l2zOI+pPKRwc015KL6yIvJ8tjQXWVTLskMH
         ngUGXKJqxZ6iqFPvqAbWR4wRg5gXOdEPb8qxwX8fTVZL9G4+qqubn/s3TfNDayEVJcCN
         y+0CasJz4u4zrNiwDGtPhLhG5hRFL8Bzt4ThO9JyyDrXtmMBBTlGKXR3SQlmdmf38tRB
         pMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3qf4U37WdvGH1xot8tLXiIVPtYvjsXskqDgkPybObY8=;
        b=iMoIapO3CHqxE1weCXdN6h7NGeUAlE1YVitjlMzNVCTAlDksXObMcNtNRECDy/Pe9w
         N5MuzwXW6P+jlRff2rxxjJPyI0JHBcnNS4pYZyqOZs1dA+JTJ7dtu+JCf0Npnf/SnBMT
         ZKNyGLFZmid+Ih7fOSK99xCSaWJrIueIHgSPxjBo52f6m1PqRe1cHqMfOIh5fhaoJ3yt
         +kJBOcU6bf1c85leJOlDMf/6zQSCR+eCX8eW+pTU1vhpWYaOCvOw6WzS+aFhte2h0AS3
         j6yO712A+Swvqm5KXMmjI2p6/8auqbvc94i3sVKJP+a+uerksPTte5VlwukyGs0S/HVB
         e2MQ==
X-Gm-Message-State: AOAM531o56rKaQoZZMALHLzqj6aoUq5weJXnt1r3W2b3B28VCZwFih/X
        W6sf7C8jUkWkKUGRRee5fs6Su5QHebNcfA==
X-Google-Smtp-Source: ABdhPJyvEhODkaO2Nn4vQltCYU9EVNLvK0feR2ihXEV6/87cRQ9nP96upKUHvLNLOnW1SgxDKzO5YA==
X-Received: by 2002:a05:6512:a88:b0:445:ce77:33d1 with SMTP id m8-20020a0565120a8800b00445ce7733d1mr12507438lfu.389.1647818201674;
        Sun, 20 Mar 2022 16:16:41 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id m24-20020a197118000000b00448bb0df9ffsm1598365lfc.140.2022.03.20.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 16:16:41 -0700 (PDT)
Date:   Mon, 21 Mar 2022 02:16:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220320231639.ymfdhy2pkjy7jmbq@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation>
 <20220312053720.GA4356@thinkpad>
 <20220314083340.244dfwo4v3uuhkkm@mobilestation>
 <20220318180605.GB4922@thinkpad>
 <20220318181911.7dujoioqc7iqwtsz@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318181911.7dujoioqc7iqwtsz@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 18, 2022 at 09:19:13PM +0300, Serge Semin wrote:
> On Fri, Mar 18, 2022 at 11:36:05PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 14, 2022 at 11:33:40AM +0300, Serge Semin wrote:
> > > On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > > > > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > [nip]
> > > 
> > > > > 
> > > > > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > > > > access to it happens over PCIe bus or by the local CPU.
> > > > > 
> > > > > Not fully correct. Root Ports can also have eDMA embedded. In that
> > > > > case the eDMA can be only accessible from the local CPU. At the same
> > > > > time the DW PCIe End-point case is the IP-core synthesize parameters
> > > > > specific. It's always possible to access the eDMA CSRs from local
> > > > > CPU, but a particular End-point BAR can be pre-synthesize to map
> > > > > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > > > > perform a full End-point configuration. Anyway the case if the eDMA
> > > > > functionality being accessible over the PCIe wire doesn't really make
> > > > > much sense with no info regarding the application logic hidden behind
> > > > > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > > > > initialized with an address from the local (application) memory space.
> > > > > 
> > > > 
> > > > Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> > > > earlier commits...
> > > > 
> > > > > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > > > > part of the Root Port/End-point and only local CPU is supposed to have
> > > > > it accessed and configured.
> > > > > 
> > > > > I can resend this patch with my fix to the problem. What do you think?
> > > > > 
> > > > 
> > > 
> > > > Yes, please do.
> > > 
> > > Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
> > > Could you please hold on with respinning the series for a few days?
> > > I'll send out some of my patches then with a note which one of them
> > > could be picked up by you and merged into this series.
> > > 
> > 
> 

> > Any update on your patches?
> 
> No worries. The patches are ready. But since Frank was on vacation I
> decided to rebase all of my work on top of his series. I'll finish it
> up shortly and send out my patchset till Monday for review. Then Frank
> will be able to pick up two patches from there so to close up his
> patchset (I'll give a note which one of them is of Frank' interes).
> My series will be able to be merged in after Frank's series is reviewed
> and accepted.

Folks, couldn't make it this weekend. Too much sidework to do. Terribly
sorry about that. Will send out the series tomorrow or at most in a day
after tomorrow. Sorry for the inconvenience.

-Sergey

> 
> > 
> > Btw, my colleage worked on merging the two dma devices used by the eDMA core
> > for read & write channels into one. Initially I thought that was not needed as
> > he did that for devicetree integration, but looking deeply I think that patch is
> > necessary irrespective of DT.
> > 
> > One standout problem is, we can't register debugfs directory under "dmaengine"
> > properly because, both read and write dma devices share the same parent
> > chip->dev.
> 
> Right, my series fixes that and some other problems too. So please be
> patient for a few more days.
> 
> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > > -Sergey
> > > 
> > > > 
> > > > Thanks,
> > > > Mani
> > > > 
> > > > > -Sergey
> > > > > 
> > > > > > 
> > > > > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > > > > already merged:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > > > > 
> > > > > > Thanks,
> > > > > > Mani
> > > > > > 
> > > > > > > -Sergey
> > > > > > > 
> > > > > > > > +		 *
> > > > > > > > +		 ****************************************************************/
> > > > > > > > +
> > > > > > > 
> > > > > > > > +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > > > +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > > > +			read = true;
> > > > > > > 
> > > > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > > > redundant.
> > > > > > > 
> > > > > > > > +
> > > > > > > > +		/* Program the source and destination addresses for DMA read/write */
> > > > > > > > +		if (read) {
> > > > > > > >  			burst->sar = src_addr;
> > > > > > > >  			if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > > > >  				burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > > > -- 
> > > > > > > > 2.24.0.rc1
> > > > > > > > 
