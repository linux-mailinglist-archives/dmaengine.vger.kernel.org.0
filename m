Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970D0395544
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 08:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhEaGNP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 02:13:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2479 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhEaGNO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 May 2021 02:13:14 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FtlGY4D2jz67NS;
        Mon, 31 May 2021 14:08:37 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 14:11:23 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 14:11:22 +0800
Subject: Re: [PATCH 2/3] dmaengine: usb-dmac: Fix PM reference leak in
 usb_dmac_probe()
To:     Vinod Koul <vkoul@kernel.org>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <michal.simek@xilinx.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <yi.zhang@huawei.com>
References: <20210517081826.1564698-1-yukuai3@huawei.com>
 <20210517081826.1564698-3-yukuai3@huawei.com>
 <YLRfZfnuxc0+n/LN@vkoul-mobl.Dlink>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <b6c340de-b0b5-6aad-94c0-03f062575b63@huawei.com>
Date:   Mon, 31 May 2021 14:11:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YLRfZfnuxc0+n/LN@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021/05/31 12:00, Vinod Koul wrote:
> On 17-05-21, 16:18, Yu Kuai wrote:
>> pm_runtime_get_sync will increment pm usage counter even it failed.
>> Forgetting to putting operation will result in reference leak here.
>> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
>> counter balanced.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/dma/sh/usb-dmac.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
>> index 8f7ceb698226..2a6c8fd8854e 100644
>> --- a/drivers/dma/sh/usb-dmac.c
>> +++ b/drivers/dma/sh/usb-dmac.c
>> @@ -796,7 +796,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
>>   
>>   	/* Enable runtime PM and initialize the device. */
>>   	pm_runtime_enable(&pdev->dev);
>> -	ret = pm_runtime_get_sync(&pdev->dev);
>> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> 
> This does not seem to fix anything.. the below goto goes and disables
> the runtime_pm for this device and thus there wont be any leak
Hi,

If pm_runtime_get_sync() fails and increments the pm.usage_count
variable, pm_runtime_disable() does not reset the counter, and
we still need to decrement the usage count when pm_runtime_get_sync()
fails. Do I miss anthing?

Thansk!
Yu Kuai
> 
>>   	if (ret < 0) {
>>   		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
>>   		goto error_pm;
>> -- 
>> 2.25.4
> 
