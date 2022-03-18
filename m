Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154114DE0E1
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiCRSUf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiCRSUe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 14:20:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E32EDC18;
        Fri, 18 Mar 2022 11:19:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q5so12286291ljb.11;
        Fri, 18 Mar 2022 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8udtdK6ScxRgqNThejz2COvggJqjemEq8DiYDv9/kJk=;
        b=HZf87xPKvFkSi/GxRXdPCdQ3/jlc9xR8gjCMXv0CkICwlBIMVe70KIkTlbd+PTcCDO
         3xLpzq/GEkhLZDGDznFZdJe2/2b6kpnc/kgOVDto9G5Ra2JCM6b3g8YixHdpWLTCeSAZ
         NAyEda9tjuAz3LwlIrANqE5zNXzxoLI9qqsC/XR8ROmt822IATS93VQMTgdXgDapDjNB
         DiJjtNv5lj4AEnHxvT4KqPKJ0PcMQXaeW30hKZHnjtBZNbbdl1lFAykYcAJILnVrjlhG
         brzYjhkLNTfRmyGOHxtYisZ5psAt45e86D/5ztR89arwHBtlr2tq6tPgJcykbCoc0/YD
         d2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8udtdK6ScxRgqNThejz2COvggJqjemEq8DiYDv9/kJk=;
        b=7aIG09Roz3qowfpskaaGwmbDfbdLDP4Jo7Qd1yq6A5hT445jXno5xvGLUUveMRYRJb
         kVSuakf+yRA23cNIk8xOjnoPWIvGQlgHsYkZpdrDWTJHbLIgGJIs2DiHLrDIIMKZ7wxo
         EB/fUpWIwO8wSriNwgZWgdfsWHfaYaBSvR7TNJlzeMO+kSrcXg94VJBQos5xCS7ZxYAn
         gkgEW4LP4XOfhqyVW0aV/AQjfLGMILIdaqBW8yukQdZF5hq5NIZU7uzpa4bKRv/+ZUve
         i7Yhv+RHCKhLnMjXjz64fLE9hOZuXIk2uY8pfYpRN9cq3HidMQL2QVnhzVlNtoCP/J3p
         EN+Q==
X-Gm-Message-State: AOAM532bXjlAs5P2Di9s+AIV/S9U+BAaTZ6pmN+Xpjb9BdqyFBGrcoMS
        mgZze7bVG31dtneRoR4XvV4=
X-Google-Smtp-Source: ABdhPJxtLM61lOyG7EBx55psA4oU7dwUstVtKa0XeowKeL8i2lDrBUgzr1vHfQWqGJsQ39pdjUB46g==
X-Received: by 2002:a2e:3602:0:b0:249:22dd:8b4e with SMTP id d2-20020a2e3602000000b0024922dd8b4emr6645626lja.299.1647627553345;
        Fri, 18 Mar 2022 11:19:13 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id s12-20020ac25fac000000b004435e2e0a08sm952291lfe.251.2022.03.18.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:19:12 -0700 (PDT)
Date:   Fri, 18 Mar 2022 21:19:11 +0300
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
Message-ID: <20220318181911.7dujoioqc7iqwtsz@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation>
 <20220312053720.GA4356@thinkpad>
 <20220314083340.244dfwo4v3uuhkkm@mobilestation>
 <20220318180605.GB4922@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318180605.GB4922@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 18, 2022 at 11:36:05PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 14, 2022 at 11:33:40AM +0300, Serge Semin wrote:
> > On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > > > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> > 
> > [nip]
> > 
> > > > 
> > > > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > > > access to it happens over PCIe bus or by the local CPU.
> > > > 
> > > > Not fully correct. Root Ports can also have eDMA embedded. In that
> > > > case the eDMA can be only accessible from the local CPU. At the same
> > > > time the DW PCIe End-point case is the IP-core synthesize parameters
> > > > specific. It's always possible to access the eDMA CSRs from local
> > > > CPU, but a particular End-point BAR can be pre-synthesize to map
> > > > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > > > perform a full End-point configuration. Anyway the case if the eDMA
> > > > functionality being accessible over the PCIe wire doesn't really make
> > > > much sense with no info regarding the application logic hidden behind
> > > > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > > > initialized with an address from the local (application) memory space.
> > > > 
> > > 
> > > Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> > > earlier commits...
> > > 
> > > > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > > > part of the Root Port/End-point and only local CPU is supposed to have
> > > > it accessed and configured.
> > > > 
> > > > I can resend this patch with my fix to the problem. What do you think?
> > > > 
> > > 
> > 
> > > Yes, please do.
> > 
> > Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
> > Could you please hold on with respinning the series for a few days?
> > I'll send out some of my patches then with a note which one of them
> > could be picked up by you and merged into this series.
> > 
> 

> Any update on your patches?

No worries. The patches are ready. But since Frank was on vacation I
decided to rebase all of my work on top of his series. I'll finish it
up shortly and send out my patchset till Monday for review. Then Frank
will be able to pick up two patches from there so to close up his
patchset (I'll give a note which one of them is of Frank' interes).
My series will be able to be merged in after Frank's series is reviewed
and accepted.

> 
> Btw, my colleage worked on merging the two dma devices used by the eDMA core
> for read & write channels into one. Initially I thought that was not needed as
> he did that for devicetree integration, but looking deeply I think that patch is
> necessary irrespective of DT.
> 
> One standout problem is, we can't register debugfs directory under "dmaengine"
> properly because, both read and write dma devices share the same parent
> chip->dev.

Right, my series fixes that and some other problems too. So please be
patient for a few more days.

-Sergey

> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > -Sergey
> > > > 
> > > > > 
> > > > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > > > already merged:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > > > 
> > > > > Thanks,
> > > > > Mani
> > > > > 
> > > > > > -Sergey
> > > > > > 
> > > > > > > +		 *
> > > > > > > +		 ****************************************************************/
> > > > > > > +
> > > > > > 
> > > > > > > +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > > +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > > +			read = true;
> > > > > > 
> > > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > > redundant.
> > > > > > 
> > > > > > > +
> > > > > > > +		/* Program the source and destination addresses for DMA read/write */
> > > > > > > +		if (read) {
> > > > > > >  			burst->sar = src_addr;
> > > > > > >  			if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > > >  				burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > > -- 
> > > > > > > 2.24.0.rc1
> > > > > > > 
