Return-Path: <dmaengine+bounces-799-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3D837107
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542CB1F2F057
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CEE482F8;
	Mon, 22 Jan 2024 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF4/hJWL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA31482EE;
	Mon, 22 Jan 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947566; cv=none; b=a3cCYEe94IOoYuRFrtB6673zy3LTKmxM94juZ9mayZxBdapO6wLN1JNqi7/WT0AiKKZ1GJNYMuV5fsX8dHr0hOF2K79hlHglPe571b+khJm8WS2yWoOmj22uuLaFcWql/vJIheEVwzw1KwdC1N941CqxP4HIdwQopqgCHH4OmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947566; c=relaxed/simple;
	bh=OZcPk2pggxtjOS+ubRNC6FIXTbmLJjawsJ9rn934CeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlGISmwDcjsdyTW+RAKBCuQTNIna7ZABnWTuZxS7dqXrE2JHNnoGhxJPX6udWS2sGIrOarBWK2panzfROG5aZLf2ZMjytlBumWl29zK+5aiTHefX0VuX4dox0vVrmm+jiHX6ysYTg03UbjtAW6fWZJeP9GD33Ce5aBMRpyKH+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF4/hJWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B5CC433F1;
	Mon, 22 Jan 2024 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947565;
	bh=OZcPk2pggxtjOS+ubRNC6FIXTbmLJjawsJ9rn934CeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF4/hJWL3mS83HQGPCR7yGPwCxscFDTWAWGOcdO342ngnj39pm8CmNGp0Hod/mDKH
	 AqYm9z4uQK2qLhRso6VfzQGJtuNoEzE1o/aVNYdDilw8YQsaPcb5zLac1mZg0UrD9J
	 n92DIxNOQZfKvc9dm9igYaWVKyajcmj3jGFrrK5f1gvMe/WYTZGNWHO0bjRPm+e+CS
	 TI1AK9C5/DPHuNEjvFGWHNt5NTsKUF1QjSgxJHJd7zsGq6Au2nw1V8rptaW5dmjNw0
	 RDjGDvrVpOCoO3XQoo7U15PXOJ/VBUOV/nqWcCYrsb2CRtHtgH7xdd5OyUs8x7RJm0
	 2yROrjWBAQNcQ==
Date: Mon, 22 Jan 2024 18:19:19 +0000
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
Subject: Re: [PATCH 2/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H616
 compatible
Message-ID: <20240122-richly-mural-817d7e39bc33@spud>
References: <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mkTWaXxeQ3jWqT6J"
Content-Disposition: inline
In-Reply-To: <20240122170518.3090814-3-wens@kernel.org>


--mkTWaXxeQ3jWqT6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:05:13AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The SPDIF hardware block found in the H616 SoC has the same layout as
> the one found in the H6 SoC, except that it is missing the receiver
> side.
>=20
> Add a new compatible string for it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--mkTWaXxeQ3jWqT6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6xpwAKCRB4tDGHoIJi
0pzhAP4vbwr67N1BpFd6xUJIlq99pUjw5fzLzySX7UT8R92OPwEAin0EoMfu94Wv
bBg4ZMSrcxLD+zno+DXZGKS5Zk1u2gk=
=AdwN
-----END PGP SIGNATURE-----

--mkTWaXxeQ3jWqT6J--

