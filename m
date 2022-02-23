Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974E4C12B5
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 13:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiBWM3Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 07:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBWM3P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 07:29:15 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E998F4D;
        Wed, 23 Feb 2022 04:28:48 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id e26so2971179vso.3;
        Wed, 23 Feb 2022 04:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiC7wY11OJzwJLXiv+WWU1cIwokaIJTzHuhQQ1ELyoI=;
        b=1ve5g7aaKDOg4zFSP9P8BIiix0XqsKXOYFT1ojt/TaBw1fk14kVpytqHkLIJeB2OZp
         8U8VekcGSnCqDyjrOH01715ybryfHkr4be1vNJslL3QMn/MuNouWAl8AUX20lvr7ixw5
         /1RqfHJboqn2JrbdfLxEe82bzMs3zGNi/Vqy4S2ReRwA8cBvgskclZrHa6LflO+rDZX9
         kX875XnJuGu232hTVj+u/PFPHlZDqWxkkIif0j0aQol2pW2A7napi6unGOCqGuPe94ge
         fgcEL7AT0QsOZvjl2WY/RqjKBnGK0u7DOHLlZf6TEsnYkNGu7IuOtrYJazC7tXHDr3r/
         7Gsw==
X-Gm-Message-State: AOAM531L9UWq/wS6ynu1zlWtbzUhixhabgp6gJd977QyBMqQp1gshnSM
        CpJw+izC99x6Yl1Bs9xeVX9nLMZsmGJb5A==
X-Google-Smtp-Source: ABdhPJxt7pkcx5BUuyncyhXTijU9N2+wuwvDiQMVyyqYxxvjDexgL/djiQxvjqwbU4nDjx/TPzVSjw==
X-Received: by 2002:a67:e005:0:b0:31b:74eb:1005 with SMTP id c5-20020a67e005000000b0031b74eb1005mr10682674vsl.50.1645619327292;
        Wed, 23 Feb 2022 04:28:47 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id x144sm3242275vkx.22.2022.02.23.04.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:28:46 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id d11so2949990vsm.5;
        Wed, 23 Feb 2022 04:28:46 -0800 (PST)
X-Received: by 2002:a67:e113:0:b0:30e:303d:d1d6 with SMTP id
 d19-20020a67e113000000b0030e303dd1d6mr11733631vsl.38.1645619326446; Wed, 23
 Feb 2022 04:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com> <20220222103437.194779-4-miquel.raynal@bootlin.com>
In-Reply-To: <20220222103437.194779-4-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 13:28:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGY7ukSpqq5GzcrfysKDvFy684VVnUKO-SoCn+SJgBEw@mail.gmail.com>
Message-ID: <CAMuHMdXGY7ukSpqq5GzcrfysKDvFy684VVnUKO-SoCn+SJgBEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] soc: renesas: rzn1-sysc: Export function to set dmamux
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The dmamux register is located within the system controller.
>
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -922,6 +947,12 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>         clocks->reg = of_iomap(np, 0);
>         if (WARN_ON(!clocks->reg))
>                 return -ENOMEM;
> +
> +       if (sysctrl_priv)
> +               return -EBUSY;

Can this actually happen, or can the check be removed?

> +
> +       sysctrl_priv = clocks;

Oh yes, it can happen, if any of the clock registrations below fail
due to -EPROBE_DEFER. So I think the assignment to sysctrl_priv
should be postponed until we're sure that can no longer happen.
Then the check above can be removed, too.

> +
>         for (i = 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
>                 const struct r9a06g032_clkdesc *d = &r9a06g032_clocks[i];
>                 const char *parent_name = d->source ?

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
