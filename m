Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70B472977
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jul 2019 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfGXIFP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jul 2019 04:05:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45281 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXIFO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jul 2019 04:05:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so20794338pgp.12;
        Wed, 24 Jul 2019 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I7CYszDrvy+reFYnb37zWErTiK7A3kRJaQqiQHkXdvQ=;
        b=XopkYn+C0zdVHgIkt66lfuYlcHVZEh0RvR2nPl7T7enil4q+4ukS6QPBJHMdwUe+at
         pVb11v30KjJTIhYhNFrnjzTG2t0YB5MBVUe0t9meobxy3Ox49svLqeoueqXv2q+jSy5w
         KsVEtk9flhxdsRWKQnnky5PxzUGpBTc0aWUhw6IX2+X7uFbURDFl3y9KcOKimWHV9/t6
         fpCjaGfM+MTjyl/oLgL7J9Okz7wcoQXVTukQTZZzE/K2It+44ctH9ZCWssR3UqzyLIZk
         9HS35r1WFqgZImkD6e1kz/jSZP8OAyYR8nY3xxow8A+3qxh27k7Em3kWdMt0oNzNU865
         +mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7CYszDrvy+reFYnb37zWErTiK7A3kRJaQqiQHkXdvQ=;
        b=eEzP9XifyV0aMFC2UMp0AOy8sQ1evjJQ8pYzeP351vz7u+ZQA6nhaiOSlJj1E6C4zQ
         oPHTQEczz1Ktd1a3KgGYm0wvR+c6lZn/YXaShqcdtpQwI3xR2ZKD0vvtyajQy9OoNbAF
         gKoywSTc8Hq/Oyxk08cJ1ozqk7Kx/SsmqLV21H6xNl4UteXv0N/7Fdpsk/kUk+dpEgd2
         ljIvF5Ia6TNwFdtzyG2SZN2yOglmR6nzTJUn8byWEzvREFspAGA1uUDSibHBtvdjmlMB
         uI66NH/8Tip369CIdqH8RK0I3EA1FVaqUhZqxRo9jicR1SNClpInVKBx7j6vZFi7UlZJ
         iupg==
X-Gm-Message-State: APjAAAV9YC5Pe3WM4SkSeafb1aXvC84OKoINMrYcZyQmyaRHOJb8nT67
        FYfhuT8oC/JIr3WCYyE1FFYfk+bm
X-Google-Smtp-Source: APXvYqzmDqmkC2d9/oClG6/UabpxPCen8k1387I2VEn/V7tCAoDJaKvuQbWQ9sWihPJv2dQ/R/pRnA==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr79304761pgg.171.1563955513909;
        Wed, 24 Jul 2019 01:05:13 -0700 (PDT)
Received: from [10.0.2.15] ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id v126sm2211091pgb.23.2019.07.24.01.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 01:05:13 -0700 (PDT)
Subject: Re: [PATCH] dma: qcom: hidma_mgmt: Add of_node_put() before goto
To:     Robin Murphy <robin.murphy@arm.com>, okaya@kernel.org,
        agross@kernel.org, vkoul@kernel.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <20190723103543.7888-1-nishkadg.linux@gmail.com>
 <b5b76ef6-c5f3-bab0-e981-cd47c7264959@arm.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <6ef666c3-a155-130d-24bc-8c04b3485d44@gmail.com>
Date:   Wed, 24 Jul 2019 13:35:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b5b76ef6-c5f3-bab0-e981-cd47c7264959@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23/07/19 5:32 PM, Robin Murphy wrote:
> On 23/07/2019 11:35, Nishka Dasgupta wrote:
>> Each iteration of for_each_available_child_of_node puts the previous
>> node, but in the case of a goto from the middle of the loop, there is
>> no put, thus causing a memory leak. Add an of_node_put before the
>> goto in 4 places.
> 
> Why not just add it once at the "out" label itself? (Consider the 
> conditions for the loop terminating naturally)

If the loop terminates naturally then, as far as I understand, child 
will be put by the loop itself; then an extra of_node_put() under the 
out label would put the child node even though it has already been put. 
If I'm understanding this correctly (and I might not be) is it okay to 
decrement refcount more times that it is incremented?

> And if you're cleaning up the refcounting here anyway then I'd also note 
> that the reference held by the loop iterator makes the extra get/put 
> inside that loop entirely redundant. It's always worth taking a look at 
> the wider context rather than just blindly focusing on what a given 
> script picks up - it's fairly rare that a piece of code has one obvious 
> issue but is otherwise perfect.

Thank  you for pointing this out; I've added it in v2.

Thanking you,
Nishka
> Robin.
> 
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/dma/qcom/hidma_mgmt.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/hidma_mgmt.c 
>> b/drivers/dma/qcom/hidma_mgmt.c
>> index 3022d66e7a33..209adc6ceabe 100644
>> --- a/drivers/dma/qcom/hidma_mgmt.c
>> +++ b/drivers/dma/qcom/hidma_mgmt.c
>> @@ -362,16 +362,22 @@ static int __init 
>> hidma_mgmt_of_populate_channels(struct device_node *np)
>>           struct platform_device *new_pdev;
>>           ret = of_address_to_resource(child, 0, &res[0]);
>> -        if (!ret)
>> +        if (!ret) {
>> +            of_node_put(child);
>>               goto out;
>> +        }
>>           ret = of_address_to_resource(child, 1, &res[1]);
>> -        if (!ret)
>> +        if (!ret) {
>> +            of_node_put(child);
>>               goto out;
>> +        }
>>           ret = of_irq_to_resource(child, 0, &res[2]);
>> -        if (ret <= 0)
>> +        if (ret <= 0) {
>> +            of_node_put(child);
>>               goto out;
>> +        }
>>           memset(&pdevinfo, 0, sizeof(pdevinfo));
>>           pdevinfo.fwnode = &child->fwnode;
>> @@ -386,6 +392,7 @@ static int __init 
>> hidma_mgmt_of_populate_channels(struct device_node *np)
>>           new_pdev = platform_device_register_full(&pdevinfo);
>>           if (IS_ERR(new_pdev)) {
>>               ret = PTR_ERR(new_pdev);
>> +            of_node_put(child);
>>               goto out;
>>           }
>>           of_node_get(child);
>>

