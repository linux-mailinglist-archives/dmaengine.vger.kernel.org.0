Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDFD48948A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 09:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbiAJI7V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 03:59:21 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:37455 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbiAJI6F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 03:58:05 -0500
Received: by mail-vk1-f172.google.com with SMTP id l68so7685417vkh.4;
        Mon, 10 Jan 2022 00:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzvAQJe2veQdg4DaRkaqygFL5jyj5pSAthDAblQ6LsI=;
        b=ygGulsMb4AZV9jyJCbG3UVjOkNQhjFoMIk+Pha8O9zwDymvq+YNb6kEE7tTKrlILcB
         heAERqjG8azMDc+lV+lnwjRGQVEFGvR9SBVETLLstfxO4vMWbUkKbhmKD0hrIdSqsQKC
         6ao4qQqxYE8jRRuD2eGig9s9BebKVsG7lDbQA9Yge7UfoVTvaLr1xVriGey+ynftWuR+
         C0+GBUP/jRec3XhmTGs6VONryKIQz/w0QZjrlK9dfO1ry0UQUj9rd7sZKNtqycDlZRmG
         M8cyUpcVxe7DML7m/yew9rz7tBbj5CdH3sBxm8zEjPhiIi+765EpkDS1IJLmZaF3+Ozf
         3CLQ==
X-Gm-Message-State: AOAM532mkdx6b8MGdpGJi6UJkeiW8yLY51NjYkLyO+hLSiPW9sCrZQsy
        RPIT32n8oFjn9GJtokHTT/hwETQWe1Jrbw==
X-Google-Smtp-Source: ABdhPJxsE6CWgbUAtb+8rUvw8031kWWFZ1ZdP3vEmegnNDkcrpZln+zkwVwSBRfEp0UfGDmoiPV7Mw==
X-Received: by 2002:a1f:2ad0:: with SMTP id q199mr7134321vkq.29.1641805084009;
        Mon, 10 Jan 2022 00:58:04 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id o12sm3504802uae.1.2022.01.10.00.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:58:03 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id l68so7685388vkh.4;
        Mon, 10 Jan 2022 00:58:02 -0800 (PST)
X-Received: by 2002:a1f:1bd0:: with SMTP id b199mr13248764vkb.33.1641805082754;
 Mon, 10 Jan 2022 00:58:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641289490.git.zong.li@sifive.com> <5a7786cff08d55d0e084cd28bc2800565fa2dce7.1641289490.git.zong.li@sifive.com>
In-Reply-To: <5a7786cff08d55d0e084cd28bc2800565fa2dce7.1641289490.git.zong.li@sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 09:57:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV5gbeaaXPfJ4EuYur0NChp3iurdzNzC_UOLDrGP7rZNA@mail.gmail.com>
Message-ID: <CAMuHMdV5gbeaaXPfJ4EuYur0NChp3iurdzNzC_UOLDrGP7rZNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: sf-pdma: Get number of channel by device tree
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

On Wed, Jan 5, 2022 at 6:44 AM Zong Li <zong.li@sifive.com> wrote:
> It currently assumes that there are four channels by default, it might
> cause the error if there is actually less than four channels. Change
> that by getting number of channel from device tree.
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
>         pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
>         if (!pdma)
>                 return -ENOMEM;
>
> -       pdma->n_chans = chans;
> +       ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> +                                  &pdma->n_chans);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to read dma-channels\n");
> +               return ret;

Note that this is not backwards-compatible with existing DTBs, which
lack the "dma-channels" property.
Perhaps you want to fallback to a default of 4 instead?

> +       }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         pdma->membase = devm_ioremap_resource(&pdev->dev, res);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
