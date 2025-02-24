Return-Path: <dmaengine+bounces-4566-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B7A41DEA
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 12:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CE916A8A9
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628525EFBC;
	Mon, 24 Feb 2025 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S2h0bWvG"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3F23F419;
	Mon, 24 Feb 2025 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396997; cv=none; b=IgyNdoXk8f2ii4vqkLq4OH/2UWRhY7QZa0tCLJzbblwnHTkmkraiuUDtKbbKTO1RBRSJxHts9lEJ7eKIAOPnNIc4RAsOcZfiZBp25bZAW5r3dlUXKLILuD+uEXLopjzUh2vVgtVo1iC30rKGQqNpJsZJ+VCktPxn0XidvLYRPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396997; c=relaxed/simple;
	bh=PSYe6R/xPBasga876FmS8mHT9Zoo5UeLL8SBdjJXyYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=me+EdXZhcikssWO2ffEGlnZ9OGrP19PKcXP6N+dto+850GYIjM+EmwVU8eFskhIX0APhu5PB9ZJAqeHD2/0xfwdsFfZ8aBeGYKckVApWflQ1Tgd5ybKudHgl9tKW5Jb+/USCAn8JC+Ixw744IIlA23N2PbLix96NV+IfR44k8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S2h0bWvG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740396992;
	bh=PSYe6R/xPBasga876FmS8mHT9Zoo5UeLL8SBdjJXyYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S2h0bWvGZ/wrr74QxKpyYx3qf9WQ0JxBIUIjM4IGAT16YoVeJKx1K4amOuK76OY8o
	 0R6eNuYkJ3ceb2AQZObzCrHaxfifC9fX9LBuHqEOQbwJxdks9F9siUe9k0qFloe+C7
	 uF3KlDYg3LvWBCNuRgxDfHblWLHi5JCe7B095xMkFnO8xz2u7wxjYxpcyX64pCu/fI
	 OidgFXAVvWuyE2CnaBc9j1s8nwYW1sbhRhZKwvgjmc0ZHNYa8zycnvM2rogw46y9gh
	 nd4QIhnLaSMccsOwjs7RRqk/keKhQI4h7jiAy7QtCib6a+/Rct5zI1AvmIWlSVDaej
	 biIXz6p58xOCw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AD4FD17E019E;
	Mon, 24 Feb 2025 12:36:31 +0100 (CET)
Date: Mon, 24 Feb 2025 12:36:28 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, Florent Tomasin
 <florent.tomasin@arm.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin
 Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J .
 Mercier" <tjmercier@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong
 Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, nd@arm.com, Akash Goel
 <akash.goel@arm.com>
Subject: Re: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali
 CSF GPUs
Message-ID: <20250224123628.52d43b84@collabora.com>
In-Reply-To: <20250220-strict-cobalt-albatross-6f742e@houat>
References: <3ykaewmjjwkp3y2f3gf5jvqketicd4p2xqyajqtfnsxci36qlm@twidtyj2kgbw>
	<1a73c3acee34a86010ecd25d76958bca4f16d164.camel@ndufresne.ca>
	<ppznh3xnfuqrozhrc7juyi3enxc4v3meu4wadkwwzecj7oxex7@moln2fiibbxo>
	<9d0e381758c0e83882b57102fb09c5d3a36fbf57.camel@ndufresne.ca>
	<1f436caa-1c27-4bbd-9b43-a94dad0d89d0@arm.com>
	<20250205-amorphous-nano-agouti-b5baba@houat>
	<2085fb785095dc5abdac2352adfb3e1e1c8ae549.camel@ndufresne.ca>
	<20250207160253.42551fb1@collabora.com>
	<20250211-robust-lush-skink-0dcc5b@houat>
	<20250211153223.2fef2316@collabora.com>
	<20250220-strict-cobalt-albatross-6f742e@houat>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Maxime,

On Thu, 20 Feb 2025 14:32:14 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> > > > This approach has two downsides though:
> > > > 
> > > > 1. We have no way of checking that the memory we're passed is actually
> > > > suitable for FW execution in a protected context. If we're passed
> > > > random memory, this will likely hang the platform as soon as we enter
> > > > protected mode.    
> > > 
> > > It's a current limitation of dma-buf in general, and you'd have the same
> > > issue right now if someone imports a buffer, or misconfigure the heap
> > > for a !protected heap.
> > > 
> > > I'd really like to have some way to store some metadata in dma_buf, if
> > > only to tell that the buffer is protected.  
> > 
> > The dma_buf has a pointer to its ops, so it should be relatively easy
> > to add an is_dma_buf_coming_from_this_heap() helper. Of course this
> > implies linking the consumer driver to the heap it's supposed to take
> > protected buffers from, which is basically the thing being discussed
> > here :-).  
> 
> I'm not sure looking at the ops would be enough. Like, you can compare
> that the buffer you allocated come from the heap you got from the DT,
> but if that heap doesn't allocate protected buffers, you're screwed and
> you have no way to tell.

If heap names are unique, the name of the heap should somehow guarantee
the protected/restricted nature of buffers allocated from this heap
though. So, from a user perspective, all you have to do is check that
the buffers you import come from this particular heap you've been
pointed to. Where we get the heap name from (DT or module param
passed through a whitelist of protected heap names?) is an
implementation detail.

> 
> It also falls apart if we have a heap driver with multiple instances,
> which is pretty likely if we ever merge the carveout heap driver.

What I meant here is that checking that a buffer comes from a
particular heap is something the heap driver itself can easily do. It
can be a mix of ops+name check (or ops+property check) if there's
multiple heaps instantiated by a single driver, of course.

I guess the other option would be to have a protected property at the
dma_buf level so we don't have to go all the way back to the dma_heap
to figure it out.

> 
> > > 
> > > I suspect you'd also need that if you do things like do protected video
> > > playback through a codec, get a protected frame, and want to import that
> > > into the GPU. Depending on how you allocate it, either the codec or the
> > > GPU or both will want to make sure it's protected.  
> > 
> > If it's all allocated from a central "protected" heap (even if that
> > goes through the driver calling the dma_heap_alloc_buffer()), it
> > shouldn't be an issue.  
> 
> Right, assuming we have a way to identify the heap the buffer was
> allocated from somehow. This kind of assumes that you only ever get one
> source of protected memory, and you'd never allocate a protected buffer
> from a different one in the codec driver for example.

Yes, and that's why having the ability to check that a buffer comes
from a particular heap is key. I mean, we don't necessarily have to
restrict things to a single heap, it can be a whitelist of heaps we know
provide protected buffers if we see a value in having multiple
protected heaps coexisting on a single platform.

Regards,

Boris

