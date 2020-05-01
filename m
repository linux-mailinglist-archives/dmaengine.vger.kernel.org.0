Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010A91C0F24
	for <lists+dmaengine@lfdr.de>; Fri,  1 May 2020 10:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgEAIJH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 May 2020 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgEAIJD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 May 2020 04:09:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C51C035494;
        Fri,  1 May 2020 01:09:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i13so2095034oie.9;
        Fri, 01 May 2020 01:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pg+1ScPrEODM3uAFA9zTWu/I1ZfaUw4KVmoBAKoheA=;
        b=YhXnbMYvvL2NERhKKxsDO4eX9F2iF5QES+58BPMPdkDa7+HWnKRPXBtihaQRlx5jhJ
         ZJ+u6PNVJetL8DPyXrHPuRXEcd5/bi3d1s+fxldrozxvCiSxYrfbkwMuRZOHt7so1kAn
         aiEHVbhCFKQAXa1VhD+k4dfmV7tkNmjJFq0NAXNXDGY0lueDa1Gg4pPmbic0IFrkPRlN
         MIr4KPcfXB2XLJFMMuVotJ6iBWmim1etULPjiMGfMuxcGrgUBWdsfJIZUHIjejVd2NMD
         zLRXjnFO6JT8OhAo0LD0S9lYl11vXLyJc2xc2LLFyC1GgYs46wc1cH263vVfeZ8MTfER
         CRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pg+1ScPrEODM3uAFA9zTWu/I1ZfaUw4KVmoBAKoheA=;
        b=ParBG8551fVXdvJgmfb9CwMd5zAxRTHOSIEJZDXc/0yR8BIx1tgpm/n2L5x4R8F22L
         3N/4vtM7rmziXk/SOshOoICm13/k4RPZ8CT9KL+lLlImInI+Lnshx5slslsS51KHdvRd
         GMDXxbcprAB2/QXd03DEog+F14+fuGcGFuzsw9bzR/IOGf4OWt/4UctxIgEG6b/vt3RB
         VcYSSuIY8ia9fxK+ss45xnoHiBC/9adoPUPstk+76kxLmth6kwB1Dv/f6Ee9gW1lR5Ay
         aFLvNqLM/jfkWDBa/0fyKvOi1o7k2l0S/fRlcsfYcd+uJ1OCutVF1oy8M5wWlhRF9qyD
         njug==
X-Gm-Message-State: AGi0PubXLoX1c+QFSn2WFa7KR2f+6KXBjCOJAZS+DzSZ6U67UrCg6mEk
        UnkZm6Tl066FwJoXpX+Tz/8sDrPfnN6oxktxkvs=
X-Google-Smtp-Source: APiQypL4tkkgblP6s79WD1Ii4byJ0FZw7ndmwSXmo65KLcrLpTxyQBgTjG8TlCh5OP8wJ/Y3Cf7Oky6dSkWu7P5a6UQ=
X-Received: by 2002:aca:b18b:: with SMTP id a133mr2294802oif.142.1588320542697;
 Fri, 01 May 2020 01:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWNSgqfCd4ZGR4Y-9M_-nKH7nO9aNcQ9z-E97CB4E5Zbw@mail.gmail.com>
In-Reply-To: <CAMuHMdWNSgqfCd4ZGR4Y-9M_-nKH7nO9aNcQ9z-E97CB4E5Zbw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 May 2020 09:08:36 +0100
Message-ID: <CA+V-a8s7s7=kxOp9ohrMp+o6KDuO-Vn6P7YX2L6fC1=_A9kVwg@mail.gmail.com>
Subject: Re: [PATCH 06/18] pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
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

Thank you for the review.

On Thu, Apr 30, 2020 at 2:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Renesas RZ/G1H (R8A7742) is pin compatible with R-Car H2 (R8A7790).
>
> but lacks several automotive-specific peripherals.
> So please split the pinmux groups and functions in common and automotive
> parts.  From a quick look, for now the latter is limited to MLB
> groups/functions.
>
Yes I can confirm its just limited to MLBP, Ill split up into common
and automotive parts and send v2.

Cheers,
--Prabhakar

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> The rest looks good to me.
>
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
