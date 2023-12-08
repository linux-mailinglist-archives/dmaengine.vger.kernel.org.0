Return-Path: <dmaengine+bounces-409-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28158098DA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F56D1C20AFF
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6801849;
	Fri,  8 Dec 2023 01:54:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58761991;
	Thu,  7 Dec 2023 17:53:29 -0800 (PST)
Received: from kwepemd100004.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmYzx5nKwzWhvX;
	Fri,  8 Dec 2023 09:52:29 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemd100004.china.huawei.com (7.221.188.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 8 Dec 2023 09:53:26 +0800
Message-ID: <5a00cc4f-1524-8a19-88c8-fe04e0211713@huawei.com>
Date: Fri, 8 Dec 2023 09:53:25 +0800
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100004.china.huawei.com (7.221.188.31)
X-CFilter-Loop: Reflected

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

