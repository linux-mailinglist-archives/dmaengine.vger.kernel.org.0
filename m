Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDD7BCED
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 11:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfGaJYD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 05:24:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47014 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfGaJYC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Jul 2019 05:24:02 -0400
Received: from pendragon.ideasonboard.com (unknown [38.98.37.141])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43683CC;
        Wed, 31 Jul 2019 11:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564565040;
        bh=R4+D8Bv1LT6NbP2s6ws7vr5lit4CpkZpXssqYzhspKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajyehgZYiZWuP/8crRvsuak4dbEKgsCno+fJZWrLMwq9jwe2RIfC7jw073dtTafk9
         /C4lWxBUY61rbOiB+dSPebWWrms6yZqTT1uqv5SnREXDPIyCW2728UykdbXOEIiMJx
         iQCsgwMhRdMmsPAKcP28FuAAdYlYIhbOeaefGbe4=
Date:   Wed, 31 Jul 2019 12:23:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     dmaengine@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] omap-dma/omap_vout_vrfb: fix off-by-one fi value
Message-ID: <20190731092347.GD5080@pendragon.ideasonboard.com>
References: <8f4e529f-9c20-b2e3-7e60-35e2d72d5242@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f4e529f-9c20-b2e3-7e60-35e2d72d5242@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Hans,

Thank you for the patch.

On Tue, Jul 30, 2019 at 08:14:19AM +0200, Hans Verkuil wrote:
> The OMAP 4 TRM specifies that when using double-index addressing
> the address increases by the ES plus the EI value minus 1 within
> a frame. When a full frame is transferred, the address increases
> by the ES plus the frame index (FI) value minus 1.
> 
> The omap-dma code didn't account for the 'minus 1' in the FI register.
> To get correct addressing, add 1 to the src_icg value.
> 
> This was found when testing a hacked version of the media m2m-deinterlace.c
> driver on a Pandaboard.
> 
> The only other source that uses this feature is omap_vout_vrfb.c,
> and that adds a + 1 when setting the dst_icg. This is a workaround
> for the broken omap-dma.c behavior. So remove the workaround at the
> same time that we fix omap-dma.c.
> 
> I tested the omap_vout driver with a Beagle XM board to check that
> the '+ 1' in omap_vout_vrfb.c was indeed a workaround for the omap-dma
> bug.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> It makes sense that this patch goes in through the dmaengine subsystem
> (Mauro, can you Ack this patch?), but if preferred it can also go in
> through the media subsystem if we get an Ack.
> 
> Regards,
> 
> 	Hans
> ---
>  drivers/dma/ti/omap-dma.c                    | 4 ++--
>  drivers/media/platform/omap/omap_vout_vrfb.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index ba2489d4ea24..ba27802efcd0 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1234,7 +1234,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
>  	if (src_icg) {
>  		d->ccr |= CCR_SRC_AMODE_DBLIDX;
>  		d->ei = 1;
> -		d->fi = src_icg;
> +		d->fi = src_icg + 1;
>  	} else if (xt->src_inc) {
>  		d->ccr |= CCR_SRC_AMODE_POSTINC;
>  		d->fi = 0;
> @@ -1249,7 +1249,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
>  	if (dst_icg) {
>  		d->ccr |= CCR_DST_AMODE_DBLIDX;
>  		sg->ei = 1;
> -		sg->fi = dst_icg;
> +		sg->fi = dst_icg + 1;
>  	} else if (xt->dst_inc) {
>  		d->ccr |= CCR_DST_AMODE_POSTINC;
>  		sg->fi = 0;
> diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/omap/omap_vout_vrfb.c
> index 29e3f5da59c1..729b1bf9395f 100644
> --- a/drivers/media/platform/omap/omap_vout_vrfb.c
> +++ b/drivers/media/platform/omap/omap_vout_vrfb.c
> @@ -254,7 +254,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
> 
>  	pixsize = vout->bpp * vout->vrfb_bpp;
>  	dst_icg = ((MAX_PIXELS_PER_LINE * pixsize) -
> -		  (vout->pix.width * vout->bpp)) + 1;
> +		  (vout->pix.width * vout->bpp));

You can remove the outer parentheses. Apart from that the patch looks OK
to me, it matches the documentation.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> 
>  	xt->src_start = vout->buf_phy_addr[vb->i];
>  	xt->dst_start = vout->vrfb_context[vb->i].paddr[0];

-- 
Regards,

Laurent Pinchart
