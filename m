Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF43C48D2CC
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jan 2022 08:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiAMH0I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jan 2022 02:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiAMH0H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jan 2022 02:26:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15DC061748
        for <dmaengine@vger.kernel.org>; Wed, 12 Jan 2022 23:26:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m1so16459540lfq.4
        for <dmaengine@vger.kernel.org>; Wed, 12 Jan 2022 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqEz1tdi+Dd5kBFVgy7VzOmS5HR1fqUYps8D18GxVbY=;
        b=cINt8NPb6J2QETAMUVvusHlCVGnH2oeK/jZ+W0YX50kGkDXF01Wdu6JPkeqwhjLpSp
         YYji7kjsL7guNBXqSVodAvb32hBKB4e7XboR0VXXP37z1ABNQ8WhZYIWNal1LEWy6JRE
         9Qsn72zK951tYkCBa8jZelBOsNb9JEQcwHeMe85fiDcOkkRi+P2Khsu3kPtQSTnPCd+a
         7InBhMnmSBDqo0/0vYYAXTFjYMAMK6158NP32i8K/HSvpzzYS7rj2mms17rdquThvMeV
         9u+zKppd96fVmuu6Mo0kk4JecUzPrXD7rzjehpsCPNVZ3FTiIb7An6As+BP00yAHsIxE
         wj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqEz1tdi+Dd5kBFVgy7VzOmS5HR1fqUYps8D18GxVbY=;
        b=U5vDrE0TMObeGmprp8VNB4MK9QfbjBoaORx38/h9BBdX/p49jAF71bhTXQeMk5gR0z
         FQimXRGo2z9HFf6Gkos8hY68sdyAFRUHbVeM0W9QkfydR9rkcvlfYFZtR4m2YGIdPVdi
         YO5nfJDy1PB0aNfCEbDb4+V4mdTyKjRvmvfTDz72lR3twOMl95q2TGXh9Y5zMcGBwKl0
         jB62BX4Wxzyr/El3YBoPjT1yY9VfxgFxXIgSU/T6T9mIZu0LVmKByWo+zK0eEt8On5hy
         cuHt3OvxfAVOkHGlke82+VVnFICdMmXHInV/pdq+hOn/0U7wiuDijp323pnFVi1epWub
         xQOQ==
X-Gm-Message-State: AOAM530WjZ9QgVIU+xIyJpQzWGCnpw4VSrTh36it1scwDVvXhqUR0g4v
        yKYA+ayvCiI7Vl1hs4tQQul4c3nziQXAoyzdnbcQAg==
X-Google-Smtp-Source: ABdhPJx45gF1826s11G22AXgxEBxocaiU3nnPiirOQSz78+oGy8yoaupoJL4uFZMsf60KHnBhTNzsVhUmkhYr5xXbCE=
X-Received: by 2002:a05:6512:ea9:: with SMTP id bi41mr2519011lfb.510.1642058765513;
 Wed, 12 Jan 2022 23:26:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641890718.git.zong.li@sifive.com> <78cfa00a02cbd10202040058af22a73caa9c5ae8.1641890718.git.zong.li@sifive.com>
 <CAMuHMdUogbyjU=vBuvocxofGFCwzdQndk9OTnVdP+RNA8HEFZQ@mail.gmail.com> <CANXhq0qpkArvELBDqOT=bnVCwvR47cxHN7oH1hYKr1Yt7zaGOQ@mail.gmail.com>
In-Reply-To: <CANXhq0qpkArvELBDqOT=bnVCwvR47cxHN7oH1hYKr1Yt7zaGOQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 13 Jan 2022 15:25:54 +0800
Message-ID: <CANXhq0rKsAsm4oSvnVqy385shoY2uTQOGUSqYdf-D=2xJ5vgWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jan 13, 2022 at 2:53 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Jan 12, 2022 at 4:28 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Zong,
> >
> > On Tue, Jan 11, 2022 at 9:51 AM Zong Li <zong.li@sifive.com> wrote:
> > > It currently assumes that there are always four channels, it would
> > > cause the error if there is actually less than four channels. Change
> > > that by getting number of channel from device tree.
> > >
> > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > is no 'dma-channels' information in dts.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > > @@ -484,21 +484,24 @@ static int sf_pdma_probe(struct platform_device *pdev)
> > >         struct sf_pdma *pdma;
> > >         struct sf_pdma_chan *chan;
> > >         struct resource *res;
> > > -       int len, chans;
> > > -       int ret;
> > > +       int len, ret;
> > >         const enum dma_slave_buswidth widths =
> > >                 DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> > >                 DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
> > >                 DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> > >                 DMA_SLAVE_BUSWIDTH_64_BYTES;
> > >
> > > -       chans = PDMA_NR_CH;
> > > -       len = sizeof(*pdma) + sizeof(*chan) * chans;
> > > +       len = sizeof(*pdma) + sizeof(*chan) * PDMA_MAX_NR_CH;
> >
> > Why is the last part added (yes, this is a pre-existing issue)?
> > struct sf_pdma already contains space for chans[PDMA_MAX_NR_CH].
> > Either drop the last part, or change sf_pdma.chans[] to a flexible
> > array member.
> >
> > BTW, you can use the struct_size() or flex_array_size() helper
> > to calculate len.
>
> Thanks for your suggestions, let me fix it in the next version.
>
> >
> > >         pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> > >         if (!pdma)
> > >                 return -ENOMEM;
> > >
> > > -       pdma->n_chans = chans;
> > > +       ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > > +                                  &pdma->n_chans);
> > > +       if (ret) {
> > > +               dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> > > +               pdma->n_chans = PDMA_MAX_NR_CH;
> > > +       }
> > >
> > >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >         pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> > > @@ -556,7 +559,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
> > >         struct sf_pdma_chan *ch;
> > >         int i;
> > >
> > > -       for (i = 0; i < PDMA_NR_CH; i++) {
> > > +       for (i = 0; i < pdma->n_chans; i++) {
> > >                 ch = &pdma->chans[i];
> >
> > If dma-channels in DT > PDMA_NR_CH, this becomes an out-of-bound
> > access.
> >
>
> Okay, let me get the min() between pdma->chans and PDMA_MAX_NR_CH,
> please let me know if it isn't good to you.

Please allow me give more details on it, I would compare the value of
pdma->chans with PDMA_MAX_NR_CH in probe function, and set the
pdma->chans to PDMA_MAX_NR_CH if the value in DT is bigger than
PDMA_MAX_NR_CH.

>
> > >
> > >                 devm_free_irq(&pdev->dev, ch->txirq, ch);
> > > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> > > index 0c20167b097d..8127d792f639 100644
> > > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > > @@ -22,11 +22,7 @@
> > >  #include "../dmaengine.h"
> > >  #include "../virt-dma.h"
> > >
> > > -#define PDMA_NR_CH                                     4
> > > -
> > > -#if (PDMA_NR_CH != 4)
> > > -#error "Please define PDMA_NR_CH to 4"
> > > -#endif
> > > +#define PDMA_MAX_NR_CH                                 4
> > >
> > >  #define PDMA_BASE_ADDR                                 0x3000000
> > >  #define PDMA_CHAN_OFFSET                               0x1000
> > > @@ -118,7 +114,7 @@ struct sf_pdma {
> > >         void __iomem            *membase;
> > >         void __iomem            *mappedbase;
> > >         u32                     n_chans;
> > > -       struct sf_pdma_chan     chans[PDMA_NR_CH];
> > > +       struct sf_pdma_chan     chans[PDMA_MAX_NR_CH];
> > >  };
> > >
> > >  #endif /* _SF_PDMA_H */
> > -
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
