Return-Path: <dmaengine+bounces-2425-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F1890EAF6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 14:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66681B247CB
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2024 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8393A145B09;
	Wed, 19 Jun 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="H5QlHj5b"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7D1411D5;
	Wed, 19 Jun 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799720; cv=none; b=bMKqoGXaWc2xujqXMozBxN7r0zHWqezhnClYFU3lbtq4oFroiuTsw3bP/uz0RnAv2RmcwApDp/17eYFC1bGduZa7o2qG09JnyuNNGsBTN7vUaj7Snh9bSDsFH349UlV8eqcRZudfdHtAiXIEJ38qtPHofy3Ke/Dd6Mf2ZTNpLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799720; c=relaxed/simple;
	bh=FVGqOE3wiRlvOnwpW+plbu90wTtSXAmdw/o00wdPQQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWeMMse9bid7nOt8X+XXbBwho5ejsFvmw5BrUU3afbrZdqyuVWhfc1rkYw1q7/RKwcJIIjCNIN8mu4679KUpIVugkXoN0NcNp3qSyJYb63mijWA3SLmvoSAcvTwuDKrVLGaHJF1xvDMhfG6KNhF+AgnCB9sUfZxydIB+Q3CfeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=H5QlHj5b; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718799717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FVGqOE3wiRlvOnwpW+plbu90wTtSXAmdw/o00wdPQQk=;
	b=H5QlHj5b47jmWWPmYrEyBk2CLjfodSkuNO3iFqDQL3q9TAKryupn+V75JTiH8WmGI/eIFy
	0Zjifr0r4dCWg3FWwIzaMp3bxyNBFP/hFECEP7HFZpj/jn85MK8NLAlzARSlcjHxvvWIqv
	zj3xrSSMAXdnhmkQLs0rsmnmfWLPh7o=
Message-ID: <15edbedcac80961ec9b7834041e54143657cd48b.camel@crapouillou.net>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
From: Paul Cercueil <paul@crapouillou.net>
To: Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linaro-mm-sig@lists.linaro.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
	 <rdunlap@infradead.org>
Date: Wed, 19 Jun 2024 14:21:55 +0200
In-Reply-To: <41fa9904-28a8-46fa-bf2a-014875409b83@web.de>
References: <202406191014.9JAzwRV6-lkp@intel.com>
	 <a4dd1d73-5af3-4d3d-8c0f-92dc439fa119@web.de>
	 <d452ecc4fc703a1f98aa4f243c6ded7fbfe54b0e.camel@crapouillou.net>
	 <cbcfb64a-e5c2-41a7-8847-227d4f6872de@web.de>
	 <e948cd137da8e4f97bfbf7ef68a5450476aeee0c.camel@crapouillou.net>
	 <41fa9904-28a8-46fa-bf2a-014875409b83@web.de>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFC
 qaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IWYXnd
 JO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN70
 62DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOt
 X0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEA
 AYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/
 Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmc
 Gu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2z
 McLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/
 7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2c
 LUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 19 juin 2024 =C3=A0 13:56 +0200, Markus Elfring a =C3=A9crit=C2=
=A0:
> =E2=80=A6
> > https://lore.kernel.org/linux-iio/219abc43b4fdd4a13b307ed2efaa0e6869e68=
e3f.camel@gmail.com/T/#eefd360069c4261aec9621fafde30924706571c94
> >=20
> > (and responses below)
> >=20
> > It's more nuanced than I remembered.
> =E2=80=A6
>=20
>=20
> > > * Will the desire grow for further collateral evolution according
> > > to
> > > =C2=A0 affected software components?
> >=20
> > Not sure what you mean by that.
>=20
> Advanced programming interfaces were added a while ago.
>=20
> Example:
> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h=
#L8
>=20
> Corresponding attempts for increasing API usage need to adapt to
> remaining change reluctance,
> don't they?

Sure, I guess.

But that does not change the fact that I cannot use cleanup.h magic in
this patchset, yet, as the required changes would have to be done in a
separate one.

Cheers,
-Paul

