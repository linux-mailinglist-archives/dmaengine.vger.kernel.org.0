Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB77D93E2
	for <lists+dmaengine@lfdr.de>; Fri, 27 Oct 2023 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjJ0JiE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Oct 2023 05:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbjJ0Jhz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Oct 2023 05:37:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893110CC;
        Fri, 27 Oct 2023 02:37:49 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SGyCj2fgYzVlMy;
        Fri, 27 Oct 2023 17:33:53 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 17:37:46 +0800
Message-ID: <8032bf97-4d22-1d67-09e2-7183d3a75ae3@huawei.com>
Date:   Fri, 27 Oct 2023 17:37:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 2/2] dt-bindings: dma: HiSilicon: Add bindings for
 HiSilicon Ascend sdma
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>
References: <20231026072549.103102-1-guomengqi3@huawei.com>
 <20231026072549.103102-3-guomengqi3@huawei.com>
 <20231026165502.GA3979802-robh@kernel.org>
From:   "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <20231026165502.GA3979802-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.156]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


在 2023/10/27 0:55, Rob Herring 写道:
> On Thu, Oct 26, 2023 at 03:25:49PM +0800, Guo Mengqi wrote:
>> Add device-tree binding documentation for sdma hardware on
>> HiSilicon Ascend SoC families.
>>
>> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
>> ---
> This is where you explain any expected failure. Resending the same patch
> with the same failure again is not a great strategy. The patch needs to
> stand on its own and not rely on some explanation in a prior version.

OK, will do this next time. I was eager to see whether those kernel 
build warnings are fixed, so sent the new patch quickly.

>>   .../bindings/dma/hisilicon,ascend-sdma.yaml   | 73 +++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/hisilicon,ascend-sdma.yaml
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> I had missed that pasid-num-bits and dma-can-stall are IOMMU consumer
> properties. (We really should have prefixed them with 'iommu'.) I've now
> added them to dtschema which should fix the warning.

They do look a little confusing.

Thanks.

-Mengqi

> Rob
>
> .
