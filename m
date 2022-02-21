Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8E4BE8D8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 19:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378725AbiBUPCZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 10:02:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378659AbiBUPCX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 10:02:23 -0500
X-Greylist: delayed 7320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 07:01:36 PST
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F7E0D;
        Mon, 21 Feb 2022 07:01:31 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 96541100015;
        Mon, 21 Feb 2022 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645455686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hK8yaZhqzk1pLLQ0EIRdH5lQc4U08JDqPo1Cz+pstQU=;
        b=fxefFsnJtjw0wIlbRk3lkZrzOYrgPmEfqJGrdG+afxpHk3u087CAgCacd9BKOQ5ngMZBOo
        lRoJQsmNjW5MkMRiMtENwgxOTLFk9mllDeShWemKC+rsqzJPM2/AbyQ+4rTQRpfS4pF/yj
        yp/3qM/7AeuuRFQojwKJXITP5Jgf5gJXUeu7ckHU5z5HyKs550vki2xaqSPhfMQImwdGaL
        P4jG8WkEs5Kgd5eJuRjJvWr+knb10/Qf8d3F2SLFeYAbP0MWibPu34uZ4EAQKQUHnEmmgZ
        vR40cxTsDiZiNJE2yxersBJE306G1R3tmyTgG9yhKuw92onKE3kotNEKQtCZfw==
Date:   Mon, 21 Feb 2022 16:01:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <20220221160121.6a7a0ed6@xps13>
In-Reply-To: <CAMuHMdWBfJSeEOev81WYSEw+9FAcUzBnN2n5BHJ2n0ig=6fxKQ@mail.gmail.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
        <20220218181226.431098-4-miquel.raynal@bootlin.com>
        <CAMuHMdWBfJSeEOev81WYSEw+9FAcUzBnN2n5BHJ2n0ig=6fxKQ@mail.gmail.com>
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

geert@linux-m68k.org wrote on Mon, 21 Feb 2022 10:16:24 +0100:

> Hi Miquel,
>=20
> On Fri, Feb 18, 2022 at 7:12 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
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
> > +++ b/drivers/clk/renesas/r9a06g032-clocks.c =20
>=20
> Missing #include <linux/soc/renesas/r9a06g032-syscon.h>
>=20
> > @@ -315,6 +315,27 @@ struct r9a06g032_priv {
> >         void __iomem *reg;
> >  };
> >
> > +/* Exported helper to access the DMAMUX register */
> > +static struct r9a06g032_priv *syscon_priv; =20
>=20
> I'd call this sysctrl_priv, as that matches the bindings and
> binding header file name.

Ok.

>=20
> > +int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
> > +{
> > +       u32 dmamux;
> > +
> > +       if (!syscon_priv)
> > +               return -EPROBE_DEFER;
> > +
> > +       spin_lock(&syscon_priv->lock); =20
>=20
> This needs propection against interrupts =3D> spin_lock_irqsave().

Yes.

>=20
> > +
> > +       dmamux =3D readl(syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
> > +       dmamux &=3D ~mask;
> > +       dmamux |=3D val & mask;
> > +       writel(dmamux, syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
> > +
> > +       spin_unlock(&syscon_priv->lock);
> > +
> > +       return 0;
> > +}
> > +
> >  /* register/bit pairs are encoded as an uint16_t */
> >  static void
> >  clk_rdesc_set(struct r9a06g032_priv *clocks, =20
>=20
> > --- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
> > +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
> > @@ -145,4 +145,6 @@
> >  #define R9A06G032_CLK_UART6            152
> >  #define R9A06G032_CLK_UART7            153
> >
> > +#define R9A06G032_SYSCON_DMAMUX                0xA0 =20
>=20
> I don't think this needs to be part of the bindings, so please move
> it to the driver source file.

I've moved it to the top of the file. There definitions are a bit mixed
with the code, I don't like this, so I kept it at the top.

>=20
> > --- /dev/null
> > +++ b/include/linux/soc/renesas/r9a06g032-syscon.h =20
>=20
> r9a06g032-sysctrl.h etc.

Done.

>=20
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__
> > +#define __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__
> > +
> > +#ifdef CONFIG_CLK_R9A06G032
> > +int r9a06g032_syscon_set_dmamux(u32 mask, u32 val);
> > +#else
> > +static inline int r9a06g032_syscon_set_dmamux(u32 mask, u32 val) { ret=
urn -ENODEV; }
> > +#endif
> > +
> > +#endif /* __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__ */
> > --
> > 2.27.0 =20
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
