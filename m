Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B19E8A9
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2019 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfH0NI2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Aug 2019 09:08:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37875 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfH0NI2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Aug 2019 09:08:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id b25so14887343oib.4;
        Tue, 27 Aug 2019 06:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2S0GVHRmC3Vkd6OFxrUvmz5N7W8VBhpQa3LnRiRzts=;
        b=At4CtcV/WQ+NbwWaTkLd3By2zKZEL6l9aXyAyFJpzgi6yLv2aVrJoGz7H2lxRzum8S
         VHxF5ATi4tW5y/oMsKN7gfMHTE2l6+PnN2ZWBEYp4KTx/2q4LdLYzpYLo2EDy5laDdct
         sk2nxE6C4pnNHMDcVXJxgDZOEnbTlRjIsNxW6+h8PKGe3y80mFKyA/3O5xrSWrGE/jZc
         MyQIvFGPZKKizKEDztCifTLBM8MELtZKxCCS/RKhhV9mkhiZlta6xrL7tHif/7dx73Xf
         y287gzNv2vGsfHkl6lopX1egx9E96dhKHPSBUsE2FPfDHhmpST2g9xe8o6Q/CcLC7XWa
         1hqg==
X-Gm-Message-State: APjAAAWYR8MsVbzDLg4rnd/y2VYl9YNVdGQB/ycD4xiyopxpFgmDIuz5
        KdLBvg6G1o8jeozkPl/QX9afWX+e2QbOvR0awr0=
X-Google-Smtp-Source: APXvYqxMwyZiaZ5XqoGofg/6Hz36RQRRUdXEeug72HzZKa+KrJ4B+PqSKV3FuX3FrjH9ZXiCvapx1vGUnDuKni3HxdU=
X-Received: by 2002:aca:f4ca:: with SMTP id s193mr15332142oih.131.1566911307470;
 Tue, 27 Aug 2019 06:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566904231-25486-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1566904231-25486-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 15:08:16 +0200
Message-ID: <CAMuHMdV9pSq1RrXG53=az1krVVnZF3M=F3MiS7t+Z5dMo_iKHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: Use of_data values instead of a macro
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Tue, Aug 27, 2019 at 1:12 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since we will have changed memory mapping of the DMAC in the future,
> this patch uses of_data values instead of a macro to calculate
> each channel's base offset.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -208,12 +208,20 @@ struct rcar_dmac {
>
>  #define to_rcar_dmac(d)                container_of(d, struct rcar_dmac, engine)
>
> +/*
> + * struct rcar_dmac_of_data - This driver's OF data
> + * @chan_offset_base: DMAC channels base offset
> + * @chan_offset_coefficient: DMAC channels offset coefficient

Perhaps "stride" instead of "coefficient"? Or "step"?

> @@ -1803,10 +1813,15 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>         unsigned int channels_offset = 0;
>         struct dma_device *engine;
>         struct rcar_dmac *dmac;
> +       const struct rcar_dmac_of_data *data;
>         struct resource *mem;
>         unsigned int i;
>         int ret;
>
> +       data = of_device_get_match_data(&pdev->dev);
> +       if (!data)
> +               return -EINVAL;

This cannot fail, as the driver is DT only, and all entries in the match table
have a data pointer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
