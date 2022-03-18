Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E04DE0BA
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 19:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiCRSHd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiCRSHc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 14:07:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319652F09E0
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 11:06:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so6636812pjb.1
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=at/qdqR1ufuVhvfs+HZINxZ4vyB2x/I4NQXo9PMyViY=;
        b=i/U/HnoMhWTp2rNT4FSmtLYc/qUKqRDkx9BmsA2b4M1ZHGu8Ds0789v/Cs7jnquFQ5
         58Xa2LoWucVNdw+fSAmdeqalSDfAhW1xSicd5kzFD7pxJZXeKoWtjwqrL2GCQQEVDWr3
         gW5mx/DmLMcwSF01odDRbeFpsER3rBKqgr50LCknJzjsqprOBAjDQQdIAqUQTEuHs0Op
         yVPyLNZ0woDMqH/G9fSQaCu6gyv4Z0TSVIxnLLsew5BrWquCx3APA2Y77ffJ7xi+eCXq
         edGd3YgFP0o4QZsZeS6q907ThHUyijK/CYNKt9AV6+umv5UNeGeAiD3Vhi3qS//zC11k
         Vnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=at/qdqR1ufuVhvfs+HZINxZ4vyB2x/I4NQXo9PMyViY=;
        b=N3Y6yv+pqlWK9bRVmkKwu4psSSTtWhkdN3wclHWA6iSYZdgm7pryHSVt96mVWeJbdB
         G+RXkJXFJDxZcp3p+BYQd4eMLFD9f5CGVIXXa4W0qCusBmickYc4PU4Gd7ZnyMJZy2nn
         sHxgYk7uV2lOFh1cqxqQGSNVKVnPAdYBwB00qskoFQttlkvi9QiLVyTUbwIumxd9NzZk
         wnQxrrk/e51kHMs6e23ip1zkAlTfwdGiGIyH6bXkZkMTpUuFe+jEhMEIpGNlBM8TgYUl
         uM+4nK2ahKo69cSncVcbOWC1h2+tBL3Tfw7qCdtfvVUWs66z+Wuc+ebR9hSwkQnDc3/+
         y+mg==
X-Gm-Message-State: AOAM531ucos3A2k+1yg1JbUdmBV4j/5SSs+WeeIRqKu6y1ABcgYXPtRC
        6Xj3OEfXNFyjTvSvR0yNX6k3
X-Google-Smtp-Source: ABdhPJygmbgM89gK6740niy0LTKS9rKowmghWeK+nrA2LTDXHdw7BwmRuVM1kwCQGoY7NNTvMRXw0Q==
X-Received: by 2002:a17:90b:3b4c:b0:1c5:df79:906f with SMTP id ot12-20020a17090b3b4c00b001c5df79906fmr23390670pjb.222.1647626772619;
        Fri, 18 Mar 2022 11:06:12 -0700 (PDT)
Received: from thinkpad ([117.217.178.61])
        by smtp.gmail.com with ESMTPSA id lp13-20020a17090b4a8d00b001c18b1114c8sm12850245pjb.10.2022.03.18.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:06:12 -0700 (PDT)
Date:   Fri, 18 Mar 2022 23:36:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220318180605.GB4922@thinkpad>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation>
 <20220312053720.GA4356@thinkpad>
 <20220314083340.244dfwo4v3uuhkkm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314083340.244dfwo4v3uuhkkm@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 14, 2022 at 11:33:40AM +0300, Serge Semin wrote:
> On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> 
> [nip]
> 
> > > 
> > > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > > access to it happens over PCIe bus or by the local CPU.
> > > 
> > > Not fully correct. Root Ports can also have eDMA embedded. In that
> > > case the eDMA can be only accessible from the local CPU. At the same
> > > time the DW PCIe End-point case is the IP-core synthesize parameters
> > > specific. It's always possible to access the eDMA CSRs from local
> > > CPU, but a particular End-point BAR can be pre-synthesize to map
> > > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > > perform a full End-point configuration. Anyway the case if the eDMA
> > > functionality being accessible over the PCIe wire doesn't really make
> > > much sense with no info regarding the application logic hidden behind
> > > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > > initialized with an address from the local (application) memory space.
> > > 
> > 
> > Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> > earlier commits...
> > 
> > > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > > part of the Root Port/End-point and only local CPU is supposed to have
> > > it accessed and configured.
> > > 
> > > I can resend this patch with my fix to the problem. What do you think?
> > > 
> > 
> 
> > Yes, please do.
> 
> Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
> Could you please hold on with respinning the series for a few days?
> I'll send out some of my patches then with a note which one of them
> could be picked up by you and merged into this series.
> 

Any update on your patches?

Btw, my colleage worked on merging the two dma devices used by the eDMA core
for read & write channels into one. Initially I thought that was not needed as
he did that for devicetree integration, but looking deeply I think that patch is
necessary irrespective of DT.

One standout problem is, we can't register debugfs directory under "dmaengine"
properly because, both read and write dma devices share the same parent
chip->dev.

Thanks,
Mani

> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > > -Sergey
> > > 
> > > > 
> > > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > > already merged:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > > 
> > > > Thanks,
> > > > Mani
> > > > 
> > > > > -Sergey
> > > > > 
> > > > > > +		 *
> > > > > > +		 ****************************************************************/
> > > > > > +
> > > > > 
> > > > > > +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > +			read = true;
> > > > > 
> > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > redundant.
> > > > > 
> > > > > > +
> > > > > > +		/* Program the source and destination addresses for DMA read/write */
> > > > > > +		if (read) {
> > > > > >  			burst->sar = src_addr;
> > > > > >  			if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > >  				burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > -- 
> > > > > > 2.24.0.rc1
> > > > > > 
