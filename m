Return-Path: <dmaengine+bounces-6902-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A499EBF2C35
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350664FBA61
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481303328FF;
	Mon, 20 Oct 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq+ctViS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B12BF01D;
	Mon, 20 Oct 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981923; cv=none; b=cGT9SMJM/SeSIWljc/UoN9/iw0MHOMrxbEVNigcHYXVHmQgvcQQM00NBQl4DyMNkR0JY/+q3J0614ecunFIbXpK7E3tHKLMZ8FK6lax4sPYvGsm7Jjf+IQNXzEB4Ywx+e6+V+NrK0HHwgkn50eMqqOxia/9teispwHjq4qzuWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981923; c=relaxed/simple;
	bh=z4S/Ek+YldPvINEkGsS4GtyzWXh8+ZPhINVzWN0ZA2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+ycyd8dTm1JZ+u0UnJ0ZAqeDFfA7hy/YdcC6JFFDpZbJPVLmYdGUQBq/vgzli8diVxX3BvK2z4Dhmd/7OLb6n2VxbpR2Op3RyCM/eHPMOGUddOJTgQHQUFmoQNq6dll7eY5zfhdpeUT/dVVIhNU33yl3diIztFCKvVMLGDm99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq+ctViS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5607C4CEF9;
	Mon, 20 Oct 2025 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981922;
	bh=z4S/Ek+YldPvINEkGsS4GtyzWXh8+ZPhINVzWN0ZA2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aq+ctViSTR7UDH16588OT6tm0rAFQZjMOnoBF6DI6S5TW19K6WeHzqvTchnqWOEpR
	 zJy2DV6vf4h6BBDBSPNWOX/0Er8aLRKjmHJP6Hc7TuceEQDk7C546Ma8Oe9gaURoeA
	 7deoLDVg1MBbu892khg/huonJO/KjI+sdhZwd2TY2BMpdzY/o1wJiiHRimXh0XAGxD
	 8EAkwtOyDwCeQa62dyq9uqtAqkxYG7qPJOTa/G8uVehVIFTj+tc6xVFU1wwoxQRl0G
	 qEGPId1Xgsvdrhwq9AidZVDdneI7kji0pE1x1d4vpakwg8gmJidmGtzK0Cwo1hVftU
	 JB6tRzy2n4mkg==
Date: Mon, 20 Oct 2025 18:38:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] ASoC: dt-bindings: allwinner,sun4i-a10-i2s: Add
 compatible for A523
Message-ID: <20251020-thaw-zippy-16c5abdab66c@spud>
References: <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YTId/bDtK4GXQ9vH"
Content-Disposition: inline
In-Reply-To: <20251020171059.2786070-3-wens@kernel.org>


--YTId/bDtK4GXQ9vH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--YTId/bDtK4GXQ9vH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZznQAKCRB4tDGHoIJi
0iiGAQDbeTZHOT/vrRa0955LNmg6Krx3j8KugyLxUopBb3l9IgD+LdsEL5bwP8r3
dXQ8jYpAE48r/+VJ7lDuXtTyDe6asgE=
=/dNm
-----END PGP SIGNATURE-----

--YTId/bDtK4GXQ9vH--

