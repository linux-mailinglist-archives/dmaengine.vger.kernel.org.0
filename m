Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3A527D3B
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 07:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiEPF4v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 01:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiEPF4v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 01:56:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4AB86D;
        Sun, 15 May 2022 22:56:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h186so10495116pgc.3;
        Sun, 15 May 2022 22:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Pwpzkyg77kk5VIp6vnvsVEKNPdGamfy1+A/pVOWozEo=;
        b=Jk2vNxB4sP9tleDrsu/ul6d1rZruz8DjlZfh8DZoItv8Exyw5PgKRV2jx3UM4EYpmS
         AKL2xNAejWYXaFz5G/hqczXQBwx0G+BG0R63CQv6x+Cgaph2Z6kSTmYGu2ed+MTf+t7L
         dSzgJ99PNaz7xQJvD+m5gisD3oWJHd3W6kO7+veftGp2yUEyJ5GBSUA0Gxu2kx15r+8+
         s1jeN3PNm9jjjYkiaFFnH9jHsxvGxGy8zLWYapv5nIeetsR/LqKBZ0eTdSjYdbn3DKa+
         b+zTyTM1+/XMjMnLB1SbUkbRa6CM3mgtHbLBQ9NI9MA9UEo7FlkFxQYmukZwwpeso8HP
         TBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pwpzkyg77kk5VIp6vnvsVEKNPdGamfy1+A/pVOWozEo=;
        b=uTOFYk25LLsOmqf+pNE7mg88aT/PL8/+DR06dFkwkCqpsAX5FOAfZcaDYoDVuusFd1
         jAR7EArgJN1dO8+kZ9yXY3tdFrrSD/X8JOSNfF0XodCi6Me+1o/TblKNQwQGjt+NnXWb
         Yb4M8vw6DPJy2xbMXdwxr6gX4zwHr+m10/UQyrXE51I/r56cQ408LsdSC4J0AR3jaga7
         UCFxiFV41l6rJnnqiS4OXxWSooCScpwn8uV2mmR5ayx6CwTCqfLIfS41sN9I9THT0v02
         FlDxsw29Ig3Rqlk+/ktE8W5NUPe+bIo2uXOTMeQcCaEmRJ/NWWIbg4pRgGwQsM5gSiNJ
         V94g==
X-Gm-Message-State: AOAM53363XRF04Yj5mbBQ0oz5foa+/ekHFaE3EUHCJAU/sLYUmPFKBKC
        PEKWDByf/9d4BxvMRkKyuSU=
X-Google-Smtp-Source: ABdhPJw5eg5a50VutqqwvkEAmuKtFjouViHMxzDmbCqdE2G1lbPuIm7B3ySqs2ZRUQZCWittsNON+Q==
X-Received: by 2002:aa7:8757:0:b0:50d:48a9:f021 with SMTP id g23-20020aa78757000000b0050d48a9f021mr15866354pfo.24.1652680607401;
        Sun, 15 May 2022 22:56:47 -0700 (PDT)
Received: from [172.16.10.243] ([106.39.150.71])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902f60b00b0015ec71f72d6sm6047182plg.253.2022.05.15.22.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 22:56:47 -0700 (PDT)
Message-ID: <b659bba8-0de9-4159-4311-bb13036bef05@gmail.com>
Date:   Mon, 16 May 2022 13:56:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dmaengine: ti: Fix refcount leak in
 ti_dra7_xbar_route_allocate
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512051815.11946-1-linmq006@gmail.com>
 <d1017a7a-4f3d-4218-13da-71f89cf81c81@intel.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <d1017a7a-4f3d-4218-13da-71f89cf81c81@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Dave

On 2022/5/13 1:03, Dave Jiang wrote:
>
> On 5/11/2022 10:18 PM, Miaoqian Lin wrote:
>> 1. of_find_device_by_node() takes reference, we should use put_device()
>> to release it when not need anymore.
>> 2. of_parse_phandle() returns a node pointer with refcount
>> incremented, we should use of_node_put() on it when not needed anymore.
>>
>> Add put_device() and of_node_put() in some error paths to fix.
> Sounds like you need 2 patches for this? One just for the put_device() and the other for the of_node_put()?

Thanks for your response, I will split it into 2 patches.


>>
>> Fixes: ec9bfa1e1a79 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
>> Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>   drivers/dma/ti/dma-crossbar.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
>> index 71d24fc07c00..f744ddbbbad7 100644
>> --- a/drivers/dma/ti/dma-crossbar.c
>> +++ b/drivers/dma/ti/dma-crossbar.c
>> @@ -245,6 +245,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>>       if (dma_spec->args[0] >= xbar->xbar_requests) {
>>           dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
>>               dma_spec->args[0]);
>> +        put_device(&pdev->dev);
>>           return ERR_PTR(-EINVAL);
>>       }
>>   @@ -252,12 +253,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>>       dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
>>       if (!dma_spec->np) {
>>           dev_err(&pdev->dev, "Can't get DMA master\n");
>> +        put_device(&pdev->dev);
>>           return ERR_PTR(-EINVAL);
>>       }
>>         map = kzalloc(sizeof(*map), GFP_KERNEL);
>>       if (!map) {
>>           of_node_put(dma_spec->np);
>> +        put_device(&pdev->dev);
>>           return ERR_PTR(-ENOMEM);
>>       }
>>   @@ -268,6 +271,8 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
>>           mutex_unlock(&xbar->mutex);
>>           dev_err(&pdev->dev, "Run out of free DMA requests\n");
>>           kfree(map);
>> +        of_node_put(dma_spec->np);
>> +        put_device(&pdev->dev);
>>           return ERR_PTR(-ENOMEM);
>>       }
>>       set_bit(map->xbar_out, xbar->dma_inuse);
