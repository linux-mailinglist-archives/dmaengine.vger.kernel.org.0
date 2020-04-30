Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB01BF89C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD3M6G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 08:58:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34004 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgD3M6G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 08:58:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id x10so5124393oie.1;
        Thu, 30 Apr 2020 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f06O0cFyNEo5gvdIcg9Ddsp0/DFy3D1D3kCWuQbyuVo=;
        b=gr2qjHMiU5xPcitYfVMFtXs4f9Pgv9gTTVab4u3LKNAJOh+xw8wqSoI+S1grCCQX8J
         DDaqiWX5lhk9GQ6DnfU4ui410l2o9DWtSud4kRuPdi2W2dbxPi+7CEeTQMdBFGQuKIZ0
         4/Xr3bhCL0sEAZf+PYpdywW++tWUBayNxUk4IKhsqFJ+Dw6Tu0Ivl/hDmNGLYMEs7qZP
         8tJBBDh7jZ/rsyRg9RXDbyWwynTFUSt67UwkP71OXw0cyOHpMwupjB2fB+dPd6Lq/i/I
         nU02fPSyZvR9eYzaAqUyOvOWOe49oAX4puHD7eC2RDMFqGPi9J/gwREcjFkBKMudtNT9
         hcSQ==
X-Gm-Message-State: AGi0PuZoT+A/oTBy+5GA7fiqYKgNQGVLO4lMgYnayVpkGF6Iw0kIfSbr
        0IxlUSa4Y/5R6uq3srYA0Bm+LtSFZI+Rso6llxw=
X-Google-Smtp-Source: APiQypJ96idTKZgifmCnQ6wUrxkX/7Ep3RkgKRx5bDPk1I41cxrwHGqHte5K9ORdTBr3+oxbhTyMJGSH5dmCUBLUFsQ=
X-Received: by 2002:aca:895:: with SMTP id 143mr1527059oii.153.1588251485338;
 Thu, 30 Apr 2020 05:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 14:57:54 +0200
Message-ID: <CAMuHMdWEo9h7HxePSDXbzVvqfdCsUUgmZ3rvuYjA2g-kqJWYWw@mail.gmail.com>
Subject: Re: [PATCH 01/18] soc: renesas: Add Renesas R8A7742 config option
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

On Wed, Apr 29, 2020 at 11:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add configuration option for the RZ/G1H (R8A77420) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
