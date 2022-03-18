Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBC4DE142
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 19:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbiCRSmR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiCRSmQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 14:42:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4112A4FB2;
        Fri, 18 Mar 2022 11:40:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u23so9092111ejt.1;
        Fri, 18 Mar 2022 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEByjJ2zOrfGkMDirRm3IgOtqWS9Kjf885pDwb6YsJQ=;
        b=ep+9MjGE//Dcp+3jJNBfcZO0YhAjIwX5jJbL+hFNglZapn/8oDMjeyBzQRdHi+T/j+
         EmKapHNOe0z8ImOb6cJwU+6T6mgDzCS8WoDnwD6S5a8XR/MT2bj+HfHW/8jE5d/5wGug
         xTJFwiMwxozBNyJ/lyrWjatVvXuFdffHhH3UdeG3+HrUcxbXggMeAx/5vR0JhU161L7N
         uvPqTl11BEZKhiB+HxtzxaFSzOoOh9p7bl233fAzFk2wu4xNre6ObmUk8jaa+nNVXQDf
         l46B4l9L9rT0Qu/plV03AsMpUaadDRNJPkHuZBU16sNTylp0mtgsBnTPDhdcbmlW0R3B
         bFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEByjJ2zOrfGkMDirRm3IgOtqWS9Kjf885pDwb6YsJQ=;
        b=wLqJIfoiJe8elJz4Y+FHGxo9F2LaBFrPX4iiXGLOoJN/ik4FCA/F6Hy6lE/sXxPGl7
         ErggysDGRw+NDosPJx82UKL7EeuZvgHz/tDjX3chWGYx7Isn/nKhLJl7UPKCDdpN7AIA
         GBFdNEYa27jj0FAx7eiFv8pCsFfOz4O+tQ3i9ycnB6rC13ZF4Ebf+9x53ct0iKUpLFx6
         AxnsTolOzAXJatzRRm5g3g4qFu4qVMfyovStQH9HnZKso7bs450t1f8m1uDJP7aqLSVr
         9nO1YMdjvCoEKH2jSOweHNEYHNM8tyq8flDH1fdNMFcF9JmDUMwqgGk1tMLm77ITLaJe
         YUZQ==
X-Gm-Message-State: AOAM531AsPgvxEqhdZxfoTaLpubwHA3xJ1GIxxLbsKseJYWIB5elhx4a
        0vqLpWaIFiMM6r/Ng3rR66KtNCwptFxi+9nVejy8TC2+
X-Google-Smtp-Source: ABdhPJxwL6o0c8L7rIM2CBxOd+KLNfq4S9+iWvP+DXB7211S/zcbmAdRlCc1WlKmxeM6Juy7zhgGm45SxSG6Dpc6Qc4=
X-Received: by 2002:a17:906:1e42:b0:6d6:df12:7f8d with SMTP id
 i2-20020a1709061e4200b006d6df127f8dmr10523536ejj.15.1647628855671; Fri, 18
 Mar 2022 11:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220307224750.18055-1-Frank.Li@nxp.com> <20220307224750.18055-5-Frank.Li@nxp.com>
 <20220310074400.GC4869@thinkpad> <CAHrpEqQ7zN7xNZXH3aOnL3N13G2GzgezDAJRBusWmq3N3TR_aQ@mail.gmail.com>
In-Reply-To: <CAHrpEqQ7zN7xNZXH3aOnL3N13G2GzgezDAJRBusWmq3N3TR_aQ@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Fri, 18 Mar 2022 13:40:44 -0500
Message-ID: <CAHrpEqS-WoK0TgX3hybVUfTPNwJrTT8SP=cr3-p5TtTvMv-23g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] dmaengine: dw-edma: add flags at struct dw_edma_chip
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
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

On Thu, Mar 10, 2022 at 11:00 AM Zhi Li <lznuaa@gmail.com> wrote:
>
> On Thu, Mar 10, 2022 at 1:44 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Mar 07, 2022 at 04:47:49PM -0600, Frank Li wrote:
> > > Allow PCI EP probe DMA locally and prevent use of remote MSI
> > > to remote PCI host.
> > >
> > > Add option to force 32bit DBI register access even on
> > > 64-bit systems. i.MX8 hardware only allowed 32bit register
> > > access.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >
> > > Resend added dmaengine@vger.kernel.org
> > >
> > > Change from v2 to v3
> > >  - rework commit message
> > >  - Change to DW_EDMA_CHIP_32BIT_DBI
> > >  - using DW_EDMA_CHIP_LOCAL control msi
> > >  - Apply Bjorn's comments,
> > >       if (!j) {
> > >                control |= DW_EDMA_V0_LIE;
> > >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > >                                control |= DW_EDMA_V0_RIE;
> > >         }
> > >
> > >       if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
> > >               !IS_ENABLED(CONFIG_64BIT)) {
> > >           SET_CH_32(...);
> > >           SET_CH_32(...);
> > >        } else {
> > >           SET_CH_64(...);
> > >        }
> > >
> > >
> > > Change from v1 to v2
> > > - none
> > >
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
> > >  include/linux/dma/edma.h              |  9 +++++++++
> > >  2 files changed, 21 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 6e2f83e31a03a..081cd7997348d 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -307,6 +307,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
> > >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >  {
> > >       struct dw_edma_burst *child;
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > >       struct dw_edma_v0_lli __iomem *lli;
> > >       struct dw_edma_v0_llp __iomem *llp;
> > >       u32 control = 0, i = 0;
> > > @@ -320,9 +321,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >       j = chunk->bursts_alloc;
> > >       list_for_each_entry(child, &chunk->burst->list, list) {
> > >               j--;
> > > -             if (!j)
> > > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > > -
> > > +             if (!j) {
> > > +                     control |= DW_EDMA_V0_LIE;
> > > +                     if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +                             control |= DW_EDMA_V0_RIE;
> > > +             }
> > >               /* Channel control */
> > >               SET_LL_32(&lli[i].control, control);
> > >               /* Transfer size */
> > > @@ -420,15 +423,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >               SET_CH_32(chip, chan->dir, chan->id, ch_control1,
> > >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > >               /* Linked list */
> > > -             #ifdef CONFIG_64BIT
> > > -                     SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > > -                               chunk->ll_region.paddr);
> > > -             #else /* CONFIG_64BIT */
> > > +             if ((chan->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> > > +                 !IS_ENABLED(CONFIG_64BIT)) {
> > >                       SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
> > >                                 lower_32_bits(chunk->ll_region.paddr));
> > >                       SET_CH_32(chip, chan->dir, chan->id, llp.msb,
> > >                                 upper_32_bits(chunk->ll_region.paddr));
> > > -             #endif /* CONFIG_64BIT */
> > > +             } else {
> > > +                     SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > > +                               chunk->ll_region.paddr);
> > > +             }
> > >       }
> > >       /* Doorbell */
> > >       SET_RW_32(chip, chan->dir, doorbell,
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index fcfbc0f47f83d..4321f6378ef66 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -33,6 +33,12 @@ enum dw_edma_map_format {
> > >       EDMA_MF_HDMA_COMPAT = 0x5
> > >  };
> > >
> > > +/* Probe EDMA engine locally and prevent generate MSI to host side*/
> > > +#define DW_EDMA_CHIP_LOCAL   BIT(0)
> > > +
> > > +/* Only support 32bit DBI register access */
> > > +#define DW_EDMA_CHIP_32BIT_DBI       BIT(1)
> > > +
> >
> > How about using an enum for defining the flags? This would help us organize the
> > flags in a more coherent way and also will give the benefit of kdoc.
>
> Did you see other linux code use enum as bitmask?
> According to my understanding, enum just chooses values in a list.

Do you agree that using define because it will be used as bitmask?

best regards
Frank Li

>
> >
> > /**
> >  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
> >  * @DW_EDMA_CHIP_LOCAL:         eDMA is used locally by an endpoint
> >  * @DW_EDMA_CHIP_32BIT_DBI:     eDMA only supports 32bit DBI access
> >  */
> > enum dw_edma_chip_flags {
> >         DW_EDMA_CHIP_LOCAL = BIT(0),
> >         DW_EDMA_CHIP_32BIT_DBI = BIT(1),
> > };
> >
> > >  /**
> > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > >   * @dev:              struct device of the eDMA controller
> > > @@ -40,6 +46,8 @@ enum dw_edma_map_format {
> > >   * @nr_irqs:          total dma irq number
> > >   * reg64bit           if support 64bit write to register
> > >   * @ops                       DMA channel to IRQ number mapping
> > > + * @flags             - DW_EDMA_CHIP_LOCAL
> > > + *                    - DW_EDMA_CHIP_32BIT_DBI
> >
> > No need to mention the flags here if you use the enum I suggested above.
> >
> > >   * @wr_ch_cnt                 DMA write channel number
> > >   * @rd_ch_cnt                 DMA read channel number
> > >   * @rg_region                 DMA register region
> > > @@ -53,6 +61,7 @@ struct dw_edma_chip {
> > >       int                     id;
> > >       int                     nr_irqs;
> > >       const struct dw_edma_core_ops   *ops;
> > > +     u32                     flags;
> >
> >         enum dw_edma_chip_flags flags;
> >
> > Thanks,
> > Mani
> >
> > >
> > >       void __iomem            *reg_base;
> > >
> > > --
> > > 2.24.0.rc1
> > >
