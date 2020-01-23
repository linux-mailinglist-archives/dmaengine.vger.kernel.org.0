Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46121462FD
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 09:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAWICv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 03:02:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33830 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgAWICu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 03:02:50 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00N82jKL092018;
        Thu, 23 Jan 2020 02:02:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579766566;
        bh=ypNW+usxLFqX7mBDpIlbeZBSDyFb2i6QeUVtoDhqkzw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GRGjOf/ksCPx3xBRaHYABtViCmI2195m989QENThnEOprwrSUmA8XP5NDI0kFe79R
         NeTiGAnIYnxnf96/2sqS+EXwBAbNhesUezG4Su0WUtwpTmiFYeXV7mcGPqIqKjLkMz
         JzLJ2R+gBHWt5m3kh9UCiTMufMtWD8vkdnEk5l5E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00N82joE094879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 02:02:45 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 02:02:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 02:02:39 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N82bq6071939;
        Thu, 23 Jan 2020 02:02:37 -0600
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dmaengine@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
Date:   Thu, 23 Jan 2020 10:03:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 23/01/2020 4.29, Laurent Pinchart wrote:
> The new interleaved cyclic transaction type combines interleaved and
> cycle transactions. It is designed for DMA engines that back display
> controllers, where the same 2D frame needs to be output to the display
> until a new frame is available.
> 
> Suggested-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/dma/dmaengine.c   |  8 +++++++-
>  include/linux/dmaengine.h | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 03ac4b96117c..4ffb98a47f31 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -981,7 +981,13 @@ int dma_async_device_register(struct dma_device *device)
>  			"DMA_INTERLEAVE");
>  		return -EIO;
>  	}
> -
> +	if (dma_has_cap(DMA_INTERLEAVE_CYCLIC, device->cap_mask) &&
> +	    !device->device_prep_interleaved_cyclic) {
> +		dev_err(device->dev,
> +			"Device claims capability %s, but op is not defined\n",
> +			"DMA_INTERLEAVE_CYCLIC");
> +		return -EIO;
> +	}
>  
>  	if (!device->device_tx_status) {
>  		dev_err(device->dev, "Device tx_status is not defined\n");
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8fcdee1c0cf9..e9af3bf835cb 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -61,6 +61,7 @@ enum dma_transaction_type {
>  	DMA_SLAVE,
>  	DMA_CYCLIC,
>  	DMA_INTERLEAVE,
> +	DMA_INTERLEAVE_CYCLIC,
>  /* last transaction type for creation of the capabilities mask */
>  	DMA_TX_TYPE_END,
>  };
> @@ -701,6 +702,10 @@ struct dma_filter {
>   *	The function takes a buffer of size buf_len. The callback function will
>   *	be called after period_len bytes have been transferred.
>   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> + * @device_prep_interleaved_cyclic: prepares an interleaved cyclic transfer.
> + *	This is similar to @device_prep_interleaved_dma, but the transfer is
> + *	repeated until a new transfer is issued. This transfer type is meant
> + *	for display.

I think capture (camera) is another potential beneficiary of this.

So you don't need to terminate the running interleaved_cyclic and start
a new one, but prepare and issue a new one, which would
terminate/replace the currently running cyclic interleaved DMA?

Can you also update the documentation at
Documentation/driver-api/dmaengine/client.rst

One more thing might be good to clarify for the interleaved_cyclic:
What is expected when DMA_PREP_INTERRUPT is set in the flags? The
client's callback is called for each completion of
dma_interleaved_template, right?

- Péter

>   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
>   * @device_config: Pushes a new configuration to a channel, return 0 or an error
>   *	code
> @@ -785,6 +790,9 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
>  		struct dma_chan *chan, struct dma_interleaved_template *xt,
>  		unsigned long flags);
> +	struct dma_async_tx_descriptor *(*device_prep_interleaved_cyclic)(
> +		struct dma_chan *chan, struct dma_interleaved_template *xt,
> +		unsigned long flags);
>  	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
>  		struct dma_chan *chan, dma_addr_t dst, u64 data,
>  		unsigned long flags);
> @@ -880,6 +888,16 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
>  	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
>  }
>  
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_cyclic(
> +		struct dma_chan *chan, struct dma_interleaved_template *xt,
> +		unsigned long flags)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_interleaved_cyclic)
> +		return NULL;
> +
> +	return chan->device->device_prep_interleaved_cyclic(chan, xt, flags);
> +}
> +
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
>  		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
>  		unsigned long flags)
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
