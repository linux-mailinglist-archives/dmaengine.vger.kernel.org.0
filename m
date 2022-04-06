Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8984F5D96
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiDFMIG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiDFMHy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 08:07:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790521D2;
        Wed,  6 Apr 2022 00:49:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BCE68FF816;
        Wed,  6 Apr 2022 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649231352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+Um5lcXyFGsJu7XXClC2r25jtPHetLl/vRWs5TLU7A=;
        b=XSa7K7eEsA5vD799sP0Ueq8b6b5wG8u6GscKYgcCywD8uL8GnDaldmyJXkVO0jBYOcn7IW
        UNaJQ1SemC4STYvW0xE7pd9MkT3hvZZOppJFktp3e0gVJKHsU3q/iHNQ+neyvxLA39k1e0
        SjDXQFfJ0pU4VSl06zfCU7Nq9ErvGPplK+aUOIV6m2mJsZRQ551KJWt16gxM9Imoj8bcFg
        fOYbRq7DxdYlKoTd4/g+XJfvYhuicyG7jSrQ+yU0xHLJAdCtYC89gsw5oK/r2ZNu9EvEDf
        F+JXuMliiZ9mTKPEJujJMNA0Z0sUfShVcxW9e9hDUto+wmCe04esaEU431j5TQ==
Date:   Wed, 6 Apr 2022 09:49:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
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
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v7 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <20220406094908.48ecc4bb@xps13>
In-Reply-To: <YkxXUdMA75b8keSd@smile.fi.intel.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
        <20220405081911.1349563-6-miquel.raynal@bootlin.com>
        <YkxXUdMA75b8keSd@smile.fi.intel.com>
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

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Tue, 5 Apr 2022 17:50:57
+0300:

> On Tue, Apr 05, 2022 at 10:19:07AM +0200, Miquel Raynal wrote:
> > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> >=20
> > We need two additional information from the 'dmas' property: the channel
> > (bit in the dmamux register) that must be accessed and the value of the
> > mux for this channel. =20
>=20
> ...
>=20
> >  dw_dmac-y			:=3D platform.o
> >  dw_dmac-$(CONFIG_OF)		+=3D of.o =20
>=20
> > +obj-$(CONFIG_RZN1_DMAMUX)	+=3D rzn1-dmamux.o =20
>=20
> I would move it down in the file to distinguish more generic drivers
> from specific quirks.

Ok.

>=20
> >  obj-$(CONFIG_DW_DMAC_PCI)	+=3D dw_dmac_pci.o
> >  dw_dmac_pci-y			:=3D pci.o =20
>=20
> ...
>=20
> > +#define RZN1_DMAMUX_SPLIT 16 =20
>=20
> I would name it more explicitly:
>=20
> #define RZN1_DMAMUX_SPLIT_1_0	 16

I am sorry but I don't understand this suffix, which probably means
that it is not as clear as we wish. Do you mind if I stick to
RZN1_DMAMUX_SPLIT?

> ...
>=20
> > +	dmac_idx =3D map->req_idx < RZN1_DMAMUX_SPLIT ? 0 : 1; =20
>=20
> ...and hence use positive conditional:
>=20
> 	dmac_idx =3D map->req_idx >=3D RZN1_DMAMUX_SPLIT_1_0 ? 1 : 0;

I will.

>=20
> With above addressed
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20


Thanks,
Miqu=C3=A8l
