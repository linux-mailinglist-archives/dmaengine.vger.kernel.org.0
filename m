Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C76A1E78
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjBXPXp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 10:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBXPXh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 10:23:37 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D31BD3;
        Fri, 24 Feb 2023 07:23:10 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E170724E2C7;
        Fri, 24 Feb 2023 23:23:04 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 23:23:04 +0800
Received: from [192.168.125.93] (113.72.147.165) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 23:23:03 +0800
Message-ID: <4636338e-b69c-0dc6-d9ee-2a687bf9448c@starfivetech.com>
Date:   Fri, 24 Feb 2023 23:23:03 +0800
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
 <d0984638-3f7f-7e4e-fe3e-5e1f88375dca@starfivetech.com>
 <36188e04-332f-e944-9c58-f6f2b74987da@linaro.org>
 <bd4301c5-d79f-6ba5-a840-95b733d2d44e@starfivetech.com>
 <6ebf87aa-4422-1f84-7e76-276ac4d884c3@linaro.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <6ebf87aa-4422-1f84-7e76-276ac4d884c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX168.cuchost.com
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



On 2023/2/24 21:21, Krzysztof Kozlowski wrote:
> On 24/02/2023 14:09, Walker Chen wrote:
>> 
>> 
>> On 2023/2/24 18:51, Krzysztof Kozlowski wrote:
>>> On 24/02/2023 11:14, Walker Chen wrote:
>>>>>>    resets:
>>>>>> -    maxItems: 1
>>>>>> +    maxItems: 2
>>>>>
>>>>> This breaks ABI and all other users. Test your changes before sending.
>>>>
>>>> I think 'minItems' should be added here. So like this:
>>>> resets:
>>>>   minItems: 1
>>>>   maxItems: 2
>>>>
>>>> Other platform/users will not be affected by this.
>>>
>>> Which will allow two resets on all platforms. Is this correct for these
>>> platforms? Do they have two resets?
>>>
>> In kernel 6.2, only two platforms use this DMA controller (see 'arch/arc/boot/dts/hsdk.dts' and 'arch/riscv/boot/dts/canaan/k210.dtsi').
> 
> What about all out-of-tree platforms, bootloaders and FW?
> 
>> There is one reset on k210, while there is no reset of DMA on hsdk at all.
>> If here minItems with value 1 is added and the value of maxItems is changed to 2, after my testing,
>> whether it is one reset or two resets, even no reset, there is no errors occur when doing dtbs_check,
> 
> Yeah, I know how this works.
> 
>> the DMA initialization shall not be affected either on their platforms.
> 
> I asked whether the hardware physically have two resets. dtbs_check
> checks the DTS, not the hardware. You know allow two resets for each
> other variant. What's more, you call first reset axi for all variants.
> This does not look correct, e.g. k210.dtsi does not indicate this is axi
> reset line but reset for entire block.
> 
> Thus your change should be constrained per your variant (min/max in
> top-level, allOf:if:then allowing two lines for you, disallowing for
> others).
> 
I see what you mean. Thank you for your guidance!
I will use allOf:if:then structure to indicate different case for resets in next version of patch.

Best regards,
Walker 

