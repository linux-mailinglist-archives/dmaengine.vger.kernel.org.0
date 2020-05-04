Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3F1C36A6
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgEDKUs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 06:20:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36177 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDKUs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 May 2020 06:20:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id t3so4583219otp.3;
        Mon, 04 May 2020 03:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGRMnuTg/l5w0maHVGEcneYHQFdFGNPfiCYfIWkTR0o=;
        b=JDi7a1+k4nDIQ2X2u7vfsWkL8tk/b85acH4ZTdmB1bwLUQNKhJfb//dPxIPNcgljhm
         jOTigMo6x1Q5lEAD7ZYe8RvzVrD5gxmJVBT4HdxH2/GfjjOO7pdK2W7nxiSzaQy+FBN2
         9npqFZe7t5nM4HsGGHyGb34zmXkN85egcixHyEtHSk4vnOEzAJEIjB5ZA9rYCijfGoGo
         pfCHnTdi3gJZxDk64F0uW4fDZj0N9Zta0SjT0bzkKV4R817Fi21w0QWPWcqkYL4TSTlI
         kJpuJQMc1HxwzuxCWoqjdKKwZ8ClEVc5HnnBnau4oEK2ZzAbDhuLvPLvVirzCvpn7Mz0
         IQQw==
X-Gm-Message-State: AGi0PubxR6DnC7gYGJtUCTCQGM/dXeVBj5JslidJOUZvwO/hrIYM7yr4
        W23D8Z4SZGcHzxnb43AZySrW7wmi/hgiPJwwuWE=
X-Google-Smtp-Source: APiQypKI/tnpEasz9c6NjgVI5Zv53OBORTXWD6v5yxAV42kvA/cHTjT9UpDrC7tAkI9k8UoXntXphLbQKxc99tQWof8=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr12887666otn.107.1588587644541;
 Mon, 04 May 2020 03:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588542414-14826-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1588542414-14826-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 May 2020 12:20:33 +0200
Message-ID: <CAMuHMdXruqw2pb3pfXNfxNgtc24FmVA376DLBQgubEYSGO7LSA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
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

Thanks for the update!

On Sun, May 3, 2020 at 11:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Renesas RZ/G1H (R8A7742) is pin compatible with R-Car H2 (R8A7790),
> however it doesn't have several automotive specific peripherals. Add
> a r8a7790 specific pin groups/functions along with common pin

s/a r8a7790/automotive/?

> groups/functions for supporting both r8a7790 and r8a7742 SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c

> @@ -5736,6 +5750,7 @@ static const struct sh_pfc_soc_operations r8a7790_pinmux_ops = {
>         .pin_to_pocctrl = r8a7790_pin_to_pocctrl,
>  };
>
> +#ifdef CONFIG_PINCTRL_PFC_R8A7790
>  const struct sh_pfc_soc_info r8a7790_pinmux_info = {
>         .name = "r8a77900_pfc",
>         .ops = &r8a7790_pinmux_ops,
> @@ -5745,13 +5760,38 @@ const struct sh_pfc_soc_info r8a7790_pinmux_info = {
>
>         .pins = pinmux_pins,
>         .nr_pins = ARRAY_SIZE(pinmux_pins),
> -       .groups = pinmux_groups,
> -       .nr_groups = ARRAY_SIZE(pinmux_groups),
> -       .functions = pinmux_functions,
> -       .nr_functions = ARRAY_SIZE(pinmux_functions),
> +       .groups = pinmux_groups.common,
> +       .nr_groups = ARRAY_SIZE(pinmux_groups.common) +
> +               ARRAY_SIZE(pinmux_groups.automotive),
> +       .functions = pinmux_functions.common,
> +       .nr_functions = ARRAY_SIZE(pinmux_functions.common) +
> +               ARRAY_SIZE(pinmux_functions.automotive),
> +
> +       .cfg_regs = pinmux_config_regs,
> +
> +       .pinmux_data = pinmux_data,
> +       .pinmux_data_size = ARRAY_SIZE(pinmux_data),
> +};
> +#endif
> +
> +#ifdef CONFIG_PINCTRL_PFC_R8A7742
> +const struct sh_pfc_soc_info r8a7742_pinmux_info = {
> +       .name = "r8a77420_pfc",
> +       .ops = &r8a7790_pinmux_ops,
> +       .unlock_reg = 0xe6060000, /* PMMR */
> +
> +       .function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
> +
> +       .pins = pinmux_pins,
> +       .nr_pins = ARRAY_SIZE(pinmux_pins),
> +       .groups = pinmux_groups.common,
> +       .nr_groups = ARRAY_SIZE(pinmux_groups.common),
> +       .functions = pinmux_functions.common,
> +       .nr_functions = ARRAY_SIZE(pinmux_functions.common),
>
>         .cfg_regs = pinmux_config_regs,
>
>         .pinmux_data = pinmux_data,
>         .pinmux_data_size = ARRAY_SIZE(pinmux_data),
>  };
> +#endif

The r8a7742 section should be inserted before the r8a7790 section,
to preserve sort order.

No need to resend, will fix up while applying.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in sh-pfc-for-v5.8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
