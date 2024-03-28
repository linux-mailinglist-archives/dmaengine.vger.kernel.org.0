Return-Path: <dmaengine+bounces-1591-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851D88F687
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 05:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652BB1F278B3
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FA383A6;
	Thu, 28 Mar 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcLKeHdc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDE20DF7;
	Thu, 28 Mar 2024 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601067; cv=none; b=hR2VFWnseXuZpa1ZxViNFHQEStPOpPnh9Bdw0o3HTsL1zbjrXRjxf1MIK49y9080vvZSRKkkzCeORer89ZJJ90X5FUz4DTq5mQsZsuW6NMmHauVNLi9qPx+ofbXjloB5D+956299t7ncJVJ0bwEI4BHOfAlycZRwQ7Nd1tEljow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601067; c=relaxed/simple;
	bh=G/uMP0Jr/IMj7Bx03Ad/dEn1bkgBD3RDR6go4r8KZns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPDKLfmOWooGTpa8OU3ZNNq6odQ+GmGUVISB9gBJxoMV/21bTd4P6a5swp8/HsLQgQOJS+DNUmNKR00KbQ4x1MvsDealrGCtSDdiIaR9w5c42x7oxxOm9ho4AuaP8VCQG4UauURykFgENLtYId3ClkgTv3o2z30F1BnrgW22qQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcLKeHdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B541BC433F1;
	Thu, 28 Mar 2024 04:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711601066;
	bh=G/uMP0Jr/IMj7Bx03Ad/dEn1bkgBD3RDR6go4r8KZns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcLKeHdcge+LTpf1C8TtEmL5YuAKbmaxRF9tqyBGFZAM2C/feRYn1OriR14iv5Stw
	 C6PssG9E3J+QIvD2cnj7vrh3VPmqEh2ipiLCCk2ich6AARMW3RvHiwuwzowYW3ATC1
	 yqXiw+1IBaRupFPgQ24kOXNaqHMy1ib3e15zjNqeCtmgLUZYNSIvLFczmU2tj+3e3D
	 Zg47oU4bSl4eBWzg16rYIeDl+f/8SlpW5ouD97flvgHW/8Lbs79qXTHWwtNiSYVPg6
	 s1cIBf2CYnn8QoaUbT3tvEUOXIQwUUjAkiOWjTLSHRzcZwk/5W6m95tq5RkQAGQquC
	 /yCwfrSlgGQkw==
Date: Thu, 28 Mar 2024 10:14:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 38/38] dma: cirrus: remove platform code
Message-ID: <ZgT1lkJYP-beY_i0@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-38-156e2ae5dfc8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-ep93xx-v9-38-156e2ae5dfc8@maquefel.me>

On 26-03-24, 12:19, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>

s/dma/dmaengine is subject line

> 
> Remove DMA platform header, from now on we use device tree for DMA
> clients.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/dma/ep93xx_dma.c                 |  48 ++++++++++++++-
>  include/linux/platform_data/dma-ep93xx.h | 100 -------------------------------
>  2 files changed, 46 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 17c8e2badee2..43c4241af7f5 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -17,6 +17,7 @@
>  #include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> @@ -25,8 +26,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -#include <linux/platform_data/dma-ep93xx.h>
> -
>  #include "dmaengine.h"
>  
>  /* M2P registers */
> @@ -106,6 +105,26 @@
>  #define DMA_MAX_CHAN_BYTES		0xffff
>  #define DMA_MAX_CHAN_DESCRIPTORS	32
>  
> +/*
> + * M2P channels.
> + *
> + * Note that these values are also directly used for setting the PPALLOC
> + * register.
> + */
> +#define EP93XX_DMA_I2S1			0
> +#define EP93XX_DMA_I2S2			1
> +#define EP93XX_DMA_AAC1			2
> +#define EP93XX_DMA_AAC2			3
> +#define EP93XX_DMA_AAC3			4
> +#define EP93XX_DMA_I2S3			5
> +#define EP93XX_DMA_UART1		6
> +#define EP93XX_DMA_UART2		7
> +#define EP93XX_DMA_UART3		8
> +#define EP93XX_DMA_IRDA			9
> +/* M2M channels */
> +#define EP93XX_DMA_SSP			10
> +#define EP93XX_DMA_IDE			11
> +
>  enum ep93xx_dma_type {
>  	M2P_DMA,
>  	M2M_DMA,
> @@ -242,6 +261,31 @@ static struct ep93xx_dma_chan *to_ep93xx_dma_chan(struct dma_chan *chan)
>  	return container_of(chan, struct ep93xx_dma_chan, chan);
>  }
>  
> +static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
> +{
> +	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
> +		return true;
> +
> +	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
> +}
> +
> +/*
> + * ep93xx_dma_chan_direction - returns direction the channel can be used
> + *
> + * This function can be used in filter functions to find out whether the
> + * channel supports given DMA direction. Only M2P channels have such
> + * limitation, for M2M channels the direction is configurable.
> + */
> +static inline enum dma_transfer_direction
> +ep93xx_dma_chan_direction(struct dma_chan *chan)
> +{
> +	if (!ep93xx_dma_chan_is_m2p(chan))
> +		return DMA_TRANS_NONE;
> +
> +	/* even channels are for TX, odd for RX */

Is this a SW limitation and HW one?

> +	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> +}
> +
>  /**
>   * ep93xx_dma_set_active - set new active descriptor chain
>   * @edmac: channel
> diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
> deleted file mode 100644
> index 9ec5cdd5a1eb..000000000000
> --- a/include/linux/platform_data/dma-ep93xx.h
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_ARCH_DMA_H
> -#define __ASM_ARCH_DMA_H
> -
> -#include <linux/types.h>
> -#include <linux/device.h>
> -#include <linux/dmaengine.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/property.h>
> -#include <linux/string.h>
> -
> -/*
> - * M2P channels.
> - *
> - * Note that these values are also directly used for setting the PPALLOC
> - * register.
> - */
> -#define EP93XX_DMA_I2S1		0
> -#define EP93XX_DMA_I2S2		1
> -#define EP93XX_DMA_AAC1		2
> -#define EP93XX_DMA_AAC2		3
> -#define EP93XX_DMA_AAC3		4
> -#define EP93XX_DMA_I2S3		5
> -#define EP93XX_DMA_UART1	6
> -#define EP93XX_DMA_UART2	7
> -#define EP93XX_DMA_UART3	8
> -#define EP93XX_DMA_IRDA		9
> -/* M2M channels */
> -#define EP93XX_DMA_SSP		10
> -#define EP93XX_DMA_IDE		11
> -
> -/**
> - * struct ep93xx_dma_data - configuration data for the EP93xx dmaengine
> - * @port: peripheral which is requesting the channel
> - * @direction: TX/RX channel
> - * @name: optional name for the channel, this is displayed in /proc/interrupts
> - *
> - * This information is passed as private channel parameter in a filter
> - * function. Note that this is only needed for slave/cyclic channels.  For
> - * memcpy channels %NULL data should be passed.
> - */
> -struct ep93xx_dma_data {
> -	int				port;
> -	enum dma_transfer_direction	direction;
> -	const char			*name;
> -};
> -
> -/**
> - * struct ep93xx_dma_chan_data - platform specific data for a DMA channel
> - * @name: name of the channel, used for getting the right clock for the channel
> - * @base: mapped registers
> - * @irq: interrupt number used by this channel
> - */
> -struct ep93xx_dma_chan_data {
> -	const char			*name;
> -	void __iomem			*base;
> -	int				irq;
> -};
> -
> -/**
> - * struct ep93xx_dma_platform_data - platform data for the dmaengine driver
> - * @channels: array of channels which are passed to the driver
> - * @num_channels: number of channels in the array
> - *
> - * This structure is passed to the DMA engine driver via platform data. For
> - * M2P channels, contract is that even channels are for TX and odd for RX.
> - * There is no requirement for the M2M channels.
> - */
> -struct ep93xx_dma_platform_data {
> -	struct ep93xx_dma_chan_data	*channels;
> -	size_t				num_channels;
> -};
> -
> -static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
> -{
> -	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
> -		return true;
> -
> -	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
> -}
> -
> -/**
> - * ep93xx_dma_chan_direction - returns direction the channel can be used
> - * @chan: channel
> - *
> - * This function can be used in filter functions to find out whether the
> - * channel supports given DMA direction. Only M2P channels have such
> - * limitation, for M2M channels the direction is configurable.
> - */
> -static inline enum dma_transfer_direction
> -ep93xx_dma_chan_direction(struct dma_chan *chan)
> -{
> -	if (!ep93xx_dma_chan_is_m2p(chan))
> -		return DMA_TRANS_NONE;
> -
> -	/* even channels are for TX, odd for RX */
> -	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> -}
> -
> -#endif /* __ASM_ARCH_DMA_H */
> 
> -- 
> 2.41.0
> 

-- 
~Vinod

