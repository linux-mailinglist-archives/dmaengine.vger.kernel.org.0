Return-Path: <dmaengine+bounces-1398-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A050C87DD39
	for <lists+dmaengine@lfdr.de>; Sun, 17 Mar 2024 13:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372391F21317
	for <lists+dmaengine@lfdr.de>; Sun, 17 Mar 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A41B28D;
	Sun, 17 Mar 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PN0199Zw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67C136A;
	Sun, 17 Mar 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710680156; cv=none; b=pwRlXr06Kiq+rcaOdc8H4f9QQONA6Sc1x1kV9Dd/nQdygftcQYFCo9GCKezB18cho4YhyrTfL26wltQzCYIULbi5GdjRZ53o6Zwaq3ACnOFf3JQWSplrv9IAsohdfJYS5X3H8lCofzQ+5q51P+5DrB3lDpuu0ZD0D7tas3R33Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710680156; c=relaxed/simple;
	bh=xwrmrE8IcvQB6scD2/O+jg7MyJ4j0/Sl++hhinClxKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKNXMsRdfLGuRwoUCum+sSMQ2UjKuLfP8nTqsDiYgnP5CRCpYQWKfStS0e2YlG2t820mCYWvasRv6x+RUfQMttRvLBInhkLzxZE/h8Q9ZLgsDqBd05VlvPzelsqC1wiC3A+BQszaLQUhLdeXP7tPog2NSZkgmGWSdgzP+jDJCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PN0199Zw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1710680134; x=1711284934; i=wahrenst@gmx.net;
	bh=3eOlEoN6SfpTcqL+Nb/fFWrFrYcV/qmikqb4ystGr/4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PN0199ZwKmpeUW8FGzs8yhLcUD3TeOi1qkkqcuo4Bc28tWp+qPI28ajvp0H5+qv/
	 rlb37+dP6JTcV1aAeZKu/uFSBPeVmXhIRm5mHqNlaOagFtsb515NdHN52Mx9om+S9
	 GMnhn3pOd/cKu1mHtQdddIBBReGvAsD7yZIwvVn/SgB4KP8ps43pc4dYAYCGnhXPF
	 AQ5fTuxPJ7uv++s4P+6ODf+2r/8YcPqiRB6DpWoGtVBMlgsJa3Jr3+4pjd9f164el
	 6GGEclAVW8JwmSiMYUzeWyDkL4EwomOTCoq45tTaaJemyKLXhHAUf8lCWTNo+HXSq
	 9AQTsIUxX1rvmxYo9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1raGXk1cNO-00Fycb; Sun, 17
 Mar 2024 13:55:34 +0100
Message-ID: <dd29bcb5-f737-4e89-b296-db54e13df9ee@gmx.net>
Date: Sun, 17 Mar 2024 13:55:32 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] dmaengine: bcm2835: Add support for per-channel
 flags
Content-Language: en-US
To: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul
 <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Saenz Julienne <nsaenz@kernel.org>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>, Maxime Ripard <maxime@cerno.tech>,
 Dom Cobley <popcornmix@gmail.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
 <da598378f733a8d45a35ed77f9626cc082262b1a.1710226514.git.andrea.porta@suse.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <da598378f733a8d45a35ed77f9626cc082262b1a.1710226514.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jub8QDgSnZ8AbSgBVMW8uke/xMwe9dhFq6FVCojQ8aQHsYD5xYe
 57cmu43IYbWzOV29/Z70p0cFAl1m0UJhGxktZFocGeazwdn5/qoXVRNxT/gMA3YYJMBbutd
 Yiz68XaOVZACJ1WA216mIwJDnGJXJAF7j0OEVYLlooR1Iioj3GLQolceZ4jPPIN6qx7zcol
 QDgqRuRxVGBgwpCQQcf0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TIF9uqa/PxY=;6PRj0Lq0EZp9bJwDP99uvSFDlZM
 SV13KTGpVXH7plqQz1K1PxEhcvGYUk9dFFaA9rhtE8ThE2BL21RrBB9eGHlhaF1ufG5h7SuIb
 A73Bkhg8wBm+OkBbu8kTy2gY5op83w8KOuyO9pRjEN+FWHj28GLzFoLzUe71Y57knzfwd+ziN
 De32tMBj5/liKY4VJZhYQHnUsp7RFKc6E5lQJRxYNH0hXIeq4SbmwllAnHQWW3vbCK7VoxWMt
 bhSttjcB+cHB+871Ka3U1HVl5GDEsenHxWHnkej69mWS5RcpuCIDoIhdn/pGntlZvpr0lantT
 z6/No3yXtXZZDVF0B/iWMRfnybdzglpjNhaLimHYkWxeY45uLhPJxWcpj8vhC7BfCn7EY9paL
 EMb42osDcjDa6bT96UwBgnB55jun21yDt8WXGhNYUFuFWJ+Ekx39D823PdpC9AIURdzKRtS4D
 Dg60kkGrvGcmQYS3zLqH9ocU3DXRw6Gk0F/ei99rA4QxVYWI0qVT6qqpwTF0hR3Hy6kOpHafS
 7bigysWVk7iC8WsjP5eANJxtFNJgi1jZfCLsXlJqLEVoeeRU8YObYTZsMcYbmLgMnVpVSZnFh
 54gfdUD4U7RHtXtGZsyYrnCnpl6bWXVy2OC5pQuNhZMnaxC9zOw3c4DmR8QHMOsa3zmdVets8
 JKGyFpU3u0D5MKBpIjImOGGTuLeY7dXGWNqr5PVaQue8hvceObdLCdWY/s5TAeIdgEOQ6lfkU
 yPAjiGOCIuoOvPKPSoK99RUfv1kqCUEPHwelDv35Ha5SS4WJ5iDj+Nesn+3gO+2QKQyOOc9CL
 1qYxP0gw4PzhpbQSfoq/SJ+umz3zkmvnwMqUNWaiXVbFE=

Hi Andrea,

Am 13.03.24 um 15:08 schrieb Andrea della Porta:
> From: Phil Elwell <phil@raspberrypi.org>
>
> Add the ability to interpret the high bits of the dreq specifier as
> flags to be included in the DMA_CS register. The motivation for this
> change is the ability to set the DISDEBUG flag for SD card transfers
> to avoid corruption when using the VPU debugger.

AFAIK this and the following 2 patches also requires modification on the
DT side. So either they must be included in the series or we better
leave them out completely. I'm not sure which one are really necessary
for 40 bit support.

Regards

>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   drivers/dma/bcm2835-dma.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 428253b468ac..3d9973dd041d 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -137,6 +137,10 @@ struct bcm2835_desc {
>   #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
>   #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 *=
/
>   #define BCM2835_DMA_BURST_LENGTH(x) (((x) & 15) << 12)
> +#define BCM2835_DMA_CS_FLAGS(x) ((x) & (BCM2835_DMA_PRIORITY(15) | \
> +				      BCM2835_DMA_PANIC_PRIORITY(15) | \
> +				      BCM2835_DMA_WAIT_FOR_WRITES | \
> +				      BCM2835_DMA_DIS_DEBUG))
>   #define BCM2835_DMA_PER_MAP(x)	(((x) & 31) << 16) /* REQ source */
>   #define BCM2835_DMA_WAIT(x)	(((x) & 31) << 21) /* add DMA-wait cycles =
*/
>   #define BCM2835_DMA_NO_WIDE_BURSTS BIT(26) /* no 2 beat write bursts *=
/
> @@ -449,7 +453,8 @@ static void bcm2835_dma_start_desc(struct bcm2835_ch=
an *c)
>   	c->desc =3D to_bcm2835_dma_desc(&vd->tx);
>
>   	writel(c->desc->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
> -	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
> +	writel(BCM2835_DMA_ACTIVE | BCM2835_DMA_CS_FLAGS(c->dreq),
> +	       c->chan_base + BCM2835_DMA_CS);
>   }
>
>   static irqreturn_t bcm2835_dma_callback(int irq, void *data)
> @@ -476,7 +481,8 @@ static irqreturn_t bcm2835_dma_callback(int irq, voi=
d *data)
>   	 * if this IRQ handler is threaded.) If the channel is finished, it
>   	 * will remain idle despite the ACTIVE flag being set.
>   	 */
> -	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
> +	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE |
> +	       BCM2835_DMA_CS_FLAGS(c->dreq),
>   	       c->chan_base + BCM2835_DMA_CS);
>
>   	d =3D c->desc;

