Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7214F4D67FA
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiCKRsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 12:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350942AbiCKRsA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 12:48:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25BF139CC5
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 09:46:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e13so8274259plh.3
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=txGfPK06ozcY91uyttBaiPuORHLgwNRYQuKR8O5vZqE=;
        b=YwFQOLFf74Bbq1z2ayW1yLD7u5GnGUWhbFljTZwUA9WenOSAVxmIEdO/NtDz7XVaEz
         j4Emg8aTGbHLu5GSIEyqOa6HDmz86NYMoXsFU/5Q5cr1IcD1rPF2H7enm/Wy4zaip8si
         6sOu2I5f6vnkTZ0BnADBji0MUhnRVoNMY0P3GaAqZfE3uH3wz9vAOTV61D/aiXIK52xV
         12vaBS+Ig841hDJljZdzgbxLU1jifUbnoo20Ngvh7Klh//oBYP7NZg+2zR605N8Vgtlz
         TWqHzLXOSUP3DK/rKBMqHJgPn9d0VSdYHK5/hR/dhTHSwK92qgDkpBI6dAmcHaRMwfwO
         e/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txGfPK06ozcY91uyttBaiPuORHLgwNRYQuKR8O5vZqE=;
        b=dn+ahbtpyNxiCWbJPAZ2cyn4+5cnoC7jehl52g48tPE3Z8kG4dvThz1s2J6znwJ2G/
         6fpe4R39XHo3frFSgowudiVXxBcCMCzOqINAJ3TkUKsGaVz/ZH8EscXBC5C3qbtOi+xd
         dC4YQnz+VhKY7Zri+WqddzrICUUL9RlevyCFHqaB+KMTG4i4EpNhXOpUdBAU+uCgq+iQ
         3GCwP7ZJMQdRxE76bAVqGnoTHBQivNd+57Jo2ztpOu+iewVkh20From6yFzcmxSQlilm
         27IpSO0x0Zh0ZLX606h6t6HIE04uFq2ujhG2k+GxnMK9QK8VSCzV4h9ZLaXBX6kVwxEN
         KgDA==
X-Gm-Message-State: AOAM532iVjFerdb/19lP2IQ/UEYOqY1y5+RcYKVXuaUO3x6lzBxR/3ii
        gM7S0TJSvXl/AKLlfb5G8lHz
X-Google-Smtp-Source: ABdhPJw1L8WnpU/huK+WNgp/0GZmLWe92zGfKgB/T8pE8eGimA0J4D+hmaMptFqb+CpggVZuzCxCJg==
X-Received: by 2002:a17:902:c3cc:b0:14f:cf9d:55e4 with SMTP id j12-20020a170902c3cc00b0014fcf9d55e4mr11201216plj.55.1647020816142;
        Fri, 11 Mar 2022 09:46:56 -0800 (PST)
Received: from thinkpad ([117.202.191.144])
        by smtp.gmail.com with ESMTPSA id j11-20020a056a00234b00b004f7463022absm10898580pfj.208.2022.03.11.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:46:55 -0800 (PST)
Date:   Fri, 11 Mar 2022 23:16:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Zhi Li <lznuaa@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220311174649.GB3966@thinkpad>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <CAHrpEqSrdEegSAKw42T8qsN_BC24LS7r5a_+jKa3ZvGu5w9W1g@mail.gmail.com>
 <20220310193759.lkwqz5avlvznn5w3@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310193759.lkwqz5avlvznn5w3@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 10:37:59PM +0300, Serge Semin wrote:
> On Thu, Mar 10, 2022 at 10:50:14AM -0600, Zhi Li wrote:
> > On Thu, Mar 10, 2022 at 10:32 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > >
> > > On Wed, Mar 09, 2022 at 03:12:01PM -0600, Frank Li wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >
> > > > When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
> > > > programs the source and destination addresses for read and write. Since the
> > > > Root complex and Endpoint uses the opposite channels for read/write, fix the
> > > > issue by finding out the read operation first and program the eDMA accordingly.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
> > > > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > No change between v1 to v4
> > > >
> > > >  drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
> > > >  1 file changed, 31 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index 66dc650577919..507f08db1aad3 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > >       struct dw_edma_chunk *chunk;
> > > >       struct dw_edma_burst *burst;
> > > >       struct dw_edma_desc *desc;
> > > > +     bool read = false;
> > > >       u32 cnt = 0;
> > > >       int i;
> > > >
> > > > @@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > >               chunk->ll_region.sz += burst->sz;
> > > >               desc->alloc_sz += burst->sz;
> > > >
> > > > -             if (chan->dir == EDMA_DIR_WRITE) {
> > > > +             /****************************************************************
> > > > +              *
> > >
> > > > +              *        Root Complex                           Endpoint
> > > > +              * +-----------------------+             +----------------------+
> > > > +              * |                       |    TX CH    |                      |
> > > > +              * |                       |             |                      |
> > > > +              * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
> > > > +              * |                       |             |                      |
> > > > +              * |                       |             |                      |
> > > > +              * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
> > > > +              * |                       |             |                      |
> > > > +              * |                       |    RX CH    |                      |
> > > > +              * +-----------------------+             +----------------------+
> > > > +              *
> > > > +              * If eDMA is controlled by the Root complex, TX channel
> > > > +              * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
> > > > +              * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
> > > > +              *
> > > > +              * If eDMA is controlled by the endpoint, RX channel
> > > > +              * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
> > > > +              * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
> > >
> > > Either I have some wrong notion about this issue, or something wrong
> > > with the explanation above and with this fix below.
> > >
> > > From my understanding of the possible DW eDMA IP-core setups the
> > > scatch above and the text below it are incorrect. Here is the way the
> > > DW eDMA can be used:
> > > 1) Embedded into the DW PCIe Host/EP controller. In this case
> > > CPU/Application Memory is the memory of the CPU attached to the
> > > host/EP controller, while the remote (link partner) memory is the PCIe
> > > bus memory. In this case MEM_TO_DEV operation is supposed to be
> > > performed by the Tx/Write channels, while the DEV_TO_MEM operation -
> > > by the Rx/Read channels.
> > >
> > > Note it's applicable for both Host and End-point case, when Linux is
> > > running on the CPU-side of the eDMA controller. So if it's DW PCIe
> > > end-point, then MEM_TO_DEV means copying data from the local CPU
> > > memory into the remote memory. In general the remote memory can be
> > > either some PCIe device on the bus or the Root Complex' CPU memory,
> > > each of which is some remote device anyway from the Local CPU
> > > perspective.
> > >
> > > 2) Embedded into the PCIe EP. This case is implemented in the
> > > drivers/dma/dw-edma/dw-edma-pcie.c driver. AFAICS from the commits log
> > > and from the driver code, that device is a Synopsys PCIe EndPoint IP
> > > prototype kit. It is a normal PCIe peripheral device with eDMA
> > > embedded, which CPU/Application interface is connected to some
> > > embedded SRAM while remote (link partner) interface is directed
> > > towards the PCIe bus. At the same time the device is setup and handled
> > > by the code running on a CPU connected to the PCIe Host controller.  I
> > > think that in order to preserve the normal DMA operations semantics we
> > > still need to consider the MEM_TO_DEV/DEV_TO_MEM operations from the
> > > host CPU perspective, since that's the side the DMA controller is
> > > supposed to be setup from.  In this MEM_TO_DEV is supposed to be used
> > > to copy data from the host CPU memory into the remote device memory.
> > > It means to allocate Rx/Read channel on the eDMA controller, so one
> > > would be read data from the Local CPU memory and copied it to the PCIe
> > > device SRAM. The logic of the DEV_TO_MEM direction would be just
> > > flipped. The eDMA PCIe device shall use Tx/Write channel to copy data
> > > from it's SRAM into the Host CPU memory.
> > >
> > > Please note as I understand the case 2) describes the Synopsys PCIe
> > > EndPoint IP prototype kit, which is based on some FPGA code. It's just
> > > a test setup with no real application, while the case 1) is a real setup
> > > available on our SoC and I guess on yours.
> > 
> 
> > I think yes. But Remote EP also is a one kind of usage module. Just no one
> > writes an EP functional driver for it yet.  Even pci-epf-test was just
> > a test function.
> > I previously sent vNTB patches to implement a virtual network between
> > RC and EP,
> > you can look if you have interest.
> 
> AFAIU the remote EP case is the same as 1) anyway. The remote EP is
> handled by its own CPU, which sets up the DW PCIe EP controller
> together with eDMA synthesized into the CPU' SoC. Am I right? While
> the case 2) doesn't have any CPU attached on the PCIe EP. It's just an
> FPGA with PCIe interface and eDMA IP-core installed. In that case all
> the setups are performed by the PCIe Host CPU. That's the root problem
> that causes having all the DEV_TO_MEM/MEM_TO_DEV complications.
> 
> So to speak I would suggest for at least to have the scatch fixed in
> accordance with the logic explained in my message.
> 
> > 
> > >
> > > So what I suggest in the framework of this patch is just to implement
> > > the case 1) only. While the case 2) as it's an artificial one can be
> > > manually handled by the DMA client drivers. BTW There aren't ones available
> > > in the kernel anyway. The only exception is an old-time attempt to get
> > > an eDMA IP test-driver mainlined into the kernel:
> > > https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> > > But it was long time ago. So it's unlikely to be accepted at all.
> > >
> > > What do you think?
> > >
> > > -Sergey
> > >
> > > > +              *
> > > > +              ****************************************************************/
> > > > +
> > >
> > > > +             if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > +                 (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > +                     read = true;
> > >
> 
> > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > redundant.
> 
> Am I getting a response on this comment? In accordance with that
> conditional statement having dir == DMA_DEV_TO_MEM means performing
> read operation. If dir equals DMA_MEM_TO_DEV then a write operation
> will be performed. The code path doesn't depend on the chan->dir
> value.
> 

As per the eDMA test application [1] submitted a while ago, my logic is correct:

+	if (thread->direction == DMA_DEV_TO_MEM) {
+		/* DMA_DEV_TO_MEM - WRITE - DMA_FROM_DEVICE */
+		dev_dbg(dev, "%s: DMA_DEV_TO_MEM - WRITE - DMA_FROM_DEVICE\n",
+			dma_chan_name(chan));
+		err = dma_map_sg(dev, sgt->sgl, sgt->nents, DMA_FROM_DEVICE);
+		if (!err)
+			goto err_descs;
+
+		sgt->nents = err;
+		/* Endpoint memory */
+		sconf.src_addr = dt_region->paddr;
+		/* CPU memory */
+		sconf.dst_addr = descs[0].paddr;
+	} else {
+		/* DMA_MEM_TO_DEV - READ - DMA_TO_DEVICE */
+		dev_dbg(dev, "%s: DMA_MEM_TO_DEV - READ - DMA_TO_DEVICE\n",
+			dma_chan_name(chan));
+		err = dma_map_sg(dev, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+		if (!err)
+			goto err_descs;
+
+		sgt->nents = err;
+		/* CPU memory */
+		sconf.src_addr = descs[0].paddr;
+		/* Endpoint memory */
+		sconf.dst_addr = dt_region->paddr;
+	}

[1] https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/

Thanks,
Mani

> -Sergey
> 
> > >
> > > > +
> > > > +             /* Program the source and destination addresses for DMA read/write */
> > > > +             if (read) {
> > > >                       burst->sar = src_addr;
> > > >                       if (xfer->type == EDMA_XFER_CYCLIC) {
> > > >                               burst->dar = xfer->xfer.cyclic.paddr;
> > > > --
> > > > 2.24.0.rc1
> > > >
