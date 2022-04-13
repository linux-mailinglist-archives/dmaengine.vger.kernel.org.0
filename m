Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF94FF128
	for <lists+dmaengine@lfdr.de>; Wed, 13 Apr 2022 10:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiDMIDd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Apr 2022 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiDMICy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Apr 2022 04:02:54 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9461E3C8;
        Wed, 13 Apr 2022 01:00:32 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 75ED01C0014;
        Wed, 13 Apr 2022 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649836831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqBnj4E/IArS778TbFuQ/LXdhPkqCVHeLCS/sR1tXo8=;
        b=bG4D7mAptj9IoSxJDX73pRGt2qJyJ6MhlJzmHqx4amX7xWZJm1qu7Sqa9uAf5BjVmOQ+n1
        eQOk+Z5lAp9DL/AqgxiHaxckOcuNH6ZoVXUJKlMSD9bvvVeEGZE3AZkRbXEseZJ6DD6JhC
        IXlPYM/hmzpPEiTfbLAtLYIMIvTDgpGl7N0gi0h0pimcZ8JL4M3lvPIxtkZh4CMXcvcZlv
        nHQv0fqfW3xApEpSvRalk9lOx4oKbdsMPxbqJPWVjW1TYDf+FUM36obalcd06t496V77C6
        k7wU9AuGnbCamtYJ3IGPqxQmZ+QnkmKIVpzhsQirtKrej+Bisik8tovOyua9iA==
Date:   Wed, 13 Apr 2022 10:00:26 +0200
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
Subject: Re: [PATCH v10 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA
 router support
Message-ID: <20220413100026.73e11004@xps13>
In-Reply-To: <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
        <20220412193936.63355-6-miquel.raynal@bootlin.com>
        <CAMuHMdV_KWuDRWtNaL2n8+1y4GbOSSosesd3RPK60i6zYkQPDA@mail.gmail.com>
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

geert@linux-m68k.org wrote on Wed, 13 Apr 2022 09:53:09 +0200:

> Hi Miquel,
>=20
> On Tue, Apr 12, 2022 at 9:39 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
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
> > +++ b/drivers/dma/dw/rzn1-dmamux.c
> > @@ -0,0 +1,160 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 Schneider-Electric
> > + * Author: Miquel Raynal <miquel.raynal@bootlin.com
> > + * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalu=
si@ti.com>
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/slab.h>
> > +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> > +#include <linux/types.h>
> > +
> > +#define RNZ1_DMAMUX_NCELLS 6
> > +#define RZN1_DMAMUX_LINES 64
> > +#define RZN1_DMAMUX_MAX_LINES 16
> > +
> > +struct rzn1_dmamux_data {
> > +       struct dma_router dmarouter;
> > +       unsigned long *used_chans; =20
>=20
> Why a pointer?
>=20
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
> > +       dmamux->used_chans =3D devm_bitmap_zalloc(&pdev->dev, 2 * RZN1_=
DMAMUX_MAX_LINES,
> > +                                               GFP_KERNEL); =20
>=20
> ... Oh, you want to allocate the bitmap separately, although you
> know it's just a single long.
>=20
> You might as well declare it in rzn1_dmamux_data as:
>=20
>     unsigned long used_chans[BITS_TO_LONGS(2 * RZN1_DMAMUX_MAX_LINES)];

I've done that in versions v1..v8 and it was explicitly requested by
Ilpo that I used something more specific like a bitmap (or an idr, but
I don't think it fits well here). So now I'm using a bitmap...

Thanks,
Miqu=C3=A8l
