Return-Path: <dmaengine+bounces-5203-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F0FABC351
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B32189D40C
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D426286431;
	Mon, 19 May 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj6KqOS+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5321A38F9;
	Mon, 19 May 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670250; cv=none; b=p0DPntE2zVX2u9hh0ZHgwSnhPXP8C8b/7ZjdmTkiA1QxP+yMA/pzw6/H59ltu3qMla5BkKgDdeaXH4e0R0Qv8muLYB8XxWFSEXDlnVpYVP9+LAwLtH0GF0OV8UZ7uFCWK3TBPP/ciQH/Ki19fG+wJPcTwzM1FSYYf172KC5PBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670250; c=relaxed/simple;
	bh=VUzSHqjWRHEw8aOWm4K55qRWmHvDt0y25jCW53sFSaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvuSfGyblu2A+sbplci4Rmmv6PvbBgdWDQthFwaZpqVD9Op5iWG2wogNQOS2Rn0KkVb4+DRFE+qBGsEAYldDXAI9i0BA7h62NgvsSvrkj1zeRENrZcomezfeuSQWuU8yVdp1UhpNI4Qm8sDbS4erfSRpVn5JV1oCqSW+QDE30Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj6KqOS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5225CC4CEE4;
	Mon, 19 May 2025 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670250;
	bh=VUzSHqjWRHEw8aOWm4K55qRWmHvDt0y25jCW53sFSaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj6KqOS+YLK/A6KTIkPXUepkPrDauNFinWc15/s+AVkSF8qc8Zj2KQzylbVHaem3W
	 +IBXyR+bp1rMnJCEc6/PbTp84IuYihfA8uF9a6DcyyfUsD2FoeCErOr2OSzUHxrU+c
	 puZ3f1f0bq47U9Uu7ORjMWffPLePNZPZL9mZp0GxWoq1gdykbNiiSYrghC4celz0Tz
	 q17/evx2CtruU8U8CuyT4NnfCu7uwZKXprlqVR8hesbGXsOfvkOoggXMVumlpCHBvp
	 +eQiN2SNGfXGRlFCROnuABlF8jGWFamWpYeLtQbf8OvCrKZ3VZ1pEqkoVlLjeeU0iD
	 Lpa65m4MYEiLQ==
Date: Mon, 19 May 2025 16:57:21 +0100
From: Mark Brown <broonie@kernel.org>
To: nuno.sa@analog.com
Cc: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Mike Turquette <mturquette@linaro.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
Message-ID: <ee2cd70a-53d1-4693-bd79-966303177da6@sirena.org.uk>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
 <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdDeMOGITLcb8Xta"
Content-Disposition: inline
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
X-Cookie: We have ears, earther...FOUR OF THEM!


--qdDeMOGITLcb8Xta
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 04:41:08PM +0100, Nuno S=E1 via B4 Relay wrote:
> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.

Acked-by: Mark Brown <broonie@kernel.org>

--qdDeMOGITLcb8Xta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgrVOAACgkQJNaLcl1U
h9Dd3wf/cHFUuNwaFGNjWnYSDMN7dQksfI+rVKAFdOxYLQfhicIF2vdJ7gUOYQUB
f3diPdVJG2mU09JQtoOWAH3VOf50DQCPSgW+NDRLNhPA1wT4dmnZpS1hCIh7Jhg6
O3hZDUugRtY4BbhLxS2lUrzPaf5Jvtg03ibVoj5ONuFAJ7DxoGVnJ+gRlQe3ZJGK
QrQKgTZMOv+rONUNhsX25zcu6j5LEag4zcbwuuhC/IAGu0xOx5eDyTg/OUafYdlZ
ZSIj1LdiXfZpJYWun8U3MMjS1lUVTmrO/5N9QDZZJhvmX7Eykvjtdc1lQxChsifU
5gulW79p9Kbvl3ncHoZRu11Vp1EGnQ==
=tVIC
-----END PGP SIGNATURE-----

--qdDeMOGITLcb8Xta--

