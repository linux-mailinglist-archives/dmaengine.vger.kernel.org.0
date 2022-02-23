Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A74C1994
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 18:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbiBWRLR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiBWRLQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 12:11:16 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918D6B0AD;
        Wed, 23 Feb 2022 09:10:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 96AE120005;
        Wed, 23 Feb 2022 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645636243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSwt/Ot4LoGe9ng93X1S2fF/3zvBslaub0B+kpBf9Lk=;
        b=KP5j9R+sh7tBnnEV1VureDxXxwSe1t3IF4UUZ74aK5dPlv6YjptgYl17EH0dC9z9wP99Ru
        /H3oj9P9VI9GN37lF95433bomtcWtIsE/+7k0zEaNFPQVQWdCR+MEQWMwWlOBZG4u/0R1E
        aW3MII0f2QjzuOAVi55J0/gEPchLRRaOToG13A8XGWtw/nbBcMZdFSa8Zz0v3tGxTC/5VV
        LDePHNu4DOS6q2T3ZRwmMgqJdsF97X78qADzipGa6BeIqmrGfehbxrgT2ZRUzIwUaRJzCd
        iOQeA/2Nf5fPHf3JugLQGBgTsYQLe8j6rLEnLD77EqcDQmTUdeDy7xpRH8Km8Q==
Date:   Wed, 23 Feb 2022 18:10:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2 2/8] dt-bindings: dma: Introduce RZN1 DMA compatible
Message-ID: <20220223181039.4052424b@xps13>
In-Reply-To: <CAMuHMdVN4Xc7Wo_5B7dv3N2wJCWMRQg=Z6Rx2tMrH=OvNO26ew@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-3-miquel.raynal@bootlin.com>
        <CAMuHMdVzMiBn-rZgWkp=v7VWqEf1CX9kPTF7qn0cx9va9Z9dWg@mail.gmail.com>
        <20220223164950.18de06a8@xps13>
        <CAMuHMdVN4Xc7Wo_5B7dv3N2wJCWMRQg=Z6Rx2tMrH=OvNO26ew@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Wed, 23 Feb 2022 17:16:32 +0100:

> Hi Miquel,
>=20
> On Wed, Feb 23, 2022 at 4:49 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:21:47 +0100: =20
> > > On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote: =20
> > > > Just like for the NAND controller that is also on this SoC, let's
> > > > provide a SoC generic and a more specific couple of compatibles for=
 the
> > > > DMA controller.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> > > =20
> > > > +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml=
 =20
> > >
> > > Perhaps you want to add the power-domains property?
> > > The RZ/N1 clock driver is also a clock-domain provider. =20
> >
> > I haven't looked at the power domains yet, but I don't plan to invest
> > time on it right now. Unless I don't understand your request, and you
> > are telling me that someone else added the description and we should
> > now point to the right domain from each new node? =20
>=20
> The RZ/N1 System Controller is a clock-domain provider.=20

Yes, there are many domains managed there.

> This means
> it can automatically manage the module clocks of devices that are
> part of the clock domain, assuming device drivers are using Runtime PM.
>=20
> The upstream RZ/N1 DTS doesn't have many devices enabled yet.
> Most of them are (variants of) Synopsis IP cores, and their drivers
> manage clocks explicitly, instead of relying on Runtime PM.
>=20
> BTW, I have just noticed the system-controller node[1] even lacks
> the #power-domain-cells property, while the example[2] does have it.

Yes, that's why I didn't understand the initial remark.

> When that is added, device nodes can gain "power-domains =3D <&sysctrl>",
> and module clocks can be managed from Runtime PM.  Perhaps the NAND
> driver would be a good target for conversion to Runtime PM, as its
> driver is not shared with SoCs from other vendors yet?
> Note this is not mandatory, and drivers can keep on using explicit
> clock handling (until the IP core is reused on an SoC that not only
> has a clock-domain, but also real power-domains).

Got it, thanks for the details. Indeed it would be interesting to gain
runtime PM support if this SoC has a good power-domain support.

Power domain cells must first be contributed.

> [1] arch/arm/boot/dts/r9a06g032.dtsi
> [2] Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds


Thanks,
Miqu=C3=A8l
