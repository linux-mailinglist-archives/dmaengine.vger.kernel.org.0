Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5103350B05A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444162AbiDVGUm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444330AbiDVGUj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:20:39 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79265506F3;
        Thu, 21 Apr 2022 23:17:23 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 22 Apr
 2022 14:17:25 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 22 Apr
 2022 14:17:19 +0800
Message-ID: <dc948948-5d69-e9b1-417b-7d6b8824782c@meizu.com>
Date:   Fri, 22 Apr 2022 14:17:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] dmaengine: imx-sdma: Remove useless null check before
 call of_node_put()
To:     Vinod Koul <vkoul@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1650509390-26877-1-git-send-email-baihaowen@meizu.com>
 <YmJGw84by8eczx/u@matsya>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <YmJGw84by8eczx/u@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

在 4/22/22 2:10 PM, Vinod Koul 写道:
> On 21-04-22, 10:49, Haowen Bai wrote:
>> No need to add null check before call of_node_put(), since the
>> implementation of of_node_put() has done it.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>  drivers/dma/imx-sdma.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index 6196a7b3956b..b8a1299b93f0 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -1933,8 +1933,7 @@ static int sdma_event_remap(struct sdma_engine *sdma)
>>  	}
>>  
>>  out:
>> -	if (gpr_np)
>> -		of_node_put(gpr_np);
>> +	of_node_put(gpr_np);
> this is incorrect as it is called on error case
>
>
Even through it is called on error case, gpr_np=null, but  of_node_put
did a null check.
void of_node_put(struct device_node *node)

{ if (node) kobject_put(&node->kobj); }

-- 
Haowen Bai

