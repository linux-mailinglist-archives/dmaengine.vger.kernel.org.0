Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82BB1C3AB8
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgEDNBi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 09:01:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40080 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDNBi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 09:01:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id i27so8726990ota.7;
        Mon, 04 May 2020 06:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8zKT+xBy6Gq3229RJb69rkd2OBVlAkNbEfst/RgefA=;
        b=KfF12E/IZIihS4TWketVaJZ7kTbDFIldK6a/1jpvdh4GHmUsihU+D3ODdQH0PuAQQd
         scHwckLZYiyx54FCqqATx1Fy51yHJnxYn+IU9nNAaNeJaQDDXJr8PGA93FWAzEb0gLcG
         CIS6aAhX4n2XJZihF/EvhdUEQz8tv4jSSBPj/U/Pj+9qnJ4yvC/31siAf5xtoSqbfa4R
         /aoqCqoqIVm6tMgz53gBSI1Bnlx9Cn3Rn9pnU7azUe75AEmAGeq72rZ8eDWTCNOexF8K
         cU9+/wMY7f5iEteK3AliLGfmXjTXLL2DKMyi5AcSi2l0xPOhfSmo1yVOBEjwJqG1TGb8
         9LiA==
X-Gm-Message-State: AGi0PuZADTvlFFCaDRnf2lNGM+RWmJAlMod3N9b63lENUYvBLfhXGecY
        dRCVRR0mLfYZM2WDF/rBd9GeiC/lNZVGU92GTV7E72TH
X-Google-Smtp-Source: APiQypJP/gXg+0E7M667GPtseOWpTQreTWWvphkLLyjHkVYI3HGEFPTzknIou3giyAvzYzckPosD7dJMqX44H6jCAfM=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr13691328otm.145.1588597296834;
 Mon, 04 May 2020 06:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 15:01:25 +0200
Message-ID: <CAMuHMdXv1kW4BeEt4tGBwp9gmRUOJ1X_7-Gu2h=m+On8+RjZ2A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H
 Qseven SOM
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

On Sun, May 3, 2020 at 11:48 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for iWave RZ/G1H Qseven System On Module.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the iWave RZ/G1H Qseven SOM
> + *
> + * Copyright (C) 2020 Renesas Electronics Corp.
> + */
> +
> +#include "r8a7742.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       compatible = "iwave,g21m", "renesas,r8a7742";
> +
> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0 0x40000000 0 0x40000000>;
> +       };
> +
> +       memory@200000000 {
> +               device_type = "memory";
> +               reg = <2 0x00000000 0 0x20000000>;

According to the schematics, the second bank is also 1 GiB, so the
reg length should be 0x40000000.

> +       };

> +&pfc {
> +       mmc1_pins: mmc1 {
> +               groups = "mmc1_data4", "mmc1_ctrl";
> +               function = "mmc1";
> +       };
> +};
> +
> +&mmcif1 {
> +       pinctrl-0 = <&mmc1_pins>;
> +       pinctrl-names = "default";
> +
> +       vmmc-supply = <&reg_3p3v>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "okay";
> +};

The eMMC has an 8-bit data path.  Is there any specific reason you use
bus-width = <4>, and the "mmc1_data4" pin group?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
