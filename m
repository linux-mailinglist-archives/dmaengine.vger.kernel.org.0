Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0919E581CDF
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jul 2022 02:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiG0A6O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 20:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiG0A6N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 20:58:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE472E9F3;
        Tue, 26 Jul 2022 17:58:12 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LswMT4CCwzmV6S;
        Wed, 27 Jul 2022 08:56:21 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 08:58:10 +0800
Received: from [10.67.102.167] (10.67.102.167) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 08:58:10 +0800
Message-ID: <af659e3f-75d4-aba9-3de0-c190aecbcbeb@huawei.com>
Date:   Wed, 27 Jul 2022 08:58:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 6/7] dmaengine: hisilicon: Add dfx feature for hisi dma
 driver
To:     Vinod Koul <vkoul@kernel.org>
CC:     <wangzhou1@hisilicon.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
 <20220629035549.44181-7-haijie1@huawei.com> <YtlTuAHTcZnTFo6B@matsya>
 <2a2a9624-d8ce-4bae-e666-3035ebb1b9e6@huawei.com> <Yt/gg+MpHQD+k5qY@matsya>
From:   Jie Hai <haijie1@huawei.com>
In-Reply-To: <Yt/gg+MpHQD+k5qY@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.167]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/7/26 20:39, Vinod Koul wrote:
> On 26-07-22, 09:43, Jie Hai wrote:
>> On 2022/7/21 21:25, Vinod Koul wrote:
>>> On 29-06-22, 11:55, Jie Hai wrote:
>>>
>>> What does dfx mean in title?
>>>
>> Thanks for the question.
>>
>> DFX＝"Design for X", I quote its definition as follows:
>> The product definition puts forward a list of specific aspects about a
>> design that designers need to optimize, for example, product usage,
>> functions and features, cost range, and aesthetics. Modern designers even
>> need to consider more design objectives because the new design
>> characteristics may finally determine the success or failure of a product.
>> Design methodologies that consider these new characteristics are called
>> design for X (DFX). Specific design methodologies include design for
>> reliability (DFR), design for serviceability (DFS), design for supply chain
>> (DFSC), design for scalability (DFSc), design for energy efficiency and
>> environment (DFEE), design for testability (DFT),and so on.
> 
> This would be better to explain in changelog, not many people would be
> familiar with these terms...
> 
Thanks. As I wrote below, I've replaced it in v3 with something easier 
to understand, which is "dump regs to debugfs".

>>
>> For clarity, I've replaced it in v3 with something easier to understand.
>>>> This patch adds dump of registers with debugfs for HIP08
>>>> and HIP09 DMA driver.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> ?
>>>
>> The kernel test robot raised an issue and asked me to modify it and add
>> "Reported-by: kernel test robot <lkp@intel.com>" to the commit message, so I
>> did, and it was removed in v3.
> 
> ok
> 
