Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21994C19A7
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbiBWROk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 12:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243299AbiBWROi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 12:14:38 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B27C02;
        Wed, 23 Feb 2022 09:14:09 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9E271FF806;
        Wed, 23 Feb 2022 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645636447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGJxqGIckWbG0AoW8FuQ5NTUMaPmwJ4NcYkXlzqmM2o=;
        b=LJeumpI/pJwigePDQI+PXY2Lz261Znlv7Sj8UlPgf9E97XaZhS+HLaOpLr/1g2i8FL7Lxe
        xrhjCfhumgQ5vom2l+wgA0tjUY2kUmezTlXU1ipkgE+EputW9XC0tv6CHmTyZOW5hkVPRb
        8iSJC6W9HIwwmsiTmlMJ23Nf5RfTSAhmeBcZpb8m42/rNHMdAq+heZs8pkdc0Kk6kYiviG
        CM4e3wmLYmgMY5MDU5ABQRqRtRnNaknoKwFTbbjA2NgVDyMMQKcWbLzQF72RwQAYde3Ma/
        2WJ4ZQ4b1xIcEvc+FQDodNr7Fs90QTei5Y5Hqp2qZVBZ61fTw0oWX07oZvRflA==
Date:   Wed, 23 Feb 2022 18:14:03 +0100
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
Subject: Re: [PATCH v2 7/8] ARM: dts: r9a06g032: Add the two DMA nodes
Message-ID: <20220223181403.11744043@xps13>
In-Reply-To: <CAMuHMdWoH3vySMiCaRxZzT474NwtXfYRAga==SyNsKKaEpiU1Q@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-8-miquel.raynal@bootlin.com>
        <CAMuHMdWoH3vySMiCaRxZzT474NwtXfYRAga==SyNsKKaEpiU1Q@mail.gmail.com>
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

geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:54:20 +0100:

> Hi Miquel,
>=20
> On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > Describe the two DMA controllers available on this SoC.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -184,6 +184,36 @@ nand_controller: nand-controller@40102000 {
> >                         status =3D "disabled";
> >                 };
> >
> > +               dma0: dma-controller@40104000 {
> > +                       compatible =3D "renesas,r9a06g032-dma", "renesa=
s,rzn1-dma";
> > +                       reg =3D <0x40104000 0x1000>;
> > +                       interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clock-names =3D "hclk";
> > +                       clocks =3D <&sysctrl R9A06G032_HCLK_DMA0>; =20
>=20
> power-domains?
>=20
> > +                       dma-channels =3D <8>;
> > +                       dma-requests =3D <16>;
> > +                       dma-masters =3D <1>;
> > +                       #dma-cells =3D <3>; =20
>=20
> <4>? The dmamux bindings say:
>=20
> +      The first four cells are dedicated to the master DMA
> controller. The fifth
> +      cell gives the DMA mux bit index that must be set starting from 0.=
 The
> +      sixth cell gives the binary value that must be written there, ie. =
0 or 1.

The DMAC bindings had initially 3 cells, and then received a fourth
optional one. We do not need it here, that's why I'm keeping #dma-cells
to 3.

But on the mux side, I don't want to deal with the presence or absence
of the optional cell so I assumed we would always request 4 cells for
the DMAC to be on the safe side.

Is this assumption wrong?

Thanks,
Miqu=C3=A8l
