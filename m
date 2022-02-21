Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508DD4BDE65
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiBUJiS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 04:38:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351879AbiBUJho (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 04:37:44 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F6654E;
        Mon, 21 Feb 2022 01:16:38 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id e22so30466709qvf.9;
        Mon, 21 Feb 2022 01:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnKbJVLfgaRymluaOH/LPddpZ+bX9fHGr9MZlFjIlxM=;
        b=xlszHnUJZbhIjq4nQuqRUxIpX+ZfTRCwdPRH6JUb0Rvq9OUyvuK3ao4uGA/qe8YAt9
         aRwJPJpGq5UYWG41pIYlqXI+Alf5mMVRRK8lxqxiErOY5SU8dManyJI3h3kghACPJqi1
         kjcSpxFG4FvYcsgEgWdUQplB7rPtBRPfJDnahGtHTo/ABh6ualHu6ho63zODxfTUL5Q9
         ZTRrxgqrvH78VCUTlzMKMlmnqdaLNY56+45VCLb30IsXhtnawdeAu0NXckEQ/XmFCm0U
         os2PcoJHR75srE5I9n5PZ7n+laNlBI2fHCy4fURJZlrlCt7ecBEuK6AdzIrVPzwLG8Xa
         Rj5w==
X-Gm-Message-State: AOAM533WDul4UqeTa8pSk3g/J6ynjFVoBSQyFWPowC5KGguzwvWCFn2P
        NFhzQqWl8QV05TL5cwPqSIygnc8p69MgsQ==
X-Google-Smtp-Source: ABdhPJzHa1YQ0rsQI9qD1uMb+I73idgYRZxjNeFVFO5wfbo/kE8e/gp5ZtX8MxbtRt9LhMOSES8J4Q==
X-Received: by 2002:ac8:5988:0:b0:2d7:84d6:aee with SMTP id e8-20020ac85988000000b002d784d60aeemr16892128qte.466.1645434997036;
        Mon, 21 Feb 2022 01:16:37 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id y18sm30482997qtj.33.2022.02.21.01.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:16:36 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id e140so32871434ybh.9;
        Mon, 21 Feb 2022 01:16:36 -0800 (PST)
X-Received: by 2002:a25:324c:0:b0:623:fb7d:cbc8 with SMTP id
 y73-20020a25324c000000b00623fb7dcbc8mr17519476yby.397.1645434996064; Mon, 21
 Feb 2022 01:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20220218181226.431098-1-miquel.raynal@bootlin.com> <20220218181226.431098-4-miquel.raynal@bootlin.com>
In-Reply-To: <20220218181226.431098-4-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Feb 2022 10:16:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBfJSeEOev81WYSEw+9FAcUzBnN2n5BHJ2n0ig=6fxKQ@mail.gmail.com>
Message-ID: <CAMuHMdWBfJSeEOev81WYSEw+9FAcUzBnN2n5BHJ2n0ig=6fxKQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set dmamux
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
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

On Fri, Feb 18, 2022 at 7:12 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> The dmamux register is located within the system controller.
>
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c

Missing #include <linux/soc/renesas/r9a06g032-syscon.h>

> @@ -315,6 +315,27 @@ struct r9a06g032_priv {
>         void __iomem *reg;
>  };
>
> +/* Exported helper to access the DMAMUX register */
> +static struct r9a06g032_priv *syscon_priv;

I'd call this sysctrl_priv, as that matches the bindings and
binding header file name.

> +int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
> +{
> +       u32 dmamux;
> +
> +       if (!syscon_priv)
> +               return -EPROBE_DEFER;
> +
> +       spin_lock(&syscon_priv->lock);

This needs propection against interrupts => spin_lock_irqsave().

> +
> +       dmamux = readl(syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
> +       dmamux &= ~mask;
> +       dmamux |= val & mask;
> +       writel(dmamux, syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
> +
> +       spin_unlock(&syscon_priv->lock);
> +
> +       return 0;
> +}
> +
>  /* register/bit pairs are encoded as an uint16_t */
>  static void
>  clk_rdesc_set(struct r9a06g032_priv *clocks,

> --- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
> +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
> @@ -145,4 +145,6 @@
>  #define R9A06G032_CLK_UART6            152
>  #define R9A06G032_CLK_UART7            153
>
> +#define R9A06G032_SYSCON_DMAMUX                0xA0

I don't think this needs to be part of the bindings, so please move
it to the driver source file.

> --- /dev/null
> +++ b/include/linux/soc/renesas/r9a06g032-syscon.h

r9a06g032-sysctrl.h etc.

> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__
> +#define __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__
> +
> +#ifdef CONFIG_CLK_R9A06G032
> +int r9a06g032_syscon_set_dmamux(u32 mask, u32 val);
> +#else
> +static inline int r9a06g032_syscon_set_dmamux(u32 mask, u32 val) { return -ENODEV; }
> +#endif
> +
> +#endif /* __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__ */
> --
> 2.27.0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
