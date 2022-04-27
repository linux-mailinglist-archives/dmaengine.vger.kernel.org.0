Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD42512112
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiD0RVu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiD0RVt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 13:21:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847A43498
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 10:18:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so2142774plh.1
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZNzLVb6IYQOQv9U2eS6LqWegFjblxsHIEuJynYwzEGc=;
        b=aCqN21episAYOq2l82EB/yHcNnat6tZvY04o7oNbYHLafKqkBN61WjW970RUu7zqkn
         nNFUca/Nc1Kg8XpNSBtDYjHvVMBPrbBw3GM/WRJEZBXmqwvHxi9VvpCFI3q6Jgh71rhw
         vVXh1PH50/g65qGVAfHxdZFkGrcX75L/7RElLrLyZDCiKK4xkyzNMW/OgsAac+m57Ico
         pMGMuALK3wujfzkL/GftiCTr3aA845ytnKwrcrdBjKjBFvcR7+eunnmsOr3mnz7prpIu
         i/xoAOuiezzOcNtFnOi1wAjbOqPE2gDzFFcMNOeLs9Dd3+TtpQDLzb70hq7/B1judgYK
         qecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZNzLVb6IYQOQv9U2eS6LqWegFjblxsHIEuJynYwzEGc=;
        b=dXYz9nFiU8yCpIXmSzRm1FtpcE5QTEpuRpRMqk59UmzwDSm3/ifXqBe17h1T6Ju/xS
         Leg0kkNv3HVFPTfohGVdHv4KBIkc2WIQHjlRrfg9OQdDH7Za2z/sAmeb56MjlxwWkSiX
         FS6PEJcAllC8hh51MWRmVSqlv9DyzM4F9nDy6K4vR3sK5UBuGmaV3bBru4xPi7Efd8T3
         zulQ6cg9A1MaBby2AZSI5qJwtIkPlkso2CiYA2M4kavoK5dTiQ7oNf5JXXNMpODyU8fd
         oXed5ba91cC5rqkxx7SU8ahQ/FYWKOK13J2DDw8AItNgIsJAOEzmRhTVd9h+IEQOzj7s
         J3sA==
X-Gm-Message-State: AOAM530tNbNPBNO601KsOCEDVp3dkI94UplBErD9riDZ7oyy82DmLO6t
        DVv5JVUVEma2n2qTEfkDJyCl
X-Google-Smtp-Source: ABdhPJyYSL0q24w6bSBRKVpoN2yZQbpWZLnjfnjWLPUv3F65PWgqqpx4Vv0kdJYzyrA3HfKXiIhD5A==
X-Received: by 2002:a17:90b:110a:b0:1d2:bde4:e277 with SMTP id gi10-20020a17090b110a00b001d2bde4e277mr33552950pjb.188.1651079914148;
        Wed, 27 Apr 2022 10:18:34 -0700 (PDT)
Received: from thinkpad ([27.111.75.179])
        by smtp.gmail.com with ESMTPSA id v1-20020a62c301000000b00505bc0b970dsm20234632pfg.178.2022.04.27.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:18:33 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:48:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v9 4/9] dmaengine: dw-edma: Rename wr(rd)_ch_cnt to
 ll_wr(rd)_cnt in struct dw_edma_chip
Message-ID: <20220427171827.GD4161@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-5-Frank.Li@nxp.com>
 <20220423121218.GG374560@thinkpad>
 <CAHrpEqTxc71wKMHQCcAd=jFPOONbrD1S1RNOr78kiu3Vr25a7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqTxc71wKMHQCcAd=jFPOONbrD1S1RNOr78kiu3Vr25a7w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Apr 23, 2022 at 04:47:51PM -0500, Zhi Li wrote:
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

Sorry, I confused the terms here. But can you use "count" instead of "number"?

Thanks,
Mani

> best regards
> Frank Li
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
