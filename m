Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9F4C1347
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 13:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiBWMzB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 07:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiBWMzA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 07:55:00 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7DF9858D;
        Wed, 23 Feb 2022 04:54:33 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id x62so4384650vkg.6;
        Wed, 23 Feb 2022 04:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2ZMGyGypWkGWFhVkz7FZ46Wu3326iiOknUbX8FkqQc=;
        b=1kGO+j6XIkGyzJduHrUxwiE7xPJaIY68FWw3YQYArI+Ct5I00T/jlehhrPO99c6tLz
         l0pwhuxPCkNzUtXv6MMZRVxZmfB0MEDgAFgiYBrU7x04TSnpO8RFNc59xk4hGZw/xQU5
         ADXkYKrjqk1ahL0bCmeG2cRBBUi5wmutaQK0e06ARHhUGVYj0gMh6KTbV/jgEFH92rY7
         IaTkvL3QqA80gTTEdr++R8+eRfF/42Vw7G3Mwxbr+Tl46Il0pgq/TOZbww8I05ZT/OUK
         TLDGzEBXZX6J5g2lzc3BBQb+YTbQvL5B6OMoEo9sJAqTTzb1+F3HzboFE0reATrgtQEl
         5bZg==
X-Gm-Message-State: AOAM533MWgjeCeAA4AZxGEygmqJXcboDTI9XVQeVeZ/05xEG4Fv86MMf
        0okTmwqPoWGpbCHk2r/+UeCKa/F8fV6b9w==
X-Google-Smtp-Source: ABdhPJz70u6fKHBVE1l4VulJrXlA8Oh3E59jKSdnBca6ZnSC4P+j20s20M1Qcpkt5c1FXlBBCBbeKQ==
X-Received: by 2002:a1f:6087:0:b0:328:e94a:54b3 with SMTP id u129-20020a1f6087000000b00328e94a54b3mr12317218vkb.20.1645620872480;
        Wed, 23 Feb 2022 04:54:32 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id y5sm680559vsj.11.2022.02.23.04.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:54:32 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id t22so3036748vsa.4;
        Wed, 23 Feb 2022 04:54:32 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr12147208vsl.68.1645620871857; Wed, 23
 Feb 2022 04:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com> <20220222103437.194779-8-miquel.raynal@bootlin.com>
In-Reply-To: <20220222103437.194779-8-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 13:54:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWoH3vySMiCaRxZzT474NwtXfYRAga==SyNsKKaEpiU1Q@mail.gmail.com>
Message-ID: <CAMuHMdWoH3vySMiCaRxZzT474NwtXfYRAga==SyNsKKaEpiU1Q@mail.gmail.com>
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

On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Describe the two DMA controllers available on this SoC.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -184,6 +184,36 @@ nand_controller: nand-controller@40102000 {
>                         status = "disabled";
>                 };
>
> +               dma0: dma-controller@40104000 {
> +                       compatible = "renesas,r9a06g032-dma", "renesas,rzn1-dma";
> +                       reg = <0x40104000 0x1000>;
> +                       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "hclk";
> +                       clocks = <&sysctrl R9A06G032_HCLK_DMA0>;

power-domains?

> +                       dma-channels = <8>;
> +                       dma-requests = <16>;
> +                       dma-masters = <1>;
> +                       #dma-cells = <3>;

<4>? The dmamux bindings say:

+      The first four cells are dedicated to the master DMA
controller. The fifth
+      cell gives the DMA mux bit index that must be set starting from 0. The
+      sixth cell gives the binary value that must be written there, ie. 0 or 1.

> +                       block_size = <0xfff>;
> +                       data_width = <3>;
> +                       status = "disabled";
> +               };

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
