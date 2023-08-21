Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246D782369
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 08:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHUGGc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjHUGGc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 02:06:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BF083
        for <dmaengine@vger.kernel.org>; Sun, 20 Aug 2023 23:06:29 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RThjm61gFzLp77;
        Mon, 21 Aug 2023 14:03:24 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 14:06:27 +0800
Message-ID: <128b2291-75c4-4482-2f6b-d9c26c062c7d@huawei.com>
Date:   Mon, 21 Aug 2023 14:06:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 1/2] dmaengine: fsl-edma: use struct_size() helper
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <liwei391@huawei.com>, <dmaengine@vger.kernel.org>
References: <20230816020355.3002617-1-liaoyu15@huawei.com>
 <ZOL6ior65updLbea@matsya>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <ZOL6ior65updLbea@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/8/21 13:47, Vinod Koul wrote:
> On 16-08-23, 10:03, Yu Liao wrote:
>> Make use of the struct_size() helper instead of an open-coded version,
>> in order to avoid any potential type mistakes or integer overflows that,
>> in the worst scenario, could lead to heap overflows.
>>
>> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>> ---
>>  drivers/dma/fsl-edma.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
>> index e40769666e39..caca3566ba82 100644
>> --- a/drivers/dma/fsl-edma.c
>> +++ b/drivers/dma/fsl-edma.c
>> @@ -270,7 +270,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
>>  	struct device_node *np = pdev->dev.of_node;
>>  	struct fsl_edma_engine *fsl_edma;
>>  	const struct fsl_edma_drvdata *drvdata = NULL;
>> -	struct fsl_edma_chan *fsl_chan;
>>  	struct edma_regs *regs;
>>  	int len, chans;
>>  	int ret, i;
>> @@ -288,7 +287,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	len = sizeof(*fsl_edma) + sizeof(*fsl_chan) * chans;
>> +	len = struct_size(fsl_edma, chans, chans);
>>  	fsl_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> 
> Drop len and use struct_size() here...

Thank you for the review. I'll make the suggested changes and send you
the V2.

Best regards,
Yu
> 
>>  	if (!fsl_edma)
>>  		return -ENOMEM;
>> -- 
>> 2.25.1
> 

