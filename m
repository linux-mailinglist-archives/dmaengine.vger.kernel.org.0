Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF2ACB58
	for <lists+dmaengine@lfdr.de>; Sun,  8 Sep 2019 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfIHHpr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 8 Sep 2019 03:45:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfIHHpr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 8 Sep 2019 03:45:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x887ja1p083024;
        Sun, 8 Sep 2019 02:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567928736;
        bh=Goad91DySdskWdmlA0VNxwlei1jTHTzjH6HEL+J6lJU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=nU1CzCziwqAfJnQ/t3MjzHC9eVrRvylqvHr34onZ/WZLcxuQRN1ysJpz5CpY8+/iA
         iphtpvMn5XXFlHCTat3q/URHeXldHRHu2DuvWJpffqPE3NGqubWSXmABrtqrg+XFqx
         9369ndmTx6WPvOhGdU5gfkesPPmvLywOjU3yTUsc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x887jaAX124745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Sep 2019 02:45:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 8 Sep
 2019 02:45:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 8 Sep 2019 02:45:36 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x887jY8x121377;
        Sun, 8 Sep 2019 02:45:34 -0500
Subject: Re: [RFC 3/3] dmaengine: Support for requesting channels preferring
 DMA domain controller
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-4-peter.ujfalusi@ti.com>
Message-ID: <a409fb40-c8d7-2f0d-20fb-1786b2cbe6fd@ti.com>
Date:   Sun, 8 Sep 2019 10:46:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906141816.24095-4-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/09/2019 17.18, Peter Ujfalusi wrote:
> In case the channel is not requested via the slave API, use the
> of_find_dma_domain() to see if a system default DMA controller is
> specified.
> 
> Add new function which can be used by clients to request channels by mask
> from their DMA domain controller if specified.
> 
> Client drivers can take advantage of the domain support by moving from
> dma_request_chan_by_mask() to dma_domain_request_chan_by_mask()
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   | 17 ++++++++++++-----
>  include/linux/dmaengine.h |  9 ++++++---
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6baddf7dcbfd..087450eed68c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -640,6 +640,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  	struct dma_device *device, *_d;
>  	struct dma_chan *chan = NULL;
>  
> +	/* If np is not specified, get the default DMA domain controller */
> +	if (!np)
> +		np = of_find_dma_domain(NULL);
> +
>  	/* Find a channel */
>  	mutex_lock(&dma_list_mutex);
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
> @@ -751,19 +755,22 @@ struct dma_chan *dma_request_slave_channel(struct device *dev,
>  EXPORT_SYMBOL_GPL(dma_request_slave_channel);
>  
>  /**
> - * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
> - * @mask: capabilities that the channel must satisfy
> + * dma_domain_request_chan_by_mask - allocate a channel by mask from DMA domain
> + * @dev:	pointer to client device structure
> + * @mask:	capabilities that the channel must satisfy
>   *
>   * Returns pointer to appropriate DMA channel on success or an error pointer.
>   */
> -struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
> +struct dma_chan *dma_domain_request_chan_by_mask(struct device *dev,
> +						 const dma_cap_mask_t *mask)
>  {
>  	struct dma_chan *chan;
>  
>  	if (!mask)
>  		return ERR_PTR(-ENODEV);
>  
> -	chan = __dma_request_channel(mask, NULL, NULL, NULL);

if (dev)
> +	chan = __dma_request_channel(mask, NULL, NULL,
> +				     of_find_dma_domain(dev->of_node));else
	chan = __dma_request_channel(mask, NULL, NULL, NULL);

>  	if (!chan) {
>  		mutex_lock(&dma_list_mutex);
>  		if (list_empty(&dma_device_list))
> @@ -775,7 +782,7 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
>  
>  	return chan;
>  }
> -EXPORT_SYMBOL_GPL(dma_request_chan_by_mask);
> +EXPORT_SYMBOL_GPL(dma_domain_request_chan_by_mask);
>  
>  void dma_release_channel(struct dma_chan *chan)
>  {
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 3b2e8e302f6c..9f94df81e83f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1438,7 +1438,8 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
>  
>  struct dma_chan *dma_request_chan(struct device *dev, const char *name);
> -struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> +struct dma_chan *dma_domain_request_chan_by_mask(struct device *dev,
> +						 const dma_cap_mask_t *mask);
>  
>  void dma_release_channel(struct dma_chan *chan);
>  int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
> @@ -1475,8 +1476,8 @@ static inline struct dma_chan *dma_request_chan(struct device *dev,
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> -static inline struct dma_chan *dma_request_chan_by_mask(
> -						const dma_cap_mask_t *mask)
> +static inline struct dma_chan *dma_domain_request_chan_by_mask(struct device *dev,
> +			const dma_cap_mask_t *mask)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> @@ -1537,6 +1538,8 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
>  	__dma_request_channel(&(mask), x, y, NULL)
>  #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
>  	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
> +#define dma_request_chan_by_mask(mask) \
> +	dma_domain_request_chan_by_mask(NULL, mask)
>  
>  static inline struct dma_chan
>  *__dma_request_slave_channel_compat(const dma_cap_mask_t *mask,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
