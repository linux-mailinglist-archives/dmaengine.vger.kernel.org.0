Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4022655262D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jun 2022 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiFTU7U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiFTU6V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 16:58:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CB237F3;
        Mon, 20 Jun 2022 13:56:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b23so4647627ljh.7;
        Mon, 20 Jun 2022 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I1q6whSBjY67mrzgmnGkRh2MNzKa13E3jo+SVBhTEQg=;
        b=XqDUXO3E0jN9GQ9iGhmoxij0PahkYfXP61nSCTKCx/fvSoFpRgDWoLiqAgCUJw1PnX
         GdUgZ6dYoT0Uit7ykMaMR28omMbZ7gDLoi3NlWPpOtwarIrAKYFsFwlDEOerY9w8oIh9
         rbNjhalyLNI+e+pBOTtZlMUNIOGbQPKrYkgGGE49HLjM86guD1yX+eIVXs28qYEpQbEL
         6u9TJxb58aw5NaSuOkvrVJyyneGqycdZCp/nKqOuDGx84SLdx3Jj79iGAZlYRrBgW6bm
         FIeQBMEkq8FhjglPxtSJNnSUrVC7AertpkEpoopILkV/YW/Fu3kY37aS2zC50BoszzoE
         3eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1q6whSBjY67mrzgmnGkRh2MNzKa13E3jo+SVBhTEQg=;
        b=fVeinxp5aaWTvUGdfrPpd7mRoHUu/AH3fG4ZS87T/TrrETruzfxS4dXXs4W99daUvo
         lFZeN4swwddKQ8pCyiPdX4oNVEmQKn4vKrJw/bRar/44k29MBweVUqoFQNNjn6Uo5StP
         XK6JkkUDopHN5Yll0JFxNqj6P4AMr6cwTshnpIEs7/nnsjaWm/A2GEW0mSckC3yH2a1E
         1bDI4/T8fML6djs0C+Xw1KP62irMxiNJsNAncNU4KV8tpeyA7wtz1hF+Z9BeF9ns7Jgz
         YFtbjeYqxBosncUrkYgNKlB7uYyi/flxQuzl1tmYyDwnE8aq/ELzRESo8/wdFfJ95bXd
         tQ2Q==
X-Gm-Message-State: AJIora/gy/kJD74Q2/uTDIrU7gqrelxm7i6XtD3nCFKsv9BVNDbtuIps
        vE4ZZR2WMzwmDwd2/OraoZk=
X-Google-Smtp-Source: AGRyM1to9l7DPfbxuwJzqkPzvrt6m3YRq/lqE+tbkd+LRqyrjxLhnrSzMA6Azd9ZVxOZ5l1LL1DhCQ==
X-Received: by 2002:a05:651c:2107:b0:255:beb0:9969 with SMTP id a7-20020a05651c210700b00255beb09969mr12785405ljq.157.1655758617786;
        Mon, 20 Jun 2022 13:56:57 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id i17-20020ac25b51000000b004778632bff6sm1893799lfp.59.2022.06.20.13.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:56:57 -0700 (PDT)
Date:   Mon, 20 Jun 2022 23:56:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Message-ID: <20220620205654.g7fyipwytbww5757@mobilestation>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618123035.563070-7-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
> this.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index e25d44c218f2..f2b9e3f062cd 100644
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

You can just use a more relaxed constraint "enum: [1 2 4 8]" here
irrespective from the compatible string. The modern DW APB SSI
controllers of v.4.* and newer also support the enhanced SPI Modes too
(Dual, Quad and Octal). Since the IP-core version is auto-detected at
run-time there is no way to create a DT-schema correctly constraining
the Rx/Tx SPI bus widths. So let's keep the
compatible-string-independent "patternProperties" here but just extend
the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
properties values.

Note the DW APB SSI/AHB SSI driver currently doesn't support the
enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
activated by means of the corresponding CSR. So most likely the DW AHB
SSI controllers need some specific setups too.

-Sergey

>  
>  unevaluatedProperties: false
>  
> -- 
> 2.36.1
> 
