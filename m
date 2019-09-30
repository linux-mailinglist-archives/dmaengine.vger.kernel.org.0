Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE11AC1F9C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2019 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfI3Kyn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Sep 2019 06:54:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbfI3Kyn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Sep 2019 06:54:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UAsc5W103901;
        Mon, 30 Sep 2019 05:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569840878;
        bh=zqrEzi3Cd3ZnhOONeBCKzkiICJvCoUyq7dA0p4K5OUo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IALk37nuw/DtUgbZwsfLfDhhiCjF+f0+s9OqDQPMLrw6evoZQDf0izkq67qQ0Kp7A
         IQvy98e13OaekZhrxyMFXHGc7VydfeiAq3OkxdWhAFC+VIo0SwEQLw/nmUr9osUw66
         axVw2uSW/acFrPIlrGtF2m/05MLeo5GISeVVzfhM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UAscNL101199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 05:54:38 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 05:54:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 05:54:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UAsaCA055134;
        Mon, 30 Sep 2019 05:54:36 -0500
Subject: Re: [PATCH v3 2/3] dt-bindings: dma: ti-edma: Document
 dma-channel-mask for EDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190926111954.9184-1-peter.ujfalusi@ti.com>
 <20190926111954.9184-3-peter.ujfalusi@ti.com> <20190927204854.GA20463@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <dd88e5a3-eb9b-7ea7-7316-c036dec41fe9@ti.com>
Date:   Mon, 30 Sep 2019 13:55:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190927204854.GA20463@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 27/09/2019 23.48, Rob Herring wrote:
> On Thu, Sep 26, 2019 at 02:19:53PM +0300, Peter Ujfalusi wrote:
>> Similarly to paRAM slots, channels can be used by other cores.
>>
>> The common dma-channel-mask property can be used for specifying the
>> available channels.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  Documentation/devicetree/bindings/dma/ti-edma.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> index 4bbc94d829c8..014187088020 100644
>> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> @@ -42,6 +42,11 @@ Optional properties:
>>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>>  		the driver, they are allocated to be used by for example the
>>  		DSP. See example.
>> +- dma-channel-mask: Mask of usable channels.
>> +		Single uint32 for EDMA with 32 channels, array of two uint32 for
>> +		EDMA with 64 channels. See example and
>> +		Documentation/devicetree/bindings/dma/dma-common.yaml
>> +
>>  
>>  ------------------------------------------------------------------------------
>>  eDMA3 Transfer Controller
>> @@ -91,6 +96,9 @@ edma: edma@49000000 {
>>  	ti,edma-memcpy-channels = <20 21>;
>>  	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
>>  	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
>> +	/* The following channels are reserved: 35-44 */
>> +	dma-channel-mask = <0xffffffff>, /* Channel 0-31 */
>> +			   <0xffffe007>; /* Channel 32-63 */
> 
> Doesn't matter yet, but you have a mismatch here with the schema. While 
> the <> around each int or not doesn't matter for the dtb, it does for 
> the schema.
> 
> dma-channel-mask = <0xffffffff>, <0xffffe007>;
> minItems: 1
> maxItems: 255
> 
> dma-channel-mask = <0xffffffff 0xffffe007>;
> items:
>   minItems: 1
>   maxItems: 255
> 
> I think the latter case is slightly more logical here as you have 1 
> thing (a mask). If had N of something (like interrupts), then the former 
> makes sense.

So, in dma-common.yaml:
    allOf:
      - $ref: /schemas/types.yaml#/definitions/uint32-array

    items:
      minItems: 1
      # Should be enough
      maxItems: 255

and here in the example:
	dma-channel-mask = <0xffffffff /* Channel 0-31 */
			    0xffffe007>; /* Channel 32-63 */

I'll send an updated series with these changes.

Thanks,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
