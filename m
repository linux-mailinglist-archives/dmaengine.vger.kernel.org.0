Return-Path: <dmaengine+bounces-6643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E235B8586D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0A016C5ED
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239C30CB54;
	Thu, 18 Sep 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLi4AGnf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2922425E;
	Thu, 18 Sep 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208713; cv=none; b=pqezMrWMYN1QBq5RoPsCoOMXE2RJTuduOM+vmclmFdHW8SUe224ap6Ht1vYXcGoefISHJtT3TMWoxzNfQEGQvFYYKJLUtwHhPsaX0LLELaFMakhkfuxsjN6P32uHjv73VYji5G8YLR2wOeQbPGSQ1DOZoXZ2GHxq7Y6ptEy9IAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208713; c=relaxed/simple;
	bh=T4wS9mTXcpSpv5NeMblAj4UwyO9r3doA7Bdhw2LH3VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBjcA+hLzwamDR8Qxz+zW+D3gPYuOxjy8ibUzhcRM6kwKBd4UesaVHrTwhZpN/EquqkCqdrUTi4AjHD8GI/Pgq2yVpLR0FqUCKj00QAF4iUIaWipgYBjbtudckA3B5+HcoTXf1SfTN2YTGYjVy1sB266xn0B6jxwR3/0BLgcS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLi4AGnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAE5C4CEE7;
	Thu, 18 Sep 2025 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208712;
	bh=T4wS9mTXcpSpv5NeMblAj4UwyO9r3doA7Bdhw2LH3VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLi4AGnfRF6V6De0JAQgyez9xlUDmOFx461zVUm3XCG3sP4T0+DSxdMQyyFkuOUhV
	 +Vh0+IHpwVsE1AZMdCz4UjHMuDlwhMrk39tlWhDcGgoEsf0H6LULv5ssc1b5PCpbhd
	 JdIa4NK88xzdm/0CBrNg88tIE/Fx13gh/UUhVDeR2zvkFOqfwIosu0udNELsXGdBkl
	 Js0qFWwQZgoA63M3jyhl2eCC8j64ckbBPtWR2RrV6aeDGgTIOkwrsNNEzkg2vc6zCf
	 TfonVsjS25GolhGQGXBUZ0rgcw0cK/3wgOdylL6W6s1718xsH2XOddKjhMSuq6sr/2
	 Gdq9xsJAzr/NA==
Date: Thu, 18 Sep 2025 16:18:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 05/25] dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
Message-ID: <20250918-unharmed-bloating-8b573513fce6@spud>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <20250917-rda8810pl-drivers-v1-5-74866def1fe3@mainlining.org>
 <20250917-contort-sassy-df07fd7515a0@spud>
 <c905fb3ace281280f1ac11c7fbe8e0aa@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qnPPSzmWE/KqIUbp"
Content-Disposition: inline
In-Reply-To: <c905fb3ace281280f1ac11c7fbe8e0aa@mainlining.org>


--qnPPSzmWE/KqIUbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:11:10AM +0700, Dang Huynh wrote:
> On 2025-09-18 03:46, Conor Dooley wrote:
> > On Wed, Sep 17, 2025 at 03:07:22AM +0700, Dang Huynh wrote:
> > > Add documentation describing the RTC found in RDA8810PL SoC.
> > >=20
> > > Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> > > ---
> > >  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    | 30
> > > ++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> > > b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..3ceae294921cc3211cd77=
5d9b3890393196faf82
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
> > > @@ -0,0 +1,30 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/rtc/rda,8810pl-rtc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RDA Micro RDA8810PL Real Time Clock
> > > +
> > > +maintainers:
> > > +  - Dang Huynh <dang.huynh@mainlining.org>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: rda,8810pl-rtc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> >=20
> > Your driver implements functions that turn on an alarm irq, but there is
> > none mentioned here. What's going on there?
> The RTC doesn't seem to have an AP IRQ associated. I can't find any
> reference to it on downstream kernel and the docs.
>=20
> >=20
> > Additionally, there's no clocks property? For an onboard RTC I'd have
> > expected there to be a clock sourced outside of the block.

What about the clock?

> >=20
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    rtc@1a06000 {
> > > +      compatible =3D "rda,8810pl-rtc";
> > > +      reg =3D <0x1a06000 0x1000>;
> > > +    };
> > >=20
> > > --
> > > 2.51.0

--qnPPSzmWE/KqIUbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwiwQAKCRB4tDGHoIJi
0mfkAP9yS2bi4VD6hutTCOIeT3qJB84qFVZONJYP1wnhQwLGeAD8CFxZvCN6Jv4e
UC/tOu6vHervFswpc7sqlf9k4hh+qQs=
=wDJV
-----END PGP SIGNATURE-----

--qnPPSzmWE/KqIUbp--

