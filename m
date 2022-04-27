Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFC5113C4
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358818AbiD0Iwp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbiD0Iwp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 04:52:45 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2619ADB9;
        Wed, 27 Apr 2022 01:49:31 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CA1571C000E;
        Wed, 27 Apr 2022 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651049370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrKuvPRFGTpXImUQtTwUc5H6AI8mSMbZRABTAhNaqFw=;
        b=e+I2mTbKdT9VesCwy7NkduOQ4XWUHgZ8Nan02rnmmptW4sTewDOUAuL+ut6g5o8X5AhJ+n
        oGOEy6wBz7vqPs70U/FSv+0bOmRSKjp/njE0LIoh7o8h3N2t4u0lYjQj4LmBmD6Gp3ZJjZ
        D38KZgctkoa/mJUj3Dc9jc8IBQwOG1ZY8ZRyMY3DMzJFG6L7e8IN1ognYZhKwQ/OShOxlq
        DF9shRzIw1JrA0RJSq4ybQv64ngYIh5EYpRf8zzyk1EZnFkjWjopcLq6LoWMPCcGpj6mHs
        StI4eYC96SHUMYr0LRDVYL9+I7KwzYdLTF3m7LW81kDsxGOPfT7qCwDmbsNQag==
Date:   Wed, 27 Apr 2022 10:49:25 +0200
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
Subject: Re: [PATCH v11 2/9] dt-bindings: clock: r9a06g032-sysctrl:
 Reference the DMAMUX subnode
Message-ID: <20220427104925.44c143f7@xps13>
In-Reply-To: <CAMuHMdWgLhhc3po6EqSnKQrtKW4v+cDcT+iDg_i_KP0iL-XF3Q@mail.gmail.com>
References: <20220421085112.78858-1-miquel.raynal@bootlin.com>
        <20220421085112.78858-3-miquel.raynal@bootlin.com>
        <CAMuHMdWgLhhc3po6EqSnKQrtKW4v+cDcT+iDg_i_KP0iL-XF3Q@mail.gmail.com>
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

geert@linux-m68k.org wrote on Mon, 25 Apr 2022 18:08:19 +0200:

> On Thu, Apr 21, 2022 at 10:51 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > This system controller contains several registers that have nothing to
> > do with the clock handling, like the DMA mux register. Describe this
> > part of the system controller as a subnode.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Stephen Boyd <sboyd@kernel.org> =20
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for all the feedback received so far!

> > --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl=
.yaml
> > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl=
.yaml
> > @@ -39,6 +39,17 @@ properties:
> >    '#power-domain-cells':
> >      const: 0
> >
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +patternProperties:
> > +  "^dma-router@[a-f0-9]+$": =20
>=20
> For now this must be @a0, right?

Yes!

Cheers,
Miqu=C3=A8l
