Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087FA87460
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2019 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405800AbfHIIjs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Aug 2019 04:39:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfHIIjs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Aug 2019 04:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XyYqpakWb1SuitGUZglvmIb6eFhkNNv0pxmvQD8vZbw=; b=NNb9GZ7Yuumrv2FwFMf56PWLN
        vyneECO+fzUHhkUvfQIAa2TQLLe2SF5diusVFmG54n2IGYmyLTCADwLoT3LVuRGrG/whkNbfBzvrG
        uRqmdrci2LHTUjUufkgTVxnUf0FtRlzmpr5+/Bsi0ivHHEIzkTbKg1wukrHCkn4aKIcfBfXcPykiZ
        BeOxQ1OOpoxMlK8srjDgOL7u8R/7wm86HdTOlz0a9l5oeabyOsvCf8zL/JcazWoCGkaIMfVeHNT7D
        qp3IKe2Ci7I5B1GIFCqrv5uKRi9qqirAX9g0cldUqW3s+98B1/70caDK25P5+itW930O/cIVT6pfj
        qmETyooGw==;
Received: from [179.162.52.10] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hw0R8-0000Dq-P6; Fri, 09 Aug 2019 08:39:47 +0000
Date:   Fri, 9 Aug 2019 05:39:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv2] omap-dma/omap_vout_vrfb: fix off-by-one fi value
Message-ID: <20190809053941.4d9842f6@coco.lan>
In-Reply-To: <952e7f51-f208-9333-6f58-b7ed20d2ea0b@xs4all.nl>
References: <952e7f51-f208-9333-6f58-b7ed20d2ea0b@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Em Fri, 9 Aug 2019 10:32:40 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

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
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Regards,
Mauro

> ---
> Changes since v1: removed unnecessary parenthesis in omap_vout_vrfb.c
> as suggested by Laurent.
> 
> It makes sense that this patch goes in through the dmaengine subsystem
> (Mauro, can you Ack this patch?), but if preferred it can also go in
> through the media subsystem if we get an Ack from Vinod.
> ---
>  drivers/dma/ti/omap-dma.c                    | 4 ++--
>  drivers/media/platform/omap/omap_vout_vrfb.c | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
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
> index 29e3f5da59c1..11ec048929e8 100644
> --- a/drivers/media/platform/omap/omap_vout_vrfb.c
> +++ b/drivers/media/platform/omap/omap_vout_vrfb.c
> @@ -253,8 +253,7 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
>  	 */
> 
>  	pixsize = vout->bpp * vout->vrfb_bpp;
> -	dst_icg = ((MAX_PIXELS_PER_LINE * pixsize) -
> -		  (vout->pix.width * vout->bpp)) + 1;
> +	dst_icg = MAX_PIXELS_PER_LINE * pixsize - vout->pix.width * vout->bpp;
> 
>  	xt->src_start = vout->buf_phy_addr[vb->i];
>  	xt->dst_start = vout->vrfb_context[vb->i].paddr[0];
