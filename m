Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5218D2870D6
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgJHIkM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 04:40:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHIkM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Oct 2020 04:40:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0988e51J002050;
        Thu, 8 Oct 2020 03:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602146405;
        bh=dQEa+ivtnjEX/aljR1OGdMNesYRRtMHm/avYLoxmHf4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HvxFFy5ZHLb28ODKd2axhg0KiSbDmAQDdGXwykWmmEKvpXEapQy2oX4rOVclcePHS
         klxj/f8ULwdW7aUjflDjUYaqLuVJreYqc5e3SJQRyfrvP9QmhnL/T6Jxv97Og5qGhV
         Volg3fLdIxwS4JLWcgptgzURNqsqLruzPnGyMJJA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0988e4ig105458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 03:40:04 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 03:40:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 03:40:04 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0988e1Hf009269;
        Thu, 8 Oct 2020 03:40:02 -0500
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <vigneshr@ti.com>, <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
 <20201006192909.GA2679155@bogus>
 <bc054ef7-dcd7-dde2-13f8-4900a33b1377@ti.com> <20201007154635.GA273523@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d5746fca-bbdd-0fd1-cbcb-21b6269c39ac@ti.com>
Date:   Thu, 8 Oct 2020 11:40:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201007154635.GA273523@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/10/2020 18.46, Rob Herring wrote:
> On Wed, Oct 07, 2020 at 12:09:06PM +0300, Peter Ujfalusi wrote:
>>
>>
>> On 06/10/2020 22.29, Rob Herring wrote:
>>> On Wed, Sep 30, 2020 at 12:14:03PM +0300, Peter Ujfalusi wrote:
>>>> New binding document for
>>>> Texas Instruments K3 Block Copy DMA (BCDMA).
>>>>
>>>> BCDMA is introduced as part of AM64.
>>>>
>>
>> ...
>>
>>>
>>>> +  ti,sci:
>>>> +    description: phandle to TI-SCI compatible System controller node
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/phandle
>>>> +
>>>> +  ti,sci-dev-id:
>>>> +    description: TI-SCI device id of BCDMA
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> We have a common definition for these.
>>
>> Yes, in arm/keystone/ti,k3-sci-common.yaml, but I could not get to use
>> that as reference.
>>
>> I can not list it under the topmost allOf and drop the ti,sci and
>> ti,sci-dev-id like this:
>>
>> allOf:
>>   - $ref: /schemas/dma/dma-controller.yaml#
>>   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>>
>> It results:
>>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>>   DTEX    Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dts
>>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>>   DTC     Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
>>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
>> Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml:
>> dma-controller@485c0100: 'ti,sci', 'ti,sci-dev-id' do not match any of
>> the regexes: 'pinctrl-[0-9]+'
>>         From schema: Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>>
>> If I remove the "additionalProperties: false" from the schema file, then
>> it compiles fine.
> 
> Yeah, you have to do 'unevaluatedProperties: false' which doesn't 
> actually do anything yet, but can 'see' into $ref's.

I see, but even if I add the unevaluatedProperties: false I will have
the same error as long as I have additionalProperties: false

If I remove the additionalProperties then it makes no difference if I
have the unevaluatedProperties: false or I don't.

> 
>>>> +  ti,asel:
>>>> +    description: ASEL value for non slave channels
>>>> +    allOf:
>>>
>>> You no longer need 'allOf' here.
>>
>> OK, I changed it in all instances.
>>
>>>
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  ti,sci-rm-range-bchan:
>>>> +    description: |
>>>> +      Array of BCDMA block-copy channel resource subtypes for resource
>>>> +      allocation for this host
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    minItems: 1
>>>> +    # Should be enough
>>>> +    maxItems: 255
>>>
>>> Are there constraints for the individual elements?
>>
>> In practice the subtype ID is 6bits number.
>> Should I add limits to individual elements?
> 
> Yes:
> 
> items:
>   maximum: 0x3f

Right, I can just omit the minimum.

It would be nice if I could use definitions for these ranges to avoid
duplicated lines by adding

definitions:
  ti,rm-range:
    $ref: /schemas/types.yaml#/definitions/uint32-array
    minItems: 1
    # Should be enough
    maxItems: 255
    items:
      minimum: 0
      maximum: 0x3f

to schemas/arm/keystone/ti,k3-sci-common.yaml

and only have:

  ti,sci-rm-range-bchan:
    $ref:
/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range
    description: |
      Array of BCDMA block-copy channel resource subtypes for resource
      allocation for this host


but it results:
Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
properties:ti,sci-rm-range-bchan: {'$ref':
'/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range',
'description': 'Array of BCDMA block-copy channel resource subtypes for
resource\nallocation for this host\n'} is not valid under any of the
given schemas (Possible causes of the failure):
        Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
properties:ti,sci-rm-range-bchan: 'not' is a required property
        Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml:
properties:ti,sci-rm-range-bchan:$ref:
'/schemas/arm/keystone/ti,k3-sci-common.yaml#/definitions/ti,rm-range'
does not match 'types.yaml#[/]{0,1}definitions/.*'

  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml: ignoring, error
in schema: properties: ti,sci-rm-range-bchan
warning: no schema found in file:
Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml

So, obviously I'm looking at it from a wrong angle. It is not urgent, I
can spend time to figure out later and switch all cases where the RM
ranges are used.

> 
>>
>>>> +
>>>> +  ti,sci-rm-range-tchan:
>>>> +    description: |
>>>> +      Array of BCDMA split tx channel resource subtypes for resource allocation
>>>> +      for this host
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    minItems: 1
>>>> +    # Should be enough
>>>> +    maxItems: 255
>>>> +
>>>> +  ti,sci-rm-range-rchan:
>>>> +    description: |
>>>> +      Array of BCDMA split rx channel resource subtypes for resource allocation
>>>> +      for this host
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    minItems: 1
>>>> +    # Should be enough
>>>> +    maxItems: 255
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - "#address-cells"
>>>> +  - "#size-cells"
>>>> +  - "#dma-cells"
>>>> +  - reg
>>>> +  - reg-names
>>>> +  - msi-parent
>>>> +  - ti,sci
>>>> +  - ti,sci-dev-id
>>>> +  - ti,sci-rm-range-bchan
>>>> +  - ti,sci-rm-range-tchan
>>>> +  - ti,sci-rm-range-rchan
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |+
>>>> +    cbass_main {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +
>>>> +        main_dmss {
>>>> +            compatible = "simple-mfd";
>>>
>>> IMO, if it is memory-mapped, then you should be using 'simple-bus'.
>>
>> We had the same discussion when I introduced the k3-udma binding and we
>> have concluded on the simple-mfd as DMSS is not a bus, but contains
>> different peripherals.
> 
> Ok.
> 
> Rob
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
