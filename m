Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7250E5DA
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiDYQdU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243382AbiDYQdR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 12:33:17 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FC1D33B;
        Mon, 25 Apr 2022 09:30:12 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id x21so1230908qtr.12;
        Mon, 25 Apr 2022 09:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkzV/+2M9zHmKkv5bNxhza8d87qIgaSeR4/CvCviOfQ=;
        b=2Kk6rDeuTgB4OrDnSqGU3Za1myqVwD/dWhfhnv3Qky8mZkdwIvDQwy9/abzn5TAT77
         wLgTHFGVaOosAYmBKywI1xQ4CKfx3jpPYx/wMPbSE1hLJCl/bSK/pvraNtllSWCbdTBq
         bA73ckq3//sLcUslOBIhS+1GEF6xreoE5Djao/RWj2Rug29jMepyXCqhFu5VqaX0c5/b
         apd8qDi7HfoglCtxayg7DyRvrEjjkApyQdZEHnGOvMZBsapmv7sPfTOcWv8yuZv48kt0
         vEt4q0rHmfoGk/61Xq0YkNd+Gl+Zm7FcibX0ekHNh+wh/HwP9CH6M9xd6O57U+F5c4v0
         LgaQ==
X-Gm-Message-State: AOAM533o/2gSDGeXjqyfL2b8sZABIYgffHYTHAAww7XEmwYVZxZiuzhT
        /Ezqbb+bxltfwtIvdpqEIK4SC/9AvgH5ZQ==
X-Google-Smtp-Source: ABdhPJx5eEvGk96GMcwbmzSBKCM3cv3JYfyXrnImWf2JSreFhhCPWgoj92dYFLtMxcA+AqLl8Th7wg==
X-Received: by 2002:ac8:1191:0:b0:2ed:bb6:ab07 with SMTP id d17-20020ac81191000000b002ed0bb6ab07mr12525257qtj.418.1650904210793;
        Mon, 25 Apr 2022 09:30:10 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id f39-20020a05622a1a2700b002f367d7a7a5sm2265190qtb.23.2022.04.25.09.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:30:10 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2ef5380669cso154297037b3.9;
        Mon, 25 Apr 2022 09:30:09 -0700 (PDT)
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr17984532ywc.512.1650904209650; Mon, 25
 Apr 2022 09:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com> <20220421085112.78858-9-miquel.raynal@bootlin.com>
In-Reply-To: <20220421085112.78858-9-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 18:29:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXkrdjETcgN9yruL_J_mL3q7OEMj2DbY36ppwg1eDU5SA@mail.gmail.com>
Message-ID: <CAMuHMdXkrdjETcgN9yruL_J_mL3q7OEMj2DbY36ppwg1eDU5SA@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] ARM: dts: r9a06g032: Add the two DMA nodes
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
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Describe the two DMA controllers available on this SoC.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still, a few comments below, valid for both instances...

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -200,6 +200,36 @@ nand_controller: nand-controller@40102000 {
>                         status = "disabled";
>                 };
>
> +               dma0: dma-controller@40104000 {
> +                       compatible = "renesas,r9a06g032-dma", "renesas,rzn1-dma";
> +                       reg = <0x40104000 0x1000>;
> +                       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "hclk";
> +                       clocks = <&sysctrl R9A06G032_HCLK_DMA0>;
> +                       dma-channels = <8>;
> +                       dma-requests = <16>;
> +                       dma-masters = <1>;
> +                       #dma-cells = <3>;
> +                       block_size = <0xfff>;
> +                       data_width = <3>;

This property is deprecated, in favor of "dma-width".

> +                       status = "disabled";

Why not keep it enabled?

> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
