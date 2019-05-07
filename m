Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5666515F7D
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEGIhq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 04:37:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56982 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEGIhp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 04:37:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x478bVuW127250;
        Tue, 7 May 2019 03:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557218251;
        bh=1FjG3j/GZXNf0sBrxxtjLhI9p1BMMNmge5pQT42QF1U=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=mvgjb4ePzxMp5mETNWkP7zsfEmppIco1QwlwsaU5kTDf/eVcGLQFht2sbXSuzQtqX
         B/NiwHuBsAjTi2h2VLJU5ZyOoq9OcMUFhgBmUo/iRg0BlobEtAFJt2R6ZovGVvaDkh
         WIM0HcK5nx4bHprUGkiTwXZheZS4oDnZU/fsROds=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x478bVh5097764
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 May 2019 03:37:31 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 7 May
 2019 03:37:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 7 May 2019 03:37:30 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x478bRVX095908;
        Tue, 7 May 2019 03:37:27 -0500
Subject: Re: [PATCH 07/16] dmaengine: Add function to request slave channel
 from a dma_device
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-8-peter.ujfalusi@ti.com>
Message-ID: <89b2ded6-f1f5-dda5-9ae4-d94bcf4c041f@ti.com>
Date:   Tue, 7 May 2019 11:37:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506123456.6777-8-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/05/2019 15.34, Peter Ujfalusi wrote:
> dma_get_any_slave_channel() would skip using the filter function, which
> in some cases needed to be executed before the alloc_chan_resources
> callback to make sure that all parameters are provided for the slave
> channel.

This can be dropped in favor of
https://patchwork.kernel.org/patch/10932299/
from Baolin Wangm and using __dma_request_channel() in the k3-udma driver.

- Péter

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   | 7 ++++---
>  include/linux/dmaengine.h | 5 ++++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 8eed5ff0fc01..7ec93be12088 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -617,7 +617,8 @@ struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
>  }
>  EXPORT_SYMBOL_GPL(dma_get_slave_channel);
>  
> -struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
> +struct dma_chan *dmadev_get_slave_channel(struct dma_device *device,
> +					  dma_filter_fn fn, void *fn_param)
>  {
>  	dma_cap_mask_t mask;
>  	struct dma_chan *chan;
> @@ -628,13 +629,13 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
>  	/* lock against __dma_request_channel */
>  	mutex_lock(&dma_list_mutex);
>  
> -	chan = find_candidate(device, &mask, NULL, NULL);
> +	chan = find_candidate(device, &mask, fn, fn_param);
>  
>  	mutex_unlock(&dma_list_mutex);
>  
>  	return IS_ERR(chan) ? NULL : chan;
>  }
> -EXPORT_SYMBOL_GPL(dma_get_any_slave_channel);
> +EXPORT_SYMBOL_GPL(dmadev_get_slave_channel);
>  
>  /**
>   * __dma_request_channel - try to allocate an exclusive channel
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c1486564a314..4774b66f2064 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1541,7 +1541,10 @@ int dmaenginem_async_device_register(struct dma_device *device);
>  void dma_async_device_unregister(struct dma_device *device);
>  void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
> -struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
> +struct dma_chan *dmadev_get_slave_channel(struct dma_device *device,
> +					  dma_filter_fn fn, void *fn_param);
> +#define dma_get_any_slave_channel(device) \
> +	dmadev_get_slave_channel(device, NULL, NULL)
>  #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
>  #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
>  	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
