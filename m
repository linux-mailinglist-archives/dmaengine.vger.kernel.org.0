Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD44C5BE2
	for <lists+dmaengine@lfdr.de>; Sun, 27 Feb 2022 15:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiB0OJ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Feb 2022 09:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiB0OJ7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Feb 2022 09:09:59 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179063A19C;
        Sun, 27 Feb 2022 06:09:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F00EB240002;
        Sun, 27 Feb 2022 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645970957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yqwbpyEfeZqCICFZlrGuTav01fic0WcbFUBWtOFHXU=;
        b=oKpg4XtmYF/rBm3kv52LWXCiGC1apIakuu2yLEpncZqHPaoNfHDSE57tc1TYTsaP3Fe0bX
        n37oIKqrnR+MbnTke72oMNAO6O5MSMXvXi0gZWn529c5zPSaRXpPbAkOU6gVCGu+EEf0tl
        /U/A7owcCXEqpUot/Ky3afa/dXImv9N0W/IZtdqoMZHuFKc/jT5qOtf6PFWsXIIZlzoKar
        SGjkJM79xhatvX/RoSQeIcAC3MfgOtYnPOJtdciQfdt++cc51+XsmFbYfoQn7pDMKZ1+vZ
        M3zbMdO1eNIN+bSTIm8ZFk9qKg3SJvwgjAHPfy+PYYy7P6lo6iQ+wBBVcDPt6w==
Date:   Sun, 27 Feb 2022 15:09:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <20220227150913.5b998b2f@xps13>
In-Reply-To: <Yhkg06bqnU8bpaxe@robh.at.kernel.org>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
        <20220218181226.431098-4-miquel.raynal@bootlin.com>
        <Yhkg06bqnU8bpaxe@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Fri, 25 Feb 2022 12:32:51 -0600:

> On Fri, Feb 18, 2022 at 07:12:21PM +0100, Miquel Raynal wrote:
> > The dmamux register is located within the system controller.
> >=20
> > Without syscon, we need an extra helper in order to give write access to
> > this register to a dmamux driver.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/clk/renesas/r9a06g032-clocks.c        | 27 +++++++++++++++++++
> >  include/dt-bindings/clock/r9a06g032-sysctrl.h |  2 ++
> >  include/linux/soc/renesas/r9a06g032-syscon.h  | 11 ++++++++
> >  3 files changed, 40 insertions(+)
> >  create mode 100644 include/linux/soc/renesas/r9a06g032-syscon.h =20
>=20
> > diff --git a/include/dt-bindings/clock/r9a06g032-sysctrl.h b/include/dt=
-bindings/clock/r9a06g032-sysctrl.h
> > index 90c0f3dc1ba1..609e7fe8fcb1 100644
> > --- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
> > +++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
> > @@ -145,4 +145,6 @@
> >  #define R9A06G032_CLK_UART6		152
> >  #define R9A06G032_CLK_UART7		153
> > =20
> > +#define R9A06G032_SYSCON_DMAMUX		0xA0 =20
>=20
> That looks like a register offset? We generally don't put register=20
> offsets in DT.

This is a leftover, the offset is defined somewhere else now, I will
fix this.

>=20
> > +
> >  #endif /* __DT_BINDINGS_R9A06G032_SYSCTRL_H__ */ =20


Thanks,
Miqu=C3=A8l
