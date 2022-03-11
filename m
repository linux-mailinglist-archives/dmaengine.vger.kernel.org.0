Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035524D68F0
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 20:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351079AbiCKTJV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 14:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351021AbiCKTJS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 14:09:18 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C39154D37;
        Fri, 11 Mar 2022 11:08:05 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 17so11185775lji.1;
        Fri, 11 Mar 2022 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0dg7aylWLHuFedgHs7EWbkTQ4kj6i2GIpXofAqAB1r8=;
        b=TrGJPfRvKVHyfjlv8XNLDWEUgSawS/g3f2wcgF/Jb02RerfjmX67ZaHPt1wEaKD6B1
         eOops+VVoVtEG3LybNIg+pz0bb94sQiiDsU7j/hlPGiv1yBxcgC1vNMrcj56SrpaaPd1
         xS7wzwLlPn04apB9ZRtr65vOj9OBKOzt6k/a3RKVev1vNm+dGU9BdWXnarskFwIxrjGp
         hwnQa8qXF3BFqNc/Sb1xNOFLTNFPGK6l60gM7U7g3MEiq3dLsYNpALBJTLhnybYTitgz
         RAi5IsuFpFKUEZQmJQhpS8525Qc+OBtTeFOYrm8IJqp+9GFwKGH0M1psoRIaDX8GQX41
         mWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dg7aylWLHuFedgHs7EWbkTQ4kj6i2GIpXofAqAB1r8=;
        b=ihsFsRFosbOLNTeN+tReI9Cd5pDN5lRvaPLgPNYQXCdP6fI+RhPnwK766V5vn8mbn7
         PzoZ80/hWDJ+Ypsawg6sgm/HRdwcnbgkLt3/J9aFM50kHh8j5KurxnHDUj+U9RDkWNgS
         q+a9bDyxkFizbTiWy5cF28+JZsHDbS/f8MXXtDzbe1ZiNXZtMUaFvVy5iqI927SBmgKF
         Wu5aw99aYKWA/kXdxJ965kc68D1sShZgJVFDzdQVzU2uhXpeXA/HqcZ2Nyj94vn5ZxsS
         6arRiYBm3bXCY75ZtabvEWteInOpwC8JlcDSiqSdsHFQJr3o76rs4seEIdgOzZmDvMiG
         iewA==
X-Gm-Message-State: AOAM532+TUAUHzEYnfuvWuSlNZrvt79gp2YUu9VD+HFv8fWNq2GN67+d
        JvA+daZG+pCGlTzit06kY9w=
X-Google-Smtp-Source: ABdhPJwkxlYRbjqxGYGYYHNptOwXcyD5Y/TzB+5Eb7vLM0TaiGi4QSUMhSnSB7rpiSBYMbtqf8b6Dw==
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id c5-20020a2ebf05000000b00247b233cfbamr6953109ljr.131.1647025683735;
        Fri, 11 Mar 2022 11:08:03 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2410b000000b004457116a575sm1763329lfi.273.2022.03.11.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:08:03 -0800 (PST)
Date:   Fri, 11 Mar 2022 22:08:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Zhi Li <lznuaa@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220311190801.va3mtgt2tabazg4k@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
 <CAHrpEqSrdEegSAKw42T8qsN_BC24LS7r5a_+jKa3ZvGu5w9W1g@mail.gmail.com>
 <20220310193759.lkwqz5avlvznn5w3@mobilestation>
 <CAHrpEqTNTiCVdyBpS06pj=TE_YoYF8k8y6BDPJWtwR9ydAwubQ@mail.gmail.com>
 <20220311123857.jgm745md4vjyaldu@mobilestation>
 <20220311175556.GC3966@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311175556.GC3966@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 11, 2022 at 11:25:56PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 11, 2022 at 03:38:57PM +0300, Serge Semin wrote:
> > @Manivannan could you join the discussion?
> > 
> > On Thu, Mar 10, 2022 at 02:16:17PM -0600, Zhi Li wrote:
> > > On Thu, Mar 10, 2022 at 1:38 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 10, 2022 at 10:50:14AM -0600, Zhi Li wrote:
> > > > > On Thu, Mar 10, 2022 at 10:32 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 09, 2022 at 03:12:01PM -0600, Frank Li wrote:
> > > > > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > >
> > > > > > > When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
> > > > > > > programs the source and destination addresses for read and write. Since the
> > > > > > > Root complex and Endpoint uses the opposite channels for read/write, fix the
> > > > > > > issue by finding out the read operation first and program the eDMA accordingly.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
> > > > > > > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > > No change between v1 to v4
> > > > > > >
> > > > > > >  drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
> > > > > > >  1 file changed, 31 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > index 66dc650577919..507f08db1aad3 100644
> > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > @@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > > > > >       struct dw_edma_chunk *chunk;
> > > > > > >       struct dw_edma_burst *burst;
> > > > > > >       struct dw_edma_desc *desc;
> > > > > > > +     bool read = false;
> > > > > > >       u32 cnt = 0;
> > > > > > >       int i;
> > > > > > >
> > > > > > > @@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > > > > >               chunk->ll_region.sz += burst->sz;
> > > > > > >               desc->alloc_sz += burst->sz;
> > > > > > >
> > > > > > > -             if (chan->dir == EDMA_DIR_WRITE) {
> > > > > > > +             /****************************************************************
> > > > > > > +              *
> > > > > >
> > > > > > > +              *        Root Complex                           Endpoint
> > > > > > > +              * +-----------------------+             +----------------------+
> > > > > > > +              * |                       |    TX CH    |                      |
> > > > > > > +              * |                       |             |                      |
> > > > > > > +              * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
> > > > > > > +              * |                       |             |                      |
> > > > > > > +              * |                       |             |                      |
> > > > > > > +              * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
> > > > > > > +              * |                       |             |                      |
> > > > > > > +              * |                       |    RX CH    |                      |
> > > > > > > +              * +-----------------------+             +----------------------+
> > > > > > > +              *
> > > > > > > +              * If eDMA is controlled by the Root complex, TX channel
> > > > > > > +              * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
> > > > > > > +              * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
> > > > > > > +              *
> > > > > > > +              * If eDMA is controlled by the endpoint, RX channel
> > > > > > > +              * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
> > > > > > > +              * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
> > > > > >
> > > > > > Either I have some wrong notion about this issue, or something wrong
> > > > > > with the explanation above and with this fix below.
> > > > > >
> > > > > > From my understanding of the possible DW eDMA IP-core setups the
> > > > > > scatch above and the text below it are incorrect. Here is the way the
> > > > > > DW eDMA can be used:
> > > > > > 1) Embedded into the DW PCIe Host/EP controller. In this case
> > > > > > CPU/Application Memory is the memory of the CPU attached to the
> > > > > > host/EP controller, while the remote (link partner) memory is the PCIe
> > > > > > bus memory. In this case MEM_TO_DEV operation is supposed to be
> > > > > > performed by the Tx/Write channels, while the DEV_TO_MEM operation -
> > > > > > by the Rx/Read channels.
> > > > > >
> > > > > > Note it's applicable for both Host and End-point case, when Linux is
> > > > > > running on the CPU-side of the eDMA controller. So if it's DW PCIe
> > > > > > end-point, then MEM_TO_DEV means copying data from the local CPU
> > > > > > memory into the remote memory. In general the remote memory can be
> > > > > > either some PCIe device on the bus or the Root Complex' CPU memory,
> > > > > > each of which is some remote device anyway from the Local CPU
> > > > > > perspective.
> > > > > >
> > > > > > 2) Embedded into the PCIe EP. This case is implemented in the
> > > > > > drivers/dma/dw-edma/dw-edma-pcie.c driver. AFAICS from the commits log
> > > > > > and from the driver code, that device is a Synopsys PCIe EndPoint IP
> > > > > > prototype kit. It is a normal PCIe peripheral device with eDMA
> > > > > > embedded, which CPU/Application interface is connected to some
> > > > > > embedded SRAM while remote (link partner) interface is directed
> > > > > > towards the PCIe bus. At the same time the device is setup and handled
> > > > > > by the code running on a CPU connected to the PCIe Host controller.  I
> > > > > > think that in order to preserve the normal DMA operations semantics we
> > > > > > still need to consider the MEM_TO_DEV/DEV_TO_MEM operations from the
> > > > > > host CPU perspective, since that's the side the DMA controller is
> > > > > > supposed to be setup from.  In this MEM_TO_DEV is supposed to be used
> > > > > > to copy data from the host CPU memory into the remote device memory.
> > > > > > It means to allocate Rx/Read channel on the eDMA controller, so one
> > > > > > would be read data from the Local CPU memory and copied it to the PCIe
> > > > > > device SRAM. The logic of the DEV_TO_MEM direction would be just
> > > > > > flipped. The eDMA PCIe device shall use Tx/Write channel to copy data
> > > > > > from it's SRAM into the Host CPU memory.
> > > > > >
> > > > > > Please note as I understand the case 2) describes the Synopsys PCIe
> > > > > > EndPoint IP prototype kit, which is based on some FPGA code. It's just
> > > > > > a test setup with no real application, while the case 1) is a real setup
> > > > > > available on our SoC and I guess on yours.
> > > > >
> > > >
> > > > > I think yes. But Remote EP also is a one kind of usage module. Just no one
> > > > > writes an EP functional driver for it yet.  Even pci-epf-test was just
> > > > > a test function.
> > > > > I previously sent vNTB patches to implement a virtual network between
> > > > > RC and EP,
> > > > > you can look if you have interest.
> > > >
> > > > AFAIU the remote EP case is the same as 1) anyway. The remote EP is
> > > > handled by its own CPU, which sets up the DW PCIe EP controller
> > > > together with eDMA synthesized into the CPU' SoC. Am I right? While
> > > > the case 2) doesn't have any CPU attached on the PCIe EP. It's just an
> > > > FPGA with PCIe interface and eDMA IP-core installed. In that case all
> > > > the setups are performed by the PCIe Host CPU. That's the root problem
> > > > that causes having all the DEV_TO_MEM/MEM_TO_DEV complications.
> > > >
> > > > So to speak I would suggest for at least to have the scatch fixed in
> > > > accordance with the logic explained in my message.
> > > >
> > > > >
> > > > > >
> > > > > > So what I suggest in the framework of this patch is just to implement
> > > > > > the case 1) only. While the case 2) as it's an artificial one can be
> > > > > > manually handled by the DMA client drivers. BTW There aren't ones available
> > > > > > in the kernel anyway. The only exception is an old-time attempt to get
> > > > > > an eDMA IP test-driver mainlined into the kernel:
> > > > > > https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> > > > > > But it was long time ago. So it's unlikely to be accepted at all.
> > > > > >
> > > > > > What do you think?
> > > > > >
> > > > > > -Sergey
> > > > > >
> > > > > > > +              *
> > > > > > > +              ****************************************************************/
> > > > > > > +
> > > > > >
> > > > > > > +             if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> > > > > > > +                 (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> > > > > > > +                     read = true;
> > > > > >
> > > >
> > > > > > Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
> > > > > > and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
> > > > > > redundant.
> > > >
> > > > Am I getting a response on this comment? In accordance with that
> > > > conditional statement having dir == DMA_DEV_TO_MEM means performing
> > > > read operation. If dir equals DMA_MEM_TO_DEV then a write operation
> > > > will be performed. The code path doesn't depend on the chan->dir
> > > > value.
> > > 
> > 
> > > Only dir is enough.
> > 
> > Right, in this case the fix is much simpler than suggested here. There
> > is no need in additional local variable and complex conditional
> > statement. It's supposed to be like this:
> > 
> > -             if (chan->dir == edma_dir_write) {
> > +             if (dir == DMA_DEV_TO_MEM) {
> > 
> > See my next comment for a detailed explanation.
> > 
> > > Remote Read,  DMA_DEV_TO_MEM, it is a write channel.
> > > SAR is the continual address at EP Side, DAR is a scatter list. RC side
> > > 
> > > Local Read,  DMA_DEV_TO_MEM, it is a reading channel.
> > > SAR is the continual address at RC side,  DAR is a scatter list at EP side
> > 
> > Right, it's a caller responsibility to use a right channel for the
> > operation (by flipping the channel the caller will invert the whole
> > logic). But As I see it what you explain and my notion don't match to what
> > is depicted on the scatch and written in the text below it. Don't you see?
> > 
> > -              *        Root Complex                           Endpoint
> > +              * Linux Root Port/End-point                  PCIe End-point
> >                * +-----------------------+             +----------------------+
> > -              * |                       |    TX CH    |                      |
> > -              * |                       |             |                      |
> > -              * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
> > +              * |                       |             |                      |
> > +              * |                       |             |                      |
> > +              * |    DEV_TO_MEM   Rx Ch <-------------+ Tx Ch  DEV_TO_MEM    |
> >                * |                       |             |                      |
> >                * |                       |             |                      |
> > -              * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
> > -              * |                       |             |                      |
> > -              * |                       |    RX CH    |                      |
> > +              * |    MEM_TO_DEV   Tx Ch +-------------> Rx Ch  MEM_TO_DEV    |
> > +              * |                       |             |                      |
> > +              * |                       |             |                      |
> >                * +-----------------------+             +----------------------+
> >                *
> > -              * If eDMA is controlled by the Root complex, TX channel
> > -              * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
> > -              * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
> > +              * If eDMA is controlled by the RP/EP, Rx channel
> > +              * (EDMA_DIR_READ) is used for device read (DEV_TO_MEM) and Tx
> > +              * channel (EDMA_DIR_WRITE) is used for device write (MEM_TO_DEV).
> > +              * (Straightforward case.)
> >                *
> > -              * If eDMA is controlled by the endpoint, RX channel
> > -              * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
> > -              * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).
> > +              * If eDMA is embedded into an independent PCIe EP, Tx channel
> > +              * (EDMA_DIR_WRITE) is used for device read (DEV_TO_MEM) and Rx
> > +              * channel (EDMA_DIR_READ) is used for device write (MEM_TO_DEV).
> > 
> > I think what was suggested above explains well the semantics you are
> > trying to implement here in the framework of this patch.
> > 
> > > 
> > > Actually,  both sides should support a scatter list. Like
> > > device_prep_dma_memcpy_sg
> > > but it is beyond this patch series.
> > 
> 

> As I said in other reply, my reasoning was entirely based on the eDMA test
> application. Since it came from Synopsys, I went with that logic of channel
> configuration.
> 
> But if someone from Synopsys confirms that your logic is correct, I'm fine with
> reworking my commit.

There is no need in waiting for the Synopsys response. I've got info
manuals of my own to say:
1) Your fix is correct, but the conditional statement has redundant
operations. It can be simplified as I suggested.
2) Your scatch and text are incorrect and they must be fixed so not to
be confusing.

-Sergey

> 
> Thanks,
> Mani
> 
> > Right, it's beyond your series too, because that feature requires
> > additional modifications. I am not asking about that.
> > 
> > -Sergey
> > 
> > > 
> > > >
> > > > -Sergey
> > > >
> > > > > >
> > > > > > > +
> > > > > > > +             /* Program the source and destination addresses for DMA read/write */
> > > > > > > +             if (read) {
> > > > > > >                       burst->sar = src_addr;
> > > > > > >                       if (xfer->type == EDMA_XFER_CYCLIC) {
> > > > > > >                               burst->dar = xfer->xfer.cyclic.paddr;
> > > > > > > --
> > > > > > > 2.24.0.rc1
> > > > > > >
