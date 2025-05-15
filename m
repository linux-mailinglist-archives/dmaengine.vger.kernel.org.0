Return-Path: <dmaengine+bounces-5180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199DAB8309
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8568C785B
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3D297A50;
	Thu, 15 May 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4gfy4j4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710D1B043A;
	Thu, 15 May 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301765; cv=none; b=tYPMZFvmFev2RMGueqjPxakvSREEDq3Gze80Vwp2/ypK47nZqM4plrbgQxEflo45fGLm/y9fdJZGR9A9G9FUz7w4qXgGOF9O+GwPwrIc0yMd6H/kkcD5mPsW+hngZkM9uDgUl1675KMkNn1roTO3O/KnH5rOqzKlB7l+QxfDSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301765; c=relaxed/simple;
	bh=jMrgzyHH+4V9t/iPtHENc2OSX0TATtWm0B0KKLwDmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elIs1Sec5C1zTHQf6LUSr8+P+HXkbCxdqMWH7PzBcQHAjnF30pWFU+dphUHQ7DCCmvd592uQHKdlcTj4LaKwPWHLvMlsIGQyo//iHAVFv9yExZnZWlJZ8fxqwxSfAFpSEREjGv96W9x1zVf7DTgfdm0zxKj2xt2cy5m9b23mQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4gfy4j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3EDC4CEED;
	Thu, 15 May 2025 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747301765;
	bh=jMrgzyHH+4V9t/iPtHENc2OSX0TATtWm0B0KKLwDmC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4gfy4j4xEx5H9jAzEyhxdiQ9ifxSASjtba1zdKjs1BNs98NwIFL0NIaHt3U/9+xM
	 csrpFI4J6CbH9YwJECNPaCUZC4NKipnyDyPt8sJa3iiVMg9IllfvP9ePu6fgV+TEwr
	 03SEi6uwBRS7M8AiK1neXCTeK0ReaVBsfU1rqZvrR41QwpcS59b1VYvRYxm6lFi+8f
	 2uo/25Jg8fUkgKwEph20KLl1mCtM2CtzceS41jXwjug05/g3X77TJ7Basi2la/whFy
	 fBQB0w5JQFW/uTaIUCgCqosD1N8ICNuzx/wAxCNzQebwRupXzWZd541z3MYZsIgg9r
	 SzsCaFDsdbvkQ==
Date: Thu, 15 May 2025 11:36:01 +0200
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v6 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
Message-ID: <aCW1geupMxr8Ft_k@finisterre.sirena.org.uk>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
 <aCWpjplhAXUvr9fj@finisterre.sirena.org.uk>
 <e4e6c7a9-9b7a-4012-8bda-75804229ec95@prolan.hu>
 <aCWyXsJ2iRXRUmOi@finisterre.sirena.org.uk>
 <9d384301-3f73-4120-a82b-580eb5f1a4ed@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NxtmzHfUyS5BkEzS"
Content-Disposition: inline
In-Reply-To: <9d384301-3f73-4120-a82b-580eb5f1a4ed@prolan.hu>
X-Cookie: Well begun is half done.


--NxtmzHfUyS5BkEzS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 11:26:57AM +0200, Cs=F3k=E1s Bence wrote:
> On 2025. 05. 15. 11:22, Mark Brown wrote:

> > Wouldn't it be simpler for me to just apply both
> > patches at this point if there's no conflicts with the DMA tree?  We're
> > at -rc6 now...

> That also works for me. I should send 1/2 to you as well, correct?

I think at this point with the merge window likely to open on Sunday
it's probably easiest to just resend the SPI patch after the merge
window, it'll likely take more time/effort to work out what to do than
it will for the reset changes to land in Linus' tree.

--NxtmzHfUyS5BkEzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgltYAACgkQJNaLcl1U
h9BBaQf/Y2QB39oFyw1a8a615Yo/UKKHjc5SIVYLNpWPvaUCfqwEMIDB3TIb0cz3
3EfT+LI7v7qk0Fzz7n0f+t/zy6pPD2MjhO7Fd3KH1K+v7hmRmJMe7Nz9iaUM6OLQ
1A6p5SIr67X/AgQM4+whaAoR6ZWuRfNYv02Qg5b9jPF57Ih0YWym6x0HfwHJHUoC
nSpTAHjL3ZNlcNc5PprSsjXRo/i8rhbUWZ2+Lzkx5e0PsYILC5Tw2TZ/iHK0PjVz
5k5kroQd4xBiVLcWpBloLrH7zUOz7ti1rODFes28up/FStyALrKVzZj4nr3E9DiZ
XgFw3I8px7JESImWR9zH1H0C3rRtcA==
=tWy1
-----END PGP SIGNATURE-----

--NxtmzHfUyS5BkEzS--

