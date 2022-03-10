Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089644D4FDB
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbiCJRB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiCJRB5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:01:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134DB177743;
        Thu, 10 Mar 2022 09:00:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t1so7599529edc.3;
        Thu, 10 Mar 2022 09:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntrxpC30yBdc3XrQj/21zte72WI3TsYRUBADPRTh3pU=;
        b=mCBR8PysYYYABLD5iY/5XnKvyXOHkNOMNsQ6YFei1kb2obg7lDJJpA/2VK+RpKRowR
         4KRPiwkI+hxUC5UyzkoQtYfKuhTQM7u4db96mlB7V0N2ES3hnaC03FMDuLFKRMIALuHz
         AKYKugTUbA60SxJLY5Wy74MA1FQi5mHR2P1l6gmdkdPzN8IMiVd4loOuo9aDy54zVOS1
         vow81jNQ7ggmdNJkfg6ZIlHBlqA81VX+lg+Cr6gAlwSbzCXSYc6yDedIPeQjjoou1wMI
         H1uGDAGE2ioufIzpkLdoGhon/XnXv7iAfAyc4sAVfEJ293mWWNaXng2AHofUmEzS9DKx
         gzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntrxpC30yBdc3XrQj/21zte72WI3TsYRUBADPRTh3pU=;
        b=PVY/1j7bnzNkNCztMIRp/LOectivJqMRv8qvMde84sBIIlVeb/aqtTvQ/FAZ558mQE
         E4R5OtI6MGx3qskHdf+SdHI43YFl9Zr8HbSkVMAWNjyxz7DRmyN0/BWd514p4MToocK/
         lEgHA/c3doUpC3Oxe0NbxnECBsFTXujguR367yk1SwwaoIYY+F3cMikKuFLKurTpR+nx
         WfoMaHv88VC1dL0OcNAhdeJS3+nrglFtEP+WUbOyyJNLdmupmcFvKdV8dhIMFyTTMKHS
         QLdWcASgEAZUu+y3sIpkRhw1F9uZVNKsv2bzgMpqgV7GKR9HwpKS1v9lfScvbS4/qK8c
         oLCw==
X-Gm-Message-State: AOAM531ljvCXJWPBkWs4vILNDKnOuGLxquC0gPZqRT9r0SBIjA9CRjo9
        smfqskomw6I6cVS9C337XuCR9WhBj+j479p50Rg=
X-Google-Smtp-Source: ABdhPJx71WBsbptJ8epwPRbp6I8mTo9cpxomrx2TYiP/QnWCghC8rXQihQucIoRJbI4Du0U5zDyPyPJjHL0fP6z6enM=
X-Received: by 2002:a05:6402:2750:b0:416:29dd:1d17 with SMTP id
 z16-20020a056402275000b0041629dd1d17mr5250112edd.387.1646931654356; Thu, 10
 Mar 2022 09:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20220307224750.18055-1-Frank.Li@nxp.com> <20220307224750.18055-5-Frank.Li@nxp.com>
 <20220310074400.GC4869@thinkpad>
In-Reply-To: <20220310074400.GC4869@thinkpad>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 11:00:42 -0600
Message-ID: <CAHrpEqQ7zN7xNZXH3aOnL3N13G2GzgezDAJRBusWmq3N3TR_aQ@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 1:44 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Mar 07, 2022 at 04:47:49PM -0600, Frank Li wrote:
> > Allow PCI EP probe DMA locally and prevent use of remote MSI
> > to remote PCI host.
> >
> > Add option to force 32bit DBI register access even on
> > 64-bit systems. i.MX8 hardware only allowed 32bit register
> > access.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >
> > Resend added dmaengine@vger.kernel.org
> >
> > Change from v2 to v3
> >  - rework commit message
> >  - Change to DW_EDMA_CHIP_32BIT_DBI
> >  - using DW_EDMA_CHIP_LOCAL control msi
> >  - Apply Bjorn's comments,
> >       if (!j) {
> >                control |= DW_EDMA_V0_LIE;
> >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> >                                control |= DW_EDMA_V0_RIE;
> >         }
> >
> >       if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
> >               !IS_ENABLED(CONFIG_64BIT)) {
> >           SET_CH_32(...);
> >           SET_CH_32(...);
> >        } else {
> >           SET_CH_64(...);
> >        }
> >
> >
> > Change from v1 to v2
> > - none
> >
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
> >  include/linux/dma/edma.h              |  9 +++++++++
> >  2 files changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 6e2f83e31a03a..081cd7997348d 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -307,6 +307,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
> >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  {
> >       struct dw_edma_burst *child;
> > +     struct dw_edma_chan *chan = chunk->chan;
> >       struct dw_edma_v0_lli __iomem *lli;
> >       struct dw_edma_v0_llp __iomem *llp;
> >       u32 control = 0, i = 0;
> > @@ -320,9 +321,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >       j = chunk->bursts_alloc;
> >       list_for_each_entry(child, &chunk->burst->list, list) {
> >               j--;
> > -             if (!j)
> > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > -
> > +             if (!j) {
> > +                     control |= DW_EDMA_V0_LIE;
> > +                     if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +                             control |= DW_EDMA_V0_RIE;
> > +             }
> >               /* Channel control */
> >               SET_LL_32(&lli[i].control, control);
> >               /* Transfer size */
> > @@ -420,15 +423,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >               SET_CH_32(chip, chan->dir, chan->id, ch_control1,
> >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >               /* Linked list */
> > -             #ifdef CONFIG_64BIT
> > -                     SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > -                               chunk->ll_region.paddr);
> > -             #else /* CONFIG_64BIT */
> > +             if ((chan->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> > +                 !IS_ENABLED(CONFIG_64BIT)) {
> >                       SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
> >                                 lower_32_bits(chunk->ll_region.paddr));
> >                       SET_CH_32(chip, chan->dir, chan->id, llp.msb,
> >                                 upper_32_bits(chunk->ll_region.paddr));
> > -             #endif /* CONFIG_64BIT */
> > +             } else {
> > +                     SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > +                               chunk->ll_region.paddr);
> > +             }
> >       }
> >       /* Doorbell */
> >       SET_RW_32(chip, chan->dir, doorbell,
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index fcfbc0f47f83d..4321f6378ef66 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -33,6 +33,12 @@ enum dw_edma_map_format {
> >       EDMA_MF_HDMA_COMPAT = 0x5
> >  };
> >
> > +/* Probe EDMA engine locally and prevent generate MSI to host side*/
> > +#define DW_EDMA_CHIP_LOCAL   BIT(0)
> > +
> > +/* Only support 32bit DBI register access */
> > +#define DW_EDMA_CHIP_32BIT_DBI       BIT(1)
> > +
>
> How about using an enum for defining the flags? This would help us organize the
> flags in a more coherent way and also will give the benefit of kdoc.

Did you see other linux code use enum as bitmask?
According to my understanding, enum just chooses values in a list.

>
> /**
>  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
>  * @DW_EDMA_CHIP_LOCAL:         eDMA is used locally by an endpoint
>  * @DW_EDMA_CHIP_32BIT_DBI:     eDMA only supports 32bit DBI access
>  */
> enum dw_edma_chip_flags {
>         DW_EDMA_CHIP_LOCAL = BIT(0),
>         DW_EDMA_CHIP_32BIT_DBI = BIT(1),
> };
>
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:              struct device of the eDMA controller
> > @@ -40,6 +46,8 @@ enum dw_edma_map_format {
> >   * @nr_irqs:          total dma irq number
> >   * reg64bit           if support 64bit write to register
> >   * @ops                       DMA channel to IRQ number mapping
> > + * @flags             - DW_EDMA_CHIP_LOCAL
> > + *                    - DW_EDMA_CHIP_32BIT_DBI
>
> No need to mention the flags here if you use the enum I suggested above.
>
> >   * @wr_ch_cnt                 DMA write channel number
> >   * @rd_ch_cnt                 DMA read channel number
> >   * @rg_region                 DMA register region
> > @@ -53,6 +61,7 @@ struct dw_edma_chip {
> >       int                     id;
> >       int                     nr_irqs;
> >       const struct dw_edma_core_ops   *ops;
> > +     u32                     flags;
>
>         enum dw_edma_chip_flags flags;
>
> Thanks,
> Mani
>
> >
> >       void __iomem            *reg_base;
> >
> > --
> > 2.24.0.rc1
> >
