Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677431B613D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgDWQrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729707AbgDWQrW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Apr 2020 12:47:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8418C09B043
        for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2020 09:47:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so5302340lfe.4
        for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2020 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRcc4dh6p+YiX6AX0x9LFumoCa/KOTeSvRHxboIV+LM=;
        b=j7pfI9HRuHbfl6xDZAoT1l4rmuUPF/dN6vFtceByAi7aVXx7F1IhQrRueEZwe2jLz1
         LPlirCZaXLDgzEX7pBzBcH8BRbSUtwv0Fr/Xr7mNnYMI5n+kQPaevi4KoW9j2YpIE//B
         4gbwSpLKTsk8a6DjpzFLCRYnmZfFffJuXd7sHUWBrzm2DdCAF+LnMir8CtAVeZNUPhEU
         o5wYq8dSbv5PpSnJvBS+3XV8BSWMUTvt8MM/+jOXHe9XtwOMnpE3dECt2rI/zXksJFfP
         1kIeQP0cTexZxF2UhgelMN3dbj6HEeRfpwsJgbRgWYigveFkQHwaL2ZSdpLI9edvCOU1
         jdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRcc4dh6p+YiX6AX0x9LFumoCa/KOTeSvRHxboIV+LM=;
        b=VjhxT4dilt5OtmfXRhDk+PfEMygPyJQnjOZMzZLBJ52FSlgGAJ7UDv2sfGEeOE1bOY
         JGp7nQAaila3hRfOUOAr00toJM1TrvrZslwuew5ROsh8XGEio6OaIoH2BHOxr9ubfL6n
         32g/LmyqLQHA3W1gXYna313KKUWGJwqJQUtp8RqjqjbfaANOlXBX+Lq8GwZxmFMmXKCS
         BTPllBYlqSUE7zP/RrkORdLtPjzLqUdr8OXiTb0ylE28XeBcxC35GMr945cvxdrPVVQY
         2tPUjst/GfElxuVlRUZFR/wXIlt9WX+/QzZb3bIy00Cl9iAhvkGwC3GaNTgsas5xg1AF
         E7+Q==
X-Gm-Message-State: AGi0PuabehGzhUC8o8AH8L3yLcCBWPHOIRMeGbeOiHJ1rQJnjnlP79hr
        q02f86/BGD46L/QqGN40Qnq/Ky+3PWIiBnnlqNWX/g==
X-Google-Smtp-Source: APiQypKp4PYv8DT/PLr79QV23nUX9UW1aERR5j0Oo8O7FXjU4ESHU6c7LwMtVWsMkh3FTpEclvzAGKWNG5gZgbFgNds=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr2882072lfy.171.1587660440070;
 Thu, 23 Apr 2020 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <1587607101-31914-1-git-send-email-alan.mikhak@sifive.com> <DM5PR12MB1276642553DDD5AF85B65E01DAD30@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1276642553DDD5AF85B65E01DAD30@DM5PR12MB1276.namprd12.prod.outlook.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Thu, 23 Apr 2020 09:47:08 -0700
Message-ID: <CABEDWGw4CYgQ9uiaig+C9UifSz24W7oOiVva+G0zbBXitcMtPg@mail.gmail.com>
Subject: Re: [PATCH v2][next] dmaengine: dw-edma: Check MSI descriptor before copying
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "maz@kernel.org" <maz@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 23, 2020 at 2:28 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> On Thu, Apr 23, 2020 at 2:58:21, Alan Mikhak <alan.mikhak@sifive.com>
> wrote:
>
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >
> > Modify dw_edma_irq_request() to check if a struct msi_desc entry exists
> > before copying the contents of its struct msi_msg pointer.
> >
> > Without this sanity check, __get_cached_msi_msg() crashes when invoked by
> > dw_edma_irq_request() running on a Linux-based PCIe endpoint device. MSI
> > interrupt are not received by PCIe endpoint devices. If irq_get_msi_desc()
> > returns null, then there is no cached struct msi_msg to be copied.
> >
> > This patch depends on the following patch:
> > [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
> > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11491757/__;!!A4F2R9G_pg!L_vf_Tml7Ca4sWVvZp5crRCp7YsMj6B93G9cMAO8Dj3w9I0MArjwuwNKtDz9rr0RlpXiqPg$
> >
> > Rebased on linux-next which has above patch applied.
> >
> > Fixes: Build error with config x86_64-randconfig-f003-20200422
> > Fixes: Build error with config s390-allmodconfig
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index db401eb11322..306ab50462be 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/irq.h>
> >  #include <linux/dma/edma.h>
> >  #include <linux/dma-mapping.h>
> >
> > @@ -773,6 +774,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >       u32 rd_mask = 1;
> >       int i, err = 0;
> >       u32 ch_cnt;
> > +     int irq;
> >
> >       ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
> >
> > @@ -781,16 +783,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >
> >       if (dw->nr_irqs == 1) {
> >               /* Common IRQ shared among all channels */
> > -             err = request_irq(dw->ops->irq_vector(dev, 0),
> > -                               dw_edma_interrupt_common,
> > +             irq = dw->ops->irq_vector(dev, 0);
> > +             err = request_irq(irq, dw_edma_interrupt_common,
> >                                 IRQF_SHARED, dw->name, &dw->irq[0]);
> >               if (err) {
> >                       dw->nr_irqs = 0;
> >                       return err;
> >               }
> >
> > -             get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
> > -                                &dw->irq[0].msi);
> > +             if (irq_get_msi_desc(irq))
> > +                     get_cached_msi_msg(irq, &dw->irq[0].msi);
> >       } else {
> >               /* Distribute IRQs equally among all channels */
> >               int tmp = dw->nr_irqs;
> > @@ -804,7 +806,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >               dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> >
> >               for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> > -                     err = request_irq(dw->ops->irq_vector(dev, i),
> > +                     irq = dw->ops->irq_vector(dev, i);
> > +                     err = request_irq(irq,
> >                                         i < *wr_alloc ?
> >                                               dw_edma_interrupt_write :
> >                                               dw_edma_interrupt_read,
> > @@ -815,8 +818,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
> >                               return err;
> >                       }
> >
> > -                     get_cached_msi_msg(dw->ops->irq_vector(dev, i),
> > -                                        &dw->irq[i].msi);
> > +                     if (irq_get_msi_desc(irq))
> > +                             get_cached_msi_msg(irq, &dw->irq[i].msi);
> >               }
> >
> >               dw->nr_irqs = i;
> > --
> > 2.7.4
>
>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Thanks Gustavo for the Ack.

FYI, I first considered adding an ops function to decouple dw-edma-core.c
from struct msi_msg. However, in a separate use case that I have in mind,
dw-edma would run on a host system having Synopsys DesignWare PCI eDMA
hardware on the host-side. In this use case, the host system eDMA engines
may be used in conjunction with an endpoint device also having the same
eDMA hardware. In this use case, dw-edma running on the host would need
to call get_cached_msi_msg() just in case the host has an msi_msg cached
from the endpoint device. As a result, I opted to not add a new ops
function.

Regards,
Alan

>
>
