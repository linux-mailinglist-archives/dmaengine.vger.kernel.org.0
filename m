Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334B64D4F49
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 17:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiCJQ30 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 11:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbiCJQ2I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 11:28:08 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29F1EEEA;
        Thu, 10 Mar 2022 08:27:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so12727404ejc.9;
        Thu, 10 Mar 2022 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wPJa1hUAbgZSIzeJTAud0xZ3vRUz2xuwzEonWnr3LY=;
        b=ogOI7G/rHeETioQmcRgRFHuR+jiyuRpAGdjubNFz+ysXoWjXRC+DbSF66RZswvyfhq
         rGCcvVMhEnlsEgX4YAlR+tTQt0/h3eSNMNKO9+HCgm1ALB422JcS8/+a1GQSVTqm2Ku3
         GCF53ojruB3aTnJ2/+7N9RbdUPjtI1M45VeMkUHzIG1+qkwG3kyUxDi8mgKnDBmSlKEb
         MeOgTsAUKVRTVr+NsGUpkpWlPCwukSv/TUG3YMqj34HlJWMP74Z+yvOe6I+BPE7tOOC3
         YS8aJE171GIQG+zp0Gz/pqv1XwzGm/MLAcLRhjHi4toNtOBbD2r1Q9owplqlzWC4Rj7H
         8Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wPJa1hUAbgZSIzeJTAud0xZ3vRUz2xuwzEonWnr3LY=;
        b=O2mH5Cj6AK7G4ctNPF0wiu2bd8wi4HFVsDkIE9Oi2worzwnQn2PyLCmbPI5GNtFNUa
         5oPwGxrItO1DfeBE2hUo2UJSpnBSSao/ilRXJkFTdl6ZQZGj7q8xcVj7hYKPlpmnpW8o
         u9KB1Wu6EMnWepg/AsUyk4LvWlEiqZk5ZJmwcR40UsfAH51jM6G5B7KJjyi3lJc+8ssV
         R5zT68rXOgDBPw82HhSk5n7nbxOsvlbr8jG4wq333HfBfFG9IIWV4clDPN9y34NRyy3T
         /pCFQVfDZQhfEoS6e2FClQNsKIZZXabHwhScliv7Sh/oTY57cZPhG4k2Uf5IU6PKIIvg
         iLOw==
X-Gm-Message-State: AOAM531FquPWI5OC1Y/1e5Q6U+wAPFn0uoMCk8Pr5saaybwNJ4fyBjDF
        WQYrQe7NoB43MYdklOcUTaNdFPikMUJ/hFO1Dgo=
X-Google-Smtp-Source: ABdhPJzY9Vs2Gxwygh0ujoXT64t5XSgNWpoxjMXMh4kuREtLO+dnFZskDmzFYD0T7XBkVvs9DfgYZOTBFDcGniLydkU=
X-Received: by 2002:a17:906:7245:b0:6cf:d3c6:8c63 with SMTP id
 n5-20020a170906724500b006cfd3c68c63mr4690707ejk.677.1646929624067; Thu, 10
 Mar 2022 08:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20220309211204.26050-1-Frank.Li@nxp.com> <20220309211204.26050-5-Frank.Li@nxp.com>
 <20220310123716.z6zh72ybevze3nk2@mobilestation>
In-Reply-To: <20220310123716.z6zh72ybevze3nk2@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 10:26:51 -0600
Message-ID: <CAHrpEqRXx8aTMCRj3PZCJiX9UC=PPfuky8Se_-21a4H11V-WdA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] dmaengine: dw-edma: rename wr(rd)_ch_cnt to
 ll_wr(rd)_cnt in struct dw_edma_chip
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

On Thu, Mar 10, 2022 at 6:37 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Wed, Mar 09, 2022 at 03:12:00PM -0600, Frank Li wrote:
> > There are same name wr(rd)_ch_cnt in struct dw_edma. EDMA driver get
> > write(read) channel number from register, then save these into dw_edma.
> > Old wr(rd)_ch_cnt in dw_edma_chip actuall means how many link list memory
> > are avaiable in ll_region_wr(rd)[EDMA_MAX_WR_CH]. So rename it to
> > ll_wr(rd)_cnt to indicate actual usage.
>
> Hmm, I am not sure you are right here. AFAICS the
> drivers/dma/dw-edma/dw-edma-pcie.c driver either uses a statically
> defined number or Rd/Wr channels or just gets the number from the
> specific vsec PCIe capability. Then based on that the driver just
> redistributes the BARs memory amongst all the detected channels in
> accordance with the statically defined snps_edda_data structure.
> Basically the BARs memory serves as the Local/CPU/Application memory
> for the case if the controller is embedded into the PCIe Host/EP
> controller. See the patches which implicitly prove that:
> 31fb8c1ff962 ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> da6e0dd54135 ("dmaengine: dw-edma: Change linked list and data blocks offset and sizes")
>
> (That's why the logic of the DEV_TO_MEM/MEM_TO_DEV is inverted for the
> the drivers/dma/dw-edma/dw-edma-pcie.c platform.)
>
> So basically the wr_ch_cnt/rd_ch_cnt fields have been and is used as
> the number of actually available channels, not linked-list. While the
> notation suggested by you can be confusing, since the ll-memory allocated for
> each channel can be split up and initialized with numerous linked lists
> each of which is used one after another.
>
> I don't really see a well justified reason to additionally have the
> @wr_ch_cnt and @rd_ch_cnt fields in the dw_edma_chip seeing the number
> of channels can be auto-detected from the corresponding registers, except
> that to workaround a bogus hardware. So we can keep it, but please no
> renaming. It will only cause additional confusion.

I agree that channel numbers can be obtained from the register.
but Caller don't know the channel number before calling dw_edma_probe.

Caller may not init all ll_region_wr[EDMA_MAX_WR_CH],

That's the reason I need a field to indicate how many ll_region_w
actually initialized.

old wr_ch_cnt just plays the same role.

>
> -Sergey
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > new patch at v4
> >
> >  drivers/dma/dw-edma/dw-edma-core.c |  4 ++--
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
> >  include/linux/dma/edma.h           |  8 ++++----
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 1abf41d49f75b..66dc650577919 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -918,11 +918,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >       raw_spin_lock_init(&dw->lock);
> >
> >
> > -     dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
> > +     dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> >                             dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
> >       dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> >
> > -     dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
> > +     dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> >                             dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> >       dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index ae42bad24dd5a..7732537f96086 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -230,14 +230,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       chip->nr_irqs = nr_irqs;
> >       chip->ops = &dw_edma_pcie_core_ops;
> >
> > -     chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
> > -     chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
> > +     chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
> > +     chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
> >
> >       chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> >       if (!chip->reg_base)
> >               return -ENOMEM;
> >
> > -     for (i = 0; i < chip->wr_ch_cnt; i++) {
> > +     for (i = 0; i < chip->ll_wr_cnt; i++) {
> >               struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> >               struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> >               struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
> > @@ -262,7 +262,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >               dt_region->sz = dt_block->sz;
> >       }
> >
> > -     for (i = 0; i < chip->rd_ch_cnt; i++) {
> > +     for (i = 0; i < chip->ll_rd_cnt; i++) {
> >               struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> >               struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> >               struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
> > @@ -302,7 +302,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >               chip->reg_base);
> >
> >
> > -     for (i = 0; i < chip->wr_ch_cnt; i++) {
> > +     for (i = 0; i < chip->ll_wr_cnt; i++) {
> >               pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> >                       i, vsec_data.ll_wr[i].bar,
> >                       vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> > @@ -314,7 +314,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                       chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
> >       }
> >
> > -     for (i = 0; i < chip->rd_ch_cnt; i++) {
> > +     for (i = 0; i < chip->ll_rd_cnt; i++) {
> >               pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> >                       i, vsec_data.ll_rd[i].bar,
> >                       vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index e9ce652b88233..c2039246fc08c 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -40,8 +40,8 @@ enum dw_edma_map_format {
> >   * @nr_irqs:          total dma irq number
> >   * @ops                       DMA channel to IRQ number mapping
> >   * @reg_base          DMA register base address
> > - * @wr_ch_cnt                 DMA write channel number
> > - * @rd_ch_cnt                 DMA read channel number
> > + * @ll_wr_cnt                 DMA write link list number
> > + * @ll_rd_cnt                 DMA read link list number
> >   * @rg_region                 DMA register region
> >   * @ll_region_wr      DMA descriptor link list memory for write channel
> >   * @ll_region_rd      DMA descriptor link list memory for read channel
> > @@ -56,8 +56,8 @@ struct dw_edma_chip {
> >
> >       void __iomem            *reg_base;
> >
> > -     u16                     wr_ch_cnt;
> > -     u16                     rd_ch_cnt;
> > +     u16                     ll_wr_cnt;
> > +     u16                     ll_rd_cnt;
> >       /* link list address */
> >       struct dw_edma_region   ll_region_wr[EDMA_MAX_WR_CH];
> >       struct dw_edma_region   ll_region_rd[EDMA_MAX_RD_CH];
> > --
> > 2.24.0.rc1
> >
