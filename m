Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3E5415ACB
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhIWJXr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 05:23:47 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:46662 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbhIWJXr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Sep 2021 05:23:47 -0400
Received: by mail-vk1-f169.google.com with SMTP id b67so2298616vkb.13;
        Thu, 23 Sep 2021 02:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy19Xo59ry3ioGFW3vDD028uDzunKdLfw+0sM5yJWSk=;
        b=xJKFYUVcedHi23bz9ztMHp8KHwI6qV3Wo7hMpBmdtR4y7c27PtSmqIoU4hczhDxWvg
         511FTuMbDsKytrv/n5WnIJgVPTNW5pJygZj2qUQmPBEKUZ0+PBMAiL/8yHU5atPJMmGP
         8cVUvOe16OcMqPzIYUTZCwh8hPaA6nA94LsZXWhzRJeWoTSKgfcEJwKr8Df6BykzdC+O
         Uyj6zq2S40d7Xi8uc1NTzjLrKfG/CWcFw3rqSQXNDZelmptnlYOWX5kGsWflC6xlkSOb
         juMzbzMaWIQPgGlBBLnAky4Ivt+4LBh8Bjwfkxrs+JftnCfeRtq5OtNi7npvg17Q5GVa
         plLg==
X-Gm-Message-State: AOAM532lrv5/jLcwd2ufe+VAc9fHB3m7jx97KdMkRYpNnIBIGCQ/t92g
        elgVnj32N/StHOHVWKddFtxOp5SdoSAcMIN0lSmhyb1F
X-Google-Smtp-Source: ABdhPJyp8y44484cuIiyS5GSi59OZm75zhsG0KKajzSYniUhxDPFttmTja8PxGlVm8NpR8ry3Qz89+wbnLX/Q3n2Ueo=
X-Received: by 2002:a1f:3a4b:: with SMTP id h72mr2255905vka.19.1632388935817;
 Thu, 23 Sep 2021 02:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210922110453.25122-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210922110453.25122-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Sep 2021 11:22:04 +0200
Message-ID: <CAMuHMdUadbZf++tTBgGUh5ZKsbu7-sr=z5wd=yHh9vgjpTU67w@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Add DMA clock handling
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Wed, Sep 22, 2021 at 1:17 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Currently, DMA clocks are turned on by the bootloader.
> This patch adds support for DMA clock handling so that
> the driver manages the DMA clocks.
>
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_dma.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>
> @@ -872,6 +873,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
>         /* Initialize the channels. */
>         INIT_LIST_HEAD(&dmac->engine.channels);
>
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_resume_and_get(&pdev->dev);

I know this cannot fail in the real world, but I think you should handle
failure here, else the junior janitor crowd will send a follow-up patch
adding such handling...

> +
>         for (i = 0; i < dmac->n_channels; i++) {
>                 ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
>                 if (ret < 0)
> @@ -925,6 +929,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
>                                   channel->lmdesc.base_dma);
>         }
>
> +       pm_runtime_put(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +
>         return ret;
>  }
>
> @@ -943,6 +950,8 @@ static int rz_dmac_remove(struct platform_device *pdev)
>         }
>         of_dma_controller_free(pdev->dev.of_node);
>         dma_async_device_unregister(&dmac->engine);
> +       pm_runtime_put(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
>
>         return 0;
>  }

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
