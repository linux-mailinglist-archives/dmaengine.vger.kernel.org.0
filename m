Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2A1AAF79
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410960AbgDORYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410957AbgDORYg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 13:24:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE2C061A0C
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 10:24:35 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so3305461lfc.0
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzSrcTTUqeoY62i4J1mjiP7l96KU8srXilqydnIieMw=;
        b=LsL/Pmp6QjNEMTOmbK4hXkJQq1MXL/X3coHxqtSzTnMwY8CBIFWwecpQTj8Aa/Y2nm
         HXZUL7LaHaDWToozWEBYqdfIHtJMcVOgjpc/B4S9mJ0WsnrpsOgqC3Ycyp5QopluTySx
         eONN7k3kJ/SBQKRhxh+QRUWWfsLDM2xvK1j6w5uYAc00JZgz4QQkNACFa19BBoyk/52k
         ye8zSvTdCgJ0JavKWhj097J/l+k8ZLqXeeL8PrJ+7WesiZHe3+xojJoRsuTKcgFb0pQB
         WikS7LoozINvaMqWs/HVLlNztYhJHYEIMkm+viwOsPxfG8CSgqOk5ic76Rlu2h3bvkiO
         cS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzSrcTTUqeoY62i4J1mjiP7l96KU8srXilqydnIieMw=;
        b=BGrlvtpCTBINHuKNCjpiRy2q+wLpVe3+JZXOLM6p9nYHcx81idqA7Rwwk0a6ucJYtO
         nMN4I1PfhIzlMnD2wawpjc/ib7lrQ0dhchS3eUf5WPf+TkNykp/1Iw2qDHcJMh9WvnlJ
         HsWHVaZOGzsiM+NlOVAKeTVGVpiU14U1H/42hs9PCNCuSAvBy8Zq7TaeKeoZmNETKNpe
         eqo0tFTpii2lA9wTZQM1Pjk8Ggv2zM/6VeiocPEYAqmux8XcvwCd4fQPDn6Vw2/21tKo
         jhuk2ztkm4GoCuTSQj5IpZmT9z6c7EwoSlC1D/qHuvzQVjLAnmyPmYXMBDhh8exfVwgg
         DPVA==
X-Gm-Message-State: AGi0PuZWL/D6wQrirUXGXbsU6u1mC1V/wWa45V37gT2akH+nvFZrXBAu
        cxg47xi762fEng0iKZtUqOFvyNL57CWf4w7xYYwdUw==
X-Google-Smtp-Source: APiQypISs/FNWs18LwWUrV/trZVCnKxXVyMZ7glhu+lx18t4xKDgxOhBgHZsI39yf8ey6jtp34Ot9/xs2ui2zJWC+qw=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr3540660lfg.49.1586971474025;
 Wed, 15 Apr 2020 10:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com> <DM5PR12MB1276CB8FA4457D4CDCE3137EDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1276CB8FA4457D4CDCE3137EDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 15 Apr 2020 10:24:22 -0700
Message-ID: <CABEDWGwYmO52g6cqvQdWb6HXWEHaMA1rcf96aUqv0f32tJZT-g@mail.gmail.com>
Subject: Re: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 15, 2020 at 5:13 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> Hi Alan,

Hi Gustavo,

Thank you for all your comments and feedback.

>
> On Wed, Apr 15, 2020 at 3:7:44, Alan Mikhak <alan.mikhak@sifive.com>
> wrote:
>
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > While reviewing the Synopsys Designware eDMA PCIe driver, I came across
>
> s/Designware/DesignWare

Corrected in v2 patch description.

>
> > the following field of struct dw_edma in dw-edma-core.h:
> >
> > const struct dw_edma_core_ops *ops;
> >
> > I was unable to find a definition for struct dw_edma_core_ops. It was
> > surprising that the kernel would build without failure even though the
> > dw-edma driver was enabled with what seems to be an undefined struct.
>
> Initially, that struct was aimed to have a set of function callbacks that
> would allow being set differently according to the eDMA version. At the
> time it was expected to have multiple cores that would need to execute
> different code sequences.
>
> However, this approach was requested to be postponed on the patch review
> because at that time and even now there isn't an extra core that would
> justify this.
>
> You caught some residue of that initial approach.
>
> > The reason I was reviewing the dw-edma driver was to see if I could
> > integrate it with pcitest to initiate dma operations from endpoint side.
>
> Great! That task was on my backlog for a very long time that I wasn't
> able to develop due the lack of time.
>
> > As I understand from reviewing the dw-edma code, it is designed to run
> > on the host side of PCIe link to initiate DMA operations remotely using
> > eDMA channels of PCIe controller on the endpoint side. I am not sure if
> > my understanding is correct. I infer this from seeing that dw-edma uses
> > struct pci_dev and accesses hardware registers of dma channels across the
> > bus using BAR0 and BAR2.
>
> You're correct.
>
> > I was exploring what would need to change in dw-edma to integrate it with
> > pci-epf-test to initiate dma operations locally from the endpoint side.
> > One barrier I see is dw_edma_probe() and other functions in dw-edma-core.c
> > depend on struct pci_dev. Hence, instead of posting a patch to remove the
> > undefined and unused ops field, I would like to define the struct and use
> > it to decouple dw-edma-core.c from struct pci_dev.
> >
> > To my surprise, the kernel still builds without error even after defining
> > struct dw_edma_core_ops in dw-edma-core.h and using it as in this patch.
> >
> > I would appreciate any comments on my observations about the 'ops' field,
> > decoupling dw-edma-core.c from struct pci_dev, and how best to use
> > dw-edma with pcitest.
>
> I like your approach, it separates the PCIe glue logic from the eDMA
> itself.
> I would suggest that pcitest would have multiple options that could be
> triggered, for instance:
>  1 - Execute Endpoint DMA (read/write) remotely with Linked List feature
> (from the Root Complex side)
>  2 - Execute Endpoint DMA (read/write) remotely without Linked List
> feature (from the Root Complex side)
>  3 - Execute Endpoint DMA (read/write) locally with Linked List feature
>  4 - Execute Endpoint DMA (read/write) locally without Linked List
> feature
>

I have all of the above four use cases in mind as well. At the moment,
only #4 is possible with pcitest.

Use case #3 would need a new command line option for pcitest such as -L
to let its user specify linked list operationwhen used with dma in
conjunction with the existing -D option.

Use cases #1 and #2 would need another new command line option such as -R
to specify remotely initiated dma operation in conjunction with -D option.

New code in pci-epf-test and pci_endpoint_test drivers would be needed
to support use cases #1, #2, and #3. However, use case #4 should be
possible without modification to pci-epf-test or pci_endpoint_test as long
as the dmaengine channels become available on the endpoint side.

> Also, don't forget the DMA has of having multiple channels for reading
> and writing (depending on the design) that can be triggered
> simultaneously.
>

At the moment, pci-epf-test grabs the first available dma channel on the
endpoint side and uses it for either read, write, or copy operation. it is not
possible at the moment to specify which dma channel to use on the pcitest
command line. This may be possible by modifying the command line option
-D to also specify the name of one or more dma channels.

Also, pci-epf-test grabs the dma channel at bind time and holds on to it
until unloaded. This denies the use of the dma channel to others on the
endpoint side. However, it seems possible to grab and release the dma
channel only for the duration of each read, write, or copy test. These are
improvements that can come over time. It is great that pci-epf-test was
recently updated to include support for dma operations which makes such
improvements possible.

> Relative to the implementation of the options 3 and 4, I wonder if the
> linked list memory space and size could be set through the DT or by the
> configfs available on the pci-epf-test driver.
>

Although these options could be set through DT or by configfs, another
option is to enable the user of pcitest to specify such parameters on
the command line when invoking each test from the host side.

> >
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 17 ++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 10 ++++++++++
> >  3 files changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index ff392c01bad1..9417a5feabbf 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -14,7 +14,7 @@
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/dma/edma.h>
> > -#include <linux/pci.h>
> > +#include <linux/dma-mapping.h>
> >
> >  #include "dw-edma-core.h"
> >  #include "dw-edma-v0-core.h"
> > @@ -781,7 +781,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >
> >       if (dw->nr_irqs == 1) {
> >               /* Common IRQ shared among all channels */
> > -             err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
> > +             err = request_irq(dw->ops->irq_vector(dev, 0),
> >                                 dw_edma_interrupt_common,
> >                                 IRQF_SHARED, dw->name, &dw->irq[0]);
> >               if (err) {
> > @@ -789,7 +789,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >                       return err;
> >               }
> >
> > -             get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
> > +             get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
> >                                  &dw->irq[0].msi);
> >       } else {
> >               /* Distribute IRQs equally among all channels */
> > @@ -804,7 +804,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >               dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> >
> >               for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> > -                     err = request_irq(pci_irq_vector(to_pci_dev(dev), i),
> > +                     err = request_irq(dw->ops->irq_vector(dev, i),
> >                                         i < *wr_alloc ?
> >                                               dw_edma_interrupt_write :
> >                                               dw_edma_interrupt_read,
> > @@ -815,7 +815,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >                               return err;
> >                       }
> >
> > -                     get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
> > +                     get_cached_msi_msg(dw->ops->irq_vector(dev, i),
> >                                          &dw->irq[i].msi);
> >               }
> >
> > @@ -833,6 +833,9 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >       u32 rd_alloc = 0;
> >       int i, err;
> >
> > +     if (!dw->ops || !dw->ops->irq_vector)
> > +             return -EINVAL;
> > +
>
> I would suggest adding dw pointer check as well.

Thanks for this suggestion. I added the dw pointer check in v2 patch as
well as some others just to make sure. Since dw_edma_probe() is an
EXPORT_SYMBOL, I may call it from my platform_device driver to bring
up dma channels dynamically or based on DT information at kernel boot
time. I added checks to make sure all the required pointers are provided
by the caller.

>
> >       raw_spin_lock_init(&dw->lock);
> >
> >       /* Find out how many write channels are supported by hardware */
> > @@ -884,7 +887,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >
> >  err_irq_free:
> >       for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > -             free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> > +             free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> >
> >       dw->nr_irqs = 0;
> >
> > @@ -904,7 +907,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >
> >       /* Free irqs */
> >       for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > -             free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> > +             free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> >
> >       /* Power management */
> >       pm_runtime_disable(dev);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 4e5f9f6e901b..31fc50d31792 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -103,6 +103,10 @@ struct dw_edma_irq {
> >       struct dw_edma                  *dw;
> >  };
> >
> > +struct dw_edma_core_ops {
> > +     int     (*irq_vector)(struct device *dev, unsigned int nr);
> > +};
> > +
> >  struct dw_edma {
> >       char                            name[20];
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index dc85f55e1bb8..1eafc602e17e 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -54,6 +54,15 @@ static const struct dw_edma_pcie_data snps_edda_data = {
> >       .irqs                           = 1,
> >  };
> >
> > +static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> > +{
> > +     return pci_irq_vector(to_pci_dev(dev), nr);
> > +}
> > +
> > +static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> > +     .irq_vector = dw_edma_pcie_irq_vector,
> > +};
> > +
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)
> >  {
> > @@ -151,6 +160,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >       dw->version = pdata->version;
> >       dw->mode = pdata->mode;
> >       dw->nr_irqs = nr_irqs;
> > +     dw->ops = &dw_edma_pcie_core_ops;
> >
> >       /* Debug info */
> >       pci_dbg(pdev, "Version:\t%u\n", dw->version);
> > --
> > 2.7.4
>
> In overall, nice patch, please fix that detail and I'll give my ACK.

Thanks in advance for your ACK and all the review comments.

>
> Regards,
> Gustavo
