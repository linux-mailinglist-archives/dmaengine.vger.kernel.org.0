Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E19B6570
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfIROEV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Sep 2019 10:04:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51902 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIROEV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Sep 2019 10:04:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IE4HF5015793;
        Wed, 18 Sep 2019 09:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568815457;
        bh=3IqZ7QQNPGbKB+VrbDJkv8iQGk6g6o0mAIi0I5dEBbc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o2zvlyrj8s+xGfs2P4CEja5v4bbRkLuWiiBniwz+39fwrA8q/Kc8VilDxiQE+ROdc
         r9k8kQeLz8LY6BJD8kYdqiyTdp0GwX4cjz1k20L6fmfUPTjWRaeCBwTltRLWc7lPW2
         sUgRr/g8BDiSZsYyZyePm+M9taE91dRRkqkYpq5E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8IE4H51063528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 09:04:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 09:04:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 09:04:13 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IE4ENA056662;
        Wed, 18 Sep 2019 09:04:14 -0500
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: dma-common: Change
 dma-channel-mask to uint32-array
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190910114559.22810-1-peter.ujfalusi@ti.com>
 <20190910114559.22810-2-peter.ujfalusi@ti.com> <20190918132835.GA4527@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d76ffc38-8e68-656a-325b-37de9b01e015@ti.com>
Date:   Wed, 18 Sep 2019 17:04:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918132835.GA4527@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/09/2019 16.28, Rob Herring wrote:
> On Tue, Sep 10, 2019 at 02:45:57PM +0300, Peter Ujfalusi wrote:
>> Make the dma-channel-mask to be usable for controllers with more than 32
>> channels.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  Documentation/devicetree/bindings/dma/dma-common.yaml | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
>> index ed0a49a6f020..41460946be64 100644
>> --- a/Documentation/devicetree/bindings/dma/dma-common.yaml
>> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
>> @@ -25,11 +25,19 @@ properties:
>>        Used to provide DMA controller specific information.
>>  
>>    dma-channel-mask:
>> -    $ref: /schemas/types.yaml#definitions/uint32
>>      description:
>>        Bitmask of available DMA channels in ascending order that are
>>        not reserved by firmware and are available to the
>>        kernel. i.e. first channel corresponds to LSB.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        items:
>> +          minItems = 1
> 
> '='? Just making up the syntax?

Opps, sorry.

> 
>> +          maxItems = 255 # Should be enough
>> +          - description: Mask of channels 0-31
>> +          - description: Mask of channels 32-63
> 
> You are mixing a schema and list here...

Should I extend the description with something like this:
"The first item in the array is for channels 0-31, the second is for
channels 32-63, etc."

To make sure that it is used in a correct and consistent manner.

>> +          ...
> 
> That's end of doc marker in YAML...

I believe I need some reading to do for YAML..

> 
>> +          - description: Mask of chnanels X-(X+31)
> 
> Obviously, this was not validated with 'make dt_binding_check'.
make dt_bindings_check
make: *** No rule to make target 'dt_bindings_check'.  Stop.

> What you  want is:
> 
>     allOf:
>       - $ref: /schemas/types.yaml#/definitions/uint32-array
>       - minItems: 1
>         maxItems: 255 # Should be enough

OK and thanks for the comments.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
