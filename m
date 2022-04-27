Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD92511F5B
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbiD0PtI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiD0PtA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 11:49:00 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10B506E7;
        Wed, 27 Apr 2022 08:45:47 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B297AFF805;
        Wed, 27 Apr 2022 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651074346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yf67sjkgBRr+AiPGp+i3USOvi1jzgEhLnw1xa1QO5Ac=;
        b=J7hS7Va7WuegUeM1wmG9bDXCdgHs4tQEcTSOh75c1N0Rwqf+pzAsiGsmisCAoOEhkWYCSf
        vgTh4cjDG0z2a35q224BWwPEPmi5LtEzODNpPd/Fdm6of+4e8GmABsN38xm9fjqIG2V6oI
        +QYGj9fMDGtdmQpRDRBzC8aoGW2cf/8eBKXDJLZZnhB8AJ7FVXc64FQ7akj+mg8THuya1u
        jRAsHx32yRWDCxmV/a0tgGy6rHrzV7gPm+L8Fo8kNhQKKYt7ruTM7BcBYhj4lqN3ILdY1c
        gapJaTpAbqaS/uL4qGpUcEFMPnpyn3bWHD0EjJHda0GDHdlWNfkMapo/vifX1w==
Date:   Wed, 27 Apr 2022 17:45:41 +0200
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
Subject: Re: [PATCH v11 0/9] RZN1 DMA support
Message-ID: <20220427174541.17efcd14@xps13>
In-Reply-To: <CAMuHMdUvD3xsObMJwhUtHVqPpAL-ehW8+sx0Ru8-zm18yWQVKA@mail.gmail.com>
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
        <CAMuHMdU6Mb9k_g7yBCknmL9DMjUSzk=W_5wiMNDMsTN6RpkcLg@mail.gmail.com>
        <20220426093232.350ed9f4@xps13>
        <CAMuHMdUvD3xsObMJwhUtHVqPpAL-ehW8+sx0Ru8-zm18yWQVKA@mail.gmail.com>
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

geert@linux-m68k.org wrote on Wed, 27 Apr 2022 14:50:43 +0200:

> Hi Miquel,
>=20
> On Tue, Apr 26, 2022 at 9:32 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:05:34 +0200: =20
> > > On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote: =20
> > > > This is the series bringing DMA support to RZN1 platforms.
> > > > Other series follow with eg. UART and RTC support as well. =20
> > >
> > > Thanks for your series!
> > > =20
> > > > There is no other conflicting dependency with the other series, so =
this
> > > > series can now entirely be merged in the dmaengine tree I believe.
> > > >
> > > > Changes in v11:
> > > > * Renamed two defines.
> > > > * Changed the way the bitmap is declared.
> > > > * Updated the cover letter: this series can now go in through the
> > > >   dmaengine tree. =20
> > >
> > > /me confused
> > > =20
> > > > Miquel Raynal (9):
> > > >   dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
> > > >   dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subno=
de
> > > >   dt-bindings: dmaengine: Introduce RZN1 DMA compatible
> > > >   soc: renesas: rzn1-sysc: Export function to set dmamux
> > > >   dmaengine: dw: dmamux: Introduce RZN1 DMA router support
> > > >   clk: renesas: r9a06g032: Probe possible children
> > > >   dmaengine: dw: Add RZN1 compatible
> > > >   ARM: dts: r9a06g032: Add the two DMA nodes
> > > >   ARM: dts: r9a06g032: Describe the DMA router =20
> > >
> > > The last two DTS parts have to go in through the renesas-arm-dt and
> > > soc trees. =20
> >
> > Yes, DT usually never go in through subsystem trees anyway, of
> > course they should be taken in through the Renesas tree. For the other
> > patches I think its simpler if everything goes through the dmaengine
> > tree, but I'm fine either way, I'll let you discuss this with the DMA
> > folks if you disagree. =20
>=20
> Fine for me.  I've acked the renesas-clk related patches, so they
> can go in through the dmaengine tree.

Perfect. Sounds like v12 is the right one \o/

Thanks for all the feedback you keep providing on all the RZ/N1
(correctly spelled this time;-) ) series.

Cheers,
Miqu=C3=A8l
