Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E214C1BF8C4
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 15:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD3NDQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:03:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40933 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgD3NDP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:03:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id i27so4803899ota.7;
        Thu, 30 Apr 2020 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPxWzD7KDAoXAsEKx6r6DlSZdVX/2/j3BmdPPiNmmUk=;
        b=CiKWp0DZgoX4z60sobkRIZPYTjm3kWHmbZsdYvuhsC+3t3vE2hRk41EvOMGvw6wsZ2
         D5tIV/mtPQg7sHVrorwgNDH1bcrqIC0Hs1+yCpg8I4ONXvEzMBuoie7nCor1g3yK/RT6
         7/uYdY3UWS1izXsTeC7D5b/02yVQZjhLopH0ZJlQ8fEqOUKtXMLBPGKveEG45w3uMGTZ
         FISy1cEHBLv7W78uPTjr8oaES+4Bb0i204DpLpMIPvtOzQmGCjOUmItBqd/xMGI+BpJr
         lD4mqQcAItvoWMNhnNDYGk1clpEtF7EY4pF/yBgXeORyTc4ai8zsK1wEls13C02Xjdrc
         bjKg==
X-Gm-Message-State: AGi0PubSMAO5u4wq6F5PZxgZejotumZmZtY05BW/kpvMXH781HuyXSd5
        WhaVNzauWBVdocmCb1ZK1X91cvnGpCRdHwakMfI=
X-Google-Smtp-Source: APiQypLffzvlZkntNwieMuPXx5W5WCKlm898qoNdXGpbuVMWO5D2B4Wdg+zmy4m1OurTy544WOAOJHj9HDm1I+Pxav8=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr2340643otm.145.1588251793175;
 Thu, 30 Apr 2020 06:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:03:02 +0200
Message-ID: <CAMuHMdXEu0i8APM+g3TWbkfkLbYtCzi7uJABvMscS0a_j030tg@mail.gmail.com>
Subject: Re: [PATCH 04/18] ARM: debug-ll: Add support for r8a7742
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
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

Hi Prabhakar,

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable low-level debugging support for RZ/G1H (R8A7742). RZ/G1H uses
> SCIFA2 for the debug console.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -976,6 +976,13 @@ choice
>                   Say Y here if you want kernel low-level debugging support
>                   via SCIF4 on Renesas RZ/G1E (R8A7745).
>
> +       config DEBUG_RCAR_GEN2_SCIFA2
> +               bool "Kernel low-level debugging messages via SCIFA2 on ARCH_R8A7742"

R8A7742 (without "ARCH_"-prefix)

I can fix that (and the sorting issue) while applying, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
