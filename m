Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA24BE5DA
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378887AbiBUPNv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 10:13:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBUPNu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 10:13:50 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FBF1AF36;
        Mon, 21 Feb 2022 07:13:26 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A610F20012;
        Mon, 21 Feb 2022 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645456405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKFS4/sethbJ2kNW1esnhR8XeR5VMqXvnzHjinf+IRg=;
        b=Q/9fdmF42lA4IkUPPaC91Ab+Vnkt+RiFmzxTjFtPC8atPNV5PRNkCu9zVjzxY2Q1jldI4g
        PiTiifPDM6odmYxFUkNJn6kkIQvMOItoSVGGfJeCKciw5o7rJjETGmt929GS9icII8GWzu
        zq26M2udbYnD2kbe7y6tcYAGwlQz2wFGO0YUC+g8T0FNrkmCWthZcOgTFP7hCvXMFAUFFW
        eLXAu0BBVW88p4A0Kk19J41MMpxM9Nqqpn4B1jPcj0y283u+6CEDDjIGpIlxYhF2m/QZMm
        VqA0skLev7CZz0ceqPOK83iZpM4bi/q0KnWY9p/WZVokLo/OO1NDLAF2emYAwg==
Date:   Mon, 21 Feb 2022 16:13:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>
Subject: Re: [PATCH 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <20220221161320.449b2d4d@xps13>
In-Reply-To: <YhIeQlwmt/yCc8Uu@smile.fi.intel.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
        <20220218181226.431098-5-miquel.raynal@bootlin.com>
        <YhIeQlwmt/yCc8Uu@smile.fi.intel.com>
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

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Sun, 20 Feb 2022 12:56:02
+0200:

> On Fri, Feb 18, 2022 at 07:12:22PM +0100, Miquel Raynal wrote:
> > The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> >=20
> > We need two additional information from the 'dmas' property: the channel
> > (bit in the dmamux register) that must be accessed and the value of the
> > mux for this channel. =20
>=20
> ...

Thanks for the review!

>=20
> > +dw_dmac-y			:=3D platform.o dmamux.o =20
>=20
> We do not need this on other platforms, please make sure we have no dangl=
ing
> code on, e.g., x86.
>=20
> ...
>=20
> > +	/* The of_node_put() will be done in the core for the node */
> > +	master =3D map->req_idx < dmamux->dmac_requests ? 0 : 1; =20
>=20
> The opposite conditional will be better, no?`

I guess this is a matter of taste. I prefer the current writing but I
will change it.

>=20
> ...
>=20
> > +	dmamux->used_chans |=3D BIT(map->req_idx);
> > +	ret =3D r9a06g032_syscon_set_dmamux(BIT(map->req_idx),
> > +					  val ? BIT(map->req_idx) : 0); =20
>=20
>=20
> Cleaner to do
>=20
> 	u32 mask =3D BIT(...);
> 	...
>=20
> 	dmamux->used_chans |=3D mask;
> 	ret =3D r9a06g032_syscon_set_dmamux(mask, val ? mask : 0);

Fine.

>=20
> ...
>=20
> > +static const struct of_device_id rzn1_dmac_match[] __maybe_unused =3D {
> > +	{ .compatible =3D "renesas,rzn1-dma", },
> > +	{}, =20
>=20
> No comma for terminator entry.

Mmh, ok.

>=20
> > +}; =20
>=20
> ...
>=20
> > +	if (!node)
> > +		return -ENODEV; =20
>=20
> Dup check, why not to simply try for phandle first?

I'll drop it.

>=20
> ...
>=20
> > +	if (of_property_read_u32(dmac_node, "dma-requests",
> > +				 &dmamux->dmac_requests)) { =20
>=20
> One line?

Ok.

>=20
> > +		dev_err(&pdev->dev, "Missing DMAC requests information\n");
> > +		of_node_put(dmac_node);
> > +		return -EINVAL; =20
>=20
> First put node, then simply use dev_err_probe().

I don't get the point here. dev_err_probe() is useful when -EPROBE_DEFER
can be returned, right? I don't understand what it would bring here nor
how I should use it to simplify error handling.

>=20
> > +	} =20
>=20
> ...
>=20
> > +static const struct of_device_id rzn1_dmamux_match[] =3D {
> > +	{ .compatible =3D "renesas,rzn1-dmamux", },
> > +	{}, =20
>=20
> No comma.

Ok.

>=20
> > +}; =20
>=20


Thanks,
Miqu=C3=A8l
