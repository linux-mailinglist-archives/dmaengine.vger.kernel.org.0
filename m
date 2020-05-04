Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3011C36DC
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEDK0l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 06:26:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36533 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgEDK0k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 06:26:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id t3so4593525otp.3;
        Mon, 04 May 2020 03:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7y6CIeS04hagLJPRHwIReiVe4JI70J94WDHouhIzWFI=;
        b=jgAxxs+maWviN3lTQq71uw3juBH9dJKZTztfpJJBDpUkVIreWNcer3+0sXZmW1WvUt
         IO3aPAJG5FD3qQxeQxJN4b+kFcWNv1PlacsKJNHOmOHFukJMAtXk6yLTsoXAwSi7DQR3
         KZu5n2MFcWvxwUmqw2jvz+j8tFDtU3N6A96M3Z7+jjuSkL3B7UDcc+Sh/SwjxzOHtD01
         hPIuT9oW+SHyhdXeLxLG2H7FcDjKfbj+ELXhQrdCG7XgjEWnmb4JBP0txa0LjTNwPrhs
         QumQovSj5AvcUwP5Jc0X2FEBzUL38fOlx/iGPdbUEAYqLMLfIApg8tFEjzCEIZw3JBMd
         FQiA==
X-Gm-Message-State: AGi0PuZF1H0mfI51BRkIczTDBlH8qsDsO9rgq2B2m9pO0tglfRiA0vbf
        z2HUwKFuHBjJWBes9sUXj/JFtiVeDFdywewZjzM=
X-Google-Smtp-Source: APiQypI/S3nQv6tWORCp4RyO1zVc/8orWhiN+nCb0rnWkV4pP4RtM5AF3V3Zb6d1pWnM+wPxKkDKhuf9JkEupBqpUk8=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr13252429otm.145.1588587998271;
 Mon, 04 May 2020 03:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 12:26:26 +0200
Message-ID: <CAMuHMdWBp_+PAa9VNhHCxd8CwrZVeeH1swDrZhegS-7YuQaL2g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: mmc: renesas,mmcif: Document
 r8a7742 DT bindings
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Prabhakar,

On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for r8a7742 SoC. Renesas RZ/G1H (R8A7742) MMCIF is identical
> to the R-Car Gen2 family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -11,6 +11,7 @@ Required properties:
>         - "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
>         - "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> +       - "renesas,mmcif-r8a7742" for the MMCIF found in r8a7742 SoCs
>         - "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
>         - "renesas,mmcif-r8a7744" for the MMCIF found in r8a7744 SoCs
>         - "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs

Please also update the paragraph stating the number of interrupts
(1 for r8a7742).

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
