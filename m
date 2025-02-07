Return-Path: <dmaengine+bounces-4331-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E898AA2C8EE
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 17:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFCB7A3F43
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDCB1891A9;
	Fri,  7 Feb 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="Z941tF0h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01C1547CA
	for <dmaengine@vger.kernel.org>; Fri,  7 Feb 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945944; cv=none; b=cjjSGIFx2of+DX8gQGHWS+f8iMBdWab46jncGRA4GEqLQ7RpcK/aXGUiQ9yG5tiAWps8FPuZR3+TQgnbfxQ/HL/FGTUsUO2Q5VPjYlwL7TOE2xqmXrhd+iZHglq/nvFG9beYV7Xn8JiksUzIurCfDiPArnuXVQ48UrDtUQ1DU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945944; c=relaxed/simple;
	bh=8W8kxm7Ck99w53h02b4o0GqmABP7jA/s61Kk2qEUBy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXGfjoIG/z+rWN+Y19WaeqEc8AH1Qm+4gI+kWyjd6ETG19wnFOLvl4A3C9QvWPU0rMpM11E/2q//9/YEP9mqNEbIbdHgXHnHTLT4EO8881YUCSqDInswl6GN72Ov7hpvS/W7BbU5Zvg+xeOin4OWkcX/xNYKo0sXJLN/lBrlwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=Z941tF0h; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f0afda3fso269334685a.2
        for <dmaengine@vger.kernel.org>; Fri, 07 Feb 2025 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1738945941; x=1739550741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1eyHbVSPzPS2H7ccJkoRfXPoW37SSjWSYPml0H3RVrY=;
        b=Z941tF0h8cTh2pwFCKQe6SKKMQMneWA6SKystJ1wXLadW65I3vc8lbsYjH2JVTtBHV
         X//Rf6oOeI2niq3m2Y6jONY+N2xthszgNfuSsxJN4DdnljMKmS5lzTySPkYZfKdYj3OB
         qzGYnP0O2ucRoYIzILh75O92Gd6Yr8LNmvS8pkK1gPEw5A5AVhAHuGWtMPWmIWQToetF
         EhAtxay1XnSU0rPe3YTPG1p9yTSOlaOlFz+oWPAmG9HXeJZqBuIFtjW5Vk1/e8cGcFAE
         gXB75J0PbK0eN9e0AUuNY104bp5lCsc6jJEE+tRFTE0wzgmHnyWsCWie8yybNT+VI2RM
         NEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945941; x=1739550741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eyHbVSPzPS2H7ccJkoRfXPoW37SSjWSYPml0H3RVrY=;
        b=QG+ZDQaxRbfMWX1mUWJrdQNimqST8axhCBwCxYkV6fz04V05Yyemfu6EkUCdbJM0gY
         9s+WtekvVZmQGP9wGPHu2Pb+NaQxHqssjUpQ6sQwUql9Gy50Mvv8XUp5l8LgfD5ER0Bf
         +48GHrZydLIlm+P9FUOgc9hDQTqzF/Y7DI/3kHo447qBOirh2neQdThrwO8M1MB6Sovc
         Z2LvWHvyRj5d7r3VCG60l223iuzFepBSW8ZkXG6dzhdjB2DLu0j2/P4xsoVCW2FzMRM5
         61EIw7GaXdnoXlxvatO/h+ITabWRBjA2vGPwMn7KP2OUb/Sjwx3H7mGJv75fqbPNIHl8
         08ig==
X-Forwarded-Encrypted: i=1; AJvYcCUJfsT6QVcSF8i5bwxnudqcaXr27wzRT+D4aSB8Efkm0S5mu8vvP13vwWD5iN26uxpl4dvpk+B5Gw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH2tP5AX8pdAqL09NHqyvg3BWXKFTOiBKRzMYDJ66nBHQ6p/fP
	rvJhslBgl42BrfpZHF1UHNG2buZfKupuXwsydPyHzwIGpYMwsKweg97VOsZLiYc=
X-Gm-Gg: ASbGncub1hNZfZc8Vu9BXL4o1rzsUDFx27zXPgqZb0HYtfUHLvwZ24MdUFmZ0EyF0pp
	rSw8RItR0Bs8T21/ghulzHZMWIVAAjzLUMI0pHuzsIlU35Aj0Wpo/f1LQIKJ+ibcsxg1rno/Yfr
	5XkdURUdaXmNUZCqtJ6i4bkLWYOUCgC55fMNuhNvBiNI1taAMd7TCKca1a13p51MiZuLlutdatz
	s2WRsbZFaL79kf13HOQb+f5k3Zo/bHe4axPWMBpJePh3iniAun0g+IF4Bc1GyAfpSgGlcmNbC26
	3sKVZ+LNITJCL2lz
X-Google-Smtp-Source: AGHT+IHMskAJ2FFpcL+LoXxgmr/MIx5nX+eElBqeikyP+Zh17IpGj4yP1i1w+a51aWNGdndmORetGg==
X-Received: by 2002:a05:620a:248e:b0:7b6:f17d:f5a7 with SMTP id af79cd13be357-7c047c1f9d5mr701310685a.6.1738945941025;
        Fri, 07 Feb 2025 08:32:21 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:e976::7a9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb7d12sm206602485a.106.2025.02.07.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:32:20 -0800 (PST)
Message-ID: <2cef75795cf3eb1c224f3562134d2ed887dbff60.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali
 CSF GPUs
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>, Florent Tomasin	
 <florent.tomasin@arm.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Steven Price <steven.price@arm.com>, Liviu Dudau	
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin
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
Date: Fri, 07 Feb 2025 11:32:18 -0500
In-Reply-To: <20250207160253.42551fb1@collabora.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
		<3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
		<1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
		<ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
		<9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
		<1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
		<20250205-amorphous-nano-agouti-b5baba@houat>
		<2085fb785095dc5abdac2352adfb3e1e1c8ae549.camel@ndufresne.ca>
	 <20250207160253.42551fb1@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le vendredi 07 f=C3=A9vrier 2025 =C3=A0 16:02 +0100, Boris Brezillon a =C3=
=A9crit=C2=A0:
> Sorry for joining the party late, a couple of comments to back Akash
> and Nicolas' concerns.
>=20
> On Wed, 05 Feb 2025 13:14:14 -0500
> Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>=20
> > Le mercredi 05 f=C3=A9vrier 2025 =C3=A0 15:52 +0100, Maxime Ripard a =
=C3=A9crit=C2=A0:
> > > On Mon, Feb 03, 2025 at 04:43:23PM +0000, Florent Tomasin wrote: =20
> > > > Hi Maxime, Nicolas
> > > >=20
> > > > On 30/01/2025 17:47, Nicolas Dufresne wrote: =20
> > > > > Le jeudi 30 janvier 2025 =C3=A0 17:38 +0100, Maxime Ripard a =C3=
=A9crit=C2=A0: =20
> > > > > > Hi Nicolas,
> > > > > >=20
> > > > > > On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrot=
e: =20
> > > > > > > Le jeudi 30 janvier 2025 =C3=A0 14:46 +0100, Maxime Ripard a =
=C3=A9crit=C2=A0: =20
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > I started to review it, but it's probably best to discuss i=
t here.
> > > > > > > >=20
> > > > > > > > On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin w=
rote: =20
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > This is a patch series covering the support for protected=
 mode execution in
> > > > > > > > > Mali Panthor CSF kernel driver.
> > > > > > > > >=20
> > > > > > > > > The Mali CSF GPUs come with the support for protected mod=
e execution at the
> > > > > > > > > HW level. This feature requires two main changes in the k=
ernel driver:
> > > > > > > > >=20
> > > > > > > > > 1) Configure the GPU with a protected buffer. The system =
must provide a DMA
> > > > > > > > >    heap from which the driver can allocate a protected bu=
ffer.
> > > > > > > > >    It can be a carved-out memory or dynamically allocated=
 protected memory region.
> > > > > > > > >    Some system includes a trusted FW which is in charge o=
f the protected memory.
> > > > > > > > >    Since this problem is integration specific, the Mali P=
anthor CSF kernel
> > > > > > > > >    driver must import the protected memory from a device =
specific exporter. =20
> > > > > > > >=20
> > > > > > > > Why do you need a heap for it in the first place? My unders=
tanding of
> > > > > > > > your series is that you have a carved out memory region som=
ewhere, and
> > > > > > > > you want to allocate from that carved out memory region you=
r buffers.
> > > > > > > >=20
> > > > > > > > How is that any different from using a reserved-memory regi=
on, adding
> > > > > > > > the reserved-memory property to the GPU device and doing al=
l your
> > > > > > > > allocation through the usual dma_alloc_* API? =20
> > > > > > >=20
> > > > > > > How do you then multiplex this region so it can be shared bet=
ween
> > > > > > > GPU/Camera/Display/Codec drivers and also userspace ? =20
> > > > > >=20
> > > > > > You could point all the devices to the same reserved memory reg=
ion, and
> > > > > > they would all allocate from there, including for their userspa=
ce-facing
> > > > > > allocations. =20
> > > > >=20
> > > > > I get that using memory region is somewhat more of an HW descript=
ion, and
> > > > > aligned with what a DT is supposed to describe. One of the challe=
nge is that
> > > > > Mediatek heap proposal endup calling into their TEE, meaning know=
ing the region
> > > > > is not that useful. You actually need the TEE APP guid and its IP=
C protocol. If
> > > > > we can dell drivers to use a head instead, we can abstract that S=
oC specific
> > > > > complexity. I believe each allocated addressed has to be mapped t=
o a zone, and
> > > > > that can only be done in the secure application. I can imagine si=
milar needs
> > > > > when the protection is done using some sort of a VM / hypervisor.
> > > > >=20
> > > > > Nicolas
> > > > >  =20
> > > >=20
> > > > The idea in this design is to abstract the heap management from the
> > > > Panthor kernel driver (which consumes a DMA buffer from it).
> > > >=20
> > > > In a system, an integrator would have implemented a secure heap dri=
ver,
> > > > and could be based on TEE or a carved-out memory with restricted ac=
cess,
> > > > or else. This heap driver would be responsible of implementing the
> > > > logic to: allocate, free, refcount, etc.
> > > >=20
> > > > The heap would be retrieved by the Panthor kernel driver in order t=
o
> > > > allocate protected memory to load the FW and allow the GPU to enter=
/exit
> > > > protected mode. This memory would not belong to a user space proces=
s.
> > > > The driver allocates it at the time of loading the FW and initializ=
ation
> > > > of the GPU HW. This is a device globally owned protected memory. =
=20
> > >=20
> > > The thing is, it's really not clear why you absolutely need to have t=
he
> > > Panthor driver involved there. It won't be transparent to userspace,
> > > since you'd need an extra flag at allocation time, and the buffers
> > > behave differently. If userspace has to be aware of it, what's the
> > > advantage to your approach compared to just exposing a heap for those
> > > secure buffers, and letting userspace allocate its buffers from there=
? =20
> >=20
> > Unless I'm mistaken, the Panthor driver loads its own firmware. Since l=
oading
> > the firmware requires placing the data in a protected memory region, an=
d that
> > this aspect has no exposure to userspace, how can Panthor not be implic=
ated ?
>=20
> Right, the very reason we need protected memory early is because some
> FW sections need to be allocated from the protected pool, otherwise the
> TEE will fault as soon at the FW enters the so-called 'protected mode'.
>=20
> Now, it's not impossible to work around this limitation. For instance,
> we could load the FW without this protected section by default (what we
> do right now), and then provide a DRM_PANTHOR_ENABLE_FW_PROT_MODE
> ioctl that would take a GEM object imported from a dmabuf allocated
> from the protected dma-heap by userspace. We can then reset the FW and
> allow it to operate in protected mode after that point. This approach
> has two downsides though:
>=20
> 1. We have no way of checking that the memory we're passed is actually
> suitable for FW execution in a protected context. If we're passed
> random memory, this will likely hang the platform as soon as we enter
> protected mode.
>=20
> 2. If the driver already boot the FW and exposed a DRI node, we might
> have GPU workloads running, and doing a FW reset might incur a slight
> delay in GPU jobs execution.
>=20
> I think #1 is a more general issue that applies to suspend buffers
> allocated for GPU contexts too. If we expose ioctls where we take
> protected memory buffers that can possibly lead to crashes if they are
> not real protected memory regions, and we have no way to ensure the
> memory is protected, we probably want to restrict these ioctls/modes to
> some high-privilege CAP_SYS_.
>=20
> For #2, that's probably something we can live with, since it's a
> one-shot thing. If it becomes an issue, we can even make sure we enable
> the FW protected-mode before the GPU starts being used for real.
>=20
> This being said, I think the problem applies outside Panthor, and it
> might be that the video codec can't reset the FW/HW block to switch to
> protected mode as easily as Panthor.

Overall the reset and reboot method is pretty ugly in my opinion. But to st=
ick
with the pure rationale, rebooting the SCP on MTK is much harder, since its=
 not
specific to a single HW/driver.

Other codecs like Samsung MFC, Venus/Iris, Chips&Media, etc. that approach =
seams
plausible, but we still can't trust the buffer, which to me is not acceptab=
le.

>=20
> Note that there's also downsides to the reserved-memory node approach,
> where some bootloader stage would ask the secure FW to reserve a
> portion of mem and pass this through the DT. This sort of things tend to
> be an integration mess, where you need all the pieces of the stack (TEE,
> u-boot, MTK dma-heap driver, gbm, ...) to be at a certain version to
> work properly. If we go the ioctl() way, we restrict the scope to the
> TEE, gbm/mesa and the protected-dma-heap driver, which is still a lot,
> but we've ripped the bootloader out of the equation at least.
>=20
> Regards,
>=20
> Boris


