Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F418D2923F5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 10:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgJSIy3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 04:54:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49752 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgJSIy2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 04:54:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09J8sQIo077633;
        Mon, 19 Oct 2020 03:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603097666;
        bh=d4/eWUg6NETKZp84IChXkt64FPYV/wmHKSw9APogGPA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=negL5hCSUslc0DN0vAttkQ4Nep7P6gpb+WggbrJhgUcANBJFVu/ejWZ5THeL0SbAI
         gcEdc7hZyRxEC45gLf9CNdhr7E2OxcbqOFYtwbzjHzEyxhagJ7Etdz3W6h0X6Jqd4R
         jD+czIGejDsiuvEHtlptS00L4KP8w4SktsBe1cQA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09J8sQ8j080902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 03:54:26 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 19
 Oct 2020 03:54:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 19 Oct 2020 03:54:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09J8sOcr068437;
        Mon, 19 Oct 2020 03:54:24 -0500
Subject: Re: [PATCH 1/4] dmaengine: move enums in interface to use peripheral
 term
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <20201015073132.3571684-1-vkoul@kernel.org>
 <20201015073132.3571684-2-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <84995bc9-9e77-1e4b-efc2-7284a25f292d@ti.com>
Date:   Mon, 19 Oct 2020 11:54:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201015073132.3571684-2-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 15/10/2020 10.31, Vinod Koul wrote:
> dmaengine history has a non inclusive terminology of dmaengine slave, I
> feel it is time to replace that. Start with moving enums in dmaengine
> interface with replacement of slave to peripheral which is an
> appropriate term for dmaengine peripheral devices
> 
> Since the change of name can break users, the new names have been added
> with old enums kept as macro define for new names. Once the users have
> been migrated, these macros will be dropped.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  include/linux/dmaengine.h | 44 ++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index dd357a747780..f7f420876d21 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -59,7 +59,7 @@ enum dma_transaction_type {
>  	DMA_INTERRUPT,
>  	DMA_PRIVATE,
>  	DMA_ASYNC_TX,
> -	DMA_SLAVE,
> +	DMA_PERIPHERAL,
>  	DMA_CYCLIC,
>  	DMA_INTERLEAVE,
>  	DMA_COMPLETION_NO_ORDER,
> @@ -69,12 +69,14 @@ enum dma_transaction_type {
>  	DMA_TX_TYPE_END,
>  };
>  
> +#define DMA_SLAVE DMA_PERIPHERAL
> +
>  /**
>   * enum dma_transfer_direction - dma transfer mode and direction indicator
>   * @DMA_MEM_TO_MEM: Async/Memcpy mode
> - * @DMA_MEM_TO_DEV: Slave mode & From Memory to Device
> - * @DMA_DEV_TO_MEM: Slave mode & From Device to Memory
> - * @DMA_DEV_TO_DEV: Slave mode & From Device to Device
> + * @DMA_MEM_TO_DEV: Peripheral mode & From Memory to Device
> + * @DMA_DEV_TO_MEM: Peripheral mode & From Device to Memory
> + * @DMA_DEV_TO_DEV: Peripheral mode & From Device to Device
>   */
>  enum dma_transfer_direction {
>  	DMA_MEM_TO_MEM,
> @@ -364,22 +366,34 @@ struct dma_chan_dev {
>  	int dev_id;
>  };
>  
> +#define	DMA_SLAVE_BUSWIDTH_UNDEFINED	DMA_PERIPHERAL_BUSWIDTH_UNDEFINED
> +#define	DMA_SLAVE_BUSWIDTH_1_BYTE	DMA_PERIPHERAL_BUSWIDTH_1_BYTE
> +#define	DMA_SLAVE_BUSWIDTH_2_BYTES	DMA_PERIPHERAL_BUSWIDTH_2_BYTES
> +#define	DMA_SLAVE_BUSWIDTH_3_BYTES	DMA_PERIPHERAL_BUSWIDTH_3_BYTES
> +#define	DMA_SLAVE_BUSWIDTH_4_BYTES	DMA_PERIPHERAL_BUSWIDTH_4_BYTES
> +#define	DMA_SLAVE_BUSWIDTH_8_BYTES	DMA_PERIPHERAL_BUSWIDTH_8_BYTES
> +#define	DMA_SLAVE_BUSWIDTH_16_BYTES	DMA_PERIPHERAL_BUSWIDTH_16_BYTES
> +#define	DMA_SLAVE_BUSWIDTH_32_BYTES	DMA_PERIPHERAL_BUSWIDTH_32_BYTES
> +#define	DMA_SLAVE_BUSWIDTH_64_BYTES	DMA_PERIPHERAL_BUSWIDTH_64_BYTES

Probably move the defines after the enum dma_peripheral_buswidth block
as well?

> +
>  /**
> - * enum dma_slave_buswidth - defines bus width of the DMA slave
> + * enum dma_peripheral_buswidth - defines bus width of the DMA peripheral
>   * device, source or target buses
>   */
> -enum dma_slave_buswidth {
> -	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
> -	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
> -	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
> -	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
> -	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
> -	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
> -	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
> -	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> -	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> +enum dma_peripheral_buswidth {
> +	DMA_PERIPHERAL_BUSWIDTH_UNDEFINED = 0,
> +	DMA_PERIPHERAL_BUSWIDTH_1_BYTE = 1,
> +	DMA_PERIPHERAL_BUSWIDTH_2_BYTES = 2,
> +	DMA_PERIPHERAL_BUSWIDTH_3_BYTES = 3,
> +	DMA_PERIPHERAL_BUSWIDTH_4_BYTES = 4,
> +	DMA_PERIPHERAL_BUSWIDTH_8_BYTES = 8,
> +	DMA_PERIPHERAL_BUSWIDTH_16_BYTES = 16,
> +	DMA_PERIPHERAL_BUSWIDTH_32_BYTES = 32,
> +	DMA_PERIPHERAL_BUSWIDTH_64_BYTES = 64,
>  };
>  
> +#define dma_slave_buswidth dma_peripheral_buswidth
> +
>  /**
>   * struct dma_slave_config - dma slave channel runtime config
>   * @direction: whether the data shall go in or out on this slave
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
