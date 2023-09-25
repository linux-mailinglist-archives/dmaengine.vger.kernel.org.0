Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D37ACD72
	for <lists+dmaengine@lfdr.de>; Mon, 25 Sep 2023 03:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjIYBKu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Sep 2023 21:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIYBKt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Sep 2023 21:10:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37821CA;
        Sun, 24 Sep 2023 18:10:43 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rv4WJ0LHDzrSxn;
        Mon, 25 Sep 2023 09:08:28 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 09:10:40 +0800
Message-ID: <4788bc76-de7f-33fe-0089-c17112fd12c9@huawei.com>
Date:   Mon, 25 Sep 2023 09:10:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: dmatest: fix timeout caused by kthread_stop
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230720114102.51053-1-haijie1@huawei.com>
In-Reply-To: <20230720114102.51053-1-haijie1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.175]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
