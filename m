Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0035F47F423
	for <lists+dmaengine@lfdr.de>; Sat, 25 Dec 2021 18:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhLYRrY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Dec 2021 12:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRrX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Dec 2021 12:47:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B9C061401;
        Sat, 25 Dec 2021 09:47:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y22so44909930edq.2;
        Sat, 25 Dec 2021 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGUNV55wraKWttlHu9LEsxw2TMdFSIetUkp+Aa5vOlw=;
        b=jvMxGG2qz701VH7PS5s1+nb3Z9EUfyfO+MeYE6dw1gHB7kICCA0bZUN9qosVmcpvrD
         Vv2jc+BnVukAgcIKHQAhvF6bZ5nLDjQNTDfJAmG/UBV1vhY+8QZLg9mORq8BGvRRTbML
         JKvGPmuvE3UcRMumC002eUUO7X26fvTPYhdqhC1jApLGt0lhX7hSy7I20913r6/9CtsV
         atUnvumDY17hms6SByBTOgwN5Bzkls9ePsKjDMURaYSqkbH0jmcUXZZDBaBAVJY4EerO
         BuanjrOvfciZZFIVPijfT5OnxsNYbIHd/LXYzM5mXaa2Qr6qwrXM7tRp6ipvYyB3WCek
         316Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGUNV55wraKWttlHu9LEsxw2TMdFSIetUkp+Aa5vOlw=;
        b=JCuIPR1/XbYauxGS5wdkzd+5gQ0V88lQT0XFfvZlxGhUwPRut1kIzqvIJ/e62l059D
         Hr7Svq9CVHSXdPU7t7a5abrKWPuzJ5zkJ+AtGHwbEru0RkicNmcKn8zNenRn8FL8+unx
         wbqos2O8ynQXquOgo+BUf5mBBr1LG08+JMusl4u2bnKgfhJTrwPZnIPrY9+s06uuKfu9
         6YxQDOv6R2UfJlnH10iyjiqEeQzcEoe20WNKK+Rt3arGoZXhA1yfEV1SsFPxMkuwKikW
         ANe6RbWAI1ZhgM0J0iKHZcvs4tJsejUq3yRA0NLNi5VBQcfOJRa/tI1Dx55f+1K5xeYr
         9wPw==
X-Gm-Message-State: AOAM533PXsEUj3lduur4cRsL75vkZATSsoBR7mg2mp6UbxoDNr1VFZCl
        R6Zn1LoGS8Y6Ogz5CnleKHrgCZmAqVL5AFOHeB8=
X-Google-Smtp-Source: ABdhPJyidpd9u5ux/81gVytN22NQ9SN65KnC06z6cIHTHqerrI7WWeQin+0FapdM5Hb1MSG1DYvDHJ8AKXbcja9W6Bw=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr8680594ejc.44.1640454441883;
 Sat, 25 Dec 2021 09:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20211222161534.1263-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211222161534.1263-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211222161534.1263-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:46:45 +0200
Message-ID: <CAHp75VfC-1Lt2JZ-e_ReySNQTOwOfBi6JLOjEHUMNEyYk5JVyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: nbpfaxi: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 24, 2021 at 3:14 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
>
> There are no non-DT users for this driver so interrupt range
> (irq_res->start-irq_res->end) is no longer required and with DT we will
> be sure it will be a single IRQ resource for each index.

>         for (i = 0; irqs < ARRAY_SIZE(irqbuf); i++) {
> -               irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -               if (!irq_res)
> +               irq = platform_get_irq_optional(pdev, i);
> +               if (irq == -ENXIO)
>                         break;
> -
> -               for (irq = irq_res->start; irq <= irq_res->end;
> -                    irq++, irqs++)
> -                       irqbuf[irqs] = irq;
> +               if (irq < 0)
> +                       return irq;
> +               irqbuf[irqs++] = irq;
>         }

Same comment as per other patch(es), i.e. consider 0 as no IRQ.

-- 
With Best Regards,
Andy Shevchenko
