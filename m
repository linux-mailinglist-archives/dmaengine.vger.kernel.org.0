Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6B1BFBFC
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgD3OC5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:02:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37029 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgD3OC4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:02:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id r25so5294160oij.4;
        Thu, 30 Apr 2020 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJs/ccRnc3IpftOPmZxsp+U77POq5aMrgerBg7OaDG4=;
        b=C6sAA3TNK9HOmmQw7lHiHuhS/WEUUHmBnOScvuDjny8G++cyYWIag1+p4NiPy6WG3P
         1gYfqbxN81AFs4ooqm57N8efmbU6C9UJskl4+qcNm+HklRkKYDpSNyMRK16XY4FaT6nI
         FPIQ6oIRn2iLIqMRQZ0T9y8QI1hKzEG5lq8ihPLaLOtUAKQW1bqFF0R0Tc+0Nv0f6DUI
         LQ1FslT5nd60Y9kxFjpspqxTjCMYVXjkQF0MIx8DbkLMBBAwkeabPuzweix5Yc2Yauhl
         bVxmtHXd4W8bqdEAnmAp/Z6MiTZDU/Neq2VT+trnfpURueKAjGWPktEQE5duQzhSrF4J
         jOrA==
X-Gm-Message-State: AGi0PuaGncbbJi8W0MI02FBWyPoL4N0Q7sglndjRU5SBp+8cw3v4Ae5y
        rPuxthl0VD6vnyzPDm+lgKSzGFriPIymPAs7S+psr4rH
X-Google-Smtp-Source: APiQypJ0gb+RTtB2XK9qYeGrvR6ZbhTKXtAi0sTZFb9b/YKzwx/yPxkzE6lCQbIOJJ/J3ynAVkE1ekKFQSCnJOLDnKM=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr1887761oig.54.1588255375518;
 Thu, 30 Apr 2020 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-14-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-14-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:02:44 +0200
Message-ID: <CAMuHMdU4zynHLhxte4gHRc=G9SvcX0ghwZtFFOdN2Vp5x1=hnw@mail.gmail.com>
Subject: Re: [PATCH 13/18] dt-bindings: serial: renesas,scifa: Document
 r8a7742 bindings
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
> RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIFA ports,
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
