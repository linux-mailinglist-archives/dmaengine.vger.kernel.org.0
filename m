Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880544DE666
	for <lists+dmaengine@lfdr.de>; Sat, 19 Mar 2022 07:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiCSG00 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Mar 2022 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbiCSG0Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Mar 2022 02:26:25 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943A35ABC
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 23:25:03 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id VSWInb6MLvjW4VSWJnTyuB; Sat, 19 Mar 2022 07:25:01 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 19 Mar 2022 07:25:01 +0100
X-ME-IP: 90.126.236.122
Message-ID: <08b7604d-f528-ecb7-a8b2-7c9c36518143@wanadoo.fr>
Date:   Sat, 19 Mar 2022 07:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dmaengine: qcom_hidma: Remove useless DMA-32 fallback
 configuration
Content-Language: en-US
To:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <4deb32b0c7838da66608022c584326eb01d0da03.1642232106.git.christophe.jaillet@wanadoo.fr>
 <ee43d68f-000c-6513-38f2-877b9018ab22@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ee43d68f-000c-6513-38f2-877b9018ab22@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 22/01/2022 à 19:05, Sinan Kaya a écrit :
> On 1/15/2022 2:35 AM, Christophe JAILLET wrote:
>> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
>> dev->dma_mask is non-NULL.
>> So, if it fails, the 32 bits case will also fail for the same reason.
>>
>> Simplify code and remove some dead code accordingly.
>>
>> [1]: 
>> https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
>>
> 
> Can we please document this?

Hi, the patch has been applied, but [1] is sometimes given as an 
explanation link.

CJ


[1]: 
https://lists.linuxfoundation.org/pipermail/iommu/2019-February/033674.html

> 
> Usual practice was to try allocating 64 bit DMA if possible and fallback
> to 32 bits.
> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> v2: have the subject and updated driver match
>> ---
>>   drivers/dma/qcom/hidma.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
>> index 65d054bb11aa..51587cf8196b 100644
>> --- a/drivers/dma/qcom/hidma.c
>> +++ b/drivers/dma/qcom/hidma.c
>> @@ -838,9 +838,7 @@ static int hidma_probe(struct platform_device *pdev)
>>       rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>       if (rc) {
>>           dev_warn(&pdev->dev, "unable to set coherent mask to 64");
>> -        rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> -        if (rc)
>> -            goto dmafree;
>> +        goto dmafree;
>>       }
>>       dmadev->lldev = hidma_ll_init(dmadev->ddev.dev,
> 
> 

