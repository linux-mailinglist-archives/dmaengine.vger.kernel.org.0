Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6026453D1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Dec 2022 07:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLGGKQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Dec 2022 01:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiLGGKP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Dec 2022 01:10:15 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996E5984C;
        Tue,  6 Dec 2022 22:10:12 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B76A0Iw106300;
        Wed, 7 Dec 2022 00:10:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670393400;
        bh=CZx2YYGidUXCNUEuGr4xCdXPppfNpvQufFTXwZLi/FY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hOt/HKigxP9Ir8oKq+TD408TSJABBlzcpZt0Hl/8fkgagVhjbKZCGKQpU1tETLuT9
         03xTcmjS/mz9vYb5wj4OWz5kGDAo2Q1qDx15csE2cgxrI3WGtl1U/N3kg4N44xx+UX
         jngulxrpCbzrMUd6A+q+RWx5qkIPku3mKPaDC9pg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B76A0ef004847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 00:10:00 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 7
 Dec 2022 00:09:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 7 Dec 2022 00:09:59 -0600
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B769uOr024284;
        Wed, 7 Dec 2022 00:09:57 -0600
Message-ID: <8e93f459-53e0-ee39-96cc-2c9e51a72547@ti.com>
Date:   Wed, 7 Dec 2022 11:39:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for
 BCDMA CSI RX
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-2-vigneshr@ti.com>
 <63e1e565-b1e7-ecfc-009a-ee036108f160@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <63e1e565-b1e7-ecfc-009a-ee036108f160@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Krzysztof,

On 06/12/22 14:02, Krzysztof Kozlowski wrote:
> On 06/12/2022 05:35, Vignesh Raghavendra wrote:
>> AM62A SoC has a dedicated BCDMA that serves Camera Serial Interface
>> (CSI) IP. Add new compatible for the same. Unlike system
>> BCDMA, this instance only has RX DMA channels and lack TX or block copy
>> channel. Thus make those properties optional. Additionally CSI RX has
>> independent power domain, add the binding for the same.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 87 ++++++++++++++-----
>>  1 file changed, 63 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> index 08627d91e607..d7b5adbb9b2e 100644
>> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> @@ -32,9 +32,66 @@ allOf:
>>    - $ref: /schemas/dma/dma-controller.yaml#
>>    - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
>>  
> 
> When adding if:then:, please move entire allOf after "required:" part.

Sure, will do

> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ti,am62a-dmss-bcdma-csirx
>> +    then:
>> +      properties:
>> +        ti,sci-rm-range-bchan: false
>> +        ti,sci-rm-range-tchan: false
>> +
>> +        reg:
>> +          maxItems: 3
>> +
>> +        reg-names:
>> +          items:
>> +            - const: gcfg
>> +            - const: rchanrt
>> +            - const: ringrt
> 
> With my changes further this can be only "maxItems: 3"

Yes, but wont that mean any of the 3 reg-names out of the 5? Would it
not be better to further restrict specifically to above 3 reg-names (as
thats how the IP is)

> 
>> +
>> +      required:
>> +        - compatible
>> +        - "#dma-cells"
>> +        - reg
>> +        - reg-names
>> +        - msi-parent
>> +        - ti,sci
>> +        - ti,sci-dev-id
>> +        - ti,sci-rm-range-rchan
>> +        - power-domains
>> +
>> +    else:
>> +      properties:
>> +        reg:
>> +          maxItems: 5
>> +
>> +        reg-names:
>> +          items:
>> +            - const: gcfg
>> +            - const: bchanrt
>> +            - const: rchanrt
>> +            - const: tchanrt
>> +            - const: ringrt
> 
> With my changes further this can be only "minItems: 5"

Ok.

> 
>> +
>> +      required:
>> +        - compatible
>> +        - "#dma-cells"
>> +        - reg
>> +        - reg-names
>> +        - msi-parent
>> +        - ti,sci
>> +        - ti,sci-dev-id
>> +        - ti,sci-rm-range-bchan
>> +        - ti,sci-rm-range-tchan
>> +        - ti,sci-rm-range-rchan
>> +
>>  properties:
>>    compatible:
>> -    const: ti,am64-dmss-bcdma
>> +    enum:
>> +      - ti,am64-dmss-bcdma
>> +      - ti,am62a-dmss-bcdma-csirx
> 
> Keep some order, e.g. alphabetical. This reduces later conflicts on
> simultaneous edits.

Will fix!

> 
>>  
>>    "#dma-cells":
>>      const: 3
>> @@ -65,19 +122,13 @@ properties:
>>  
>>        cell 3: ASEL value for the channel
>>  
>> -  reg:
>> -    maxItems: 5
> 
> Keep it here with widest constrains - minItems: 3, maxItems: 5
> 
>> -
>> -  reg-names:
>> -    items:
>> -      - const: gcfg
>> -      - const: bchanrt
>> -      - const: rchanrt
>> -      - const: tchanrt
>> -      - const: ringrt
> 
> Keep the list here with minItems: 3
> 
>> -
>>    msi-parent: true
>>  
>> +  power-domains:
>> +    description:
>> +      Power domain if available
>> +    maxItems: 1
>> +
>>    ti,asel:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>>      description: ASEL value for non slave channels
>> @@ -115,18 +166,6 @@ properties:
>>      items:
>>        maximum: 0x3f
>>  
>> -required:
>> -  - compatible
>> -  - "#dma-cells"
>> -  - reg
>> -  - reg-names
>> -  - msi-parent
>> -  - ti,sci
>> -  - ti,sci-dev-id
>> -  - ti,sci-rm-range-bchan
>> -  - ti,sci-rm-range-tchan
>> -  - ti,sci-rm-range-rchan
> 
> Keep required here. Customize it if needed in if:then:else.

Got it, will fix accordingly...

> 
>> -
>>  unevaluatedProperties: false
>>  
>>  examples:
> 
> Best regards,
> Krzysztof
> 

Thanks for the review!


-- 
Regards
Vignesh
