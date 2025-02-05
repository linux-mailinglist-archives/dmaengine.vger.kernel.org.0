Return-Path: <dmaengine+bounces-4313-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A5A29864
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D977A1BDD
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C01FC7E4;
	Wed,  5 Feb 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="xRPpjKBF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0211FC0F7
	for <dmaengine@vger.kernel.org>; Wed,  5 Feb 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778850; cv=none; b=E/chLsACeWuqdK9bMtcHmUjFXow4ZI9LzLSPIt+Xn0q5KIZkDvV13MypPnlNf4KKJx8OIIQX9ZN0E8d4Rtv1g4mPpL8L8Mvoaw5E06flqIcngwYG17VlV0+04kD4BIcDI5hebgCoxBBDBL/PcUPcLqi/ec+iNfigv5R/UkIkhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778850; c=relaxed/simple;
	bh=ijNuuflNXrUb9eu8IX4GbOOlYC+05reWEq31MswjY30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CS1Dh6xSjB1K69lKtQ8N4j0xuZGeZmZNApgCrLotI6SWPhlbUCpFoKPss3BvRdYRPdZWQCjleo5aESZyYB3stb3yxgaXljS4QIKvLR7I0yMfOmKXbVBbn77YMlZSPQETTlWKWOqgAfsiPHAPinzlhswe2E/CP2TErwVifVhI8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=xRPpjKBF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a37a2a53so1188691cf.2
        for <dmaengine@vger.kernel.org>; Wed, 05 Feb 2025 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1738778848; x=1739383648; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5a3g63YXuRyBGyCYvHoCZXHBrCt33UAX5/d9X21sMZ4=;
        b=xRPpjKBFsoqaqbEWaaP+WH7qekhTXK96G6wybhIWctpZB3bCwPZEhiBOUOOGYBnMze
         qiSF3mB3InzOLM2L2e7J7j0lgze9yku86rZDUc1SgpKlMzixliHn9uWLG4vMVLVuFoNC
         dsQpkwLx7eq1aoMy+NetVpzS1JxZXQPfBQRU/nuajoFHb0TMiKkpMcrrEkWHatt2t4q1
         qXDfCNMbHQxdM9NFohmw/kzUMeLpliuBWBHrmmVVMpmpbjFMoTStld/DxPySlWWct9gp
         kh7IN5LGl2CiY0OOx9wuwBxmHl3ygKld2dWyq+pgbr5re/wokG2MQ8Lth7pZb2m+2oUA
         td+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778848; x=1739383648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5a3g63YXuRyBGyCYvHoCZXHBrCt33UAX5/d9X21sMZ4=;
        b=jvYZcMSlnTrW7Mgy5038QEkPKGR6EnPPQwHXhx4bsX/zHe2sIKOcSrfJBaJAPz6NUa
         JiCMPVZ0DyDDTgml+UD2vxLvaGSDLjT47AvIuhAFSi9fSxEaAUp5QFhMhjVUTT7rVRI3
         z0rOMQrfKZ/JxMz7RApfUabA46j4RhlXtq6KRoUyZjd+FGdUoJGwj9pAPeXvkNy2X5d7
         lxIkTeDmBOLvI3hGF8ZvFl9iRFjUk969OZwgcJOXpoRv5Cxh4hBTG6ThCtZ8eaOoEFN4
         AqcU5sduODIBl82PBJAVrRiyNnoHkyLNHeVXbap2WBX2dMjPqYB8efa27ctOXd9nexcy
         tbJg==
X-Forwarded-Encrypted: i=1; AJvYcCW0MwRaT+g37q9vhq32m7tmOJsW8CzDDfxYMiutYmMKBye1Ep9cslvSUq4lGX7tBmjd2eDLFx59XbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+K6QnN8DpQLyqn2eWkCmvMAkepQHK5nzhz0ThVfeUe0xHeSE
	PM+S3Y+jA6c+Unjx/eiQzOHU0fVDd3cLR4UVJdcxfU8zBpSJN5ZgTcgZ7INbpzg=
X-Gm-Gg: ASbGncvM8HcpGW70QDdZ7l5+/5P2Xlofq00r22fuIKxHIuEr9Eg0eULGTwrTQS+pAaT
	UzRe9s2U2j4cN1ZG+jYoe5EnAM++wFNCj+89bstZuSSit4qH0YryS7rWCGTawEydDgCQerh3Hnu
	EFB3VL4K2StUwM9PjMH9NQpB1k0ywtJcRgJaoxK8va8B3kpZ54nk/Bxv1ohokHiYBNi1pKGYrvQ
	gejTYA9LgRW9DS5kMlEw5B9Qdi6GNQhThSS5xN94wcyyzzKVgK8IpzOM9ey2iv4oqc2nm84f9XA
	sRuKKNKAMcNIuuYp
X-Google-Smtp-Source: AGHT+IEo4hXzx1g4KENBMeo2s9vL7H7kP3tcfvoRUkgZj0tj3tMn7WAB4E53kizdrimAnj8XyGNu6g==
X-Received: by 2002:ac8:7e93:0:b0:467:6833:e30c with SMTP id d75a77b69052e-470281e8607mr53959051cf.30.1738778847693;
        Wed, 05 Feb 2025 10:07:27 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:e976::7a9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4702c56c62bsm7919921cf.28.2025.02.05.10.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:07:27 -0800 (PST)
Message-ID: <9b5104631f827fe44ad1030c971c72fba9a8ac90.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali
 CSF GPUs
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Maxime Ripard <mripard@kernel.org>
Cc: Florent Tomasin <florent.tomasin@arm.com>, Vinod Koul
 <vkoul@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, Liviu
 Dudau	 <liviu.dudau@arm.com>, Maarten Lankhorst
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
Date: Wed, 05 Feb 2025 13:07:25 -0500
In-Reply-To: <20250205-robust-tall-parrot-69baf7@houat>
References: <cover.1738228114.git.florent.tomasin@arm.com>
	 <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
	 <1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
	 <ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
	 <9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
	 <1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
	 <c856a7059171bcc6afd6d829c6c025882855778b.camel@ndufresne.ca>
	 <20250205-robust-tall-parrot-69baf7@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 05 f=C3=A9vrier 2025 =C3=A0 15:53 +0100, Maxime Ripard a =C3=A9=
crit=C2=A0:
> On Tue, Feb 04, 2025 at 01:22:58PM -0500, Nicolas Dufresne wrote:
> > Le lundi 03 f=C3=A9vrier 2025 =C3=A0 16:43 +0000, Florent Tomasin a =C3=
=A9crit=C2=A0:
> > > Hi Maxime, Nicolas
> > >=20
> > > On 30/01/2025 17:47, Nicolas Dufresne wrote:
> > > > Le jeudi 30 janvier 2025 =C3=A0 17:38 +0100, Maxime Ripard a =C3=A9=
crit=C2=A0:
> > > > > Hi Nicolas,
> > > > >=20
> > > > > On Thu, Jan 30, 2025 at 10:59:56AM -0500, Nicolas Dufresne wrote:
> > > > > > Le jeudi 30 janvier 2025 =C3=A0 14:46 +0100, Maxime Ripard a =
=C3=A9crit=C2=A0:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > I started to review it, but it's probably best to discuss it =
here.
> > > > > > >=20
> > > > > > > On Thu, Jan 30, 2025 at 01:08:56PM +0000, Florent Tomasin wro=
te:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > This is a patch series covering the support for protected m=
ode execution in
> > > > > > > > Mali Panthor CSF kernel driver.
> > > > > > > >=20
> > > > > > > > The Mali CSF GPUs come with the support for protected mode =
execution at the
> > > > > > > > HW level. This feature requires two main changes in the ker=
nel driver:
> > > > > > > >=20
> > > > > > > > 1) Configure the GPU with a protected buffer. The system mu=
st provide a DMA
> > > > > > > >    heap from which the driver can allocate a protected buff=
er.
> > > > > > > >    It can be a carved-out memory or dynamically allocated p=
rotected memory region.
> > > > > > > >    Some system includes a trusted FW which is in charge of =
the protected memory.
> > > > > > > >    Since this problem is integration specific, the Mali Pan=
thor CSF kernel
> > > > > > > >    driver must import the protected memory from a device sp=
ecific exporter.
> > > > > > >=20
> > > > > > > Why do you need a heap for it in the first place? My understa=
nding of
> > > > > > > your series is that you have a carved out memory region somew=
here, and
> > > > > > > you want to allocate from that carved out memory region your =
buffers.
> > > > > > >=20
> > > > > > > How is that any different from using a reserved-memory region=
, adding
> > > > > > > the reserved-memory property to the GPU device and doing all =
your
> > > > > > > allocation through the usual dma_alloc_* API?
> > > > > >=20
> > > > > > How do you then multiplex this region so it can be shared betwe=
en
> > > > > > GPU/Camera/Display/Codec drivers and also userspace ?
> > > > >=20
> > > > > You could point all the devices to the same reserved memory regio=
n, and
> > > > > they would all allocate from there, including for their userspace=
-facing
> > > > > allocations.
> > > >=20
> > > > I get that using memory region is somewhat more of an HW descriptio=
n, and
> > > > aligned with what a DT is supposed to describe. One of the challeng=
e is that
> > > > Mediatek heap proposal endup calling into their TEE, meaning knowin=
g the region
> > > > is not that useful. You actually need the TEE APP guid and its IPC =
protocol. If
> > > > we can dell drivers to use a head instead, we can abstract that SoC=
 specific
> > > > complexity. I believe each allocated addressed has to be mapped to =
a zone, and
> > > > that can only be done in the secure application. I can imagine simi=
lar needs
> > > > when the protection is done using some sort of a VM / hypervisor.
> > > >=20
> > > > Nicolas
> > > >=20
> > >=20
> > > The idea in this design is to abstract the heap management from the
> > > Panthor kernel driver (which consumes a DMA buffer from it).
> > >=20
> > > In a system, an integrator would have implemented a secure heap drive=
r,
> > > and could be based on TEE or a carved-out memory with restricted acce=
ss,
> > > or else. This heap driver would be responsible of implementing the
> > > logic to: allocate, free, refcount, etc.
> > >=20
> > > The heap would be retrieved by the Panthor kernel driver in order to
> > > allocate protected memory to load the FW and allow the GPU to enter/e=
xit
> > > protected mode. This memory would not belong to a user space process.
> > > The driver allocates it at the time of loading the FW and initializat=
ion
> > > of the GPU HW. This is a device globally owned protected memory.
> >=20
> > This use case also applies well for codec. The Mediatek SCP firmware ne=
eds to be
> > loaded with a restricted memory too, its a very similar scenario, plus =
Mediatek
> > chips often include a Mali. On top of that, V4L2 codecs (in general) do=
 need to
> > allocate internal scratch buffer for the IP to write to for things like=
 motion
> > vectors, reconstruction frames, entropy statistics, etc. The IP will on=
ly be
> > able to write if the memory is restricted.
>=20
> BTW, in such a case, do the scratch buffers need to be
> protected/secure/whatever too, or would codecs be able to use any buffer
> as a scratch buffer?

They need to be protected yes. Its not very fine grained on the platform I =
work
on. When that protection is enabled, the decoder can only read and write fr=
om
protected memory. I know there is platform were it can read from both, but
generally all IOs regardless what they are used for endup with the same
restriction.

Nicolas

p.s. since Khronos seems to have adopted "protected", perhaps it will be ad=
vised
to go for that in the end.

>=20
> Maxime


