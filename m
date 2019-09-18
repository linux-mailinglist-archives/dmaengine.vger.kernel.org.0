Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E74B6573
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 16:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfIROFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 10:05:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52026 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfIROFc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Sep 2019 10:05:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IE5SiH016072;
        Wed, 18 Sep 2019 09:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568815528;
        bh=kVQC2FJRU2S5Poz/atwdatUDcVSq3TedPnujye31yYA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IHLIL9hsXCw0pG7rUgvUnX6hYKAcx4Efv+9mZw3ARmLHOIZu+iPzFxzEZKpTEz62p
         5yqZcO47XrVMNO62YaM/FwRAeNsm3Fu2LnxtaVuRzh+kgG79KSupFKVDniEmffWv7a
         VAh9JJNGYIwIg7gQiIeik1GVy+pGW8nFgSu5jSCo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8IE5SXQ065872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 09:05:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 09:05:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 09:05:28 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IE5Qke011106;
        Wed, 18 Sep 2019 09:05:27 -0500
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: ti-edma: Document
 dma-channel-mask for EDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190910114559.22810-1-peter.ujfalusi@ti.com>
 <20190910114559.22810-3-peter.ujfalusi@ti.com> <20190918132931.GA14832@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8949605b-34e8-cec1-818c-838291b72622@ti.com>
Date:   Wed, 18 Sep 2019 17:06:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918132931.GA14832@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/09/2019 16.29, Rob Herring wrote:
> On Tue, Sep 10, 2019 at 02:45:58PM +0300, Peter Ujfalusi wrote:
>> Similarly to paRAM slots, channels can be used by other cores.
>>
>> The common dma-channel-mask property can be used for specifying the
>> available channels.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  Documentation/devicetree/bindings/dma/ti-edma.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> index 4bbc94d829c8..3c7736246354 100644
>> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> @@ -42,6 +42,9 @@ Optional properties:
>>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>>  		the driver, they are allocated to be used by for example the
>>  		DSP. See example.
>> +- dma-channel-mask: Mask of usable channels, see
>> +		Documentation/devicetree/bindings/dma/dma-common.yaml
>> +
> 
> What's the size? 2 cells?

Depending on the EDMA, some have 32, some have 64 channels. I'll update
the patch to reflect this.

>>  
>>  ------------------------------------------------------------------------------
>>  eDMA3 Transfer Controller
>> @@ -91,6 +94,9 @@ edma: edma@49000000 {
>>  	ti,edma-memcpy-channels = <20 21>;
>>  	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
>>  	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
>> +	/* The following channels are reserved: 35-44 */
>> +	dma-channel-mask = <0xffffffff>, /* Channel 0-31 */
>> +			   <0xffffe007>; /* Channel 32-63 */
>>  };
>>  
>>  edma_tptc0: tptc@49800000 {
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
