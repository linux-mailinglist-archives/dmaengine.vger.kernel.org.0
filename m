Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5384C1852
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 17:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiBWQRP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiBWQRO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 11:17:14 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071132EE6;
        Wed, 23 Feb 2022 08:16:45 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id w4so3756744vsq.1;
        Wed, 23 Feb 2022 08:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DmRxbGCCqQ2m+24/NebsHhzJx4jsfKGvSXWFxae1yA=;
        b=ZOi1uGwN1ih30N4KAESygop4U2HEmLo98IMLCkiwrukbj6Z5ZA3henrkafv6Q19wF7
         2vt4z7/iW5hmSum00cwCvGMfsqwPLLBcZwyXV/9pMjqm2/OLzhprkrJcbGYS1hRimSqM
         UDcNg8B86v0IQLGySr6mI7jKyfIEYogRnhaJsM08UcpNAKRm0JmM2QtkqEW7eCo6ClOs
         GWBeZdLifX2VTuIxamk/nS5bilmewRklCynhdBdyFXDh0vUuLcdZ590Eey3jhX671rsc
         arz4kvWtREJ1EJZ9f9mZcRe1hZ0qEeTITz12FnonSMPPryV5r1At6EB9Wp4sOaQ0sYpE
         b+og==
X-Gm-Message-State: AOAM532QnS1eOjt5qS7d/J62O0zx1gY8xT3nx/O7y4dLIrfZMaDK3I54
        mVamaQ1efT2jAcTQN4ckMClnCM2MrkJprA==
X-Google-Smtp-Source: ABdhPJxwEZwp3t7bQsz4sX7ugyEbisuE75649jrfekkqcqeduEyWOOl9aWtV5YVrJtpaxyKNlwpahw==
X-Received: by 2002:a05:6102:3a06:b0:31b:d9c6:c169 with SMTP id b6-20020a0561023a0600b0031bd9c6c169mr216596vsu.22.1645633004672;
        Wed, 23 Feb 2022 08:16:44 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id i13sm1017860uap.12.2022.02.23.08.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:16:44 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id u10so3706079vsu.13;
        Wed, 23 Feb 2022 08:16:43 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr226177vsl.68.1645633003682; Wed, 23 Feb
 2022 08:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
 <20220222103437.194779-3-miquel.raynal@bootlin.com> <CAMuHMdVzMiBn-rZgWkp=v7VWqEf1CX9kPTF7qn0cx9va9Z9dWg@mail.gmail.com>
 <20220223164950.18de06a8@xps13>
In-Reply-To: <20220223164950.18de06a8@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 17:16:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVN4Xc7Wo_5B7dv3N2wJCWMRQg=Z6Rx2tMrH=OvNO26ew@mail.gmail.com>
Message-ID: <CAMuHMdVN4Xc7Wo_5B7dv3N2wJCWMRQg=Z6Rx2tMrH=OvNO26ew@mail.gmail.com>
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

Hi Miquel,

On Wed, Feb 23, 2022 at 4:49 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:21:47 +0100:
> > On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > Just like for the NAND controller that is also on this SoC, let's
> > > provide a SoC generic and a more specific couple of compatibles for the
> > > DMA controller.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > > +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> >
> > Perhaps you want to add the power-domains property?
> > The RZ/N1 clock driver is also a clock-domain provider.
>
> I haven't looked at the power domains yet, but I don't plan to invest
> time on it right now. Unless I don't understand your request, and you
> are telling me that someone else added the description and we should
> now point to the right domain from each new node?

The RZ/N1 System Controller is a clock-domain provider.  This means
it can automatically manage the module clocks of devices that are
part of the clock domain, assuming device drivers are using Runtime PM.

The upstream RZ/N1 DTS doesn't have many devices enabled yet.
Most of them are (variants of) Synopsis IP cores, and their drivers
manage clocks explicitly, instead of relying on Runtime PM.

BTW, I have just noticed the system-controller node[1] even lacks
the #power-domain-cells property, while the example[2] does have it.
When that is added, device nodes can gain "power-domains = <&sysctrl>",
and module clocks can be managed from Runtime PM.  Perhaps the NAND
driver would be a good target for conversion to Runtime PM, as its
driver is not shared with SoCs from other vendors yet?
Note this is not mandatory, and drivers can keep on using explicit
clock handling (until the IP core is reused on an SoC that not only
has a clock-domain, but also real power-domains).

[1] arch/arm/boot/dts/r9a06g032.dtsi
[2] Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
