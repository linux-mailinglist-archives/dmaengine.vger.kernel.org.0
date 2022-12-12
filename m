Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6564987C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 05:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiLLEvh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Dec 2022 23:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLLEvg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Dec 2022 23:51:36 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7391647E;
        Sun, 11 Dec 2022 20:51:35 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BC4pPCo070809;
        Sun, 11 Dec 2022 22:51:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670820685;
        bh=7/fFXBYjkN1MNbFYjZzD9xCpu7/tyg5It6JEWvC4SAc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dnFMcq7BkqhU+phc+ckrdXm9gACcFmi8Y9Nu5k6qO8kJRBDgxoupLlWYjGyrsHZ9A
         A9OoIWyvnTqtcLv4SOIcMusS0LWfRoCyVIhlh48idqT98VHmMojZzEOm8ansb+uM9s
         l9L2H4M/Mfn6b9ZQcBSweut5Qiac0zkAIu8h4CjY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BC4pPds000317
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Dec 2022 22:51:25 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 11
 Dec 2022 22:51:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 11 Dec 2022 22:51:25 -0600
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BC4pMMW031997;
        Sun, 11 Dec 2022 22:51:23 -0600
Message-ID: <099c1084-4093-860b-587d-2942a5da7e6c@ti.com>
Date:   Mon, 12 Dec 2022 10:21:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/5] dmaengine: ti: k3-udma: Add support for BCDMA CSI RX
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-6-vigneshr@ti.com>
 <46e1321e-ff27-7b95-6f93-975d08802626@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <46e1321e-ff27-7b95-6f93-975d08802626@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/12/22 14:19, Péter Ujfalusi wrote:
> 
> 
> On 12/6/22 06:35, Vignesh Raghavendra wrote:
>> BCDMA CSI RX present on AM62Ax SoC is a dedicated DMA for servicing
>> Camera Serial Interface (CSI) IP. Add support for the same.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 37 ++++++++++++++++++++++++++++++++-----
>>  1 file changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 19fce52a9b53..a8b497ed3f30 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -135,6 +135,7 @@ struct udma_match_data {
>>  	u32 flags;
>>  	u32 statictr_z_mask;
>>  	u8 burst_size[3];
>> +	struct udma_soc_data *soc_data;
>>  };
>>  
>>  struct udma_soc_data {
>> @@ -4295,6 +4296,25 @@ static struct udma_match_data j721e_mcu_data = {
>>  	},
>>  };
>>  
>> +static struct udma_soc_data am62a_dmss_csi_soc_data = {
>> +	.oes = {
>> +		.bcdma_rchan_data = 0xe00,
>> +		.bcdma_rchan_ring = 0x1000,
>> +	},
>> +};
>> +
>> +static struct udma_match_data am62a_bcdma_csirx_data = {
>> +	.type = DMA_TYPE_BCDMA,
>> +	.psil_base = 0x3100,
>> +	.enable_memcpy_support = false,
>> +	.burst_size = {
>> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
>> +		0, /* No H Channels */
>> +		0, /* No UH Channels */
>> +	},
>> +	.soc_data = &am62a_dmss_csi_soc_data,
>> +};
>> +
>>  static struct udma_match_data am64_bcdma_data = {
>>  	.type = DMA_TYPE_BCDMA,
>>  	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
>> @@ -4344,6 +4364,10 @@ static const struct of_device_id udma_of_match[] = {
>>  		.compatible = "ti,am64-dmss-pktdma",
>>  		.data = &am64_pktdma_data,
>>  	},
>> +	{
>> +		.compatible = "ti,am62a-dmss-bcdma-csirx",
>> +		.data = &am62a_bcdma_csirx_data,
>> +	},
>>  	{ /* Sentinel */ },
>>  };
>>  
>> @@ -5272,12 +5296,15 @@ static int udma_probe(struct platform_device *pdev)
>>  	}
>>  	ud->match_data = match->data;
>>  
>> -	soc = soc_device_match(k3_soc_devices);
>> -	if (!soc) {
>> -		dev_err(dev, "No compatible SoC found\n");
>> -		return -ENODEV;
>> +	ud->soc_data = ud->match_data->soc_data;
>> +	if (!ud->soc_data) {
>> +		soc = soc_device_match(k3_soc_devices);
>> +		if (!soc) {
>> +			dev_err(dev, "No compatible SoC found\n");
>> +			return -ENODEV;
>> +		}
>> +		ud->soc_data = soc->data;
>>  	}
>> -	ud->soc_data = soc->data;
> 
> Right, the original design was based on the promise that a DMSS will
> contain maximum 1 BCDMA and/or 1 PKTDMA, looks like now a DMSS have 2
> BCDMAs?
> 

Thats correct. IPs requiring dedicated B/W paths (its just CSI today)
would probably have dedicated BCDMA.

> The only possible issue I can see is that if in future SoCs the Output
> Event Offsets got shuffled for the BCDMAs, but then a new compatible for
> each SoC might just work.
> 

We have ensured all BCDMAs for CSI follow the same offsets across the
SoCs. So, this compatible should work for all BCDMA_CSIs. But yes, this
can be expanded by adding new compatible is third BCDMA variant shows up
(doesn't exist today though).

> Nice solution with minimal change! ;)

Thanks! appreciate the review comments.


> 
>>  
>>  	ret = udma_get_mmrs(pdev, ud);
>>  	if (ret)
> 

-- 
Regards
Vignesh
