Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2FC6F7F75
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjEEI6l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 04:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEEI6k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 04:58:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230113C22;
        Fri,  5 May 2023 01:58:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3458wWfR059994;
        Fri, 5 May 2023 03:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683277112;
        bh=SWG4LX47KUpJB6whFqKHOX6asRz/2b2FfJDoFeUwT0k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=r+kQNaDcaYT8h9C47rzGLsXNQqpER5ieWLV5Cafe/Ellq9lCUC09MfWsX75MpB2vC
         DKbSMrRijCZ/VKLnochszoHxLb/QwcMiMnoNTmMbhaD9Q3W7bZYRCZS2OcGUUUMyv3
         DDdYUIogH535uSLhfuq1E1UY7Xk1ijyFyKX2aZyQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3458wWue054742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 03:58:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 03:58:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 03:58:32 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3458wSVa062228;
        Fri, 5 May 2023 03:58:29 -0500
Message-ID: <e9415553-1439-2039-3d85-88c4ac29583e@ti.com>
Date:   Fri, 5 May 2023 14:28:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>
References: <20230503065303.16674-1-vaishnav.a@ti.com>
 <6bce9c65-12f3-0128-91d0-142f0b5a791e@linaro.org>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <6bce9c65-12f3-0128-91d0-142f0b5a791e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Krzysztof,

On 04/05/23 22:34, Krzysztof Kozlowski wrote:
> On 03/05/2023 08:53, Vaishnav Achath wrote:
>> Add bindings for J721S2 BCDMA instance dedicated for Camera
>> Serial Interface. Unlike AM62A CSI BCDMA, this instance has RX
>> and TX channels but lacks block copy channels.
>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 21 +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> index beecfe7a1732..5ca9581a66f4 100644
>> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> @@ -33,6 +33,7 @@ properties:
>>      enum:
>>        - ti,am62a-dmss-bcdma-csirx
>>        - ti,am64-dmss-bcdma
>> +      - ti,j721s2-dmss-bcdma-csi
>>  
>>    reg:
>>      minItems: 3
>> @@ -150,7 +151,27 @@ allOf:
>>  
>>        required:
>>          - power-domains
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ti,j721s2-dmss-bcdma-csi
>> +    then:
>> +      properties:
>> +        ti,sci-rm-range-bchan: false
>> +
>> +        reg:
>> +          maxItems: 4
>>  
>> +        reg-names:
>> +          items:
>> +            - const: gcfg
>> +            - const: rchanrt
>> +            - const: tchanrt
>> +            - const: ringrt
>> +
>> +      required:
>> +        - ti,sci-rm-range-tchan
>>      else:
>>        properties:
> 
> 
> You now require 5 reg items on ti,am62a-dmss-bcdma-csirx. I don't think
> you tested your DTS against this change. Rework the else: so it will
> match specific variant (if:).

Thank you for the review, Sorry, I did not have the ti,am62a-dmss-bcdma-csirx
instance added while I tested this change, I have made the update you suggested,
checked DTS with the nodes added and sent a v2 now.

Thanks and Regards,
Vaishnav

> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Vaishnav
