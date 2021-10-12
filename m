Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB59D429F7D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Oct 2021 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhJLIPl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Oct 2021 04:15:41 -0400
Received: from mail-vk1-f182.google.com ([209.85.221.182]:44930 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhJLIPk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Oct 2021 04:15:40 -0400
Received: by mail-vk1-f182.google.com with SMTP id s137so9011021vke.11;
        Tue, 12 Oct 2021 01:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXmarTI1+LQWu2ghsOxw1SFURZt34vaHNVI6qavZVwQ=;
        b=LgfDMurpWTsmuvX2afUwlVMhgHBC+eOoM3+Lu1/sM0YJa+40l8y1Mhohh4MvdK7FhE
         Pw27H/1kE/hccK4GZHX0oG9qVp7gSt8i2zrh6/2rXxv3tB0IC1OeUL8uRr8uejn2Fuj+
         Df0BBHDfGi+X85tl2pzB0VOrBGDiNg2lTdEMpcJxObaB0zo8VVTSJZO0y/4nbnOYo3Sm
         cFgw+43+Sq20mAcT7k6G6+jRnIGLWqfp9eDr+HVZyD/CW/g2btt5olPrXnIRyYHMIj+F
         P0Odi9XHJHxn7nvF3Sh+eL4tLarAJtBXaUv2nWrZdKVzn+QazGSaiMmNOotYspQsDGZN
         rfJg==
X-Gm-Message-State: AOAM533JoiZ1dYSuQd3SUzbrflcTGtK9BdISckqrP6wL3a3UoXyXk2i5
        498x4M6fpz9p2OFlB0vF8B+RPHWOTK/92jj90e8=
X-Google-Smtp-Source: ABdhPJzXLc6FRGi1ayWukPxcVFgRtXkkzylUdiS6GTlTzIIkIMWC1XlG+Y6Mw+ro+TI+YVWXakK0v/SRjxM9FUygYco=
X-Received: by 2002:a1f:3a4b:: with SMTP id h72mr24727058vka.19.1634026419028;
 Tue, 12 Oct 2021 01:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210923102451.11403-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210923102451.11403-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Oct 2021 10:13:27 +0200
Message-ID: <CAMuHMdXF0QwFTZdi2qGuUk6ui=X+TnkgScxqu5oMrEi+4yGN=A@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: sh: rz-dmac: Add DMA clock handling
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju, Vinod,

On Thu, Sep 23, 2021 at 12:25 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Currently, DMA clocks are turned on by the bootloader.
> This patch adds support for DMA clock handling so that
> the driver manages the DMA clocks.
>
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

If I'm not mistaken, this is a fix we want in v5.15, to avoid
regressions when the clock driver will be fixed (in clk-fixes for
v5.15), and DMA will be enabled in DT (in v5.16)?

Thanks!

> ---
> v1->v2:
>  * Handled the failure case for pm_runtime_resume_and_get
>  * Added Geert's Rb tag.
> ---
>  drivers/dma/sh/rz-dmac.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index f9f30cbeccbe..d9f2cfef878e 100644
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
> @@ -872,6 +873,13 @@ static int rz_dmac_probe(struct platform_device *pdev)
>         /* Initialize the channels. */
>         INIT_LIST_HEAD(&dmac->engine.channels);
>
> +       pm_runtime_enable(&pdev->dev);
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "pm_runtime_resume_and_get failed\n");
> +               goto err_pm_disable;
> +       }
> +
>         for (i = 0; i < dmac->n_channels; i++) {
>                 ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
>                 if (ret < 0)
> @@ -925,6 +933,10 @@ static int rz_dmac_probe(struct platform_device *pdev)
>                                   channel->lmdesc.base_dma);
>         }
>
> +       pm_runtime_put(&pdev->dev);
> +err_pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +
>         return ret;
>  }
>
> @@ -943,6 +955,8 @@ static int rz_dmac_remove(struct platform_device *pdev)
>         }
>         of_dma_controller_free(pdev->dev.of_node);
>         dma_async_device_unregister(&dmac->engine);
> +       pm_runtime_put(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
>
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
