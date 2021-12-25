Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF547F4C5
	for <lists+dmaengine@lfdr.de>; Sun, 26 Dec 2021 00:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhLYXvN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Dec 2021 18:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhLYXvN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Dec 2021 18:51:13 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398EC061401;
        Sat, 25 Dec 2021 15:51:12 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e136so35861284ybc.4;
        Sat, 25 Dec 2021 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mab5mMpRybDmvoFxs8lTizsm2eo8VhM1MviNWFKkilM=;
        b=fueTjS1Z1RSllHtzC0ybZBt1a6OdyayQl85pLbdG1o9AIgydmuPrOFqFC0L3LvxOXl
         5foeNBGKeXHj/HpfgE8th+ow9kLSxQReYQ6mZ57GliCp8ldlT3D2VJtjalV6h+U/jqDO
         Ey+eIL628icYfvC7qDca8DjdBnUHYvJOrzMU6BA+2quGVp7WyAMJQ8IQXcYpThhXV7SN
         kwUOLd1AcsSSb5YWm0uO404rV9+0eIDr1AAbIp1IRAATKnhmY/+EDDSsOGxJGojB1gca
         Ckljl7/T/rOU4g+n2BPNaEJ1WbkIUy36KtlKGLYrx8Bdnf94/HHXkcFHfVs+CjOZKs4y
         HHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mab5mMpRybDmvoFxs8lTizsm2eo8VhM1MviNWFKkilM=;
        b=7j5ixjGDe9/qZFZrGhTskeRIRaVww1RzcFFxEJsShy+dFhGK4UXgGINDwZvnDsNHqx
         orpzu02Ukf2ydu34S3jqvUrL63qbvnmRVP6Qqnx88FOB2KSlE3Rssv9VwPLCo3d3HeW/
         vpl9616iSHrlo28HbwiSMesJzdt35uGfjp8ZxyFd6IFYW3JEMQwtzIbdM9isPAkRPSrG
         OAk/houtTuS+tQo3sVnuf7/jBzhxYGfpuTwpgKGQCOgg0l6fCv+8pMenxlL440GkFyKZ
         VgR8WpZh99KJmi21fHmXrm0ZkFaGfiqEDVoZXhqmJTeEp8fPNuPB/SZBVPHRwU5npOcY
         QV3g==
X-Gm-Message-State: AOAM532rtFh3sGiHHri28GQPl/hgMbHhTPwul6pvhe4hGNY6GSwCwv+0
        C8xlddKXaQoJSgi/4UkR23NIWb7OeRVauMvB9J0=
X-Google-Smtp-Source: ABdhPJxaY58w66BUMhpMOlodVvGGr1c4xvmHif1u7BWvphaK7ALNnNzFzgtjxpRUkiSpw1KzFZtZkr1oR9Q6i4LT8jg=
X-Received: by 2002:a25:1004:: with SMTP id 4mr15364823ybq.669.1640476272202;
 Sat, 25 Dec 2021 15:51:12 -0800 (PST)
MIME-Version: 1.0
References: <20211222161534.1263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222161534.1263-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VfC-1Lt2JZ-e_ReySNQTOwOfBi6JLOjEHUMNEyYk5JVyg@mail.gmail.com>
In-Reply-To: <CAHp75VfC-1Lt2JZ-e_ReySNQTOwOfBi6JLOjEHUMNEyYk5JVyg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 23:50:46 +0000
Message-ID: <CA+V-a8sXwS2FMjgNhLAGcsTT46kAjuh+N4BC78MUFvvptnjjtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: nbpfaxi: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 5:47 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Dec 24, 2021 at 3:14 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > There are no non-DT users for this driver so interrupt range
> > (irq_res->start-irq_res->end) is no longer required and with DT we will
> > be sure it will be a single IRQ resource for each index.
>
> >         for (i = 0; irqs < ARRAY_SIZE(irqbuf); i++) {
> > -               irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> > -               if (!irq_res)
> > +               irq = platform_get_irq_optional(pdev, i);
> > +               if (irq == -ENXIO)
> >                         break;
> > -
> > -               for (irq = irq_res->start; irq <= irq_res->end;
> > -                    irq++, irqs++)
> > -                       irqbuf[irqs] = irq;
> > +               if (irq < 0)
> > +                       return irq;
> > +               irqbuf[irqs++] = irq;
> >         }
>
> Same comment as per other patch(es), i.e. consider 0 as no IRQ.
>
Will do.

Cheers,
Prabhakar
