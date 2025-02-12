Return-Path: <dmaengine+bounces-4427-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1EA323D7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DF4188A2B0
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF3208978;
	Wed, 12 Feb 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsCk99ec"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9D2AF19;
	Wed, 12 Feb 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357377; cv=none; b=f364/g94c7WFYrTgkCyQjaYjOnC/+6xbx8C0R2ccajUHL1U0cBzC4SPb2hMAgp4uxSPmAYHhtD9FFQem9K1nBQIBJxSzZctW8IeZvCSXC5+nWBoYjXzCX0bRT6AUgGn8Rewirf2/j/i7aLKJ99l+yzN1ycY8YE1u/haGMVeAJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357377; c=relaxed/simple;
	bh=SrZ7q3UddXW1p49/GdRvgpUzejtlAUiY6e9x0tcKinE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+q4+hvyrftlj3ARhQAJrH9LRybl7B2WkTVVkrl0lqNlUYuB+40DyVMGzt7FYHfzCbiXeNhrdLPpBdZ4zrpzmx00xXe7350ll34veVmDadslLsc21ZEJSi6G7AFYxjvAI/nH/lT+lo9C7s4VaHIp1z66COBE+J1LEPHONsRNLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsCk99ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01860C4CEDF;
	Wed, 12 Feb 2025 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739357376;
	bh=SrZ7q3UddXW1p49/GdRvgpUzejtlAUiY6e9x0tcKinE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsCk99ecgG1X1H4oCmDUZgnbAUfRIvj8fWtdlwdoQ07gzWE7fmKGgOCFbXT8zxU8z
	 E17uZ/CKSWTiBSsXf6Z6vZWKYpqlNlcKGIyrhcObTMnI1Vs8SOuMqX9285cpyLhl3h
	 i4BACZrSu2IrhvuCBWekSlYRZzO3qid0P9Ajy4xYJi/PyBLZ+A2HVA8MjrFX049Kga
	 aC8profD5qguMrsDfEYi5k14CfG/ZS5ZwDrn1/hjq/RJX6KfdiM3+g5V+nuBxEflNE
	 BuOxNawNPtWooUTQhU4pS84J5mQd1EBbum7ylQPZiEkomLW6MNCo51OZTDyrBZ+Ri7
	 Mh4FqItv9flOg==
Date: Wed, 12 Feb 2025 11:49:34 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Florent Tomasin <florent.tomasin@arm.com>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, nd@arm.com, 
	Akash Goel <akash.goel@arm.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Message-ID: <20250212-sweet-nano-penguin-e85e7d@houat>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
 <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
 <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
 <b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
 <fae8df2a-3e47-4266-aace-392c5f37581f@arm.com>
 <20250212-naughty-chipmunk-of-potency-7e0ced@houat>
 <8ee8e684-0164-4e70-b42e-3827c7885685@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hofcel2epznouj7x"
Content-Disposition: inline
In-Reply-To: <8ee8e684-0164-4e70-b42e-3827c7885685@arm.com>


--hofcel2epznouj7x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 10:29:32AM +0000, Florent Tomasin wrote:
>=20
>=20
> On 12/02/2025 10:01, Maxime Ripard wrote:
> > On Wed, Feb 12, 2025 at 09:49:56AM +0000, Florent Tomasin wrote:
> >> Note that the CMA patches were initially shared to help reproduce my
> >> environment of development, I can isolate them in a separate patch
> >> series and include a reference or "base-commit:" tag to it in the
> >> Panthor protected mode RFC, to help progress this review in another
> >> thread. It will avoid overlapping these two topics:
> >>
> >> - Multiple standalone CMA heaps support
> >> - Panthor protected mode handling
> >=20
> > You keep insisting on using CMA here, but it's really not clear to me
> > why you would need CMA in the first place.
> >=20
> > By CMA, do you mean the CMA allocator, and thus would provide buffers
> > through the usual dma_alloc_* API, or would any allocator providing
> > physically contiguous memory work?
>=20
> You are correct only the CMA allocator is relevant. I needed a way to
> sub-allocate from a carved-out memory.

I'm still confused, sorry. You're saying that you require CMA but...

> > In the latter case, would something like this work:
> > https://lore.kernel.org/all/20240515-dma-buf-ecc-heap-v1-1-54cbbd049511=
@kernel.org/
>=20
> Thanks for sharing this link, I was not aware previous work was done
> on this aspect. The new carveout heap introduced in the series could
> probably be a good alternative. I will play-around with it and share
> some updates.

=2E.. you seem to be ok with a driver that doesn't use it?

Maxime

--hofcel2epznouj7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6x8uQAKCRAnX84Zoj2+
dhpNAX9dpZ7jCHWS9XEKQqdeu+k8bL1z43DeFaKsONHamJEssyPacY4cU20LNyHZ
dE3EP2gBfigcyv0UGOHYi7iyKQFw7lfvXnKfZ2/xUjJoWzSqoXVjjOm3bVKTr4WT
bTbtf2LYNw==
=IIBH
-----END PGP SIGNATURE-----

--hofcel2epznouj7x--

