Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6045AA88F
	for <lists+dmaengine@lfdr.de>; Fri,  2 Sep 2022 09:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiIBHOF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Sep 2022 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBHOE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Sep 2022 03:14:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F176DB8F04;
        Fri,  2 Sep 2022 00:14:01 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJpvt0T4qzkWpd;
        Fri,  2 Sep 2022 15:10:18 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 15:14:00 +0800
Received: from [10.67.102.167] (10.67.102.167) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 15:13:59 +0800
Message-ID: <9c4ca0b8-863d-1f27-9ba0-819d597aa4ce@huawei.com>
Date:   Fri, 2 Sep 2022 15:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more
 incorrectly.
To:     Koba Ko <koba.ko@canonical.com>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220830093207.951704-1-koba.ko@canonical.com>
From:   Jie Hai <haijie1@huawei.com>
In-Reply-To: <20220830093207.951704-1-koba.ko@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.167]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Koba Ko

Thanks for your patch.

I've had the same problem,see
https://lore.kernel.org/all/20220716024453.1418259-1-haijie1@huawei.com/.

The two operations of updating client_count, that is,
     chan->client_count++;
     balance_ref_count(chan);

the order of which is modified by d2f4f99db3e9 ("dmaengine: Rework 
dma_chan_get").

I have complied and tested it on my arm64 and this patch does
fix the problem.

For this patch,
Reviewed-by: Jie Hai <haijie1@huawei.com>
Test-by: Jie Hai <haijie1@huawei.com>

Best regards,
Jie Hai

On 2022/8/30 17:32, Koba Ko wrote:
> If the passed client_count is 0,
> it would be incremented by balance_ref_count first
> then increment one more.
> This would cause client_count to 2.
> 
> cat /sys/class/dma/dma0chan*/in_use
> 2
> 2
> 2
> 
> Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>   drivers/dma/dmaengine.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2cfa8458b51be..78f8a9f3ad825 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
>   	/* The channel is already in use, update client count */
>   	if (chan->client_count) {
>   		__module_get(owner);
> -		goto out;
> +		chan->client_count++;
> +		return 0;
>   	}
>   
>   	if (!try_module_get(owner))
> @@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
>   			goto err_out;
>   	}
>   
> +	chan->client_count++;
> +
>   	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
>   		balance_ref_count(chan);
>   
> -out:
> -	chan->client_count++;
>   	return 0;
>   
>   err_out:
