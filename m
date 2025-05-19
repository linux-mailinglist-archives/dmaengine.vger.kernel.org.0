Return-Path: <dmaengine+bounces-5206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39EABC47B
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4666D1711B7
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 16:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB232874EF;
	Mon, 19 May 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1SINi+u"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA0286D79;
	Mon, 19 May 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672132; cv=none; b=olzH3PrTp2QeVujPMITuoSIcT33FSEBuqhHSqJrilbe3hACcs7OvwYlJS5uPk9sB/4aW+JgbwBWHZgcpqOci4pByT4mWz6aluiwLnQVUqFMtI5FxqEzK6Fdqx7mS5TC9A93Kf0EdoxKYcJ9HkoU5B8pdV/8YoODX6nQU4iy7Lus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672132; c=relaxed/simple;
	bh=33cTvU1qBUdJ2kbCQM2qxSf1F+IUciULteXqEWFXPyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfDtgnGo4SvMAmzpqhOpqpNIipDqU1mVxqDnoLzIUah7qvoRuzcpwR24ZWPBSqiXaMZuLUmNSXX6voJILd+96eLXDCsvkp+XlL0p69LG5dAWWElxP4igmAl9JJP7cziQ4+k8GVpo4gzSCU+UBPZQSQniG1TwxFus3eWqSj6iAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1SINi+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E349AC4CEE4;
	Mon, 19 May 2025 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747672131;
	bh=33cTvU1qBUdJ2kbCQM2qxSf1F+IUciULteXqEWFXPyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1SINi+ujtraVCf67Fj/+P1foxwZZ1nad1P/kJA/kyAfgXGcQiMWQ40cvyhGuG9C3
	 kB9+98tVsy2sG2EH2OGVU+r6xuxeqfhDfB/3+rSyn9VnnaVQLDtOsaOzlABiUkwAPW
	 0VXoq3EXPtGEnCBeO5tEiXghea7QG3+M+656FtmI0A0N6RKrFRN/0ehXEjqZLTCjtp
	 iACApKGzUdQwr//FlFXAvSfCAANYGwDmGt8824jyGoANL/4F+e+iRB5bzbOvs6aT+C
	 wYdk8SF6ojVeVXC2Wwgv3GhpTDTaOOqLfSicnLNcKeWq6EU/z4/rtCZzpk3vFBN7tO
	 0jNzRdoySTnMA==
Date: Mon, 19 May 2025 18:28:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
	Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
Message-ID: <gneof3jin55orfncvexyjtj2a2bdcvks6hxuaf4ovqbm6jcl42@kcohbvsi2zmc>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
 <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qc7wyrddxi24dmdp"
Content-Disposition: inline
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>


--qc7wyrddxi24dmdp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
MIME-Version: 1.0

On Mon, May 19, 2025 at 04:41:08PM +0100, Nuno S=E1 via B4 Relay wrote:
> ...
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-

There is nothing scheduled on my side for that driver and the change
looks as expected.

Take my

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

to get it applied to whatever tree that series will be merged through
(clk?).

Best regards
Uwe

--qc7wyrddxi24dmdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgrXD0ACgkQj4D7WH0S
/k5bXwf/cJD2ZIBr/eC/DLRua6Dq8h+RlZnDSQh1lehylLta85o6E8oYlHQEZ240
2lvD0KSsJzcqbMyIKp39Kw+sXNZ6Y737QlYDTkGgKV35JNPfQeEv0GwJrfpGI7vO
eyxcWys1iV9qbfTb9zAXVdSKU31iGb/sFW2NIOjOcQFLejMnDtFGDpQAmaeILc2B
Knb8t+KEHMnXTD6FI9f/+YZUX4Bg4FZ6EtLhQqWS2oGu2W4naVpqHdVapeNh4ZVF
LzTSUKF4ljtL8demEJW4eXSzaD3eYlfYSMThAwocQFUqbs8bttRb+Q1XQwpLIEH9
l+6sHZcXJ1Q42rpKqAfhyeh0aU650g==
=BfpI
-----END PGP SIGNATURE-----

--qc7wyrddxi24dmdp--

