Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5332EBB91
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jan 2021 10:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbhAFJMR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jan 2021 04:12:17 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:16177 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAFJMP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jan 2021 04:12:15 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 49C3E240011;
        Wed,  6 Jan 2021 09:11:32 +0000 (UTC)
Date:   Wed, 6 Jan 2021 10:11:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_hdmac: remove platform data header
Message-ID: <20210106091131.GL122615@piout.net>
References: <20201228203022.2674133-1-alexandre.belloni@bootlin.com>
 <20210106062453.GR2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106062453.GR2771@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06/01/2021 11:54:53+0530, Vinod Koul wrote:
> On 28-12-20, 21:30, Alexandre Belloni wrote:
> > linux/platform_data/dma-atmel.h is only used by the at_hdmac driver. Move
> > the CFG bits definitions back in at_hdmac_regs.h and the remaining
> > definitions in the driver.
> 
> Applied, thanks...
> 
> >  /* Bitfields in CFG */
> > -/* are in at_hdmac.h */
> > +#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
> > +
> > +#define	ATC_SRC_PER(h)		(0xFU & (h))	/* Channel src rq associated with periph handshaking ifc h */
> > +#define	ATC_DST_PER(h)		((0xFU & (h)) <<  4)	/* Channel dst rq associated with periph handshaking ifc h */
> > +#define	ATC_SRC_REP		(0x1 <<  8)	/* Source Replay Mod */
> > +#define	ATC_SRC_H2SEL		(0x1 <<  9)	/* Source Handshaking Mod */
> > +#define		ATC_SRC_H2SEL_SW	(0x0 <<  9)
> > +#define		ATC_SRC_H2SEL_HW	(0x1 <<  9)
> > +#define	ATC_SRC_PER_MSB(h)	(ATC_PER_MSB(h) << 10)	/* Channel src rq (most significant bits) */
> > +#define	ATC_DST_REP		(0x1 << 12)	/* Destination Replay Mod */
> > +#define	ATC_DST_H2SEL		(0x1 << 13)	/* Destination Handshaking Mod */
> > +#define		ATC_DST_H2SEL_SW	(0x0 << 13)
> > +#define		ATC_DST_H2SEL_HW	(0x1 << 13)
> > +#define	ATC_DST_PER_MSB(h)	(ATC_PER_MSB(h) << 14)	/* Channel dst rq (most significant bits) */
> > +#define	ATC_SOD			(0x1 << 16)	/* Stop On Done */
> > +#define	ATC_LOCK_IF		(0x1 << 20)	/* Interface Lock */
> > +#define	ATC_LOCK_B		(0x1 << 21)	/* AHB Bus Lock */
> > +#define	ATC_LOCK_IF_L		(0x1 << 22)	/* Master Interface Arbiter Lock */
> > +#define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
> > +#define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
> > +#define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
> > +#define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
> > +#define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
> > +#define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
> > +#define		ATC_FIFOCFG_ENOUGHSPACE		(0x2 << 28)
> 
> Make these use BIT() or GENMASK() later..?
> 

Sure but for this patch, I wanted to make it clear that this was just
moving code around.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
