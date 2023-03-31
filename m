Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E716D295A
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjCaUYE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCaUYC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 16:24:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911641A473
        for <dmaengine@vger.kernel.org>; Fri, 31 Mar 2023 13:23:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iLHvp2hY8xuxqiLHvpWGqu; Fri, 31 Mar 2023 22:23:56 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 31 Mar 2023 22:23:56 +0200
X-ME-IP: 86.243.2.178
Message-ID: <4464e70f-71a3-3c04-7e53-8ccf2e143a04@wanadoo.fr>
Date:   Fri, 31 Mar 2023 22:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dmaengine: mv_xor_v2: Fix an error code.
To:     Dan Carpenter <error27@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
 <16cfc681-7a08-4160-bd69-4c8b59774688@kili.mountain>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <16cfc681-7a08-4160-bd69-4c8b59774688@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 29/03/2023 à 12:27, Dan Carpenter a écrit :
> On Sun, Mar 26, 2023 at 09:06:37AM +0200, Christophe JAILLET wrote:
>> If the probe is deferred, -EPROBE_DEFER should be returned, not
>> +EPROBE_DEFER.
>>
>> Fixes: 3cd2c313f1d6 ("dmaengine: mv_xor_v2: Fix clock resource by adding a register clock")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/dma/mv_xor_v2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
>> index 89790beba305..0991b8265829 100644
>> --- a/drivers/dma/mv_xor_v2.c
>> +++ b/drivers/dma/mv_xor_v2.c
>> @@ -752,7 +752,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
>>   
>>   	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
>>   	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
>> -		ret = EPROBE_DEFER;
>> +		ret = -EPROBE_DEFER;
>>   		goto disable_reg_clk;
> 
> Heh.  Looking through the Smatch results, I don't think this actually
> affects runtime because driver_probe_device() checks for both positive
> and negatives.  People shouldn't be returning positives, of course, but
> it appears there is a work around for bugs built in already.

Correct, but weird.

I've tried to look at the history of [1], but couldn't find any rational 
for it.

Apparently it was already in the v1 of the serie. [2]

CJ

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=45ddcb42949f825f0caa25352e825cede94b6aba
[2]: https://lore.kernel.org/all/20210614150846.4111871-5-hch@lst.de/

> 
> regards,
> dan carpenter
> 
> 

