Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253D34C12AA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 13:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiBWMW3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 07:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiBWMW1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 07:22:27 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B59AD9B;
        Wed, 23 Feb 2022 04:22:00 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id e26so2951862vso.3;
        Wed, 23 Feb 2022 04:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH9kx8uglIy4IymTz3ycr2PEM2TVDcpmS0Wpy32dbbI=;
        b=7ZL1+71pUijFszLPbokmpDzFI9Vdv+y7l55adoxsO5W3FP2Ey0HSj2INOUUZl0OcgL
         EE1ythJiv/r5XwZCCCcwpWzwyv4OPwC9bV4EBT9rmUlYqt076lHohAumz35GpoF1Znvj
         97M+qMdBWEdijf7Q7qwJVPuLfDwg9uS5PYIIR4eHSA+A5JfV9i1DvqY2C5kwFJusaTk/
         BNFjbOHZ5SlSJF+uhkLl7FHy/GPTWP7H9oku0yD70dPfzznVVy13tGgYkE5prcpzfga3
         astpFD/tmZPTA+JyFViGeLWZC5wdeXxO43I3C80JFGQs4/kwIttMr7kd9XtqlM3OmJej
         rzDQ==
X-Gm-Message-State: AOAM532rrsFim7cBtL7iw400q35mfvrL2tkUlNSz0cY7n6rcavxitfWY
        EDEWIkHH0JDSBND61VhTiun971dO+rt/hw==
X-Google-Smtp-Source: ABdhPJzbuskKnYq8oJB/4rObpZcTKXVv2SrEX++zKypPtsZe9cYXvqaaBLAgrxH2Pudvpaq209emOw==
X-Received: by 2002:a05:6102:3116:b0:31b:f7e2:c504 with SMTP id e22-20020a056102311600b0031bf7e2c504mr11236202vsh.58.1645618919137;
        Wed, 23 Feb 2022 04:21:59 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id y22sm646492vsi.25.2022.02.23.04.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:21:58 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id i27so2909504vsr.10;
        Wed, 23 Feb 2022 04:21:58 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr11609191vsb.5.1645618918150; Wed, 23
 Feb 2022 04:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com> <20220222103437.194779-3-miquel.raynal@bootlin.com>
In-Reply-To: <20220222103437.194779-3-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 13:21:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzMiBn-rZgWkp=v7VWqEf1CX9kPTF7qn0cx9va9Z9dWg@mail.gmail.com>
Message-ID: <CAMuHMdVzMiBn-rZgWkp=v7VWqEf1CX9kPTF7qn0cx9va9Z9dWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: dma: Introduce RZN1 DMA compatible
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

On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Just like for the NAND controller that is also on this SoC, let's
> provide a SoC generic and a more specific couple of compatibles for the
> DMA controller.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

> +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml

Perhaps you want to add the power-domains property?
The RZ/N1 clock driver is also a clock-domain provider.

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
