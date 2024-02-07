Return-Path: <dmaengine+bounces-965-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E005484C619
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D77E1F229F2
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1A200BE;
	Wed,  7 Feb 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chi+r8jn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FDD200BA;
	Wed,  7 Feb 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293991; cv=none; b=mz4i5lXOOhcffu/4USoZ99y2ndcRW9yclPhgzmJMsKI2zRqLWpL6TnUFOlCUQTUHb3Qf0rMeeFfHaaryeyBcVwNU8GK+5/gYTaNpzkTJ3IAFHrAry/wrpkPWjwE71j6lLAm58BKQxOuS9avOa14z8UnM7Nxoy6gE6AuAD7CIO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293991; c=relaxed/simple;
	bh=+sQ5L6rGBsn2M996CLaOLE7iyMKt30Zg+NEaU+RovJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSK2SdVNvnTRuoZs6tmUTVcSDP8Gonz79TcPVZgMQR42465hx5/q+YMWsOLAwETUdQshHxegi1YqS+fPl6gKjQCjNVE692EjDe5eyFvYptq2IL6dxMJc4noWvUA9EMuiwNFcHFxB7r2pxZ4ZpKx1bnaXMGeIY0+FsD56jhDOQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chi+r8jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00540C433C7;
	Wed,  7 Feb 2024 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707293990;
	bh=+sQ5L6rGBsn2M996CLaOLE7iyMKt30Zg+NEaU+RovJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Chi+r8jnVDNxdg4OKMOcUAwAT8K7f3du0gXeb/kEWU5YIcUw5nLi5sEvEy/yghrOj
	 pRT6L2oNaRbXWwUxvnhgRq6pyThhfjylfjrhAEPS7edfRORjVu7wp0RDNexGfO0AR+
	 MlYubfCxW7PQAQ5D/iazBvKS2t5VJg9R1P4R25jSAOdSt61RV71c39hYVFfM8z3XnA
	 zY4fRzUMQWUc2CYwNYtf8llDXLal9H+SOsLWctPN8h1T5kUonBVLcgvZNZAzB9a5wj
	 sCaOohs7HL9keZXJmJoPN71GCNJ3T/BPfD5nfwHc5l1mvjOFnhNsjOwpeZuU8IQ0uR
	 /t6ES/82DDZdw==
Date: Wed, 7 Feb 2024 09:19:47 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 00/12] Add support for BCM2712 DMA engine
Message-ID: <ZcM9I-U3w7xRcWVt@matsya>
References: <cover.1706948717.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706948717.git.andrea.porta@suse.com>

On 04-02-24, 07:59, Andrea della Porta wrote:
> This patchset aims to update the dma engine for BCM* chipset with respect
> to current advancements in downstream vendor tree. In particular:
> 
> * Added support for BCM2712 DMA.
> * Extended DMA addressing to 40 bit. Since BCM2711 also supports 40 bit addressing,
> it will also benefit from the update.
> * Handled the devicetree node from vendor dts (e.g. "dma40").
> 
> The only difference between the application of this patch and the relative code
> in vendor tree is the dropping of channel reservation for BCM2708 DMA legacy
> driver, that seems to have not made its way to upstream anyway, and it's
> probably used only from deprecated subsystems.
> 
> Compile tested and runtime tested on RPi4B only.
> 
> Dom Cobley (4):
>   bcm2835-dma: Support dma flags for multi-beat burst
>   bcm2835-dma: Need to keep PROT bits set in CS on 40bit controller
>   dmaengine: bcm2835: Rename to_bcm2711_cbaddr to to_40bit_cbaddr
>   bcm2835-dma: Fixes for dma_abort
> 
> Maxime Ripard (2):
>   dmaengine: bcm2835: Use to_bcm2711_cbaddr where relevant
>   dmaengine: bcm2835: Support DMA-Lite channels
> 
> Phil Elwell (6):
>   bcm2835-dma: Add support for per-channel flags
>   bcm2835-dma: Add proper 40-bit DMA support
>   bcm2835-dma: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and DMA_WIDE_DEST flag
>   bcm2835-dma: Advertise the full DMA range
>   bcm2835-dma: Derive slave DMA addresses correctly
>   dmaengine: bcm2835: Add BCM2712 support
> 
>  drivers/dma/bcm2835-dma.c | 701 ++++++++++++++++++++++++++++++++------
>  1 file changed, 588 insertions(+), 113 deletions(-)

Everything is modifying one file and still you have 2 different tags for patches, why?

Consistency is a good thing, right...

-- 
~Vinod

