Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6C1EF857
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFEMwF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 08:52:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37986 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFEMwE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jun 2020 08:52:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id c194so8108722oig.5;
        Fri, 05 Jun 2020 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0l1qYzvXi/GO1NNvXjYET+2paPoc72Q4SdiakMSrAJE=;
        b=NMiI0cxm3L5FK+XtkUqxfkfr16nI8LXlr6zv2XNGDXyMN5Rt1ttn0qhKXMEMtCpiIR
         rvZZcqwQrQvaDVA2S1v2j1fvnG9+Qaxw40pcFFaFh/ERXgX5g9gOyw271xfoCNDQYy+l
         CESBmJzj9C63rBx73CiXDS7QcW5TBOp4TFb274Byvj4DD01yLc6V3MVoGZa8Omgu4B86
         Yv0lZ2KtbUceWzGjeq3vHYbw5kmV7pCNWrfPAw9UudKFtGSuqHarOOEC1EJMTTV+eJbf
         GJefnoOypP8BsxzQWnWtC60fu9aVf4BXrD1EsfyPVjeosA2JNIYiqK1CzGf+bjeLVdPY
         0Q0A==
X-Gm-Message-State: AOAM530GlO5HQszfC6hPJUihsZSTy/zUCqltYggG3mFdx+k/oRH+8kEF
        glM1aXIsqJrqs0swTMnhpGkt1Ab/sY9I3CoQZBgYok5Z
X-Google-Smtp-Source: ABdhPJytYGDFbxN/XEq2VGE23sTUMKtd1U9+zTazCFQWHGPrv/2hO4eOc8uC8OCmgaeeBGlB90o3SnUqaReY8OrFTNk=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr1815274oia.54.1591361523495;
 Fri, 05 Jun 2020 05:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Jun 2020 14:51:52 +0200
Message-ID: <CAMuHMdXgSWHd-w_vgv-2mrYwJ2trcdDNniKFGCDGbn3ts-CkjA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: dts: r8a7742-iwg21d-q7: Add support for
 iWave G21D-Q7 board based on RZ/G1H
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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
> Add support for iWave RainboW-G21D-Qseven board based on RZ/G1H.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the iWave-RZ/G1H Qseven board
> + *
> + * Copyright (C) 2020 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +#include "r8a7742-iwg21m.dtsi"
> +
> +/ {
> +       model = "iWave Systems RainboW-G21D-Qseven board based on RZ/G1H";
> +       compatible = "iwave,g21d", "iwave,g21m", "renesas,r8a7742";
> +
> +       aliases {
> +               serial2 = &scifa2;
> +       };
> +
> +       chosen {
> +               bootargs = "ignore_loglevel root=/dev/mmcblk0p1 rw rootwait";
> +               stdout-path = "serial2:115200n8";
> +       };
> +};
> +
> +&pfc {
> +       scifa2_pins: scifa2 {
> +               groups = "scifa2_data_c";

Upon second look, I think this group is wrong.  While labeled SCIFA2 in
the SOM schematics, these signals seem to be connected to a debugging
interface.

The real UART2 seems to be present on the camera daughter board.  Those
signals are labeled "SCIFA2" in the camera board schematics, but "SCIF2"
in the SOM schematics.  This is OK, as "scif2_data" and "scifa2_data"
share the same pins, so you can choose either SCIF2 or SCIFA2 to drive
them.

If I'm right, please change the group, and move all serial2 descriptions
to the camera board DTS.

> +               function = "scifa2";
> +       };
> +};
> +
> +&scifa2 {
> +       pinctrl-0 = <&scifa2_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
