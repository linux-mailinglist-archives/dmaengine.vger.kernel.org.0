Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD0511409
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiD0JGJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiD0JGG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 05:06:06 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35AD1D70DA;
        Wed, 27 Apr 2022 02:02:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7D56D200003;
        Wed, 27 Apr 2022 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651050154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+rW5mXOv5sbGat0TDX1wCwn8FAk7uPLtDbpW3WtQ0M=;
        b=OExvz/fso96rIW52h/+SICEP1ySdo298YEFNftVJH2dwKMIBVt8zG5jFi1yEIUaDWm4HjM
        97CjSPmMfdXB0Yw2uMVoshEQK0a0shs+vsjEEnUjHPFNW0/EQdjyGOlDTbIqO9wlfcmCjo
        wqB+2GUfdVhe+copVOqNZg01oV56BIaOWcdUXjmCMMPQIxMTDVkRxgF7a1Qo4Vcx3XpnEB
        MX7FptvGuTxGYKUYpHB+WGUBcv2kYz5rWMZdmIdzq7lGGclVJ5b5PG/mYu6oHuUYfuOvVt
        ovyuSTisZL8Wdkpn2ZXhzOtv/ktDmUL5tmMWJAl+OcCZ96CZYJT+iiRteKmYOQ==
Date:   Wed, 27 Apr 2022 11:02:29 +0200
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
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v11 6/9] clk: renesas: r9a06g032: Probe possible
 children
Message-ID: <20220427110229.25825aaa@xps13>
In-Reply-To: <CAMuHMdWaViDYRnwdpD+m73ZisDSMKESfcGbanf6qXR1M2167EQ@mail.gmail.com>
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
        <20220421085112.78858-7-miquel.raynal@bootlin.com>
        <CAMuHMdWaViDYRnwdpD+m73ZisDSMKESfcGbanf6qXR1M2167EQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:18:28 +0200:

> Hi Miquel,
>=20
> On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > The clock controller device on r9a06g032 takes all the memory range that
> > is described as being a system controller. This range contains many
> > different (unrelated?) registers besides the ones belonging to the clock
> > controller, that can necessitate to be accessed from other peripherals.
> >
> > For instance, the dmamux registers are there. The dmamux "device" will
> > be described as a child node of the clock/system controller node, which
> > means we need the top device driver (the clock controller driver in this
> > case) to populate its children manually.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org> =20
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> > @@ -996,7 +997,7 @@ static int __init r9a06g032_clocks_probe(struct pla=
tform_device *pdev)
> >
> >         sysctrl_priv =3D clocks;
> >
> > -       return 0;
> > +       return of_platform_populate(np, NULL, NULL, dev); =20
>=20
> This is a bit dangerous: in the (very unlikely) case that
> of_platform_populate() fails, the clock driver will fail to probe,
> and all managed cleanup will be done (not everything will be cleant
> up, though), while sysctrl_priv will still point to the now-freed
> r9a06g032_priv structure.
>=20
> So I think you just want to ignore the failure from
> of_platform_populate(), and return zero anyway.

That is a very good point. I've changed the logic to just print an
error message and return 0 anyway.

Thanks,
Miqu=C3=A8l
