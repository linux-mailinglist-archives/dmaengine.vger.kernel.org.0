Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958171BF8D6
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD3NER (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:04:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42487 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgD3NER (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:04:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id m18so4786277otq.9;
        Thu, 30 Apr 2020 06:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8uSpmhwBDQ1U9t+PlYqOYkuJzr7dXp1+naCrrRJGfY=;
        b=slOtTPldluIQvsCBZyrXip9p3qdoe/Qe6+WmHWW+5XCDnXAIatIHcrSjh/w/2DMF4s
         HUyS/y8TR3GlnTJcy5m7z7m9UnxNz+st7KYGoN2x86fDNE+5uZdTnJf0T+VWWZff/Au0
         vEBmr9nxd9emLIKPil7TqVYap1rwMFMPMcefelm6jdrz52zy/ZLT6bQxWebdblAo9L5i
         GNG2Wyh/oYzab3lfdSb3jPhpNLjMOk6h1YtTLXdaa3Jg9BJ2QxFHDlG35Okr32FHY1sc
         x4jkm15WxCkZvwNJO4y9FyfVTx+xyCDiV4Q7VrHYaXFBF3o6+G0kWbznH1MGzai2I5PY
         0Zpw==
X-Gm-Message-State: AGi0PuYWk4x5oc8GPgH+u77ECUzIV7MrnpEoSfOE5b0hzxwo0h4zSl2r
        7Dd4GZ47ZZU5uGIDUVk14Q3CQXcs/mQk1w88tv0=
X-Google-Smtp-Source: APiQypJM8NPdDbTWm6Iu7eFmwUmgJfrZdKrQ+XkEkbx+p2+b3lqy3IQKLn2ouBNMfjTTCkDtqDWWS/OEgjBAfo04W0E=
X-Received: by 2002:a9d:564:: with SMTP id 91mr2433669otw.250.1588251856441;
 Thu, 30 Apr 2020 06:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:04:05 +0200
Message-ID: <CAMuHMdWDFDEYtD6kW5x96j-fwpkxXeaoOvXZdF1Ex-zaT+zANw@mail.gmail.com>
Subject: Re: [PATCH 05/18] dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
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
> Document PFC support for the RZ/G1H (R8A7742) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in sh-pfc-for-v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
