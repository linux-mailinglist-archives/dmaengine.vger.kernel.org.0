Return-Path: <dmaengine+bounces-4302-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD7A29284
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37F43AB552
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D01A83F9;
	Wed,  5 Feb 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvScG1w8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2BDF71;
	Wed,  5 Feb 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767155; cv=none; b=nNbGIOfBuEQnbaUIiW3eRMRkiSEt01bYX0PR+lZ3Z9tyFezXCl4scwhekwGS7RC+CoudqE40Kr5qyldj0h9yV3ex0f2ygBV3S8lL8R6jBt4GgRaIEn6CE1FwIIbQH0DhdVn/i1ZLq6aWFdcSPRXRtXl+4cHQy/2GGbvRKX6oHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767155; c=relaxed/simple;
	bh=fKO+KfI5PoBjPM7OHhzkdtchZan6XyDHTFGvgKnrJtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGWriCEitUuAXF9p3NK8bhSERWeAbwBqGy+KyGgrz/RWJ9B5vzeIHUhyt5MaoMLsyTLaBOHOpmEwra95tCwml1RufizSTT7/6tYsNLq7gPsoJOBRy70VUlKK2S7gv+GZFaAD4l72M4VotJ7HSsFdXUy/I+z35OTG6SPfZV6skCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvScG1w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9B9C4CED6;
	Wed,  5 Feb 2025 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738767154;
	bh=fKO+KfI5PoBjPM7OHhzkdtchZan6XyDHTFGvgKnrJtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvScG1w8c3lzvGdrKEfNltQnZPVFiv8WkOrq6iQNZzqSB8LNBMhAQFovae2gi0eUa
	 3nbDFeW3BaLJiiAbivLtI77/J/4q2K/ORqjOSIIgcv5dSvxrobYjZKJfIdGajr+gbE
	 iaI9IllyDMwHFcpEfF16iO0TsRPIBgI8YEGbBE9DfNX26y9p6j0ZbEbe1vvORUwXD/
	 61J7E9204dbh3xQiUX7HqlpQ7Hlb5l+HUKvvR5PSW/psF3V2eBAbZuCJih3yIqGa6g
	 wMnwP0LtdWDgDIiSvific4Vi4/nuP1VsUzDa/YyA9yIC5OCcNFrgBGm8x4txUv0A2E
	 WomZfL1uRWd/g==
Date: Wed, 5 Feb 2025 15:52:31 +0100
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
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
Message-ID: <20250205-amorphous-nano-agouti-b5baba@houat>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
 <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
 <ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
 <9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
 <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="n3ihhmqacysffxra"
Content-Disposition: inline
In-Reply-To: <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>


--n3ihhmqacysffxra
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
MIME-Version: 1.0

On Mon, Feb 03, 2025 at 04:43:23PM +0000, Florent Tomasin wrote:
> Hi Maxime, Nicolas
>=20
> On 30/01/2025 17:47, Nicolas Dufresne wrote:
> > Le jeudi 30 janvier 2025 =E0 17:38 +0100, Maxime Ripard a =E9crit=A0:
> >> Hi Nicolas,
> >>
> >> On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrote:
> >>> Le jeudi 30 janvier 2025 =E0 14:46 +0100, Maxime Ripard a =E9crit=A0:
> >>>> Hi,
> >>>>
> >>>> I started to review it, but it's probably best to discuss it here.
> >>>>
> >>>> On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wrote:
> >>>>> Hi,
> >>>>>
> >>>>> This is a patch series covering the support for protected mode exec=
ution in
> >>>>> Mali Panthor CSF kernel driver.
> >>>>>
> >>>>> The Mali CSF GPUs come with the support for protected mode executio=
n at the
> >>>>> HW level. This feature requires two main changes in the kernel driv=
er:
> >>>>>
> >>>>> 1) Configure the GPU with a protected buffer. The system must provi=
de a DMA
> >>>>>    heap from which the driver can allocate a protected buffer.
> >>>>>    It can be a carved-out memory or dynamically allocated protected=
 memory region.
> >>>>>    Some system includes a trusted FW which is in charge of the prot=
ected memory.
> >>>>>    Since this problem is integration specific, the Mali Panthor CSF=
 kernel
> >>>>>    driver must import the protected memory from a device specific e=
xporter.
> >>>>
> >>>> Why do you need a heap for it in the first place? My understanding of
> >>>> your series is that you have a carved out memory region somewhere, a=
nd
> >>>> you want to allocate from that carved out memory region your buffers.
> >>>>
> >>>> How is that any different from using a reserved-memory region, adding
> >>>> the reserved-memory property to the GPU device and doing all your
> >>>> allocation through the usual dma_alloc_* API?
> >>>
> >>> How do you then multiplex this region so it can be shared between
> >>> GPU/Camera/Display/Codec drivers and also userspace ?
> >>
> >> You could point all the devices to the same reserved memory region, and
> >> they would all allocate from there, including for their userspace-faci=
ng
> >> allocations.
> >=20
> > I get that using memory region is somewhat more of an HW description, a=
nd
> > aligned with what a DT is supposed to describe. One of the challenge is=
 that
> > Mediatek heap proposal endup calling into their TEE, meaning knowing th=
e region
> > is not that useful. You actually need the TEE APP guid and its IPC prot=
ocol. If
> > we can dell drivers to use a head instead, we can abstract that SoC spe=
cific
> > complexity. I believe each allocated addressed has to be mapped to a zo=
ne, and
> > that can only be done in the secure application. I can imagine similar =
needs
> > when the protection is done using some sort of a VM / hypervisor.
> >=20
> > Nicolas
> >=20
>=20
> The idea in this design is to abstract the heap management from the
> Panthor kernel driver (which consumes a DMA buffer from it).
>=20
> In a system, an integrator would have implemented a secure heap driver,
> and could be based on TEE or a carved-out memory with restricted access,
> or else. This heap driver would be responsible of implementing the
> logic to: allocate, free, refcount, etc.
>=20
> The heap would be retrieved by the Panthor kernel driver in order to
> allocate protected memory to load the FW and allow the GPU to enter/exit
> protected mode. This memory would not belong to a user space process.
> The driver allocates it at the time of loading the FW and initialization
> of the GPU HW. This is a device globally owned protected memory.

The thing is, it's really not clear why you absolutely need to have the
Panthor driver involved there. It won't be transparent to userspace,
since you'd need an extra flag at allocation time, and the buffers
behave differently. If userspace has to be aware of it, what's the
advantage to your approach compared to just exposing a heap for those
secure buffers, and letting userspace allocate its buffers from there?

> When I came across this patch series:
> -
> https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/=
#t
> I found it could help abstract the interface between the secure heap and
> the integration of protected memory in Panthor.
>=20
> A kernel driver would have to find the heap: `dma_heap_find()`, then
> request allocation of a DMA buffer from it. The heap driver would deal
> with the specifities of the protected memory on the system.

Sure, but we still have to address *why* it would be a good idea for the
driver to do it in the first place. The mediatek series had the same
feedback.

Maxime

--n3ihhmqacysffxra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6N7LwAKCRAnX84Zoj2+
drAsAX4tWhirmSzsRaErM0ohMmzW3Z8MA7ak1TjIT6PBjwjyjlMf3NLPRmiboav/
v7gqrQQBf2OeL8Jeku8Xf1ostov/rNHGnpfXL0sAeI8i7GUariIGQVnG5QhnHyrX
lokEkw8UZA==
=e43F
-----END PGP SIGNATURE-----

--n3ihhmqacysffxra--

