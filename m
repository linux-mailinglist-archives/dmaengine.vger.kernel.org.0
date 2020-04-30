Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E71BF90C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD3NRP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:17:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45616 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgD3NRP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:17:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so4803502otk.12;
        Thu, 30 Apr 2020 06:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYuSc1eBkZJQojwW+mycEWGyCJ0BWkp4Uav1Yp+waH4=;
        b=undtWtvT2mHdlVAjkAxpA6HjFxe07ox1UQKkExR4jfUjZIDVL1bVpAwaQiAPvL6zEk
         EpZYpRm6vNziyuj6hmp5Rc5FEGdq8XEVZokGpVopJqdDFhA0O771cvfOuGrzE9D/hWn5
         AEdK1zyOz/sYzMTBBoeAUj6sHYmNh7liv6lbbu1rRGiBwoRThxh3FTEVK++zPOLagWkr
         SvxlnmOSiXt1rmd8ailRb3CB+3jf+A3OpIH9BUAFu7aFihk9ZMQ0iJxzyNW+zJ6ZFZiY
         5qQh27i0hGWqE4E01QweWMIRp2ea6lKyqPoZaYeOjdFozX1AybtnSYqMsaw6liV8X27A
         eWzQ==
X-Gm-Message-State: AGi0PubbWhzngmYMl2/PR2e08Zu2FRwmwRf/l0wxx7Mim/Z+rmjo7vo5
        2EtinPMk0SHObdbdV9fpNpzN8axcuAD0lTOpzxc=
X-Google-Smtp-Source: APiQypIgBXU9BSTQiGJjGVpm37UKzZ3o3uIg7xCulwGQee8j0/6+X/C6FX1fA+tIeRv6xErPA9HMWzTT4VA6MAkCalo=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr2302946otn.107.1588252634888;
 Thu, 30 Apr 2020 06:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:17:03 +0200
Message-ID: <CAMuHMdWNSgqfCd4ZGR4Y-9M_-nKH7nO9aNcQ9z-E97CB4E5Zbw@mail.gmail.com>
Subject: Re: [PATCH 06/18] pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
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

Thanks for your patch!

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/G1H (R8A7742) is pin compatible with R-Car H2 (R8A7790).

but lacks several automotive-specific peripherals.
So please split the pinmux groups and functions in common and automotive
parts.  From a quick look, for now the latter is limited to MLB
groups/functions.

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

The rest looks good to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
