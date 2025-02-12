Return-Path: <dmaengine+bounces-4426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9AAA32391
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CCD188B4FD
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19C2080EA;
	Wed, 12 Feb 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I8pUmckE"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BED1F9A83;
	Wed, 12 Feb 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356661; cv=none; b=cwpIwmXlVMixuInCaKcJQH0q7mG2i+FHDsC52BQgZQU6ya106gOMbzYdp6jSJ8ZuPlOt7Bw3gHmKCqD/6sV0C2+RfikNEJGizT+iqz/3peRoSOixEG8rhnSlANmxL7sfU58mnRfbrWtke0y46LCNyjb8S8Ggndpvb5f7i3NeG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356661; c=relaxed/simple;
	bh=k/xHaZw9Tz6lmoCuwwVAm04oRGKiqCf1wbcqAMZmcVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRXwIGzLenElNQGqoTOAmD/1i5ZwijKLBbBjszGLP02mCcZrfetJ+D38CYP4atttEDyg5UTne83QANCLxtWhMMQ2quyraNv/HUKOw00DlHU4KcZo/VyA0c0ZGjrL+NCXNZJY3nRMRAa6aSDZ+0hzt/dyH8zvM0NJ4VC4Tl6I0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I8pUmckE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739356657;
	bh=k/xHaZw9Tz6lmoCuwwVAm04oRGKiqCf1wbcqAMZmcVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8pUmckE/VrhFzGJrHFb8l3kffAS9Zu0hipC0goSWw9N174CY9irmhDzjVC4TY7pp
	 7QS1MRIpLIqM6he/PPxwBd6rdKs7sD9DbphMcyFyPHrTris+QRjVVNHp2uoatKBd9L
	 IwC713km8Xc7Uk4I293gmxlW6j7GYXlnnw6jN3DHeRtnnwZdu/wfqZBaBOIBp+dPSE
	 ZcgECT8w3mJf95orzRzXdXH0Q9IWM+CY38j0sUFMqpBseuLHw2Y5KhyWdonIYeMGj6
	 SU6zA9IHHfo8Wv6xXP2aNRrVrpgUa/M2ip3fAaexclT0ekzgymM1yf75g9X/5VFQa3
	 v1rjIVI0lhntQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FF5A17E0ECF;
	Wed, 12 Feb 2025 11:37:36 +0100 (CET)
Date: Wed, 12 Feb 2025 11:37:15 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Florent Tomasin <florent.tomasin@arm.com>, Nicolas Dufresne
 <nicolas@ndufresne.ca>, Vinod Koul <vkoul@kernel.org>, Rob Herring
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
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Message-ID: <20250212113715.166def88@collabora.com>
In-Reply-To: <20250212-naughty-chipmunk-of-potency-7e0ced@houat>
References: <cover.1738228114.git.florent.tomasin@arm.com>
	<771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
	<ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
	<be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
	<b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
	<fae8df2a-3e47-4266-aace-392c5f37581f@arm.com>
	<20250212-naughty-chipmunk-of-potency-7e0ced@houat>
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

On Wed, 12 Feb 2025 11:01:11 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Wed, Feb 12, 2025 at 09:49:56AM +0000, Florent Tomasin wrote:
> > Note that the CMA patches were initially shared to help reproduce my
> > environment of development, I can isolate them in a separate patch
> > series and include a reference or "base-commit:" tag to it in the
> > Panthor protected mode RFC, to help progress this review in another
> > thread. It will avoid overlapping these two topics:
> > 
> > - Multiple standalone CMA heaps support
> > - Panthor protected mode handling  
> 
> You keep insisting on using CMA here, but it's really not clear to me
> why you would need CMA in the first place.

CMA is certainly not the solution. As Florent said, it's just here to
help people test the panthor protected-mode feature without having to
pull Mediatek's protected heap implementation, which currently
lives in some vendor tree and is thus quite painful to integrate to a
vanilla kernel.

I would suggest keeping those patches in a public tree we can point to,
and dropping them from v2, to avoid the confusion.

> 
> By CMA, do you mean the CMA allocator, and thus would provide buffers
> through the usual dma_alloc_* API, or would any allocator providing
> physically contiguous memory work?

Panthor can work with the system heap too AFAICT (I've done my testing
with the system heap, and it seems to work fine). It gets tricky when
you want to allocate protected scanout buffers and import them in the
KMS device though. But as said above, we shouldn't really bother
exposing custom CMA heaps, because that's not what we want to use
ultimately. What we'll want is some ATF implementation for protected
memory, that we can rely on to implement a standard protected dma-heap
implementation, I guess.

> 
> In the latter case, would something like this work:
> https://lore.kernel.org/all/20240515-dma-buf-ecc-heap-v1-1-54cbbd049511@kernel.org/
> 
> Maxime


