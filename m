Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00B50E533
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiDYQLi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiDYQLh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 12:11:37 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C73D4A7;
        Mon, 25 Apr 2022 09:08:33 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id y129so11106981qkb.2;
        Mon, 25 Apr 2022 09:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHmbubdOPtstEpBS9UZl1HKEMRRPaARjRH3/+Y7nuDA=;
        b=0q/H5HL3VyLkJQIqMrioindzHbe6HeEO8/J8zsncprNT8Ku6+VJtD+VmuLa9mbDRHg
         CsEQtxvohi7qaOWsVsOcKTkvLNU5YHJXart7NljB3iIzeSUmqyimiI8lRb4IV14LhPyn
         uPRIWFMN8CODyN2jlbJSU+j9ePYx3H3e1RGSXjroV6gmEpFUkvU/wz6ramuPRGi7KW1W
         BysWn971sTvfUljB/YV27Y41c5x/KmXdE1A/GGYB0K9x5kJDvsDUnHxMl+RYp5AcszLp
         Drom3EZHkDDNNHKjmKqCUfF9oXaEx1D1aRzwcCXljbS95OzK5zXuGhcEWayTkHh2Jcjr
         +sAA==
X-Gm-Message-State: AOAM533MnagFbFB2eNdacruzX1QaBy8nwg1cwLuIUVBzQMM8EaBnWELh
        EWN78KUEmRA4cga+KsHi2VjyFtclmce40w==
X-Google-Smtp-Source: ABdhPJysuem3fOkHdzpHFmHLqr1hCi43sUvtPcqnxUtmmh+RKUQRH1RZNtch9vXg3aXTmxSSXUmRGQ==
X-Received: by 2002:a05:620a:4483:b0:69f:3647:b559 with SMTP id x3-20020a05620a448300b0069f3647b559mr5770129qkp.270.1650902911807;
        Mon, 25 Apr 2022 09:08:31 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t22-20020a05620a451600b0069f4d952f8esm2320364qkp.0.2022.04.25.09.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:08:31 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w187so18517921ybe.2;
        Mon, 25 Apr 2022 09:08:31 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr16322354ybp.613.1650902910982; Mon, 25
 Apr 2022 09:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com> <20220421085112.78858-3-miquel.raynal@bootlin.com>
In-Reply-To: <20220421085112.78858-3-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:08:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgLhhc3po6EqSnKQrtKW4v+cDcT+iDg_i_KP0iL-XF3Q@mail.gmail.com>
Message-ID: <CAMuHMdWgLhhc3po6EqSnKQrtKW4v+cDcT+iDg_i_KP0iL-XF3Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] dt-bindings: clock: r9a06g032-sysctrl: Reference
 the DMAMUX subnode
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

On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> This system controller contains several registers that have nothing to
> do with the clock handling, like the DMA mux register. Describe this
> part of the system controller as a subnode.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> @@ -39,6 +39,17 @@ properties:
>    '#power-domain-cells':
>      const: 0
>
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^dma-router@[a-f0-9]+$":

For now this must be @a0, right?

> +    type: object
> +    $ref: "../dma/renesas,rzn1-dmamux.yaml#"
> +
>  required:
>    - compatible
>    - reg

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
