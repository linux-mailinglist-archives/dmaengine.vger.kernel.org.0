Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88C30509A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 05:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhA0ERt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 23:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbhAZV4a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jan 2021 16:56:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F9C061756;
        Tue, 26 Jan 2021 13:55:50 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E61EC2E0;
        Tue, 26 Jan 2021 22:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611698149;
        bh=SMDoBPaHZPP3ApaQVHa76WRBiwdWB84rlo2LUhpd7TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJYbmAfPeZAHaajRkyl/x4hwkTWg78Pl4ptDbG3UV7q+iLA2znt32qHJ8OLBBjZ+S
         AcvFmlrmCTK019WdLWetY/fepre4sSnsMzqX62PjnB1CHkxlF05LFJOhgLyHe/Qzu+
         +3zVNiy64UFdmYZdxg6JNkLFGkhrmwxdXneyoIVk=
Date:   Tue, 26 Jan 2021 23:55:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dmaengine: rcar-dmac: Add helpers for clearing
 DMA channel status
Message-ID: <YBCP0cXXu5Sd+nUL@pendragon.ideasonboard.com>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-4-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Jan 25, 2021 at 03:24:30PM +0100, Geert Uytterhoeven wrote:
> Extract the code to clear the status of one or all channels into their
> own helpers, to prepare for the different handling of the R-Car V3U SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - No changes.
> ---
>  drivers/dma/sh/rcar-dmac.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 537550b4121bbc22..7a0f802c61e5152d 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -336,6 +336,17 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
>  		writel(data, chan->iomem + reg);
>  }
>  
> +static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
> +				 struct rcar_dmac_chan *chan)
> +{
> +	rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
> +}
> +
> +static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
> +{
> +	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * Initialization and configuration
>   */
> @@ -451,7 +462,7 @@ static int rcar_dmac_init(struct rcar_dmac *dmac)
>  	u16 dmaor;
>  
>  	/* Clear all channels and enable the DMAC globally. */
> -	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> +	rcar_dmac_chan_clear_all(dmac);
>  	rcar_dmac_write(dmac, RCAR_DMAOR,
>  			RCAR_DMAOR_PRI_FIXED | RCAR_DMAOR_DME);
>  
> @@ -1566,7 +1577,7 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)
>  		 * because channel is already stopped in error case.
>  		 * We need to clear register and check DE bit as recovery.
>  		 */
> -		rcar_dmac_write(dmac, RCAR_DMACHCLR, 1 << chan->index);
> +		rcar_dmac_chan_clear(dmac, chan);
>  		rcar_dmac_chcr_de_barrier(chan);
>  		reinit = true;
>  		goto spin_lock_end;

-- 
Regards,

Laurent Pinchart
