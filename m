Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A01536C37
	for <lists+dmaengine@lfdr.de>; Sat, 28 May 2022 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiE1KG3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 May 2022 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiE1KG2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 May 2022 06:06:28 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA20C38A9
        for <dmaengine@vger.kernel.org>; Sat, 28 May 2022 03:06:25 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id utKwngSjFZDzUutKwnSoQU; Sat, 28 May 2022 12:06:23 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 28 May 2022 12:06:23 +0200
X-ME-IP: 90.11.191.102
Message-ID: <ef7cd76e-b4bf-359d-08eb-848764de75f7@wanadoo.fr>
Date:   Sat, 28 May 2022 12:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: ti: Fix a potential under memory allocation
 issue in edma_setup_from_hw()
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        dan.carpenter@oracle.com, Vinod Koul <vkoul@kernel.org>,
        Joel Fernandes <joelf@ti.com>, Sekhar Nori <nsekhar@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org
References: <8c95c485be294e64457606089a2a56e68e2ebd1a.1653153959.git.christophe.jaillet@wanadoo.fr>
 <6e750770-fcda-d157-21d1-872a611c3bf2@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6e750770-fcda-d157-21d1-872a611c3bf2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 28/05/2022 à 11:33, Péter Ujfalusi a écrit :
> 
> 
> On 21/05/2022 20:26, Christophe JAILLET wrote:
>> If the 'queue_priority_mapping' is not provided, we need to allocate the
>> correct amount of memory. Each entry takes 2 s8, so actually less memory
>> than needed is allocated.
>>
>> Update the size of each entry when the memory is devm_kcalloc'ed.
>>
>> Fixes: 6d10c3950bf4 ("ARM: edma: Get IP configuration from HW (number of channels, tc, etc)")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Note that the devm_kcalloc() in edma_xbar_event_map() looks also spurious.
>> However, this looks fine to me because of the 'nelm >>= 1;' before the
>> 'for' loop.
> 
> This has been deprecated ever since we have moved to dma router to
> handle the xbar for various TI platforms, but by the looks it kida looks
> bogus in a same way.

This one is correct, IIUC.

There is an extra ">> 1" before the loop. (see [1]).

CJ

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/dma/ti/edma.c#n2173

> 
>> ---
>>   drivers/dma/ti/edma.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
>> index 3ea8ef7f57df..f313e2cf542c 100644
>> --- a/drivers/dma/ti/edma.c
>> +++ b/drivers/dma/ti/edma.c
>> @@ -2121,7 +2121,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
>>   	 * priority. So Q0 is the highest priority queue and the last queue has
>>   	 * the lowest priority.
>>   	 */
>> -	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
>> +	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8) * 2,
>>   					  GFP_KERNEL);
>>   	if (!queue_priority_map)
>>   		return -ENOMEM;
> 

