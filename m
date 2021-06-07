Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270EA39DA1C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGKwG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 06:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGKwG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Jun 2021 06:52:06 -0400
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E9C061766;
        Mon,  7 Jun 2021 03:50:15 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Fz9BD6rjTzQjgl;
        Mon,  7 Jun 2021 12:50:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id CCqJTFs-0X5b; Mon,  7 Jun 2021 12:50:09 +0200 (CEST)
Subject: Re: [PATCH v5 3/3] dmaengine: altera-msgdma: add OF support
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
 <088a373c92bdee6e24da771c1ae2e4ed0887c0d7.1621343877.git.olivier.dautricourt@orolia.com>
 <YL3DvQWhn+SsBqhJ@vkoul-mobl> <YL3Ynm9xBQ419qK3@orolia.com>
 <YL3wOT1B8Qp+EXSV@vkoul-mobl> <YL343OIeVZe0Hvod@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <0fe0984f-7fa4-5885-47b9-db4fe6d5cd7c@denx.de>
Date:   Mon, 7 Jun 2021 12:50:09 +0200
MIME-Version: 1.0
In-Reply-To: <YL343OIeVZe0Hvod@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.62 / 15.00 / 15.00
X-Rspamd-Queue-Id: C7D14180C
X-Rspamd-UID: 796acd
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07.06.21 12:45, Olivier Dautricourt wrote:
> The 06/07/2021 15:38, Vinod Koul wrote:
>> On 07-06-21, 10:28, Olivier Dautricourt wrote:
>>> The 06/07/2021 12:29, Vinod Koul wrote:
>>>> On 18-05-21, 15:25, Olivier Dautricourt wrote:
>>>>> This driver had no device tree support.
>>>>>
>>>>> - add compatible field "altr,socfpga-msgdma"
>>>>> - define msgdma_of_xlate, with no argument
>>>>> - register dma controller with of_dma_controller_register
>>>>>
>>>>> Reviewed-by: Stefan Roese <sr@denx.de>
>>>>> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>      Changes in v2:
>>>>>          none
>>>>>
>>>>>      Changes from v2 to v3:
>>>>>          Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
>>>>>          only once.
>>>>>
>>>>>      Changes from v3 to v4
>>>>>          Reintroduce #ifdef CONFIG_OF for msgdma_match
>>>>>          as it produces a unused variable warning
>>>>>
>>>>>      Changes from v4 to v5
>>>>>          - As per Rob's comments on patch 1/2:
>>>>>            change compatible field from altr,msgdma to
>>>>>            altr,socfpga-msgdma.
>>>>>          - change commit title to fit previous commits naming
>>>>>          - As per Vinod's comments:
>>>>>            - use dma_get_slave_channel instead of dma_get_any_slave_channel which
>>>>>              makes more sense.
>>>>>            - remove if (IS_ENABLED(CONFIG_OF)) for of_dma_controller_register
>>>>>              as it is taken care by the core
>>>>>
>>>>>   drivers/dma/altera-msgdma.c | 26 ++++++++++++++++++++++++++
>>>>>   1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
>>>>> index 9a841ce5f0c5..acf0990d73ae 100644
>>>>> --- a/drivers/dma/altera-msgdma.c
>>>>> +++ b/drivers/dma/altera-msgdma.c
>>>>> @@ -19,6 +19,7 @@
>>>>>   #include <linux/module.h>
>>>>>   #include <linux/platform_device.h>
>>>>>   #include <linux/slab.h>
>>>>> +#include <linux/of_dma.h>
>>>>>
>>>>>   #include "dmaengine.h"
>>>>>
>>>>> @@ -784,6 +785,14 @@ static int request_and_map(struct platform_device *pdev, const char *name,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> +static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
>>>>> +                                     struct of_dma *ofdma)
>>>>> +{
>>>>> +     struct msgdma_device *d = ofdma->of_dma_data;
>>>>> +
>>>>> +     return dma_get_slave_channel(&d->dmachan);
>>>>> +}
>>>>
>>>> Why not use of_dma_simple_xlate() instead?
>>> I guess i could, but i don't think i need to define a filter function,
>>> also there is only one possible channel.
>>
>> Yeah no point in adding filter_fn. I guess we need
>> of_dma_xlate_by_chan_id() here, I guess you are specifying channel in dts
>> right? If not above would be okay
> Yes i am, but as this controller has only one channel I was thinking not to fail
> if something other than chan_id == 0 is specified. But it may not be right,
> I could also remove the argument in the device tree but dma controller
> schema expects at least one argument.
> Now i think maybe it makes more sense to use of_dma_xlate_by_chan_id and
> expect chan_id == 0 in the dt.
>>
>>>>
>>>>> +
>>>>>   /**
>>>>>    * msgdma_probe - Driver probe function
>>>>>    * @pdev: Pointer to the platform_device structure
>>>>> @@ -888,6 +897,13 @@ static int msgdma_probe(struct platform_device *pdev)
>>>>>        if (ret)
>>>>>                goto fail;
>>>>>
>>>>> +     ret = of_dma_controller_register(pdev->dev.of_node,
>>>>> +                                      msgdma_of_xlate, mdev);
>>>>> +     if (ret) {
>>>>> +             dev_err(&pdev->dev, "failed to register dma controller");
>>>>> +             goto fail;
>>>>
>>>> Should this be treated as an error.. the probe will be invoked on non of
>>>> systems too..
>>> Ok, i'm a bit confused,
>>> in v4 those lines were enclosed with 'if (IS_ENABLED(CONFIG_OF)) { }'
>>> when you said to me that it was already taken care by the core i though
>>> that of_dma_controller_register will return 0 on non-of systems.
>>> Now i can add back IS_ENABLED(CONFIG_OF) or discard the ret value.
>>
>> Well including in CONFIG_OF sounded protection from compilation which is
>> not required.
>>
>> Now the issue is that you maybe running on a system which may or maynot
>> have DT and even on DT based systems your device may not be DT one..
> good catch, i forgot this use-case ..
>>
>> So i think the return should be handled here if DT device is not present
>> and warn that and continue for not DT modes.. Also someone who has this
>> non DT device should test the changes
> I can do that.
> 
> I think Stefan used this driver on non-DT platform but he said
> that he has no access to the hardware anymore.

Correct. Unfortunately I can't do any tests.

Thanks,
Stefan
