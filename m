Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1255D18F
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbiF0RPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiF0RPF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 13:15:05 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB325F78;
        Mon, 27 Jun 2022 10:15:04 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id m13so10313561ioj.0;
        Mon, 27 Jun 2022 10:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=An//ZVIBHusXq7ojPg64QggrwNUop5VEk57ILCBBv0U=;
        b=CBvltL9en7zdkd9Xbno6IFiA1P8DymS8Gudymsubfx04HeE6ItR2ZXg0GNd1YjS0SH
         deDSIU1Oan8FUDNwy0eRx3NqYxVz3wqQFNjVXnICkPtBr3F/E5pUfB9LNKUGoOJ41yfv
         0JOaHXAizkwDaSwkoSFrNnxMDfh/mPYKNquwrTgZp926JWK62pzfcsWcA+p7+k3EEsnb
         fdA7Dm5wXFDTYKifNPw7k4jnAowpjYfQI8RZGEEW8YE1Kmf9FKYL+iW1G3cmxP2ZJtpS
         VFcR90HTjQoSaJ9FVaRZU+P/UsaN0iwHq/MuEQ6dC9qLklCFDzaDN9PxxHHSRsyaJplY
         NSkg==
X-Gm-Message-State: AJIora8r9OCtTrGY2XShKEJdvNxtPWs9KQrrS3qJnNnQzS/A3NQ5HDAU
        +cz5lB/nQjqwkD1VCiVegQ==
X-Google-Smtp-Source: AGRyM1trlOnex3HcAYrl5SVQu6l8zcvR+jlYFtBQiWM5jDgBNdFpV78MBBeicB8VYl+Oe0sIBxfwBA==
X-Received: by 2002:a05:6638:3387:b0:33c:9f9e:5a17 with SMTP id h7-20020a056638338700b0033c9f9e5a17mr2713672jav.12.1656350104060;
        Mon, 27 Jun 2022 10:15:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a23-20020a056638059700b003320e4b5bb7sm5118946jar.57.2022.06.27.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:15:03 -0700 (PDT)
Received: (nullmailer pid 2608313 invoked by uid 1000);
        Mon, 27 Jun 2022 17:15:00 -0000
Date:   Mon, 27 Jun 2022 11:15:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     fancer.lancer@gmail.com, mail@conchuod.ie, airlied@linux.ie,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, sam@ravnborg.org,
        Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, daniel.lezcano@linaro.org,
        palmer@dabbelt.com, palmer@rivosinc.com, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, damien.lemoal@opensource.wdc.com,
        geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, jee.heng.sia@intel.com,
        joabreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Message-ID: <20220627171500.GA2600685-robh@kernel.org>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
 <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 20, 2022 at 09:06:34PM +0000, Conor.Dooley@microchip.com wrote:
> On 20/06/2022 21:56, Serge Semin wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
> >> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
> >> this.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
> >>  1 file changed, 35 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> index e25d44c218f2..f2b9e3f062cd 100644
> >> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> >> @@ -135,19 +135,41 @@ properties:
> >>        of the designware controller, and the upper limit is also subject to
> >>        controller configuration.
> >>
> >> -patternProperties:
> >> -  "^.*@[0-9a-f]+$":
> >> -    type: object
> >> -    properties:
> >> -      reg:
> >> -        minimum: 0
> >> -        maximum: 3
> >> -
> >> -      spi-rx-bus-width:
> >> -        const: 1
> >> -
> >> -      spi-tx-bus-width:
> >> -        const: 1
> >> +if:
> >> +  properties:
> >> +    compatible:
> >> +      contains:
> >> +        const: snps,dwc-ssi-1.01a
> >> +
> >> +then:
> >> +  patternProperties:
> >> +    "^.*@[0-9a-f]+$":
> >> +      type: object
> >> +      properties:
> >> +        reg:
> >> +          minimum: 0
> >> +          maximum: 3
> >> +
> >> +        spi-rx-bus-width:
> >> +          const: 4
> >> +
> >> +        spi-tx-bus-width:
> >> +          const: 4
> >> +
> >> +else:
> >> +  patternProperties:
> >> +    "^.*@[0-9a-f]+$":
> >> +      type: object
> >> +      properties:
> >> +        reg:
> >> +          minimum: 0
> >> +          maximum: 3
> >> +
> >> +        spi-rx-bus-width:
> >> +          const: 1
> >> +
> >> +        spi-tx-bus-width:
> >> +          const: 1
> > 
> > You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> 
> 8 too? sure.

Then no constraints needed because the common definition already has 
this presumably.

Rob
