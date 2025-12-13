Return-Path: <dmaengine+bounces-7607-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5BACBA3E5
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 04:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690D330625BC
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 03:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75817C220;
	Sat, 13 Dec 2025 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3I+s6WU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8F29A2;
	Sat, 13 Dec 2025 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765595767; cv=none; b=l0FQfvbmzMb8O63Df9CFPyKbBjtwX9JIgmVnFqtDWAbWmMN+mw+PulfCZCD/uHlz92dpwVhlTdOUPRnZN4Ll+SEWne2Ff5tUqklPQjBtlpsSJn7atNCf82EsM+5mMgwFO7bu2F2GqVZfJa8nvC9sHBJ6Op2+e/cGdfasvQQ4Sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765595767; c=relaxed/simple;
	bh=KOXoqXt5Xmrh921+CW5vaUGrvh86vh0stCQ6djrzqE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym3rIhxIhd6fdHEn9HN4LTkbPgo+eq+lkfqTNUdm0aqeutnkHZpfW73qBKzseWX9nmvQjxso6RXUo4/irJAGld/JsZ53Vwb8EdyrXTx4GnI11Y0sY6SOcgVJEeyo2iPHDU0g9jB8R8cyo2QL8aH0hlmQlO60k8RToyVLdUl1/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3I+s6WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F60BC4CEF7;
	Sat, 13 Dec 2025 03:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765595765;
	bh=KOXoqXt5Xmrh921+CW5vaUGrvh86vh0stCQ6djrzqE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3I+s6WUp1W0mDBHh3cXyXcKGUScadcndF+cR3bgdkuVT8PtPMHZEyLDDCKB6/lvo
	 88P9PXI72Czg+bZKQlpV+eY9jQ1t7gDn5pPxgi77RX1wV1Cf43YTNwypRjgpbHjUsT
	 /XwvzDaMAMK3vmvKqVyrQYiPLhUgwOmqFodb/rtOHkt45fyTXRPLA1mAh8+sPEL0gx
	 cuIN66MjtHUbl3Raq6JnufW9dEwnQWqXOH3FNEKMClq9koFS9HG53PJGil0z+rP1hN
	 sWCKhvX/uF8pFTAUXBymg6e7qcSJYcw7pDIdRzTyWUUCOWB3nHatb/Q5WiS6y79fJe
	 L1+w9wqtxnhQw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 9308C1AC5657; Sat, 13 Dec 2025 12:16:03 +0900 (JST)
Date: Sat, 13 Dec 2025 12:16:03 +0900
From: Mark Brown <broonie@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Vinod Koul <vkoul@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Peter Rosin <peda@axentia.se>, Linus Walleij <linusw@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-iio@vger.kernel.org, iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove unused includes
Message-ID: <aTzaczBfsrH2nY5w@sirena.co.uk>
References: <20251212231203.727227-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8bHZTj54bYLdLiw+"
Content-Disposition: inline
In-Reply-To: <20251212231203.727227-1-robh@kernel.org>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!


--8bHZTj54bYLdLiw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 05:11:52PM -0600, Rob Herring (Arm) wrote:
> Remove includes which are not referenced by either DTS files or drivers.
>=20
> There's a few more which are new, so they are excluded for now.

Acked-by: Mark Brown <broonie@kernel.org>

--8bHZTj54bYLdLiw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk82nAACgkQJNaLcl1U
h9AF0wf/RU9WagcpUCZ1sx0lAc8LqeClGvN8UmsUry3bwmzqht7//PCIqy9YES2b
YonKgjyQSc6jVAso760Vy8kMyVo3qmDtZh/+HhG+hKZKYjuWXTgNDZbcuHqLLC0n
VfP2g8L5ainnzUQn4d6fuC7yTPCemUe5LXXlfAXcsxgTzYp9lCOfPAzCQ8AXP8dR
3nfijzX8hDff/ZC7rmalUnnhx/RkrrAxxNALfZTo2xmgpP63cimXvuJt8oQEAPBU
Sl4lfIk/svMJjz8wkCP6p7YT9E2tyyrKpLCsduZAXCRi8+OSbV/EMEwVvn0DbsAO
zBEwV/somQyTbEe29Lzi683OStqqEg==
=3mYQ
-----END PGP SIGNATURE-----

--8bHZTj54bYLdLiw+--

