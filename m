Return-Path: <dmaengine+bounces-4347-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26EA2CFD8
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0983A2B1A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3DC1AF0D6;
	Fri,  7 Feb 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfyiv5cu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09471195962;
	Fri,  7 Feb 2025 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964297; cv=none; b=EzcHQtlf4FP1y5ufGEFEHUU3bYLmJv/N69UmuaxS/BDbdAHI10yhfXqUh5eqFX5O6hhXKFaGMDqNeUXSrF8uO9KpuXCgT8JI3aZLwhSiSE4mQk/FrnylxJ4hw0ABk/YDJBNt6AZ8nvi5cPE0UmAWDESTzequICRAb31YIdephoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964297; c=relaxed/simple;
	bh=7xVwhwDjoai8YSxFqqwGSBjxwD2KZy4EIiDqNHKYu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwQVzc2zClN2p2sv64Y9f00fcSYjMfBshaaQgUaW99OruACNVJrehh4VQICo3uTUPDYlyqFRkNgyifIMW4sxqWcQS69y0A6UhGbv7PVXsmjhOvYurV+2XSR8cUlo2vI9FO3GYF5wEqoeY1ds3lIcy3UctmDv0Qsp2lySXrkxjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfyiv5cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DF4C4CED1;
	Fri,  7 Feb 2025 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738964295;
	bh=7xVwhwDjoai8YSxFqqwGSBjxwD2KZy4EIiDqNHKYu+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfyiv5cuS/GU2byBNx1/HS6vFu4XgUVKiwxJxFKa4f3ofnDnF5InCMn2/xpuWS58N
	 4QtqPZCaUgmr79HJ9xmM78pXb89BQLwgxXvc33Lh+3EQeafVlBrVppNrK8XOQUw5H8
	 UJR9X0noZ/1FbX4W1ZBZAMhUYy9BgxOGEd9MwMZFlu4BmJKNV6MQRgPREDIoJFchfh
	 vkIpTE9C01BimsoJ3MqyEWHAtinnUWxUS8B374bKNWOXDU9Asd0dSh8FiOORDf92iW
	 aQPWNpap/IIavA7B9QLaDyt/3GM8gUFwZBNJqf8kGVt3NewUlFLL83a8JTzoH0ByF2
	 gYO4ujWIo0Hvw==
Date: Fri, 7 Feb 2025 21:38:05 +0000
From: Mark Brown <broonie@kernel.org>
To: j.ne@posteo.net
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT
 bindings
Message-ID: <611e47da-ba87-4c21-a6b7-cf051dc88158@sirena.org.uk>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yv3YhmJAoxj+QMAv"
Content-Disposition: inline
In-Reply-To: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--Yv3YhmJAoxj+QMAv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 10:30:17PM +0100, J. Neusch=E4fer via B4 Relay wrot=
e:

> This is a spin-off of the series titled
> "powerpc: MPC83xx cleanup and LANCOM NWAPP2 board".

> During the development of that series, it became clear that many
> devicetree bindings for Freescale MPC8xxx platforms are still in the old
> plain-text format, or don't exist at all, and in any case don't mention
> all valid compatible strings.

What's the story with dependencies here - why is all this stuff in one
series?  Normally I'd expect bindings conversions to be standalone.

--Yv3YhmJAoxj+QMAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemfT0ACgkQJNaLcl1U
h9Dq1Af/eChCpyVx52hhPj2Ppke4XqgRYwHfMx1ZD4zg9Fv5cLy+pNBr/CAHHckC
zFU84oMRCqn0Y8VcKQo6h/qnhsFnmdYxFgRmYg1kXZIm+jfrFUtTHfRH4I/8b95Z
G2JrWA/AN9rNXn2n7I0gL2mBLfXBlTl2GlESRinIHR9eESMM/hJAQmkkw2xpgeCM
lc0xNSEPmuS3M0+rYNtypbnc1bbGXU6zVOEz+5Ennz6bHPi6q6Amjz6HBLyoln3X
3F9zfSERvGPIA442jE6Qm6cFH4S7Vv/L4urjeIvSe7le626ajH99YJZl1BSFaPLR
qcOQY87d6Kjx7kPP+wMJG/Lfhrmprg==
=9fhs
-----END PGP SIGNATURE-----

--Yv3YhmJAoxj+QMAv--

