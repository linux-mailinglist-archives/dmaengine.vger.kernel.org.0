Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57133C7FCA
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbhGNIMd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 04:12:33 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:42527 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbhGNIMc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jul 2021 04:12:32 -0400
Received: by mail-vs1-f53.google.com with SMTP id u7so468950vst.9;
        Wed, 14 Jul 2021 01:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfB2Bf/ewMYqgY1zZmUeNM2ulG9069p5Wk8W/IUC/II=;
        b=A0HpwRGij6+s9Albdes6+JGApM0pC+4O/ji3ogsM2f6dAY1nqG2ce5d/SJhdSKyIUP
         W3/Q6GPsKLMpIebPpoe7VwZUmZ3QH0v7Amqa79go6ZCTrL7B5IDAIEi8b1SLFx70dQUO
         810GEhKZ2SH4808B59Uk5uA28B9AV70HIh2qUv2gU+hWMzTMuCXhQthwcCMKT0gkJqy4
         7tSu9XsBWL581ljBkLYnAkeaVU90b1AJripnGuPzKU7h4Rz5eXz/Yzwim7gSgZZzXqXx
         iLtVZO8awr7JdNVgc6TeMd7zFH+aS6ds4tUJ38Kd6U4cDZsJCkUw9P2kiaQP8ozTNIvB
         MUbA==
X-Gm-Message-State: AOAM5334cyEGAUGnlHtnp0lSMQkgqKyGmD+XezDfI+TqKA2m7LvPxIJ5
        EQx3W56b9x7mYY/TB4ElRYMQLaZfM7OqbK7L9RFXOqn1Cps=
X-Google-Smtp-Source: ABdhPJwXG46ASU0GsUrjem2Rl4YE3iFNrK3VYfY8aMm6AopdEYtEcizJdl3F+jIVf3OhhYC+tL16SxU0w8lHe+5mqAU=
X-Received: by 2002:a67:1542:: with SMTP id 63mr10391525vsv.40.1626250180000;
 Wed, 14 Jul 2021 01:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210702100527.28251-1-biju.das.jz@bp.renesas.com> <20210702100527.28251-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210702100527.28251-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Jul 2021 10:09:28 +0200
Message-ID: <CAMuHMdV8VFoUC_Od9F=4On6=tZwr-qN4s4g+=_QcHQTrxrvQJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine <dmaengine@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Fri, Jul 2, 2021 at 12:05 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add DMA Controller driver for RZ/G2L SoC.
>
> Based on the work done by Chris Brandt for RZ/A DMA driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/dma/sh/rz-dmac.c

> +static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr,
> +                                      u32 dmars)
> +{
> +       u32 dmars_offset = (nr / 2) * 4;
> +       u32 dmars32;
> +
> +       dmars32 = rz_dmac_ext_readl(dmac, dmars_offset);
> +       if (nr % 2) {
> +               dmars32 &= 0x0000ffff;
> +               dmars32 |= dmars << 16;
> +       } else {
> +               dmars32 &= 0xffff0000;
> +               dmars32 |= dmars;
> +       }

An alternative to Vinod's suggestion:

    shift = (nr %2) * 16;
    dmars32 &= ~(0xffff << shift);
    dmars32 |= dmars << shift;

> +
> +       rz_dmac_ext_writel(dmac, dmars32, dmars_offset);
> +}

> +static int rz_dmac_chan_probe(struct rz_dmac *dmac,
> +                             struct rz_dmac_chan *channel,
> +                             unsigned int index)
> +{
> +       struct platform_device *pdev = to_platform_device(dmac->dev);
> +       struct rz_lmdesc *lmdesc;
> +       char pdev_irqname[5];
> +       char *irqname;
> +       int ret;
> +
> +       channel->index = index;
> +       channel->mid_rid = -EINVAL;
> +
> +       /* Request the channel interrupt. */
> +       sprintf(pdev_irqname, "ch%u", index);
> +       channel->irq = platform_get_irq_byname(pdev, pdev_irqname);
> +       if (channel->irq < 0)
> +               return -ENODEV;

Please propagate the error in channel->irq, which might be
-EPROBE_DEFER.

> +static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
> +{
> +       struct device_node *np = dev->of_node;
> +       int ret;
> +
> +       ret = of_property_read_u32(np, "dma-channels", &dmac->n_channels);
> +       if (ret < 0) {
> +               dev_err(dev, "unable to read dma-channels property\n");
> +               return ret;
> +       }
> +
> +       if (!dmac->n_channels || dmac->n_channels > RZ_DMAC_MAX_CHANNELS) {
> +               dev_err(dev, "invalid number of channels %u\n", dmac->n_channels);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rz_dmac_probe(struct platform_device *pdev)
> +{
> +       const char *irqname = "error";
> +       struct dma_device *engine;
> +       struct rz_dmac *dmac;
> +       int channel_num;
> +       int ret, i;

unsigned int i;

> +       int irq;
> +
> +       dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> +       if (!dmac)
> +               return -ENOMEM;
> +
> +       dmac->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, dmac);
> +
> +       ret = rz_dmac_parse_of(&pdev->dev, dmac);
> +       if (ret < 0)
> +               return ret;
> +
> +       dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
> +                                     sizeof(*dmac->channels), GFP_KERNEL);
> +       if (!dmac->channels)
> +               return -ENOMEM;
> +
> +       /* Request resources */
> +       dmac->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(dmac->base))
> +               return PTR_ERR(dmac->base);
> +
> +       dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(dmac->ext_base))
> +               return PTR_ERR(dmac->ext_base);
> +
> +       /* Register interrupt handler for error */
> +       irq = platform_get_irq_byname(pdev, irqname);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "no error IRQ specified\n");
> +               return -ENODEV;

I'd say "return dev_err_probe(&pdev->dev, irq, ..);", but
platform_get_irq_byname() already prints an error message, so
please just use "return irq;" to propagate the error, which could
be -EPROBE_DEFER.

> +       }

> +static int rz_dmac_remove(struct platform_device *pdev)
> +{
> +       struct rz_dmac *dmac = platform_get_drvdata(pdev);
> +       int i;

unsigned int it;

> +
> +       for (i = 0; i < dmac->n_channels; i++) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
