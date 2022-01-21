Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19249582B
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 03:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378470AbiAUCVT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jan 2022 21:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348454AbiAUCVT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jan 2022 21:21:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2569C061574
        for <dmaengine@vger.kernel.org>; Thu, 20 Jan 2022 18:21:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h26so13969146lfv.11
        for <dmaengine@vger.kernel.org>; Thu, 20 Jan 2022 18:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90SUwfZKnXAN2kM8GActo5Koq5JSCVfHKRRzgtkh5Os=;
        b=k41BhGLhKcQl33sjtk33LyRdUWfPbdGkg2+xYsaQP1bZcwv6NvVelCFt09dvXXlM/E
         LR2VgnNKeXQnlubrwXg/fRlKBaiomOtFGb2upZd8Uc3pHkOOy1Nq6dnia7X+Lay85xTM
         GOKJ9KMsNIgvt3VE1PaHwh3vXNUZ8URxwiKJntcFTa60dzZS66aLQEdpup9SAhT24yTj
         UkpmilzA5C9FmX0W2IT1WW5yNuLaTu5hjsIzHhf2scfRXGabfT7astzzgPRRByydQbrQ
         jCSLlqjnLqLipVYhrEqnwiBT3TjRa9iWZxh4oXD7eTX6ysIpjgAVCXQ3E4kJwHfGmwVR
         RR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90SUwfZKnXAN2kM8GActo5Koq5JSCVfHKRRzgtkh5Os=;
        b=gLQVxsQBRZDlNdBpfBDOGbDCXl6pSZXDIWGsSgHjiybCa6POi/SOQ2NEdwq2eixXDC
         3iyA48+QVUHDuFHmHGNCIA7AyiulsF2uc3drm2z7PMuJT1LtnRW0qE2ieY8Zs76/AEpK
         3l/xtowSLk2dAcgS+hhwuAMVMJNwotlOFODGM+rbgN2aFhV15wZimqm6IPQ3YxzX4yJr
         Aln3oy1UoNklUM4lRZGf4mAbo4KVpL1w2iRVtc7IN9kgct0WkaLcMEa1hJ1/CziLhSbi
         hfNqpmoHiNJZSYkEjARYZcdarmf9j1UbdOJRaW29+h4UUoX6pruEq8Rj+N+0DwzyQauX
         AgMQ==
X-Gm-Message-State: AOAM530ORHHHMsLI3idq8cS/tun+Q3SEpILS15cVCPluUtV9e9clgT3G
        EwKqE058NNu/uxPrj/U4TsjY/5QGq9U2MoHNfuBTt7WCm6r1tmWq
X-Google-Smtp-Source: ABdhPJzdiyBatU0LrtK6uPQFcURsoMznYoQLlvhCGLJzKacKUwAKALkzsj/4DLWi17fzhN4g+L7w7jNO0lwJlq2yRAo=
X-Received: by 2002:a05:6512:1114:: with SMTP id l20mr1955215lfg.410.1642731676933;
 Thu, 20 Jan 2022 18:21:16 -0800 (PST)
MIME-Version: 1.0
References: <0d0b0a3ad703f5ef50611e2dd80439675bda666a.1642383007.git.zong.li@sifive.com>
 <mhng-5b3e2596-3558-4534-9229-26885ee4cc5c@palmer-ri-x1c9>
In-Reply-To: <mhng-5b3e2596-3558-4534-9229-26885ee4cc5c@palmer-ri-x1c9>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 21 Jan 2022 10:21:05 +0800
Message-ID: <CANXhq0ruGxjO0WPUipzZ7QQM1oEapyHAvb_aVQ_CMqVxbjc_BQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 21, 2022 at 2:52 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 16 Jan 2022 17:35:28 PST (-0800), zong.li@sifive.com wrote:
> > It currently assumes that there are always four channels, it would
> > cause the error if there is actually less than four channels. Change
> > that by getting number of channel from device tree.
> >
> > For backwards-compatible, it uses the default value (i.e. 4) when there
> > is no 'dma-channels' information in dts.
>
> Some of the same wording issues here as those I pointed out in the DT
> bindings patch.
>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/dma/sf-pdma/sf-pdma.c | 20 +++++++++++++-------
> >  drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
> >  2 files changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> > index f12606aeff87..1264add9897e 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
> >  static int sf_pdma_probe(struct platform_device *pdev)
> >  {
> >       struct sf_pdma *pdma;
> > -     struct sf_pdma_chan *chan;
> >       struct resource *res;
> > -     int len, chans;
> >       int ret;
> >       const enum dma_slave_buswidth widths =
> >               DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> > @@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
> >               DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> >               DMA_SLAVE_BUSWIDTH_64_BYTES;
> >
> > -     chans = PDMA_NR_CH;
> > -     len = sizeof(*pdma) + sizeof(*chan) * chans;
> > -     pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> > +     pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
> >       if (!pdma)
> >               return -ENOMEM;
> >
> > -     pdma->n_chans = chans;
> > +     ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > +                                &pdma->n_chans);
> > +     if (ret) {
> > +             dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> > +             pdma->n_chans = PDMA_MAX_NR_CH;
> > +     }
> > +
> > +     if (pdma->n_chans > PDMA_MAX_NR_CH) {
> > +             dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
> > +             return -EINVAL;
>
> Can we get away with just using only the number of channels the driver
> actually supports?  ie, just never sending an op to the channels above
> MAX_NR_CH?  That should leave us with nothing to track.

It might be a bit like when pdma->n_chans is bigger than the maximum,
set the pdma->chans to PDMA_MAX_NR_CH, then we could ensure that we
don't access the channels above the maximum. If I understand
correctly, I gave the similar thought in the thread of v2 patch, and
there are some discussions on that, but this way seems to lead to
hard-to-track problems.

>
> > +     }
> >
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >       pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> > @@ -556,7 +562,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
> >       struct sf_pdma_chan *ch;
> >       int i;
> >
> > -     for (i = 0; i < PDMA_NR_CH; i++) {
> > +     for (i = 0; i < pdma->n_chans; i++) {
> >               ch = &pdma->chans[i];
> >
> >               devm_free_irq(&pdev->dev, ch->txirq, ch);
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> > index 0c20167b097d..8127d792f639 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -22,11 +22,7 @@
> >  #include "../dmaengine.h"
> >  #include "../virt-dma.h"
> >
> > -#define PDMA_NR_CH                                   4
> > -
> > -#if (PDMA_NR_CH != 4)
> > -#error "Please define PDMA_NR_CH to 4"
> > -#endif
> > +#define PDMA_MAX_NR_CH                                       4
> >
> >  #define PDMA_BASE_ADDR                                       0x3000000
> >  #define PDMA_CHAN_OFFSET                             0x1000
> > @@ -118,7 +114,7 @@ struct sf_pdma {
> >       void __iomem            *membase;
> >       void __iomem            *mappedbase;
> >       u32                     n_chans;
> > -     struct sf_pdma_chan     chans[PDMA_NR_CH];
> > +     struct sf_pdma_chan     chans[PDMA_MAX_NR_CH];
> >  };
> >
> >  #endif /* _SF_PDMA_H */
