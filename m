Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB64D5216
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbiCJS1Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 13:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiCJS1Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 13:27:25 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7466315879D;
        Thu, 10 Mar 2022 10:26:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id w27so10955548lfa.5;
        Thu, 10 Mar 2022 10:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHOMjH5MbYALlpP+i8VSvXdfmClCVMeFQWDVjPZGG1k=;
        b=KuquYEsTTBNBM6BdMC/ShJfh8JoeSvvbqy15PUo7K/jxP30MwkbziOz1kOqm2lc1gs
         gRMVbsekFfedAuStIVafn2Em3hB822NS7r7K0avzXi5fLM5xYv7IUv05P5R6U2bwULeQ
         E7nog2qm9PRy+5xMRo4LBtibbuB4avXgKu9/GZwezmMa6fTZGAGkA/F1hj1ie+USRi2y
         Elw0mjZiJXuk2ZBCFfbWHTNMDEyxCmDdbjKIRfsopi9tut5ApbweugA1Ro75gL1d5Bqf
         M9hGOjLfP+x3m/SWaxG+i/BwW3Bp7WnOQsq1WaFcr9IRI5iU3Cy6OO2/mNw6U4bYhhzA
         2fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHOMjH5MbYALlpP+i8VSvXdfmClCVMeFQWDVjPZGG1k=;
        b=WB97s7zM5VmzQGpi6+hLUobn1BCZsVNozXNw/6AkjqGlVRUI1oYNn9heINoTNFx4/E
         F70C6wH3uRe2NSOViE0SyhXN8nZMJiua0vpew7PE1+GlDL6rNqRP9Qtc1klyIQ4RMez4
         Cytb2Aj2ZnQrLxo7yU91G0J8Grj83Run9PAc7DHd25xNG02YbybfojT2BWFouyNdDf/K
         Uup1Vz2MiF9Yi5ANTZ2stxk+Kn0CpwxhYqM7tRFnOTJDHf6YU34JZCenxfpwFZka3PID
         1dZUVuhE1/mXqubD0IU5/fBclE0GA897GIkd87OTzmBD7/YpISqaB9m2+dXh3xs6WF3t
         3zbQ==
X-Gm-Message-State: AOAM531DpcuU02OHERsEHDe4RJbHvwDF0D6zFkdKWCvwvf2SNzlYHQ5e
        cxuf+fFhQsNTPZyD0cr7r3Y=
X-Google-Smtp-Source: ABdhPJyC1gpFvUMWzWBWgLdjDn6Jw6FmJba2HZiucrunUyUFkBWMRIH94Que7CoS4B9qGLumpTxChw==
X-Received: by 2002:a05:6512:3f1d:b0:443:3c8b:58f5 with SMTP id y29-20020a0565123f1d00b004433c8b58f5mr3825344lfa.669.1646936781410;
        Thu, 10 Mar 2022 10:26:21 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e5349000000b00247e931bd67sm1216693ljd.9.2022.03.10.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:26:03 -0800 (PST)
Date:   Thu, 10 Mar 2022 21:25:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 7/8] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220310182549.stijctp5ct75x4uo@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-8-Frank.Li@nxp.com>
 <20220310174643.gxtmg373dgqqocpk@mobilestation>
 <CAHrpEqSZjZvA4RE8hw_kJgw535SHNOWziZfQU_HsQT2DJArpcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqSZjZvA4RE8hw_kJgw535SHNOWziZfQU_HsQT2DJArpcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 10, 2022 at 11:54:30AM -0600, Zhi Li wrote:
> On Thu, Mar 10, 2022 at 11:47 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Wed, Mar 09, 2022 at 03:12:03PM -0600, Frank Li wrote:
> > > Allow PCI EP probe DMA locally and prevent use of remote MSI
> > > to remote PCI host.
> > >
> > > Add option to force 32bit DBI register access even on
> > > 64-bit systems. i.MX8 hardware only allowed 32bit register
> > > access.
> >
> > Could you please split this patch up into two? These flags are
> > unrelated thus adding them is two unrelated changes. That can be
> > implicitly inferred from your commit log and the patch title.
> 

> I don't think it needs to be separated.  It also show why need 32bit mask to
> control features and reserved futured extension capability .
> 
> The two flags were descriptions for EDMA chip features.

Both of these flags define separate platform features. Each of which
can be distinctively specific for a particular SoC, not only for the
i.MX8. Even though your log messages does mention i.MX8 hardware the
corresponding flag is defined as generic in the patch. As I said both
flags are unrelated to each other and can be independently specific to
one or another platform. So one SoC can be restricted to use 32bits
DBI IOs and do have the Synopsys PCIe End-point IP prototype kit
detected on the PCIe bus. Another SoC can have the eDMA core embedded
into the DW PCIe EP/Host controller, but with no 32-bits DBI IOs
requirement.

Secondly since both of these flags are unrelated then having a
monolithic patch as you suggest will harden the bisection procedure in
case of a bug is caused by one of these modifications. Bisecting will
lead straight to the bogus change if the patch is split up into two.

Thirdly as I said before your commit log states two distinctive
changes, which means the log can be split up into two together with
the logical changes. In addition referring to a particular change in
further commits will be more informative.

Finally please see [1] regarding the patches splitting up, logical changes,
bisection, etc.

[1] Documentation/process/submitting-patches.rst: "Separate your changes"

-Sergey

> 
> >
> > -Sergey
> >
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v3 to v4
> > >  - None
> > > Change from v2 to v3
> > >  - rework commit message
> > >  - Change to DW_EDMA_CHIP_32BIT_DBI
> > >  - using DW_EDMA_CHIP_LOCAL control msi
> > >  - Apply Bjorn's comments,
> > >         if (!j) {
> > >                control |= DW_EDMA_V0_LIE;
> > >                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> > >                                control |= DW_EDMA_V0_RIE;
> > >         }
> > >
> > >         if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
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
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
> > >  include/linux/dma/edma.h              |  9 +++++++++
> > >  2 files changed, 21 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 35f2adac93e46..00a00d68d44e7 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> > >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >  {
> > >       struct dw_edma_burst *child;
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > >       struct dw_edma_v0_lli __iomem *lli;
> > >       struct dw_edma_v0_llp __iomem *llp;
> > >       u32 control = 0, i = 0;
> > > @@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >       j = chunk->bursts_alloc;
> > >       list_for_each_entry(child, &chunk->burst->list, list) {
> > >               j--;
> > > -             if (!j)
> > > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > > -
> > > +             if (!j) {
> > > +                     control |= DW_EDMA_V0_LIE;
> > > +                     if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > +                             control |= DW_EDMA_V0_RIE;
> > > +             }
> > >               /* Channel control */
> > >               SET_LL_32(&lli[i].control, control);
> > >               /* Transfer size */
> > > @@ -414,15 +417,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >               SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> > >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > >               /* Linked list */
> > > -             #ifdef CONFIG_64BIT
> > > -                     SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > > -                               chunk->ll_region.paddr);
> > > -             #else /* CONFIG_64BIT */
> > > +             if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> > > +                 !IS_ENABLED(CONFIG_64BIT)) {
> > >                       SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> > >                                 lower_32_bits(chunk->ll_region.paddr));
> > >                       SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> > >                                 upper_32_bits(chunk->ll_region.paddr));
> > > -             #endif /* CONFIG_64BIT */
> > > +             } else {
> > > +                     SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > > +                               chunk->ll_region.paddr);
> > > +             }
> > >       }
> > >       /* Doorbell */
> > >       SET_RW_32(dw, chan->dir, doorbell,
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index c2039246fc08c..eea11b1d9e688 100644
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
> > >  /**
> > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > >   * @dev:              struct device of the eDMA controller
> > > @@ -40,6 +46,8 @@ enum dw_edma_map_format {
> > >   * @nr_irqs:          total dma irq number
> > >   * @ops                       DMA channel to IRQ number mapping
> > >   * @reg_base          DMA register base address
> > > + * @flags               - DW_EDMA_CHIP_LOCAL
> > > + *                      - DW_EDMA_CHIP_32BIT_DBI
> > >   * @ll_wr_cnt                 DMA write link list number
> > >   * @ll_rd_cnt                 DMA read link list number
> > >   * @rg_region                 DMA register region
> > > @@ -53,6 +61,7 @@ struct dw_edma_chip {
> > >       int                     id;
> > >       int                     nr_irqs;
> > >       const struct dw_edma_core_ops   *ops;
> > > +     u32                     flags;
> > >
> > >       void __iomem            *reg_base;
> > >
> > > --
> > > 2.24.0.rc1
> > >
