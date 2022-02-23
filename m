Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D294C1902
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbiBWQtm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 11:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243002AbiBWQth (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 11:49:37 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF930E4E;
        Wed, 23 Feb 2022 08:49:07 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 01073FF802;
        Wed, 23 Feb 2022 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645634946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xaUb2CD3MY4isvllCC6mNWacyCjvupia9kHICx3QHGA=;
        b=WMj+HiLMld8KdH1Cakquy9OoT7Ti2J9T9xi2XWITG8ZHQNfPsINGcSL9FrHQMY+NAwrXnM
        3Sv9H2HeZW33EaqfY3cX0Y3BHG9gFwGo6CF5UG0Vfs2BgMdqZjskQOtST2+B003UadILNa
        h1EyCDziYyBkdZizUHnadNtktv/G+U8YgwxxdMX8K1LUzxFdrYY3exn2z1BapUIuUZTFIz
        7cJG2YTlJKqgq1js3tcK3mn/Ip5n356zf6HSWy/cdOB6vha6LS1Cbn3OHkc1FMN3iNQyuK
        CJy1lyy3GopNEZYQkdQclPSksHopspROIfYSVjyNwpzykHJeQlLBfCWTrjIOnw==
Date:   Wed, 23 Feb 2022 17:49:02 +0100
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
Message-ID: <20220223174902.3a9b85ea@xps13>
In-Reply-To: <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
        <20220222103437.194779-5-miquel.raynal@bootlin.com>
        <CAMuHMdWd150q63Nr-=7tn34D3EyiBkAKyuXHm35MM6wci93KZw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

geert@linux-m68k.org wrote on Wed, 23 Feb 2022 13:46:11 +0100:

> Hi Miquel,
>=20
> On Tue, Feb 22, 2022 at 11:35 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> >
> > We need two additional information from the 'dmas' property: the channel
> > (bit in the dmamux register) that must be accessed and the value of the
> > mux for this channel.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/drivers/dma/dw/dmamux.c =20
>=20
> rzn1-dmamux.c?

Ok.

>=20
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 Schneider-Electric
> > + * Author: Miquel Raynal <miquel.raynal@bootlin.com
> > + * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalu=
si@ti.com>
> > + */
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/list.h>
> > +#include <linux/io.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> > +
> > +#define RZN1_DMAMUX_LINES      64 =20
>=20
> Unused. But using it wouldn't hurt, I guess?
>=20
> > +static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_sp=
ec,
> > +                                       struct of_dma *ofdma)
> > +{
> > +       struct platform_device *pdev =3D of_find_device_by_node(ofdma->=
of_node);
> > +       struct rzn1_dmamux_data *dmamux =3D platform_get_drvdata(pdev);
> > +       struct rzn1_dmamux_map *map;
> > +       unsigned int master, chan, val;
> > +       u32 mask;
> > +       int ret;
> > +
> > +       map =3D kzalloc(sizeof(*map), GFP_KERNEL);
> > +       if (!map)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       if (dma_spec->args_count !=3D 6)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       chan =3D dma_spec->args[0];
> > +       map->req_idx =3D dma_spec->args[4];
> > +       val =3D dma_spec->args[5];
> > +       dma_spec->args_count -=3D 2;
> > +
> > +       if (chan >=3D dmamux->dmac_requests) {
> > +               dev_err(&pdev->dev, "Invalid DMA request line: %d\n", c=
han); =20
>=20
> %u
>=20
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       if (map->req_idx >=3D dmamux->dmamux_requests ||
> > +           map->req_idx % dmamux->dmac_requests !=3D chan) { =20
>=20
> The reliance on .dmac_requests (i.e. "dma-requests" in the parent
> DMA controller DT node) looks fragile to me.  Currently there are two
> masters, each providing 16 channels, hence using all 2 x 16 =3D
> 32 bits in the DMAMUX register.
> What if a variant used the same mux, and the same 16/16 split, but
> the parent DMACs don't have all channels available?
> I think it would be safer to hardcode this as 16 (using a #define, ofc).

That's right, I assumed this was safe but indeed it does not work in
all cases. I will change the second condition to:

		map->req_idx % <16> !=3D chan

>=20
> > +               dev_err(&pdev->dev, "Invalid MUX request line: %d\n", m=
ap->req_idx); =20
>=20
> %u
>=20
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       /* The of_node_put() will be done in the core for the node */
> > +       master =3D map->req_idx >=3D dmamux->dmac_requests ? 1 : 0; =20
>=20
> The name "master" confused me: initially I thought it was used as a
> boolean flag, but it really is the index of the parent DMAC.

I personally prefer using true/false for booleans ;) Whatever, the name
is badly chosen I agree, I'll switch to "dmac_idx" which seems more
accurate.

>=20
> > +       dma_spec->np =3D of_parse_phandle(ofdma->of_node, "dma-masters"=
, master);
> > +       if (!dma_spec->np) {
> > +               dev_err(&pdev->dev, "Can't get DMA master\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u reques=
t %u\n",
> > +               map->req_idx, master, chan);
> > +
> > +       mask =3D BIT(map->req_idx);
> > +       mutex_lock(&dmamux->lock);
> > +       dmamux->used_chans |=3D mask;
> > +       ret =3D r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
> > +       mutex_unlock(&dmamux->lock);
> > +       if (ret) {
> > +               rzn1_dmamux_free(&pdev->dev, map);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> > +       return map;
> > +}
> > +
> > +static const struct of_device_id rzn1_dmac_match[] __maybe_unused =3D {
> > +       { .compatible =3D "renesas,rzn1-dma" },
> > +       {},
> > +};
> > +
> > +static int rzn1_dmamux_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *mux_node =3D pdev->dev.of_node;
> > +       const struct of_device_id *match;
> > +       struct device_node *dmac_node;
> > +       struct rzn1_dmamux_data *dmamux;
> > +
> > +       dmamux =3D devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL=
);
> > +       if (!dmamux)
> > +               return -ENOMEM;
> > +
> > +       mutex_init(&dmamux->lock);
> > +
> > +       dmac_node =3D of_parse_phandle(mux_node, "dma-masters", 0);
> > +       if (!dmac_node)
> > +               return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DM=
A master node\n");
> > +
> > +       match =3D of_match_node(rzn1_dmac_match, dmac_node);
> > +       if (!match) {
> > +               of_node_put(dmac_node);
> > +               return dev_err_probe(&pdev->dev, -EINVAL, "DMA master i=
s not supported\n");
> > +       }
> > +
> > +       if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dm=
ac_requests)) {
> > +               of_node_put(dmac_node);
> > +               return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC=
 requests information\n");
> > +       }
> > +
> > +       of_node_put(dmac_node); =20
>=20
> When hardcoding dmac_requests to 16, I guess the whole dmac_node
> handling can be removed?

Not really, I think the following checks are still valid and fortunate,
and they need some of_ handling to work properly:
- verify that the chan requested is within the range of dmac_requests
  in the _route_allocate() callback
- ensure the dmamux is wired to a supported DMAC in the DT (this
  condition might be loosen in the future if needed or dropped entirely
  if considered useless)
- I would like to add a check against the number of requests supported
  by the dmamux and the dmac (not done yet).
For the record, I've taken inspiration to write these lines on the other
dma router driver from TI.

Unless, and I know some people think like that, we do not try to
validate the DT and if the DT is wrong that is none of our business.

>=20
> > +
> > +       if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dma=
mux_requests)) { =20
>=20
> Don't obtain from DT, but fix to 32?

I believe the answer to the previous question should give me a clue
about why you would prefer hardcoding than reading from the DT such
an information. Perhaps I should mention that all these properties are
already part of the bindings, and are not specific to the driver, the
information will be in the DT anyway.

Thanks,
Miqu=C3=A8l
