Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11478DC40
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjH3SoH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 14:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbjH3Jd6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 05:33:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015EBE;
        Wed, 30 Aug 2023 02:33:55 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RbJwY2FvqzrS4S;
        Wed, 30 Aug 2023 17:32:13 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 17:33:51 +0800
Message-ID: <6906870e-cafa-9a5e-f981-38561576455c@huawei.com>
Date:   Wed, 30 Aug 2023 17:33:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: hisi: Add bindings for Hisi
 Ascend sdma
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>
References: <20230824040007.1476-1-guomengqi3@huawei.com>
 <20230824040007.1476-3-guomengqi3@huawei.com>
 <20230824194324.GA1342234-robh@kernel.org>
From:   "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <20230824194324.GA1342234-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.156]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


在 2023/8/25 3:43, Rob Herring 写道:
> On Thu, Aug 24, 2023 at 12:00:07PM +0800, Guo Mengqi wrote:
>> Add device-tree binding documentation for the Hisi Ascend sdma
>> controller.
>>
>> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
>> ---
>>   .../bindings/dma/hisi,ascend-sdma.yaml        | 75 +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
>> new file mode 100644
>> index 000000000000..87b6132c1b4b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/hisi,ascend-sdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: HISI Ascend System DMA (SDMA) controller
>> +
>> +description: |
>> +  The Ascend SDMA controller is used for transferring data
>> +  in system memory. It utilizes IOMMU SVA feature and accepts
>> +  virtual address from user process.
>> +
>> +maintainers:
>> +  - Guo Mengqi <guomengqi3@huawei.com>
>> +
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - hisilicon,ascend310-sdma
>> +      - hisilicon,ascend910-sdma
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#dma-cells':
>> +    const: 1
>> +    description:
>> +      Clients specify a single cell with channel number.
>> +
>> +  hisilicon,ascend-sdma-channel-map:
>> +    description: |
>> +      bitmap, each bit stands for a channel that is allowed to
>> +      use by this system. Maximum 64 bits.
>> +    $ref: /schemas/types.yaml#/definitions/uint64
> Sounds like the common property dma-channel-mask. Use that.
It does seem to be the one I'm looking for. Will use it in next patch.
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  pasid-num-bits:
> Needs a vendor prefix.
This can be found in iommu optional properties. Although nobody use it 
for now.
>> +    description: |
>> +      sdma utilizes iommu sva feature to transfer user space data.
> Isn't shared VA mostly a s/w concept?

Well, sdma controller has built-in mechanism to support shared VA 
translation.

I add this to explain purpose of property.

>> +      It acts as a basic dma controller if not bound to user space.
> I don't understand what this means.

By "basic" I mean iommu bypass mode, which is supported in hardware design.

So if the transfer is all in physical address, it seems quite... basic?


However, shared VA is main usage scenario. Driver only implements shared 
VA. So I guess I can remove this line.

>> +    const: 0x10
> If only 1 value is allowed, what is the point of this property.

It seems that the property should be declared here, to tell iommu it 
supports PASID (see 2e981b9468e670b76bd1048fa939ad1f9653bd79 mainline).

I think it could be adjust to other values. I will check out if there is 
a specific range.

> Rob
> .

Best regards,

Guo Mengqi

