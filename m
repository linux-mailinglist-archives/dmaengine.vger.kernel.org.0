Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E001C0F56
	for <lists+dmaengine@lfdr.de>; Fri,  1 May 2020 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEAIUW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 May 2020 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgEAIUV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 May 2020 04:20:21 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFBC035494;
        Fri,  1 May 2020 01:20:21 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x16so560686oop.13;
        Fri, 01 May 2020 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xmDrknoIK7bXjgHNUmPbIHsbFNrCtpw+rgXposQwms=;
        b=O5Bdg7qQzAnlPhD7xVJhnqshnj7xNmXBKRGbWbhp2T9vzzM1MpFW+E+RYCzOknKpj8
         ky8+dFqN4sKrq5u57LLjx7VY+/3/WsZskllAALIAtybnzNJR5vjiggO1UpC+6aDbbu9t
         kydHSvKLXU7sGWkz9y9RVKviHgYZWyYOdg2x61aI7Ws5OUMZX6mszoJOTXjCYgE1kCG3
         YxX1fPKMUR1N/tfPH7XlGmuqZdaT3kJbh6CaQQU6+twLEmxTOFlPMFYj1ocjQyMHVXpF
         B5EvjhnHPr8btv+Tyz5UgmMlUf682frU/Xa8+Ff2S6K0/HOvwKzJmdLj2aYf5auUrllc
         1zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xmDrknoIK7bXjgHNUmPbIHsbFNrCtpw+rgXposQwms=;
        b=hYWFBVCawSjWwMhj3q/lDfMxofxhjOEbIkJWVjFwEUC3insRhZQlVlRhYkGkLwlyku
         TYFA93a1l4kwHrkLn1mZj5Y8v77RiURD6hILCtu/PXILTTzLzP6xYcuoC3N8xX0LqOv9
         LKGC7lAwIPw/rlWIFWLPYNWHspWuLfqL/hgjDY+X3n+EECC7LoNjFoctbhNLhlPZ929u
         bXQefpc3OyzoMNazJ0b/lr7QIlG30yOMVC0IASBdofqtVnduRrTxGjWHLb3+40hErQIe
         BS0KkLFJZL88gjEPQ1RCGDcgjBW8ugTV2RkDoaBncQA4ixsGcbsdgivaZ7ampn5v1PJ4
         AhOQ==
X-Gm-Message-State: AGi0PuYl1v3NaMJ6XKl2nDoyJu7I3FGlF55ANp+dcz+b0xI8dQapIZY3
        Uo8wyOeYhi1NST9m3fq106ZzpgIcwlknfJI/xhfLJMpQoZw=
X-Google-Smtp-Source: APiQypKWRZyPptVG5tDacv48mYRSDp6n8y852TNesK+NocS5PxHwyt2eSwaWJhO2Yzy3GzH7tq6UeX5cCu+1f17mElg=
X-Received: by 2002:a4a:a209:: with SMTP id m9mr2850194ool.62.1588321221043;
 Fri, 01 May 2020 01:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXEu0i8APM+g3TWbkfkLbYtCzi7uJABvMscS0a_j030tg@mail.gmail.com>
In-Reply-To: <CAMuHMdXEu0i8APM+g3TWbkfkLbYtCzi7uJABvMscS0a_j030tg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 May 2020 09:19:54 +0100
Message-ID: <CA+V-a8u8r+zT-HSHqPQdRfCKOmx=-a_GrTTM1ZQueOwnvT8xeg@mail.gmail.com>
Subject: Re: [PATCH 04/18] ARM: debug-ll: Add support for r8a7742
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On Thu, Apr 30, 2020 at 2:03 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Enable low-level debugging support for RZ/G1H (R8A7742). RZ/G1H uses
> > SCIFA2 for the debug console.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -976,6 +976,13 @@ choice
> >                   Say Y here if you want kernel low-level debugging support
> >                   via SCIF4 on Renesas RZ/G1E (R8A7745).
> >
> > +       config DEBUG_RCAR_GEN2_SCIFA2
> > +               bool "Kernel low-level debugging messages via SCIFA2 on ARCH_R8A7742"
>
> R8A7742 (without "ARCH_"-prefix)
>
> I can fix that (and the sorting issue) while applying, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v5.8.
>
Thank you for taking care of that.

Cheers,
--Prabhakar

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
