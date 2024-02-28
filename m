Return-Path: <dmaengine+bounces-1162-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674A86B983
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56A628D781
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298978625A;
	Wed, 28 Feb 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOmdFSNz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC678624E;
	Wed, 28 Feb 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154025; cv=none; b=QnVPO9XCgLCBVyuUaZa28jkJ7CTjTzAxct2rCT76s0VbRBZXJ5PQ4lL4eSKucmvVc9EWe0qy6S88RkwSsHnq/HGsu/YRwO7jEUCfLeXiP34TQcjotR/bRzulaUXGfZ2esrRVLhlR9Fv5w42mUYwJBIafOocpXwxu+W/dSQ5CSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154025; c=relaxed/simple;
	bh=FcwKp/UWdTffbXRIcOsOFOR+78otSCOswrhWTwcAlqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPVygE+TqRRXlnLF+CEO3p0ZWjl8KZ4eCI0T28ccawYP7IucbXhM6vEgaxlw95m8E066LE0CFXrzUCZdyOnlQaxfXnRujqZdMBMazlu6n7SuwubMpFpKw1CjB+JOkBfGNxQJ/4fZsYpwKdFzH8i6DWZ7J+cySwwWFdCBeF9iY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOmdFSNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C66BC433C7;
	Wed, 28 Feb 2024 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709154024;
	bh=FcwKp/UWdTffbXRIcOsOFOR+78otSCOswrhWTwcAlqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOmdFSNzkPCQQ/4whocnsxMjSbyb5JDdYRP7Jg8kc7MJkj0p5cRb0zU5RK+PgDIea
	 GQrhmgA2zDrfh9DXu/qbepiNOpl5R5GreAJngS02tMorgpal9PJUM65LkQ5peBav0L
	 AQyJGfiuo2EnjLlUC0kimaH156Tj4h4aGlreZEb3leS+19tLz6gNstAwUyLr0CwBj4
	 wn8FAAQ6vQqdqfAcjn+QWoQhCCSVOxEyYskfYa62p0Q2VOWci8Nuu6IVG0XOicBA/1
	 0kFjgCI+uobLjUxZCmwDCQwsJnpaZQuVyvBX+Y+/X+fIL5tKHUkEDcLwW8J8V6UV/D
	 o7iavPnxhqXAQ==
Date: Wed, 28 Feb 2024 21:00:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 6/8] spi: Use new helpers from overflow.h in
 __spi_alloc_controller()
Message-ID: <d2ba1ccf-b22c-4939-823f-5298d5d8a15b@sirena.org.uk>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-7-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gk1BrI7DkkgarVoc"
Content-Disposition: inline
In-Reply-To: <20240228204919.3680786-7-andriy.shevchenko@linux.intel.com>
X-Cookie: Function reject.


--gk1BrI7DkkgarVoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 10:41:36PM +0200, Andy Shevchenko wrote:
> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in __spi_alloc_controller(). Do it so.

Acked-by: Mark Brown <broonie@kernel.org>

--gk1BrI7DkkgarVoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfnt0ACgkQJNaLcl1U
h9BgOAf9FI0recmC0vWAsLHdxnLZ3bOgqWYIL5B3T4mtMG3GuQr3YG2DvaTxsw/L
QhLkb+GOuSatBmvkPsVFx0FWtvVpf94puDaIWZv0vlC8jVwGRnBfTx2GkQUhfcrJ
QwC4yAe6uoYffFT1QKi6ciibDmkz0h/PfgQ1lP6Dkrz1tySzwziI1wsuq6fGyKwW
fHw7LZfoevfiaH4x9u2ByukwqGhDXhASRx+H8O9ujAU2j80ZTpUCHLjWF9XzqcLz
2OZZzA0huTOd7AggXRnzRQ0CrQDa4JqcLrT15hxwfQX9pqDi+ewLmnfANzKUeeC4
5AoTzSsw2gEuPX3Rz04M1o5pIEXRYw==
=2YDc
-----END PGP SIGNATURE-----

--gk1BrI7DkkgarVoc--

