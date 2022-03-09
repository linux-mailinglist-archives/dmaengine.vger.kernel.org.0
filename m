Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEA4D35E8
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 18:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiCIReq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 12:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiCIRep (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 12:34:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59930104580;
        Wed,  9 Mar 2022 09:33:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qa43so6596641ejc.12;
        Wed, 09 Mar 2022 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUzqK6hXawtvGMITlMc29fby7iqS7nO8v68mjfPlaQw=;
        b=peKfUZ+F1hK+5+uYb3BrKm+R2+qKCdsescJNX50/ebdaS0lfEk5pxuvv4ft/YbvKHp
         ddOSDC18I+22mCZsORuhL4ok/jB/18A+XRzV16YEDg8P/Sgb8gTMlW3ohVwQmfr8Dogh
         wvbK4hPJx0eupIILITUwFVlWMjRXl9VPBvDbFCLr4kc40Okv2fxxDUFozp7bUU7YMl1P
         D9iErrOJkiLIm9BQqKArvmyMlCXRurtaODgKdYgEc+wDdkKkUdTH1N5ez9Bq9AXCoP2g
         6Ae/RUSq3Ifu6iBQmUU624zb+mK0FiC+1ohSwG/yGK/VnUC4BCEaTjMlPYmznpqmZEo2
         D9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUzqK6hXawtvGMITlMc29fby7iqS7nO8v68mjfPlaQw=;
        b=uki9WbqeUV19ye10DEd6BJQfQY2bpQOtozv6HmtbdFF5Jen/k/t6BuV6d/ecedkidD
         3EmcDaZUM/vjjB77y8DaiF9IJexFu5rjMSW3aLof2SnkV4/oZH2knHxkqsFWX8zPp7vK
         4AKi38SdTnE+hjXAnU2vW7Ag15xOuilnAFPAeFi+nQqKrByTEQkHXAXZrbzPPmpwrcBQ
         +exeTNNqhc2pqxOoSC/tSMuV1VbcOs9tP6/z2JFyXtFqBj0jxAIPdzTORT+KyEKJYLcC
         OEbKWqcrOMNg7/19fpos6kxOcNW+MMHOMbhkCfyFiB69SYDe6rt1bfrBF5pEXBnHZCZA
         0RNA==
X-Gm-Message-State: AOAM533Gle78VciH01rNC84Oppc0G/kIQQBZtEdS1wjmUyuMczyo4fgi
        LDiXCwOdhY4FKpYFGigXrZV7yt6XvWO8LVGv1BR5c+RsCs+3dw==
X-Google-Smtp-Source: ABdhPJzD0z0xB05Iefz+GPIy2sVDUSVlJk2Sc73LS7sPzXqEJwxtTKoQEChie4UdM6iNUv6i1zF/RQUcHs3V7nHVcik=
X-Received: by 2002:a17:906:1e42:b0:6d6:df12:7f8d with SMTP id
 i2-20020a1709061e4200b006d6df127f8dmr806754ejj.15.1646847223501; Wed, 09 Mar
 2022 09:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20220307224750.18055-1-Frank.Li@nxp.com> <20220307224750.18055-2-Frank.Li@nxp.com>
 <20220309172506.wdqfx2ds5snmpmt7@mobilestation>
In-Reply-To: <20220309172506.wdqfx2ds5snmpmt7@mobilestation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 9 Mar 2022 11:33:32 -0600
Message-ID: <CAHrpEqT3ggemtnNnj8oaEpDG+yNxEd9xRNzJLOvoELeO_UnLqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dmaengine: dw-edma-pcie: don't touch internal
 struct dw_edma
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
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

On Wed, Mar 9, 2022 at 11:25 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Mon, Mar 07, 2022 at 04:47:46PM -0600, Frank Li wrote:
> > "struct dw_edma" is an internal structure of the eDMA core. This should not be
> > used by the eDMA controllers like "dw-edma-pcie" for passing the controller
> > specific information to the core.
> >
> > Instead, use the fields local to the "struct dw_edma_chip" for passing the
> > controller specific info to the core.
>
> Hmm, I've got a feeling that without this patch the kernel won't be
> even buildable. Am I right? If so, it must be fixed. As I see it,
> you'll need to merge this change into the "[PATCH vX 1/6] dmaengine:
> dw-edma: fix dw_edma_probe() can't be call globally" patch. Thus
> you'll have a coherent modification, which will leave the kernel
> buildable and hopefully problemlessly runnable.

Patch https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#mbc75cc69c9a7d4bddb821394e2ac9291861b6628.c
Fixed  dw-edma-pcie.c build problem.

Do you want to combine it into one patch?

>
> BTW I would have changed the patch title anyway: "[PATCH vX 1/6]
> dmaengine: dw-edma: fix dw_edma_probe() can't be call globally". It
> doesn't really explains the modification it self, but the purpose why
> you need to do what you did. Something like: "[PATCH vX 1/6]
> dmaengine: dw-edma: Detach the private data and chip info structures"

>
> -Sergey
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Resend added dmaengine@vger.kernel.org
> >
> > Change from v2 to v3:
> >  None
> >
> > Change from v1 to v2:
> >  - rework commit message
> >  - rg_region only use virtual address. using chip->reg_base instead
> >
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 83 ++++++++++++------------------
> >  1 file changed, 34 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 44f6e09bdb531..7732537f96086 100644
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
>
> > +     chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
> > +     chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
>
> Please see my comment to the previous patch regarding these fields
> naming.
>
> >
> > -     dw->rg_region.vaddr += vsec_data.rg.off;
> > -     dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
> > -     dw->rg_region.paddr += vsec_data.rg.off;
> > -     dw->rg_region.sz = vsec_data.rg.sz;
>
> > +     chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
>
> Please see my comment to the previous patch regarding the reg_base
> field introduction. See you've dropped rg_region from the dw_edma
> structure in the previous patch, while it's left being used in the
> dw-edma-pcie driver. Thus the kernel will fail to build this driver
> for sure.
>
> -Sergey
>
> > +     if (!chip->reg_base)
> > +             return -ENOMEM;
> >
> > -     for (i = 0; i < dw->wr_ch_cnt; i++) {
> > -             struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
> > -             struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
> > +     for (i = 0; i < chip->ll_wr_cnt; i++) {
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
> > +     for (i = 0; i < chip->ll_rd_cnt; i++) {
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
> > +             chip->reg_base);
> >
> >
> > -     for (i = 0; i < dw->wr_ch_cnt; i++) {
> > +     for (i = 0; i < chip->ll_wr_cnt; i++) {
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
> > +     for (i = 0; i < chip->ll_rd_cnt; i++) {
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
> > --
> > 2.24.0.rc1
> >
