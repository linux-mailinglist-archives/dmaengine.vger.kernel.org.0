Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263434D68DB
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 20:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbiCKTC5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 14:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiCKTC4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 14:02:56 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C581B3A64;
        Fri, 11 Mar 2022 11:01:52 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id q5so13249120ljb.11;
        Fri, 11 Mar 2022 11:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnrBejOhyT5C0jAW86TjsRhNvZo6bsHC7jAzqYVrGgM=;
        b=EGCjwfJxUeVFJP+MWkXAXfrsX/AfeBCimQQNvjL16LzzZvSg7kdxdOvbVijGCCcjzQ
         3VCtxwitpxcaiA2uthqVgyFfevzk0JWtLHoU3jIaNyiCiYNyX9c3w/eaR87LKs1I1/WL
         Cs20EqcTZ/WSRQstIromtPCCXxrJMIrbnvYqD67ASPyZ3SWatGaDtGyroDKDPOt8KlIZ
         Ynv4jdvYIm4ArgT3lXugBLGQXppAD1ogEyPhsK6lJLOtir0QGpv+gyyPScjbmwrPq8Xo
         dX4teznr/GKez9mlwaIcG3WkvhGM4pLFlkA0b3bJEjwl8D8yJRjgJJEjO5j0u8tjHE6T
         tF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnrBejOhyT5C0jAW86TjsRhNvZo6bsHC7jAzqYVrGgM=;
        b=ALPd64hNqeY727MKEiabJga0Sf+jdIAzRU3U3MWtdXqWbQGaG+2Qkpz6uFytH4nSZA
         XYrTPd4bCnU9zki/35WgA8ar92fuiYIz3iBf1ZVx9s//OiELrDz1AFbyRFdViawiM6yv
         CQMvT8htfMCpSY6NftqiOYikoaXR7WTmNEj9qcN0WDips2yV2iIjFEsMlAy1VxtrOVQB
         499NHTJ7lcWnZDgO5HdbWZcMU7lbihOox8dPfLN5DdWuJ7zgBqH0DfFXBD/buAaWNwBR
         qoS7d39WLyivBetFrWA2DtAGj/f4rzZsM2tsM8cu6k+3iJlancX9kHKWtoLDZv34vN0X
         x/mw==
X-Gm-Message-State: AOAM530/kOv/gXcubQVRevZUeh2MO/Z7F0bRZhclqeG2Xsw/Jk5+mrV7
        HdoQqVgukqOPlSji/LH/N8o=
X-Google-Smtp-Source: ABdhPJwEqAUPpnXseZSO/W0+NticzuW+88isJmtl4dH9GKXbI6QPr/mR9ngU+esVbjNcyEf0OuZdFQ==
X-Received: by 2002:a05:651c:386:b0:246:c7e:bb1e with SMTP id e6-20020a05651c038600b002460c7ebb1emr6877807ljp.161.1647025310927;
        Fri, 11 Mar 2022 11:01:50 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id a12-20020a05651c010c00b002485f6a9a03sm1183519ljb.87.2022.03.11.11.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:01:50 -0800 (PST)
Date:   Fri, 11 Mar 2022 22:01:47 +0300
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
Message-ID: <20220311190147.pvjp6v7whjgyeuey@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <20220311174134.GA3966@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311174134.GA3966@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 11, 2022 at 11:11:34PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 10, 2022 at 07:31:23PM +0300, Serge Semin wrote:
> > On Wed, Mar 09, 2022 at 03:12:01PM -0600, Frank Li wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
> > > programs the source and destination addresses for read and write. Since the
> > > Root complex and Endpoint uses the opposite channels for read/write, fix the
> > > issue by finding out the read operation first and program the eDMA accordingly.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
> > > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > No change between v1 to v4
> > > 
> > >  drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
> > >  1 file changed, 31 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 66dc650577919..507f08db1aad3 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > >  	struct dw_edma_chunk *chunk;
> > >  	struct dw_edma_burst *burst;
> > >  	struct dw_edma_desc *desc;
> > > +	bool read = false;
> > >  	u32 cnt = 0;
> > >  	int i;
> > >  
> > > @@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > >  		chunk->ll_region.sz += burst->sz;
> > >  		desc->alloc_sz += burst->sz;
> > >  
> > > -		if (chan->dir == EDMA_DIR_WRITE) {
> > > +		/****************************************************************
> > > +		 *
> > 
> > > +		 *        Root Complex                           Endpoint
> > > +		 * +-----------------------+             +----------------------+
> > > +		 * |                       |    TX CH    |                      |
> > > +		 * |                       |             |                      |
> > > +		 * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
> > > +		 * |                       |             |                      |
> > > +		 * |                       |             |                      |
> > > +		 * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
> > > +		 * |                       |             |                      |
> > > +		 * |                       |    RX CH    |                      |
> > > +		 * +-----------------------+             +----------------------+
> > > +		 *
> > > +		 * If eDMA is controlled by the Root complex, TX channel
> > > +		 * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
> > > +		 * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
> > > +		 *
> > > +		 * If eDMA is controlled by the endpoint, RX channel
> > > +		 * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
> > > +		 * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
> > 
> > Either I have some wrong notion about this issue, or something wrong
> > with the explanation above and with this fix below.
> > 
> > From my understanding of the possible DW eDMA IP-core setups the
> > scatch above and the text below it are incorrect. Here is the way the
> > DW eDMA can be used:
> > 1) Embedded into the DW PCIe Host/EP controller. In this case
> > CPU/Application Memory is the memory of the CPU attached to the
> > host/EP controller, while the remote (link partner) memory is the PCIe
> > bus memory. In this case MEM_TO_DEV operation is supposed to be
> > performed by the Tx/Write channels, while the DEV_TO_MEM operation -
> > by the Rx/Read channels.
> > 
> 

> I'm not aware or even not sure about the use of eDMA in the PCIe host.
> If that's the case, how the endpoint can access it from remote perspective?
> Do you have a usecase or an example where used or even documented?

I am aware. I've got SoC with DW PCIe Host v4.60/v4.70 and eDMA
enabled for each of them. I also poses several manuals of the DW PCIe
Host and End-points of various versions. Both Host and End-points can
have eDMA enabled. But it's possible to have the eDMA accessed via the
PCIe wire only for the End-points and only if the IP-core is
accordingly synthesized. Other than that the eDMA is configurable from
the Local CPU only.

> 
> > Note it's applicable for both Host and End-point case, when Linux is
> > running on the CPU-side of the eDMA controller. So if it's DW PCIe
> > end-point, then MEM_TO_DEV means copying data from the local CPU
> > memory into the remote memory. In general the remote memory can be
> > either some PCIe device on the bus or the Root Complex' CPU memory,
> > each of which is some remote device anyway from the Local CPU
> > perspective.
> > 
> > 2) Embedded into the PCIe EP. This case is implemented in the
> > drivers/dma/dw-edma/dw-edma-pcie.c driver. AFAICS from the commits log
> > and from the driver code, that device is a Synopsys PCIe EndPoint IP
> > prototype kit. It is a normal PCIe peripheral device with eDMA
> > embedded, which CPU/Application interface is connected to some
> > embedded SRAM while remote (link partner) interface is directed
> > towards the PCIe bus. At the same time the device is setup and handled
> > by the code running on a CPU connected to the PCIe Host controller.  I
> > think that in order to preserve the normal DMA operations semantics we
> > still need to consider the MEM_TO_DEV/DEV_TO_MEM operations from the
> > host CPU perspective, since that's the side the DMA controller is
> > supposed to be setup from.  In this MEM_TO_DEV is supposed to be used
> > to copy data from the host CPU memory into the remote device memory.
> > It means to allocate Rx/Read channel on the eDMA controller, so one
> > would be read data from the Local CPU memory and copied it to the PCIe
> > device SRAM. The logic of the DEV_TO_MEM direction would be just
> > flipped. The eDMA PCIe device shall use Tx/Write channel to copy data
> > from it's SRAM into the Host CPU memory.
> > 
> > Please note as I understand the case 2) describes the Synopsys PCIe
> > EndPoint IP prototype kit, which is based on some FPGA code. It's just
> > a test setup with no real application, while the case 1) is a real setup
> > available on our SoC and I guess on yours.
> > 
> > So what I suggest in the framework of this patch is just to implement
> > the case 1) only. While the case 2) as it's an artificial one can be
> > manually handled by the DMA client drivers. BTW There aren't ones available
> > in the kernel anyway. The only exception is an old-time attempt to get
> > an eDMA IP test-driver mainlined into the kernel:
> > https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> > But it was long time ago. So it's unlikely to be accepted at all.
> > 
> > What do you think?
> > 
> 

> As per my understanding, the eDMA is solely used in the PCIe endpoint. And the
> access to it happens over PCIe bus or by the local CPU.

Not fully correct. Root Ports can also have eDMA embedded. In that
case the eDMA can be only accessible from the local CPU. At the same
time the DW PCIe End-point case is the IP-core synthesize parameters
specific. It's always possible to access the eDMA CSRs from local
CPU, but a particular End-point BAR can be pre-synthesize to map
either Port Logic, or eDMA or iATU CSRs. Thus a PCIe root port can
perform a full End-point configuration. Anyway the case if the eDMA
functionality being accessible over the PCIe wire doesn't really make
much sense with no info regarding the application logic hidden behind
the PCIe End-point interface since SAR/DAR LLP is supposed to be
initialized with an address from the local (application) memory space.

So AFAICS the main usecase of the controller is 1) - when eDMA is a
part of the Root Port/End-point and only local CPU is supposed to have
it accessed and configured.

I can resend this patch with my fix to the problem. What do you think?

-Sergey

> 
> The commit from Alan Mikhak is what I took as a reference since the patch was
> already merged:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/dma/dw-edma?id=bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > +		 *
> > > +		 ****************************************************************/
> > > +
> > 
> > > +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > +			read = true;
> > 
> > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > redundant.
> > 
> > > +
> > > +		/* Program the source and destination addresses for DMA read/write */
> > > +		if (read) {
> > >  			burst->sar = src_addr;
> > >  			if (xfer->type == EDMA_XFER_CYCLIC) {
> > >  				burst->dar = xfer->xfer.cyclic.paddr;
> > > -- 
> > > 2.24.0.rc1
> > > 
