Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A34895EC
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 11:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiAJKDg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 05:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiAJKDe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 05:03:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA5C06173F
        for <dmaengine@vger.kernel.org>; Mon, 10 Jan 2022 02:03:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u13so42230385lff.12
        for <dmaengine@vger.kernel.org>; Mon, 10 Jan 2022 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HY6zdUgUPJS0rZ9Ot4PacGAg8YII4kCfsueCrIhKQWY=;
        b=H/hhv/x8EzQOjr1k+fLZF3B7CAvRRYEH7EnnulDR8KojIxjB3Jy0WngKqCnaEJZ9AQ
         H0GkrpL2uvxKCxiv9iD7NNtwqZK4YVSuHoJVJdMspvcmsT+bo4kHO6v/eQZsyHnwY+Fs
         /GaHP+eN37cXeJJuFzW3OOD83ivkpGLwLWRFZNUDArSPWECEbLmip/A2l6chRcAHZPnH
         pBMKhag9gnvjHeu7p/ayq/nrNISo2mwFLpZAAGkL8TYvQavMqmLQbQBuYbxj2cvkaeTN
         +m54X7JjzHOTo3nN7z++KMhjAvF+iIF4NeRpmSy1O3ono0RiDTCbqRt09gFtj5HYwh6a
         FwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HY6zdUgUPJS0rZ9Ot4PacGAg8YII4kCfsueCrIhKQWY=;
        b=OWxgCtmHIZWej2fYS7bkIcSUdj6h5zaYiZlKCwreepRQKF7gI6p3GLEK25nfRM1wK2
         3P7KmyBCwBAvP0TCBmYapJTJsagCgv6SCXbH1AMtV3JImv7IwNoo76Z46gYbWKOP0o4+
         jiUzFdnUGy0zBQdgIUlz6Tzd3q7HgQYhgPdXS1Fx5zTZzGssJsME/bDGSSHq4+86T/Al
         O8ucjUFI7OQnbTCZJ7jn3B9fmx9kDDs/gYVNQ5yY9LFnIUZLGatg5EKUVPxXRxxbHwr0
         +hR0dy9s38EdmCOmawBZEGEhXv6sGMWMPfmfOWiIOiEydOQ4YZmGBnF+HaXdvhOSjI/1
         9Mcg==
X-Gm-Message-State: AOAM533hJqet3fiLJNh2QfeStS0uqcF0Y/vSp6opJKcfvX0S3HZcHMGT
        oCNp0Oc4kqdBXyYCEuwXWYFk+ix7tEhYZM7e5pUnFA==
X-Google-Smtp-Source: ABdhPJzuq0aXiUP/F1mE5uAGsEE58SDn3kREJFq3JcX7qKN8JgezJdqYacYS9Vtb1vlZzcgPK6y7ZO0Wf1//9XS4ewg=
X-Received: by 2002:a05:6512:260a:: with SMTP id bt10mr19060865lfb.223.1641809011771;
 Mon, 10 Jan 2022 02:03:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641289490.git.zong.li@sifive.com> <5a7786cff08d55d0e084cd28bc2800565fa2dce7.1641289490.git.zong.li@sifive.com>
 <CAMuHMdV5gbeaaXPfJ4EuYur0NChp3iurdzNzC_UOLDrGP7rZNA@mail.gmail.com>
In-Reply-To: <CAMuHMdV5gbeaaXPfJ4EuYur0NChp3iurdzNzC_UOLDrGP7rZNA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 10 Jan 2022 18:03:20 +0800
Message-ID: <CANXhq0r_x=xW37SGJfQRs11-+VL1oJKRHe1fxk3QbT_Qzy6-dQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: sf-pdma: Get number of channel by device tree
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

On Mon, Jan 10, 2022 at 4:58 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Zong,
>
> On Wed, Jan 5, 2022 at 6:44 AM Zong Li <zong.li@sifive.com> wrote:
> > It currently assumes that there are four channels by default, it might
> > cause the error if there is actually less than four channels. Change
> > that by getting number of channel from device tree.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Thanks for your patch!
>
> > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > @@ -484,21 +484,24 @@ static int sf_pdma_probe(struct platform_device *pdev)
> >         struct sf_pdma *pdma;
> >         struct sf_pdma_chan *chan;
> >         struct resource *res;
> > -       int len, chans;
> > -       int ret;
> > +       int len, ret;
> >         const enum dma_slave_buswidth widths =
> >                 DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> >                 DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
> >                 DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> >                 DMA_SLAVE_BUSWIDTH_64_BYTES;
> >
> > -       chans = PDMA_NR_CH;
> > -       len = sizeof(*pdma) + sizeof(*chan) * chans;
> > +       len = sizeof(*pdma) + sizeof(*chan) * PDMA_MAX_NR_CH;
> >         pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> >         if (!pdma)
> >                 return -ENOMEM;
> >
> > -       pdma->n_chans = chans;
> > +       ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > +                                  &pdma->n_chans);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to read dma-channels\n");
> > +               return ret;
>
> Note that this is not backwards-compatible with existing DTBs, which
> lack the "dma-channels" property.
> Perhaps you want to fallback to a default of 4 instead?
>

Thanks for your advice. I would set n_chans to 4 in failure condition
for backwards-compatible.

> > +       }
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         pdma->membase = devm_ioremap_resource(&pdev->dev, res);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
