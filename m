Return-Path: <dmaengine+bounces-6672-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367CAB8E507
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33F93BCD37
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C528C011;
	Sun, 21 Sep 2025 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm+7yGVK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3135965;
	Sun, 21 Sep 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486099; cv=none; b=GKDXCaECrEMq3XlAhIO02x9rjhT0KA0zE8QjrHcF9taQ5fZBZo28yaE2wSRSESWPZPdyBfMxH8bB3bwSxR7sxF2G5rEEHAk2OKTMQzySXgY5Wg1naJ3BcREKD4mHR0miYrwj7rhSqhm55isdSlHe3+Xw78rqHChQBCRFVK13Udc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486099; c=relaxed/simple;
	bh=bstEZ3MlozQwIr0qi9vp4rP/dEmgLKuVJDPIe2c54w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXdHInyQP97zwRKev452Eh8ieHqt6XQzK1Wb2Gq9MpU7ZC9L7bcJZ0QX03mdAlX4kAmfRFVYGZIo/wBkkhIp0OCBcjvSfWz5MMwTTCPwDIfP4yDPqaTJuyZVI9KBmBs7TZDZRGtTVpmUs87VaNiA7xp/DjO3Xm6GNmAd4KuyOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm+7yGVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ABDC4CEE7;
	Sun, 21 Sep 2025 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758486098;
	bh=bstEZ3MlozQwIr0qi9vp4rP/dEmgLKuVJDPIe2c54w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm+7yGVKVTF+lnHcl8xWL7Mxp5PWJgukZe4RAMz5nMDHick/Vwp/j+4eduQXSaPBI
	 5hw+6RvKFMyJGQTyP1MNeC4AMKdI+ynm2UhGToJn+3YJf8OTJLjlgmDm3tWS9RqlBK
	 l6mv/CoXHrTePmcZ8xC8E+5Pf0QQftA7zPtOFS51QDC7h6KtC5Oi0f5J1fjQdg3kT0
	 d8jlvGF4B5er8Rh+QAPgK3glnvMPHwKHOCcAHytbLuTzL9zav+2sfnoRgVmfzS2Yr8
	 O3OXZek7SR5Gtc4QeLlq3qMsjGR+utv3/D14FPlNOIcWYLv+Zy53cvZnU/7YxeONDd
	 oHb3Gnnl4gWJw==
Date: Sun, 21 Sep 2025 22:21:35 +0200
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
Subject: Re: [PATCH RESEND v7 3/7] include: linux: move adi-axi-common.h out
 of fpga
Message-ID: <vxbmatzbecktgppfexpdam4plwvynu4mzimtqbrzikeaxwjdfs@pyk3j4mmgjls>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
 <20250627-dev-axi-clkgen-limits-v7-3-e4f3b1f76189@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qyi5knjwltel7rd5"
Content-Disposition: inline
In-Reply-To: <20250627-dev-axi-clkgen-limits-v7-3-e4f3b1f76189@analog.com>


--qyi5knjwltel7rd5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v7 3/7] include: linux: move adi-axi-common.h out
 of fpga
MIME-Version: 1.0

Hello,

On Fri, Jun 27, 2025 at 03:59:12PM +0100, Nuno S=E1 via B4 Relay wrote:
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-

Assuming this will go through some other tree than PWM:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--qyi5knjwltel7rd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjQXksACgkQj4D7WH0S
/k5ueQgAgYcvo6IUp2+PMkmWCwM2DQDxPkieRxywvN1Ze7NM6pC3wo9sU19sxYTU
UL8SLVlOE1CZQ5Z04cwp7upDXKH5sagjnZSH/w0eovHyEethV2lZUoyvQdaHudl/
+s18xlBrfiGjT1ZMvbpy8IIJUoTXI0Aznrs6M71a8nhFfFRxr6JtC/yOoohUp30L
7m3YaJvBmCaGeCVfS3PLlPxEl9oTng9PYu0X3Bx83c6iIaB75u7XuFSAKucadlT2
sY3mQ+WmgAWjMXkkY9mPgKgdjxJohDbxzz5JpB71VYppT6v8Usg7P9Dnh8TGt+bY
KtbslkMXXVK70XJjmhSXnpeBn7gsTg==
=YEhB
-----END PGP SIGNATURE-----

--qyi5knjwltel7rd5--

