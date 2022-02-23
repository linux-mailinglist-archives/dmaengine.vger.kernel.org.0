Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA06C4C113D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbiBWL14 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 06:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbiBWL1v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 06:27:51 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EC3CA4D;
        Wed, 23 Feb 2022 03:27:23 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id g21so2773862vsp.6;
        Wed, 23 Feb 2022 03:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCNg1dsvPK2cBaOM9RaFK2fkB9AEdshhbIiM7c0UENw=;
        b=XETiVgOxdwnbwZFx3HqyuH/fT529T4GP0nqUZSweIs4XZM1u+k7Y9icHe6wmJ47pk0
         2yle23OhAMsKc/R4oN0k/z5wsrk/uleEoNFKkSu4EISK0W7h1doH44YziVPk2kefjEH5
         ch4zEPyYDCfEJ3p/vbLOCFi0nrmqWFZxwg2Jj98s75HZdz2V/Ni2Ch8HX3Ov/xJbIitd
         273r5hSLjaWfOO5T8oyfA9Rx7MA4M5dXm8IfMyMH6rp17qf1sbB4ucvsM15iVfRBa7Ry
         /6vtNQGgpnEayTy318ynCc3Lcq1QodUPpHLk1PoxPi0oHfD3GVN0fwBFIpZo1YoC6YzF
         QLKw==
X-Gm-Message-State: AOAM5327w/fSulyIpaUsDdU4EsAdCuY14oli+cBrBunDbtb519tH3kjj
        7ddQ5fO3MlnSPZG5cvcFm47eUbIjAgrvOA==
X-Google-Smtp-Source: ABdhPJzD1xrDgXnqyaCr3y34geL6gcdufvrQQHEKhzlNeVwwl2t5LNxGaZzPrdwMWFoKp0ehM7gdFA==
X-Received: by 2002:a67:d589:0:b0:31b:5561:b18e with SMTP id m9-20020a67d589000000b0031b5561b18emr11884394vsj.53.1645615642261;
        Wed, 23 Feb 2022 03:27:22 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id u6sm8521559vku.15.2022.02.23.03.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:27:22 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id d11so2767979vsm.5;
        Wed, 23 Feb 2022 03:27:21 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr11543425vsb.5.1645615641619; Wed, 23
 Feb 2022 03:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com> <20220222103437.194779-2-miquel.raynal@bootlin.com>
In-Reply-To: <20220222103437.194779-2-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 12:27:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJ5nNf0d2tn05HcknznK199U6oFkZSR-BrFhmurRR8HA@mail.gmail.com>
Message-ID: <CAMuHMdXJ5nNf0d2tn05HcknznK199U6oFkZSR-BrFhmurRR8HA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: dma: Introduce RZN1 dmamux bindings
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

On Tue, Feb 22, 2022 at 11:34 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/renesas,rzn1-dmamux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/N1 DMA mux
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +allOf:
> +  - $ref: "dma-router.yaml#"
> +
> +properties:
> +  compatible:
> +    const: renesas,rzn1-dmamux

Do we want an SoC-specific compatible value, too?
See also my comments on the dmamux driver.

> +
> +  '#dma-cells':
> +    const: 6
> +    description:
> +      The first four cells are dedicated to the master DMA controller. The fifth
> +      cell gives the DMA mux bit index that must be set starting from 0. The
> +      sixth cell gives the binary value that must be written there, ie. 0 or 1.
> +
> +  dma-masters:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-requests:
> +    const: 32

Do we need this in DT? It depends on the actual dmamux hardware,
and is (currently) the register width of the CFG_DMAMUX register.

The rest LGTM (I'm no dma-router expert),so with the above clarified:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
