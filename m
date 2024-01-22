Return-Path: <dmaengine+bounces-798-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D288371DA
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 20:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83450B3538F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38537481C9;
	Mon, 22 Jan 2024 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxM5tg9Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D835A0E9;
	Mon, 22 Jan 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947535; cv=none; b=Tn3lDmjzo1d/l3YkTz/meJJxCJS48RqcDQT22KAhx4X6+kq/GJ1gRY2ECe6P/6pcPmQPtFpDRyAzVXuFZV+72QrAO38Ur5hzqqcOH4aXRKAlEa7FxU1P3Leda5y8QLAzmyana5kkhhcY3j/8qX1MVG3V1AEVP58HIjee4fRUuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947535; c=relaxed/simple;
	bh=TCnptQYm76Cnzy+JMIZep0BJD9/N8YDksXE5yoBTQwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiVnfZDSMHpTjhE31FmQ9U2DaXQfcSlAzEImc/781F85bnD34IaFUdaWXyIgw2jHTbrdbG4/E+ZIarnDPWLXtGWgkuifQPyGOgFgvFMqpoVS0sRwgSNdmy+7o7cvmTpF4+eCS6EeRA5Q1JR4ygzx4W9P9aslNED9uUqaeeCv9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxM5tg9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E48C43399;
	Mon, 22 Jan 2024 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947534;
	bh=TCnptQYm76Cnzy+JMIZep0BJD9/N8YDksXE5yoBTQwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxM5tg9ZNK8UfX6navcoSQvKXUFEjAbysReE8tuV/Q9jzzLjjvWCl6GpIf3Y1RQjS
	 f8Nz0VgmXniNXC98CIiT8k8543VENx0UbCwATC9MPxkdQxsseLSC5NuHYNZ4TrIYDo
	 Hu/0+S4uKAJAL33jxkcOMwEfI1ZpRsxpMlZQmQbxZOZo8wbj25tecfh2vlHQa8cRMb
	 24VlXvZWjQzDdQj3HiEWqK14Spz+JMbY2sHBsVY8DBQ340jcrjgVYkwtNsZujkxzDb
	 jrfB8R3reIXOxmf9/mXcbvolBeXctj6XVtJKAINJhklIv0//il1CF4rjidnCXuF1Pe
	 E7reeYGA+wuPQ==
Date: Mon, 22 Jan 2024 18:18:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: sound: sun4i-spdif: Fix requirements
 for H6
Message-ID: <20240122-stiffen-stylist-b3ae23c02aea@spud>
References: <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bpOSSRFHL/Ug5loW"
Content-Disposition: inline
In-Reply-To: <20240122170518.3090814-2-wens@kernel.org>


--bpOSSRFHL/Ug5loW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:05:12AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> When the H6 was added to the bindings, only the TX DMA channel was
> added. As the hardware supports both transmit and receive functions,
> the binding is missing the RX DMA channel and is thus incorrect.
> Also, the reset control was not made mandatory.
>=20
> Add the RX DMA channel for SPDIF on H6 by removing the compatible from
> the list of compatibles that should only have a TX DMA channel. And add
> the H6 compatible to the list of compatibles that require the reset
> control to be present.
>=20
> Fixes: b20453031472 ("dt-bindings: sound: sun4i-spdif: Add Allwinner H6 c=
ompatible")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bpOSSRFHL/Ug5loW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6xhwAKCRB4tDGHoIJi
0sLTAP91m25Zp8MqaVLxP69Lq9eRk2M1rHEgfJkiPGUj6MY/1QEA48eYJb4o0NS6
orlpzr+TPbD9wQMdLsmaRiMX/rj8cg8=
=Akub
-----END PGP SIGNATURE-----

--bpOSSRFHL/Ug5loW--

