Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1574C2808
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 10:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiBXJ2C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 04:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiBXJ2B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 04:28:01 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08125F11A7;
        Thu, 24 Feb 2022 01:27:29 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 879A1FF805;
        Thu, 24 Feb 2022 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645694848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLJ/bcLItCv9HjSRiDqArmyxNKrFb+RrjF79qRknBBY=;
        b=dQhyx59jLotHyUcmVYOrndZCuFPzEuiNVjUTMbwCQxa2NhF40NpfOT/DNqNtXbAEy7B31A
        /TanbRcuOWhA8hSvLYp0yhw0qV0oCq6Uu51UojcCpDbjeBhxpHNqfH8X8+SV2NpAbc/9mp
        qb5SEme/Js9C8rzNOCaqT9CZpSqkmhGg+S0r0t8Np8vNJN3r5PqwY883FpJZgeL37z8eQH
        jPPTD0w4MgqOfAi+lWBv1XE2C9Jdry9e4050AGohJF/pmGojTX6MJObNI+EGCsfokxujsR
        JX2tQ7Q7JXrq+R5IX5Ra3lgmUkgsANvRdn/5YmRCS0m6ILhLGj0VS4k+yUqkOA==
Date:   Thu, 24 Feb 2022 10:27:24 +0100
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
Subject: Re: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <20220224102724.74e2c406@xps13>
In-Reply-To: <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-5-miquel.raynal@bootlin.com>
        <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
        <20220223174902.3a9b85ea@xps13>
        <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
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

geert@linux-m68k.org wrote on Thu, 24 Feb 2022 10:14:48 +0100:

> Hi Miquel,
>=20
> On Wed, Feb 23, 2022 at 5:49 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:46:11 +0100: =20
> > > On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote: =20
> > > > The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additi=
onal
> > > > dmamux register located in the system control area which can take u=
p to
> > > > 32 requests (16 per DMA controller). Each DMA channel can be wired =
to
> > > > two different peripherals.
> > > >
> > > > We need two additional information from the 'dmas' property: the ch=
annel
> > > > (bit in the dmamux register) that must be accessed and the value of=
 the
> > > > mux for this channel.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> > >
> > > Thanks for your patch!
> > > =20
> > > > --- /dev/null
> > > > +++ b/drivers/dma/dw/dmamux.c =20
>=20
> > > > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct device_node *mux_node =3D pdev->dev.of_node;
> > > > +       const struct of_device_id *match;
> > > > +       struct device_node *dmac_node;
> > > > +       struct rzn1_dmamux_data *dmamux;
> > > > +
> > > > +       dmamux =3D devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KE=
RNEL);
> > > > +       if (!dmamux)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       mutex_init(&dmamux->lock);
> > > > +
> > > > +       dmac_node =3D of_parse_phandle(mux_node, "dma-masters", 0);
> > > > +       if (!dmac_node)
> > > > +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't ge=
t DMA master node\n");
> > > > +
> > > > +       match =3D of_match_node(rzn1_dmac_match, dmac_node);
> > > > +       if (!match) {
> > > > +               of_node_put(dmac_node);
> > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA mast=
er is not supported\n");
> > > > +       }
> > > > +
> > > > +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux=
->dmac_requests)) {
> > > > +               of_node_put(dmac_node);
> > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing =
DMAC requests information\n");
> > > > +       }
> > > > +
> > > > +       of_node_put(dmac_node); =20
> > >
> > > When hardcoding dmac_requests to 16, I guess the whole dmac_node
> > > handling can be removed? =20
> >
> > Not really, I think the following checks are still valid and fortunate,
> > and they need some of_ handling to work properly:
> > - verify that the chan requested is within the range of dmac_requests
> >   in the _route_allocate() callback
> > - ensure the dmamux is wired to a supported DMAC in the DT (this
> >   condition might be loosen in the future if needed or dropped entirely
> >   if considered useless)
> > - I would like to add a check against the number of requests supported
> >   by the dmamux and the dmac (not done yet).
> > For the record, I've taken inspiration to write these lines on the other
> > dma router driver from TI.
> >
> > Unless, and I know some people think like that, we do not try to
> > validate the DT and if the DT is wrong that is none of our business.
> > =20
> > > =20
> > > > +
> > > > +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux-=
>dmamux_requests)) { =20
> > >
> > > Don't obtain from DT, but fix to 32? =20
> >
> > I believe the answer to the previous question should give me a clue
> > about why you would prefer hardcoding than reading from the DT such
> > an information. Perhaps I should mention that all these properties are
> > already part of the bindings, and are not specific to the driver, the
> > information will be in the DT anyway. =20
>=20
> The 32 is a property of the hardware (32 bits in DMAMUX register).
> So IMHO it falls under the "differentiate by compatible value,
> not by property" rule.

I agree this is a property of the hardware and feels redundant here.

What about the checks below, do you agree with the fact that I should
keep them or do you prefer dropping them (all? partially?)?


Thanks,
Miqu=C3=A8l
