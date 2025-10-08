Return-Path: <dmaengine+bounces-6792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE0BC69AD
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 22:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563C318913F8
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BF2AF1B;
	Wed,  8 Oct 2025 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWQxs4Jo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCA34BA47;
	Wed,  8 Oct 2025 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956349; cv=none; b=jd6vi8aOkmjMdmQ4q4JhEbxtfbCMhlhCi9iz5JQnzUvhhwJHVaFUk4WMZkRgkPEx4ReRVqN4PygW0vxwEOwFDvehVss7G0xWY403l/eB5v9R/mARtXq9C43hWzh4Qc8/qh2xJKdaCWTOwkPMRLul19Q6bJqd6bc7usp2E9qtdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956349; c=relaxed/simple;
	bh=LW0bw/jiGBt9EQg7EK+quDFm8WZF1tmhz+TiW+AYGiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyCr+vm7HqggivkHHJDhohQ+W3yJ60ey3nefkxeAEKd54bJa8YFOB2ZajPEUFWlr+2gHzvMm0dvWsR95vUL+RjeJSsCg3t3zDLf89NlSaFzg3RFnUYlEQEKgfxeQVe7UBJRmYC3geTkC/wP+zoqYpZy4r3w5+p7a1aUsccOAw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWQxs4Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD3FC4CEE7;
	Wed,  8 Oct 2025 20:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759956347;
	bh=LW0bw/jiGBt9EQg7EK+quDFm8WZF1tmhz+TiW+AYGiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWQxs4JojNuZTiszKRwycHX1sNsToytA2sX3mt3G027T3bn2Y95sx3ewLPyJQwGxc
	 ZYIWh4O8nlekHxZxKSNUeDQY4Q0OWwKRRjkwNTlYPTgi5dPCv9i7+UGlLFlqr9AlTN
	 +xI5Io++jXLjdSIcUPxzr1KCGooUbKlKO1wYuLcB4KmzQDrHMr7wbugfDKURbjLnjp
	 HXsADIbY8qoloo2DHhr8nkw/zpEO4hZZLYk0p5UkyKVOdDjXpgM4rBcfmUpZ9oFt3s
	 SHn6esXHxXgi9C54HC2mHkOa7P3NoplkyW08cMb2f0DWlTEICUJ/bZyUAcYzIiC0ak
	 WXmy3UxhdB+WQ==
Date: Wed, 8 Oct 2025 21:45:42 +0100
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	gg@swlinux02.smtp.subspace.kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH V1 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <20251008-criteria-debit-09f8e855bcec@spud>
References: <20251002131659.973955-1-cl634@andestech.com>
 <20251002131659.973955-2-cl634@andestech.com>
 <20251002-absolute-spinning-f899e75b2c4a@spud>
 <aOUIfaZY7-eUYoOS@swlinux02>
 <734de17e-a712-4eb5-96fa-b7e75f86d880@kernel.org>
 <aOXW7HUMeOyABuUG@swlinux02>
 <dcd14886-f2cc-41ec-8bb5-9cb5ed50c452@kernel.org>
 <aOZokztqpHHX0JPq@swlinux02>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+n0iJs4RcGo1Uplu"
Content-Disposition: inline
In-Reply-To: <aOZokztqpHHX0JPq@swlinux02>


--+n0iJs4RcGo1Uplu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 09:35:15PM +0800, CL Wang wrote:
> Hi Krzysztof,
>=20
> Thanks for the clarification, and sorry for the earlier confusion.
>=20
> To elaborate on the rationale:
> "andestech,atcdmac300" is the IP core name of the DMA controller, which s=
erves
> as a generic fallback compatible shared across multiple Andes SoCs.
>=20
> Primary compatible (SoC-specific):
> andestech,qilai-dma refers to the DMA controller instance implemented on =
the
> Qilai SoC, following the SoC-specific recommendation.
>=20
> Fallback compatible (IP-core specific):
> andestech,atcdmac300 represents the reusable IP block used across differe=
nt
> Andes SoCs that share the same register map and programming model.
>=20
> Keeping andestech,atcdmac300 as a fallback helps avoid code duplication a=
nd
> allows a single driver to support future SoCs using the same hardware IP.
>=20
> This approach follows the DeviceTree binding guideline:
>=20
> =E2=80=9CDO use a SoC-specific compatible for all SoC devices, followed b=
y a fallback
> if appropriate. SoC-specific compatibles are also preferred for the fallb=
acks.=E2=80=9D
> =E2=80=94 Documentation/devicetree/bindings/writing-bindings.rst, line 42

Unless there is a significant likelihood of there being different
configurations between devices that are reflected by dedicated properties
there's usually no reason not to use a single compatible for the first
devices and then use that as the fallback for future devices. Either the
future devices will be similar enough for this to work or the fallback
to something not soc-specific wouldn't have helped much since the new
device would need special handling.

This case might be different though Krzysztof, because Andes is an IP
vendor not just someone using an IP in their own devices. People
certainly get tetchy about using someone else's soc-specific compatible
for their device and I can understand that. I also think it's easier to
understand that when you bought an "atcdmac300" IP from a vendor that
the correct fallback is "andes,atcdmac300" rather than
"andes,qilai-dma". Personally, I think what's suggested below is okay.


>=20
> Please let me know if this aligns with your expectation.
>=20
> Best regards,
> CL
>=20
> On Wed, Oct 08, 2025 at 05:04:53PM +0900, Krzysztof Kozlowski wrote:
> > [EXTERNAL MAIL]
> >=20
> > On 08/10/2025 12:13, CL Wang wrote:
> > > Hi Krzysztof,
> > >
> > > Thank you for pointing this out.
> > >
> > > "ATCDMAC300" is the IP block name of the DMA controller used in Andes=
 SoC.
> > > According to your suggestion, I have updated the binding to use SoC-s=
pecific
> > > compatibles with "andestech,atcdmac300" as a fallback, as shown below:
> > >
> > > -  const: andestech,atcdmac300
> > > +  items:
> > > +    - enum:
> > > +        - andestech,qilai-dma
> > > +    - const: andestech,atcdmac300
> > > ...
> > >    dma-controller@f0c00000 {
> > > -      compatible =3D "andestech,atcdmac300";
> > > +      compatible =3D "andestech,qilai-dma", "andestech,atcdmac300";
> >=20
> > That's exactly the same code as you pasted before. Please do not repeat
> > the same as argument to my comment.
> >=20
> > Best regards,
> > Krzysztof
>=20

--+n0iJs4RcGo1Uplu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaObNdgAKCRB4tDGHoIJi
0tA5AQDh+jkkW+8bNKgitktkRidvoNRSZ818jGiiGIapmS8ntwD/cLKcBUM1lScV
Ue8XhfNYOpIqVPyv1WDc6TAFqZoc+Q4=
=TekB
-----END PGP SIGNATURE-----

--+n0iJs4RcGo1Uplu--

