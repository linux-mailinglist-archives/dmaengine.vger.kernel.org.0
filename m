Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3B861DF
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbfHHMcK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 08:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389970AbfHHMcI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 08:32:08 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44671204EC;
        Thu,  8 Aug 2019 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267527;
        bh=NqibGTdtyWubrniWSl6Zy3IzNlMPZsiY5dNU5CczzGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USf5usFNO1/aVJIngZrZc/pLA08V6kbJZeJ1YWbpp3+5gcmPbNixDo+U5TRUj/XAN
         py8KbI2I/djGTTUX9+EHyweZKZXgj2k/MFq1y2qJIr3NNDvBVHMVegeE3u72V6OtPA
         DXTfEOBfbnF9w3+BRpxPZlm16teoHwccEnNMAmks=
Date:   Thu, 8 Aug 2019 18:00:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 02/10] dmaengine: bcm2835: Allow cyclic transactions
 without interrupt
Message-ID: <20190808123055.GU12733@vkoul-mobl.Dlink>
References: <cover.1564825752.git.lukas@wunner.de>
 <037b83d2ae8aa92448b9d647436012c06f4c0561.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037b83d2ae8aa92448b9d647436012c06f4c0561.1564825752.git.lukas@wunner.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-19, 12:10, Lukas Wunner wrote:
> The BCM2835 DMA driver currently requests an interrupt from the
> controller regardless whether or not the client has passed in the
> DMA_PREP_INTERRUPT flag. This causes unnecessary overhead for cyclic
> transactions which do not need an interrupt after each period.
> 
> We're about to add such a use case, namely cyclic clearing of the SPI
> controller's RX FIFO, so amend the DMA driver to request an interrupt
> only if DMA_PREP_INTERRUPT was passed in. Ignore the period_len for
> such transactions and set it to the buffer length to make the driver's
> calculations work.

Acked-by: Vinod Koul <vkoul@kernel.org>

> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Florian Kauer <florian.kauer@koalo.de>
> ---
>  drivers/dma/bcm2835-dma.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 523c507ad69e..a65514fcb7f2 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -691,7 +691,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>  	struct bcm2835_desc *d;
>  	dma_addr_t src, dst;
>  	u32 info = BCM2835_DMA_WAIT_RESP;
> -	u32 extra = BCM2835_DMA_INT_EN;
> +	u32 extra = 0;
>  	size_t max_len = bcm2835_dma_max_frame_length(c);
>  	size_t frames;
>  
> @@ -707,6 +707,11 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>  		return NULL;
>  	}
>  
> +	if (flags & DMA_PREP_INTERRUPT)
> +		extra |= BCM2835_DMA_INT_EN;
> +	else
> +		period_len = buf_len;
> +
>  	/*
>  	 * warn if buf_len is not a multiple of period_len - this may leed
>  	 * to unexpected latencies for interrupts and thus audiable clicks
> @@ -778,7 +783,10 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
>  
>  	/* stop DMA activity */
>  	if (c->desc) {
> -		vchan_terminate_vdesc(&c->desc->vd);
> +		if (c->desc->vd.tx.flags & DMA_PREP_INTERRUPT)
> +			vchan_terminate_vdesc(&c->desc->vd);
> +		else
> +			vchan_vdesc_fini(&c->desc->vd);
>  		c->desc = NULL;
>  		bcm2835_dma_abort(c);
>  	}
> -- 
> 2.20.1

-- 
~Vinod
