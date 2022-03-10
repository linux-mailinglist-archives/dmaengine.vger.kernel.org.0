Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887704D5311
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 21:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiCJUae (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 15:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiCJUad (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 15:30:33 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97847C0840;
        Thu, 10 Mar 2022 12:29:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h13so8485598ede.5;
        Thu, 10 Mar 2022 12:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zuorw18C0O93fcxDkRV0gXcu7AHJQrLsOGssT9yRz1E=;
        b=CDThFyecPwMM+bOeGJVRPEbhJHk0Zj+CwLObAthS1NzPzuRIB3Qfs5qrUZx8MBtleq
         FWyDWYV3c35YMGVz1mLy/RCICFOVcw+wnZ6VPAzyj9BaQ6z1OcTjNa4ZlayV0ykaOEPt
         NaGeaJVqQSZIchbIzQdGqCrBNuGMdVT0dgBDfVmH65slegMTuftUc2EevD1+7nqO4cph
         LMYjuPnVxQI3o+1Wnie9difQLmnq2hN1xi+kXlWHotXUk6YptE2k4pzfyE9kv+SVH6qx
         EzEa6Th7PcLJI+VxhowsdhPAMKqxKgha39CIMbowphaHioXljV2qkMB5A33ux3AHfta2
         EyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zuorw18C0O93fcxDkRV0gXcu7AHJQrLsOGssT9yRz1E=;
        b=m6oeDucqDtm3TDytS1UXBlzYED8xb5sX/2EiKuPn/tb7N8tTqJ3Ct/lHxpzViTbzIT
         EyBOsOWr8qFt2Jw8kmr6WMMODh8DLnnBWpNP3KXmWKNSaZZLnnuDNy1YHb4eqR96B82V
         oNRyM5UH3G2zsx0uGTWpeF1vwUEgCrqHWi3h7TZXWJXhqfRRHpHno8VkYHczd4wVVruF
         pTduQbMFaYdZbpQHYMfJnDDTyPjQQJkTNRbcxYx9Jo6yQ6usd+HFteMOtQTD3bDmme5C
         IwLFgNTJgrLEeq6Dvnl5Vfy5QiRqX0kanwyZm+kc48HJSky0z04v+G872vDFKyjL4/tq
         yCcA==
X-Gm-Message-State: AOAM532hwSOB2cocefIcZ1HyhZqQZoNjxrnWFJBfgvEuqT/5g/kHus8z
        RwN74SFqJSuhOkeWB5PtIMi/M53irVB1bJk4NY0=
X-Google-Smtp-Source: ABdhPJxGJh7gB6e9qAwh/8/x2B6PzK8IahBNBgTpz2IDps0Af/X+hvMeJejgN2ax/cnHwn0rxX9z98igh4pIXwkog68=
X-Received: by 2002:a05:6402:35d2:b0:416:4c38:1537 with SMTP id
 z18-20020a05640235d200b004164c381537mr6166635edc.260.1646944167761; Thu, 10
 Mar 2022 12:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20220309211204.26050-1-Frank.Li@nxp.com> <20220309211204.26050-2-Frank.Li@nxp.com>
 <20220310202011.spxpi66golseyc3a@mobilestation>
In-Reply-To: <20220310202011.spxpi66golseyc3a@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 14:29:15 -0600
Message-ID: <CAHrpEqRJTwiNe=OH-cN_2ZeYmAOqaVbQtdaWUVb7AX8=5fFBqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dmaengine: dw-edma: Detach the private data and
 chip info structures
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

 in

On Thu, Mar 10, 2022 at 2:20 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Wed, Mar 09, 2022 at 03:11:57PM -0600, Frank Li wrote:
> > "struct dw_edma_chip" contains an internal structure "struct dw_edma" that
> > is used by the eDMA core internally. This structure should not be touched
> > by the eDMA controller drivers themselves. But currently, the eDMA
> > controller drivers like "dw-edma-pci" allocates and populates this
> > internal structure then passes it on to eDMA core. The eDMA core further
> > populates the structure and uses it. This is wrong!
> >
> > Hence, move all the "struct dw_edma" specifics from controller drivers
> > to the eDMA core.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3 to v4
> >  - Accept most suggestions of Serge Semin
> > Change from v2 to v3
> >  - none
> > Change from v1 to v2
> >  - rework commit message
> >  - remove duplicate field in struct dw_edma
> >
> >  drivers/dma/dw-edma/dw-edma-core.c       | 81 +++++++++++++----------
> >  drivers/dma/dw-edma/dw-edma-core.h       | 32 +--------
> >  drivers/dma/dw-edma/dw-edma-pcie.c       | 83 ++++++++++--------------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c    | 24 +++----
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 10 +--
> >  include/linux/dma/edma.h                 | 44 +++++++++++++
> >  6 files changed, 144 insertions(+), 130 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 53289927dd0d6..1abf41d49f75b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -65,7 +65,7 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
> >  static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> >  {
> >       struct dw_edma_chan *chan = desc->chan;
> > -     struct dw_edma *dw = chan->chip->dw;
> > +     struct dw_edma_chip *chip = chan->dw->chip;
> >       struct dw_edma_chunk *chunk;
> >
> >       chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
> > @@ -82,11 +82,11 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> >        */
> >       chunk->cb = !(desc->chunks_alloc % 2);
> >       if (chan->dir == EDMA_DIR_WRITE) {
> > -             chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
> > -             chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
> > +             chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
> > +             chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
> >       } else {
> > -             chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
> > -             chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
> > +             chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
> > +             chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
> >       }
> >
> >       if (desc->chunk) {
> > @@ -664,7 +664,7 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >       if (chan->status != EDMA_ST_IDLE)
> >               return -EBUSY;
> >
> > -     pm_runtime_get(chan->chip->dev);
> > +     pm_runtime_get(chan->dw->chip->dev);
> >
> >       return 0;
> >  }
> > @@ -686,7 +686,7 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
> >               cpu_relax();
> >       }
> >
> > -     pm_runtime_put(chan->chip->dev);
> > +     pm_runtime_put(chan->dw->chip->dev);
> >  }
> >
> >  static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> > @@ -718,7 +718,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> >       }
> >
> >       INIT_LIST_HEAD(&dma->channels);
> > -     for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
> > +     for (j = 0; (alloc || chip->nr_irqs == 1) && j < cnt; j++, i++) {
> >               chan = &dw->chan[i];
> >
> >               dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
> > @@ -727,7 +727,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> >
> >               chan->vc.chan.private = dt_region;
> >
> > -             chan->chip = chip;
> > +             chan->dw = dw;
> >               chan->id = j;
> >               chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
> >               chan->configured = false;
> > @@ -735,15 +735,15 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> >               chan->status = EDMA_ST_IDLE;
> >
> >               if (write)
> > -                     chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
> > +                     chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
> >               else
> > -                     chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
> > +                     chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
> >               chan->ll_max -= 1;
> >
> >               dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> >                        write ? "write" : "read", j, chan->ll_max);
> >
> > -             if (dw->nr_irqs == 1)
> > +             if (chip->nr_irqs == 1)
> >                       pos = 0;
> >               else
> >                       pos = off_alloc + (j % alloc);
> > @@ -767,13 +767,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
> >               vchan_init(&chan->vc, dma);
> >
> >               if (write) {
> > -                     dt_region->paddr = dw->dt_region_wr[j].paddr;
> > -                     dt_region->vaddr = dw->dt_region_wr[j].vaddr;
> > -                     dt_region->sz = dw->dt_region_wr[j].sz;
> > +                     dt_region->paddr = chip->dt_region_wr[j].paddr;
> > +                     dt_region->vaddr = chip->dt_region_wr[j].vaddr;
> > +                     dt_region->sz = chip->dt_region_wr[j].sz;
> >               } else {
> > -                     dt_region->paddr = dw->dt_region_rd[j].paddr;
> > -                     dt_region->vaddr = dw->dt_region_rd[j].vaddr;
> > -                     dt_region->sz = dw->dt_region_rd[j].sz;
> > +                     dt_region->paddr = chip->dt_region_rd[j].paddr;
> > +                     dt_region->vaddr = chip->dt_region_rd[j].vaddr;
> > +                     dt_region->sz = chip->dt_region_rd[j].sz;
> >               }
> >
> >               dw_edma_v0_core_device_config(chan);
> > @@ -840,16 +840,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >
> >       ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> >
> > -     if (dw->nr_irqs < 1)
> > +     if (chip->nr_irqs < 1)
> >               return -EINVAL;
> >
> > -     if (dw->nr_irqs == 1) {
> > +     if (chip->nr_irqs == 1) {
> >               /* Common IRQ shared among all channels */
> > -             irq = dw->ops->irq_vector(dev, 0);
> > +             irq = chip->ops->irq_vector(dev, 0);
> >               err = request_irq(irq, dw_edma_interrupt_common,
> >                                 IRQF_SHARED, dw->name, &dw->irq[0]);
> >               if (err) {
> > -                     dw->nr_irqs = 0;
> > +                     chip->nr_irqs = 0;
> >                       return err;
> >               }
> >
> > @@ -857,7 +857,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >                       get_cached_msi_msg(irq, &dw->irq[0].msi);
> >       } else {
> >               /* Distribute IRQs equally among all channels */
> > -             int tmp = dw->nr_irqs;
> > +             int tmp = chip->nr_irqs;
> >
> >               while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
> >                       dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
> > @@ -868,7 +868,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >               dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> >
> >               for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> > -                     irq = dw->ops->irq_vector(dev, i);
> > +                     irq = chip->ops->irq_vector(dev, i);
> >                       err = request_irq(irq,
> >                                         i < *wr_alloc ?
> >                                               dw_edma_interrupt_write :
> > @@ -876,7 +876,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >                                         IRQF_SHARED, dw->name,
> >                                         &dw->irq[i]);
> >                       if (err) {
> > -                             dw->nr_irqs = i;
> > +                             chip->nr_irqs = i;
> >                               return err;
> >                       }
> >
> > @@ -884,7 +884,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >                               get_cached_msi_msg(irq, &dw->irq[i].msi);
> >               }
> >
> > -             dw->nr_irqs = i;
> > +             chip->nr_irqs = i;
> >       }
> >
> >       return err;
> > @@ -905,17 +905,24 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >       if (!dev)
> >               return -EINVAL;
> >
> > -     dw = chip->dw;
> > -     if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
> > +     dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> > +     if (!dw)
> > +             return -ENOMEM;
> > +
> > +     chip->dw = dw;
> > +     dw->chip = chip;
> > +
> > +     if (!chip->nr_irqs || !chip->ops)
> >               return -EINVAL;
> >
> >       raw_spin_lock_init(&dw->lock);
> >
> > -     dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
> > +
> > +     dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
> >                             dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> >       dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> >
> > -     dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
> > +     dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
> >                             dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> >       dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> >
> > @@ -936,6 +943,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >       /* Disable eDMA, only to establish the ideal initial conditions */
> >       dw_edma_v0_core_off(dw);
> >
> > +     dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> > +     if (!dw->irq)
> > +             return -ENOMEM;
> > +
> >       /* Request IRQs */
> >       err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
> >       if (err)
> > @@ -960,10 +971,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >       return 0;
> >
> >  err_irq_free:
> > -     for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > -             free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> > +     for (i = (chip->nr_irqs - 1); i >= 0; i--)
> > +             free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> >
> > -     dw->nr_irqs = 0;
> > +     chip->nr_irqs = 0;
> >
> >       return err;
> >  }
> > @@ -980,8 +991,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >       dw_edma_v0_core_off(dw);
> >
> >       /* Free irqs */
> > -     for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > -             free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> > +     for (i = (chip->nr_irqs - 1); i >= 0; i--)
> > +             free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
> >
> >       /* Power management */
> >       pm_runtime_disable(dev);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 60316d408c3e0..e254c2fc3d9cf 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -15,20 +15,12 @@
> >  #include "../virt-dma.h"
> >
> >  #define EDMA_LL_SZ                                   24
> > -#define EDMA_MAX_WR_CH                                       8
> > -#define EDMA_MAX_RD_CH                                       8
> >
> >  enum dw_edma_dir {
> >       EDMA_DIR_WRITE = 0,
> >       EDMA_DIR_READ
> >  };
> >
> > -enum dw_edma_map_format {
> > -     EDMA_MF_EDMA_LEGACY = 0x0,
> > -     EDMA_MF_EDMA_UNROLL = 0x1,
> > -     EDMA_MF_HDMA_COMPAT = 0x5
> > -};
> > -
> >  enum dw_edma_request {
> >       EDMA_REQ_NONE = 0,
> >       EDMA_REQ_STOP,
> > @@ -57,12 +49,6 @@ struct dw_edma_burst {
> >       u32                             sz;
> >  };
> >
> > -struct dw_edma_region {
> > -     phys_addr_t                     paddr;
> > -     void                            __iomem *vaddr;
> > -     size_t                          sz;
> > -};
> > -
> >  struct dw_edma_chunk {
> >       struct list_head                list;
> >       struct dw_edma_chan             *chan;
> > @@ -87,7 +73,7 @@ struct dw_edma_desc {
> >
> >  struct dw_edma_chan {
> >       struct virt_dma_chan            vc;
> > -     struct dw_edma_chip             *chip;
> > +     struct dw_edma                  *dw;
> >       int                             id;
> >       enum dw_edma_dir                dir;
> >
> > @@ -109,10 +95,6 @@ struct dw_edma_irq {
> >       struct dw_edma                  *dw;
> >  };
> >
> > -struct dw_edma_core_ops {
> > -     int     (*irq_vector)(struct device *dev, unsigned int nr);
> > -};
> > -
> >  struct dw_edma {
> >       char                            name[20];
> >
> > @@ -122,21 +104,13 @@ struct dw_edma {
> >       struct dma_device               rd_edma;
> >       u16                             rd_ch_cnt;
> >
> > -     struct dw_edma_region           rg_region;      /* Registers */
> > -     struct dw_edma_region           ll_region_wr[EDMA_MAX_WR_CH];
> > -     struct dw_edma_region           ll_region_rd[EDMA_MAX_RD_CH];
> > -     struct dw_edma_region           dt_region_wr[EDMA_MAX_WR_CH];
> > -     struct dw_edma_region           dt_region_rd[EDMA_MAX_RD_CH];
> > -
> >       struct dw_edma_irq              *irq;
> > -     int                             nr_irqs;
> > -
> > -     enum dw_edma_map_format         mf;
> >
> >       struct dw_edma_chan             *chan;
> > -     const struct dw_edma_core_ops   *ops;
> >
> >       raw_spinlock_t                  lock;           /* Only for legacy */
> > +
> > +     struct dw_edma_chip             *chip;
> >  #ifdef CONFIG_DEBUG_FS
> >       struct dentry                   *debugfs;
> >  #endif /* CONFIG_DEBUG_FS */
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 44f6e09bdb531..2c1c5fa4e9f28 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       struct dw_edma_pcie_data vsec_data;
> >       struct device *dev = &pdev->dev;
> >       struct dw_edma_chip *chip;
> > -     struct dw_edma *dw;
> >       int err, nr_irqs;
> >       int i, mask;
> >
> > @@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       if (!chip)
> >               return -ENOMEM;
> >
> > -     dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> > -     if (!dw)
> > -             return -ENOMEM;
> > -
> >       /* IRQs allocation */
> >       nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
> >                                       PCI_IRQ_MSI | PCI_IRQ_MSIX);
> > @@ -228,29 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       }
> >
> >       /* Data structure initialization */
> > -     chip->dw = dw;
> >       chip->dev = dev;
> >       chip->id = pdev->devfn;
> > -     chip->irq = pdev->irq;
> >
> > -     dw->mf = vsec_data.mf;
> > -     dw->nr_irqs = nr_irqs;
> > -     dw->ops = &dw_edma_pcie_core_ops;
> > -     dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
> > -     dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
> > +     chip->mf = vsec_data.mf;
> > +     chip->nr_irqs = nr_irqs;
> > +     chip->ops = &dw_edma_pcie_core_ops;
> >
> > -     dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> > -     if (!dw->rg_region.vaddr)
> > -             return -ENOMEM;
> > +     chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
> > +     chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
> >
> > -     dw->rg_region.vaddr += vsec_data.rg.off;
> > -     dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
> > -     dw->rg_region.paddr += vsec_data.rg.off;
> > -     dw->rg_region.sz = vsec_data.rg.sz;
> > +     chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> > +     if (!chip->rg_region.vaddr)
> > +             return -ENOMEM;
> >
> > -     for (i = 0; i < dw->wr_ch_cnt; i++) {
> > -             struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
> > -             struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
> > +     for (i = 0; i < chip->wr_ch_cnt; i++) {
> > +             struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > +             struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> >               struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
> >               struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
> >
> > @@ -273,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >               dt_region->sz = dt_block->sz;
> >       }
> >
> > -     for (i = 0; i < dw->rd_ch_cnt; i++) {
> > -             struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
> > -             struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
> > +     for (i = 0; i < chip->rd_ch_cnt; i++) {
> > +             struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> > +             struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> >               struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
> >               struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
> >
> > @@ -299,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       }
> >
> >       /* Debug info */
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY)
> > -             pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
> > -     else if (dw->mf == EDMA_MF_EDMA_UNROLL)
> > -             pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
> > -     else if (dw->mf == EDMA_MF_HDMA_COMPAT)
> > -             pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
> > +     if (chip->mf == EDMA_MF_EDMA_LEGACY)
> > +             pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
> > +     else if (chip->mf == EDMA_MF_EDMA_UNROLL)
> > +             pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
> > +     else if (chip->mf == EDMA_MF_HDMA_COMPAT)
> > +             pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
> >       else
> > -             pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
> > +             pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
> >
> > -     pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > +     pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
> >               vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> > -             dw->rg_region.vaddr, &dw->rg_region.paddr);
> > +             chip->rg_region.vaddr);
> >
> >
> > -     for (i = 0; i < dw->wr_ch_cnt; i++) {
> > +     for (i = 0; i < chip->wr_ch_cnt; i++) {
> >               pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> >                       i, vsec_data.ll_wr[i].bar,
> > -                     vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
> > -                     dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
> > +                     vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> > +                     chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
> >
> >               pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> >                       i, vsec_data.dt_wr[i].bar,
> > -                     vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
> > -                     dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
> > +                     vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
> > +                     chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
> >       }
> >
> > -     for (i = 0; i < dw->rd_ch_cnt; i++) {
> > +     for (i = 0; i < chip->rd_ch_cnt; i++) {
> >               pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> >                       i, vsec_data.ll_rd[i].bar,
> > -                     vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
> > -                     dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
> > +                     vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> > +                     chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
> >
> >               pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> >                       i, vsec_data.dt_rd[i].bar,
> > -                     vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
> > -                     dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
> > +                     vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
> > +                     chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
> >       }
> >
> > -     pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
> > +     pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
> >
> >       /* Validating if PCI interrupts were enabled */
> >       if (!pci_dev_msi_enabled(pdev)) {
> > @@ -345,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >               return -EPERM;
> >       }
> >
> > -     dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> > -     if (!dw->irq)
> > -             return -ENOMEM;
> > -
> >       /* Starting eDMA driver */
> >       err = dw_edma_probe(chip);
> >       if (err) {
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 329fc2e57b703..e507e076fad16 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -25,7 +25,7 @@ enum dw_edma_control {
> >
> >  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> >  {
> > -     return dw->rg_region.vaddr;
> > +     return dw->chip->rg_region.vaddr;
> >  }
> >
> >  #define SET_32(dw, name, value)                              \
> > @@ -96,7 +96,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> >  static inline struct dw_edma_v0_ch_regs __iomem *
> >  __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
> >  {
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY)
> > +     if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
> >               return &(__dw_regs(dw)->type.legacy.ch);
> >
> >       if (dir == EDMA_DIR_WRITE)
> > @@ -108,7 +108,7 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
> >  static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >                            u32 value, void __iomem *addr)
> >  {
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> > +     if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
> >               u32 viewport_sel;
> >               unsigned long flags;
> >
> > @@ -133,7 +133,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  {
> >       u32 value;
> >
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> > +     if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
> >               u32 viewport_sel;
> >               unsigned long flags;
> >
> > @@ -169,7 +169,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >                            u64 value, void __iomem *addr)
> >  {
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> > +     if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
> >               u32 viewport_sel;
> >               unsigned long flags;
> >
> > @@ -194,7 +194,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  {
> >       u32 value;
> >
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY) {
> > +     if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
> >               u32 viewport_sel;
> >               unsigned long flags;
> >
> > @@ -256,7 +256,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
> >
> >  enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> >  {
> > -     struct dw_edma *dw = chan->chip->dw;
> > +     struct dw_edma *dw = chan->dw;
> >       u32 tmp;
> >
> >       tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
> > @@ -272,7 +272,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
> >
> >  void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> >  {
> > -     struct dw_edma *dw = chan->chip->dw;
> > +     struct dw_edma *dw = chan->dw;
> >
> >       SET_RW_32(dw, chan->dir, int_clear,
> >                 FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
> > @@ -280,7 +280,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
> >
> >  void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
> >  {
> > -     struct dw_edma *dw = chan->chip->dw;
> > +     struct dw_edma *dw = chan->dw;
> >
> >       SET_RW_32(dw, chan->dir, int_clear,
> >                 FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
> > @@ -357,7 +357,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >       struct dw_edma_chan *chan = chunk->chan;
> > -     struct dw_edma *dw = chan->chip->dw;
> > +     struct dw_edma *dw = chan->dw;
> >       u32 tmp;
> >
> >       dw_edma_v0_core_write_chunk(chunk);
> > @@ -365,7 +365,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >       if (first) {
> >               /* Enable engine */
> >               SET_RW_32(dw, chan->dir, engine_en, BIT(0));
> > -             if (dw->mf == EDMA_MF_HDMA_COMPAT) {
> > +             if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
> >                       switch (chan->id) {
> >                       case 0:
> >                               SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
> > @@ -431,7 +431,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >
> >  int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
> >  {
> > -     struct dw_edma *dw = chan->chip->dw;
> > +     struct dw_edma *dw = chan->dw;
> >       u32 tmp = 0;
> >
> >       /* MSI done addr - low, high */
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > index 4b3bcffd15ef1..edb7e137cb35a 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> > @@ -54,7 +54,7 @@ struct debugfs_entries {
> >  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
> >  {
> >       void __iomem *reg = (void __force __iomem *)data;
> > -     if (dw->mf == EDMA_MF_EDMA_LEGACY &&
> > +     if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
> >           reg >= (void __iomem *)&regs->type.legacy.ch) {
> >               void __iomem *ptr = &regs->type.legacy.ch;
> >               u32 viewport_sel = 0;
> > @@ -173,7 +173,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
> >       nr_entries = ARRAY_SIZE(debugfs_regs);
> >       dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> >
> > -     if (dw->mf == EDMA_MF_HDMA_COMPAT) {
> > +     if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
> >               nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
> >               dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
> >                                          regs_dir);
> > @@ -242,7 +242,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
> >       nr_entries = ARRAY_SIZE(debugfs_regs);
> >       dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
> >
> > -     if (dw->mf == EDMA_MF_HDMA_COMPAT) {
> > +     if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
> >               nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
> >               dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
> >                                          regs_dir);
> > @@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
> >       if (!dw)
> >               return;
> >
> > -     regs = dw->rg_region.vaddr;
> > +     regs = dw->chip->rg_region.vaddr;
> >       if (!regs)
> >               return;
> >
> > @@ -296,7 +296,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
> >       if (!dw->debugfs)
> >               return;
> >
> > -     debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
> > +     debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
> >       debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
> >       debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
> >
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index cab6e18773dad..a9bee4aeb2eee 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -12,19 +12,63 @@
> >  #include <linux/device.h>
> >  #include <linux/dmaengine.h>
> >
> > +#define EDMA_MAX_WR_CH                                  8
> > +#define EDMA_MAX_RD_CH                                  8
> > +
> >  struct dw_edma;
> >
> > +struct dw_edma_region {
> > +     phys_addr_t     paddr;
> > +     void __iomem    *vaddr;
> > +     size_t          sz;
> > +};
> > +
> > +struct dw_edma_core_ops {
> > +     int (*irq_vector)(struct device *dev, unsigned int nr);
> > +};
> > +
> > +enum dw_edma_map_format {
> > +     EDMA_MF_EDMA_LEGACY = 0x0,
> > +     EDMA_MF_EDMA_UNROLL = 0x1,
> > +     EDMA_MF_HDMA_COMPAT = 0x5
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:              struct device of the eDMA controller
> >   * @id:                       instance ID
> >   * @irq:              irq line
> > + * @nr_irqs:          total dma irq number
> > + * @ops                       DMA channel to IRQ number mapping
> > + * @wr_ch_cnt                 DMA write channel number
> > + * @rd_ch_cnt                 DMA read channel number
> > + * @rg_region                 DMA register region
> > + * @ll_region_wr      DMA descriptor link list memory for write channel
> > + * @ll_region_rd      DMA descriptor link list memory for read channel
> > + * @mf                        DMA register map format
> >   * @dw:                       struct dw_edma that is filed by dw_edma_probe()
> >   */
> >  struct dw_edma_chip {
> >       struct device           *dev;
> >       int                     id;
> >       int                     irq;
> > +     int                     nr_irqs;
> > +     const struct dw_edma_core_ops   *ops;
> > +
> > +     struct dw_edma_region   rg_region;
> > +
> > +     u16                     wr_ch_cnt;
> > +     u16                     rd_ch_cnt;
> > +     /* link list address */
> > +     struct dw_edma_region   ll_region_wr[EDMA_MAX_WR_CH];
> > +     struct dw_edma_region   ll_region_rd[EDMA_MAX_RD_CH];
> > +
> > +     /* data region */
> > +     struct dw_edma_region   dt_region_wr[EDMA_MAX_WR_CH];
> > +     struct dw_edma_region   dt_region_rd[EDMA_MAX_RD_CH];
> > +
> > +     enum dw_edma_map_format mf;
> > +
>
> >       struct dw_edma          *dw;
>
> Please drop this field from here and just change the dw_edma_probe()
> prototype to returning a pointer to the struct dw_edma structure. Like
> this:
> struct dw_edma *dw_edma_probe(const struct dw_edma_chip *chip);
> void dw_edma_remove(struct dw_edma *dw);

Actually, I don't think it is good to drop it now.

struct dw_edma *dw_edma_probe(const struct dw_edma_chip *chip);

Users likely put struct dw_edma_chip in stack.
foo()
{
        struct dw_edma_chip chip
        dw = dw_edma_proble(&chip);
}

but now, edma_core_driver still does not save chip information to dw_edma

>
> By doing so we'll be able to have the chip data being const and at least
> statically defined.
>
> -Sergey
>
> >  };
> >
> > --
> > 2.24.0.rc1
> >
