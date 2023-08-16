Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3777E8D9
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbjHPSjE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Aug 2023 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbjHPSiv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Aug 2023 14:38:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18891B2;
        Wed, 16 Aug 2023 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Zt0oIUR7CPyOLzen8uwt/eQkJhMyoct9UDoUX3KYy9w=; b=4LQCWKgUm1uweQAPl58aV65Jjg
        IX4nraKfDHtq1oTAbepnVOGSPyAWWfQ4VefJaI0s8DpCrRaWZdlkiTZqSdQ3GMipKyrWbP5Oi03Ok
        QfLIbNaXV5YRFr8YE2RnoICQRW207MvP69Ov6eevZi37iadRfuuKWZz4E327Cvq/AxXkUwYfM57+d
        CJk3yQRJ5kdEMjwkI2AHONGEwArp16+wSefizti8D4HvGQDm0fnq1ajcsV3IivGaxWGWLGPVPTlZn
        TiPIkA/lUpnPTjt7Up6uFImFfdVHuYIYct6pGp5ZsPpw6lBgjzVoQxmhsDXudLHyt2OPGqGJHCDpA
        iWY1hX4g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWLPp-004on9-1W;
        Wed, 16 Aug 2023 18:38:45 +0000
Message-ID: <1595571f-e69a-319e-0f8e-708c222706cb@infradead.org>
Date:   Wed, 16 Aug 2023 11:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dma: dmatest: Use div64_s64
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, coolrrsh@gmail.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230816060400.3325-1-coolrrsh@gmail.com>
 <2023081654-dormitory-vocally-02f7@gregkh>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2023081654-dormitory-vocally-02f7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/16/23 08:16, Greg KH wrote:
> On Wed, Aug 16, 2023 at 11:34:00AM +0530, coolrrsh@gmail.com wrote:
>> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>>
>> In the function do_div, the dividend is evaluated multiple times
>> so it can cause side effects. Therefore replace it with div64_s64.
>>
>> This fixes warning such as:
>> drivers/dma/dmatest.c:496:1-7:
>> WARNING: do_div() does a 64-by-32 division,
>> please consider using div64_s64 instead.
>>
>> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
>> ---
>>  drivers/dma/dmatest.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index ffe621695e47..07042f239db8 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -9,6 +9,7 @@
>>  
>>  #include <linux/err.h>
>>  #include <linux/delay.h>
>> +#include <linux/math64.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/freezer.h>
>> @@ -493,7 +494,7 @@ static unsigned long long dmatest_persec(s64 runtime, unsigned int val)
>>  
>>  	per_sec *= val;
>>  	per_sec = INT_TO_FIXPT(per_sec);
>> -	do_div(per_sec, runtime);
>> +	per_sec=div64_s64(per_sec, runtime);
> 
> Please always run checkpatch.pl on your changes before submitting them
> for others to review.

Also please tell us what tool produced that warning message.
Thanks.

-- 
~Randy
