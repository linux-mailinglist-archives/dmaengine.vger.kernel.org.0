Return-Path: <dmaengine+bounces-5335-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDCAAD3553
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5551884F14
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB96262BE;
	Tue, 10 Jun 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDx0CSXh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165E155322;
	Tue, 10 Jun 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556153; cv=none; b=J8H1I1m+0TvSn2+gCXBlBqQNg9jB9waGenvBcp1ciVk/LSRKdryLZRcsUZgNwxEVAbMHeGjrjRz9rnS86EpzSp0y02+MgL+Bou0Sj01fja/llhniPrWyfjjTrmTI2C9yRYSxhE8OCWq43Y8fcOIy9NTxU7tXIV42EBbIfdTJCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556153; c=relaxed/simple;
	bh=fBLPiWnO9uNKawNvP06Zsj18SKgG4bUyQKJLE9C1e20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAi21m7eM/I4Wgs2MQoXeTqnzBU1yKXC+sMi1Ql1qMobMirNgyPu9nozhhA5lvDjsvq3Zm94//yoh2zB0hgFo2neXtaYjeby85BaRl/zfupGJrFG+6JFh16XZsq40ZmdfJttTtWzuwbq9UgHyAHTpb+FIKYex2DZ/zdNlCHkzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDx0CSXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADCFC4CEED;
	Tue, 10 Jun 2025 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749556152;
	bh=fBLPiWnO9uNKawNvP06Zsj18SKgG4bUyQKJLE9C1e20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDx0CSXhosb1MCwmMMLVBJhw4RHs2iH3RBVbfKPFLyKIkg0CJg5XzcmINGrTRkAz6
	 E5OcUYaz7jKYEuQYZCwxhq61G13i5C0uwczEzl8xIHTMRjCm7S0UMlRCYNoqTXOv4T
	 hrUoqkNpRQXUTmLEHSAAAlUSYW7NUu7IjoFtvE/YCZeSMzbJTYUUnnoSmF93KM/RAf
	 DtoMizdrcON0V0PwX7k0WZrQ95efyP33dD8PkvqrJ/W9K+CHNTAMpznuAdUWBHhWyw
	 9owOzHGckHx2s4htkjDtZeJvsLrGUrsckNsHlSl90arLujT34IiH3CreHRyRo3vp3A
	 tZ6oIom7ul+nA==
Date: Tue, 10 Jun 2025 12:49:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v7 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
Message-ID: <f21f9aa5-974a-4326-88e0-cd29fd24555f@sirena.org.uk>
References: <20250610082256.400492-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zJq1f6WaSVUF1DVa"
Content-Disposition: inline
In-Reply-To: <20250610082256.400492-1-csokas.bence@prolan.hu>
X-Cookie: When in doubt, follow your heart.


--zJq1f6WaSVUF1DVa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:22:52AM +0200, Bence Cs=F3k=E1s wrote:

> to their devm_ managed counterparts. Patch 1/2 adds the new
> `devm_dma_request_chan()` function. Patch 2/2 then uses this APIs to
> simplify the probe() function.

I'm not copied on patch 1, please let me know if/when there's some
progress there.

--zJq1f6WaSVUF1DVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhIG7MACgkQJNaLcl1U
h9AQeAf9FV6h6KezO9cviLoW3oxs2kOWvPhEC1ccqhMicpP9/H8QcdXTjPyjz48a
WEqp9J7VeP5ztmAotBI1XkQE+gweqge9iPCwwCOPsb8kefWHnjqpwbJtfK2MKRBX
JIYzW2fX/SGLCqwGrPARhh86CQgMsyyTDPN2tKDojFafQi5a3XzinXkaxQ0p7Pfy
GEIwa3+ABIcBOXHYwQ/ldFfolpWhEArjfPW0JYfpUFvquRzfwL8gfsrKq46VrpDu
2RlD/s5/qV8ZOyVaSL0PLbReZWmPWpH5FKgtWrE4FdxulCPOrEocQhDwfd8fRch7
96FfsCyTEaMYv51GWyK8Ivng7C5XcA==
=eUzF
-----END PGP SIGNATURE-----

--zJq1f6WaSVUF1DVa--

