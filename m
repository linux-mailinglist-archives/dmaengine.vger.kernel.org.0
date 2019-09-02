Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4585A522B
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2019 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfIBIu6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Sep 2019 04:50:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42635 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfIBIu5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Sep 2019 04:50:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id o6so9884322oic.9;
        Mon, 02 Sep 2019 01:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCTDBqrkWmc5NnYPw8CKa//92aDX1d47QiLvL6uAPIA=;
        b=V8SINKiBQrOf9j3qMwTZsUwmDyeogLHazyu2sYHqa+fZBi1PhW9byy8nRBZtm4iF7e
         T+zVc0oxfZy+wUaSLHyiFfJIbQoyXon1q6WDZ1Bg6juE8I4cw1/hcyl9s432JPOtd+oH
         W2nbYda6wFXAe0JviqKDVu0jAneuTWW/XZVPKx3CD4k6SVjqvPLCgfKjNRWXkAufYMdH
         YpEo4Hp2pm2p4NGeTtcavHAMIfFVAufvSMo7ayhbcvLCmGduuRDSZ4Pr1Z2QGknQnqFK
         GThWtxQ/ORJqQTNj2y+E3Stx3jjGqCbbSDKwtQ4OfqJurYPk5mmD5FIhCd4GOTswgDQU
         sTyA==
X-Gm-Message-State: APjAAAXal/O38ila/TtLyLtiWN/IgHKka6a7YVZj5OECbZufaQ/vlbEb
        M/c8GuZpbCwUVZOYx6/jbE2UlW/ZAyxJ4d5hRhk=
X-Google-Smtp-Source: APXvYqwM3XGiy8zRacmtsK2PkhAsp9osDhTTD9LHYYnmZ6c7IF8zR35UgBO4EdudT2f+CrzZ0i7jDfXlVJhCqMf79UM=
X-Received: by 2002:aca:3382:: with SMTP id z124mr19141479oiz.102.1567414256805;
 Mon, 02 Sep 2019 01:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566990835-27028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1566990835-27028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Sep 2019 10:50:45 +0200
Message-ID: <CAMuHMdXL3YVceigUh1WfCPQLwgZ2S46NUNO11=r22P+qp3C3-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: rcar-dmac: Add dma-channel-mask property support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Wed, Aug 28, 2019 at 1:15 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds dma-channel-mask property support not to reserve
> some DMA channels for some reasons. (for example: a heterogeneous
> CPU uses it.)

Thanks for your patch!

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One suggestion below.

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1806,7 +1806,17 @@ static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
>                 return -EINVAL;
>         }
>
> -       dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
> +       /*
> +        * If the driver is unable to read dma-channel-mask property,
> +        * the driver assumes that it can use all channels.
> +        */
> +       ret = of_property_read_u32(np, "dma-channel-mask",
> +                                  &dmac->channels_mask);
> +       if (ret < 0)
> +               dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);

You could keep the preinitialization, and just ignore the return value:

    dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
    of_property_read_u32(np, "dma-channel-mask", &dmac->channels_mask);

>
> +
> +       /* If the property has out-of-channel mask, this driver clears it */
> +       dmac->channels_mask &= GENMASK(dmac->n_channels - 1, 0);
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
