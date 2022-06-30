Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053BD5620AE
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jun 2022 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiF3Q50 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jun 2022 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiF3Q5W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jun 2022 12:57:22 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC07393DC;
        Thu, 30 Jun 2022 09:57:21 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id p9so12491515ilj.7;
        Thu, 30 Jun 2022 09:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cSCjzkkaYP9MYdWZQafK4xMoYiSrEDWkLIVS/pLNRR8=;
        b=JmV7Xak6rkAw/IIrTD8iY8w38WPI88kBk7nLKfjetfg04LNFPiUXEDkjmISZec4N3H
         GXm40CZ9XEeDb7iLPScDqs5zcJ179gLte5Oe2F/UogWu8POy64s6v4c3A5uoJxwi/uPr
         ohFaziFaTPf0Ko3EnxK7cclEo3VI468FmXqzg/RxVDIXadLL3bae36JGdbQwLhk0Ub7n
         VomTJEN8tIkBhmTGtiEEDpsVI9eEH3jew/PnM4pmqkD67oowqrRdCqq1AV6UmYHcNygO
         nDRAHxjpZN7LbKkfYy9Vpk8JG+fQdTxx7jb2DlX5yuChgUU8sIrnkYhF/F3x9UAgknGj
         +i5A==
X-Gm-Message-State: AJIora9y36wf4Doxgne49ArSEUSsprnUYoqnFz1swjH4XBazdC6ae11M
        DzsLBO7dYtuvLs/GDsY8tKB48z0tPA==
X-Google-Smtp-Source: AGRyM1ur4AOc7bK5eVjgml5dO/I1YI3o54vzy9DsjE/7iDAB6CuVvnaI9nMRxVWdksw+oB2ay497Pw==
X-Received: by 2002:a92:cd8f:0:b0:2d9:5d44:6a53 with SMTP id r15-20020a92cd8f000000b002d95d446a53mr5817684ilb.226.1656608240763;
        Thu, 30 Jun 2022 09:57:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q25-20020a05663810d900b0032e1a07228asm8851588jad.26.2022.06.30.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:57:20 -0700 (PDT)
Received: (nullmailer pid 2895373 invoked by uid 1000);
        Thu, 30 Jun 2022 16:57:17 -0000
Date:   Thu, 30 Jun 2022 10:57:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, dmaengine@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mark Brown <broonie@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 04/15] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width
Message-ID: <20220630165717.GA2895317-robh@kernel.org>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <20220629184343.3438856-5-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629184343.3438856-5-mail@conchuod.ie>
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

On Wed, 29 Jun 2022 19:43:33 +0100, Conor Dooley wrote:
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
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
