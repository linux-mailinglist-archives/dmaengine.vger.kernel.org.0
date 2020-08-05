Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403C23C81D
	for <lists+dmaengine@lfdr.de>; Wed,  5 Aug 2020 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgHEIso (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Aug 2020 04:48:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41326 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHEIsm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Aug 2020 04:48:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id b22so12986544oic.8;
        Wed, 05 Aug 2020 01:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mrXzxi9uxOAW3sW2InYWxrD30ehGwVVOP3HqfzhRdk=;
        b=ac8PtcXxGfZXOJRiBTYhlU1K0kRNtHc9Qpq2jv81kcZYZwgoljWqD+/7yrmxToLqCG
         Sy7TBdKOMG99Q6tDrTbr4Yj+oF4elOTvyd2nv6mNBxkWs9wxyyjKYddVuNNa0qNoh0/Y
         LdoveLh1tS52S0r/4qTehIuqF8O2qsUg/KD5KvMAI5EH1X3NdkFISVT6aZz9ls+IWa97
         RYTyiSa7kO0Z7F9O4iY2q3yPhNi4RvyFTdmzHNQneE9w66n74Ztv33aVB6/XmUzpQbB/
         s5Ispt87lxXU0w+dWKderoL4i8R8fRiCDaZ1FRsjuJ3ZzNtiiK2iy0k2HrTNumgIF1Km
         Z8ig==
X-Gm-Message-State: AOAM531Eem8/H2sOCSKCvuFcP+2uMJIWfhjwzR70cXCfQzI8KQEuyuUf
        XFiFKJKXoaxA52F99mdxHyNpuvyIbm+sowZfUrs=
X-Google-Smtp-Source: ABdhPJytnGMFscI/4Vj10JBqUQ7Wgi/Lqycodf6cBlV8PTnw+Znw95/OXOULRQVW5Ng30YOlYqbpGAXWXSVGKdV5pP0=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr1785208oie.153.1596617320906;
 Wed, 05 Aug 2020 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Aug 2020 10:48:29 +0200
Message-ID: <CAMuHMdXOvVkbhXXmaugHe4fo5vUK3x7bYFHPYHESPWqVdDJBjg@mail.gmail.com>
Subject: Re: [PATCH 03/20] dt-bindings: ata: renesas,rcar-sata: Add r8a774e1 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas <niklas.soderlund@ragnatech.se>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 16, 2020 at 7:19 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document SATA support for the RZ/G2H, no driver change required.
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
