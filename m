Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9E50F28C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiDZHfv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Apr 2022 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344028AbiDZHft (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Apr 2022 03:35:49 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E9F8E70;
        Tue, 26 Apr 2022 00:32:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 78C7324000B;
        Tue, 26 Apr 2022 07:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650958356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKTZnsZsqmXZVFHnJzXGzABByJosRfbnUL/DTMhMw7w=;
        b=Ws1WNfBRgV6efObectf5Wi/XBQWi92pIPZwEEsYSAcFP+yC4UgmVjxUA95jETo0mW8Uy7y
        AE2F5ssPhKibSBdiKtU3oUq2I5yGneK0UIaHF7Q7a742FlXOtKyn8kviG9mmSJStV2l91M
        vockGRJiiS6XMrptQBRod6sSrLPpsx4juFt2hJRqCXpiOjNaLmq8SWVzV1CTVTglJIv+cU
        ny/3cfW3Tss6IVioRz+ol/djjTIlZXWKJ4CKQrnxFaUAKm83Yup6OFNyTw4RkkaOUn5hZq
        PNxfIAf0FBJzj+dB4WLcQ5AwuZ99V2MoL+brwHRZbQLW/Hk4ZVxYtEIcDco+yA==
Date:   Tue, 26 Apr 2022 09:32:32 +0200
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
Message-ID: <20220426093232.350ed9f4@xps13>
In-Reply-To: <CAMuHMdU6Mb9k_g7yBCknmL9DMjUSzk=W_5wiMNDMsTN6RpkcLg@mail.gmail.com>
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
        <CAMuHMdU6Mb9k_g7yBCknmL9DMjUSzk=W_5wiMNDMsTN6RpkcLg@mail.gmail.com>
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

geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:05:34 +0200:

> Hi Miquel,
>=20
> On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > This is the series bringing DMA support to RZN1 platforms.
> > Other series follow with eg. UART and RTC support as well. =20
>=20
> Thanks for your series!
>=20
> > There is no other conflicting dependency with the other series, so this
> > series can now entirely be merged in the dmaengine tree I believe.
> >
> > Changes in v11:
> > * Renamed two defines.
> > * Changed the way the bitmap is declared.
> > * Updated the cover letter: this series can now go in through the
> >   dmaengine tree. =20
>=20
> /me confused
>=20
> > Miquel Raynal (9):
> >   dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
> >   dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
> >   dt-bindings: dmaengine: Introduce RZN1 DMA compatible
> >   soc: renesas: rzn1-sysc: Export function to set dmamux
> >   dmaengine: dw: dmamux: Introduce RZN1 DMA router support
> >   clk: renesas: r9a06g032: Probe possible children
> >   dmaengine: dw: Add RZN1 compatible
> >   ARM: dts: r9a06g032: Add the two DMA nodes
> >   ARM: dts: r9a06g032: Describe the DMA router =20
>=20
> The last two DTS parts have to go in through the renesas-arm-dt and
> soc trees.

Yes, DT usually never go in through subsystem trees anyway, of
course they should be taken in through the Renesas tree. For the other
patches I think its simpler if everything goes through the dmaengine
tree, but I'm fine either way, I'll let you discuss this with the DMA
folks if you disagree.

Thanks,
Miqu=C3=A8l
