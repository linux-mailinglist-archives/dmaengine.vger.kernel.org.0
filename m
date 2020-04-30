Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A214F1BFE3C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgD3O2y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:28:54 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42705 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgD3O2x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 10:28:53 -0400
Received: by mail-qv1-f67.google.com with SMTP id v18so3061297qvx.9;
        Thu, 30 Apr 2020 07:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVWzBYKJUQDuVX/btoJY+6LYMrXr1RGguk9M1fRb2Gk=;
        b=c1Eh+42PwFYobzAMNbij4wSLEGz4vv46XYNuXdkPgCmPVjYZArbDfkK/p/YMpGFZmL
         MXShKaudt8uvF34kkiRA/Hkqv+pgBXDbLnspBQm8cJUcki1fnNujFxU0u/97UnL+e9rs
         8JB2WRxhq8ozW5FUMUK3p5YDesuCAwUcUftH+sWfzQU2vzA15YF98HKoe5F+cmHC2nUb
         CpeyMPE3NstsFVrH1gyeLXTKz3Ib/h0VdLb3ohIvJbKb+UmA1Ikxa0sDWYQjYGLMVUJF
         aB6RKfDP9JaVvXsv4StGnTYqYnrbULSkr0FK4OMjzEPDSf2LMSbHm/DXEV3+xPf1nYPX
         oJgg==
X-Gm-Message-State: AGi0PuZvgzW2Z058tmlVsBje3plgsNacnB2ev/8A0cPPhC8zUToYbkxQ
        7JRw6m7hLNzvXyydQX3cJlulhHJ1OY5Tcfy7Xqo=
X-Google-Smtp-Source: APiQypJRTf/ui9dNutw4tN535a/lPdlLEOpjjfiChGE7kI685qtINjYPuVWS/8HbqUbbyS9WsJPmByFOcVrXUvlv1Rk=
X-Received: by 2002:a0c:ec8f:: with SMTP id u15mr3355852qvo.102.1588256932282;
 Thu, 30 Apr 2020 07:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 16:28:40 +0200
Message-ID: <CAMuHMdXrX-Crdgjx31LzYpGabfMcZ6GcVQuUFo64Dxd3y3orgg@mail.gmail.com>
Subject: Re: [PATCH 17/18] dt-bindings: gpio: rcar: Add r8a7742 (RZ/G1H) support
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

On Wed, Apr 29, 2020 at 11:59 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/G1H (R8A7742) SoC GPIO blocks are identical to the R-Car Gen2
> family. Add support for its GPIO controllers.
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
