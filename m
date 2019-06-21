Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D474F4E268
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFUIzc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 04:55:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38323 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFUIzc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 04:55:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so6153645qtl.5;
        Fri, 21 Jun 2019 01:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KofcWutPGQM8+34UtXSZlF1xvjBdqL2eWlVqOVnyu54=;
        b=kVKIFhdLVFPw1qZr8sdwB4CteyNvJ8vT1uWfa/zcwiv/CcSqF7vGjfWQ+L1N2P28sD
         DQT+ANnQa570nOH148M5oVTtWJuVxO/Io2XAiSgvNqNW5PZz7PSxln9kxhv/b7k4AHMO
         XZ/6jJxf+mrGQGoqpkYy+vVng809lDwCM2ktdRnPAe7yn+MeCbRU87F4thUUebQo49Y2
         2sWr4dmCA/T8/gWQWt8yCYlMEwD025t31zyI8LbDQlf/85DJx6c3h10nw9y/GWxkRHTL
         iAONBu9kZXadwU209jP3IrunqtZNQtIlKvIY6f5ouFFA5p+JSLak5MRMagA14zxZVRyF
         arQA==
X-Gm-Message-State: APjAAAW+LZVoZ8s9uNZ0lRxxMrXvyQB3pAJMv34wn2n3zHzx7Fc4MLox
        8BcSzyVsB3OQcAknYB0Ew8OQ2LXOmRjLrzd0zNQ=
X-Google-Smtp-Source: APXvYqy0vVVQU67T/bPkca9zWXzxraVmkuqvPnpt4wR0pGGSejei60Is5RxpZ7qrwDHxKZo6LygqfpL5qQK7uNt/KUc=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr38030947qtb.142.1561107330816;
 Fri, 21 Jun 2019 01:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131820.2470686-1-arnd@arndb.de> <DM6PR12MB40101798EDD46EF4B8E0E0E1DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40101798EDD46EF4B8E0E0E1DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 10:55:11 +0200
Message-ID: <CAK8P3a0wvfJnYv3K232G87i5YCo+3dxw9GuL-x6YcuxnzREbfA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: dw-edma: fix endianess confusion
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 21, 2019 at 10:42 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
> On Mon, Jun 17, 2019 at 14:17:47, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > When building with 'make C=1', sparse reports an endianess bug:
>
> I didn't know that option.
>
> >
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:60:30: warning: cast removes address space of expression
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type in argument 1 (different address spaces)
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const volatile [noderef] <asn:2>*addr
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] ptr
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type in argument 1 (different address spaces)
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const volatile [noderef] <asn:2>*addr
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] ptr
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type in argument 1 (different address spaces)
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const volatile [noderef] <asn:2>*addr
> > drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] ptr
> >
> > The current code is clearly wrong, as it passes an endian-swapped word
> > into a register function where it gets swapped again. I assume that this
>
> Sorry I didn't catch this, endianness-swapped word into a register
> function where it gets swapped again?
> Where?

See dw_edma_v0_core_write_chunk()

                sar = cpu_to_le64(child->sar);
                SET_LL(&lli[i].sar_low, lower_32_bits(sar));
                SET_LL(&lli[i].sar_high, upper_32_bits(sar));

SET_LL() expands to writel(), which does a cpu_to_le32() swap.
(the swap  gets left out on architectures that are little-endian only)

> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 97e3fd41c8a8..d670ebcc37b3 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -195,7 +195,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >       struct dw_edma_v0_lli __iomem *lli;
> >       struct dw_edma_v0_llp __iomem *llp;
> >       u32 control = 0, i = 0;
> > -     u64 sar, dar, addr;
> > +     uintptr_t sar, dar, addr;
>
> Will this type assure variables sar, dar and addr are 64 bits?

No, just as long as a pointer. I somehow misread these as
referring to a kernel pointer, but got that part wrong. The
local variables can just be dropped then, just use
lower_32_bits(child->sar)) etc.

> >       int j;
> >
> >       lli = chunk->ll_region.vaddr;
> > @@ -214,11 +214,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >               /* Transfer size */
> >               SET_LL(&lli[i].transfer_size, child->sz);
> >               /* SAR - low, high */
> > -             sar = cpu_to_le64(child->sar);
> > +             sar = (uintptr_t)child->sar;
>
> Assuming the host is a big-endian machine and the eDMA on the endpoint
> strictly requires the address to be little endian.
> By not using cpu_to_le64(), the address to be written on the eDMA will be
> in big-endian format, right? If so, that will break the driver.

No, because of the double-swap you are writing a big-endian address
here, which is the bug I am referring to.

     Arnd
