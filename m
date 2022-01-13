Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23748D48D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jan 2022 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiAMI6q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jan 2022 03:58:46 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:41614 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiAMI5y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jan 2022 03:57:54 -0500
Received: by mail-vk1-f170.google.com with SMTP id n9so2397598vkq.8;
        Thu, 13 Jan 2022 00:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbBEPLACDWPlnwwenFhgzoqyYNOO9jVGdUxMfFLqZ1s=;
        b=YDNx9R2PJHTPQRoxOSRCAwrZLZH4IrLLdD1icaHLJmy/AbGjYcfwImjzQ+bX07VNni
         sCdNNMIYJODD50avJSrUpe1KCZFGpMnzXTA7zRQR6o78lS1FPV4dcrdGNlNm+7dEBAoR
         0y6D4hsZ7ewszumkynFmnTHId1Ot441RXoE//FlDpn/A4QLqrm9eQXQI2icjFuUePq3L
         sZ8pp+4nidbOXFI4LUBY0f2KOBygVAxp1uj3SzMrYpJDxOIEYICB4E5NdC+ZQys05O3b
         SDzXO0TbqpQFMftGAUJ8Tm1zX51paOs67NDud6UrBPnMKVNtt2bl6Uo2E8Q0AVMgPfjv
         VGcQ==
X-Gm-Message-State: AOAM532x0yvN9FTloEbHwi0ud93DGg7fiJW0Fl19JQOFNEDG0rwK/oeA
        DulES3lyJmz8+ok7PuzXcfRzI3zRZX1Qql0I
X-Google-Smtp-Source: ABdhPJytBiW0pWRPd3E20XdPL953mPOAKx2u0ydk0wECE35NIiIc34qfuJl9Xd4B2Vfprw3HYh/Ejw==
X-Received: by 2002:a05:6122:90a:: with SMTP id j10mr1686160vka.12.1642064273381;
        Thu, 13 Jan 2022 00:57:53 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id s25sm1312780vsk.20.2022.01.13.00.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 00:57:52 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id m90so9815541uam.2;
        Thu, 13 Jan 2022 00:57:51 -0800 (PST)
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr1708060vsu.5.1642064271439;
 Thu, 13 Jan 2022 00:57:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641890718.git.zong.li@sifive.com> <78cfa00a02cbd10202040058af22a73caa9c5ae8.1641890718.git.zong.li@sifive.com>
 <CAMuHMdUogbyjU=vBuvocxofGFCwzdQndk9OTnVdP+RNA8HEFZQ@mail.gmail.com>
 <CANXhq0qpkArvELBDqOT=bnVCwvR47cxHN7oH1hYKr1Yt7zaGOQ@mail.gmail.com> <CANXhq0rKsAsm4oSvnVqy385shoY2uTQOGUSqYdf-D=2xJ5vgWg@mail.gmail.com>
In-Reply-To: <CANXhq0rKsAsm4oSvnVqy385shoY2uTQOGUSqYdf-D=2xJ5vgWg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jan 2022 09:57:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUa8VCyocHzXGrQevEHiMVs_-p+qGpw_5ZFdOT66pv=Q@mail.gmail.com>
Message-ID: <CAMuHMdXUa8VCyocHzXGrQevEHiMVs_-p+qGpw_5ZFdOT66pv=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Zong Li <zong.li@sifive.com>
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

Hi Zong,

On Thu, Jan 13, 2022 at 8:26 AM Zong Li <zong.li@sifive.com> wrote:
> On Thu, Jan 13, 2022 at 2:53 PM Zong Li <zong.li@sifive.com> wrote:
> > On Wed, Jan 12, 2022 at 4:28 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Jan 11, 2022 at 9:51 AM Zong Li <zong.li@sifive.com> wrote:
> > > > It currently assumes that there are always four channels, it would
> > > > cause the error if there is actually less than four channels. Change
> > > > that by getting number of channel from device tree.
> > > >
> > > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > > is no 'dma-channels' information in dts.
> > > >
> > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > > > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > > > @@ -484,21 +484,24 @@ static int sf_pdma_probe(struct platform_device *pdev)
> > > >         struct sf_pdma *pdma;
> > > >         struct sf_pdma_chan *chan;
> > > >         struct resource *res;
> > > > -       int len, chans;
> > > > -       int ret;
> > > > +       int len, ret;
> > > >         const enum dma_slave_buswidth widths =
> > > >                 DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> > > >                 DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
> > > >                 DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> > > >                 DMA_SLAVE_BUSWIDTH_64_BYTES;
> > > >
> > > > -       chans = PDMA_NR_CH;
> > > > -       len = sizeof(*pdma) + sizeof(*chan) * chans;
> > > > +       len = sizeof(*pdma) + sizeof(*chan) * PDMA_MAX_NR_CH;
> > >
> > > Why is the last part added (yes, this is a pre-existing issue)?
> > > struct sf_pdma already contains space for chans[PDMA_MAX_NR_CH].
> > > Either drop the last part, or change sf_pdma.chans[] to a flexible
> > > array member.
> > >
> > > BTW, you can use the struct_size() or flex_array_size() helper
> > > to calculate len.
> >
> > Thanks for your suggestions, let me fix it in the next version.
> >
> > >
> > > >         pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> > > >         if (!pdma)
> > > >                 return -ENOMEM;
> > > >
> > > > -       pdma->n_chans = chans;
> > > > +       ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > > > +                                  &pdma->n_chans);
> > > > +       if (ret) {
> > > > +               dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> > > > +               pdma->n_chans = PDMA_MAX_NR_CH;
> > > > +       }
> > > >
> > > >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >         pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> > > > @@ -556,7 +559,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
> > > >         struct sf_pdma_chan *ch;
> > > >         int i;
> > > >
> > > > -       for (i = 0; i < PDMA_NR_CH; i++) {
> > > > +       for (i = 0; i < pdma->n_chans; i++) {
> > > >                 ch = &pdma->chans[i];
> > >
> > > If dma-channels in DT > PDMA_NR_CH, this becomes an out-of-bound
> > > access.
> > >
> >
> > Okay, let me get the min() between pdma->chans and PDMA_MAX_NR_CH,
> > please let me know if it isn't good to you.
>
> Please allow me give more details on it, I would compare the value of
> pdma->chans with PDMA_MAX_NR_CH in probe function, and set the
> pdma->chans to PDMA_MAX_NR_CH if the value in DT is bigger than
> PDMA_MAX_NR_CH.

Silently limiting "dma-channels" to PDMA_MAX_NR_CH is not a good idea,
as that may lead to hard-to-track problems.

Basically you have two options:
  1. Just use the value of "dma-channels" if present.
     This has the advantage that it will work automatically with
     future variants that have more channels, but allows the
     developer to trigger memory exhaustion by providing a very large value.
  2. Return -EINVAL if "dma-channels" is larger than PDMA_MAX_NR_CH.
     This is the safest, but requires driver changes for a future variant
      that has more channels.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
