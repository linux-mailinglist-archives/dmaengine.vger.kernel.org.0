Return-Path: <dmaengine+bounces-4273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B877A279AA
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 19:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26799161F99
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C393217674;
	Tue,  4 Feb 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="CsaThUYn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C778F4A
	for <dmaengine@vger.kernel.org>; Tue,  4 Feb 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693383; cv=none; b=d1XMZN6rBD6hm9XpHt2PQBZurvs5hiAbX430YZwsf2VCexp+2PUjX1qXWjbbYUH+zhQRwkhQjIopTzVtYgX7W2M4242pwu1ndp7OaVkY9Q6UNmuE5B0cxcJNfHu5NZLM3HDyJaAFgjOrHkqdVJ398GoyKcrS7azUcrOciga8BPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693383; c=relaxed/simple;
	bh=wovIoxaB1GBhtTR1K6ERxfvU9SdF2qRsGfpDTFxhmrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2RpOPYEs2YRdu+QpzQ5E38K/5uIU5wnSguApMN+mj0Xtv2+wZ/yw/aiVT8x20m7KbHuMEu41PWe8M9Qck61IwD09M/2T3cmc9DmZAMUN2UScW3UKRDXHYf/9L1lhNfjkH6ETehVKm0CFqjo4e25AZj2KGtgP+4tANS6nbJBWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=CsaThUYn; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d92cd1e811so445146d6.1
        for <dmaengine@vger.kernel.org>; Tue, 04 Feb 2025 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1738693380; x=1739298180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tac0SuyxfkJEVndSE8YT8kHaqPS7Ds82fJ/2JoeM9mo=;
        b=CsaThUYn2HBvFRVT2O3/SwiWG9cDXUIdyASrw7wOBFyOIu4tLC5GNAGFSpohtbCvEk
         ziFAbIv2Npjs6aP+7gugorwfl9lgYDiGQXcCq7t0vmNqYk1h/JKdmovlq5sIlNVTJwpA
         gNWxFRXvN0jgzhDP4F+WUQUlh9V4cG5wJE+5luU8mxwHIlrGNHko8au0MlMtz/owrLmQ
         H7gxBFCpRYX0viZtWycFL/7S0O5j/pk67omhpJfsDqE0UX957kxDlHE4+UvDXvQ3LbIf
         dTnrf7m9mnFQiUj9osKFhAlFsZ9Zo6N2tYc4J4GyLGNzCvEdiRnyC3lRj4kTcmED85nO
         2sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693380; x=1739298180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tac0SuyxfkJEVndSE8YT8kHaqPS7Ds82fJ/2JoeM9mo=;
        b=GsM8MnV6pa/h65ABswMJT2djIvsY1TB9rTr85wRbv3Y9xpg2G2BGRQA04HTrpg7z1l
         MKC+LKI6y+8Pk6/oGR9ER+Scgql8pHKeHapdnb2Fp/CzfKgKbrD4gfpFCXKvR30i2z2V
         WVw8ddG3nW7jFMqGMxuXCDTQ5VcWA3aVt3xuw/U/Re8RIdmjBqFT1ZESXIWJTK9Z8wXX
         AaMdleFQMqJUb5szalOtL3sct5i/BPQpifyxcht0IzXVfLemDjB8j5mwcZ/3voCbmOnW
         E+jl5S62VPblibfJlThe+j5b8AHfMVghD8hFkCtUOmed/PxssH0IkJGnKbhBvW4SJS72
         GtiA==
X-Forwarded-Encrypted: i=1; AJvYcCVaV7ihSk+LYDHELmKoxC/l/KEVDNoXLJpUdIQWvSKMwCBqLG17kZQvYkeR3rfXC4RbXib19sBqRVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMgWehTIdc03vQ+d9tgZvTpIIJ64Tqu0/uugRK1Q5rhun4tWgM
	DHRFSxwIYdOiSpMH4Xg4mItl73RZykWRAuQPzvWba3SJS40M6zDWw/eGEQT6E94=
X-Gm-Gg: ASbGncs/YKdHfTx9I0MxlOUMTh7sUoboKCEwjVrBWlFMwQFGk0B6Hg9vacOCfLzAUC3
	cyGna01GxRpd/vbzjs0L7aSr9CNzF/0G96WAyNOQZzdAlJvpOrqHP2Y5shoBNrQNihvgsS0iB6G
	tdBhWARIRKsRfAdprt16ctrDG1y6tkjVMw2YiIgmTMmmZUWxecR0PRA03aMG01WzbzHRf//TIYa
	S+2qcounBkveRFxLgsFpsPlC+sy9GLPc4C3zub1Cg+zG0q2vL3LVn9qkaTpBCQ/eInRMUj4l1Br
	fYUMiFalZYCPwguh
X-Google-Smtp-Source: AGHT+IE/f1kxzWTc19HByUy9ODx9TdMIUe4LBdJWBN0eGiPy3I/9968X4R31P6i56Rq3iDSVWjRNWA==
X-Received: by 2002:ad4:5ecb:0:b0:6e2:3761:71b0 with SMTP id 6a1803df08f44-6e420f3b728mr78300806d6.5.1738693380393;
        Tue, 04 Feb 2025 10:23:00 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:e976::7a9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e423ca0476sm9418096d6.124.2025.02.04.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:23:00 -0800 (PST)
Message-ID: <c856a7059171bcc6afd6d829c6c025882855778b.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali
 CSF GPUs
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Florent Tomasin <florent.tomasin@arm.com>, Maxime Ripard
	 <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Boris
 Brezillon	 <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>,  Sumit Semwal <sumit.semwal@linaro.org>, Benjamin
 Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey	
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J .
 Mercier"	 <tjmercier@google.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong
 Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, nd@arm.com, Akash Goel
 <akash.goel@arm.com>
Date: Tue, 04 Feb 2025 13:22:58 -0500
In-Reply-To: <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
	 <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
	 <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
	 <ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
	 <9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
	 <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 03 f=C3=A9vrier 2025 =C3=A0 16:43 +0000, Florent Tomasin a =C3=A9c=
rit=C2=A0:
> Hi Maxime, Nicolas
>=20
> On 30/01/2025 17:47, Nicolas Dufresne wrote:
> > Le jeudi 30 janvier 2025 =C3=A0 17:38 +0100, Maxime Ripard a =C3=A9crit=
=C2=A0:
> > > Hi Nicolas,
> > >=20
> > > On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrote:
> > > > Le jeudi 30 janvier 2025 =C3=A0 14:46 +0100, Maxime Ripard a =C3=A9=
crit=C2=A0:
> > > > > Hi,
> > > > >=20
> > > > > I started to review it, but it's probably best to discuss it here=
.
> > > > >=20
> > > > > On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > This is a patch series covering the support for protected mode =
execution in
> > > > > > Mali Panthor CSF kernel driver.
> > > > > >=20
> > > > > > The Mali CSF GPUs come with the support for protected mode exec=
ution at the
> > > > > > HW level. This feature requires two main changes in the kernel =
driver:
> > > > > >=20
> > > > > > 1) Configure the GPU with a protected buffer. The system must p=
rovide a DMA
> > > > > >    heap from which the driver can allocate a protected buffer.
> > > > > >    It can be a carved-out memory or dynamically allocated prote=
cted memory region.
> > > > > >    Some system includes a trusted FW which is in charge of the =
protected memory.
> > > > > >    Since this problem is integration specific, the Mali Panthor=
 CSF kernel
> > > > > >    driver must import the protected memory from a device specif=
ic exporter.
> > > > >=20
> > > > > Why do you need a heap for it in the first place? My understandin=
g of
> > > > > your series is that you have a carved out memory region somewhere=
, and
> > > > > you want to allocate from that carved out memory region your buff=
ers.
> > > > >=20
> > > > > How is that any different from using a reserved-memory region, ad=
ding
> > > > > the reserved-memory property to the GPU device and doing all your
> > > > > allocation through the usual dma_alloc_* API?
> > > >=20
> > > > How do you then multiplex this region so it can be shared between
> > > > GPU/Camera/Display/Codec drivers and also userspace ?
> > >=20
> > > You could point all the devices to the same reserved memory region, a=
nd
> > > they would all allocate from there, including for their userspace-fac=
ing
> > > allocations.
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

This use case also applies well for codec. The Mediatek SCP firmware needs =
to be
loaded with a restricted memory too, its a very similar scenario, plus Medi=
atek
chips often include a Mali. On top of that, V4L2 codecs (in general) do nee=
d to
allocate internal scratch buffer for the IP to write to for things like mot=
ion
vectors, reconstruction frames, entropy statistics, etc. The IP will only b=
e
able to write if the memory is restricted.

Nicolas

>=20
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
>=20
> > >=20
> > > > Also, how the secure memory is allocted / obtained is a process tha=
t
> > > > can vary a lot between SoC, so implementation details assumption
> > > > should not be coded in the driver.
> > >=20
> > > But yeah, we agree there, it's also the point I was trying to make :)
> > >=20
> > > Maxime
> >=20
>=20
> Agree with your point, the Panthor kernel driver may not be aware of the
> heap management logic. As an alternative to the DMA heap API used here,
> I also tried to expose the heap by passing the phandle of a "heap"
> device to Panthor. The reference to the DMA heap was stored as a private
> data of the heap device as a new type: `struct dma_heap_import_info`,
> similar to the existing type: `struct dma_heap_export_info`.
> This made me think it could be problematic, as the private data type
> would have to be cast before accessing it from the importer driver. I
> worried about a mis-use of the types with this approach.
>=20
> Regards,
> Florent


