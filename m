Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312A4C3095
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiBXP5y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 10:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiBXP5s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 10:57:48 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36CC5D644;
        Thu, 24 Feb 2022 07:56:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 91C0810002F;
        Thu, 24 Feb 2022 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645718203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVC5Hb4g25SCLSnlfjVTXAofrx2zK62/e4HH3XRyFUU=;
        b=XeJrFZ1RfxTMcI1LQPhCWXMip6cK1NcwY/MisfO8S/sBqEZTmJa/Nbi+dU5/0msLDud1mO
        s0oXA+P3JHPPXiVGONryyVE4OHX3aa1nsMa/M/qP/1RGJAHX5yQum3wJW2hpEBU/UXFWeO
        OtSMX17UKgUfm5SOcy5ClxrNROZRn4PmD/nste9O5M6eA/baGpaBhZe7d5WcoeP/4xVSQc
        g6YdDfoiZ/gGS6ZOmY1Qycw90v3jd+yDCVV+DPGTQ1gu+KuPocW1x9ofbDY29UKIIyMzu+
        i5eiMbCHTD4DFycnLo+16zTMMDzWQj8tk5dAohUG+7EOKg6CQbFw7zBNidL1BA==
Date:   Thu, 24 Feb 2022 16:56:40 +0100
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
Message-ID: <20220224165640.321d7c56@xps13>
In-Reply-To: <CAMuHMdWofNo5aCZscADc_LuQjzDb7YoQhZS736d7_hrswdY5DA@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-5-miquel.raynal@bootlin.com>
        <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
        <20220223174902.3a9b85ea@xps13>
        <CAMuHMdVr4tiicEn-BbBnCd-zP6ncr=zKd-eDvPYoYKNWUKsOBw@mail.gmail.com>
        <20220224102724.74e2c406@xps13>
        <CAMuHMdWtx5jnyZ0vhCVvM=nTv9H4tD7+g0YTWX8MALc_hR5x4g@mail.gmail.com>
        <20220224123620.02740e8c@xps13>
        <CAMuHMdWofNo5aCZscADc_LuQjzDb7YoQhZS736d7_hrswdY5DA@mail.gmail.com>
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

geert@linux-m68k.org wrote on Thu, 24 Feb 2022 13:16:09 +0100:

> Hi Miquel,
>=20
> On Thu, Feb 24, 2022 at 12:36 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > > > > > > > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > > > > > > > +{
> > > > > > > > +       struct device_node *mux_node =3D pdev->dev.of_node;
> > > > > > > > +       const struct of_device_id *match;
> > > > > > > > +       struct device_node *dmac_node;
> > > > > > > > +       struct rzn1_dmamux_data *dmamux;
> > > > > > > > +
> > > > > > > > +       dmamux =3D devm_kzalloc(&pdev->dev, sizeof(*dmamux)=
, GFP_KERNEL);
> > > > > > > > +       if (!dmamux)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +
> > > > > > > > +       mutex_init(&dmamux->lock);
> > > > > > > > +
> > > > > > > > +       dmac_node =3D of_parse_phandle(mux_node, "dma-maste=
rs", 0);
> > > > > > > > +       if (!dmac_node)
> > > > > > > > +               return dev_err_probe(&pdev->dev, -ENODEV, "=
Can't get DMA master node\n");
> > > > > > > > +
> > > > > > > > +       match =3D of_match_node(rzn1_dmac_match, dmac_node);
> > > > > > > > +       if (!match) {
> > > > > > > > +               of_node_put(dmac_node);
> > > > > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "=
DMA master is not supported\n");
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       if (of_property_read_u32(dmac_node, "dma-requests",=
 &dmamux->dmac_requests)) {
> > > > > > > > +               of_node_put(dmac_node);
> > > > > > > > +               return dev_err_probe(&pdev->dev, -EINVAL, "=
Missing DMAC requests information\n");
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       of_node_put(dmac_node); =20
> > > > > > >
> > > > > > > When hardcoding dmac_requests to 16, I guess the whole dmac_n=
ode
> > > > > > > handling can be removed? =20
> > > > > >
> > > > > > Not really, I think the following checks are still valid and fo=
rtunate,
> > > > > > and they need some of_ handling to work properly:
> > > > > > - verify that the chan requested is within the range of dmac_re=
quests
> > > > > >   in the _route_allocate() callback
> > > > > > - ensure the dmamux is wired to a supported DMAC in the DT (this
> > > > > >   condition might be loosen in the future if needed or dropped =
entirely
> > > > > >   if considered useless)
> > > > > > - I would like to add a check against the number of requests su=
pported
> > > > > >   by the dmamux and the dmac (not done yet).
> > > > > > For the record, I've taken inspiration to write these lines on =
the other
> > > > > > dma router driver from TI. =20
> >
> >         ^^^^^^^^^^^
> > ... these checks =20
>=20
> I don't know. Some of them will be checked when calling into the
> parent DMAC, right?

Only the first item above will be validated by the DMAC driver. But I
prefer to error out sooner than later, because getting the mux in
place while knowing that the request is invalid sounds silly.

Thanks,
Miqu=C3=A8l
