Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2557BD9A
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfGaJql (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 05:46:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43978 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGaJql (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Jul 2019 05:46:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6V9kbUA096452;
        Wed, 31 Jul 2019 04:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564566397;
        bh=wAzgrHP9yAIV9nHZ+M9AcajXEtzIx7V60+cmUe7oPHc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A8+O5tU8FlSEnuZ6U2IbdaVPAhVrGUXil63PpbjgrXtl0IMrYpz/qaRYGACnYbnBE
         55Vl+Yzj2rAPmOY/Q6B8qLFHT/q5t23kor1qRNUa30wZcOSgCX49Zj1+OVTizClynF
         gwBsoCl+duqljLCQgGf8JkuM930XTRaygUzef/OA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6V9kbOF124551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Jul 2019 04:46:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 31
 Jul 2019 04:46:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 31 Jul 2019 04:46:37 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6V9kW10012208;
        Wed, 31 Jul 2019 04:46:34 -0500
Subject: Re: [PATCH] omap-dma/omap_vout_vrfb: fix off-by-one fi value
To:     Hans Verkuil <hverkuil@xs4all.nl>, <dmaengine@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <8f4e529f-9c20-b2e3-7e60-35e2d72d5242@xs4all.nl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0ee2c9c3-ea23-ed38-6d98-be35e78fb383@ti.com>
Date:   Wed, 31 Jul 2019 12:46:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8f4e529f-9c20-b2e3-7e60-35e2d72d5242@xs4all.nl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hans,

On 30/07/2019 9.14, Hans Verkuil wrote:
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

Thanks for catching it. I have implemented the interleaved support based
on the omap_vout_vrfb driver's behavior and hence I have missed the + 1
in the omap-dma.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

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
> 
>  	xt->src_start = vout->buf_phy_addr[vb->i];
>  	xt->dst_start = vout->vrfb_context[vb->i].paddr[0];
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
