Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F99552B7F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbiFUHK4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUHK4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 03:10:56 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DB21E27;
        Tue, 21 Jun 2022 00:10:55 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id j39so12891631vsv.11;
        Tue, 21 Jun 2022 00:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ezwPnqEAb9XxkVE6EHdU5akaM6B3QfniuvIAXM1ujs=;
        b=fuofd0oO5ckTaIX0G1gNLRd1YEzHxjZNEpPhcxtUP/1v3vrfEnIDnEhcFyoGQEUvW+
         zSnNUot8AVfrbL796eiV81eKdQIE+etqt6j5zez6pPMb/s3nC78ZqbRk1H9W7hIEPB4F
         8W7y+qPfVg5eH4Y/sjPBNKmhuSPNGoVrjkOxxyZ7Yv4H35M2uRoWs6NFTbkYt5RDH3If
         WS5JmU49CSgt2YLTfAUn+kT6Q33Ile5j0CdFe4n7b/s9Lj4toAlO9jgcjSkZXajhIE3y
         /1WvlZg5jgR3z5aYHKsKGGZWEycSkIuXNqbjmrK7IU1nn7FuaXXNT3SI5q1KPJDGHU1A
         3VQA==
X-Gm-Message-State: AJIora86IIt2ZF348GKFVi03VTj/bE16OAbnKDhfMdW/eXz7yxuM8mBt
        oAb04WP6auVM8SvjPDTYgza2rgTI2glL6A==
X-Google-Smtp-Source: AGRyM1uC15BDDDPZ32VHX52B3S2f6EVB9JAVhTCz8cbw4+sQXaxKgCVv6c8qbfb+j3Vg3jtQMUguQw==
X-Received: by 2002:a67:ead7:0:b0:354:40c1:6859 with SMTP id s23-20020a67ead7000000b0035440c16859mr1984640vso.71.1655795454160;
        Tue, 21 Jun 2022 00:10:54 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id r42-20020a9f362d000000b00379a495e42esm2353234uad.28.2022.06.21.00.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:10:54 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id q1so4762894uao.1;
        Tue, 21 Jun 2022 00:10:54 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr30754158ybh.36.1655795017074; Tue, 21
 Jun 2022 00:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220618123035.563070-1-mail@conchuod.ie> <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
In-Reply-To: <20220620205654.g7fyipwytbww5757@mobilestation>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Jun 2022 09:03:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDcnAxjxdwpnbfUiDUoo=RGvQm537-EboAmaQTmxpY-g@mail.gmail.com>
Message-ID: <CAMuHMdWDcnAxjxdwpnbfUiDUoo=RGvQm537-EboAmaQTmxpY-g@mail.gmail.com>
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

Hi Serge,

On Mon, Jun 20, 2022 at 10:56 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
> > width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
> > this.
> >
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
> >  1 file changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > index e25d44c218f2..f2b9e3f062cd 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -135,19 +135,41 @@ properties:
> >        of the designware controller, and the upper limit is also subject to
> >        controller configuration.
> >
> > -patternProperties:
> > -  "^.*@[0-9a-f]+$":
> > -    type: object
> > -    properties:
> > -      reg:
> > -        minimum: 0
> > -        maximum: 3
> > -
> > -      spi-rx-bus-width:
> > -        const: 1
> > -
> > -      spi-tx-bus-width:
> > -        const: 1
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: snps,dwc-ssi-1.01a
> > +
> > +then:
> > +  patternProperties:
> > +    "^.*@[0-9a-f]+$":
> > +      type: object
> > +      properties:
> > +        reg:
> > +          minimum: 0
> > +          maximum: 3
> > +
> > +        spi-rx-bus-width:
> > +          const: 4
> > +
> > +        spi-tx-bus-width:
> > +          const: 4
> > +
> > +else:
> > +  patternProperties:
> > +    "^.*@[0-9a-f]+$":
> > +      type: object
> > +      properties:
> > +        reg:
> > +          minimum: 0
> > +          maximum: 3
> > +
> > +        spi-rx-bus-width:
> > +          const: 1
> > +
> > +        spi-tx-bus-width:
> > +          const: 1
>
> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> irrespective from the compatible string. The modern DW APB SSI
> controllers of v.4.* and newer also support the enhanced SPI Modes too
> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
> run-time there is no way to create a DT-schema correctly constraining
> the Rx/Tx SPI bus widths. So let's keep the
> compatible-string-independent "patternProperties" here but just extend
> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
> properties values.
>
> Note the DW APB SSI/AHB SSI driver currently doesn't support the
> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
> activated by means of the corresponding CSR. So most likely the DW AHB
> SSI controllers need some specific setups too.

That doesn't matter here, as DT describes hardware, not software
limitations.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
