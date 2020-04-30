Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009F81BFBCF
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgD3OCD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:02:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40118 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgD3OB7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:01:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id i27so4963929ota.7;
        Thu, 30 Apr 2020 07:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVFdq6UQxDJKbsif1NQfby/13W9nh3L9S4lY7xpqo6Q=;
        b=m9QNoe/dBuFvKS+KAVhOQqSyXFhfKnRaXxAa5VbyfPGh1Xz0O6dKnUEEO+i7Qp6P+C
         fAjHMJckPD+0PwJPZ/4/28MwrTNzVqvmPS1p+tsSFJSBKzFRjg79hwndaRQv5bh5EiUP
         vTDwOZLE+FLPJ7CtqpwI8P6SQvN4fLLRrAWX+jIgUge8JjBN2hreycBVEq6MkErZZ72r
         FpH4Z5YPxWNjBCVmcQS0TyN2a5IhTL9WM7O/MdlqlKuBj4/NZBSVYWDqquoc3JSVOm0C
         caSQU5qeSWbfrHGMY+9prdRN+S1839uk5cDqvCneEH4rJlldsRTDD+Ui0KcAJ3MGjwdT
         giiw==
X-Gm-Message-State: AGi0PuZxA/QzzE6rudqw6bO1bYNTxCDFq8oLuPbzH0P/aPVWQchrzaT0
        2kJpcYnfJlPhC/2ax2ggzfYLC/SOOITuTbahxzE=
X-Google-Smtp-Source: APiQypJUIE+IYTO5+NZ/A/sZ/oDHSxSbaWQRCNupntk+tPRhXXvE+d6x6FrwKggI4wtqfQWZDSOEK5v9pvRt9F25u+Q=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr2567757otm.145.1588255317529;
 Thu, 30 Apr 2020 07:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:01:46 +0200
Message-ID: <CAMuHMdVzcGnSZqPx0ZXXt7yahp5app2BW=GHUxgvNgEVnamLMg@mail.gmail.com>
Subject: Re: [PATCH 12/18] dt-bindings: serial: renesas,scif: Document r8a7742 bindings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIF ports,
> so document the SoC specific bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
