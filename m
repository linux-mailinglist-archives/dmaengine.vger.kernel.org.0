Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548D4C27F2
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 10:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiBXJSY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 04:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiBXJSX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 04:18:23 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088951B9884;
        Thu, 24 Feb 2022 01:17:54 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id x62so827351vkg.6;
        Thu, 24 Feb 2022 01:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGOodK82VUO9G8FX7AR6GFtS5XZEXOhl5R6zSovlVqo=;
        b=NMG+qJt9VHJQdFPGyBJbrYMswdIXvcx2U4UkYTmHgyOt3UjSproz+PHHMpo5IB07Ag
         8tKjJrMvCzl4rLHI4PyDBrI1vL89RyoZKH3H3C0zbLqspFVfyq+uPsGnnrsBcgBhwioF
         idUkhV+unyZmjJqaFHHoyYTryiuCBTKDUNxd7eJ26aPH1qmL4gXcreFAN1Bte9Zojtdm
         Xnab+ohauQi1Q2Qy2oBFYXW/7HNeSlIBJdSHxvdwml7LXlCNKlP81nGjB/R16zg6PYTY
         FPHZCW5iQAQqLMQO3PS7BN9r8DtrqMW0x6Yl8esPBVcV96X7n49RPUOrMxKSMLo2rbem
         M7dw==
X-Gm-Message-State: AOAM530lbRzy2iEuJGMU61ho7JnveIROn6e11+0AiDI5/L66man8soK2
        UFz5/XSnU8FwrMIHydJ8Fw7oosk2FF5wAA==
X-Google-Smtp-Source: ABdhPJwdfYGjm2MOQ/FABlRCaYQ0w4bnY+yPqKvA2AJRstJGJnNUa0ymjawz8o8bYe9TVK9haeOhnQ==
X-Received: by 2002:a05:6122:180e:b0:330:1b9e:732d with SMTP id ay14-20020a056122180e00b003301b9e732dmr636711vkb.5.1645694273044;
        Thu, 24 Feb 2022 01:17:53 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id o11sm315154vsl.0.2022.02.24.01.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:17:52 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id g20so1414550vsb.9;
        Thu, 24 Feb 2022 01:17:52 -0800 (PST)
X-Received: by 2002:a67:e10e:0:b0:31b:956b:70cf with SMTP id
 d14-20020a67e10e000000b0031b956b70cfmr644365vsl.77.1645694272225; Thu, 24 Feb
 2022 01:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
 <20220222103437.194779-8-miquel.raynal@bootlin.com> <CAMuHMdWoH3vySMiCaRxZzT474NwtXfYRAga==SyNsKKaEpiU1Q@mail.gmail.com>
 <20220223181403.11744043@xps13>
In-Reply-To: <20220223181403.11744043@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:17:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsTii548DJjOKNG1smLZNsn1fkKTk_KQt7GdEe+w8wEw@mail.gmail.com>
Message-ID: <CAMuHMdUsTii548DJjOKNG1smLZNsn1fkKTk_KQt7GdEe+w8wEw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] ARM: dts: r9a06g032: Add the two DMA nodes
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

On Wed, Feb 23, 2022 at 6:14 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:54:20 +0100:
> > On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > Describe the two DMA controllers available on this SoC.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > > @@ -184,6 +184,36 @@ nand_controller: nand-controller@40102000 {
> > >                         status = "disabled";
> > >                 };
> > >
> > > +               dma0: dma-controller@40104000 {
> > > +                       compatible = "renesas,r9a06g032-dma", "renesas,rzn1-dma";
> > > +                       reg = <0x40104000 0x1000>;
> > > +                       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clock-names = "hclk";
> > > +                       clocks = <&sysctrl R9A06G032_HCLK_DMA0>;
> >
> > power-domains?
> >
> > > +                       dma-channels = <8>;
> > > +                       dma-requests = <16>;
> > > +                       dma-masters = <1>;
> > > +                       #dma-cells = <3>;
> >
> > <4>? The dmamux bindings say:
> >
> > +      The first four cells are dedicated to the master DMA
> > controller. The fifth
> > +      cell gives the DMA mux bit index that must be set starting from 0. The
> > +      sixth cell gives the binary value that must be written there, ie. 0 or 1.
>
> The DMAC bindings had initially 3 cells, and then received a fourth
> optional one. We do not need it here, that's why I'm keeping #dma-cells
> to 3.
>
> But on the mux side, I don't want to deal with the presence or absence
> of the optional cell so I assumed we would always request 4 cells for
> the DMAC to be on the safe side.
>
> Is this assumption wrong?

OK.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
