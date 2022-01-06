Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59A3486194
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jan 2022 09:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiAFIox (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jan 2022 03:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiAFIow (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jan 2022 03:44:52 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964EC061245;
        Thu,  6 Jan 2022 00:44:52 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d201so5395555ybc.7;
        Thu, 06 Jan 2022 00:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oh23BjoKFzAkuG9NnxICbp39CiGWdcw5gpXaXCR0gv4=;
        b=SDoA0JU56MlWxVUqde4e+r/Qk/EhEUwnd157f6jKhWFrQhlnRaGdHmY5Hgt6HE/LtN
         H3JR8g6ajSPTD54T1IFH25bcu/wBh2cnFsigURyxJjOF8EykEgXUvwURqZGEQpkP5QM0
         U31VLkZU3F0DhluyoOCeFJ7wnCssDevX8PF4LVkIiIRpnUdMnrSqTA/FlGRzKi8Cu0OQ
         MTEN2Gwz6tQJlMkoCosohaBGLn+CR6IPpfOF06D8fDH99fyZW6iK6SgCWgfPZU/O/BvU
         PEpdfDuk+9+ctgdfP5iF1FbQuGYsNvIdgHV9DPR7YnV3eZiemvcoWvUB0K6mgIP658KD
         lc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oh23BjoKFzAkuG9NnxICbp39CiGWdcw5gpXaXCR0gv4=;
        b=Pc0gpbT+0SBhVq54faPltjArYchcyammic5YkHN/KU4ti24afpbe5SBbMqfv/YEoJ8
         yfAoD1ndL0S9syAGT2vuFuODe4DinoTgRiQP+YEYO3OhWg946gNUQOaMq08+2CaCSEIn
         leufiOzX0ffal0S1FVayqzNqEJNgHRZBTmofp6o8EZwJVh3U5QbJwwXOnfHW3lhOjSv4
         ToJku4Peq2k2c0jhsPRXJfz1Y0su+S4tu06SCP0rcvtQvjS6s+qTYY5+aBNg2sC3hqGM
         QmCdFsWdQvdYipjhaFA2J2GQ//MzcvDoo/f1sAzE+Zbguez9/Kfp+U0nYfnRO4QzQP3t
         OWmg==
X-Gm-Message-State: AOAM531OVFAg4Ib3j+78OGw+yfrquqNYaREoQUgqnyUfNc16huUnuD7b
        UjTygIbR5fks2v4o3QWvKZ5ygd88ZbvdtfyqSGs=
X-Google-Smtp-Source: ABdhPJw9vxajmAvvj3b+nKVLj9oHrVmIGPAkG7ay1+DYFjTGWUO3lmz8SjL8jkJOZNrqNJ0ZIDUOCTX4Hf4zjwdy7vQ=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr73638815ybo.613.1641458691689;
 Thu, 06 Jan 2022 00:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20220104163519.21929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220104163519.21929-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <YdZ9rDvYtdu8L8Vb@matsya>
In-Reply-To: <YdZ9rDvYtdu8L8Vb@matsya>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 6 Jan 2022 08:44:25 +0000
Message-ID: <CA+V-a8sO0AioGJh23jdFWoN_Qx9rm_3skYcCeyrWZVAuRtuOSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dmaengine: mediatek: mtk-hsdma: Use
 platform_get_irq() to get the interrupt
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thank you for the review.

On Thu, Jan 6, 2022 at 5:27 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 04-01-22, 16:35, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * No change
> > ---
> >  drivers/dma/mediatek/mtk-hsdma.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
> > index 6ad8afbb95f2..c0fffde7fe08 100644
> > --- a/drivers/dma/mediatek/mtk-hsdma.c
> > +++ b/drivers/dma/mediatek/mtk-hsdma.c
> > @@ -923,13 +923,10 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
> >               return PTR_ERR(hsdma->clk);
> >       }
> >
> > -     res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -     if (!res) {
> > -             dev_err(&pdev->dev, "No irq resource for %s\n",
> > -                     dev_name(&pdev->dev));
> > -             return -EINVAL;
> > -     }
> > -     hsdma->irq = res->start;
> > +     err = platform_get_irq(pdev, 0);
>
> why not platform_get_irq_optional() here and 3rd patch ?
>
For patches #2 and #3 the driver expects the IRQ to be present
strictly, that is the reason platform_get_irq_optional() isn't used so
that the behavior of the driver is unchanged with this patch.

Cheers,
Prabhakar

> > +     if (err < 0)
> > +             return err;
> > +     hsdma->irq = err;
> >
> >       refcount_set(&hsdma->pc_refcnt, 0);
> >       spin_lock_init(&hsdma->lock);
> > --
> > 2.17.1
>
> --
> ~Vinod
