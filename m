Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DF7A16E5
	for <lists+dmaengine@lfdr.de>; Fri, 15 Sep 2023 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjIOHHb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Sep 2023 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjIOHHa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Sep 2023 03:07:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A41998;
        Fri, 15 Sep 2023 00:07:14 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rn4tZ1pJSzVkXV;
        Fri, 15 Sep 2023 15:04:22 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 15:07:11 +0800
Message-ID: <c2f6e5b7-8eda-fb00-08ac-e1f54938f6a4@huawei.com>
Date:   Fri, 15 Sep 2023 15:07:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 2/2] dt-bindings: dma: HiSilicon: Add bindings for
 HiSilicon Ascend sdma
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <xuqiang36@huawei.com>, <chenweilong@huawei.com>
References: <20230913082825.3180-1-guomengqi3@huawei.com>
 <20230913082825.3180-3-guomengqi3@huawei.com>
 <8eff1f20-1cfc-7097-da26-97daaae5e8ca@linaro.org>
From:   "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <8eff1f20-1cfc-7097-da26-97daaae5e8ca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.156]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


在 2023/9/13 17:20, Krzysztof Kozlowski 写道:
> On 13/09/2023 10:28, Guo Mengqi wrote:
>> Add device-tree binding documentation for sdma hardware on
>> HiSilicon Ascend SoC families.
>>
>> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
>> ---
>>
>> +  dma-channel-mask:
>> +    minItems: 1
>> +    maxItems: 2
> Why 2? Care to bring any example? Where is your DTS?

Seems that the complete dts is not in the repository.

Some platform supports up to 40 channels at most, in design. So I think 
2 should be enough.

>> +  iommus:
>> +    maxItems: 1
>> +
>> +  pasid-num-bits:
>> +    description: |
>> +      This tells smmu that this device supports iommu-sva feature.
>> +      This determines the maximum number of digits in the pasid.
>> +    maximum: 0x10
>> +
>> +  dma-coherent: true
>> +
>> +  dma-can-stall: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - dma-channel-mask
>> +  - '#dma-cells'
>> +  - iommus
>> +  - pasid-num-bits
>> +  - dma-can-stall
> I am not sure if requiring dma-can-stall is correct here. To my
> understanding this is in general optional property.

If  "dma-can-stall" is declared,  drivers can rely on smmu to handle 
page-fault.

Yes, this is not a required one. It does not affect main usage. Drop it 
in next patch.

> Best regards,
> Krzysztof
>
>
> .

Best regards,

Guo Mengqi

