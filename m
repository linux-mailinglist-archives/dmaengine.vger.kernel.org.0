Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C46A925E
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCCI1Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 03:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCCI1X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 03:27:23 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5A59424;
        Fri,  3 Mar 2023 00:26:34 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C974224E285;
        Fri,  3 Mar 2023 16:24:10 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 16:24:10 +0800
Received: from [192.168.125.93] (113.72.145.171) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 16:24:10 +0800
Message-ID: <82b2a817-5fb6-d0fc-868a-26a0285bcad7@starfivetech.com>
Date:   Fri, 3 Mar 2023 16:24:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain
 minItems/maxItems of resets for JH7110 DMA
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230227131042.16125-1-walker.chen@starfivetech.com>
 <20230227131042.16125-2-walker.chen@starfivetech.com>
 <20230228153752.GA3292255-robh@kernel.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230228153752.GA3292255-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023/2/28 23:37, Rob Herring wrote:
> On Mon, Feb 27, 2023 at 09:10:40PM +0800, Walker Chen wrote:
>> The DMA controller needs two reset items to work properly on JH7110 SoC,
>> so there is need to change the maxItems' value to 2 and add minItems
>> whose value is equal to 1. Other platforms do not have this constraint.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 ++++++++++++++++---
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> index ad107a4d3b33..4ed0a6b7ca69 100644
>> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> @@ -12,14 +12,12 @@ maintainers:
>>  description:
>>    Synopsys DesignWare AXI DMA Controller DT Binding
>>  
>> -allOf:
>> -  - $ref: "dma-controller.yaml#"
>> -
>>  properties:
>>    compatible:
>>      enum:
>>        - snps,axi-dma-1.01a
>>        - intel,kmb-axi-dma
>> +      - starfive,jh7110-axi-dma
>>  
>>    reg:
>>      minItems: 1
>> @@ -58,7 +56,8 @@ properties:
>>      maximum: 8
>>  
>>    resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>    snps,dma-masters:
>>      description: |
>> @@ -109,6 +108,24 @@ required:
>>    - snps,priority
>>    - snps,block-size
>>  
>> +allOf:
>> +  - $ref: "dma-controller.yaml#"
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - starfive,jh7110-axi-dma
>> +    then:
>> +      properties:
>> +        resets:
>> +          minItems: 1
>> +          maxItems: 2
> 
> A given platform should not have a variable number of resets. This also 
> does nothing because you just duplicated the top-level constraints. If 
> you have 2, then you want just 'minItems: 2'.

Okay, this will be fixed.
Thank you for pointing out the problem for me.

Best regards,
Walker
