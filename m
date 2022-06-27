Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A455D629
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiF0UV6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 16:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiF0UV4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 16:21:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F31EC62;
        Mon, 27 Jun 2022 13:21:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z13so18483555lfj.13;
        Mon, 27 Jun 2022 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEWNCuKRy84iEbBoB1dMIfYVeUetfldA1vTgDU/ZzpE=;
        b=geDEG3yd1mYJXt6c1aZqzKWP/aSMvf/tfBT02vnFiFO+9ETRIt4umK1PW+NPrV4xAH
         IPwGcjymmEkEzhhk9+XfpXmXGl1Hw9JVqezOplwRathZX7199rU+Z7wL341nIIuFtkZf
         rX2nPa+o+ldHMvBiVu03vmITAtU3+Jlc/PAYiJ2mr2uSfK25+/LYPfwM6msaBK3V5YU+
         /HKZtnsRBNWbAUETnWCFuG2fuIB/wg1zNavS4iltt3gKSZOGaTwwTY6EMCMZedVNKp41
         XYAPLMzh0ibM9cjqHXGiaOyXJy6HDQQZ/imNX5A24xcPor78JRMcqOv2q4TJSZyyxRKh
         dSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEWNCuKRy84iEbBoB1dMIfYVeUetfldA1vTgDU/ZzpE=;
        b=G5n+ibalo6kWzvu9biI9vVVdqC/sCltrUBOma2Ozo7U+cefhIjt9Bq8fXaeAVMweX1
         CXYRWQGCnP5oSVDpPni7lL4DtIl+u88a/y4dJ21ayaIUEkKGNiBkWH8lXGvqo5T54e0o
         iN3SWBLWesFhLG5mA/Y6qdOJXPAaT/gga8jUKvWG6La7tSXijcraNXokC9fxaXKL2wrN
         7dJ2nfEa8FtOxl5vUyHITIBrqTC3b5lChYm+FJ8K+/vxzFZgvt9jjNKwdv5xx0F8AEwK
         dWB8ryUomKAgkPNpu/TJE9tSrnO8V658gQbAiCrXlmfFrvH2Zk92Mvd5Yd4ARD4VezUD
         8uNQ==
X-Gm-Message-State: AJIora/iVPLuBt0qRlLn2xAY4G4DJzJOIaNq6kvOOS0ajqrOj2h5HNz0
        HfCsyRGcq1mmnRom2PQLHS0=
X-Google-Smtp-Source: AGRyM1va63TpZ/BKlBrasRzo3hQuwImYd1Viwhj3pBKVD/eIotL0NPskkSjb7q5nOJbI3zAauoeozw==
X-Received: by 2002:a05:6512:3d8f:b0:47f:a083:a989 with SMTP id k15-20020a0565123d8f00b0047fa083a989mr9505126lfv.646.1656361313593;
        Mon, 27 Jun 2022 13:21:53 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id q4-20020a0565123a8400b004796e1555eesm1917694lfu.199.2022.06.27.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:21:52 -0700 (PDT)
Date:   Mon, 27 Jun 2022 23:21:49 +0300
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
Subject: Re: [PATCH v2 04/16] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width
Message-ID: <20220627202149.624eu7w2gzw7jchd@mobilestation>
References: <20220627194003.2395484-1-mail@conchuod.ie>
 <20220627194003.2395484-5-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627194003.2395484-5-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 27, 2022 at 08:39:52PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Most users of dw-apb-ssi use spi-{r,t}x-bus-width of 1, however the
> Canaan k210 is wired up for a width of 4.
> Quoting Serge:
> The modern DW APB SSI controllers of v.4.* and newer also support the
> enhanced SPI Modes too (Dual, Quad and Octal). Since the IP-core
> version is auto-detected at run-time there is no way to create a
> DT-schema correctly constraining the Rx/Tx SPI bus widths.
> /endquote
> 
> As such, drop the restriction on only supporting a bus width of 1.
> 
> Link: https://lore.kernel.org/all/20220620205654.g7fyipwytbww5757@mobilestation/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Serge, I dropped your R-b when I swapped to the default
> property since it changed the enum.
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index e25d44c218f2..0a43d6e0ef91 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -143,12 +143,6 @@ patternProperties:
>          minimum: 0
>          maximum: 3
>  

> -      spi-rx-bus-width:
> -        const: 1
> -
> -      spi-tx-bus-width:
> -        const: 1
> -

My comment was:
> > > You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> >
> > 8 too? sure.
Then Rob said:
> Then no constraints needed because the common definition already has
> this presumably.

IMO preserving the device-specific constraints even if they match the
generic ones has some maintainability benefits. What if you get to
discover a new HW which supports Hexal mode? Then you would have
needed to update the common schema constraints. But that would have
caused permitting the unsupported bus-mode for all the schemas, which
isn't correct. So as I see it the explicit bus-width enumeration would
be ok to have here. But I'll leave it for Rob to make a final
decision.

Rob

>  unevaluatedProperties: false
>  
>  required:
> -- 
> 2.36.1
> 
