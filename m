Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A1511513
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 12:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiD0KqN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiD0KqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 06:46:02 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5814282B41;
        Wed, 27 Apr 2022 03:29:36 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 32924C16AE;
        Wed, 27 Apr 2022 09:39:31 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 145C6240002;
        Wed, 27 Apr 2022 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651052290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRN/OeTEoBAbIZfKfZap1cmQDF6MJtwTJ3zeNwUxoKI=;
        b=Vci9XarbySArRis0diY3Wj2ybIy1BxKjhRzYzgwauFxRTjLkMQkslZtdTLdCZ8Vhr1cO03
        lzM2ftL2t6PTk7ms9ucBQfnQTctjKFDxcNcPLpIZjtwEB5Q4rTmCTMWNxzkIyz4GoBkRAz
        dXTfaiFDBrJkf8CPkjp5W/UJUSi9FMoyLaB8qPrd04N+9n2F4LAOfcsSm1K2cjcGHx3a74
        ArUt4DOIltWVX7H1FGJ8aabsqAU9j9qy5rNnT3nxsnQbr5FXsExl+PZPwVJ4S6rabidWyL
        3Qd3cEDLdGC65MtJbxwMF6oGCTiGkr/3Fd53ckiZQP/N+fl8jmPaoJ1FnkiElQ==
Date:   Wed, 27 Apr 2022 11:38:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v11 8/9] ARM: dts: r9a06g032: Add the two DMA nodes
Message-ID: <20220427113805.45717559@xps13>
In-Reply-To: <CAMuHMdUdJtwOkYT86H5TneMmrVRDrsRqhhaxMp3ruyEkiG+XqA@mail.gmail.com>
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
        <20220421085112.78858-9-miquel.raynal@bootlin.com>
        <CAMuHMdXkrdjETcgN9yruL_J_mL3q7OEMj2DbY36ppwg1eDU5SA@mail.gmail.com>
        <20220427111449.338d9579@xps13>
        <CAMuHMdUdJtwOkYT86H5TneMmrVRDrsRqhhaxMp3ruyEkiG+XqA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Wed, 27 Apr 2022 11:36:23 +0200:

> Hi Miquel,
>=20
> On Wed, Apr 27, 2022 at 11:14 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:29:58 +0200:
> > > On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:
> > > > Describe the two DMA controllers available on this SoC.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Still, a few comments below, valid for both instances...
> > >
> > > > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > > > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > > > @@ -200,6 +200,36 @@ nand_controller: nand-controller@40102000 {
> > > >                         status =3D "disabled";
> > > >                 };
> > > >
> > > > +               dma0: dma-controller@40104000 {
> > > > +                       compatible =3D "renesas,r9a06g032-dma", "re=
nesas,rzn1-dma";
> > > > +                       reg =3D <0x40104000 0x1000>;
> > > > +                       interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_H=
IGH>;
> > > > +                       clock-names =3D "hclk";
> > > > +                       clocks =3D <&sysctrl R9A06G032_HCLK_DMA0>;
> > > > +                       dma-channels =3D <8>;
> > > > +                       dma-requests =3D <16>;
> > > > +                       dma-masters =3D <1>;
> > > > +                       #dma-cells =3D <3>;
> > > > +                       block_size =3D <0xfff>;
> > > > +                       data_width =3D <3>;
> > >
> > > This property is deprecated, in favor of "dma-width".
> >
> > Indeed,
> >         data_width =3D <3>;
> > is deprecated.
> >
> > However, dma-width does not seem to be described anywhere. Do you mean:
> >         data-width =3D <8>;
> > instead?
>=20
> Oops, I did mean "data-width".
>=20
> > > > +                       status =3D "disabled";
> > >
> > > Why not keep it enabled?
> >
> > I'm used to always disable all the nodes from the SoC descriptions,
> > but it's true that for a DMA controller it might make sense to keep
> > it enabled.
> >
> > Would dropping the status property be enough or do you prefer a proper
> >         status =3D "okay";
> > instead?
>=20
> Please just drop the status property, like is done in other Renesas .dtsi
> files.

Sure.

Thanks,
Miqu=C3=A8l
