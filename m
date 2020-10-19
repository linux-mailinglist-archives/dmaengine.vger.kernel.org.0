Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA05292479
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgJSJQh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 05:16:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54536 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgJSJQh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 05:16:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09J9GYnG086235;
        Mon, 19 Oct 2020 04:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603098994;
        bh=vcVzVk/88At+m/5nPg0GX7nj7jgpu933yKxAb5W9Qv8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ZJ16jNVqbS5X3ehIgMhfU19KBzGP1Kv7Os1GdqReEvrIUE/rAcstykljFdXMP/NKX
         3jXfEqtmcNssef+t9hScU4E2qLI1o7G7xItAX+gHfEFC/nDHW/LF1EJO21Ro0SnBN/
         o2qj2aquXFd5IsZCpN0LUlDy58Lv7MeE+X64KFNU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09J9GYIb099011
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 04:16:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 19
 Oct 2020 04:16:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 19 Oct 2020 04:16:33 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09J9GWsi128096;
        Mon, 19 Oct 2020 04:16:33 -0500
Subject: Re: [PATCH 3/4] dmaengine: move APIs in interface to use peripheral
 term
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20201015073132.3571684-1-vkoul@kernel.org>
 <20201015073132.3571684-4-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <18d27d30-c6c4-51f6-b361-6bf0be1a34b5@ti.com>
Date:   Mon, 19 Oct 2020 12:17:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201015073132.3571684-4-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 15/10/2020 10.31, Vinod Koul wrote:
> dmaengine history has a non inclusive terminology of dmaengine slave, I
> feel it is time to replace that.
> 
> This moves APIs in dmaengine interface with replacement of slave
> to peripheral which is an appropriate term for dmaengine peripheral
> devices
> 
> Since the change of name can break users, the new names have been added
> with old APIs kept as macro define for new names. Once the users have
> been migrated, these macros will be dropped.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  include/linux/dmaengine.h | 46 +++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 04b993a5373c..d8dce3cdfdd4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -923,6 +923,10 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
>  		struct dma_chan *chan, unsigned long flags);
>  
> +	struct dma_async_tx_descriptor *(*device_prep_peripheral_sg)(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context);
>  	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
> @@ -959,8 +963,8 @@ struct dma_device {
>  #endif
>  };
>  
> -static inline int dmaengine_slave_config(struct dma_chan *chan,
> -					  struct dma_slave_config *config)
> +static inline int dmaengine_peripheral_config(struct dma_chan *chan,
> +					  struct dma_peripheral_config *config)
>  {
>  	if (chan->device->device_config)
>  		return chan->device->device_config(chan, config);
> @@ -968,12 +972,16 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
>  	return -ENOSYS;
>  }
>  
> -static inline bool is_slave_direction(enum dma_transfer_direction direction)
> +#define dmaengine_slave_config dmaengine_peripheral_config
> +
> +static inline bool is_peripheral_direction(enum dma_transfer_direction direction)
>  {
>  	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
> +#define is_slave_direction is_peripheral_direction
> +
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_single(
>  	struct dma_chan *chan, dma_addr_t buf, size_t len,
>  	enum dma_transfer_direction dir, unsigned long flags)
>  {
> @@ -989,7 +997,9 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
>  						  dir, flags, NULL);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> +#define dmaengine_prep_slave_single dmaengine_prep_peripheral_single
> +
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_sg(
>  	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
>  	enum dma_transfer_direction dir, unsigned long flags)
>  {
> @@ -1000,6 +1010,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
>  						  dir, flags, NULL);
>  }
>  
> +#define dmaengine_prep_slave_sg dmaengine_prep_peripheral_sg
> +

If you do similar changes to _single() then DMA drivers can migrate to
the new device_prep_peripheral_sg in their own pace:

static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_sg(
	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
	enum dma_transfer_direction dir, unsigned long flags)
{
	if (!chan || !chan->device)
		return NULL;

	if (chan->device->device_prep_peripheral_sg)
		return chan->device->device_prep_peripheral_sg(chan, sgl, sg_len,
							       dir, flags, NULL);

	if (chan->device->device_prep_slave_sg)
		return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
							  dir, flags, NULL);
	return NULL;
}



>  #ifdef CONFIG_RAPIDIO_DMA_ENGINE
>  struct rio_dma_ext;
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
> @@ -1498,7 +1510,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name);
>  struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
>  
>  void dma_release_channel(struct dma_chan *chan);
> -int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
> +int dma_get_peripheral_caps(struct dma_chan *chan, struct dma_peripheral_caps *caps);
>  #else
>  static inline struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type)
>  {
> @@ -1535,19 +1547,21 @@ static inline struct dma_chan *dma_request_chan_by_mask(
>  static inline void dma_release_channel(struct dma_chan *chan)
>  {
>  }
> -static inline int dma_get_slave_caps(struct dma_chan *chan,
> -				     struct dma_slave_caps *caps)
> +static inline int dma_get_peripheral_caps(struct dma_chan *chan,
> +				     struct dma_peripheral_caps *caps)
>  {
>  	return -ENXIO;
>  }
>  #endif
>  
> +#define dma_get_slave_caps dma_get_peripheral_caps
> +
>  static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
>  {
> -	struct dma_slave_caps caps;
> +	struct dma_peripheral_caps caps;
>  	int ret;
>  
> -	ret = dma_get_slave_caps(tx->chan, &caps);
> +	ret = dma_get_peripheral_caps(tx->chan, &caps);
>  	if (ret)
>  		return ret;
>  
> @@ -1592,17 +1606,19 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  
>  /* Deprecated, please use dma_request_chan() directly */
>  static inline struct dma_chan * __deprecated
> -dma_request_slave_channel(struct device *dev, const char *name)
> +dma_request_peripheral_channel(struct device *dev, const char *name)
>  {
>  	struct dma_chan *ch = dma_request_chan(dev, name);
>  
>  	return IS_ERR(ch) ? NULL : ch;
>  }
>  
> +#define dma_request_slave_channel dma_request_peripheral_channel
> +
>  static inline struct dma_chan
> -*dma_request_slave_channel_compat(const dma_cap_mask_t mask,
> -				  dma_filter_fn fn, void *fn_param,
> -				  struct device *dev, const char *name)
> +*dma_request_peripheral_channel_compat(const dma_cap_mask_t mask,
> +				       dma_filter_fn fn, void *fn_param,
> +				       struct device *dev, const char *name)
>  {
>  	struct dma_chan *chan;
>  
> @@ -1616,6 +1632,8 @@ static inline struct dma_chan
>  	return __dma_request_channel(&mask, fn, fn_param, NULL);
>  }
>  
> +#define dma_request_slave_channel_compat dma_request_peripheral_channel_compat
> +
>  static inline char *
>  dmaengine_get_direction_text(enum dma_transfer_direction dir)
>  {
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
