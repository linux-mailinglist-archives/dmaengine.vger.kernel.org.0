Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2515F83
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEGIiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 04:38:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57066 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEGIiT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 04:38:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x478bsCu127307;
        Tue, 7 May 2019 03:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557218274;
        bh=Olgyr8WZLKt8gGzTEuPealNrw31hIrJIggcB6sk9mwA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AfFSF5EpswIiPbbL86OZYu4kcAilSG876Qa3ixDnLUyX+cjNV9vO0Tk9jHPPemr4v
         1CVzjgsmaL03L1j016BhNw3R8ODKp8RRZ+IWqjbVYJTx7SmneRYDxRMF1UZz+8Lce3
         gOWook+vRea/dwRFIjqOgQhifaTq2U9ckMd44ibM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x478bsVP089757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 May 2019 03:37:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 7 May
 2019 03:37:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 7 May 2019 03:37:54 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x478boXY045826;
        Tue, 7 May 2019 03:37:50 -0500
Subject: Re: [PATCH 1/8] dmaengine: Add matching device node validation in
 __dma_request_channel()
To:     Baolin Wang <baolin.wang@linaro.org>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <Zubair.Kakakhel@imgtec.com>, <wsa+renesas@sang-engineering.com>,
        <jroedel@suse.de>, <vincent.guittot@linaro.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
 <17a22052fdb759ae6129e30f9bd8862f23a03ad9.1557206859.git.baolin.wang@linaro.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <42b84cfe-3281-7f4e-03cc-6ca126e16191@ti.com>
Date:   Tue, 7 May 2019 11:37:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <17a22052fdb759ae6129e30f9bd8862f23a03ad9.1557206859.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 07/05/2019 9.09, Baolin Wang wrote:
> When user try to request one DMA channel by __dma_request_channel(), it won't
> validate if it is the correct DMA device to request, that will lead each DMA
> engine driver to validate the correct device node in their filter function
> if it is necessary.
> 
> Thus we can add the matching device node validation in the DMA engine core,
> to remove all of device node validation in the drivers.

I have picked this patch to my TI UDMA series and with
__dma_request_channel() it works as expected - picking the channel from
the correct DMA device.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/dmaengine.c   |   10 ++++++++--
>  drivers/dma/of-dma.c      |    4 ++--
>  include/linux/dmaengine.h |   12 ++++++++----
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 3a11b10..610080c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -641,11 +641,13 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
>   * @mask: capabilities that the channel must satisfy
>   * @fn: optional callback to disposition available channels
>   * @fn_param: opaque parameter to pass to dma_filter_fn
> + * @np: device node to look for DMA channels
>   *
>   * Returns pointer to appropriate DMA channel on success or NULL.
>   */
>  struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
> -				       dma_filter_fn fn, void *fn_param)
> +				       dma_filter_fn fn, void *fn_param,
> +				       struct device_node *np)
>  {
>  	struct dma_device *device, *_d;
>  	struct dma_chan *chan = NULL;
> @@ -653,6 +655,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  	/* Find a channel */
>  	mutex_lock(&dma_list_mutex);
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
> +		/* Finds a DMA controller with matching device node */
> +		if (np && device->dev->of_node && np != device->dev->of_node)
> +			continue;
> +
>  		chan = find_candidate(device, mask, fn, fn_param);
>  		if (!IS_ERR(chan))
>  			break;
> @@ -769,7 +775,7 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
>  	if (!mask)
>  		return ERR_PTR(-ENODEV);
>  
> -	chan = __dma_request_channel(mask, NULL, NULL);
> +	chan = __dma_request_channel(mask, NULL, NULL, NULL);
>  	if (!chan) {
>  		mutex_lock(&dma_list_mutex);
>  		if (list_empty(&dma_device_list))
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index 91fd395..6b43d04 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -316,8 +316,8 @@ struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>  	if (count != 1)
>  		return NULL;
>  
> -	return dma_request_channel(info->dma_cap, info->filter_fn,
> -			&dma_spec->args[0]);
> +	return __dma_request_channel(&info->dma_cap, info->filter_fn,
> +				     &dma_spec->args[0], dma_spec->np);
>  }
>  EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
>  
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index d49ec5c..504085b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1314,7 +1314,8 @@ static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
>  enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
>  void dma_issue_pending_all(void);
>  struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
> -					dma_filter_fn fn, void *fn_param);
> +				       dma_filter_fn fn, void *fn_param,
> +				       struct device_node *np);
>  struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
>  
>  struct dma_chan *dma_request_chan(struct device *dev, const char *name);
> @@ -1339,7 +1340,9 @@ static inline void dma_issue_pending_all(void)
>  {
>  }
>  static inline struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
> -					      dma_filter_fn fn, void *fn_param)
> +						     dma_filter_fn fn,
> +						     void *fn_param,
> +						     struct device_node *np)
>  {
>  	return NULL;
>  }
> @@ -1411,7 +1414,8 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
>  void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
>  struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
> -#define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
> +#define dma_request_channel(mask, x, y) \
> +	__dma_request_channel(&(mask), x, y, NULL)
>  #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
>  	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
>  
> @@ -1429,6 +1433,6 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
>  	if (!fn || !fn_param)
>  		return NULL;
>  
> -	return __dma_request_channel(mask, fn, fn_param);
> +	return __dma_request_channel(mask, fn, fn_param, NULL);
>  }
>  #endif /* DMAENGINE_H */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
