Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF62F14D166
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 20:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgA2TvS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 14:51:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgA2TvR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 14:51:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00TJp1Lr078023;
        Wed, 29 Jan 2020 13:51:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580327461;
        bh=rbB/lD7xEgzLxXwTLa3JpCV55iUJ31TPZ7JK+o77KyA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i+SbOgfPYo7oQJfA+Q3vNaHmk6uHqFgEJ28i3Fxt7pifIhEH2MdjGg/uPNV9NVRsc
         zc+SHz4kE0B1WMghT0gX6uVeGbGIST4r+ydRgsHFPkxh1t/ew60x+KwLXY0RuCMcgK
         BoyjKqrW1p9iPtwSYX4spV6syCAb1RVBuU8FVrVY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00TJp1fk010922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jan 2020 13:51:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 29
 Jan 2020 13:51:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 29 Jan 2020 13:51:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00TJowTf087910;
        Wed, 29 Jan 2020 13:50:59 -0600
Subject: Re: [PATCH] dmaengine: Fix return value for dma_requrest_chan() in
 case of failure
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <dmaengine@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20200129163716eucas1p19550fcbfff81ca8586df28782399cff0@eucas1p1.samsung.com>
 <20200129163548.11096-1-m.szyprowski@samsung.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <3d7a612a-851f-85f1-4207-531f5a87212a@ti.com>
Date:   Wed, 29 Jan 2020 21:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129163548.11096-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 29/01/2020 18.35, Marek Szyprowski wrote:
> Commit 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and
> slaves") changed the dma_request_chan() function flow in such a way that
> it always returns EPROBE_DEFER in case of channels that cannot be found.
> This break the operation of the devices which have optional DMA channels
> as it puts their drivers in endless deferred probe loop. Fix this by
> propagating the proper error value.
> 
> Fixes: 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and slaves")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/dma/dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index f3ef4edd4de1..27b64a665347 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -759,7 +759,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  	if (!IS_ERR_OR_NULL(chan))
>  		goto found;
>  
> -	return ERR_PTR(-EPROBE_DEFER);
> +	return chan;

It should be:
return chan ? chan : ERR_PTR(-EPROBE_DEFER);

dma_request_chan() should never return NULL, it either returns the
dma_chan, or ERR_PTR().

>  
>  found:
>  	chan->slave = dev;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
