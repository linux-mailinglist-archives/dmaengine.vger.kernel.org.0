Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E355E7F6
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346552AbiF1P0H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiF1P0G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 11:26:06 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B742DA9D;
        Tue, 28 Jun 2022 08:26:06 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id u20so13204462iob.8;
        Tue, 28 Jun 2022 08:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVoUetZ5S/GqO2CHeSuZD5HjqLM10h5uZxs1HR13hfg=;
        b=hllCHjeYk/PZ7+/WyqC1MfqxXQ9ewqwhA6ZXUBM+25j5duk2wN0pXwb2EveaHJ2ALI
         MZm08Rq7GqNUcBN31vHPEbeAYcHATm3d1p58cgIfRlfB2hLWrYf8lcyPSnq3KSfXrqcR
         rHBlanjcYDd+gImPiIdivVXXuUeNj8WGzNOQBte+qLxcUQlIi67ESRoblUzaQMMHq4iW
         pqvSJLzlK0LSd0p34TpDNt5hgppfws8LRgrJP+GhfZ+OXfY0IkOyYAFZU4yfGGchZtnf
         yD2BiupWhxVhEsnRy/lrtOiMeCO0DGNMLFzaLETZyR35GcfUupSKp14Jbtyurt2u5I8y
         m2uw==
X-Gm-Message-State: AJIora8vjwLcQRxm33+vSw9jjsDpnCCfPLP7wceI4R2UhvDR/3WMiSke
        ZozJohOZiabnmUOMnYumBA==
X-Google-Smtp-Source: AGRyM1u30z6rjSQP/yfjddK3j5eb9UHQa30g9hrzhKsueFxERdQlxns3zeN/rJtosCIDlaE+/J+6ew==
X-Received: by 2002:a05:6638:14c3:b0:331:8153:e5b with SMTP id l3-20020a05663814c300b0033181530e5bmr11835574jak.114.1656429965253;
        Tue, 28 Jun 2022 08:26:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y20-20020a6bd814000000b006751347e61bsm5482552iob.27.2022.06.28.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:26:04 -0700 (PDT)
Received: (nullmailer pid 491422 invoked by uid 1000);
        Tue, 28 Jun 2022 15:26:01 -0000
Date:   Tue, 28 Jun 2022 09:26:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Subject: Re: [PATCH v2 04/16] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width
Message-ID: <20220628152601.GA465684-robh@kernel.org>
References: <20220627194003.2395484-1-mail@conchuod.ie>
 <20220627194003.2395484-5-mail@conchuod.ie>
 <20220627202149.624eu7w2gzw7jchd@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202149.624eu7w2gzw7jchd@mobilestation>
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

On Mon, Jun 27, 2022 at 11:21:49PM +0300, Serge Semin wrote:
> On Mon, Jun 27, 2022 at 08:39:52PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Most users of dw-apb-ssi use spi-{r,t}x-bus-width of 1, however the
> > Canaan k210 is wired up for a width of 4.
> > Quoting Serge:
> > The modern DW APB SSI controllers of v.4.* and newer also support the
> > enhanced SPI Modes too (Dual, Quad and Octal). Since the IP-core
> > version is auto-detected at run-time there is no way to create a
> > DT-schema correctly constraining the Rx/Tx SPI bus widths.
> > /endquote
> > 
> > As such, drop the restriction on only supporting a bus width of 1.
> > 
> > Link: https://lore.kernel.org/all/20220620205654.g7fyipwytbww5757@mobilestation/
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Serge, I dropped your R-b when I swapped to the default
> > property since it changed the enum.
> > ---
> >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > index e25d44c218f2..0a43d6e0ef91 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -143,12 +143,6 @@ patternProperties:
> >          minimum: 0
> >          maximum: 3
> >  
> 
> > -      spi-rx-bus-width:
> > -        const: 1
> > -
> > -      spi-tx-bus-width:
> > -        const: 1
> > -
> 
> My comment was:
> > > > You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> > >
> > > 8 too? sure.
> Then Rob said:
> > Then no constraints needed because the common definition already has
> > this presumably.
> 
> IMO preserving the device-specific constraints even if they match the
> generic ones has some maintainability benefits. What if you get to
> discover a new HW which supports Hexal mode? 

x16? Wouldn't we be back to parallel NOR and the problems with parallel 
buses?

> Then you would have
> needed to update the common schema constraints. But that would have
> caused permitting the unsupported bus-mode for all the schemas, which
> isn't correct. So as I see it the explicit bus-width enumeration would
> be ok to have here. But I'll leave it for Rob to make a final
> decision.

Assuming a new width does appear, it's just a matter of time before the 
DW block has a new rev supporting it too, so there's 2 places to update. 
Also, a given platform may pinout less than the block supports, so you 
can't ever be 100% sure an out of range value is in a DT.

But either way is okay with me. If you do keep constraints, you only 
need 'maximum: 8'.

Acked-by: Rob Herring <robh@kernel.org>

Rob
