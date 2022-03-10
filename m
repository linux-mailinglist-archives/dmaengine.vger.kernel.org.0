Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA64D5109
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiCJRzr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiCJRzq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:55:46 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEECEAC8A;
        Thu, 10 Mar 2022 09:54:44 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gb39so13761265ejc.1;
        Thu, 10 Mar 2022 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/+7f43jzNRtohcBff0vjdWTynRZSOEhV46lWGpyiRQ=;
        b=j58OvalBzU2IMagBwOAgvkVrcHm/+Mz2e8BUztCXFvmvKTO2+DJZD6+JWhXd36XMQD
         M+wnyMRKUXXPYeJ58YXDuoF/297YXa0rKDq67dynABZfT8n9OsVGT4Qou706mSbJfzBZ
         kX53xAuTT4AmebNNGkInbatJ4IIl8ubD7aBzSMFtom56/UA24ghQAGtTvxlwKSGv4VBB
         Ds8o9XUE0cq4jS1iK64Ax/PbGNY7uzNQ+OxtlyKvrnX+JTsTcRLEDXtgjNnhlnh9VHla
         rVnGnLlulFSoLkaRZ8EoZ268omLOPlHPZKfEm4X6yIMXXIdOLzBhNNSANH16dKL/qxGc
         06bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/+7f43jzNRtohcBff0vjdWTynRZSOEhV46lWGpyiRQ=;
        b=itebzgDzjsUqcuaUohX959YmBy3R+x3LZxElQuM6r+j3w23tx0JxG2Jeh9D8BQCUgw
         Chd2Upltc8C015FMrTevZXM1oXPrDo7M8qtnatkKMRjnq7GgX33txCSzIcP7iHFbrThr
         DzMdWly8stUZnMPYddfFYDkDWk+OZyr3s+/o9pkV25zaXJ/s+Qvum0W9Fq0o6bL3n7IJ
         03q4lHRi15VWqGbFzRGbCLHweWXLLu9JaHUSTVrUEN3dRkzoSGHdFeZ9AKONjEP/wXqr
         dreMZmFW2u97qVOec+VCqyN+auHK0UvkJrzRECDNEX59BYI4umzWd2ZwyPnnZ45gEePR
         g8BA==
X-Gm-Message-State: AOAM530V/qd6erfaVbgitv4ZhOG7IsgiKKZcnMySv0ev8NYlum/wRiTD
        9WNZx/tn/txk2Ld1LMF2p+nFlvTvck9DSa1V3UQ=
X-Google-Smtp-Source: ABdhPJwNMARDh0nBHvjUH/MmsAWgNv/dDgfGet7KYOBEE0+Kt4HbuZkTDhse/Ij4z9AGtWwtHyXWMVWUZBqIcpZ4Ew4=
X-Received: by 2002:a17:907:60cc:b0:6da:9616:ecec with SMTP id
 hv12-20020a17090760cc00b006da9616ececmr5662902ejc.298.1646934882936; Thu, 10
 Mar 2022 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20220309211204.26050-1-Frank.Li@nxp.com> <20220309211204.26050-8-Frank.Li@nxp.com>
 <20220310174643.gxtmg373dgqqocpk@mobilestation>
In-Reply-To: <20220310174643.gxtmg373dgqqocpk@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 11:54:30 -0600
Message-ID: <CAHrpEqSZjZvA4RE8hw_kJgw535SHNOWziZfQU_HsQT2DJArpcA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] dmaengine: dw-edma: add flags at struct dw_edma_chip
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

On Thu, Mar 10, 2022 at 11:47 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Wed, Mar 09, 2022 at 03:12:03PM -0600, Frank Li wrote:
> > Allow PCI EP probe DMA locally and prevent use of remote MSI
> > to remote PCI host.
> >
> > Add option to force 32bit DBI register access even on
> > 64-bit systems. i.MX8 hardware only allowed 32bit register
> > access.
>
> Could you please split this patch up into two? These flags are
> unrelated thus adding them is two unrelated changes. That can be
> implicitly inferred from your commit log and the patch title.

I don't think it needs to be separated.  It also show why need 32bit mask to
control features and reserved futured extension capability .

The two flags were descriptions for EDMA chip features.

>
> -Sergey
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3 to v4
> >  - None
> > Change from v2 to v3
> >  - rework commit message
> >  - Change to DW_EDMA_CHIP_32BIT_DBI
> >  - using DW_EDMA_CHIP_LOCAL control msi
> >  - Apply Bjorn's comments,
> >         if (!j) {
> >                control |= DW_EDMA_V0_LIE;
> >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> >                                control |= DW_EDMA_V0_RIE;
> >         }
> >
> >         if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
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
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
> >  include/linux/dma/edma.h              |  9 +++++++++
> >  2 files changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 35f2adac93e46..00a00d68d44e7 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  {
> >       struct dw_edma_burst *child;
> > +     struct dw_edma_chan *chan = chunk->chan;
> >       struct dw_edma_v0_lli __iomem *lli;
> >       struct dw_edma_v0_llp __iomem *llp;
> >       u32 control = 0, i = 0;
> > @@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >       j = chunk->bursts_alloc;
> >       list_for_each_entry(child, &chunk->burst->list, list) {
> >               j--;
> > -             if (!j)
> > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > -
> > +             if (!j) {
> > +                     control |= DW_EDMA_V0_LIE;
> > +                     if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +                             control |= DW_EDMA_V0_RIE;
> > +             }
> >               /* Channel control */
> >               SET_LL_32(&lli[i].control, control);
> >               /* Transfer size */
> > @@ -414,15 +417,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >               SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >               /* Linked list */
> > -             #ifdef CONFIG_64BIT
> > -                     SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > -                               chunk->ll_region.paddr);
> > -             #else /* CONFIG_64BIT */
> > +             if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> > +                 !IS_ENABLED(CONFIG_64BIT)) {
> >                       SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> >                                 lower_32_bits(chunk->ll_region.paddr));
> >                       SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> >                                 upper_32_bits(chunk->ll_region.paddr));
> > -             #endif /* CONFIG_64BIT */
> > +             } else {
> > +                     SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > +                               chunk->ll_region.paddr);
> > +             }
> >       }
> >       /* Doorbell */
> >       SET_RW_32(dw, chan->dir, doorbell,
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index c2039246fc08c..eea11b1d9e688 100644
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
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:              struct device of the eDMA controller
> > @@ -40,6 +46,8 @@ enum dw_edma_map_format {
> >   * @nr_irqs:          total dma irq number
> >   * @ops                       DMA channel to IRQ number mapping
> >   * @reg_base          DMA register base address
> > + * @flags               - DW_EDMA_CHIP_LOCAL
> > + *                      - DW_EDMA_CHIP_32BIT_DBI
> >   * @ll_wr_cnt                 DMA write link list number
> >   * @ll_rd_cnt                 DMA read link list number
> >   * @rg_region                 DMA register region
> > @@ -53,6 +61,7 @@ struct dw_edma_chip {
> >       int                     id;
> >       int                     nr_irqs;
> >       const struct dw_edma_core_ops   *ops;
> > +     u32                     flags;
> >
> >       void __iomem            *reg_base;
> >
> > --
> > 2.24.0.rc1
> >
