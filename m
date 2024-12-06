Return-Path: <dmaengine+bounces-3922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4619E763E
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5832916EF99
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5420458C;
	Fri,  6 Dec 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuGYt4ol"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30320457B;
	Fri,  6 Dec 2024 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502939; cv=none; b=e9jC7i3uwXdwywJuyBAJDJ/IiNST2EpbgZZRiJufHQQ9GDfBm5Vc5vTLzr0GiRK8ZZjvsS7TV0RO6cBZQGyJmG8aJj7F5215dqsQ5edhyBfGREelZvN5zpzqb7ESwfHOhJylG7XmW4Jd0ji3Hgu8p7TRGYmk0Mk/Zd4SRhHojuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502939; c=relaxed/simple;
	bh=BpWfeIfcxxaNUbn2U8tKvdEkHK2FsMtBU4eTLwJnl7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6aPY6rMwFp2zyFk3hcem5gLFMQ1Mrf6QsfHt5iyCjcXm63yxrQOCzh3kRhvpweUzp7HZ6SvCVo/uwAIC205xTzY8CH2Tqz4eo5nzjyPd+pfojA/yCUwXnWD3YQlAFUZlr9RELpmzNHSGVYrzUpXJ49d6mZNoPx3ma7jFhIcvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuGYt4ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C80C4CEDC;
	Fri,  6 Dec 2024 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733502938;
	bh=BpWfeIfcxxaNUbn2U8tKvdEkHK2FsMtBU4eTLwJnl7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuGYt4olh5TgvxpQcRl9PsFUBVax8yi9s7islv/y9OlAhdA+vMfaT6D+ES2NY8iqU
	 AgGeGQsq7HZdd+l3d7QxeCUn8u8uyr2+2subSrnL+Zl7WM3RHjjEl+14YNPzkT7yeZ
	 9J+e/vl7MoYGWnFG3dUkcR6kQPZ2xH0gJ62LJHfdzEsy8wGTwszUHXNeRh0+PgP77g
	 hJK9GFhd32id039IqfSeHBOohpEM1+bHCIoZ8HYnwLRRIoSUOCqjx2ZpFA/iePQVnO
	 Y3WCoPFi///8rDq9toJijZtrRNsKL1AG5mBT8FGpaKqebQII1RyBhOrZB4CohOG8Fy
	 t60/s+ezsWQ5w==
Date: Fri, 6 Dec 2024 16:35:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Ken Sloat <ksloat@cornersoftsolutions.com>
Cc: =?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: st-stm32-dmamux: Add description
 for dma-cell values
Message-ID: <20241206-placard-hesitate-626fd285dfe6@spud>
References: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rLkrVVLioLF61Rl/"
Content-Disposition: inline
In-Reply-To: <20241206115018.1155149-1-ksloat@cornersoftsolutions.com>


--rLkrVVLioLF61Rl/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 06:50:18AM -0500, Ken Sloat wrote:
> The dma-cell values for the stm32-dmamux are used to craft the DMA spec
> for the actual controller. These values are currently undocumented
> leaving the user to reverse engineer the driver in order to determine
> their meaning. Add a basic description, while avoiding duplicating
> information by pointing the user to the associated DMA docs that
> describe the fields in depth.
>=20
> Signed-off-by: Ken Sloat <ksloat@cornersoftsolutions.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--rLkrVVLioLF61Rl/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1Mn1QAKCRB4tDGHoIJi
0ufIAP9eSd/XJsTC82uOXaiS9+VsdB9msrVYPoh9A6R9d6eBIQD+Jz2f3eV4SOv7
heJ+59ODd2/vb4Rz4ypHMaY7cXXBFgg=
=7nq5
-----END PGP SIGNATURE-----

--rLkrVVLioLF61Rl/--

