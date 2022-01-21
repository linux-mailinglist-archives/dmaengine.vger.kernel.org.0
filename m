Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF44495DC1
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 11:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380010AbiAUK32 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 05:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380005AbiAUK31 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jan 2022 05:29:27 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88455C06173F
        for <dmaengine@vger.kernel.org>; Fri, 21 Jan 2022 02:29:27 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id o80so26303119yba.6
        for <dmaengine@vger.kernel.org>; Fri, 21 Jan 2022 02:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8w6xWRpa7rbpkggVeukinLzBFh9GxZQwFDGtpRnC44=;
        b=m52NB69onp/zx9ahchIitMVkr5LhjxaNcYFjkdcinu6bnm9NAQJTjMrHBbkgeM9OfC
         HXftb2G62xf1sm5KLZvxgQ3rvesY+Sc/YcBdei2LGNQPra9qIgiu+UDhbDLA/VlfLBNt
         skF2g3Rsb9f2kPHcPaRq4sQv1t9DmTSjopwjSJ3rTiLL8Eua0dYVlPgXR0O7SbecPdOj
         6s2IrOUSUF9GNbarrDN+oMV7NtJ0sWXDzbFR7oEP8DyZq8+FHuynvTWwPi7p5nB5xNwS
         gYi+WSDxq/CnJBmKrW3oQXzXVfOQqViHni+3d2n5l4giZdSD6XLNDjEMoA6tfnqg5H1N
         /vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8w6xWRpa7rbpkggVeukinLzBFh9GxZQwFDGtpRnC44=;
        b=GSayrUS3pZIdW2KHj6VPXioj6EoGtvXg9678R875vfer7gwkz4Z2XCkYzUE550kjYt
         JFjmZSUysXDqyonk5OtdAwAjY/68UfdRlDcA9Rl5Vyo1FH8EcrOR/jenhR4vrz70fZPE
         EB3POFyVA9/BQiQ8GirpwhT/kazbesBY0r67F5RP7hR5Mx1YOHrwgK2i4RqVfu7GbGkq
         RyDgXQPS/LTHChfBNdc9y3L/TLbo/zjqhTgK3vWVdbDLEvtJNPFjIIG3SWqTpmSRVcq4
         AzieWzkQ0kGtB3gZBMzr/Vue0O7Bl4p2La5gAfZC2E6x2snqM3aacwqzaUHw31F7uKPH
         aVGQ==
X-Gm-Message-State: AOAM530GeG/+Gt8iEJD41g/BHT6/ustklMTPP1BQV3V99OeA6bxxR7Mn
        ble+/tM1xuZmyGCD/HJqii3tyIx6OK1YYCrNPpwJaA==
X-Google-Smtp-Source: ABdhPJxm744i+nISDqxOsYuvMp+v23wPfnB2Z/8fLa4of8nEAD0vpc980qigY5xY1bfcMU3/heJwA/3CEi3t6OXMJUQ=
X-Received: by 2002:a25:2507:: with SMTP id l7mr5166575ybl.526.1642760966773;
 Fri, 21 Jan 2022 02:29:26 -0800 (PST)
MIME-Version: 1.0
References: <0d0b0a3ad703f5ef50611e2dd80439675bda666a.1642383007.git.zong.li@sifive.com>
 <mhng-5b3e2596-3558-4534-9229-26885ee4cc5c@palmer-ri-x1c9>
 <CANXhq0ruGxjO0WPUipzZ7QQM1oEapyHAvb_aVQ_CMqVxbjc_BQ@mail.gmail.com> <CAMuHMdVh_cXpbUeOmr_1K0dOJwGHSO0Ao=W43j5mpgvOiNyV9w@mail.gmail.com>
In-Reply-To: <CAMuHMdVh_cXpbUeOmr_1K0dOJwGHSO0Ao=W43j5mpgvOiNyV9w@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 21 Jan 2022 18:29:15 +0800
Message-ID: <CANXhq0oTrVMhY19odFHroJKXmW1dROdS5J5YR-osO9uwbr9GKA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dmaengine: sf-pdma: Get number of channel by
 device tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 21, 2022 at 4:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Zong, Palmer,
>
> On Fri, Jan 21, 2022 at 3:21 AM Zong Li <zong.li@sifive.com> wrote:
> > On Fri, Jan 21, 2022 at 2:52 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > On Sun, 16 Jan 2022 17:35:28 PST (-0800), zong.li@sifive.com wrote:
> > > > It currently assumes that there are always four channels, it would
> > > > cause the error if there is actually less than four channels. Change
> > > > that by getting number of channel from device tree.
> > > >
> > > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > > is no 'dma-channels' information in dts.
> > >
> > > Some of the same wording issues here as those I pointed out in the DT
> > > bindings patch.
> > >
> > > > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> > > > --- a/drivers/dma/sf-pdma/sf-pdma.c
> > > > +++ b/drivers/dma/sf-pdma/sf-pdma.c
> > > > @@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
> > > >  static int sf_pdma_probe(struct platform_device *pdev)
> > > >  {
> > > >       struct sf_pdma *pdma;
> > > > -     struct sf_pdma_chan *chan;
> > > >       struct resource *res;
> > > > -     int len, chans;
> > > >       int ret;
> > > >       const enum dma_slave_buswidth widths =
> > > >               DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
> > > > @@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
> > > >               DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
> > > >               DMA_SLAVE_BUSWIDTH_64_BYTES;
> > > >
> > > > -     chans = PDMA_NR_CH;
> > > > -     len = sizeof(*pdma) + sizeof(*chan) * chans;
> > > > -     pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> > > > +     pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
> > > >       if (!pdma)
> > > >               return -ENOMEM;
> > > >
> > > > -     pdma->n_chans = chans;
> > > > +     ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
> > > > +                                &pdma->n_chans);
> > > > +     if (ret) {
> > > > +             dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
> > > > +             pdma->n_chans = PDMA_MAX_NR_CH;
> > > > +     }
> > > > +
> > > > +     if (pdma->n_chans > PDMA_MAX_NR_CH) {
> > > > +             dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
> > > > +             return -EINVAL;
> > >
> > > Can we get away with just using only the number of channels the driver
> > > actually supports?  ie, just never sending an op to the channels above
> > > MAX_NR_CH?  That should leave us with nothing to track.
>
> In theory we can...
>
> > It might be a bit like when pdma->n_chans is bigger than the maximum,
> > set the pdma->chans to PDMA_MAX_NR_CH, then we could ensure that we
> > don't access the channels above the maximum. If I understand
> > correctly, I gave the similar thought in the thread of v2 patch, and
> > there are some discussions on that, but this way seems to lead to
> > hard-to-track problems.
>
> ... but that would mean that when a new variant appears that supports
> more channels, no error is printed, and people might not notice
> immediately that the higher channels are never used.
>

I guess people might need to follow the dt-bindings, so they couldn't
specify the number of channels to the value which is more than
maximum. But as you mentioned, if people don't notice that and specify
it more than maximum,  they wouldn't be aware that the higher channels
are never used. It seems to me that we could keep returning the error
there, or show a warning message and use PDMA_MAX_NR_CH in that
situation, both looks good to me.

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
