Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF35F4D52F8
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 21:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiCJURd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 15:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCJURc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 15:17:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19C15C1BA;
        Thu, 10 Mar 2022 12:16:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b15so4357980edn.4;
        Thu, 10 Mar 2022 12:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMdLl2uTJ82nafZuj9bjgPGtckIng2io1n7y+a70dfc=;
        b=ilc737UmY4lMLfG/mKC4pIKR7h0u6rFNshBEq5NRgEhgANbS4vkeQktyfAxeJLViVE
         D9DsVxsqykA3fAgqL7Yfql2Q4GFWykE6+ZQ/xcUqb/ANmgu3plTlVrwjOMenjti0InZD
         DJFJjJYScL9JpGwxkquFSBWZ1vQ978d8Wplnv6W7MK1iICggKIR/zXBnEFG/jmWAQ88o
         NlPHCjQJrPZzGVKn51Mz4Uy5o1naKGODDtIJma/B2DHg2DPTTq8TFOyGIC+zyvpw3XtE
         QGBfREzh4TKaKZ90KiMFAOt6ZoERip8OHi2kZBAcXI/fDvnZ52om+oMXkpOfiaHJLFgW
         19kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMdLl2uTJ82nafZuj9bjgPGtckIng2io1n7y+a70dfc=;
        b=LAvXhVZnN83PHPNNNBJh2bY+FMkJ8WfPq0Eofs0HUSXwm6hfnGzkE24ldeqgxOC+fp
         tq0DplYDtirylJcRH4teC6Bkk/GodQDG6B8rbXiEIyIxPaD6N5hd1GYadFed3YL/kab5
         +eUVKybXnoHeGOaTW4Dk5PXkqLTiwTpDNVunb2Ev4TMMtskCKk1dRZCClGBWNuzsJdSx
         yTdvI4D6+4fu/FPEJfrukKwkC5igZg4XVfK9P5gR7evMriP3k/fivhNo+rEifxLVaOh8
         XMkV62kwlYJKTqfw4joRTrNXrSBzqkncUe+bIiwek8xe1hBkHigSkrPjfOG6o2j07F07
         y+wg==
X-Gm-Message-State: AOAM532qH3/Z9zghErd1Ml5un9C9l6RKuTFZGG+EZiYe2F5teSSwZGUk
        5lEOCaNdxHB/3UwVkzqu5kiBgkfCeLwZIECGDbE=
X-Google-Smtp-Source: ABdhPJzZNahNOh7EchycSqfFqcMkEWTbMl6M9jpD8BGNnazwHDbd7e+H0nD1j0fDV7NAaj3qj/UVeVPxWTfdKSlKPVA=
X-Received: by 2002:a05:6402:4315:b0:416:9c6f:f724 with SMTP id
 m21-20020a056402431500b004169c6ff724mr5998975edc.400.1646943389228; Thu, 10
 Mar 2022 12:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20220309211204.26050-1-Frank.Li@nxp.com> <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation> <CAHrpEqSrdEegSAKw42T8qsN_BC24LS7r5a_+jKa3ZvGu5w9W1g@mail.gmail.com>
 <20220310193759.lkwqz5avlvznn5w3@mobilestation>
In-Reply-To: <20220310193759.lkwqz5avlvznn5w3@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 14:16:17 -0600
Message-ID: <CAHrpEqTNTiCVdyBpS06pj=TE_YoYF8k8y6BDPJWtwR9ydAwubQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

On Thu, Mar 10, 2022 at 1:38 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
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

Only dir is enough.
Remote Read,  DMA_DEV_TO_MEM, it is a write channel.
SAR is the continual address at EP Side, DAR is a scatter list. RC side

Local Read,  DMA_DEV_TO_MEM, it is a reading channel.
SAR is the continual address at RC side,  DAR is a scatter list at EP side

Actually,  both sides should support a scatter list. Like
device_prep_dma_memcpy_sg
but it is beyond this patch series.

>
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
