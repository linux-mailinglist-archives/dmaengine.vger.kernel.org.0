Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1988F2885BE
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgJIJEH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 05:04:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbgJIJEG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Oct 2020 05:04:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099944J1005639;
        Fri, 9 Oct 2020 04:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602234244;
        bh=FT8t5B4j4P6XhHIGl23LsrUhTcxqXSyhT9rpir4C/0k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A16+6Mck75isudaNslyvogxfVTdeGyXeTmXBOqq5LvBk2TiVGbCXU23P7vjqzQg9m
         +w1LzFqQI272gASDdpi9owFaWItrV2zNEY4TB4Xy/FrH3Zjg9kLJCFvu9ISqQdLbBT
         rwETMbFE48UuytS8cGsZv1RtvmBDToRFcejch9yA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099944ul085818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 04:04:04 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 04:04:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 04:04:04 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099942aX039959;
        Fri, 9 Oct 2020 04:04:02 -0500
Subject: Re: [PATCH v4 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-3-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
Date:   Fri, 9 Oct 2020 12:04:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201008123151.764238-3-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/10/2020 15.31, Vinod Koul wrote:
> Some complex dmaengine controllers have capability to program the
> peripheral device, so pass on the peripheral configuration as part of
> dma_slave_config
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  include/linux/dmaengine.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 6fbd5c99e30c..a15dc2960f6d 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -418,6 +418,9 @@ enum dma_slave_buswidth {
>   * @slave_id: Slave requester id. Only valid for slave channels. The dma
>   * slave peripheral will have unique id as dma requester which need to be
>   * pass as slave config.
> + * @peripheral_config: peripheral configuration for programming peripheral
> + * for dmaengine transfer
> + * @peripheral_size: peripheral configuration buffer size
>   *
>   * This struct is passed in as configuration data to a DMA engine
>   * in order to set up a certain channel for DMA transport at runtime.
> @@ -443,6 +446,8 @@ struct dma_slave_config {
>  	u32 dst_port_window_size;
>  	bool device_fc;
>  	unsigned int slave_id;
> +	void *peripheral_config;
> +	size_t peripheral_size;

Do you foresee a need of src/dst pair of these?
If we do DEV_TO_DEV with different type of peripherals it is going to
cause issues.

AASRC to McASP and McASP to AASRC for example.

>  };
>  
>  /**
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
