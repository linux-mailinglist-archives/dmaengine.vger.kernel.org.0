Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D22884E0
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbgJIIGn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 04:06:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgJIIGm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Oct 2020 04:06:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09986VA4111967;
        Fri, 9 Oct 2020 03:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602230791;
        bh=BHTrCfkiTOmXAou93T2ihLIRlwCwPpMEKu1ad7VxsbA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G+b6W2PG2fdRqSHgCyBL7rYoIjHLHbnG3bjeh7mXe863YM0jen/l3tk+KAsw58rKm
         PuEN40yCkC631DMp4/fZBfTxl29L8HCpfHwnfmGWDNrNKSSgdzwvoqVJ9n/ekmn5dt
         L3r35sJjDI0bwNBKZw740t7LXTNIMzHB+ArBlw6M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09986V0w091492
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 03:06:31 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 03:06:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 03:06:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09986R0G066243;
        Fri, 9 Oct 2020 03:06:28 -0500
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
To:     Rob Herring <robh@kernel.org>
CC:     Vinod <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh R <vigneshr@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tero Kristo <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
 <20201006192909.GA2679155@bogus>
 <bc054ef7-dcd7-dde2-13f8-4900a33b1377@ti.com> <20201007154635.GA273523@bogus>
 <d5746fca-bbdd-0fd1-cbcb-21b6269c39ac@ti.com>
 <CAL_JsqJnk=ycRurUTBwWgX1+vOq_MZuevegvK2MwGJHkHW50mg@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1f532784-c46d-6746-2511-466fd82c0809@ti.com>
Date:   Fri, 9 Oct 2020 11:06:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJnk=ycRurUTBwWgX1+vOq_MZuevegvK2MwGJHkHW50mg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/10/2020 22.15, Rob Herring wrote:
> On Thu, Oct 8, 2020 at 3:40 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

>>> Yeah, you have to do 'unevaluatedProperties: false' which doesn't
>>> actually do anything yet, but can 'see' into $ref's.
>>
>> I see, but even if I add the unevaluatedProperties: false I will have
>> the same error as long as I have additionalProperties: false
> 
> Yes. I meant unevaluatedProperties instead of additionalProperties.

OK, changed it to unevaluatedProperties.

>> If I remove the additionalProperties then it makes no difference if I
>> have the unevaluatedProperties: false or I don't.
> 
> Not yet, but it will soon. Once I have the tree in a consistent state
> in 5.10-rc1, there will be a meta-schema to check all this (which is
> one of those must always be present).
> 
> Though, as of now 'unevaluatedProperties' doesn't do anything because
> the underlying json-schema tool doesn't yet support it.

Understand, thanks for the details.

>>>>>> +  ti,sci-rm-range-bchan:
>>>>>> +    description: |
>>>>>> +      Array of BCDMA block-copy channel resource subtypes for resource
>>>>>> +      allocation for this host
>>>>>> +    allOf:
>>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>> +    minItems: 1
>>>>>> +    # Should be enough
>>>>>> +    maxItems: 255
>>>>>
>>>>> Are there constraints for the individual elements?
>>>>
>>>> In practice the subtype ID is 6bits number.
>>>> Should I add limits to individual elements?
>>>
>>> Yes:
>>>
>>> items:
>>>   maximum: 0x3f
>>
>> Right, I can just omit the minimum.
>>
>> It would be nice if I could use definitions for these ranges to avoid
>> duplicated lines by adding
>>
>> definitions:
>>   ti,rm-range:
>>     $ref: /schemas/types.yaml#/definitions/uint32-array
>>     minItems: 1
>>     # Should be enough
>>     maxItems: 255
>>     items:
>>       minimum: 0
>>       maximum: 0x3f
>>
>> to schemas/arm/keystone/ti,k3-sci-common.yaml
>>
>> and only have:
>>
>>   ti,sci-rm-range-bchan:
>>     $ref:
>> /schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range
>>     description: |
>>       Array of BCDMA block-copy channel resource subtypes for resource
>>       allocation for this host
> 
> Just do:
> 
> patternProperties:
>   "^ti,sci-rm-range-[btr]chan$":
>     ...
> 
> If this is common for other bindings, then you can put it in
> ti,k3-sci-common.yaml.

Similar property (for RM ranges) also used by the ringacc, I have tried
to standardize us to use: ti,sci-rm-range-* in DT.

I will leave it as it is now for this series and we can simplify it
later with a wider series touching all involved yaml files.

>> but it results:
>> Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
>> properties:ti,sci-rm-range-bchan: {'$ref':
>> '/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range',
>> 'description': 'Array of BCDMA block-copy channel resource subtypes for
>> resource\nallocation for this host\n'} is not valid under any of the
>> given schemas (Possible causes of the failure):
>>         Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
>> properties:ti,sci-rm-range-bchan: 'not' is a required property
>>         Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
>> properties:ti,sci-rm-range-bchan:$ref:
>> '/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range'
>> does not match 'types.yaml#[/]{0,1}definitions/.*'
> 
> We probably should allow for using 'definitions' which is pretty
> common json-schema practice, but don't primarily in order to keep
> folks within the lines. Things are optimized for not knowing
> json-schema and trying to minimize errors I have to check for.

I agree on these.

> Supporting it would complicate the meta-schema and the tools' fixup
> code. So far, the need for it has been pretty infrequent.

Sure, for the couple of duplication I have it is manageable without
sacrificing readability.

btw: I have made the similar changes to the k3-pktdma schema.

> 
> Rob
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
