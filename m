Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454544D7D9E
	for <lists+dmaengine@lfdr.de>; Mon, 14 Mar 2022 09:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiCNIez (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Mar 2022 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiCNIey (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Mar 2022 04:34:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F165C8;
        Mon, 14 Mar 2022 01:33:44 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 25so20692123ljv.10;
        Mon, 14 Mar 2022 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/lxC0RZgyTNm5IJy+tApWTULFN2ZbIloTBHcLX3Txa4=;
        b=RK1LKmtrCEPcKEW6DR+Kh77VUky4SPt3P8QAMyVY/JtAio5EA/nG/jmmqBTTKvhp+e
         VdcVLcD7wlOJBVF6I04e2Zp6nfUMy37StwrwoOijqhqJ596yykKCRG+uSgXkGihbs3qS
         tyKic8dMUEIaxjRwF5djptDQQljsTgw2qV2wp6eZLt8N6FgUxZVknBlJrJrUOvU/P/Tk
         823A2HgaGgTJsEkWbVLeqZn8OAfH++SZC9sfSO878Rj/YT4PYAaafT9hZRTypt8p7yFX
         skSdhXFgfTzmTUXuIsGwKgcJ2C/CN5ADv8AzDOwQ68wIhN74oYw2w7nkwQZ/Qq4JV1bO
         J+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/lxC0RZgyTNm5IJy+tApWTULFN2ZbIloTBHcLX3Txa4=;
        b=PuLzBu/mn7ATOnxHltgnp9QXnEGJ4RSQjprjQzuekME5gBKxwHsgXJ/tkpuxd6FwSt
         T0t8qinlbkOQ/5XWw5nttTl1+vAgUrQlA8PAqQVHM4u0yxC9PpGagwELQcvk28KlhHay
         8Obhr+Wuj8YxhUkcN705g+r5I3yQ2HRZXYmqcie4VTyoCFs01lrDksrRtHuoLpWHppMV
         WVp6L/WiL9Vd/TJVDwTzAlfZUiTq7q2IcyXUgmtko+EJCmNSr2vyJ+Qoa1rO3PCRAh1D
         ORfD3oNQWT/UP1w/pf9+aLPhHKKqBD4ci8mr4anHeia7xJoXdiB+W0e1zZJ82aV/D07U
         59iw==
X-Gm-Message-State: AOAM533sA1uNlXwuM7OMM2ywoP25kfy8+lODMb2al6rvkN6muVBnR883
        OMbjc7Wh1fUWSYXM2Nbtu2A=
X-Google-Smtp-Source: ABdhPJzRKpeLltrQrE8DFtgLrrgPbOU9E2Y8LQXYmZRIlYR70Grus7D6/LJRPq+BfmZP88rPYoCTeQ==
X-Received: by 2002:a05:651c:12c7:b0:23e:b8f9:15b2 with SMTP id 7-20020a05651c12c700b0023eb8f915b2mr13323382lje.382.1647246822824;
        Mon, 14 Mar 2022 01:33:42 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b00443d9064160sm3127921lft.125.2022.03.14.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:33:42 -0700 (PDT)
Date:   Mon, 14 Mar 2022 11:33:40 +0300
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
Message-ID: <20220314083340.244dfwo4v3uuhkkm@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
 <20220311190147.pvjp6v7whjgyeuey@mobilestation>
 <20220312053720.GA4356@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312053720.GA4356@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Mar 12, 2022 at 11:07:20AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 11, 2022 at 10:01:47PM +0300, Serge Semin wrote:
> > On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:

[nip]

> > 
> > > As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> > > access to it happens over PCIe bus or by the local CPU.
> > 
> > Not fully correct. Root Ports can also have eDMA embedded. In that
> > case the eDMA can be only accessible from the local CPU. At the same
> > time the DW PCIe End-point case is the IP-core synthesize parameters
> > specific. It's always possible to access the eDMA CSRs from local
> > CPU, but a particular End-point BAR can be pre-synthesize to map
> > either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
> > perform a full End-point configuration. Anyway the case if the eDMA
> > functionality being accessible over the PCIe wire doesn't really make
> > much sense with no info regarding the application logic hidden behind
> > the PCIe End-point interface since SAR/DAR LLP is supposed to be
> > initialized with an address from the local (application) memory space.
> > 
> 
> Thanks for the explanation, it clarifies my doubt. I got misleaded by the
> earlier commits...
> 
> > So AFAICS the main usecase of the controller is 1) - when eDMA is a
> > part of the Root Port/End-point and only local CPU is supposed to have
> > it accessed and configured.
> > 
> > I can resend this patch with my fix to the problem. What do you think?
> > 
> 

> Yes, please do.

Ok. I'll be AFK today, but will send my patches tomorrow.  @Frank,
Could you please hold on with respinning the series for a few days?
I'll send out some of my patches then with a note which one of them
could be picked up by you and merged into this series.

-Sergey

> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > 
> > > The commit from Alan Mikhak is what I took as a reference since the patch was
> > > already merged:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > -Sergey
> > > > 
> > > > > +		 *
> > > > > +		 ****************************************************************/
> > > > > +
> > > > 
> > > > > +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > +			read = true;
> > > > 
> > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > redundant.
> > > > 
> > > > > +
> > > > > +		/* Program the source and destination addresses for DMA read/write */
> > > > > +		if (read) {
> > > > >  			burst->sar = src_addr;
> > > > >  			if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > >  				burst->dar = xfer->xfer.cyclic.paddr;
> > > > > -- 
> > > > > 2.24.0.rc1
> > > > > 
