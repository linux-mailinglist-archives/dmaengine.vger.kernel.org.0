Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68554FDB75
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354594AbiDLKD7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357442AbiDLITB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 04:19:01 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345C622BEC;
        Tue, 12 Apr 2022 00:43:46 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6DB4A20000B;
        Tue, 12 Apr 2022 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649749422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNKKl0B89mxTmL7IuuBmptC0vwMqvThJjA4HAX6u/T8=;
        b=a5vmG4pPPcFZ8V+LB/7K4J7GtH/fKvOXBzIPD4Aovpf6xIFjrXhK495+KFN8X+XrHr01rQ
        jwMJ6TPkrnFLnpFTjLUT5qD2v++77dahW60KzRQm26JOXdh2l+kVhu5Vo95yWr2Pw0vHje
        6B4ZvYofpy83brEw08RYSYeMNncaNq1nk08wALlrJZj1N3GH/qjD6RM21+suDK0dPh47Kn
        ewLEPbH5DZszfhJT4qt7h8PDTLOBQ4I5pek2zHLl6/aT7HQmDxLJTVKmjPX+9ozICNIqmU
        M7KomQhkB0uHlIV4YJ/HaAI5gUMeaS4vdfdAlRu4ODKw2wQ6Bf0EIkRDsuGSLQ==
Date:   Tue, 12 Apr 2022 09:43:38 +0200
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
Message-ID: <20220412094338.382e8754@xps13>
In-Reply-To: <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
        <20220407004511.3A6D1C385A3@smtp.kernel.org>
        <20220407101605.7d2a17cc@xps13>
        <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
        <20220412093155.090de9d6@xps13>
        <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
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

geert@linux-m68k.org wrote on Tue, 12 Apr 2022 09:37:22 +0200:

> Hi Miquel,
>=20
> On Tue, Apr 12, 2022 at 9:32 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > geert@linux-m68k.org wrote on Mon, 11 Apr 2022 17:09:50 +0200: =20
> > > On Thu, Apr 7, 2022 at 10:16 AM Miquel Raynal <miquel.raynal@bootlin.=
com> wrote: =20
> > > > sboyd@kernel.org wrote on Wed, 06 Apr 2022 17:45:09 -0700: =20
> > > > > Quoting Miquel Raynal (2022-04-06 09:18:47) =20
> > > > > > Here is a first series bringing DMA support to RZN1 platforms. =
Soon a
> > > > > > second series will come with changes made to the UART controller
> > > > > > driver, in order to interact with the RZN1 DMA controller.
> > > > > >
> > > > > > Stephen acked the sysctrl patch (in the clk driver) but somehow=
 I feel
> > > > > > like it would be good to have this patch applied on both sides
> > > > > > (dmaengine and clk) because more changes will depend on the add=
ition of
> > > > > > this helper, that are not related to DMA at all. I'll let you f=
olks
> > > > > > figure out what is best. =20
> > > > >
> > > > > Are you sending more patches in the next 7 weeks or so that will =
touch
> > > > > the same area? If so, then it sounds like I'll need to take the c=
lk
> > > > > patch through clk tree. I don't know what is best because I don't=
 have
> > > > > the information about what everyone plans to do in that file. =20
> > > >
> > > > This series brings DMA support and needs to access the dmamux regis=
ters
> > > > that are in the sysctrl area.
> > > >
> > > > I've sent an RTC series which needs to access this area as well, but
> > > > it is not fully ready yet as it was advised to go for a reset
> > > > controller in this case. The reset controller would be registered by
> > > > the clock driver, so yes it would touch the same file.
> > > >
> > > > Finally, there is an USB series that is coming soon, I don't know if
> > > > it will be ready for merge for 5.19, but it needs to access a speci=
fic
> > > > register in this area as well (h2mode).
> > > >
> > > > So provided that we are able to contribute this reset driver quickly
> > > > enough, I would argue that it is safer to merge the clk changes in =
the
> > > > clk tree. =20
> > >
> > > The clk tree or the renesas-clk tree? ;-) =20
> >
> > Actually I forgot about this tree, would you mind to merge *all* the
> > patches that depend on the sysctrl changes in the renesas/renesas-clk
> > tree? This also stands for the UART and RTC for instance. Otherwise
> > you'll need to set up immutable branches and share them with the
> > dmaengine, serial and rtc trees. I'm fine either way, it's just much
> > less work in the first situation IMHO. =20
>=20
> Sure, I can do that, given acks from the DMA, UART, and RTC
> maintainers.

Ok, I'll say so in the cover letter of the v9.

> So far I've been rather terse in giving feedback on these series,
> as I'm in wait-and-see mode w.r.t. what else you've planned for the
> sysctrl DT node[1] and clock/sys controller code...
>=20
> [1] Did I say I'm not that fond of child nodes? But for the dmamux,
>     it looks like a good solution to handle this.

O:-)

I plan in the coming days to write a proper reset controller driver
that will be queried by the rtc driver (as proposed by Alexandre).
Which means I'll have to declare this reset controller as a child of
the systrl node. If you disagree with it, you may jump-in, see this
thread :

	Subject: Re: [PATCH 2/7] soc: renesas: rzn1-sysc: Export a
		 function to  enable/disable the RTC
	Date: Wed, 6 Apr 2022 10:32:31 +0200

Thanks,
Miqu=C3=A8l
