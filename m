Return-Path: <dmaengine+bounces-5322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212BAD0503
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1E1899380
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66353289343;
	Fri,  6 Jun 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elql2HZ9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659C1991CD;
	Fri,  6 Jun 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223039; cv=none; b=clHcnHU8qjN46dD/pp27yh0iKu7kEjb6PfAKuryLsqWlVB9xG4WhMcGOYIp7jm6JTXLHzWef8h4JMiut9OvFHwCCmZHHF9SM3vsP2KHioE1W1yzitPAkN1W5ZR6UMe2mZFXzE2QXiyMNgviwfW2yWRFYrVP12MzzaInmSbXedYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223039; c=relaxed/simple;
	bh=SZEx9/PHTlU/AzqfimMF/aQJ07Zs92TCTW3A11T2ll8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UatNr9gkddD2FbpUzuCEs4Kr+aiA3av0rWvks8ohVoyYyQzOaBsv7KJBvW3S041k6mGqMyYlE15hwj4t9og/79tudkLdkkWNnkex/KOTFYRu7mooNKNu6/V/rdgaHuUHy0tRLw5fzD9qbLl7VSVStAxZob9YYwbc8oFpZUSvbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elql2HZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22CC4CEEB;
	Fri,  6 Jun 2025 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749223036;
	bh=SZEx9/PHTlU/AzqfimMF/aQJ07Zs92TCTW3A11T2ll8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elql2HZ9+gtHvY35GtOiYx0rdbcugqG9COKyiBsqE5u6G+ZselZNyCQ8ifregkx4G
	 IRcbvbJ4gTPuV41LzVDKLVzMLjYd5y17Zkaipl7FmdbGRidLBFxthV9r/KJbMU+IfK
	 oYQ7dqeS3IMJHFI/PbkXxvWkNHAC69iRfdhkH2MTc9oqyNCBs9FtUYDho32eIzZ/NM
	 wxeLIT1CGY8ZZnFpjmD7SiWzphak9SvJuWRHhkmd6QvXRheckOHlqCQ6msL/mD2SVX
	 3OAyZTBpzNj5idhrC7qtgJqrLKwNvYHcr6zcZdHrgmsOMpWUJf0pnn4TIFZ6hnmCSg
	 cR2KpwDw/ocXg==
Date: Fri, 6 Jun 2025 16:17:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl-mxs-dma: allow interrupt-names
 for fsl,imx23-dma-apbx
Message-ID: <20250606-unending-rockband-fabcdaed87a4@spud>
References: <20250523213252.582366-1-Frank.Li@nxp.com>
 <20250526-plural-nifty-b43938d9f180@spud>
 <aDcw0sgN1ZX0kCCZ@lizhi-Precision-Tower-5810>
 <20250530-those-frequency-f8106275769f@spud>
 <aDnYpeViGvIsGCLD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LWyb0P04RKgeQbRs"
Content-Disposition: inline
In-Reply-To: <aDnYpeViGvIsGCLD@lizhi-Precision-Tower-5810>


--LWyb0P04RKgeQbRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:11:17PM -0400, Frank Li wrote:
> On Fri, May 30, 2025 at 04:24:51PM +0100, Conor Dooley wrote:
> > On Wed, May 28, 2025 at 11:50:42AM -0400, Frank Li wrote:
> > > On Mon, May 26, 2025 at 04:28:07PM +0100, Conor Dooley wrote:
> > > > On Fri, May 23, 2025 at 05:32:52PM -0400, Frank Li wrote:
> > > > > Allow interrupt-names for fsl,imx23-dma-apbx and keep the same re=
striction
> > > > > for others.
> > > >
> > > > The content of the patch seems okay, but why are you doing this? Wh=
at is
> > > > the value on this particular platform but not the others?
> > >
> > > Actually it is not used in dma driver, i.MX23 is quite old chips (ove=
r 10year).
> >
> > If they provide no value, why not just delete them?
>=20
> The platform is too old. I have not hardware to test if it really unused.

oh well,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--LWyb0P04RKgeQbRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEMGdwAKCRB4tDGHoIJi
0rfRAP0d1c7CjpWwGCBbFeIXDYjKjS0gYWoeInijKrMbsrTAEwEA7zYVo1MkZANM
Jf3bucvpJep13y2QUVEkdnRbqqP5+A0=
=2oX8
-----END PGP SIGNATURE-----

--LWyb0P04RKgeQbRs--

