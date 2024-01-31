Return-Path: <dmaengine+bounces-913-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1F8432C9
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 02:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B666C28A97A
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 01:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2571FBB;
	Wed, 31 Jan 2024 01:32:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3C1FA1;
	Wed, 31 Jan 2024 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664727; cv=none; b=V5Izjv8k7e85gAtxImmK9l5mZUHrOqb0Q7Y903bbP1Gqe4ouOIGgsoT/+yj9bLKNSCHmH0Enubj/YtzAmIwKoY17XHz2978qfn8fck8O0MOP+SuHKA90pAt8zR9fGckSoe8hrZvttN0fUAA56QQ4JlSn04fMRtVgN4xVc+vsEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664727; c=relaxed/simple;
	bh=1BFxpRU0wow9E5T1en/T+t5yKpoSkaHDND4+7UI0rjM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qzfLWhWzWb2/niY1OJD/RufxD7XzTt16Nhwh5h8L3L8h6YwDPjwfnW9NZfC4vm0NE2wI1HlfyJx/cGWv5PzPCO53htdJiQFl3pW4jXqp/yRqzgObNhwcPbavEcY7uHkDykrsqSHGTvHbpCifhyiXYHTK41walNfBE0tuhcMHSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TPkyH1qfdz1xmt0;
	Wed, 31 Jan 2024 09:31:03 +0800 (CST)
Received: from kwepemd100004.china.huawei.com (unknown [7.221.188.31])
	by mail.maildlp.com (Postfix) with ESMTPS id C462F1A016B;
	Wed, 31 Jan 2024 09:32:02 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemd100004.china.huawei.com (7.221.188.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 31 Jan 2024 09:32:02 +0800
Message-ID: <7494329f-4a42-1fd5-0db8-a81831393268@huawei.com>
Date: Wed, 31 Jan 2024 09:32:01 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: dmatest: fix timeout caused by kthread_stop
From: Jie Hai <haijie1@huawei.com>
To: <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230720114102.51053-1-haijie1@huawei.com>
In-Reply-To: <20230720114102.51053-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100004.china.huawei.com (7.221.188.31)

Hi, Vkoul,

Kindly ping...

Thanks,
Jie Hai
On 2023/7/20 19:41, Jie Hai wrote:
> The change introduced by commit a7c01fa93aeb ("signal: break
> out of wait loops on kthread_stop()") causes dmatest aborts
> any ongoing tests and possible failure on the tests. This patch
> use wait_event_timeout instead of wait_event_freezable_timeout
> to avoid interrupting ongoing tests by signal brought by
> kthread_stop().
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>   drivers/dma/dmatest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index ffe621695e47..c06b8b16645a 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -827,7 +827,7 @@ static int dmatest_func(void *data)
>   		} else {
>   			dma_async_issue_pending(chan);
>   
> -			wait_event_freezable_timeout(thread->done_wait,
> +			ret = wait_event_timeout(thread->done_wait,
>   					done->done,
>   					msecs_to_jiffies(params->timeout));
>   

