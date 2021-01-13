Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BBA2F4BFE
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAMNGU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 08:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbhAMNGU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jan 2021 08:06:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D2EC061575;
        Wed, 13 Jan 2021 05:05:39 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so1178269pfm.6;
        Wed, 13 Jan 2021 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVJs+wfp4qreGTLYzgt4gXDakLeTUHDUIVeds1NEB3w=;
        b=Q603ItwbofIDv0BZdc0l/fkr0heq3s6JMUNYsCKrXLGNOwpfASDzD0aOEo6EOcqcN/
         yApmddQBQh952j8W9gTxwosqY49Ch6DnCSoftFF2uFDMpND0UkAbu0NlXNSdoomGZVMB
         I/+13VBhsQTHaz6rfN6o5VZUAfV/e/fPkxCnvM2MXqxqwMuVSPUDE4UlP2ADrmd0766n
         MYRzd2n3ULDqL+H/qCZgjOjEjDI17pMmZH0WDsynKMAEdysHufuBUaEnZ0cG9WdRKrmU
         gPZgIQb3FqE5gKGLSYLThp9qOlzLRBIZlX+z3rVH6uX7DDWMAVv8sfqZ/tAO8BXTKK6f
         PjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVJs+wfp4qreGTLYzgt4gXDakLeTUHDUIVeds1NEB3w=;
        b=pAxusdDDzYMCKyZxrrT08z6xaoDSIBaFbvBa90Sf1OZ7gnr2+ovvX21zr0folPjHjn
         qDszubeEOH7PUgEehxxsxCPaeGpqmlso36Z2CHhhRZf1FxJE9Y7fNHOFTU62iVU3qof7
         +eBtkvNofSlnR+pVNISBgvtEzs+txviM3xDm0+MiB9mO+YTVVw/BX+Kazq6o6bSi064Q
         gNsm6GthlmkPUafgHFjsNDTFhytqnI5KXPnIoNnRj4VAixpc+RFMby8zpYazbP95gKM3
         bHC18JQhT/f4cM8FaJlc61NUYB6OieQyV3K4s9t74wavMDLTjX4sVlVk699NwZCC5UBq
         aOhg==
X-Gm-Message-State: AOAM531Tro4LaZt5unvnHcaM4S6VPaDFwPiM/KfKNlqEnLtODlyGn3eC
        b6ttOXP6tPt2Yd1OwgVJsqB+FbgoY9Ji0nnousY=
X-Google-Smtp-Source: ABdhPJy8RRQw2FZhD1iGuFKtD3o12SiBXCQ5m32xkaCAoscgSF+q0Z8Yv/ePpmOKrfck14S7L7Wzwnrk+5DNSUl49/w=
X-Received: by 2002:a63:c04b:: with SMTP id z11mr2029372pgi.74.1610543139443;
 Wed, 13 Jan 2021 05:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20210112223749.97036-1-ftoth@exalondelft.nl>
In-Reply-To: <20210112223749.97036-1-ftoth@exalondelft.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jan 2021 15:05:23 +0200
Message-ID: <CAHp75VfLOcMxUCU7urFi0Kz6RS4FNLA2y9T0rK_5Y0g8+UrE0w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hsu_dma_pci: disable spurious interrupt
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 13, 2021 at 5:23 AM Ferry Toth <ftoth@exalondelft.nl> wrote:
>
> On Intel Tangier B0 and Anniedale the interrupt line, disregarding
> to have different numbers, is shared between HSU DMA and UART IPs.
> Thus on such SoCs we are expecting that IRQ handler is called in
> UART driver only. hsu_pci_irq was handling the spurious interrupt

hsu_pci_irq()

> from HSU DMA by returning immediately. This wastes CPU time and
> since HSU DMA and HSU UART interrupt occur simultaneously they race
> to be handled causing delay to the HSU UART interrupt handling.
> Fix this by disabling the interrupt entirely.

Title should be "dmaengine: hsu: ..."

After addressing above
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Fixes: 4831e0d9054c ("serial: 8250_mid: handle interrupt correctly in DMA case")
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> ---
>  drivers/dma/hsu/pci.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
> index 07cc7320a614..9045a6f7f589 100644
> --- a/drivers/dma/hsu/pci.c
> +++ b/drivers/dma/hsu/pci.c
> @@ -26,22 +26,12 @@
>  static irqreturn_t hsu_pci_irq(int irq, void *dev)
>  {
>         struct hsu_dma_chip *chip = dev;
> -       struct pci_dev *pdev = to_pci_dev(chip->dev);
>         u32 dmaisr;
>         u32 status;
>         unsigned short i;
>         int ret = 0;
>         int err;
>
> -       /*
> -        * On Intel Tangier B0 and Anniedale the interrupt line, disregarding
> -        * to have different numbers, is shared between HSU DMA and UART IPs.
> -        * Thus on such SoCs we are expecting that IRQ handler is called in
> -        * UART driver only.
> -        */
> -       if (pdev->device == PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA)
> -               return IRQ_HANDLED;
> -
>         dmaisr = readl(chip->regs + HSU_PCI_DMAISR);
>         for (i = 0; i < chip->hsu->nr_channels; i++) {
>                 if (dmaisr & 0x1) {
> @@ -105,6 +95,17 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (ret)
>                 goto err_register_irq;
>
> +       /*
> +        * On Intel Tangier B0 and Anniedale the interrupt line, disregarding
> +        * to have different numbers, is shared between HSU DMA and UART IPs.
> +        * Thus on such SoCs we are expecting that IRQ handler is called in
> +        * UART driver only. Instead of handling the spurious interrupt
> +        * from HSU DMA here and waste CPU time and delay HSU UART interrupt
> +        * handling, disable the interrupt entirely.
> +        */
> +       if (pdev->device == PCI_DEVICE_ID_INTEL_MRFLD_HSU_DMA)
> +               disable_irq_nosync(chip->irq);
> +
>         pci_set_drvdata(pdev, chip);
>
>         return 0;
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
