Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E129C26BF76
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIPIh3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Sep 2020 04:37:29 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46422 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgIPIh2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Sep 2020 04:37:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08G8bPBK107515;
        Wed, 16 Sep 2020 03:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600245445;
        bh=NO5L1W1TBd6tRQC39Bmby66RFrz9l8kO1fCI273vpOA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OR0Im5bje92CDwk+oVq2jrNlRSydHF736wgsWVBVhmtO8DHxkfrNhS0IIVgoRSDwW
         0jSAwilQUH+RHfPvO/grq8cf2jpmd3jdqZ7UmoOwxel7e023CbeGOuifykMjnq0lzQ
         NBcw1KSnooAQYrNnFng8S0WQLKyO9Cqx5ksjCASs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08G8bPHh001862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 03:37:25 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 03:37:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 03:37:25 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08G8bN8V083930;
        Wed, 16 Sep 2020 03:37:23 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: fix channel enable functions
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20200915164149.22123-1-grygorii.strashko@ti.com>
 <46ea0401-e4f7-5b08-c780-b6cd7d1af5e9@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <d6b7cb0e-0d4a-a912-cd39-102717c9ccca@ti.com>
Date:   Wed, 16 Sep 2020 11:37:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <46ea0401-e4f7-5b08-c780-b6cd7d1af5e9@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 16/09/2020 11:35, Peter Ujfalusi wrote:
> 
> 
> On 15/09/2020 19.41, Grygorii Strashko wrote:
>> Now the K3 UDMA glue layer enable functions perform RMW operation on UDMA
>> RX/TX RT_CTL registers to set EN bit and enable channel, which is
>> incorrect, because only EN bit has to be set in those registers to enable
>> channel (all other bits should be cleared 0).
>> More over, this causes issues when bootloader leaves UDMA channel RX/TX
>> RT_CTL registers in incorrect state - TDOWN bit set, for example. As
>> result, UDMA channel will just perform teardown right after it's enabled.
>>
>> Hence, fix it by writing correct values (EN=1) directly in UDMA channel
>> RX/TX RT_CTL registers in k3_udma_glue_enable_tx/rx_chn() functions.
> 
> This is how the DMAengine driver deals with the enable.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Sorry, but I'd need to resend v2 - based on wrong tree.
Worked too late yesterday :(

> 
>> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma-glue.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
>> index dc03880f021a..37d706cf3ba9 100644
>> --- a/drivers/dma/ti/k3-udma-glue.c
>> +++ b/drivers/dma/ti/k3-udma-glue.c
>> @@ -370,7 +370,6 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
>>   
>>   int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>>   {
>> -	u32 txrt_ctl;
>>   	int ret;
>>   
>>   	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
>> @@ -383,15 +382,11 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>>   
>>   	tx_chn->psil_paired = true;
>>   
>> -	txrt_ctl = UDMA_PEER_RT_EN_ENABLE;
>>   	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
>> -			    txrt_ctl);
>> +			    UDMA_PEER_RT_EN_ENABLE);
>>   
>> -	txrt_ctl = xudma_tchanrt_read(tx_chn->udma_tchanx,
>> -				      UDMA_CHAN_RT_CTL_REG);
>> -	txrt_ctl |= UDMA_CHAN_RT_CTL_EN;
>>   	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
>> -			    txrt_ctl);
>> +			    UDMA_CHAN_RT_CTL_EN);
>>   
>>   	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
>>   	return 0;
>> @@ -1059,7 +1054,6 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_disable);
>>   
>>   int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
>>   {
>> -	u32 rxrt_ctl;
>>   	int ret;
>>   
>>   	if (rx_chn->remote)
>> @@ -1078,11 +1072,8 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
>>   
>>   	rx_chn->psil_paired = true;
>>   
>> -	rxrt_ctl = xudma_rchanrt_read(rx_chn->udma_rchanx,
>> -				      UDMA_CHAN_RT_CTL_REG);
>> -	rxrt_ctl |= UDMA_CHAN_RT_CTL_EN;
>>   	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
>> -			    rxrt_ctl);
>> +			    UDMA_CHAN_RT_CTL_EN);
>>   
>>   	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
>>   			    UDMA_PEER_RT_EN_ENABLE);
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Best regards,
grygorii
