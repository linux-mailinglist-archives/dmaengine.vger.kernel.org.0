Return-Path: <dmaengine+bounces-4424-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CAA3230C
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 11:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E8F1630A3
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581D2080FC;
	Wed, 12 Feb 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFknMvAY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E12080F6;
	Wed, 12 Feb 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354474; cv=none; b=fsDH8Mtd3CGj86o78dJ4AV6zfNZjNbWxF2K79YHSTUZs0ZK/Yc/GUA29NsI86w/v1RqQFE1g2dS/FO6/l1jh0NE57OwUHKzaKAAhFlDEse6o7+nVHfxMejTW9LHbtD/WcW7Janm9hARwXhTaG+l9daEroxy1qGYX6MPCAr/EUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354474; c=relaxed/simple;
	bh=woz7pk/+ngx1fAXXik33xpEwcwvHhgnlnzWIambURC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqbbygEtswuwWLAdOsBTKXOL5mps0yVibe9WZzhDnoB8uThGkh8bvCjfgCKSa+soPEM6jbkPuP8/Ph6vin1X4tCRUpZCvsx02Kv/WcnAxvsLyDXoriIw59tNjdT4ewehsIug7M7zKb8iaL5/444vL7AtIuKTXdknA0mnIr3GtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFknMvAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373AEC4CEDF;
	Wed, 12 Feb 2025 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739354473;
	bh=woz7pk/+ngx1fAXXik33xpEwcwvHhgnlnzWIambURC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFknMvAYCwTyrVf3OxL2gYhdX1gCloKqAmyPXLmtzPDsbcRVkduTdz/DV5ooCn6B8
	 4+t2DpEMJiVVr1HQy/UiPXnSvdRjYZe/W+HkI0ERWJH1/abm0dKszP95sM9O6UTc7F
	 cLOzYQhgS2NJc9exC2em9aL/Mx1QYAwOIbY8AESaYkLTGqh4r4i4tds7+BKUhmiddw
	 rV8PgQzg43sxTHsHorGuUbkQHjEZkYtDbHRc+gM3WRI8ALQ9y2UmKa7xUpmV7xI6eF
	 3dF5FTcTfKWbuXXv91blHqqWPM6YquxAfS0ysnR7v22PRyei45Pal7UpfLtSsX8Q6B
	 eI9d4Ema9btyQ==
Date: Wed, 12 Feb 2025 11:01:11 +0100
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
Message-ID: <20250212-naughty-chipmunk-of-potency-7e0ced@houat>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
 <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
 <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
 <b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
 <fae8df2a-3e47-4266-aace-392c5f37581f@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="uxrfo3idfywaw7zh"
Content-Disposition: inline
In-Reply-To: <fae8df2a-3e47-4266-aace-392c5f37581f@arm.com>


--uxrfo3idfywaw7zh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 09:49:56AM +0000, Florent Tomasin wrote:
> Note that the CMA patches were initially shared to help reproduce my
> environment of development, I can isolate them in a separate patch
> series and include a reference or "base-commit:" tag to it in the
> Panthor protected mode RFC, to help progress this review in another
> thread. It will avoid overlapping these two topics:
>=20
> - Multiple standalone CMA heaps support
> - Panthor protected mode handling

You keep insisting on using CMA here, but it's really not clear to me
why you would need CMA in the first place.

By CMA, do you mean the CMA allocator, and thus would provide buffers
through the usual dma_alloc_* API, or would any allocator providing
physically contiguous memory work?

In the latter case, would something like this work:
https://lore.kernel.org/all/20240515-dma-buf-ecc-heap-v1-1-54cbbd049511@ker=
nel.org/

Maxime

--uxrfo3idfywaw7zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6xxYgAKCRAnX84Zoj2+
doOXAYCmJnHBgdesgUZVquuWr6GPMIwXNegsF2kF9WE8cUf8QZREQljZMta1yPl+
Y3KyEfEBf2GAaLjFhJfdk0/CAvLXAP/kO5oVGERfJbRdGvpysS+9JiElAhrVFTWR
1Zzqx2VRSg==
=Jh+j
-----END PGP SIGNATURE-----

--uxrfo3idfywaw7zh--

