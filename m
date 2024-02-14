Return-Path: <dmaengine+bounces-1014-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A874854A05
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 14:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F201A1F22894
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C45337D;
	Wed, 14 Feb 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czJyM+o4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BF1B813;
	Wed, 14 Feb 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915841; cv=none; b=MnkR6FUtbnfHlgB2iSH8MxOfRgNqwzAAmIB19WIuTfA3x/sH/aaZWoL0sZORetQEGbZxNWabpw7LwXyhuoO5mITYvCTecKXR90siSWzSdhR7UYHwpdtjLtdza9DVdj/eWnuRsqa9wWtaW5gACsRrew1BK8HfGCJfc8kNmRUj2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915841; c=relaxed/simple;
	bh=FIfbmtUX2ySen7uU2M4erZhZ0Y4ojbxmPLBScBthICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAWAN6Kxt5vFYzwBebG51OlpOF663Q4FHIeyji8Nm5ctVL9CyEkNvQOcWR4GZfVnAv33HI380SPQZK4a8D1BPTDR5a3e5We/VziA5Kz/R91p9fv7EVc5HulMScxNG90jN5M1WsLe9XchT6fnoC3ZHBO1GGOnhywhqb/RMpc0xQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czJyM+o4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52F2C433F1;
	Wed, 14 Feb 2024 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915840;
	bh=FIfbmtUX2ySen7uU2M4erZhZ0Y4ojbxmPLBScBthICA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czJyM+o4F/aOvE379DciA+dJfraO8xnki9r0RuTRKR9HliuY880aJt8k/fe8Fuurb
	 ViQ7maAnIAT7PazffgrMyCFUgwOfFiVpU4UMpbVf+dWU8UpZAK2WfOy7L3PfTbG3rQ
	 Gh/09SEb63vMe50kIwDejaMujBC9bx4mb1w+LEDr/RB22/rP8uiaWuRcFtgso0I321
	 plbRp8SVUmmjqEbt+/E5mzBYAS5iT02s0D8R2619Sz2z5TOx+/9khiKbogJHtScEEn
	 75NddTymCSUIyVh2AzqhLlXdvd/SwQFRFOiVmKUALCLJSZhc+Y7lTHg4tvEOI5KJRg
	 3WLGlbU+r63lw==
Date: Wed, 14 Feb 2024 14:03:55 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779h0 support
Message-ID: <Zcy6O9XX0dHA-MOS@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qzhFuwFvMVlL1V4b"
Content-Disposition: inline
In-Reply-To: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>


--qzhFuwFvMVlL1V4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 02:00:34PM +0100, Geert Uytterhoeven wrote:
> Document support for the Direct Memory Access Controllers (DMAC) in the
> Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Based on a patch in the BSP by Thanh Le.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--qzhFuwFvMVlL1V4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXMujsACgkQFA3kzBSg
KbYwKxAAgHalDTDVB4PO0AxVAnzLhssYydxQ9fdfSRoToK8eLLq4eZbKHPUSiD/l
KpR1lCH+nCS7Zo8TZSnFTtjFheaJsZxASaJD6vApWAqEJwDlfJKAo7DwRvdnFNsc
wZlOWXzxrmKL1jUpf8YTbZU0D8tc1i/iGODwqqmuePY/wnQUHYAj1RAbahJXWcAd
j3bBTHtGbMUkTSR+eUy6rAOYtPS1hAVpk3wcEMwmIEoF2GR/gBEaT/btbMdZuXD0
PO+e7VXLzGpsL9/DmfuVJsYNXEy/im9NWwvEX1yZ4mphGIYAgUVnpXZgpvMDMWhG
bXLwfkm86Whe1FbXgiWciQP3aa5TvEXL1XHqK5wzsrHBZwt5M5FgT06bL0xCiYqx
5Z+pQN/uQ8RhiPWFZ+0K+CkADuiHcOMAKaWiqHuG8qwkcftiSYO2oZyN2zT9YVaq
++3YuVRtgApE7/oqGyaAjvVvi95S88YnjNGDpKd37B9Ca9Ng9P6ii6fGVfPwvVu6
yrpVUhfnp0bXxxUzgPbk2bzczSbqMR5uxDISFVh+qTOW0yz5O4SlFKB7rm1aSyX1
j4WXQUMA6qI4ipVPQs6UEoQC4uWH6fKyuXUWqT9EsNNcsyH5tbgXmwbJIL79vrv9
HPQOK0vNdu3AezL1qZ9/f7ssAL4DFGMgPuBBxKO+BLsJFXHfjxs=
=1NIx
-----END PGP SIGNATURE-----

--qzhFuwFvMVlL1V4b--

