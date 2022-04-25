Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4250E570
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiDYQVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiDYQVq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 12:21:46 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE485C845;
        Mon, 25 Apr 2022 09:18:41 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id d19so11141997qko.3;
        Mon, 25 Apr 2022 09:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmopMEhO5sJFa6N97UeuS8xj6v439U2xJGJI9H+fOkk=;
        b=DxX5Ty4jmUn0D5FNwwBv8ooLxTYpmWIUGhJWQHyWn/Gu8xpyCAf4ypFNeUDgv9c9Mw
         6zj1ti+x60e9rgU28CEFTRPJRfItC4IBhZtnQixRfUj43uUsmrSIMkhcQUcOFTwFvITK
         Ll4eHdb0yWsKXVxN2ch75luSIi2ZxwlHFLMohNSK+SqJOaSqFVP1bQ9Do+SnqKDQ2up/
         jWI6eXGyHgsG17ZMdoEacrNtWNi3EMxarvQFTZkU6e1ZkkctcInQEOpkoga3p4mNP/R1
         3ihZ1zlp9WW4iIMbxDK3vKbXbgS9HtXFEqcTvJzqpJhXwLJ6R0att11pyTo07S01Tcjk
         N0Vg==
X-Gm-Message-State: AOAM533Y2TWMuGUGLRSMCWugUaraqXTy9X4Fs79Jwioksfb+hLKrmgIJ
        0XFImG2jS/6HLkpTmQQUKH+kLtAnN5SGTg==
X-Google-Smtp-Source: ABdhPJxTWChXVzYuuLjx4uora+ov5MmoM4yvCSzOIhk+JG+tW4wFW6PgktnEbFI55VZoLa0olNSaaA==
X-Received: by 2002:a05:620a:4611:b0:69f:6a64:e694 with SMTP id br17-20020a05620a461100b0069f6a64e694mr1633421qkb.36.1650903520803;
        Mon, 25 Apr 2022 09:18:40 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d15-20020ac84e2f000000b002f36938f259sm1873797qtw.91.2022.04.25.09.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:18:40 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id r189so27977419ybr.6;
        Mon, 25 Apr 2022 09:18:40 -0700 (PDT)
X-Received: by 2002:a25:8087:0:b0:641:dd06:577d with SMTP id
 n7-20020a258087000000b00641dd06577dmr16564168ybk.207.1650903519962; Mon, 25
 Apr 2022 09:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com> <20220421085112.78858-7-miquel.raynal@bootlin.com>
In-Reply-To: <20220421085112.78858-7-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:18:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWaViDYRnwdpD+m73ZisDSMKESfcGbanf6qXR1M2167EQ@mail.gmail.com>
Message-ID: <CAMuHMdWaViDYRnwdpD+m73ZisDSMKESfcGbanf6qXR1M2167EQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] clk: renesas: r9a06g032: Probe possible children
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The clock controller device on r9a06g032 takes all the memory range that
> is described as being a system controller. This range contains many
> different (unrelated?) registers besides the ones belonging to the clock
> controller, that can necessitate to be accessed from other peripherals.
>
> For instance, the dmamux registers are there. The dmamux "device" will
> be described as a child node of the clock/system controller node, which
> means we need the top device driver (the clock controller driver in this
> case) to populate its children manually.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -996,7 +997,7 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>
>         sysctrl_priv = clocks;
>
> -       return 0;
> +       return of_platform_populate(np, NULL, NULL, dev);

This is a bit dangerous: in the (very unlikely) case that
of_platform_populate() fails, the clock driver will fail to probe,
and all managed cleanup will be done (not everything will be cleant
up, though), while sysctrl_priv will still point to the now-freed
r9a06g032_priv structure.

So I think you just want to ignore the failure from
of_platform_populate(), and return zero anyway.

>  }
>
>  static const struct of_device_id r9a06g032_match[] = {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
