Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184A1CF806
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgELO4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 10:56:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34703 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELO4P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 10:56:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id c12so17460328oic.1;
        Tue, 12 May 2020 07:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/N06xotf8iar1D4UgdTjomlZyumlZDa21O+nxsz7Gs=;
        b=Bw5aMtaTY7Ai1hy3njXmlZXnmCGDgmdN/uvMraVZ6fQwIASR9Y5Qawssgs/8Mpcmh/
         SRuGZaIKXlBrXQYAkjgBhsA8cD/JtTc1Ajt6/H22/zHebXoPQLQac9YRYSjNbu2hVu6I
         K+WgJdcPhAgSKEhB1gB0gNVNcgOl4pOFWmS1948U5o0pbju6m7+oNESWi2ykxYg6o6+x
         jKVTW5Gar7NU5gxKXhFg1wjXRlEkcDKs0D6VJQOiHQWa04WVOi8LWkXIRUsYfEZZByrA
         sCPYeVuxkLQFHgWlI6nm1S3/6kU48aeY2mAbv4Xe0YC+9i7ho4wbml4gggj86G6iBS5h
         86lw==
X-Gm-Message-State: AGi0Pua6MeG6zKDwGy718FdSJwn7kQzinRNiAVftsrrEbCJCa8VmqcLz
        8zbwRd7T/Pt3Pvx9XuxzUvmPUTxGIxYTo3mOXlAj1kOX
X-Google-Smtp-Source: APiQypLPHII6upk6iNYoZD9pYfWhiPJxDNt/TH7BuAvFbVXWIAt/4KdUs8x3tA8y610NHj/T3IkbGJwtxVll7YHTVaA=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr23734306oig.54.1589295373790;
 Tue, 12 May 2020 07:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200512145256.GA25121@bogus>
In-Reply-To: <20200512145256.GA25121@bogus>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 May 2020 16:56:01 +0200
Message-ID: <CAMuHMdXzeJdBqjshm5eEqTF05GZC1HS02=oJ2VG+B0r16=gkeQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] dt-bindings: gpio: rcar: Add r8a7742 (RZ/G1H) support
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On Tue, May 12, 2020 at 4:53 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, 29 Apr 2020 22:56:54 +0100, Lad Prabhakar wrote:
> > Renesas RZ/G1H (R8A7742) SoC GPIO blocks are identical to the R-Car Gen2
> > family. Add support for its GPIO controllers.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> Acked-by: Rob Herring <robh@kernel.org>

Note that you've just applied 7f7d408e5a00d515 ("dt-bindings: gpio: rcar:
Convert to json-schema"), so this no longer applies.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
