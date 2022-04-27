Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B909511572
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiD0LDt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 07:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiD0LDT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 07:03:19 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04C3E010C;
        Wed, 27 Apr 2022 03:52:53 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id ay11so821583qtb.4;
        Wed, 27 Apr 2022 03:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeLCBbdeC0qD/hBxXlqSXJDGwgSvd3X/uaXmAMqW6zk=;
        b=t0KBTaCSCYha6Hax/gXynQzxub2+ZyzD/X16Jdu0645zIjcUrtWOQMebkAZOdncBU5
         tQddXF0hLgTugkA+efgPqJozDNIhQsy5yXynj5tT0cItwxdRuH2PyTiuW6VOwYvCGdb0
         syhQ5RGaDwlsZ3goZSdVfIwbYuf7kysytl0ZYnqWku/QMukig1BeV4hJhCrb7jKkL1tY
         JRcbMdeD/tFtK7qT7gWJHwbVhkORHBDdZdhAQwrZg7p6nTxsrmwU5zMvwtrVepQX9AEe
         sx8FROJPF782NEXJ9DqmX76sjstdvka9HqpZkqxx5l88L01eAfY8lyTlOylm+jMDWUbU
         /LEQ==
X-Gm-Message-State: AOAM5324AbiKlLHkFdwYMHUfPAwkb3fjlvewjZSuPViwZzjBPqw7HbKe
        eOBllBlFwI/t0rv8rW5oSLM0U0YSBpqGaw==
X-Google-Smtp-Source: ABdhPJzGxz8Io1ttjjHGXiVhAChNio+RmmRO1avG8nIsh3BztxQiSgLBgz6CscLT9CLL3DXUDJOVhg==
X-Received: by 2002:a05:620a:270d:b0:69f:26e4:15f6 with SMTP id b13-20020a05620a270d00b0069f26e415f6mr12974171qkp.362.1651052196478;
        Wed, 27 Apr 2022 02:36:36 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id s18-20020a05622a1a9200b002f36470c4f1sm6197201qtc.56.2022.04.27.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 02:36:35 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id w17so2275068ybh.9;
        Wed, 27 Apr 2022 02:36:35 -0700 (PDT)
X-Received: by 2002:a25:d393:0:b0:648:4871:3b91 with SMTP id
 e141-20020a25d393000000b0064848713b91mr16014133ybf.506.1651052195208; Wed, 27
 Apr 2022 02:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
 <20220421085112.78858-9-miquel.raynal@bootlin.com> <CAMuHMdXkrdjETcgN9yruL_J_mL3q7OEMj2DbY36ppwg1eDU5SA@mail.gmail.com>
 <20220427111449.338d9579@xps13>
In-Reply-To: <20220427111449.338d9579@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 11:36:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdJtwOkYT86H5TneMmrVRDrsRqhhaxMp3ruyEkiG+XqA@mail.gmail.com>
Message-ID: <CAMuHMdUdJtwOkYT86H5TneMmrVRDrsRqhhaxMp3ruyEkiG+XqA@mail.gmail.com>
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

On Wed, Apr 27, 2022 at 11:14 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:29:58 +0200:
> > On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > Describe the two DMA controllers available on this SoC.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Still, a few comments below, valid for both instances...
> >
> > > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > > @@ -200,6 +200,36 @@ nand_controller: nand-controller@40102000 {
> > >                         status = "disabled";
> > >                 };
> > >
> > > +               dma0: dma-controller@40104000 {
> > > +                       compatible = "renesas,r9a06g032-dma", "renesas,rzn1-dma";
> > > +                       reg = <0x40104000 0x1000>;
> > > +                       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clock-names = "hclk";
> > > +                       clocks = <&sysctrl R9A06G032_HCLK_DMA0>;
> > > +                       dma-channels = <8>;
> > > +                       dma-requests = <16>;
> > > +                       dma-masters = <1>;
> > > +                       #dma-cells = <3>;
> > > +                       block_size = <0xfff>;
> > > +                       data_width = <3>;
> >
> > This property is deprecated, in favor of "dma-width".
>
> Indeed,
>         data_width = <3>;
> is deprecated.
>
> However, dma-width does not seem to be described anywhere. Do you mean:
>         data-width = <8>;
> instead?

Oops, I did mean "data-width".

> > > +                       status = "disabled";
> >
> > Why not keep it enabled?
>
> I'm used to always disable all the nodes from the SoC descriptions,
> but it's true that for a DMA controller it might make sense to keep
> it enabled.
>
> Would dropping the status property be enough or do you prefer a proper
>         status = "okay";
> instead?

Please just drop the status property, like is done in other Renesas .dtsi
files.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
