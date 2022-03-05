Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F964CE3A0
	for <lists+dmaengine@lfdr.de>; Sat,  5 Mar 2022 09:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiCEIjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Mar 2022 03:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiCEIjK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Mar 2022 03:39:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC8433BF;
        Sat,  5 Mar 2022 00:38:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q11so9734840pln.11;
        Sat, 05 Mar 2022 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4q9rupxAtgeh0z74bvSngfTH3q+iMizoxg7UH0B4T/o=;
        b=btIKdS/FS+BX5jnCkXzHGhLWyAwM7A4CN9T3gOQW3bKxtSfv1NLvqa2oPzSDgPUIvI
         UVLo3SWgHLbmQVWY1SH4Jl1WF3D02PyCrf05AvaTR79v8kYsgerAmHM145FhUkiEHE/0
         pXVk7/6CjNYa1i7CjX4T5NeE0oOrgn30aP3p6pu9wcLB/MS60SzeeFqlwdD0Y/CDPivG
         /3mgWdGeorKgmq/+zOmM9W4UBhaPGYDjwI6j3a0jpbZQrTFD1m+uWR/XBeATEQdyQre5
         Fu6jYuTcCQZGPO3pAp5FZ+jDScDuyJLT2w1W6J/iG+rq1kTsDV7kHKNk+U6KEQ1Z5jfA
         okgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4q9rupxAtgeh0z74bvSngfTH3q+iMizoxg7UH0B4T/o=;
        b=J+kzv5ZHfe8sZnjNo2vYIwCrOiQow5sVO59tvngszN53P1V807JSOM5T34GzqZaYs/
         fzT9rHJpL8VRgkQgeVWA1u8G+vWkBu4lrsPobXmr4DhTAP29bbl8YRs2FayDXb64/Jo4
         XfWUi+JgP2J8UdqYd2eObh/U0eFRWXSBKSqiOaU/TV9HGtZhu7fKf5rXZiHfdP1+JLrH
         lfIZ0+A36PM2BPHG4zEbe9ypG4+XR89iD8JdXedzZhd0/uXPACHPNUMinwoRIhvh5c93
         1gK6gsX2EpazwyBoWYiyDm4dVhwkNO/9LKC9hUhYJ3NgFcsEfdXhCNRZ7ra8b9U+ILDw
         eIvw==
X-Gm-Message-State: AOAM530fR6x8aaLTx+/jpBGI1CWC4DHc1VO2KAJHh/nN0sWeTQ7PdBXO
        5yEc0+j4djtp7FR4xJo4vvw=
X-Google-Smtp-Source: ABdhPJwrqasm/Aj96Sb/8B66of8QRPaNNoC3JjmddWhpSQd0G6BpPFgWNdhVFq3NO2IF1nkMqSouag==
X-Received: by 2002:a17:902:ccc6:b0:14f:88e6:8040 with SMTP id z6-20020a170902ccc600b0014f88e68040mr2332802ple.13.1646469498919;
        Sat, 05 Mar 2022 00:38:18 -0800 (PST)
Received: from [10.107.0.6] ([64.64.123.82])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm12586726pju.44.2022.03.05.00.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 00:38:18 -0800 (PST)
Subject: Re: [PATCH] dma: xilinx: check the return value of dma_set_mask() in
 zynqmp_dma_probe()
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     vkoul@kernel.org, michal.simek@xilinx.com, yukuai3@huawei.com,
        lars@metafoo.de, libaokun1@huawei.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20220303024334.813-1-baijiaju1990@gmail.com>
 <20220304082024.GO8137@pengutronix.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <47bca068-9bc2-73c7-dfa4-ddd5ce78618c@gmail.com>
Date:   Sat, 5 Mar 2022 16:38:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220304082024.GO8137@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2022/3/4 16:20, Michael Tretter wrote:
> On Wed, 02 Mar 2022 18:43:34 -0800, Jia-Ju Bai wrote:
>> The function dma_set_mask() in zynqmp_dma_probe() can fail, so its
>> return value should be checked.
>>
>> Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
>> index 7aa63b652027..963fb1de93af 100644
>> --- a/drivers/dma/xilinx/zynqmp_dma.c
>> +++ b/drivers/dma/xilinx/zynqmp_dma.c
>> @@ -1050,7 +1050,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>   	zdev->dev = &pdev->dev;
>>   	INIT_LIST_HEAD(&zdev->common.channels);
>>   
>> -	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
>> +	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(44)))
>> +		return -EIO;
> Thanks.
>
> You may print an error message with dev_err_probe and forward the return value
> of dma_set_mask.

Hi Michael,

Thanks for the advice.
I will send a V2 patch.


Best wishes,
Jia-Ju Bai
