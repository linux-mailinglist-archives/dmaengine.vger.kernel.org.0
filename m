Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0818C606D06
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJUBba (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 21:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJUBb3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 21:31:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED714EC6F
        for <dmaengine@vger.kernel.org>; Thu, 20 Oct 2022 18:31:27 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtn453CqyzHv2P;
        Fri, 21 Oct 2022 09:31:17 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:31:25 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:31:25 +0800
Subject: Re: [PATCH] dmaengine: fix possible memory leak in while registering
 device channel
To:     Jerry Snitselaar <jsnitsel@redhat.com>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <yangyingliang@huawei.com>
References: <20221020063830.3013799-1-yangyingliang@huawei.com>
 <20221020212104.toaz5drpyf6jji3c@cantor>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7d67e6ba-abb1-612c-96e5-229a8cd1de9f@huawei.com>
Date:   Fri, 21 Oct 2022 09:31:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221020212104.toaz5drpyf6jji3c@cantor>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 2022/10/21 5:21, Jerry Snitselaar wrote:
> On Thu, Oct 20, 2022 at 02:38:30PM +0800, Yang Yingliang wrote:
>> Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
>> bus_id string array"), the name of device is allocated dynamically,
>> if device_register() fails, it should call put_device() to give up
>> reference, the name can be freed in callback function kobject_cleanup().
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/dma/dmaengine.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index c741b6431958..46adfec04f0c 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -1068,8 +1068,11 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>>   	dev_set_name(&chan->dev->device, "dma%dchan%d",
>>   		     device->dev_id, chan->chan_id);
>>   	rc = device_register(&chan->dev->device);
>> -	if (rc)
>> +	if (rc) {
>> +		put_device(&chan->dev->device);
>> +		chan->dev = NULL;
> Doesn't this leak the memory that was just grabbed with the kzalloc() call at
> the beginning of __dma_async_device_channel_register() since now kfree() is
> going to passed NULL?
After calling put_device(), chan_dev_release() will be called when 
refcount hit to 0,
'chan->dev' is freed in it, so set chan->dev to NULL to avoid double free.

Thanks,
Yang
>
> Regards,
> Jerry
>
>
>>   		goto err_out_ida;
>> +	}
>>   	chan->client_count = 0;
>>   	device->chancnt++;
>>   
>> -- 
>> 2.25.1
>>
> .
