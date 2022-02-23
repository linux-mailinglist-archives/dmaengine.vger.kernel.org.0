Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962614C17CD
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiBWPy6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 10:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiBWPy5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 10:54:57 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C2C1169;
        Wed, 23 Feb 2022 07:54:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 918F6FF808;
        Wed, 23 Feb 2022 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645631667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrpvXrMghPUC5Fn4OLbvHUF/cai0eceieAz4wZ+pT5o=;
        b=Su7FsY7CsgkqOxmm2tUF0LsGwSqlb1R5B4+z0WlJ3ZKGBRrSDVMojo3uUyigr3uJIQJXFI
        sfBt1+HNLESs+B941F0aUvTGTeLe4WW6lDWtteHjVf33kM6MEo6j+o9eaSP3XgogWNAE4E
        unJuHXjUks02lk0Ecu+cP4nuOSZWV6Tv2NI+dUJlus6J5M5/BcHHiwM+wj7i9Ht6YedIUc
        KQ+qGa3tN15dAEJC2nGyq+kY1HiWlZ8sDLNbnI3vd5aeMDENrZupKpMlTuhT2crM7v0x78
        Vnwk68V0qfmljzrStrP2sYqCY9wDF3k5VXyRwvmtOpdCJF/wD85IWUflqHlslg==
Date:   Wed, 23 Feb 2022 16:54:22 +0100
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
Subject: Re: [PATCH v2 3/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <20220223165422.453c4e7d@xps13>
In-Reply-To: <CAMuHMdXGY7ukSpqq5GzcrfysKDvFy684VVnUKO-SoCn+SJgBEw@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-4-miquel.raynal@bootlin.com>
        <CAMuHMdXGY7ukSpqq5GzcrfysKDvFy684VVnUKO-SoCn+SJgBEw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:28:35 +0100:

> Hi Miquel,
>=20
> On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > The dmamux register is located within the system controller.
> >
> > Without syscon, we need an extra helper in order to give write access to
> > this register to a dmamux driver.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> > @@ -922,6 +947,12 @@ static int __init r9a06g032_clocks_probe(struct pl=
atform_device *pdev)
> >         clocks->reg =3D of_iomap(np, 0);
> >         if (WARN_ON(!clocks->reg))
> >                 return -ENOMEM;
> > +
> > +       if (sysctrl_priv)
> > +               return -EBUSY; =20
>=20
> Can this actually happen, or can the check be removed?

I mostly wanted to prevent the case where a SoC would need the clock
driver to probe twice (sanity check let's say).

> > +
> > +       sysctrl_priv =3D clocks; =20
>=20
> Oh yes, it can happen, if any of the clock registrations below fail
> due to -EPROBE_DEFER. So I think the assignment to sysctrl_priv
> should be postponed until we're sure that can no longer happen.
> Then the check above can be removed, too.

Ok, no problem.

> > +
> >         for (i =3D 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
> >                 const struct r9a06g032_clkdesc *d =3D &r9a06g032_clocks=
[i];
> >                 const char *parent_name =3D d->source ? =20
>=20
> The rest LGTM.

Great, thanks!

Miqu=C3=A8l
