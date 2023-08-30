Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3278D362
	for <lists+dmaengine@lfdr.de>; Wed, 30 Aug 2023 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjH3GcB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 02:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjH3Gbn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 02:31:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF520CC;
        Tue, 29 Aug 2023 23:31:39 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RbDrT356SzLp7H;
        Wed, 30 Aug 2023 14:28:25 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 14:31:36 +0800
Message-ID: <40832b5f-4e34-21cc-bca2-110477fc7317@huawei.com>
Date:   Wed, 30 Aug 2023 14:31:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: hisi: Add bindings for Hisi
 Ascend sdma
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <xuqiang36@huawei.com>, <chenweilong@huawei.com>
References: <20230824040007.1476-1-guomengqi3@huawei.com>
 <20230824040007.1476-3-guomengqi3@huawei.com>
 <b3a6c920-9de5-2788-61ff-beaa60a7a942@linaro.org>
From:   "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <b3a6c920-9de5-2788-61ff-beaa60a7a942@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.156]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


在 2023/8/24 15:15, Krzysztof Kozlowski 写道:
> On 24/08/2023 06:00, Guo Mengqi wrote:
>> Add device-tree binding documentation for the Hisi Ascend sdma
>> controller.
>>
>> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
>> ---
>>   .../bindings/dma/hisi,ascend-sdma.yaml        | 75 +++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/hisi,ascend-sdma.yaml
> Filename matching compatible, so hisilicon,ascend-sdma.yaml. hisi, is a
> deprecated prefix, so don't use it.
OK, will change it in next patch.
>
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
> What is HISI? HiSilicon?
Yes, It is short for HiSilicon.
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
> Why some channels would not be allowed to be used on some board with
> ascend310? Who decides on this?
This is because the SoC runs more than one operating system. So from the 
perspective of any user OS, dma hardware is a shared resource.
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  pasid-num-bits:
>> +    description: |
>> +      sdma utilizes iommu sva feature to transfer user space data.
>> +      It acts as a basic dma controller if not bound to user space.
>> +    const: 0x10
>
> Best regards,
> Krzysztof
>
> .

Best regards,

Guo Mengqi

