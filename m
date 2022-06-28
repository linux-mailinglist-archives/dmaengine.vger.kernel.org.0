Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7255D979
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbiF1LGQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiF1LGN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 07:06:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384231933;
        Tue, 28 Jun 2022 04:06:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b19so1704289ljf.6;
        Tue, 28 Jun 2022 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74ZknYvbAERmU3fgiRR2mY3FgoTL84vsypu6NISs3NA=;
        b=dDWLan8xSf2psi8Ku75yN5OgwcTLoIo4QLRQchGf/tnOHIEErsIqClR6R6jj0hHnE1
         glxdqv+Q+oNFas8s3KUFWDNz6pCfCPGtgu3GDRYlMy8tJSqLISPSkAXtSSB18Fc1cBl9
         K3i6ywdqZ7ooQdcDjGUO7jYYHtuMLkvdmJ0B7dpE8NaXa1Etww0PTwkNOS43/A+TUy5U
         fbSKJaRnMnBzQpBS8IlH8etIJaUkiMjzJuedU3YNzOd/a7muD3ZZ5O3Ejx5xtKj1NDNE
         X0K/TmyZEHl6Tx4YK+iB9mRmODqCTxt7r/nNT2QWhS3fceeeluPSUjYTDUwqbKQzyWX0
         vMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74ZknYvbAERmU3fgiRR2mY3FgoTL84vsypu6NISs3NA=;
        b=gNZM+u0meoetZWsJHDwXsjTX3v5M9Dzb3b9NI6A8g89MHlTJbbFPvQi/MDcXR1jsAn
         kUv8mpLQE+A7u5mHflL+lMMyMcsDhJjMheOnwX4ySBTrDAhl6/YzqSM2hf3w63xh72/r
         fUq/aoRkf5nXfjeIexo5l/NyGwgo4Y+HheLyZfZmoerDZCgUA0lu0PxQ7hXyNY61nyc9
         llmAbKwbnPZWdvvwRfdEpm0aH7yXt/C2uaNAPXFw0R6sbM++uBSg2EOeIJNnlJ7/FXxJ
         kkx/I1uBeP+8/cvtg9+LgYIfkZIdVdyf68J1hrm3/VaAW91vQsfS7nPQyqA8ngkzcNAp
         cSww==
X-Gm-Message-State: AJIora9Zu0/pgia4zjzt3KeJA0h0/7Q7zmNxUavwtiAo9oAjV4O3D8wb
        fnoH8iki9JqD6/bj/8qxxKE=
X-Google-Smtp-Source: AGRyM1uuwEf2Hbf380gJgJC1h2WOLcL2fEEXBsO7Ix96Zj9MMadTRjHIHgo7LzQz1OVzJUoUH5Gl+w==
X-Received: by 2002:a2e:b88a:0:b0:25b:c698:eede with SMTP id r10-20020a2eb88a000000b0025bc698eedemr4258515ljp.205.1656414369905;
        Tue, 28 Jun 2022 04:06:09 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512371400b0047f9f075e04sm2156981lfr.296.2022.06.28.04.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:06:09 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:06:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Subject: Re: [PATCH 05/14] dt-bindings: timer: add Canaan k210 to Synopsys
 DesignWare timer
Message-ID: <20220628110606.5xdzqxwrrqwymgvn@mobilestation>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-6-mail@conchuod.ie>
 <20220627233025.GA3167724-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627233025.GA3167724-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On Mon, Jun 27, 2022 at 05:30:25PM -0600, Rob Herring wrote:
> On Sat, Jun 18, 2022 at 01:30:27PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > The Canaan k210 apparently has a Sysnopsys Designware timer but
> > according to the documentation & devicetree it has 2 interrupts rather
> > than the standard one. Add a custom compatible that supports the 2
> > interrupt configuration and falls back to the standard binding (which
> > is currently the one in use in the devicetree entry).
> > 
> > Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/timer/snps,dw-apb-timer.yaml     | 28 +++++++++++++++----
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> > index d33c9205a909..9a76acc7a66f 100644
> > --- a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> > +++ b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> > @@ -12,6 +12,9 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - items:
> > +          - const: canaan,k210-apb-timer
> > +          - const: snps,dw-apb-timer
> >        - const: snps,dw-apb-timer
> >        - enum:
> >            - snps,dw-apb-timer-sp
> > @@ -21,9 +24,6 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > -  interrupts:
> > -    maxItems: 1
> > -
> >    resets:
> >      maxItems: 1
> >  
> > @@ -41,7 +41,23 @@ properties:
> >  
> >    clock-frequency: true
> >  
> > -additionalProperties: false
> > +unevaluatedProperties: false
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: canaan,k210-apb-timer
> > +
> > +then:
> > +  properties:
> > +    interrupts:
> > +      maxItems: 2
> 

> When more than 1, you need to define what they are and the order.

Please see my note to v2 of this patch:
Link: https://lore.kernel.org/lkml/20220627211314.dc2hempelyl5ayjg@mobilestation/

-Sergey

> 
> > +
> > +else:
> > +  properties:
> > +    interrupts:
> > +      maxItems: 1
> >  
> >  required:
> >    - compatible
> > @@ -60,8 +76,8 @@ oneOf:
> >  examples:
> >    - |
> >      timer@ffe00000 {
> > -      compatible = "snps,dw-apb-timer";
> > -      interrupts = <0 170 4>;
> > +      compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
> > +      interrupts = <0 170 4>, <0 170 4>;
> >        reg = <0xffe00000 0x1000>;
> >        clocks = <&timer_clk>, <&timer_pclk>;
> >        clock-names = "timer", "pclk";
> > -- 
> > 2.36.1
> > 
> > 
