Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4526500C1D
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiDNL1x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiDNL12 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 07:27:28 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517243AA4D;
        Thu, 14 Apr 2022 04:25:02 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BC95B20003;
        Thu, 14 Apr 2022 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649935500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpXnu283Y9BImJWjRcqDTNSCLv7O9zSkjtgobyNWNkk=;
        b=VFAvo1HKcbMfgjPRb2K9JOxVgtxYM2fmACdTAMdXP0BC1ewA06cPBHbL2LVnWCi+C5Cg26
        mEYbILpM2nuTEikkL+qgf+6KRGYPdcSqYhjZz7Ow5ldkr4qodvIFf9Wo9J4XEzxA6L4FEz
        4tGL+eHeZKNwe+wyHPqHnHzOSdLYm223GjiKHhl8wLIYojFKrptNVWdqLnmwISxS9H6GwL
        D/xaoxNPH0hOPaZFrdL+YeGYJ/5b5nWllgRj3/exsblpTuSJ5xtCto2d+iCqdz1tILV7Aa
        Z+PzrYk9/Yp37RTga3x2OLYx10YZjkWyhV5QM3KscvlE0Yp1h7Sos+XiDcGChA==
Date:   Thu, 14 Apr 2022 13:24:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
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
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
Message-ID: <20220414132456.30b19306@xps13>
In-Reply-To: <CAMuHMdXPRb0SiCtYcqAy5YJEGp3U30FaXcmjMpgc=szXUnShpA@mail.gmail.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
        <20220407004511.3A6D1C385A3@smtp.kernel.org>
        <20220407101605.7d2a17cc@xps13>
        <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
        <20220412093155.090de9d6@xps13>
        <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
        <20220412094338.382e8754@xps13>
        <CAMuHMdVaWskmiqUEyGyz7HKUjgzFhx+5hAJxd5od7Hp4hFD1KA@mail.gmail.com>
        <20220412100301.03ccece8@xps13>
        <CAMuHMdXPRb0SiCtYcqAy5YJEGp3U30FaXcmjMpgc=szXUnShpA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Tue, 12 Apr 2022 10:12:41 +0200:

> Hi Miquel,
>=20
> On Tue, Apr 12, 2022 at 10:03 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > geert@linux-m68k.org wrote on Tue, 12 Apr 2022 09:52:25 +0200: =20
> > > On Tue, Apr 12, 2022 at 9:43 AM Miquel Raynal <miquel.raynal@bootlin.=
com> wrote: =20
> > > > geert@linux-m68k.org wrote on Tue, 12 Apr 2022 09:37:22 +0200: =20
> > > > > So far I've been rather terse in giving feedback on these series,
> > > > > as I'm in wait-and-see mode w.r.t. what else you've planned for t=
he
> > > > > sysctrl DT node[1] and clock/sys controller code...
> > > > >
> > > > > [1] Did I say I'm not that fond of child nodes? But for the dmamu=
x,
> > > > >     it looks like a good solution to handle this. =20
> > > >
> > > > O:-)
> > > >
> > > > I plan in the coming days to write a proper reset controller driver
> > > > that will be queried by the rtc driver (as proposed by Alexandre). =
=20
> > >
> > > OK.
> > > =20
> > > > Which means I'll have to declare this reset controller as a child of
> > > > the systrl node. If you disagree with it, you may jump-in, see this
> > > > thread :
> > > >
> > > >         Subject: Re: [PATCH 2/7] soc: renesas: rzn1-sysc: Export a
> > > >                  function to  enable/disable the RTC
> > > >         Date: Wed, 6 Apr 2022 10:32:31 +0200 =20
> > >
> > > But do you need a child node for that? All(most all) other Renesas
> > > clock drivers provide reset functionality, and none of them use a
> > > child node for that. =20
> >
> > How do you "request" the reset handle from the consumer driver if it's
> > not described in the DT? Do you have examples to share? =20
>=20
> I didn't say it does not need to be described in DT ;-)
>=20
> Just add "#reset-cells =3D <1>" to the sysctrl node, and nodes can
> start referring to it using "resets =3D <&sysctrl N>".
> Currently, the sysctrl node is already a clock and power-domain provider.
>=20
> Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
> shows an R-Car CPG/MSSR node providing clock, power-domain, and
> reset functionalities.

While working on implementing a reset controller driver, I realized
that almost all the clocks had a reset, which was already managed by the
driver as part of a number of additional possible signals (gate
reset, gate master idle, gate ready...). So I actually figured out
that my issue originated from an incomplete description of the RTC clock
gate, which I fulfilled. Now it works without the need for an additional
exported symbol.

Thanks,
Miqu=C3=A8l
