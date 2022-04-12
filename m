Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910C4FDE12
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 13:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiDLLgr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbiDLLe1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 07:34:27 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A305675E40;
        Tue, 12 Apr 2022 03:12:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9B51560005;
        Tue, 12 Apr 2022 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649758357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7W7OOcrrKTOVlol+0rT6FrGel11SznXB9OxT0OrvmLY=;
        b=S2dApP1cK3k2G5XFtr78njfdto9xIO1n4H6AI1VnDvhqeLMLzlqyysr8YuJZBjltlubKXE
        4pDruN07AolH2TsJxGRx5JM3O1puZ/wswQjWt9tWdjrRBikvKl5MpkkvXIldO4zuCOOi3l
        +c/5p5DRpGxsB0U2wI7P7gqyDTssQO7xIHfN1xeChU/onWKYxlrAcwGAFvmmfh1629PDmg
        3WeVSA3GIkqeLuZZT6ag91ezPm5Zqo4QOGbXOJ4XS2JDjQwb9/MYAKYDbjhDsGUwjIG3OR
        eZw/ieqZ9RI5/2hiTJXMp+y4H2Sgw/Y7m6ZNBJ3kQ+HlpTaoSWXm6e36sP6cbA==
Date:   Tue, 12 Apr 2022 12:12:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <20220412121232.69c85b20@xps13>
In-Reply-To: <YlQQBIeM0GZQ6UOE@matsya>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
        <20220406161856.1669069-6-miquel.raynal@bootlin.com>
        <YlQQBIeM0GZQ6UOE@matsya>
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

Hi Vinod,


> > +static void rzn1_dmamux_free(struct device *dev, void *route_data)
> > +{
> > +	struct rzn1_dmamux_data *dmamux =3D dev_get_drvdata(dev);
> > +	struct rzn1_dmamux_map *map =3D route_data;
> > +
> > +	dev_dbg(dev, "Unmapping DMAMUX request %u\n", map->req_idx);
> > +
> > +	mutex_lock(&dmamux->lock);
> > +	dmamux->used_chans &=3D ~BIT(map->req_idx);
> > +	mutex_unlock(&dmamux->lock); =20
>=20
> Why not use idr or bitmap for this. Hint: former does locking as well

I've changed the code to use a proper bitmap.

>=20
> > +
> > +	kfree(map);
> > +}
> > +
> > +static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_sp=
ec,
> > +					struct of_dma *ofdma)
> > +{
> > +	struct platform_device *pdev =3D of_find_device_by_node(ofdma->of_nod=
e);
> > +	struct rzn1_dmamux_data *dmamux =3D platform_get_drvdata(pdev);
> > +	struct rzn1_dmamux_map *map;
> > +	unsigned int dmac_idx, chan, val;
> > +	u32 mask;
> > +	int ret;
> > +
> > +	if (dma_spec->args_count !=3D 6) =20
>=20
> magic

Defined.

>=20
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	map =3D kzalloc(sizeof(*map), GFP_KERNEL);
> > +	if (!map)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	chan =3D dma_spec->args[0];
> > +	map->req_idx =3D dma_spec->args[4];
> > +	val =3D dma_spec->args[5];
> > +	dma_spec->args_count -=3D 2;
> > +

[...]

> > +	dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n=
",
> > +		map->req_idx, dmac_idx, chan);
> > +
> > +	mask =3D BIT(map->req_idx);
> > +	mutex_lock(&dmamux->lock);
> > +	dmamux->used_chans |=3D mask;
> > +	ret =3D r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0); =20
>=20
> I guess due to this it would be merged by whosoever merges this api.
> Please mention this in cover letter and how you propose this should be
> merged

Yes, the cover letter mentions this issue, but since then Geert
proposed to take everything through the renesas trees, which I agree
with. I will send a v9 and if you agree with it please provide your Ack
so that Geert can take it.

Thanks,
Miqu=C3=A8l
