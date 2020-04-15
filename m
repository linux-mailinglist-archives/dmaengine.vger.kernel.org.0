Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204651AB114
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441616AbgDOTJv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441608AbgDOTJq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 15:09:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F33C061A0F
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 12:02:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q22so4979359ljg.0
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PAL4FT8oI0mRZyF3YfLl8XwS0XvdpC5f2FhsnqKXQQ4=;
        b=GSqy2qK9ju2LPM8Q8WZSWDGak8bYygVT0fC/+xYkRBU8FR41raa0/9NdjN4NtbABLs
         nkUhwBBBputEWOf6wDfR8p7bgjYOoTEH+VVO0mf44Xp2Tt/mYkTtmDPEx/QX7YAQMywF
         V+ktG+8DRhYB4b+7AC5/0vpih7661me0Do1Vk/XJDycKxyYey6D9xuRkIQPS3Tiz1cKD
         d45kVCmQ40qJnCgsNgIQP+2FW2+dhl/n+GO4EJV7E55XK+mitMnkyGV0YT7QNVLLDLMg
         55eReRmR8eQUO3f7OcRFJ8lGLUCORi+WE4IolpIdsYyqZTH+a1iUrsNAObCyeKicfy2D
         Z8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PAL4FT8oI0mRZyF3YfLl8XwS0XvdpC5f2FhsnqKXQQ4=;
        b=M0rNWJZgG0U0p39inLCxej7LeSAZeD/sU23pwN+tbBWO1l52VsST7iKGVUqILClaOJ
         VsnHgwhd6ETWO+ZOqiKWkSrGNzSyPROaQbKz5xBoEVOeX9Hp5aUrZe7mPUzL5BVeTxLy
         w9eZy+gLDJSZSzQPriFJ00XFmjjPZYJlTUKXLTss6ITx6EsjWigcBCA3A25/w00zDYB/
         Vnf/wbexBOIDoAPrVtmz+WsVLa06zjSNuSDNU2SaL7U5A9Tz1vUMYAY54/IYHAlamZ/A
         t4Z5ZlXcQschttYonAA8QqBwqWRZ1pSVt36mwbGXu4VWUu0qCpmrMRFhuE6eS2IRmz5D
         i1XQ==
X-Gm-Message-State: AGi0PuZsE1GiaFjeo3knXlnpK7bGq1ZsPFStF5T08FPKyrBNHDmwcjsB
        sXEUTV1P/ypWipef7Bko5pkjLdGeDzoW8w1+2MsEXAnF2PE=
X-Google-Smtp-Source: APiQypLumLCXkKPV4iM2+8piZqvGIxHqHDB8sAtt+cxtBV34gvyU5kEIQvKGwzcEjcI1gDpFBh1ntrKOLCbpxb8QW94=
X-Received: by 2002:a2e:a548:: with SMTP id e8mr4133522ljn.151.1586977360244;
 Wed, 15 Apr 2020 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 15 Apr 2020 12:02:29 -0700
Message-ID: <CABEDWGza3WXzFJ5cP_v9yKT+F=iYzDyuxf-N=0_v=5wrbdz2AA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        dan.j.williams@intel.com, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 15, 2020 at 10:27 AM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> From: Alan Mikhak <alan.mikhak@sifive.com>
>
> Decouple dw-edma-core.c from struct pci_dev as a step toward integration
> of dw-edma with pci-epf-test so the latter can initiate dma operations
> locally from the endpoint side. A barrier to such integration is the
> dependency of dw_edma_probe() and other functions in dw-edma-core.c on
> struct pci_dev.
>
> The Synopsys DesignWare dw-edma driver was designed to run on host side
> of PCIe link to initiate DMA operations remotely using eDMA channels of
> PCIe controller on the endpoint side. This can be inferred from seeing
> that dw-edma uses struct pci_dev and accesses hardware registers of dma
> channels across the bus using BAR0 and BAR2.
>
> The ops field of struct dw_edma in dw-edma-core.h is currenty undefined:
>
> const struct dw_edma_core_ops   *ops;
>
> However, the kernel builds without failure even when dw-edma driver is
> enabled. Instead of removing the currently undefined and usued ops field,
> define struct dw_edma_core_ops and use the ops field to decouple
> dw-edma-core.c from struct pci_dev.
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>

Adding the ACK from RFC patch

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 29 ++++++++++++++++++++---------
>  drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c | 10 ++++++++++
>  3 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index ff392c01bad1..db401eb11322 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -14,7 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/dma/edma.h>
> -#include <linux/pci.h>
> +#include <linux/dma-mapping.h>
>
>  #include "dw-edma-core.h"
>  #include "dw-edma-v0-core.h"
> @@ -781,7 +781,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>
>         if (dw->nr_irqs == 1) {
>                 /* Common IRQ shared among all channels */
> -               err = request_irq(pci_irq_vector(to_pci_dev(dev), 0),
> +               err = request_irq(dw->ops->irq_vector(dev, 0),
>                                   dw_edma_interrupt_common,
>                                   IRQF_SHARED, dw->name, &dw->irq[0]);
>                 if (err) {
> @@ -789,7 +789,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>                         return err;
>                 }
>
> -               get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
> +               get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
>                                    &dw->irq[0].msi);
>         } else {
>                 /* Distribute IRQs equally among all channels */
> @@ -804,7 +804,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>                 dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
>
>                 for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> -                       err = request_irq(pci_irq_vector(to_pci_dev(dev), i),
> +                       err = request_irq(dw->ops->irq_vector(dev, i),
>                                           i < *wr_alloc ?
>                                                 dw_edma_interrupt_write :
>                                                 dw_edma_interrupt_read,
> @@ -815,7 +815,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>                                 return err;
>                         }
>
> -                       get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
> +                       get_cached_msi_msg(dw->ops->irq_vector(dev, i),
>                                            &dw->irq[i].msi);
>                 }
>
> @@ -827,12 +827,23 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
>
>  int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> -       struct device *dev = chip->dev;
> -       struct dw_edma *dw = chip->dw;
> +       struct device *dev;
> +       struct dw_edma *dw;
>         u32 wr_alloc = 0;
>         u32 rd_alloc = 0;
>         int i, err;
>
> +       if (!chip)
> +               return -EINVAL;
> +
> +       dev = chip->dev;
> +       if (!dev)
> +               return -EINVAL;
> +
> +       dw = chip->dw;
> +       if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
> +               return -EINVAL;
> +
>         raw_spin_lock_init(&dw->lock);
>
>         /* Find out how many write channels are supported by hardware */
> @@ -884,7 +895,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>
>  err_irq_free:
>         for (i = (dw->nr_irqs - 1); i >= 0; i--)
> -               free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> +               free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
>
>         dw->nr_irqs = 0;
>
> @@ -904,7 +915,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>
>         /* Free irqs */
>         for (i = (dw->nr_irqs - 1); i >= 0; i--)
> -               free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> +               free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
>
>         /* Power management */
>         pm_runtime_disable(dev);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 4e5f9f6e901b..31fc50d31792 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -103,6 +103,10 @@ struct dw_edma_irq {
>         struct dw_edma                  *dw;
>  };
>
> +struct dw_edma_core_ops {
> +       int     (*irq_vector)(struct device *dev, unsigned int nr);
> +};
> +
>  struct dw_edma {
>         char                            name[20];
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index dc85f55e1bb8..1eafc602e17e 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -54,6 +54,15 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>         .irqs                           = 1,
>  };
>
> +static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> +{
> +       return pci_irq_vector(to_pci_dev(dev), nr);
> +}
> +
> +static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> +       .irq_vector = dw_edma_pcie_irq_vector,
> +};
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>                               const struct pci_device_id *pid)
>  {
> @@ -151,6 +160,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>         dw->version = pdata->version;
>         dw->mode = pdata->mode;
>         dw->nr_irqs = nr_irqs;
> +       dw->ops = &dw_edma_pcie_core_ops;
>
>         /* Debug info */
>         pci_dbg(pdev, "Version:\t%u\n", dw->version);
> --
> 2.7.4
>
