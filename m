Return-Path: <dmaengine+bounces-4416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B675A309D5
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D803A2396
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A071F63FE;
	Tue, 11 Feb 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hMrujhFc"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435670807;
	Tue, 11 Feb 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272865; cv=none; b=iWNzxTFTegwmEh5yyixVK0TeMe/KzP7PS4UpakeZ6ytw7kc3JMXaXWrFGVF5wHHqvhQ5fR7eg7zcvNCfjQ5O1LUqj6YjbuF+myC0frtv4XyBq5FzJy2xINA+RyH5cCgM3HqryEi40osTKIIi+CXaxttK0OHxzITD8PJSKtEAqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272865; c=relaxed/simple;
	bh=uoP1nCCvDBGx8Z7jqAGdTm1hPsk3dkyFnV2/E09V82I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6xCWcSlXckiZTLw8VYOZmjbJRmiwVxVXC+sOiKikeOmWYTK3MqaL54zCi33t3qk/ODp9DT0qYuPbiynopixgatapuGX/XZzh7Jfgfmiz/jjl/luFQQ+jlICC8DorXM9s9My95WPVP3BXUpYQWRP8dogymdjWW1dfbG/aeFMAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hMrujhFc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739272861;
	bh=uoP1nCCvDBGx8Z7jqAGdTm1hPsk3dkyFnV2/E09V82I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMrujhFcOZq/4f66dL7dk+b6M2gxuegP3AwaTO8f1n9aKVEgZtlMNnY4Bhx/ejzMo
	 pGydGWXFHnA9dpurrQF5alPZvAbxpAYPoU8StnnR1TnOtC2kRfP0P0HWRkql/TO0D/
	 AO/IjMCit3Ob3tK2swaYdx2cFbxh+ddFXuYpgwwwBd/TLPrl0etaxbXsqx1rZMR+4S
	 qW2a+K82BrOMXpC4modD0gLaLNGAhu1FPLTJcT5saZWCgOb/A7j6w2vZofUsFr1CLV
	 5FdHFaAPaZrnZNYD5X11VJbi2Nzamdxrpz3mFC12cUu6rMtJJ8VrGRjTBAVvRBuD+w
	 85thIsVMvH2Jw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 77FD117E0657;
	Tue, 11 Feb 2025 12:21:00 +0100 (CET)
Date: Tue, 11 Feb 2025 12:20:52 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Florent Tomasin <florent.tomasin@arm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>,
 <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <nd@arm.com>, Akash Goel
 <akash.goel@arm.com>
Subject: Re: [RFC PATCH 4/5] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <20250211122052.3f550650@collabora.com>
In-Reply-To: <20250211120448.3e89e75f@collabora.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
	<821252c96ab2ab3e2d8ef211a09f8b171719baaa.1738228114.git.florent.tomasin@arm.com>
	<20250211120448.3e89e75f@collabora.com>
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

On Tue, 11 Feb 2025 12:04:48 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -9,10 +9,14 @@
> >  
> >  #include <drm/panthor_drm.h>
> >  
> > +#include <uapi/linux/dma-heap.h>
> > +
> >  #include "panthor_device.h"
> >  #include "panthor_gem.h"
> >  #include "panthor_mmu.h"
> >  
> > +MODULE_IMPORT_NS(DMA_BUF);  
> 
> Uh, that's ugly. If the consensus is to let panthor allocate
> its protected buffers from a heap, let's just add a dependency on
> DMABUF_HEAPS instead.

My bad, that one is required for dma_buf_put(). Should be

  MODULE_IMPORT_NS("DMA_BUF");

though.

