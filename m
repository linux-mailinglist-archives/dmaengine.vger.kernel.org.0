Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B22EB9FB
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jan 2021 07:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbhAFGZi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jan 2021 01:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbhAFGZi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Jan 2021 01:25:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49481207B2;
        Wed,  6 Jan 2021 06:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609914297;
        bh=y+0zaAn5avtMtf02YYNkF8iT84BXfRL1v9Z7Is+W+hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jx+3v0oBYO/hbO1+6ETQe3F/VFiOZPtbTBNgXD/Pp8xpN4LKh4330rBi2fW2Pxy5V
         oq7OzA+Ju4lCk4t/QJM5NAh20PhgPrgGV/9ubUHefeM01tmGnoDL1JhZG7zCq3l+z5
         5WgMrVHJbB01zZCMtE2KVDgb4/amrSe5BB7i9NaVNSzgxX6qqn0UDuG3IeqVeOSSlp
         B49X0Lvf2YoMbWTSVnKdbm/Yxre2D5XSmZr1Uy5Gp4eevi82xKegKZRVIQuhqeBcuP
         8BEl82ipSIbXDsb074gjtW8zUjWN5gCd5IxtBh4ImE3I9blxSWG4kDkBcqjFp6kxn8
         9rbKeAgYHHnNg==
Date:   Wed, 6 Jan 2021 11:54:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_hdmac: remove platform data header
Message-ID: <20210106062453.GR2771@vkoul-mobl>
References: <20201228203022.2674133-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228203022.2674133-1-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-12-20, 21:30, Alexandre Belloni wrote:
> linux/platform_data/dma-atmel.h is only used by the at_hdmac driver. Move
> the CFG bits definitions back in at_hdmac_regs.h and the remaining
> definitions in the driver.

Applied, thanks...

>  /* Bitfields in CFG */
> -/* are in at_hdmac.h */
> +#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
> +
> +#define	ATC_SRC_PER(h)		(0xFU & (h))	/* Channel src rq associated with periph handshaking ifc h */
> +#define	ATC_DST_PER(h)		((0xFU & (h)) <<  4)	/* Channel dst rq associated with periph handshaking ifc h */
> +#define	ATC_SRC_REP		(0x1 <<  8)	/* Source Replay Mod */
> +#define	ATC_SRC_H2SEL		(0x1 <<  9)	/* Source Handshaking Mod */
> +#define		ATC_SRC_H2SEL_SW	(0x0 <<  9)
> +#define		ATC_SRC_H2SEL_HW	(0x1 <<  9)
> +#define	ATC_SRC_PER_MSB(h)	(ATC_PER_MSB(h) << 10)	/* Channel src rq (most significant bits) */
> +#define	ATC_DST_REP		(0x1 << 12)	/* Destination Replay Mod */
> +#define	ATC_DST_H2SEL		(0x1 << 13)	/* Destination Handshaking Mod */
> +#define		ATC_DST_H2SEL_SW	(0x0 << 13)
> +#define		ATC_DST_H2SEL_HW	(0x1 << 13)
> +#define	ATC_DST_PER_MSB(h)	(ATC_PER_MSB(h) << 14)	/* Channel dst rq (most significant bits) */
> +#define	ATC_SOD			(0x1 << 16)	/* Stop On Done */
> +#define	ATC_LOCK_IF		(0x1 << 20)	/* Interface Lock */
> +#define	ATC_LOCK_B		(0x1 << 21)	/* AHB Bus Lock */
> +#define	ATC_LOCK_IF_L		(0x1 << 22)	/* Master Interface Arbiter Lock */
> +#define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
> +#define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
> +#define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
> +#define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
> +#define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
> +#define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
> +#define		ATC_FIFOCFG_ENOUGHSPACE		(0x2 << 28)

Make these use BIT() or GENMASK() later..?

-- 
~Vinod
