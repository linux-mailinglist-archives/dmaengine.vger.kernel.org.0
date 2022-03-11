Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD984D67E4
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiCKRnL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 12:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350897AbiCKRm6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 12:42:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21B1D67C3
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 09:41:43 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w4so8211437ply.13
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 09:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IL8WqP9zRtOM2eqAASZmWYxkmnzpOI42XIv9DnV3igs=;
        b=fL4myNujW+4hX5z8zH6VbUJkmXQPxszVaeTi1v8CWpJEPrV+vV3zMwWVXdoHvvOqvc
         IoZbjeYWXo2lGhhrG7mZ03qv2OEkf4gL2DtUR+wy3pHmjZa9bItguE8abxPv0Qm81xro
         Nd661OVTH4fDgjd1aXVQJrVfR5RVD+RXflMNAu3gyp/CCVZbPmw096g2VbAaU7yWJevy
         f9819+Ov403pP6sn85HRcX1o/gz9WyQ4mk4SabMCXoyXeaYQe1QGEX0pYxHoqDks6Kf0
         v/lR7HZijlSAqSBo/DsbUt1fPIvBDRdISJybZOiRyepp1+XnjSmt9wROYFWUP7EIJB/b
         QDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IL8WqP9zRtOM2eqAASZmWYxkmnzpOI42XIv9DnV3igs=;
        b=yp7RYM1vSlGLN4voi9n0MeV9t31rurvrYR5cfBi0d6DHHzaoSlOJicNXoOYzELIllM
         j++JzSUrXwis7gkHZtR1kn2FfnInk8Dp4QyiPXEOoOLaGOc4XFL/n+HJzhzfOrIhoXXS
         UDQvn8ETLxDmJozj7xXROze5o69GuJbPQBpggzMTRovgo8SL+f4MEyZYGaWCg7Oz9itP
         ZMSDAZVWEx5KMcu6baL/Uujlgd6FvAItKdVNhKtRB+8Kt+q8aNpewZqnjBEKjQx1qyPM
         LsCsa1qPraCI47/mOirXaLbHYQmtGxxrrWf7vwg+8GOYT2Hr3lxWIHeVtdd6FHBJt9GT
         swug==
X-Gm-Message-State: AOAM533FI5EOlafeNmTQEM0MFvErvfAYf8yrtYTlrqzOQX7vm9b+sfJy
        CoLb7qWOCrgKwKMTYAtT1bMz
X-Google-Smtp-Source: ABdhPJweJHugv9aOdFdj0Vo5F5r4S0G1rgcR8NUxe4eNwcvtb9ycupmtfNrGT1ITb5JiJuJQ8LE4lw==
X-Received: by 2002:a17:902:ed82:b0:151:9b29:5123 with SMTP id e2-20020a170902ed8200b001519b295123mr11524259plj.138.1647020502410;
        Fri, 11 Mar 2022 09:41:42 -0800 (PST)
Received: from thinkpad ([117.202.191.144])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm10282205pjb.27.2022.03.11.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:41:42 -0800 (PST)
Date:   Fri, 11 Mar 2022 23:11:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220311174134.GA3966@thinkpad>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 07:31:23PM +0300, Serge Semin wrote:
> On Wed, Mar 09, 2022 at 03:12:01PM -0600, Frank Li wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
> > programs the source and destination addresses for read and write. Since the
> > Root complex and Endpoint uses the opposite channels for read/write, fix the
> > issue by finding out the read operation first and program the eDMA accordingly.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
> > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > No change between v1 to v4
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 66dc650577919..507f08db1aad3 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >  	struct dw_edma_chunk *chunk;
> >  	struct dw_edma_burst *burst;
> >  	struct dw_edma_desc *desc;
> > +	bool read = false;
> >  	u32 cnt = 0;
> >  	int i;
> >  
> > @@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >  		chunk->ll_region.sz += burst->sz;
> >  		desc->alloc_sz += burst->sz;
> >  
> > -		if (chan->dir == EDMA_DIR_WRITE) {
> > +		/****************************************************************
> > +		 *
> 
> > +		 *        Root Complex                           Endpoint
> > +		 * +-----------------------+             +----------------------+
> > +		 * |                       |    TX CH    |                      |
> > +		 * |                       |             |                      |
> > +		 * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
> > +		 * |                       |             |                      |
> > +		 * |                       |             |                      |
> > +		 * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
> > +		 * |                       |             |                      |
> > +		 * |                       |    RX CH    |                      |
> > +		 * +-----------------------+             +----------------------+
> > +		 *
> > +		 * If eDMA is controlled by the Root complex, TX channel
> > +		 * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
> > +		 * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
> > +		 *
> > +		 * If eDMA is controlled by the endpoint, RX channel
> > +		 * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
> > +		 * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
> 
> Either I have some wrong notion about this issue, or something wrong
> with the explanation above and with this fix below.
> 
> From my understanding of the possible DW eDMA IP-core setups the
> scatch above and the text below it are incorrect. Here is the way the
> DW eDMA can be used:
> 1) Embedded into the DW PCIe Host/EP controller. In this case
> CPU/Application Memory is the memory of the CPU attached to the
> host/EP controller, while the remote (link partner) memory is the PCIe
> bus memory. In this case MEM_TO_DEV operation is supposed to be
> performed by the Tx/Write channels, while the DEV_TO_MEM operation -
> by the Rx/Read channels.
> 

I'm not aware or even not sure about the use of eDMA in the PCIe host.
If that's the case, how the endpoint can access it from remote perspective?
Do you have a usecase or an example where used or even documented?

> Note it's applicable for both Host and End-point case, when Linux is
> running on the CPU-side of the eDMA controller. So if it's DW PCIe
> end-point, then MEM_TO_DEV means copying data from the local CPU
> memory into the remote memory. In general the remote memory can be
> either some PCIe device on the bus or the Root Complex' CPU memory,
> each of which is some remote device anyway from the Local CPU
> perspective.
> 
> 2) Embedded into the PCIe EP. This case is implemented in the
> drivers/dma/dw-edma/dw-edma-pcie.c driver. AFAICS from the commits log
> and from the driver code, that device is a Synopsys PCIe EndPoint IP
> prototype kit. It is a normal PCIe peripheral device with eDMA
> embedded, which CPU/Application interface is connected to some
> embedded SRAM while remote (link partner) interface is directed
> towards the PCIe bus. At the same time the device is setup and handled
> by the code running on a CPU connected to the PCIe Host controller.  I
> think that in order to preserve the normal DMA operations semantics we
> still need to consider the MEM_TO_DEV/DEV_TO_MEM operations from the
> host CPU perspective, since that's the side the DMA controller is
> supposed to be setup from.  In this MEM_TO_DEV is supposed to be used
> to copy data from the host CPU memory into the remote device memory.
> It means to allocate Rx/Read channel on the eDMA controller, so one
> would be read data from the Local CPU memory and copied it to the PCIe
> device SRAM. The logic of the DEV_TO_MEM direction would be just
> flipped. The eDMA PCIe device shall use Tx/Write channel to copy data
> from it's SRAM into the Host CPU memory.
> 
> Please note as I understand the case 2) describes the Synopsys PCIe
> EndPoint IP prototype kit, which is based on some FPGA code. It's just
> a test setup with no real application, while the case 1) is a real setup
> available on our SoC and I guess on yours.
> 
> So what I suggest in the framework of this patch is just to implement
> the case 1) only. While the case 2) as it's an artificial one can be
> manually handled by the DMA client drivers. BTW There aren't ones available
> in the kernel anyway. The only exception is an old-time attempt to get
> an eDMA IP test-driver mainlined into the kernel:
> https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> But it was long time ago. So it's unlikely to be accepted at all.
> 
> What do you think?
> 

As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
access to it happens over PCIe bus or by the local CPU.

The commit from Alan Mikhak is what I took as a reference since the patch was
already merged:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9

Thanks,
Mani

> -Sergey
> 
> > +		 *
> > +		 ****************************************************************/
> > +
> 
> > +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > +			read = true;
> 
> Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> redundant.
> 
> > +
> > +		/* Program the source and destination addresses for DMA read/write */
> > +		if (read) {
> >  			burst->sar = src_addr;
> >  			if (xfer->type == EDMA_XFER_CYCLIC) {
> >  				burst->dar = xfer->xfer.cyclic.paddr;
> > -- 
> > 2.24.0.rc1
> > 
