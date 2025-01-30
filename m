Return-Path: <dmaengine+bounces-4237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5DA23204
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B22716363F
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9D1EBA19;
	Thu, 30 Jan 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw08cHJ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1A1E9918;
	Thu, 30 Jan 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255113; cv=none; b=eVhkl6gZ2d70MlueZYAJWC1Gjg79/zADEfyAoLPZj8xB3e35n2rVpudcvg3/Ov5q1CqpIgC9zvaov9VClnOLXd2tnnu5jwGgv/8JWE7+8di6DSn5fu5zqz1UpNXM4VJ3C48jYa8aCYFFHzj9b9WZPMDi97vXuUyghb5qNxO0OYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255113; c=relaxed/simple;
	bh=rL0sztCP+uUFRfh2eiDMbMSqe47y8cNW75kdLaMZy6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgLSG1qAEmyrIUoXiAvhYdTf1mUthY243z8vlL58VsnSxsv1nD3VG01F+WMOC7fep9nMpW6Z+FL4b2YiEUANQkKkg2Ws+khEZ1y7nJ+Vlqy000yrrOCechDpWWbWDrilsGcu+8UKsS7udvfCYIuuIQNnE1G25l6gn7K5a/5Bcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw08cHJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36384C4CED2;
	Thu, 30 Jan 2025 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738255112;
	bh=rL0sztCP+uUFRfh2eiDMbMSqe47y8cNW75kdLaMZy6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw08cHJ2aoBWJ+IETboYHto71wnX+ITXFMGHOEzPklbEm+pnyZNHbkN9q746wggvg
	 pG5Db377lcrP8PdiA0R9/JFkUfWxhoF+8ABqNjmlyX5PK/P9sgFF4cssO25dnbkb/q
	 kb2L8+iKo07FrGNfa5/uq3UnnD4WOS/GCZlodeWi372pMYcMxlJS8HdxkNMHNtQzWL
	 p/3GfGiCxHNcN27Ym7lum86Aw4xonzm4VuJYbFlmC/LoIaAa1YWRrK/H9wE9Lmzdvx
	 Y6TB5qdiEFP4VS/2R/YG0qhMhHjssBzTLzhc6505HOLCHrijhkYg0MYP6/wPIMoVhU
	 LA4FYb3l7ejdg==
Date: Thu, 30 Jan 2025 17:38:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Florent Tomasin <florent.tomasin@arm.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
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
Message-ID: <ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
 <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7thzhib5zt2dlqzi"
Content-Disposition: inline
In-Reply-To: <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>


--7thzhib5zt2dlqzi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
MIME-Version: 1.0

Hi Nicolas,

On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrote:
> Le jeudi 30 janvier 2025 =E0 14:46 +0100, Maxime Ripard a =E9crit=A0:
> > Hi,
> >=20
> > I started to review it, but it's probably best to discuss it here.
> >=20
> > On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wrote:
> > > Hi,
> > >=20
> > > This is a patch series covering the support for protected mode execut=
ion in
> > > Mali Panthor CSF kernel driver.
> > >=20
> > > The Mali CSF GPUs come with the support for protected mode execution =
at the
> > > HW level. This feature requires two main changes in the kernel driver:
> > >=20
> > > 1) Configure the GPU with a protected buffer. The system must provide=
 a DMA
> > >    heap from which the driver can allocate a protected buffer.
> > >    It can be a carved-out memory or dynamically allocated protected m=
emory region.
> > >    Some system includes a trusted FW which is in charge of the protec=
ted memory.
> > >    Since this problem is integration specific, the Mali Panthor CSF k=
ernel
> > >    driver must import the protected memory from a device specific exp=
orter.
> >=20
> > Why do you need a heap for it in the first place? My understanding of
> > your series is that you have a carved out memory region somewhere, and
> > you want to allocate from that carved out memory region your buffers.
> >=20
> > How is that any different from using a reserved-memory region, adding
> > the reserved-memory property to the GPU device and doing all your
> > allocation through the usual dma_alloc_* API?
>=20
> How do you then multiplex this region so it can be shared between
> GPU/Camera/Display/Codec drivers and also userspace ?

You could point all the devices to the same reserved memory region, and
they would all allocate from there, including for their userspace-facing
allocations.

> Also, how the secure memory is allocted / obtained is a process that
> can vary a lot between SoC, so implementation details assumption
> should not be coded in the driver.

But yeah, we agree there, it's also the point I was trying to make :)

Maxime

--7thzhib5zt2dlqzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ5urAAAKCRAnX84Zoj2+
drkxAYDhYMdCMRvVHsxuLWqll6NhSpmIh8E41iqDapuJU/CzgZsEjwmhO6YYeg3A
2+EGrI8BgJd5IXr28mAs79h3kSGwjcbdvd2Dt6UIrNjBeLUprzQsspQVlCb01M+1
D+t8k0aXog==
=tDkf
-----END PGP SIGNATURE-----

--7thzhib5zt2dlqzi--

