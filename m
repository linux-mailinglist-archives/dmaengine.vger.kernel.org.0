Return-Path: <dmaengine+bounces-1916-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9223B8ADC4F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 05:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1001C218E1
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 03:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4218E1F;
	Tue, 23 Apr 2024 03:39:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20115E89;
	Tue, 23 Apr 2024 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843550; cv=none; b=mb1snbxhwxNbt6l/56pSGc720iWiRBS4Ouh9DCYpGNOhKSBnUGmjQlbHqq4pNHyZvHTTLoheiV6UlnBpaPDXe7PR/fqJKW+cr+ce2GIDlMudjE9nJJYDEujwdXijk0Ar7LMRBCzGPreoARqTIWebgbwm3h52NvsiC9DDyAvB4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843550; c=relaxed/simple;
	bh=pNiBG+e9qgp5dz04/zKlKcKVo2+IvJWVJQw3C1VcUgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X8YLitB30h+YHptIduFWmxX4Cy3ZBpHhH85GUGEUGkg9jgVbCbyVySYM6hjZkkB07o84KdhN0Bet8vxnKJ9rg7LcVK+FhCawL4umcGnXKMaIlETrdOxqA/KznRdZzfUckFA+8LngqHyjYVruVZJtopPCg94yIgrlmvwxGpv07s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VNnrW2q2tz1HBjK;
	Tue, 23 Apr 2024 11:38:03 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 58B4D1A016C;
	Tue, 23 Apr 2024 11:39:03 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 23 Apr 2024 11:39:02 +0800
Message-ID: <d0ea4a88-900a-ad38-0580-017ae20c2fd4@huawei.com>
Date: Tue, 23 Apr 2024 11:39:02 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: dmatest: fix timeout caused by kthread_stop
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230720114102.51053-1-haijie1@huawei.com>
 <ZiAEbOMxy9pBcOX5@matsya>
From: Jie Hai <haijie1@huawei.com>
In-Reply-To: <ZiAEbOMxy9pBcOX5@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Hi, Vinod Koul,

Stop an ongoing test by
"echo 0 > /sys/module/dmatest/parameters/run".
If the current code is executed inside the while loop
"while (!(kthread_should_stop() ||
  (params->iterations &&
  total_tests >= params->iterations)))"
and before the call of "wait_event_freezable_timeout",
the "wait_event_freezable_timeout" will be interrupted
and result in  "time out" for the test even if the test
is not completed.



Operations to the problem is as follows,
and the failures are probabilistic:

modprobe hisi_dma
modprobe dmatest

echo 0 > /sys/module/dmatest/parameters/iterations
echo "dma0chan0" > /sys/module/dmatest/parameters/channel
echo "dma0chan1" > /sys/module/dmatest/parameters/channel
echo "dma0chan2" > /sys/module/dmatest/parameters/channel
echo 1 > /sys/module/dmatest/parameters/run
echo 0 > /sys/module/dmatest/parameters/run

dmesg:

[52575.636992] dmatest: Added 1 threads using dma0chan0
[52575.637555] dmatest: Added 1 threads using dma0chan1
[52575.638044] dmatest: Added 1 threads using dma0chan2
[52581.020355] dmatest: Started 1 threads using dma0chan0
[52581.020585] dmatest: Started 1 threads using dma0chan1
[52581.020814] dmatest: Started 1 threads using dma0chan2
[52587.705782] dmatest: dma0chan0-copy0: result #57691: 'test timed out' 
with src_off=0xfe6 dst_off=0x89 len=0x1d9a (0)
[52587.706527] dmatest: dma0chan0-copy0: summary 57691 tests, 1 failures 
51179.98 iops 411323 KB/s (0)
[52587.707028] dmatest: dma0chan1-copy0: result #63178: 'test timed out' 
with src_off=0xdf dst_off=0x6ab len=0x389e (0)
[52587.707767] dmatest: dma0chan1-copy0: summary 63178 tests, 1 failures 
62851.60 iops 503835 KB/s (0)
[52587.708376] dmatest: dma0chan2-copy0: result #60527: 'test timed out' 
with src_off=0x10e dst_off=0x58 len=0x3ea4 (0)
[52587.708951] dmatest: dma0chan2-copy0: summary 60527 tests, 1 failures 
52403.78 iops 420014 KB/s (0)


On 2024/4/18 1:18, Vinod Koul wrote:
> On 20-07-23, 19:41, Jie Hai wrote:
>> The change introduced by commit a7c01fa93aeb ("signal: break
>> out of wait loops on kthread_stop()") causes dmatest aborts
>> any ongoing tests and possible failure on the tests. This patch
> 
> Have you see this failure? Any log of that..
> 
>> use wait_event_timeout instead of wait_event_freezable_timeout
>> to avoid interrupting ongoing tests by signal brought by
>> kthread_stop().
>>
>> Signed-off-by: Jie Hai <haijie1@huawei.com>
>> ---
>>   drivers/dma/dmatest.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index ffe621695e47..c06b8b16645a 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -827,7 +827,7 @@ static int dmatest_func(void *data)
>>   		} else {
>>   			dma_async_issue_pending(chan);
>>   
>> -			wait_event_freezable_timeout(thread->done_wait,
>> +			ret = wait_event_timeout(thread->done_wait,
>>   					done->done,
>>   					msecs_to_jiffies(params->timeout));
>>   
>> -- 
>> 2.33.0
> 

