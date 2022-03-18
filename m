Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB04DE1C8
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 20:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiCRTaT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 15:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiCRTaT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 15:30:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5776112E16D
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 12:28:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so5234694pjb.5
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEO5vUwGExLIfBBdOPjasW2sNtPBbPBisQiyN29X/zc=;
        b=SQ698VQd1H6q64SIWQZqCpBmiCG2h1c5cjcguhL2ZTzcDFsU1an7257v+wzno7W5HU
         gPxVbk2AMTvx6gmnNybUkFDVfdABBxDc9GrSw93FyL+umzmTn6y5Ur+ij9JH2iPkY0He
         mONIvM5mwL7N+BQae4IXVPYTsKeUiV8KzWcU2aylLZNVZO2PGSH2NSCu+w6vyF0l2x99
         Dx5nrOLTJMUIR535AKWPcOOk11491ro/bo/taqWg7GQB1tc8zicbZxpFDxuDuaclueyT
         zBYV3iVlqDPDCbjR9z7xm0vIOviRw5HtTr9EcOFGniSntGfcIAmRPYXygjE43JOnZ2ER
         BQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEO5vUwGExLIfBBdOPjasW2sNtPBbPBisQiyN29X/zc=;
        b=xyAoVQWLvW1w465iRsqVFF3s09/OdTcTlP/HMZQ3Qk4z7T+pst/OWGlDr8WmZem+vP
         X844t34nGpqaqajS//dIUUZXgljCkzX22DlDoaYizfKkzweCxrOPxwL+frex3+bo2g3W
         1/wAMEup8Vd5Fzu/TAwH6hKvpz9R56qkPfNetzflGxRKPs/Zw0XxTTUX757eCOGIJObg
         yJhEL0cNv/kDANXKd/FdCJ17k2EYkLyCK0Npxzg0dVlsQeuJRwe87HtGZUTvNEYx1/Jd
         P8i2Dy4iHAUYL4Yek82i1/rzjK7Ec/e9K1w1uLuJLEO8GIQPbhj3umon+7Op0mNCj+Ai
         K6Lw==
X-Gm-Message-State: AOAM533o50mBA8nUHQjXpXCisomKKRRgZPT+F+flLn+2PTMFU8wpJS33
        pS8UoDm4rAIYtBj1pBmQjyz7
X-Google-Smtp-Source: ABdhPJzGwMPYXMLX1mzsN97m+IgQ0FJUAQKdKbhPkEzpY/Ip93G8bq3cBSDKo/+v7KA2ekcyG8W+GA==
X-Received: by 2002:a17:902:7fc1:b0:151:f80f:494a with SMTP id t1-20020a1709027fc100b00151f80f494amr1002121plb.81.1647631735684;
        Fri, 18 Mar 2022 12:28:55 -0700 (PDT)
Received: from thinkpad ([117.217.178.61])
        by smtp.gmail.com with ESMTPSA id g2-20020a056a000b8200b004fa23c8b522sm10501412pfj.156.2022.03.18.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:28:55 -0700 (PDT)
Date:   Sat, 19 Mar 2022 00:58:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 5/6] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220318192849.GC4922@thinkpad>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220307224750.18055-5-Frank.Li@nxp.com>
 <20220310074400.GC4869@thinkpad>
 <CAHrpEqQ7zN7xNZXH3aOnL3N13G2GzgezDAJRBusWmq3N3TR_aQ@mail.gmail.com>
 <CAHrpEqS-WoK0TgX3hybVUfTPNwJrTT8SP=cr3-p5TtTvMv-23g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqS-WoK0TgX3hybVUfTPNwJrTT8SP=cr3-p5TtTvMv-23g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 18, 2022 at 01:40:44PM -0500, Zhi Li wrote:
> On Thu, Mar 10, 2022 at 11:00 AM Zhi Li <lznuaa@gmail.com> wrote:
> >
> > On Thu, Mar 10, 2022 at 1:44 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Mar 07, 2022 at 04:47:49PM -0600, Frank Li wrote:
> > > > Allow PCI EP probe DMA locally and prevent use of remote MSI
> > > > to remote PCI host.
> > > >
> > > > Add option to force 32bit DBI register access even on
> > > > 64-bit systems. i.MX8 hardware only allowed 32bit register
> > > > access.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >
> > > > Resend added dmaengine@vger.kernel.org
> > > >
> > > > Change from v2 to v3
> > > >  - rework commit message
> > > >  - Change to DW_EDMA_CHIP_32BIT_DBI
> > > >  - using DW_EDMA_CHIP_LOCAL control msi
> > > >  - Apply Bjorn's comments,
> > > >       if (!j) {
> > > >                control |= DW_EDMA_V0_LIE;
> > > >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > >                                control |= DW_EDMA_V0_RIE;
> > > >         }
> > > >
> > > >       if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
> > > >               !IS_ENABLED(CONFIG_64BIT)) {
> > > >           SET_CH_32(...);
> > > >           SET_CH_32(...);
> > > >        } else {
> > > >           SET_CH_64(...);
> > > >        }
> > > >
> > > >
> > > > Change from v1 to v2
> > > > - none
> > > >
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
> > > >  include/linux/dma/edma.h              |  9 +++++++++
> > > >  2 files changed, 21 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > index 6e2f83e31a03a..081cd7997348d 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > @@ -307,6 +307,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
> > > >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > > >  {
> > > >       struct dw_edma_burst *child;
> > > > +     struct dw_edma_chan *chan = chunk->chan;
> > > >       struct dw_edma_v0_lli __iomem *lli;
> > > >       struct dw_edma_v0_llp __iomem *llp;
> > > >       u32 control = 0, i = 0;
> > > > @@ -320,9 +321,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > > >       j = chunk->bursts_alloc;
> > > >       list_for_each_entry(child, &chunk->burst->list, list) {
> > > >               j--;
> > > > -             if (!j)
> > > > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > > > -
> > > > +             if (!j) {
> > > > +                     control |= DW_EDMA_V0_LIE;
> > > > +                     if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > +                             control |= DW_EDMA_V0_RIE;
> > > > +             }
> > > >               /* Channel control */
> > > >               SET_LL_32(&lli[i].control, control);
> > > >               /* Transfer size */
> > > > @@ -420,15 +423,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > >               SET_CH_32(chip, chan->dir, chan->id, ch_control1,
> > > >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > > >               /* Linked list */
> > > > -             #ifdef CONFIG_64BIT
> > > > -                     SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > > > -                               chunk->ll_region.paddr);
> > > > -             #else /* CONFIG_64BIT */
> > > > +             if ((chan->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> > > > +                 !IS_ENABLED(CONFIG_64BIT)) {
> > > >                       SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
> > > >                                 lower_32_bits(chunk->ll_region.paddr));
> > > >                       SET_CH_32(chip, chan->dir, chan->id, llp.msb,
> > > >                                 upper_32_bits(chunk->ll_region.paddr));
> > > > -             #endif /* CONFIG_64BIT */
> > > > +             } else {
> > > > +                     SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > > > +                               chunk->ll_region.paddr);
> > > > +             }
> > > >       }
> > > >       /* Doorbell */
> > > >       SET_RW_32(chip, chan->dir, doorbell,
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index fcfbc0f47f83d..4321f6378ef66 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -33,6 +33,12 @@ enum dw_edma_map_format {
> > > >       EDMA_MF_HDMA_COMPAT = 0x5
> > > >  };
> > > >
> > > > +/* Probe EDMA engine locally and prevent generate MSI to host side*/
> > > > +#define DW_EDMA_CHIP_LOCAL   BIT(0)
> > > > +
> > > > +/* Only support 32bit DBI register access */
> > > > +#define DW_EDMA_CHIP_32BIT_DBI       BIT(1)
> > > > +
> > >
> > > How about using an enum for defining the flags? This would help us organize the
> > > flags in a more coherent way and also will give the benefit of kdoc.
> >
> > Did you see other linux code use enum as bitmask?
> > According to my understanding, enum just chooses values in a list.
>

There are lot of places it is used:

$ grep -r "= BIT(.*)," include/
 
> Do you agree that using define because it will be used as bitmask?
> 

As I said, using enum helps in organizing the flags and it also provides kdoc.
I'd prefer to go with it.

Thanks,
Mani

> best regards
> Frank Li
> 
> >
> > >
> > > /**
> > >  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
> > >  * @DW_EDMA_CHIP_LOCAL:         eDMA is used locally by an endpoint
> > >  * @DW_EDMA_CHIP_32BIT_DBI:     eDMA only supports 32bit DBI access
> > >  */
> > > enum dw_edma_chip_flags {
> > >         DW_EDMA_CHIP_LOCAL = BIT(0),
> > >         DW_EDMA_CHIP_32BIT_DBI = BIT(1),
> > > };
> > >
> > > >  /**
> > > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > > >   * @dev:              struct device of the eDMA controller
> > > > @@ -40,6 +46,8 @@ enum dw_edma_map_format {
> > > >   * @nr_irqs:          total dma irq number
> > > >   * reg64bit           if support 64bit write to register
> > > >   * @ops                       DMA channel to IRQ number mapping
> > > > + * @flags             - DW_EDMA_CHIP_LOCAL
> > > > + *                    - DW_EDMA_CHIP_32BIT_DBI
> > >
> > > No need to mention the flags here if you use the enum I suggested above.
> > >
> > > >   * @wr_ch_cnt                 DMA write channel number
> > > >   * @rd_ch_cnt                 DMA read channel number
> > > >   * @rg_region                 DMA register region
> > > > @@ -53,6 +61,7 @@ struct dw_edma_chip {
> > > >       int                     id;
> > > >       int                     nr_irqs;
> > > >       const struct dw_edma_core_ops   *ops;
> > > > +     u32                     flags;
> > >
> > >         enum dw_edma_chip_flags flags;
> > >
> > > Thanks,
> > > Mani
> > >
> > > >
> > > >       void __iomem            *reg_base;
> > > >
> > > > --
> > > > 2.24.0.rc1
> > > >
