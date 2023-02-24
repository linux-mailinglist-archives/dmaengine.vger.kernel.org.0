Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EE6A19BC
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 11:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBXKO7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 05:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXKO6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 05:14:58 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA72212B;
        Fri, 24 Feb 2023 02:14:55 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C429224DB8C;
        Fri, 24 Feb 2023 18:14:39 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 18:14:39 +0800
Received: from [192.168.125.93] (113.72.147.165) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 18:14:38 +0800
Message-ID: <d0984638-3f7f-7e4e-fe3e-5e1f88375dca@starfivetech.com>
Date:   Fri, 24 Feb 2023 18:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add reset
 items
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230221140424.719-1-walker.chen@starfivetech.com>
 <20230221140424.719-2-walker.chen@starfivetech.com>
 <1467f7c5-07eb-97db-c6f2-573a4208cc28@linaro.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <1467f7c5-07eb-97db-c6f2-573a4208cc28@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023/2/22 17:17, Krzysztof Kozlowski wrote:
> On 21/02/2023 15:04, Walker Chen wrote:
>> This DMA controller needs to be reset before being used on JH7110 SoC,
>> so add reset items to support this chip.
> 
> There is reset already. The DMA controller is reset already. Your commit
> msg and commit subject do not match commit at all.

OK, the commit message will be changed to match the actual modification.

> 
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml         | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> index ad107a4d3b33..c2247c65a22f 100644
>> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> @@ -20,6 +20,7 @@ properties:
>>      enum:
>>        - snps,axi-dma-1.01a
>>        - intel,kmb-axi-dma
>> +      - starfive,jh7110-axi-dma
>>  
>>    reg:
>>      minItems: 1
>> @@ -58,7 +59,12 @@ properties:
>>      maximum: 8
>>  
>>    resets:
>> -    maxItems: 1
>> +    maxItems: 2
> 
> This breaks ABI and all other users. Test your changes before sending.

I think 'minItems' should be added here. So like this:
resets:
  minItems: 1
  maxItems: 2

Other platform/users will not be affected by this.

Thanks.

Best regards,
Walker




