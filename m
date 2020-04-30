Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B291BFADA
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 15:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgD3N42 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 09:56:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38495 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgD3N41 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Apr 2020 09:56:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id r66so5275000oie.5;
        Thu, 30 Apr 2020 06:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0BdSY6aYGuZTCeF5gOrkfhmzXUO5QbPbC35o2A29hs=;
        b=A5bRAUkVit7A9Q67nBb0D6LjEHNWr5O8oTtDn7WlefMt19SjeAW7pDUGNvL+j1D+/G
         lOAb37JXd0umrybksFPSbudPdAe7IaruY9oxP8Lxm5zi0qLiTLAq/rPUMU/S1y+kfDKr
         wKMnJlDctXfI169wqMlRrN6dC9+ugfrVBbE+DIMdNwpOQYItOYppG4pOu6Ge4Ik/uodF
         YRxjLo1c1IHN2+GCQWCzv9+ajbVr95DaReI1mZx88BJH284wiCkug9He/iSDPCumrjQQ
         7YNkFxFnB4smVZa3TstLQiLuMOs6ErlCMZSv3OOX/kdXUSoXlElQNSKiPrb+nHGHVbfO
         oJAw==
X-Gm-Message-State: AGi0PuaHq/SZj8kdIujY5MO1wVQ2/nMa4paWr1+pNuobNLDfBGRHASCK
        hcqDhlgKa8cIepye7Gcgdeokf/M8qb1Ool9We/E=
X-Google-Smtp-Source: APiQypKEYGGNvKQoS3yHrfZA1ZqB91++Kmari2arpNNAHltBPFXklTXvWPxfYoN3XHTdW9bxVOsPDs6q+I2XoirDHdk=
X-Received: by 2002:aca:895:: with SMTP id 143mr1736708oii.153.1588254986270;
 Thu, 30 Apr 2020 06:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588197415-13747-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Apr 2020 15:56:15 +0200
Message-ID: <CAMuHMdVY8HOe=R82Z=ymnSiq_zUXDyZNbDYy2RwaPD9hVkkQrA@mail.gmail.com>
Subject: Re: [PATCH 10/18] dt-bindings: rcar-dmac: Document r8a7742 support
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

Hi Prabhakar,

On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
> Document RZ/G1H (also known as R8A7742) SoC bindings.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt

This file has been replaced by renesas,rcar-dmac.yaml.

> @@ -16,6 +16,7 @@ Required Properties:
>
>  - compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
>               Examples with soctypes are:
> +               - "renesas,dmac-r8a7742" (RZ/G1H)
>                 - "renesas,dmac-r8a7743" (RZ/G1M)
>                 - "renesas,dmac-r8a7744" (RZ/G1N)
>                 - "renesas,dmac-r8a7745" (RZ/G1E)

For the logical change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
