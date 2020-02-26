Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AB16FF22
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 13:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBZMgv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 07:36:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58084 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZMgv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Feb 2020 07:36:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QCaVNI061631;
        Wed, 26 Feb 2020 06:36:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582720591;
        bh=NRh16dsIfahRU1lMXzXpat3M8tzd1Smyg0oGRqJ8WuY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=e9yT/XIZyU5JMd9VgCU8N1ILTbp1Zn6U27kcuQN1aKHxYHzq7A+D/3LyXeFEM7zNV
         gCmkKNc8TFfKoZrI14azzjSaLCKYAQQAWYZZfLu1SfDt/1pojxsFeZP4xQqnadZlg0
         5/CGPApEgobuLD6sf3c9hkm6x0Z3vaCL9xuuHJjU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCaVaD070255;
        Wed, 26 Feb 2020 06:36:31 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 06:36:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 06:36:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QCaT98045067;
        Wed, 26 Feb 2020 06:36:29 -0600
Subject: Re: [PATCH v1 2/4] dmaengine: Use negative condition for better
 readability
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
 <20200226101842.29426-2-andriy.shevchenko@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f31ef630-4a29-7302-e484-62dcf548251a@ti.com>
Date:   Wed, 26 Feb 2020 14:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226101842.29426-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

On 2/26/20 12:18 PM, Andy Shevchenko wrote:
> When negative condition is in use we may decrease indentation level
> and make the main part of logic better visible.

It makes the code a bit nicer, I agree.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/dmaengine.h | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 9f3f5582816a..ae56a91c2a05 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -618,10 +618,11 @@ static inline void dmaengine_unmap_put(struct dmaengine_unmap_data *unmap)
>  
>  static inline void dma_descriptor_unmap(struct dma_async_tx_descriptor *tx)
>  {
> -	if (tx->unmap) {
> -		dmaengine_unmap_put(tx->unmap);
> -		tx->unmap = NULL;
> -	}
> +	if (!tx->unmap)
> +		return;
> +
> +	dmaengine_unmap_put(tx->unmap);
> +	tx->unmap = NULL;
>  }
>  
>  #ifndef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
> @@ -1408,11 +1409,12 @@ static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
>  static inline void
>  dma_set_tx_state(struct dma_tx_state *st, dma_cookie_t last, dma_cookie_t used, u32 residue)
>  {
> -	if (st) {
> -		st->last = last;
> -		st->used = used;
> -		st->residue = residue;
> -	}
> +	if (!st)
> +		return;
> +
> +	st->last = last;
> +	st->used = used;
> +	st->residue = residue;
>  }
>  
>  #ifdef CONFIG_DMA_ENGINE
> @@ -1489,12 +1491,11 @@ static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
>  	if (ret)
>  		return ret;
>  
> -	if (caps.descriptor_reuse) {
> -		tx->flags |= DMA_CTRL_REUSE;
> -		return 0;
> -	} else {
> +	if (!caps.descriptor_reuse)
>  		return -EPERM;
> -	}
> +
> +	tx->flags |= DMA_CTRL_REUSE;
> +	return 0;
>  }
>  
>  static inline void dmaengine_desc_clear_reuse(struct dma_async_tx_descriptor *tx)
> @@ -1510,10 +1511,10 @@ static inline bool dmaengine_desc_test_reuse(struct dma_async_tx_descriptor *tx)
>  static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
>  {
>  	/* this is supported for reusable desc, so check that */
> -	if (dmaengine_desc_test_reuse(desc))
> -		return desc->desc_free(desc);
> -	else
> +	if (!dmaengine_desc_test_reuse(desc))
>  		return -EPERM;
> +
> +	return desc->desc_free(desc);
>  }
>  
>  /* --- DMA device --- */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
