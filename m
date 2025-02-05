Return-Path: <dmaengine+bounces-4303-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FFA292C2
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A7F188EEBD
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5418B47D;
	Wed,  5 Feb 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnE4QYFL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7734157465;
	Wed,  5 Feb 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767212; cv=none; b=MccZH0hlZUa3fJeMFW3T0jjHiyU10JE0F4SmhsB761S1gc1LE3WitFFSxJXwDruRHXjO1xtv0BZK7HxE5jFJcgglIxAmRm2gd4UNTA2Zo7t4iws3PRkcDCfglGkI7PS4fsJrY0ivmT4aYd7awwnV1b101bkKsaWCCReC11VMqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767212; c=relaxed/simple;
	bh=ly4tyRLO/ehfMN/FLCIRG16hKWOkEGsQKwgjdbw72Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBrGzii/luAgG/88wW0tvb0h8yz4Sfsgv49UWWDIRQZXVpA2wz/vqNgr1dcsjgbv8c2+l6Ptcscxgv7AD5dW9llpK94QhqRF1wHeltmDWMoD5xWpRyXloNpErVndOSp/aP31ehpt/c76oLPnj6CpMHDTuTmjA/z53dWE+bfSOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnE4QYFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF1FC4CED1;
	Wed,  5 Feb 2025 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738767211;
	bh=ly4tyRLO/ehfMN/FLCIRG16hKWOkEGsQKwgjdbw72Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnE4QYFLfLaYNfccMdfqWT+RYN9yf+Gjxza7rzCut/1l9oMaUuiijDdd/DhaRbESZ
	 XgFg6X3q4ifc0Xq8xBrBd3RLOXS/4Y33jlkUTNozgo2VcesBo2wJwSkQaRsQqJZa0a
	 T67JDf8W1XRZNMD5C9zAXRKf4SEEAxGwkW8xeIPTCdscEvhIh30okn0Sv7Z9Jvpu3E
	 PHUledK8RTCFdrv8PmcgPFa163+tjJbY8mwv5asDoBKS5o2hovBwjFoJP+EmXlJDXt
	 0al3PgvxiEK16LH5cWdsPOTO8FTFJ0qmea/GqbeiLRwUna6jGtHUrHA0uLaWFwRXQg
	 MrFxL1PvPIaEA==
Date: Wed, 5 Feb 2025 15:53:29 +0100
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
Message-ID: <20250205-robust-tall-parrot-69baf7@houat>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
 <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
 <ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
 <9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
 <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
 <c856a7059171bcc6afd6d829c6c025882855778b.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="edrbb66pldmq62jz"
Content-Disposition: inline
In-Reply-To: <c856a7059171bcc6afd6d829c6c025882855778b.camel@ndufresne.ca>


--edrbb66pldmq62jz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF
 GPUs
MIME-Version: 1.0

On Tue, Feb 04, 2025 at 01:22:58PM -0500, Nicolas Dufresne wrote:
> Le lundi 03 f=E9vrier 2025 =E0 16:43 +0000, Florent Tomasin a =E9crit=A0:
> > Hi Maxime, Nicolas
> >=20
> > On 30/01/2025 17:47, Nicolas Dufresne wrote:
> > > Le jeudi 30 janvier 2025 =E0 17:38 +0100, Maxime Ripard a =E9crit=A0:
> > > > Hi Nicolas,
> > > >=20
> > > > On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrote:
> > > > > Le jeudi 30 janvier 2025 =E0 14:46 +0100, Maxime Ripard a =E9crit=
=A0:
> > > > > > Hi,
> > > > > >=20
> > > > > > I started to review it, but it's probably best to discuss it he=
re.
> > > > > >=20
> > > > > > On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > This is a patch series covering the support for protected mod=
e execution in
> > > > > > > Mali Panthor CSF kernel driver.
> > > > > > >=20
> > > > > > > The Mali CSF GPUs come with the support for protected mode ex=
ecution at the
> > > > > > > HW level. This feature requires two main changes in the kerne=
l driver:
> > > > > > >=20
> > > > > > > 1) Configure the GPU with a protected buffer. The system must=
 provide a DMA
> > > > > > >    heap from which the driver can allocate a protected buffer.
> > > > > > >    It can be a carved-out memory or dynamically allocated pro=
tected memory region.
> > > > > > >    Some system includes a trusted FW which is in charge of th=
e protected memory.
> > > > > > >    Since this problem is integration specific, the Mali Panth=
or CSF kernel
> > > > > > >    driver must import the protected memory from a device spec=
ific exporter.
> > > > > >=20
> > > > > > Why do you need a heap for it in the first place? My understand=
ing of
> > > > > > your series is that you have a carved out memory region somewhe=
re, and
> > > > > > you want to allocate from that carved out memory region your bu=
ffers.
> > > > > >=20
> > > > > > How is that any different from using a reserved-memory region, =
adding
> > > > > > the reserved-memory property to the GPU device and doing all yo=
ur
> > > > > > allocation through the usual dma_alloc_* API?
> > > > >=20
> > > > > How do you then multiplex this region so it can be shared between
> > > > > GPU/Camera/Display/Codec drivers and also userspace ?
> > > >=20
> > > > You could point all the devices to the same reserved memory region,=
 and
> > > > they would all allocate from there, including for their userspace-f=
acing
> > > > allocations.
> > >=20
> > > I get that using memory region is somewhat more of an HW description,=
 and
> > > aligned with what a DT is supposed to describe. One of the challenge =
is that
> > > Mediatek heap proposal endup calling into their TEE, meaning knowing =
the region
> > > is not that useful. You actually need the TEE APP guid and its IPC pr=
otocol. If
> > > we can dell drivers to use a head instead, we can abstract that SoC s=
pecific
> > > complexity. I believe each allocated addressed has to be mapped to a =
zone, and
> > > that can only be done in the secure application. I can imagine simila=
r needs
> > > when the protection is done using some sort of a VM / hypervisor.
> > >=20
> > > Nicolas
> > >=20
> >=20
> > The idea in this design is to abstract the heap management from the
> > Panthor kernel driver (which consumes a DMA buffer from it).
> >=20
> > In a system, an integrator would have implemented a secure heap driver,
> > and could be based on TEE or a carved-out memory with restricted access,
> > or else. This heap driver would be responsible of implementing the
> > logic to: allocate, free, refcount, etc.
> >=20
> > The heap would be retrieved by the Panthor kernel driver in order to
> > allocate protected memory to load the FW and allow the GPU to enter/exit
> > protected mode. This memory would not belong to a user space process.
> > The driver allocates it at the time of loading the FW and initialization
> > of the GPU HW. This is a device globally owned protected memory.
>=20
> This use case also applies well for codec. The Mediatek SCP firmware need=
s to be
> loaded with a restricted memory too, its a very similar scenario, plus Me=
diatek
> chips often include a Mali. On top of that, V4L2 codecs (in general) do n=
eed to
> allocate internal scratch buffer for the IP to write to for things like m=
otion
> vectors, reconstruction frames, entropy statistics, etc. The IP will only=
 be
> able to write if the memory is restricted.

BTW, in such a case, do the scratch buffers need to be
protected/secure/whatever too, or would codecs be able to use any buffer
as a scratch buffer?

Maxime

--edrbb66pldmq62jz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6N7aAAKCRAnX84Zoj2+
doTZAYC3KraTKaHat9Tiq3AbNilzp/uyB6OJohhC6KgS8ip7Em2xWpjYSTaqcm0i
XDstePQBf2GNysp5QIxHwmbP32dTXWpJP67ChoVOCgGc+5xAqzvPeAGxw97hlfZf
HYSF4lENtQ==
=HDp7
-----END PGP SIGNATURE-----

--edrbb66pldmq62jz--

