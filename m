Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1988D55120F
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jun 2022 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiFTICW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiFTICV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 04:02:21 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C31145D;
        Mon, 20 Jun 2022 01:02:20 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id c1so14516545qvi.11;
        Mon, 20 Jun 2022 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6iOgcYMqJ9zOwx1P0bKGX4G545U6AIxu9kHxZeyUd0=;
        b=J3htXg1EPv1BalqywQs3Ybn4KQ+idKLCI1sqx15OBE6cn6qnP0H6CeCGhARK4Md01b
         QPmOnK6+OdCTdpKftctxpvXg64MonaqNOdOoQnN+1vVSioiNIkK26N3SAQfG2W6Q0APA
         BA/euf01jTM0PpO90YxA9W3vnXTES/HIQt6OqHZqmChe6/jJ2NCzPP5IcmOIR5y8Zngv
         Gv09K8KdzYVxjEF/n4MbtNr4djM4pZgeydVPo2w6SYbMw71LmJeQ+Ss+k8b1n2BMeumt
         pnq3qQVbivlh/vO6+bDzyz2TB2k3adouB5zd2sgdU//O378xNqKMTNhbOo9isNkiOd97
         UI1Q==
X-Gm-Message-State: AJIora9wJzcoVZFdarqMgw0xfmetd8DtxF8b+JgTEohnUBTvpPxCnyWy
        jM85VA1R7lCSZRnWJjTTR4ggQVWYT7K6qA==
X-Google-Smtp-Source: AGRyM1vHgp9LHpiJ7Aqcns08PZ2ZNxRyprRpMxnZujRmGz0+s8hIYBEFAdOJpUPgoyLj15Y+Hk0hoQ==
X-Received: by 2002:ac8:5915:0:b0:304:f2f8:f254 with SMTP id 21-20020ac85915000000b00304f2f8f254mr18791942qty.303.1655712139119;
        Mon, 20 Jun 2022 01:02:19 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id j17-20020a05620a289100b006a6d7c3a82esm11798285qkp.15.2022.06.20.01.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:02:17 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id v81so17621539ybe.0;
        Mon, 20 Jun 2022 01:02:17 -0700 (PDT)
X-Received: by 2002:a25:bd41:0:b0:668:c259:f6c2 with SMTP id
 p1-20020a25bd41000000b00668c259f6c2mr15091616ybm.365.1655712136748; Mon, 20
 Jun 2022 01:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220618123035.563070-1-mail@conchuod.ie> <20220618123035.563070-7-mail@conchuod.ie>
In-Reply-To: <20220618123035.563070-7-mail@conchuod.ie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jun 2022 10:02:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtjZVvy-gGTksVRYa+dS7-1ngQf9_kfp6k29nkfizKbA@mail.gmail.com>
Message-ID: <CAMuHMdXtjZVvy-gGTksVRYa+dS7-1ngQf9_kfp6k29nkfizKbA@mail.gmail.com>
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
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
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

Hi Conor,

On Sat, Jun 18, 2022 at 2:32 PM Conor Dooley <mail@conchuod.ie> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
> this.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -135,19 +135,41 @@ properties:
>        of the designware controller, and the upper limit is also subject to
>        controller configuration.
>
> -patternProperties:
> -  "^.*@[0-9a-f]+$":
> -    type: object
> -    properties:
> -      reg:
> -        minimum: 0
> -        maximum: 3
> -
> -      spi-rx-bus-width:
> -        const: 1
> -
> -      spi-tx-bus-width:
> -        const: 1
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: snps,dwc-ssi-1.01a
> +
> +then:
> +  patternProperties:
> +    "^.*@[0-9a-f]+$":
> +      type: object
> +      properties:
> +        reg:
> +          minimum: 0
> +          maximum: 3
> +
> +        spi-rx-bus-width:
> +          const: 4
> +
> +        spi-tx-bus-width:
> +          const: 4

These two also depend on the board (SPI device + wiring).
So all of [1, 2, 4] are valid values.

> +
> +else:
> +  patternProperties:
> +    "^.*@[0-9a-f]+$":
> +      type: object
> +      properties:
> +        reg:
> +          minimum: 0
> +          maximum: 3
> +
> +        spi-rx-bus-width:
> +          const: 1
> +
> +        spi-tx-bus-width:
> +          const: 1
>
>  unevaluatedProperties: false

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
