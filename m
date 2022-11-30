Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0204E63D121
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 09:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiK3IxL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 03:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiK3IxK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 03:53:10 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5A13E0C
        for <dmaengine@vger.kernel.org>; Wed, 30 Nov 2022 00:53:09 -0800 (PST)
Received: from [192.168.0.105] (unknown [123.112.66.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 30A5441CE7;
        Wed, 30 Nov 2022 08:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669798387;
        bh=LsZDP7v1tsj2/7izLl4U9Qnosq8CjJxoYskuUCMYSz4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FQE11lO0npaoH7U9BztE4B9rLliecAgK6KgBKhhF4Q7MQiruNC565gkuzo7vE9SM0
         M7m/Dn30HWLvbaGjPT9fbgS5lUWO24axY+PE2itxxLl424a0w0JC0JzQHwhh5Ftrua
         OIDWsJPGYDrC3DaHrzXBUyVGlO6+6ypK7i9a4jppJMHkiDQJTb/eb1GhbjXHOE2BZM
         Sx91Nd8S36UFQ2uVFk0/oVVaI3Jv1sQ9rbZkd8js4TZekzM/V8+uKLqYFcrWRDu1B5
         FkkzgRCa4R35LdIufOEnoIeHOwQGoBuMk5s3opEJVCJ8/qPBn4N/cfYWxVRTdpWzoH
         JCXS2pYy7yRbA==
Message-ID: <c1501eca-5b67-95aa-bc46-3cd85bfd6083@canonical.com>
Date:   Wed, 30 Nov 2022 16:53:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dmaengine: imx-sdma: Fix a possible memory leak in
 sdma_transfer_init
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org, shawnguo@kernel.org
References: <20221130044237.29525-1-hui.wang@canonical.com>
 <20221130082937.GF29728@pengutronix.de>
Content-Language: en-US
From:   Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20221130082937.GF29728@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

OK, got it. Will change it in the V2.

Thanks.

On 11/30/22 16:29, Sascha Hauer wrote:
> On Wed, Nov 30, 2022 at 12:42:37PM +0800, Hui Wang wrote:
>> If the function sdma_load_context() fails, the sdma_desc will be
>> freed, but the allocated desc->bd is forgot to be freed.
>>
>> We already met the sdma_load_context() failure case and the log as
>> below:
>> [ 450.699064] imx-sdma 30bd0000.dma-controller: Timeout waiting for CH0 ready
>> ...
>>
>> In this case, the desc->bd will not be freed without this change.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/dma/imx-sdma.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index fbea5f62dd98..235a4e12d660 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -1520,8 +1520,10 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>>   	if (direction == DMA_MEM_TO_MEM)
>>   		sdma_config_ownership(sdmac, false, true, false);
>>   
>> -	if (sdma_load_context(sdmac))
>> +	if (sdma_load_context(sdmac)) {
>> +		sdma_free_bd(desc);
>>   		goto err_desc_out;
>> +	}
> We have an error path at the end of the function. For consistency you
> should follow that pattern and add another label where you call
> sdma_free_bd().
>
> Sascha
>
