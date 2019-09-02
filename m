Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8CA51DF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2019 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfIBIgN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Sep 2019 04:36:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33524 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbfIBIgN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Sep 2019 04:36:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id l2so9927013oil.0;
        Mon, 02 Sep 2019 01:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/i26wNEedususukrR+bieDmneYLksMf979nWG1j3xI=;
        b=p+8CO7LfjhHvWDuHr0r+8KI7++JzLyi/suBqOj0t2WnG1LN4u3JL76B1xRAd0f63/w
         y5R9hSJYijmR//tVshVi9oqX99gwm+w/9XVjwLn3Q6AWij+hgZ1+a/TmeYEKkSLx9+zj
         aqIF2FskeWziqm9i34Zb2CyYQE178vaeAAQ4dDhtPUP1MYgsTX0pjUe/dJ4usGb2l47h
         27p/iv+IldNwu+VsDaJfJ5yecHvNEZPj2gp6g0C/Dp02hqdNYfP17LczOvGStOiWHMIG
         EOruNG+Cjc9oegY33WbImsoWftHbrZUwD2GC9LFBnGwCKysKMaRSUxxi7risa01BcCDT
         2Qzg==
X-Gm-Message-State: APjAAAX5GMRjNLsuakLVA0HCuncHeEdt1w7x/2argF6wNz3hOkvYN4Ob
        Xnk4cWLY+B1EI0o39svxssB5fsYEjey6R5Pm1ex4tyX+
X-Google-Smtp-Source: APXvYqyWeM6LBHGwRhDp66uXSD4C+HFluC1bzC+s2Y9FXzzH5uWe5faErlJnwdbITCuYTKJX+TE3T6n1y7HtlNGxxHw=
X-Received: by 2002:aca:b154:: with SMTP id a81mr17593986oif.148.1567413372420;
 Mon, 02 Sep 2019 01:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Sep 2019 10:36:01 +0200
Message-ID: <CAMuHMdUF4pgad0CWE6h4CQijy+-0Cif40C91TRVzH_OBO2tRPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1
 if iommu is mapped
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
> The commit 20c169aceb45 ("dmaengine: rcar-dmac: clear pertinence
> number of channels") always set the DMACHCLR bit 0 to 1, but if
> iommu is mapped to the device, this driver doesn't need to clear it.
> So, this patch takes care of it by using "channels_mask" bitfield.

Thanks for your patch!

> Note that, this patch doesn't have a "Fixes:" tag because the driver
> doesn't manage the channel 0 anyway so that the behavior of
> the channel is not changed.

This patch does fix a bug, as GENMASK(dmac->n_channels - 1, 0) doesn't
take into account channels_offset.  Hence it not only clears channel 0,
as you mentioned, but also forgets to clear the last channel, which
is a real bug.

So I think this does warrant a
Fixes: 20c169aceb459575 ("dmaengine: rcar-dmac: clear pertinence
number of channels")

Or perhaps the actual bug should be fixed first in a separate patch?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c

> @@ -446,7 +448,7 @@ static int rcar_dmac_init(struct rcar_dmac *dmac)
>         u16 dmaor;
>
>         /* Clear all channels and enable the DMAC globally. */
> -       rcar_dmac_write(dmac, RCAR_DMACHCLR, GENMASK(dmac->n_channels - 1, 0));
> +       rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
>         rcar_dmac_write(dmac, RCAR_DMAOR,
>                         RCAR_DMAOR_PRI_FIXED | RCAR_DMAOR_DME);
>
> @@ -822,6 +824,9 @@ static void rcar_dmac_stop_all_chan(struct rcar_dmac *dmac)
>         for (i = 0; i < dmac->n_channels; ++i) {
>                 struct rcar_dmac_chan *chan = &dmac->channels[i];
>
> +               if (!(dmac->channels_mask & BIT(i)))
> +                       continue;
> +
>                 /* Stop and reinitialize the channel. */
>                 spin_lock_irq(&chan->lock);
>                 rcar_dmac_chan_halt(chan);
> @@ -1801,6 +1806,8 @@ static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
>                 return -EINVAL;
>         }
>
> +       dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);

You're aware dmac->n_channels can be 99, as per the check above, jut out of
context? ;-)

Probably that check should be changed to reject >= 32, as the hardware
and driver don't support more than 32 bits in CHCLR anyway.
> +
>         return 0;
>  }
>
> @@ -1810,7 +1817,6 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>                 DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
>                 DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
>                 DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
> -       unsigned int channels_offset = 0;
>         struct dma_device *engine;
>         struct rcar_dmac *dmac;
>         const struct rcar_dmac_of_data *data;
> @@ -1843,10 +1849,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>          * level we can't disable it selectively, so ignore channel 0 for now if
>          * the device is part of an IOMMU group.
>          */
> -       if (device_iommu_mapped(&pdev->dev)) {
> -               dmac->n_channels--;
> -               channels_offset = 1;
> -       }
> +       if (device_iommu_mapped(&pdev->dev))
> +               dmac->channels_mask &= ~BIT(0);
>
>         dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
>                                       sizeof(*dmac->channels), GFP_KERNEL);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
