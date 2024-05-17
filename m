Return-Path: <dmaengine+bounces-2067-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B388C8CFD
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C101C21C5B
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FABC140364;
	Fri, 17 May 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QSFXmsaV"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EFA13DDB0;
	Fri, 17 May 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975470; cv=none; b=kNKU4SyNvraNyI9rWAZI3Kx+TDKXdIMHdvbULlX7jCin1oi41bXzLUPijjcCq8ojzgnE9Bxly+4okjkFqfNOvwTrGT9Yb/wdPQT/k4onuJuGc+eUgqchOQQpsoUOQ/An/p1qP7hy31wdu5K6S4AjK2K/WbGmewxqrCQdsylwzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975470; c=relaxed/simple;
	bh=rmu3HQK5IMzJ2YBCSpWscJn3wukuD4WnaUXI3S2kyBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XStkM8y0T+31tUbOKNOpar8jbhKrTO5To0ySBdFBus5sth2pc5We/Zpythq+Hx0VoKAvsu81y9LRfaBgX0XXq8mr+NhEnY1iQ7iz20UWkBijQ/qh/ztev9+oSIl+KOtF+fBkRGP1eK0RQJFkyZ1RIff3a3wzNZLMVyGveHoKzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QSFXmsaV; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8C7BFF803;
	Fri, 17 May 2024 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715975460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlP3PK23BxpttVUOU8FsAkJILKdtrU2gUyyrnf+ZS/Y=;
	b=QSFXmsaVERvB0isdMhxp1MzMnwr57OGNI00otZAQqzk95G1OG2DZXWOPdxN3iFj524NAss
	PXlV5t5b1+oiUzmJTq+BbMwM3+EsiR+tROgxM/A85pJVIktMj6XBepj31fJYqWcd2fw1fk
	3T2W9KCMu2URjBIkukDhMOtRrz/LWNCieQpkMlXZ0oTMe2TM7O0sdj/fXSMI7BsAJIC0wc
	oZE5/se95lpTcSDRUquO51JS4p18WZtgv8+8r60jO44Th8gL275xumbrT1DOz+xuR/4u4Y
	8+r9w/HXGdBDYX8i9YVRvSNRj+HcAvO23OIxBRg/UFkmLwSxJ+Ef1O/vfn8BnA==
Date: Fri, 17 May 2024 21:50:55 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Han Xu
 <han.xu@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Message-ID: <20240517215055.02622324@xps-13>
In-Reply-To: <Zkes3n6ZLjIFFQUK@lizhi-Precision-Tower-5810>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
	<20240517-gpmi_nand-v1-1-73bb8d2cd441@nxp.com>
	<20240517203621.72b8b9c7@xps-13>
	<Zkes3n6ZLjIFFQUK@lizhi-Precision-Tower-5810>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.li@nxp.com wrote on Fri, 17 May 2024 15:15:42 -0400:

> On Fri, May 17, 2024 at 08:36:21PM +0200, Miquel Raynal wrote:
> > Hi Frank,
> >=20
> > Frank.Li@nxp.com wrote on Fri, 17 May 2024 14:09:48 -0400:
> >  =20
> > > Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restric=
tion.
> > >=20
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++=
++++++++++
> > >  1 file changed, 22 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/D=
ocumentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > > index 021c0da0b072f..f9eb1868ca1f4 100644
> > > --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > > @@ -24,6 +24,7 @@ properties:
> > >            - fsl,imx6q-gpmi-nand
> > >            - fsl,imx6sx-gpmi-nand
> > >            - fsl,imx7d-gpmi-nand
> > > +          - fsl,imx8qxp-gpmi-nand
> > >        - items:
> > >            - enum:
> > >                - fsl,imx8mm-gpmi-nand
> > > @@ -151,6 +152,27 @@ allOf:
> > >              - const: gpmi_io
> > >              - const: gpmi_bch_apb
> > > =20
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8qxp-gpmi-nand
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: SoC gpmi io clock
> > > +            - description: SoC gpmi apb clock =20
> >=20
> > I believe these two clocks are mandatory? =20
>=20
> minItems default is equal to items numbers, here is 4. So all 4 clock are
> mandatory.
>=20
> Anything wrong here?

I'd say that the two "bch" clocks are only used if you decide to
configure the on-host hardware ECC engine and thus are not needed with
software corrections, but I'm fine keeping the fourth described in all
cases if that's simpler.

Also,here the diff just shows that "if we provide a clocks property
with this compatible, then we need to provide 4 members", I believe the
"required" property is already filled somewhere with the
clocks/clock-names properties?

Thanks,
Miqu=C3=A8l

