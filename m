Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FD2B5A41
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 08:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKQHYT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 02:24:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42702 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKQHYS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 02:24:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AH7Nrv6073069;
        Tue, 17 Nov 2020 01:23:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605597833;
        bh=hC8URl26dDt4YEvGxCUxFPMwcj4xB06a0unh+EiQkGc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TyOYXatebi/dCtfAuhhhdgyr9Ho4rPyNNhde2/jddZWzJKKftRgsXQohewahQwDHg
         GJ8OsFCmiOiARWA0z/WcsR5F9+OKBFBvblZ+x7IxkZxJnhCY3nqr4fvvxCuMZAQOpq
         sKegN0w+UdEusrf4Z6AEVd9zLj8cMRXOGS2gIsYA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AH7NqPf007435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 01:23:52 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 01:23:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 01:23:52 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AH7Nob7052762;
        Tue, 17 Nov 2020 01:23:50 -0600
Subject: Re: [PATCH] dmaengine: fix error codes in channel_register()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20201113101631.GE168908@mwanda>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2be1522e-17a8-7d3d-3fdf-f6e729b7740e@ti.com>
Date:   Tue, 17 Nov 2020 09:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201113101631.GE168908@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dan,

On 13/11/2020 12.16, Dan Carpenter wrote:
> The error codes were not set on some of these error paths.
> 
> Also the error handling was more confusing than it needed to be so I
> cleaned it up and shuffled it around a bit.

Nice catch,

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

fwiw I did a boot test as well.

- Péter

> Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/dma/dmaengine.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 7974fa0400d8..962cbb5e5f7f 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1039,16 +1039,15 @@ static int get_dma_id(struct dma_device *device)
>  static int __dma_async_device_channel_register(struct dma_device *device,
>  					       struct dma_chan *chan)
>  {
> -	int rc = 0;
> +	int rc;
>  
>  	chan->local = alloc_percpu(typeof(*chan->local));
>  	if (!chan->local)
> -		goto err_out;
> +		return -ENOMEM;
>  	chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
>  	if (!chan->dev) {
> -		free_percpu(chan->local);
> -		chan->local = NULL;
> -		goto err_out;
> +		rc = -ENOMEM;
> +		goto err_free_local;
>  	}
>  
>  	/*
> @@ -1061,7 +1060,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	if (chan->chan_id < 0) {
>  		pr_err("%s: unable to alloc ida for chan: %d\n",
>  		       __func__, chan->chan_id);
> -		goto err_out;
> +		rc = chan->chan_id;
> +		goto err_free_dev;
>  	}
>  
>  	chan->dev->device.class = &dma_devclass;
> @@ -1082,9 +1082,10 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	mutex_lock(&device->chan_mutex);
>  	ida_free(&device->chan_ida, chan->chan_id);
>  	mutex_unlock(&device->chan_mutex);
> - err_out:
> -	free_percpu(chan->local);
> + err_free_dev:
>  	kfree(chan->dev);
> + err_free_local:
> +	free_percpu(chan->local);
>  	return rc;
>  }
>  
> 


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
