Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC01512004
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbiD0QtR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbiD0QtP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:49:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC225177B;
        Wed, 27 Apr 2022 09:46:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bg9so1874073pgb.9;
        Wed, 27 Apr 2022 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfLIi7M0ejRLlXUml3mWuBYY98Ras26Ry9ezyo7ncFc=;
        b=FDpWXld8ui8/puEY7U7ErD4M81vuJpVjax5m/Aq1X7KF002IDFsgLJesdzx66/Rs67
         u2tzI5YiHPC2yeE00C3GdVv0zy9LLzOC64UaMM/66VdyvBNokmugFxzVcSaSp65chYA2
         DI/nUhaKdN4qaXuLM+/+WfITLad6tJqCd06i1fx8JQx5//51aWbg1VRn4Flim/v0VjsV
         j0tf2oGoXGSnzTS4iXXtorRykWufq3ybIqkXOtNP7L5DVf4NwIMv+PDJ9tQuG8cBsEcq
         1Z4wqC2Y3OxVhSiDER45Xt84EowUp5TdXeF9+e98u/kj1x+5MyCMAi60B6HPsBDYpQIr
         OENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfLIi7M0ejRLlXUml3mWuBYY98Ras26Ry9ezyo7ncFc=;
        b=DtG+ksOu8GYU4aRbAZBE1GwgHFw0Qe2h/Jrnbw3K1F427fCkTuLaCsKqA0Cuyp1NAw
         R7UBCQbeZ1Od7qydcjTar2hcKXNKiE2pTPVO9FNbbme/c1QCxvDryl8vGovfyQT4DYOp
         60jpSf7h7ZKKc6hxAySqdWCZgtS3merqXKzcYISTVUcOxXqSOicy+DBbDEDgtQusypnw
         JQYj+p8vkNJUWH9xX4Dhsg0aw8nKdNXWt0+OcVz/6WUlbpjECZL2znvLvOIjazMCOPfg
         yvnjRMEw4jELvYMGN1QSgIZRpzWQIism9XQuJmNZpt5twV6PoPqqDK7j91yjOOhlsmIe
         5DDQ==
X-Gm-Message-State: AOAM533YlkXZBA4+UBU12i7j2ROD/PT4YD2EECdDS8Na6pPQNQ2+bT2a
        rwlvrt7v8OxM+HneHRFZtfekQKMucGsCIzkMheY=
X-Google-Smtp-Source: ABdhPJwuVL6Ugbvkz+KkYh0ppItIip4wos/clMe1ziK1/Ds2eesN0oDrXeUx1ln693n+3RChFxvjF1WRBogwp5XIIq8=
X-Received: by 2002:a63:c22:0:b0:39d:a9ed:ebc6 with SMTP id
 b34-20020a630c22000000b0039da9edebc6mr24790713pgl.350.1651077959652; Wed, 27
 Apr 2022 09:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220422143643.727871-1-Frank.Li@nxp.com> <20220422143643.727871-5-Frank.Li@nxp.com>
 <20220423121218.GG374560@thinkpad> <CAHrpEqTxc71wKMHQCcAd=jFPOONbrD1S1RNOr78kiu3Vr25a7w@mail.gmail.com>
In-Reply-To: <CAHrpEqTxc71wKMHQCcAd=jFPOONbrD1S1RNOr78kiu3Vr25a7w@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 27 Apr 2022 11:45:48 -0500
Message-ID: <CAHrpEqSHyoQe+vASQB3+igGh74HgTBAKfKLynoEuV17a6yijxQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to
 ll_wr(rd)_cnt in struct dw_edma_chip
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Apr 23, 2022 at 4:47 PM Zhi Li <lznuaa@gmail.com> wrote:
>
> On Sat, Apr 23, 2022 at 7:12 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Apr 22, 2022 at 09:36:38AM -0500, Frank Li wrote:
> > > There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
> > > write(read) channel number from register, then save these into dw_edma.
> > > Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
> > > are available in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
> > > ll_wr(rd)_cnt to indicate actual usage.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >
> > One minor comment below,
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > ---
> > > Change from v6 to v9
> > >  - none
> > > Change from v5 to v6
> > >  - s/rename/Rename/ at subject
> > > new patch at v4
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
> > >  drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
> > >  include/linux/dma/edma.h           |  8 ++++----
> > >  3 files changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 435e4f2ab6575..1a0a98f6c5515 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -919,11 +919,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >
> > >       raw_spin_lock_init(&dw->lock);
> > >
> > > -     dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
> > > +     dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > >                             dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> > >       dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > >
> > > -     dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
> > > +     dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > >                             dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> > >       dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index ae42bad24dd5a..7732537f96086 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -230,14 +230,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >       chip->nr_irqs = nr_irqs;
> > >       chip->ops = &dw_edma_pcie_core_ops;
> > >
> > > -     chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
> > > -     chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
> > > +     chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
> > > +     chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
> > >
> > >       chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> > >       if (!chip->reg_base)
> > >               return -ENOMEM;
> > >
> > > -     for (i = 0; i < chip->wr_ch_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_wr_cnt; i++) {
> > >               struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > >               struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> > >               struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
> > > @@ -262,7 +262,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >               dt_region->sz = dt_block->sz;
> > >       }
> > >
> > > -     for (i = 0; i < chip->rd_ch_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_rd_cnt; i++) {
> > >               struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> > >               struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> > >               struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
> > > @@ -302,7 +302,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >               chip->reg_base);
> > >
> > >
> > > -     for (i = 0; i < chip->wr_ch_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_wr_cnt; i++) {
> > >               pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > >                       i, vsec_data.ll_wr[i].bar,
> > >                       vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> > > @@ -314,7 +314,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >                       chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
> > >       }
> > >
> > > -     for (i = 0; i < chip->rd_ch_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_rd_cnt; i++) {
> > >               pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> > >                       i, vsec_data.ll_rd[i].bar,
> > >                       vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index e9ce652b88233..c2039246fc08c 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -40,8 +40,8 @@ enum dw_edma_map_format {
> > >   * @nr_irqs:          total dma irq number
> > >   * @ops                       DMA channel to IRQ number mapping
> > >   * @reg_base          DMA register base address
> > > - * @wr_ch_cnt                 DMA write channel number
> > > - * @rd_ch_cnt                 DMA read channel number
> > > + * @ll_wr_cnt                 DMA write link list number
> > > + * @ll_rd_cnt                 DMA read link list number
> >
> > DMA linked list write/read memory regions?
>
> ll_wr_cnt is the counter of the DMA listed list.
>
> Do you means
>
> @ll_region_wr        DMA linked list write memory regions
>
> best regards
> Frank Li

Ping @Manivannan Sadhasivam


>
>
> >
> > Thanks,
> > Mani
> >
> > >   * @rg_region                 DMA register region
> > >   * @ll_region_wr      DMA descriptor link list memory for write channel
> > >   * @ll_region_rd      DMA descriptor link list memory for read channel
> > > @@ -56,8 +56,8 @@ struct dw_edma_chip {
> > >
> > >       void __iomem            *reg_base;
> > >
> > > -     u16                     wr_ch_cnt;
> > > -     u16                     rd_ch_cnt;
> > > +     u16                     ll_wr_cnt;
> > > +     u16                     ll_rd_cnt;
> > >       /* link list address */
> > >       struct dw_edma_region   ll_region_wr[EDMA_MAX_WR_CH];
> > >       struct dw_edma_region   ll_region_rd[EDMA_MAX_RD_CH];
> > > --
> > > 2.35.1
> > >
