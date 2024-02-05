Return-Path: <dmaengine+bounces-960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342084A6B0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 22:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2253D1C2652D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Feb 2024 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB94F5EF;
	Mon,  5 Feb 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="CFGjo7pS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB804F5E9;
	Mon,  5 Feb 2024 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160003; cv=none; b=Q7RtfQ3G5pIIOnNG9CA3JGIkH4r9pPkC8BSlAXtynOqakeWGYqmquGRJ+F2+Tj61+J1Fez4xFElDHIFqY1bfJwIbZeTxG+lEFSnuW6pVUR2ap0g7Yt2IEBBzKcEXD+4aToV6baUuOjbABeI6ncIkjX/6w7LcMOrV3HgFSYo+3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160003; c=relaxed/simple;
	bh=e2OL4EiWvWIn9xVFVK1QFdVDd5fgSWtFdp0kgfHTXGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NevAqEeOzjGax+Ce16GvJ9PVH7Tn8SzUSGYPkOdXozpdiAEJMwFdw77Sp1zj73uGzfj5sdxTycQ/NOck161Zq9h4gN49YhB/u4ch66Z3Q6TMA3yRpl5EdgWGY8Ad7VNXkasSzI9EsM92QqllxQGUcjYbGOqbWE6T/l7dh+d83s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=CFGjo7pS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707159986; x=1707764786; i=wahrenst@gmx.net;
	bh=e2OL4EiWvWIn9xVFVK1QFdVDd5fgSWtFdp0kgfHTXGM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=CFGjo7pS2S2sF0CGwdUzGzoBAgKOXGcn82YLTASuQPe9G6Q83AqbLoZ/YEtPcNe4
	 lfOqdi1GlbnHa4V6E10vBUqg2Ygkm1hhPSsAoDuxRM3piFFe+ehxUC61NvvNU8gaR
	 vAX9vfUnjKGo/z4by0mTaUWu0Qqt4TzSFrZcrIEImTjhc8AmZron26KbFHczYE+FZ
	 jO/zlGPHthvY12+T85z+iXCNK3r2ycNdzdQbo0Vq90Hd03J7wLfwSA5vvCVcsquos
	 f5EHOXY2LFevX9RvPNc6MDb0LrwgVGICfxzUQ0id52+sDaW/YH+weiGBFWISaWUVt
	 QffHEKoLjx2uqxN5Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1qi8N22ow2-00shgQ; Mon, 05
 Feb 2024 20:06:26 +0100
Message-ID: <a12a0bf1-c59d-4b87-87ac-546f0f5e8d72@gmx.net>
Date: Mon, 5 Feb 2024 20:06:25 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Add support for BCM2712 DMA engine
Content-Language: en-US
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1706948717.git.andrea.porta@suse.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <cover.1706948717.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJiNqVk/3+nZThAYal+pN6vhJK0NctDKoVu/OKHGcg10XoKbpGu
 cuY8O8OOO1QONMKNJZVAfo6x3fzZRJFIaUJj2nNiVl4mtHckd1HbZiV4l6W+PDnZ0H4qiUx
 pcKh8tu/G2meJTF2khqF4Nw81J8L0Z5BZLTzlGnylb2xBOjPP1c5C9U74C2WLCJaSTbRMql
 3fh07nh6ZGRKXg+johyCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D0ByTQ4dxtk=;wVGIfcHu2aqaBPu4fkqTwf9T5Wz
 sthJxR2uEffnPYrkNDt7HwyWrQuU8aOC/YFD3SQsSE8hLvz67vi7VM0cjLvXZ0CitMAZp8SGD
 17s2jUrjvNo1IWDtoA4AQi2Dr4MiaphAs89o3WBvv2BgRUZmlG5ub0Us5irBWEGAlONyRPAKU
 Sj0ObMkaSAsEGYtnSq2KOLFGLsI8q26ec8GhaBZqjOephWoC1IqDkeDJkVb09X9KiErCmhTfO
 B2zBfvF44ruSXlZI5GWqSsxjadCajaL2AyMfGSnXocfYMoRv8+ECMhoTuweZJAZ2JVbGXRAbi
 nHQy8rkUd9r+2yRiayNrrcwg91gUvL7H+6mmvwodXCjUxJfydJyHEBSnKLquYVTyS9S29ZJLc
 vomggZHaG6lHgaug6clsoRk5PFM7zR3d3KJ45X7oHkdt0p+UOu5QHaSlcca4Jh8eIfGiOj9uq
 sPiuxJDyl9aT7C3bV7AJFRBNOOW3ehBVuFfd86t/mEQOloAKScTnVRozFb18coNui+TcE0Izi
 leFf/NVBxuZlknRpygDQjz74Fk7ID7W3zYTPBrKGEH9vrtKeN1t8KtIfhOYl+P0kc7XnPaIyA
 46QxH5847H1XTP57224inOS65uUzIPcGVZpphwIMv6003dP/TnPbjEEp4T++/IlJYhtXWpQPy
 b/cNvq506jtn6PdVARCbvxDKZLhWWqp1i6IbII7lpvRl6gD0dAf3azK2Gfn9dF4ZJ4Gy5OnMM
 72DrFB5oAlDmcQ864YogPaNglENiSk4L2fqVegyG9+HCt/BP7KRmZjplqrMoYC0WPn1o+/P4A
 ZJ3hfRM8ZGYtvxGkipp6Dwtb40d0cOLYIb7cbPP9Pj6oI=

Hi Andrea,

Am 04.02.24 um 07:59 schrieb Andrea della Porta:
> This patchset aims to update the dma engine for BCM* chipset with respec=
t
> to current advancements in downstream vendor tree. In particular:
>
> * Added support for BCM2712 DMA.
> * Extended DMA addressing to 40 bit. Since BCM2711 also supports 40 bit =
addressing,
> it will also benefit from the update.
> * Handled the devicetree node from vendor dts (e.g. "dma40").
>
> The only difference between the application of this patch and the relati=
ve code
> in vendor tree is the dropping of channel reservation for BCM2708 DMA le=
gacy
> driver, that seems to have not made its way to upstream anyway, and it's
> probably used only from deprecated subsystems.
>
> Compile tested and runtime tested on RPi4B only.
sorry but this is not sufficient. AFAIK only the Raspberry Pi 5 has a
BCM2712. I suggest to start with BCM2711 40 bit support, which is enough
work.

This whole series does neither contain a change to the dt-bindings nor
to the DTS files. This is not how it works.

Best regards
>
> Dom Cobley (4):
>    bcm2835-dma: Support dma flags for multi-beat burst
>    bcm2835-dma: Need to keep PROT bits set in CS on 40bit controller
>    dmaengine: bcm2835: Rename to_bcm2711_cbaddr to to_40bit_cbaddr
>    bcm2835-dma: Fixes for dma_abort
>
> Maxime Ripard (2):
>    dmaengine: bcm2835: Use to_bcm2711_cbaddr where relevant
>    dmaengine: bcm2835: Support DMA-Lite channels
>
> Phil Elwell (6):
>    bcm2835-dma: Add support for per-channel flags
>    bcm2835-dma: Add proper 40-bit DMA support
>    bcm2835-dma: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and DMA_WIDE_DEST flag
>    bcm2835-dma: Advertise the full DMA range
>    bcm2835-dma: Derive slave DMA addresses correctly
>    dmaengine: bcm2835: Add BCM2712 support
>
>   drivers/dma/bcm2835-dma.c | 701 ++++++++++++++++++++++++++++++++------
>   1 file changed, 588 insertions(+), 113 deletions(-)
>


