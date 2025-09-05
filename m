Return-Path: <dmaengine+bounces-6403-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E25B45C9C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79938565F24
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169431C5D55;
	Fri,  5 Sep 2025 15:30:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804145038
	for <dmaengine@vger.kernel.org>; Fri,  5 Sep 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086252; cv=none; b=OJl+wNgQkQBEUu3K+Z32SQ5zsOjGhUuA292itDHORNZ83OCx7qqPjOoPyDWVnMxlSTrdj2cv6Mo7FfOtpSd+jP5v+of0rVwhaQoZkhEJ1wE+FUDx4IXKBJMKYrvATKCOsI2IlPZiE2z49JJI5KUQ2OHT942BqzUFxCH6RiKPa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086252; c=relaxed/simple;
	bh=A4ic6ODTiBaDKNa1fC8D4vrvVB1rgld9zJXBeUf4mwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRPXJjQNom53X9OR/8y0yVKrzMt2WtPEQxY5aHOjc7O8g3LkcTMzccp0X5aKjUNIJydTCz0/BLUXmMkW3xWPuuHzjH3STWgzB89uOLAfmkGtiPP2dxLc97BUWbDxCU4CMHde+P0i1K+OUBIsMMeIxXGJs0KAC7M8m9Q6mWSM8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uuYOX-0004lC-50; Fri, 05 Sep 2025 17:30:33 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uuYOV-004OU7-34;
	Fri, 05 Sep 2025 17:30:31 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uuYOV-000YZb-2n;
	Fri, 05 Sep 2025 17:30:31 +0200
Message-ID: <7b610a06e17e1c816a0a760bb661dbfd20ec44f4.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] dmaengine: sh: rz-dmac: Use
 devm_add_action_or_reset()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
 biju.das.jz@bp.renesas.com, Vinod Koul <vkoul@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>,  Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@baylibre.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 05 Sep 2025 17:30:31 +0200
In-Reply-To: <aLsATdoqct8JfgYz@tom-desktop>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
	 <20250905144427.1840684-3-tommaso.merciai.xr@bp.renesas.com>
	 <1b2d2410dd9c300da1ffe015ed4835208416798b.camel@pengutronix.de>
	 <aLsATdoqct8JfgYz@tom-desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

On Fr, 2025-09-05 at 17:22 +0200, Tommaso Merciai wrote:
> Hi Philipp,
> Thank you for your review!
>=20
> On Fri, Sep 05, 2025 at 04:53:54PM +0200, Philipp Zabel wrote:
> > On Fr, 2025-09-05 at 16:44 +0200, Tommaso Merciai wrote:
> > > Slightly simplify rz_dmac_probe() by using devm_add_action_or_reset()
> > > for reset cleanup.
> > >=20
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > ---
> > >  drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> > > index 0b526cc4d24be..0bc11a6038383 100644
> > > --- a/drivers/dma/sh/rz-dmac.c
> > > +++ b/drivers/dma/sh/rz-dmac.c
> > > @@ -905,6 +905,11 @@ static int rz_dmac_parse_of(struct device *dev, =
struct rz_dmac *dmac)
> > >  	return rz_dmac_parse_of_icu(dev, dmac);
> > >  }
> > > =20
> > > +static void rz_dmac_reset_control_assert(void *data)
> > > +{
> > > +	reset_control_assert(data);
> > > +}
> > > +
> > >  static int rz_dmac_probe(struct platform_device *pdev)
> > >  {
> > >  	const char *irqname =3D "error";
> > > @@ -977,6 +982,12 @@ static int rz_dmac_probe(struct platform_device =
*pdev)
> > >  	if (ret)
> > >  		goto err_pm_runtime_put;
> > > =20
> > > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > > +				       rz_dmac_reset_control_assert,
> > > +				       dmac->rstc);
> > > +	if (ret)
> > > +		goto err_pm_runtime_put;
> > > +
> > >  	for (i =3D 0; i < dmac->n_channels; i++) {
> > >  		ret =3D rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> > >  		if (ret < 0)
> > > @@ -1031,7 +1042,6 @@ static int rz_dmac_probe(struct platform_device=
 *pdev)
> > >  				  channel->lmdesc.base_dma);
> > >  	}
> > > =20
> > > -	reset_control_assert(dmac->rstc);
> > >  err_pm_runtime_put:
> > >  	pm_runtime_put(&pdev->dev);
> > > =20
> > > @@ -1053,7 +1063,6 @@ static void rz_dmac_remove(struct platform_devi=
ce *pdev)
> > >  				  channel->lmdesc.base,
> > >  				  channel->lmdesc.base_dma);
> > >  	}
> > > -	reset_control_assert(dmac->rstc);
> >=20
> > This patch changes cleanup order by effectively moving the
> > reset_control_assert() after pm_runtime_put(). The commit message does
> > not explain that this is safe to do.
>=20
> Agreed. Thanks.
>=20
> >=20
> > If this is ok, I'd move the reset_control_assert() up before
> > pm_runtime_enable/resume_and_get().
>=20
> You mean having in the end the following calls:
>=20
> ...
> 	dmac->rstc =3D devm_reset_control_array_get_optional_exclusive(&pdev->de=
v);
> 	if (IS_ERR(dmac->rstc))
> 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
> 				     "failed to get resets\n");
>=20
> 	ret =3D reset_control_deassert(dmac->rstc);
> 	if (ret)
> 		return dev_err_probe(&pdev->dev, ret,
> 				     "failed to deassert resets\n");
>=20
> 	ret =3D devm_add_action_or_reset(&pdev->dev,
> 				       rz_dmac_reset_control_assert,
> 				       dmac->rstc);
> 	if (ret)
> 		return dev_err_probe(&pdev->dev, ret,
> 				     "failed to register reset cleanup action\n");
>=20
> 	ret =3D devm_pm_runtime_enable(&pdev->dev);
> 	if (ret < 0)
> 		return dev_err_probe(&pdev->dev, ret,
> 				     "Failed to enable runtime PM\n");
> ...
>=20
> Right?

Right.

regards
Philipp

