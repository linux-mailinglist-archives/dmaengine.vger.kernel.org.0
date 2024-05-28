Return-Path: <dmaengine+bounces-2191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03898D146E
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 08:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512B21F21B85
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331554FAF;
	Tue, 28 May 2024 06:33:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDC22067;
	Tue, 28 May 2024 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878021; cv=none; b=hkJmYjUA9QkzuNELrD/beU6OtOp88laWpLM71N7Ac+gYM2Bb02cY7D0HXhmGChEVdaaZI8pgnlZL8ATT9TU9zNcIG5eY6ww2crldEvS4BKv/DHCYeWdJm73Zi6IdrHpN3jgNab4cTZIp5wgU+wRpkoJIMBGj4xlKsq3PihlYzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878021; c=relaxed/simple;
	bh=ldjbI0S/6R2kqmtohSnLqSpSiUjP7PyHc2GT7iFo/70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7kY6VR0OnHy4UzdtzdRjJxtgIauAy/dj1jNaw2TTt51fw3eLPim4WXZw2o/C+0TP2r0+plRdWyfwXDscHaklgoSf191csT6xr+hR9VfcxjrbDpe3je3VdrWthFBewp5P8hSpYfPPiRc89B0cdmE3BJ74uWXJgdjPK1b9y4QJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED81868BEB; Tue, 28 May 2024 08:33:32 +0200 (CEST)
Date: Tue, 28 May 2024 08:33:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
	iommu@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/18] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20240528063332.GA30051@lst.de>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com> <20240524182702.1317935-2-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524182702.1317935-2-dave.stevenson@raspberrypi.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 24, 2024 at 07:26:45PM +0100, Dave Stevenson wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> A basic device-specific linear memory mapping was introduced back in
> commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
> preserved in the device.dma_pfn_offset field, which was initialized for
> instance by means of the "dma-ranges" DT property. Afterwards the
> functionality was extended to support more than one device-specific region
> defined in the device.dma_range_map list of maps. But all of these
> improvements concerned a single pointer, page or sg DMA-mapping methods,
> while the system resource mapping function turned to miss the
> corresponding modification. Thus the dma_direct_map_resource() method now
> just casts the CPU physical address to the device DMA address with no
> dma-ranges-based mapping taking into account, which is obviously wrong.
> Let's fix it by using the phys_to_dma_direct() method to get the
> device-specific bus address from the passed memory resource for the case
> of the directly mapped DMA.

My memory is getting a little bad, but as dma_direct_map_resource is
mostly used for (non-PCIe) peer to peer transfers, any kind of mapping
from the host address should be excluded.

(dma_direct_map_resource in general is a horrible interface and I'd
prefer everyone to switch to the map_sg based P2P support, but we
have plenty of users for it unfortunately)


