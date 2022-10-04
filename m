Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225625F40BA
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJDK0c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Oct 2022 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDK0b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Oct 2022 06:26:31 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C882B621;
        Tue,  4 Oct 2022 03:26:28 -0700 (PDT)
Received: from [192.168.42.220] (14-nat1-1.centrio.cz [217.195.172.14])
        by mx.gpxsee.org (Postfix) with ESMTPSA id C095435502;
        Tue,  4 Oct 2022 12:26:26 +0200 (CEST)
Message-ID: <daccee4a-ac3c-bfc1-4876-24e6ecf5bcf1@gpxsee.org>
Date:   Tue, 4 Oct 2022 12:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V5 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com
Cc:     max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com>
 <1664409507-64079-3-git-send-email-lizhi.hou@amd.com>
 <33583d7f-8f8c-64a1-7b93-4e6aebb266a3@gpxsee.org>
 <1836ce13-101f-a863-41ea-bd49c21d4f60@amd.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <1836ce13-101f-a863-41ea-bd49c21d4f60@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 03. 10. 22 17:52, Lizhi Hou wrote:
>
> On 10/3/22 06:59, Martin Tůma wrote:
>> On 29. 09. 22 1:58, Lizhi Hou wrote:
>>> The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
>>> interrupt wires to user logic that generate interrupts to the host.
>>> This patch adds APIs to enable/disable user logic interrupt for a given
>>> interrupt wire index.
>>>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>> Signed-off-by: Brian Xu <brian.xu@amd.com>
>>> ---
>>>   MAINTAINERS                  |  1 +
>>>   drivers/dma/xilinx/xdma.c    | 65 
>>> ++++++++++++++++++++++++++++++++++++
>>>   include/linux/dma/amd_xdma.h | 16 +++++++++
>>>   3 files changed, 82 insertions(+)
>>>   create mode 100644 include/linux/dma/amd_xdma.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index c1be0b2e378a..019d84b2b086 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -21691,6 +21691,7 @@ L:    dmaengine@vger.kernel.org
>>>   S:    Supported
>>>   F:    drivers/dma/xilinx/xdma-regs.h
>>>   F:    drivers/dma/xilinx/xdma.c
>>> +F:    include/linux/dma/amd_xdma.h
>>>   F:    include/linux/platform_data/amd_xdma.h
>>>     XILINX ZYNQMP DPDMA DRIVER
>>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>>> index 58a57e03bef5..13f627445c4a 100644
>>> --- a/drivers/dma/xilinx/xdma.c
>>> +++ b/drivers/dma/xilinx/xdma.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/dmapool.h>
>>>   #include <linux/regmap.h>
>>>   #include <linux/dmaengine.h>
>>> +#include <linux/dma/amd_xdma.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/platform_data/amd_xdma.h>
>>>   #include <linux/dma-mapping.h>
>>> @@ -736,6 +737,7 @@ static int xdma_set_vector_reg(struct 
>>> xdma_device *xdev, u32 vec_tbl_start,
>>>   static int xdma_irq_init(struct xdma_device *xdev)
>>>   {
>>>       u32 irq = xdev->irq_start;
>>> +    u32 user_irq_start;
>>>       int i, j, ret;
>>>         /* return failure if there are not enough IRQs */
>>> @@ -786,6 +788,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
>>>           goto failed;
>>>       }
>>>   +    /* config user IRQ registers if needed */
>>> +    user_irq_start = xdev->h2c_chan_num + xdev->c2h_chan_num;
>>> +    if (xdev->irq_num > user_irq_start) {
>>> +        ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
>>> +                      user_irq_start,
>>> +                      xdev->irq_num - user_irq_start);
>>> +        if (ret) {
>>> +            xdma_err(xdev, "failed to set user vectors: %d", ret);
>>> +            goto failed;
>>> +        }
>>> +    }
>>> +
>>>       /* enable interrupt */
>>>       ret = xdma_enable_intr(xdev);
>>>       if (ret) {
>>> @@ -816,6 +830,57 @@ static bool xdma_filter_fn(struct dma_chan 
>>> *chan, void *param)
>>>       return true;
>>>   }
>>>   +/**
>>> + * xdma_disable_user_irq - Disable user interrupt
>>> + * @pdev: Pointer to the platform_device structure
>>> + * @user_irq_index: User IRQ index
>>> + */
>>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index)
>>> +{
>>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>>> +
>>> +    if (xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index >=
>>> +        xdev->irq_num) {
>>> +        xdma_err(xdev, "invalid user irq index");
>>> +        return;
>>> +    }
>>> +
>>> +    xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
>>> +               (1 << user_irq_index));
>>> +}
>>> +EXPORT_SYMBOL(xdma_disable_user_irq);
>>> +
>>> +/**
>>> + * xdma_enable_user_irq - Enable user logic interrupt
>>> + * @pdev: Pointer to the platform_device structure
>>> + * @user_irq_index: User logic IRQ wire index
>>> + * @irq: Pointer to returning system IRQ number
>>> + */
>>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index,
>>> +             u32 *irq)
>>> +{
>>> +    struct xdma_device *xdev = platform_get_drvdata(pdev);
>>> +    u32 user_irq;
>>> +    int ret;
>>> +
>>> +    user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + 
>>> user_irq_index;
>>> +    if (user_irq >= xdev->irq_num) {
>>> +        xdma_err(xdev, "invalid user irq index");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, 
>>> XDMA_IRQ_USER_INT_EN_W1S,
>>> +                 (1 << user_irq_index));
>>> +    if (ret) {
>>> +        xdma_err(xdev, "set user irq mask failed, %d", ret);
>>> +        return ret;
>>> +    }
>>> +    *irq = user_irq + xdev->irq_start;
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL(xdma_enable_user_irq);
>>> +
>>>   /**
>>>    * xdma_remove - Driver remove function
>>>    * @pdev: Pointer to the platform_device structure
>>> diff --git a/include/linux/dma/amd_xdma.h 
>>> b/include/linux/dma/amd_xdma.h
>>> new file mode 100644
>>> index 000000000000..91fb02ff93a7
>>> --- /dev/null
>>> +++ b/include/linux/dma/amd_xdma.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#ifndef _DMAENGINE_AMD_XDMA_H
>>> +#define _DMAENGINE_AMD_XDMA_H
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index,
>>> +             u32 *irq);
>>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 
>>> user_irq_index);
>>> +
>>> +#endif /* _DMAENGINE_AMD_XDMA_H */
>>
>> Hi,
>> While rewriting our V4L2 driver to use your XDMA driver, I realized, 
>> that the API for the user interrupts is still not fully usable. If
>> the expected outcome is that the "parent" driver using the xdma 
>> driver knows nothing about the IRQ allocation in XDMA, then the 
>> xdma_enable_user_irq() function must be split into two separate 
>> functions:
>>
>> int xdma_enable_user_irq(struct platform_device *pdev, u32 
>> user_irq_index)
>>
>> and
>>
>> int xdma_get_system_irq(u32 user_irq_index)
>>
>> that returns the system IRQ number for the given user_irq_index.
>> Because without it you can not get the system IRQ number without 
>> enabling the irq at the same time which is usually not what you want.
>
> Is this because the user logic you are using does not have 
> disable/enable interrupt by itself?  I thought that the user logic IP 
> would have its own register to enable/disable interrupt.
>
Yes. Our HW has no "own" registers to disable the IRQs. As such 
registers are already there in XDMA, there was no need for them.


> And xdma_enable_user_irq() will only be called once for creating the 
> user logic platform device. Then, user logic IP driver would use its 
> own register to control interrupts. The existing platform driver does 
> not call any xdma_* to control interrupt.
>
As you can see, there is HW that was designed to use the XDMA registers 
during normal operation and separate enable/disable and irq mapping 
functions are required. Maybe it is not the best HW design, but it can 
evidently happen and then the driver author is screwed with the merged API.

M.

>
> Thanks,
>
> Lizhi
>
>>
>> As a workaround, you can compute the system IRQ yourself with the 
>> knowledge of the XDMA internals (this is what I have to do at the 
>> moment in our driver), but then the "u32 *irq" parameter becomes 
>> useless and can be removed anyway.
>>
>> M.
