Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7A48BFDC
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 09:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbiALI2o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 03:28:44 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:37413 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351628AbiALI2l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 03:28:41 -0500
Received: by mail-ua1-f44.google.com with SMTP id o1so3332800uap.4;
        Wed, 12 Jan 2022 00:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICGbwIc6WQlKE/ioYvNigSD06lESIz/s7WepMycFiZo=;
        b=YhEAl30wNcHFyH1+7O1DETP3Av7qbfD+WnsLM8hO1vitAW2g9n+InwUKJoXbWadKy0
         9JATbFKZI5jE+JefVHSqi7bPqExvVVR8tX6/YEMAwFPW9iWWTit3w6zhyhS6dP+BLoie
         pOZVF/ykuEDkkqDcfSHpElbXJ4VIhTfVwQoyTY8S+QZEou+iiffhLl0rgDoQLQiyJ1Oi
         qXXwzIaRG6c+AmFe5OMGKKmeawQkzk19ueZWA+jrelIk5CQoEvRp8/JDAlfaQOPhQJ48
         u/hpfFkg2p/f1zbouAzJuiVV4SPE69+HHfUU/rydOyqadR1qAyA1QIAbN0N/1kX0maYy
         BHFQ==
X-Gm-Message-State: AOAM531jneUJv9YWx2zzNzN+Tum6Ky6bdGM9fcIv4bl34Wvh7Sq9Tnum
        CXSpQcFmqdX3UBsHPbySnR6oLMEhfeA1Fg==
X-Google-Smtp-Source: ABdhPJwRWO0gQ7dsBbyZyegdRgDMCFwxwXtWiRODwE+JyRIBB9C7UKZYyalC1z28i9qPm8qgghuvfA==
X-Received: by 2002:a67:b807:: with SMTP id i7mr3495512vsf.52.1641976120115;
        Wed, 12 Jan 2022 00:28:40 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id c25sm8147583vsk.32.2022.01.12.00.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:28:39 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id x33so3264101uad.12;
        Wed, 12 Jan 2022 00:28:39 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr3660457vsg.57.1641976118915;
 Wed, 12 Jan 2022 00:28:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641890718.git.zong.li@sifive.com> <78cfa00a02cbd10202040058af22a73caa9c5ae8.1641890718.git.zong.li@sifive.com>
In-Reply-To: <78cfa00a02cbd10202040058af22a73caa9c5ae8.1641890718.git.zong.li@sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jan 2022 09:28:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUogbyjU=vBuvocxofGFCwzdQndk9OTnVdP+RNA8HEFZQ@mail.gmail.com>
Message-ID: <CAMuHMdUogbyjU=vBuvocxofGFCwzdQndk9OTnVdP+RNA8HEFZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Zong Li <zong.li@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>, green.wan@sifive.com,
        Vinod <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Zong,

On Tue, Jan 11, 2022 at 9:51 AM Zong Li <zong.li@sifive.com> wrote:
> It currently assumes that there are always four channels, it would
> cause the error if there is actually less than four channels. Change
> that by getting number of channel from device tree.
>
> For backwards-compatible, it uses the default value (i.e. 4) when there
> is no 'dma-channels' information in dts.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks for your patch!

> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -484,21 +484,24 @@ static int sf_pdma_probe(struct platform_device *pdev)
>         struct sf_pdma *pdma;
>         struct sf_pdma_chan *chan;
>         struct resource *res;
> -       int len, chans;
> -       int ret;
> +       int len, ret;
>         const enum dma_slave_buswidth widths =
>                 DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
>                 DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
>                 DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
>                 DMA_SLAVE_BUSWIDTH_64_BYTES;
>
> -       chans = PDMA_NR_CH;
> -       len = sizeof(*pdma) + sizeof(*chan) * chans;
> +       len = sizeof(*pdma) + sizeof(*chan) * PDMA_MAX_NR_CH;

Why is the last part added (yes, this is a pre-existing issue)?
struct sf_pdma already contains space for chans[PDMA_MAX_NR_CH].
Either drop the last part, or change sf_pdma.chans[] to a flexible
array member.

BTW, you can use the struct_size() or flex_array_size() helper
to calculate len.

>         pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>         if (!pdma)
>                 return -ENOMEM;
>
> -       pdma->n_chans = chans;
> +       ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> +                                  &pdma->n_chans);
> +       if (ret) {
> +               dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> +               pdma->n_chans = PDMA_MAX_NR_CH;
> +       }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         pdma->membase = devm_ioremap_resource(&pdev->dev, res);
> @@ -556,7 +559,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
>         struct sf_pdma_chan *ch;
>         int i;
>
> -       for (i = 0; i < PDMA_NR_CH; i++) {
> +       for (i = 0; i < pdma->n_chans; i++) {
>                 ch = &pdma->chans[i];

If dma-channels in DT > PDMA_NR_CH, this becomes an out-of-bound
access.

>
>                 devm_free_irq(&pdev->dev, ch->txirq, ch);
> diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
> index 0c20167b097d..8127d792f639 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.h
> +++ b/drivers/dma/sf-pdma/sf-pdma.h
> @@ -22,11 +22,7 @@
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>
> -#define PDMA_NR_CH                                     4
> -
> -#if (PDMA_NR_CH != 4)
> -#error "Please define PDMA_NR_CH to 4"
> -#endif
> +#define PDMA_MAX_NR_CH                                 4
>
>  #define PDMA_BASE_ADDR                                 0x3000000
>  #define PDMA_CHAN_OFFSET                               0x1000
> @@ -118,7 +114,7 @@ struct sf_pdma {
>         void __iomem            *membase;
>         void __iomem            *mappedbase;
>         u32                     n_chans;
> -       struct sf_pdma_chan     chans[PDMA_NR_CH];
> +       struct sf_pdma_chan     chans[PDMA_MAX_NR_CH];
>  };
>
>  #endif /* _SF_PDMA_H */
-
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
