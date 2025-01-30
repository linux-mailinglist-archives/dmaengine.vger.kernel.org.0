Return-Path: <dmaengine+bounces-4234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA563A22E16
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F62C7A37D8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8591E47B4;
	Thu, 30 Jan 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVevpFFh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBD1E3775;
	Thu, 30 Jan 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244822; cv=none; b=CPUvJpUDxrT+gxN5maHgGZGOSkex02AcwT6glDSHYZjFOSElACHZlMbMjv6nllMLCwMVKce57uYPSG5KovP2/401jK47O2EspZ6pMbl3plFSewWrEix4a5b9CnxjPuq+3wJHbMaNij5cHGxbtzxzRcGABkgX0j4xix6kbUBZbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244822; c=relaxed/simple;
	bh=1HcMWa+Krm0evLloVfTaMDioU4vbaxg54rfXDQtmf5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz++xmmUJOYU0kXBwqe9AXFuiF/uzRGo+/Gq4+IljuGFdJzbBXc/oLMAxKuhks5GzZciL/4oO+rGrU/BQeOsQ9te80B4WNc5J9pyNphVRgPczf05Vso/CEyhgm6/J/e3txZPg+mdGch+pWIq7b83nnfP1bKMKVGupFAJRfGXddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVevpFFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC69DC4CED2;
	Thu, 30 Jan 2025 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738244821;
	bh=1HcMWa+Krm0evLloVfTaMDioU4vbaxg54rfXDQtmf5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVevpFFhICWy5gdtLgxOYly145CXHa5QtjLlFolUZN+6Efeki+9DKjDK0k9iHYnZt
	 HTmak8Jk9KLr+REnfRqTz1TBJ6KIXUaXNYWY5rDo56lLO0k8IqwGpTbyxy6fBnir23
	 ql5N7/J69pa99ob9XyApcvDrxaIv+4jixqjLJyLgK6yRTKYcmr1U7yuKkkXDmTi3ap
	 J0eiKCsuxxZxlhqs3/ByKvITUC6Mmd4yrPtMCJAua+9IfntoHx0/3K5NiG8s1bZiFx
	 4czILs0mdAHc9YVe9nglJKrrI3UsXriubNyT9XtI9MVCYRwvoyVn1rgISbaqaMT9zb
	 yERv6witqaUiQ==
Date: Thu, 30 Jan 2025 14:46:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Florent Tomasin <florent.tomasin@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, nd@arm.com, 
	Akash Goel <akash.goel@arm.com>
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
Message-ID: <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
References: <cover.1738228114.git.florent.tomasin@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="34o7hfemb7lyu5o2"
Content-Disposition: inline
In-Reply-To: <cover.1738228114.git.florent.tomasin@arm.com>


--34o7hfemb7lyu5o2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
MIME-Version: 1.0

Hi,

I started to review it, but it's probably best to discuss it here.

On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wrote:
> Hi,
>=20
> This is a patch series covering the support for protected mode execution =
in
> Mali Panthor CSF kernel driver.
>=20
> The Mali CSF GPUs come with the support for protected mode execution at t=
he
> HW level. This feature requires two main changes in the kernel driver:
>=20
> 1) Configure the GPU with a protected buffer. The system must provide a D=
MA
>    heap from which the driver can allocate a protected buffer.
>    It can be a carved-out memory or dynamically allocated protected memor=
y region.
>    Some system includes a trusted FW which is in charge of the protected =
memory.
>    Since this problem is integration specific, the Mali Panthor CSF kernel
>    driver must import the protected memory from a device specific exporte=
r.

Why do you need a heap for it in the first place? My understanding of
your series is that you have a carved out memory region somewhere, and
you want to allocate from that carved out memory region your buffers.

How is that any different from using a reserved-memory region, adding
the reserved-memory property to the GPU device and doing all your
allocation through the usual dma_alloc_* API?

Or do you expect to have another dma-buf heap that would call into the
firmware to perform the allocations?

The semantics of the CMA heap allocations is a concern too.

Another question is how would you expect something like a secure
video-playback pipeline to operate with that kind of interface. Assuming
you have a secure codec, you would likely get that protected buffer from
the codec, right? So the most likely scenario would be to then import
that dma-buf into the GPU driver, but not allocate the buffer from it.

Overall, I think a better abstraction would be to have a heap indeed to
allocate your protected buffers from, and then import them in the
devices that need them. The responsibility would be on the userspace to
do so, but it already kind of does with your design anyway.

Maxime

--34o7hfemb7lyu5o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5uC0QAKCRAnX84Zoj2+
dkA4AYDYrS5bk2TFxito0yjOXO6So47lFz5UzaXuosDfn5WUytk/shyJlNgqK8Qe
ytvE2GkBgNtOW+4ZQtCmW9i1X2peM2q+jrrnhD6soQun0iSdlrVLjvNIXKHT4ViO
p7LJbwkZTQ==
=pw8X
-----END PGP SIGNATURE-----

--34o7hfemb7lyu5o2--

