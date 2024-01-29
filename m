Return-Path: <dmaengine+bounces-848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241D8407F2
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC361F21561
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811D65BAC;
	Mon, 29 Jan 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="d1tm4uHv"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7146311F;
	Mon, 29 Jan 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537715; cv=none; b=ofMexdIUqJEOB4Z1UivvQ+0TfeBduGUJl6YB+PeSLZ18E36z1IXGLEpzBraSi7Al5TxdpKj9sbypUdSCHqS5hrok/i9FM7FZ4BvMoVoG82idtQ843qlNQpVbDCbfN/s0UT4DaFfY8PbWvAJWpx4976NDszHGvHwF6A6KhA2B0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537715; c=relaxed/simple;
	bh=joKOcQVzaGp+Eqm7uU448Qn7y9ce+cvNOf58xf3Uhm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2St8h65daslB803RKO/ayq9KTslJORirwNofk/OngkeasLdFZvHQZyTOopL6CDKHaM0DqDsqwL+n4Fo1FNSR656Lh6hopFtcKpCF2SDB2h6Um4XdTaBUgxQD+96PuixFXSt/aqaNXz6oe9q+XSUzPPWTAQ2eZwvhz5Y7O9BMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=d1tm4uHv; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706537710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pgidmgFeP0tk17gjD21+VDw69unAjkitiIzLDu66t2o=;
	b=d1tm4uHvLjI5geAdOzhvTRgdZIr1L3eaCvN8jfDMVBENQ99GYSV5EcCEqcQrqH6LHIAL++
	nfkRyyMWSUxnJPc+ogGTV6ArelezJ5g0QkZNbSG65vKXOClj6W+zGQdglXaZKVovqwiA1A
	GslGn9EBvHWlk2dR9BvhuZ0iweu8854=
Message-ID: <f676839ba47eefe7c33d3f46f4517fbdb1d01c7a.camel@crapouillou.net>
Subject: Re: [PATCH v5 5/8] iio: core: Add new DMABUF interface
 infrastructure
From: Paul Cercueil <paul@crapouillou.net>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Vinod Koul <vkoul@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org,  dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nuno =?ISO-8859-1?Q?S=E1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>
Date: Mon, 29 Jan 2024 15:15:08 +0100
In-Reply-To: <fb4bcbefcfd0ab1982172c780ce5c5f1e96ae798.camel@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	 <20231219175009.65482-6-paul@crapouillou.net>
	 <20231221120624.7bcdc302@jic23-huawei>
	 <ee5d7bb2fb3e74e8fc621d745b23d1858e1f0c3c.camel@crapouillou.net>
	 <20240127165044.22f1b329@jic23-huawei>
	 <d6bef39c-f940-4097-8ca3-0cf4ef89a743@amd.com>
	 <aac82ce15a49c5e4b939a69229b9a8a51ca00f5d.camel@crapouillou.net>
	 <8fc55451-dfd7-4d09-8051-8b39048f85e2@amd.com>
	 <fb4bcbefcfd0ab1982172c780ce5c5f1e96ae798.camel@crapouillou.net>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 29 janvier 2024 =C3=A0 14:32 +0100, Paul Cercueil a =C3=A9crit=C2=
=A0:
> Le lundi 29 janvier 2024 =C3=A0 14:17 +0100, Christian K=C3=B6nig a =C3=
=A9crit=C2=A0:
> > Am 29.01.24 um 14:06 schrieb Paul Cercueil:
> > > Hi Christian,
> > >=20
> > > Le lundi 29 janvier 2024 =C3=A0 13:52 +0100, Christian K=C3=B6nig a =
=C3=A9crit=C2=A0:
> > > > Am 27.01.24 um 17:50 schrieb Jonathan Cameron:
> > > > > > > > +	iio_buffer_dmabuf_put(attach);
> > > > > > > > +
> > > > > > > > +out_dmabuf_put:
> > > > > > > > +	dma_buf_put(dmabuf);
> > > > > > > As below. Feels like a __free(dma_buf_put) bit of magic
> > > > > > > would
> > > > > > > be a
> > > > > > > nice to have.
> > > > > > I'm working on the patches right now, just one quick
> > > > > > question.
> > > > > >=20
> > > > > > Having a __free(dma_buf_put) requires that dma_buf_put is
> > > > > > first
> > > > > > "registered" as a freeing function using DEFINE_FREE() in
> > > > > > <linux/dma-
> > > > > > buf.h>, which has not been done yet.
> > > > > >=20
> > > > > > That would mean carrying a dma-buf specific patch in your
> > > > > > tree,
> > > > > > are you
> > > > > > OK with that?
> > > > > Needs an ACK from appropriate maintainer, but otherwise I'm
> > > > > fine
> > > > > doing
> > > > > so.=C2=A0 Alternative is to circle back to this later after this
> > > > > code is
> > > > > upstream.
> > > > Separate patches for that please, the autocleanup feature is so
> > > > new
> > > > that
> > > > I'm not 100% convinced that everything works out smoothly from
> > > > the
> > > > start.
> > > Separate patches is a given, did you mean outside this patchset?
> > > Because I can send a separate patchset that introduces scope-
> > > based
> > > management for dma_fence and dma_buf, but then it won't have
> > > users.
> >=20
> > Outside of the patchset, this is essentially brand new stuff.
> >=20
> > IIRC we have quite a number of dma_fence selftests and sw_sync
> > which
> > is=20
> > basically code inside the drivers/dma-buf directory only there for=20
> > testing DMA-buf functionality.
> >=20
> > Convert those over as well and I'm more than happy to upstream this
> > change.
>=20
> Well there is very little to convert there; you can use scope-based
> management when the unref is done in all exit points of the
> functional
> block, and the only place I could find that does that in drivers/dma-
> buf/ was in dma_fence_chain_enable_signaling() in dma-fence-chain.c.

Actually - not even that, since it doesn't call dma_fence_get() and
dma_fence_put() on the same fence.

So I cannot use it anywhere in drivers/dma-buf/.

-Paul

