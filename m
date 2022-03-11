Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D891B4D65B6
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 17:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiCKQFJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 11:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiCKQFG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 11:05:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C611CFA2E;
        Fri, 11 Mar 2022 08:04:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c25so9305407edj.13;
        Fri, 11 Mar 2022 08:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Svl+52JR5clqVInHreXu6mwgT1Ovw1ajDFhAv6UrGg=;
        b=W0JdBlPXAfBI18ED1PmTliXjFIx40+Lt5wJc9B6psEoaKjRekUN74c4XWTaN3hzyvX
         i+KY3ZpjntxjA166YkFNHmRYopN6LFLIdx9v9bysnE05XsmibkhwHrVza6lM8Fqr9ZfW
         dr75a73bSOGSoAEUZiGX2U4kvKmGG7wxXIzI7eGfyYLD3G9sc2tvHt+c8SMi0ma5aPBk
         r7hL5143yWvvj47GnqA44Re/6Y9yXb7uOATVSfJzSV8V7XUSDZAbwIBZ1H8wRREOuKpM
         IbY/ioZqPqWjcKtY4CIJVRE411CL3cJvSx6nUGZZf+TF+x1MOJxTL+d/aqrAzJB3Wr4h
         bo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Svl+52JR5clqVInHreXu6mwgT1Ovw1ajDFhAv6UrGg=;
        b=BqD5UXpNNjT9AC+GNkag/vVqUfHI/4pnc/LnO44w3KIIFAFIuUR6RFA/C7dEkq6mdW
         aCiDQLtWoljkVZM4ZfOAFo9dG003X5pk/U8e167iabDSFsXAecM1V8Vdplw5xIOLGrKm
         pkMQo6REYs4f0dCVQ/OdtIH45q0iUgJm7+5LhAr4bAyDTie3hc6psPyjtQaS3rz+WzBT
         18bh4NvurZaWn88W7AAbXQtPkDSUKfwbBC/9e2zxqEXecxVD/u8Bbk9/nGLgOeBDecCC
         ncOIRrhgJMrNFskztp2Nmc3FdC52X9jfOTheaBwOV9jPHmblUeY2/sYuxSy3AJF580h/
         hJDA==
X-Gm-Message-State: AOAM5322wWCycW4LM+EcUUozgLt5f3GbwzwY0+FXsOviQr+ZjXsnmyMI
        hES2DN76w/UjTc4J0vZ12RqKcBLL5aopF33DMOM=
X-Google-Smtp-Source: ABdhPJxATJ71zJ5TSr/wba/tF6gOvSIWv244PcKe37PWi41Qj45vTCx2LIspZwIquJHWqR3Vn/ZMYpW5qg7vZOSYzc0=
X-Received: by 2002:a50:e1ca:0:b0:413:b403:f8e6 with SMTP id
 m10-20020a50e1ca000000b00413b403f8e6mr9438113edl.204.1647014640744; Fri, 11
 Mar 2022 08:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20220309211204.26050-1-Frank.Li@nxp.com> <20220309211204.26050-6-Frank.Li@nxp.com>
 <20220310163123.h2zqdx5tkn2czmbm@mobilestation> <CAHrpEqSrdEegSAKw42T8qsN_BC24LS7r5a_+jKa3ZvGu5w9W1g@mail.gmail.com>
 <20220310193759.lkwqz5avlvznn5w3@mobilestation> <CAHrpEqTNTiCVdyBpS06pj=TE_YoYF8k8y6BDPJWtwR9ydAwubQ@mail.gmail.com>
 <20220311123857.jgm745md4vjyaldu@mobilestation> <CAHrpEqRtT1B+M40Pkwi_VN-b1zJjGBhzay6VJjL8B-pL6pn8Pg@mail.gmail.com>
In-Reply-To: <CAHrpEqRtT1B+M40Pkwi_VN-b1zJjGBhzay6VJjL8B-pL6pn8Pg@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Fri, 11 Mar 2022 10:03:48 -0600
Message-ID: <CAHrpEqThUzSRs=Uoe5cBxPtRk=35fYUGOHKv3RG5JBu7Wh4A4g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
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

On Fri, Mar 11, 2022 at 9:37 AM Zhi Li <lznuaa@gmail.com> wrote:
>
> On Fri, Mar 11, 2022 at 6:39 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
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
>
> > +             if (dir == DMA_DEV_TO_MEM)
> > See my next comment for a detailed explanation.
>
> Actually directly revert patch
>
> commit bd96f1b2f43a39310cc576bb4faf2ea24317a4c9
> Author: Alan Mikhak <alan.mikhak@sifive.com>
> Date:   Tue Apr 28 18:10:33 2020 -0700
>
> @Alan Mikhak, welcome to join the discussion.  We think the original code is
> correct  for both remote DMA and local DMA. Can you help join the discussion to
> descript what's your test case when you upstream?  Actually pci-epf-test.c have
> not enable local EP dma. How do you test your code?

Alan Mikhank's email address does not exist now!.
@Serge Semin  @Manivannan Sadhasivam , how do you think revert
bd96f1b2f43a39310cc576bb4faf2ea24317a4c9

>
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
