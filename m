Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBCC6723A0
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjARQkP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 11:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjARQj5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 11:39:57 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAD6312F29;
        Wed, 18 Jan 2023 08:39:54 -0800 (PST)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id C9735356E6;
        Wed, 18 Jan 2023 17:39:52 +0100 (CET)
Message-ID: <f993b252-ab7b-c67c-a440-9de6b290dbeb@gpxsee.org>
Date:   Wed, 18 Jan 2023 17:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH V11 XDMA 2/2] dmaengine: xilinx: xdma: Add user
 logic interrupt support
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
 <1673988842-43631-3-git-send-email-lizhi.hou@amd.com>
 <Y8eRz2sXrnCtSib+@matsya> <85d1e660-1df4-6e84-a329-751197ef7eec@gpxsee.org>
 <483c7088-1ac1-6924-9cfb-a131e82276ee@metafoo.de>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <483c7088-1ac1-6924-9cfb-a131e82276ee@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18. 01. 23 16:33, Lars-Peter Clausen wrote:
> On 1/18/23 07:28, Martin Tůma wrote:
>>>> +++ b/include/linux/dma/amd_xdma.h
>>>> @@ -0,0 +1,16 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +/*
>>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>>> + */
>>>> +
>>>> +#ifndef _DMAENGINE_AMD_XDMA_H
>>>> +#define _DMAENGINE_AMD_XDMA_H
>>>> +
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num);
>>>> +void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num);
>>>> +int xdma_get_user_irq(struct platform_device *pdev, u32 
>>>> user_irq_index);
>>>
>>> who is the user of these APIs? It is not clear to me how this is to be
>>> used...
>>>
>>
>> The APIs are used by the PCIe card devices/drivers that use XDMA. 
>> Without them the "user IRQs" provided by the XDMA HW can not be used 
>> by the PCIe card drivers. If you look at the XDMA HW overview:
>> https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Overview?tocId=O_EMX26J5IsdubL4i3XJ_w
>> those APIs control the "IRQ module" block.
>>
>> For a linux driver using them see the mgb4 v4l2 driver:
>> https://patchwork.kernel.org/project/linux-media/patch/20230113172636.2590-2-tumic@gpxsee.org/ 
> 
> 
> Rather than custom functions this should probably be integrated with the 
> generic IRQ framework registering a IRQ chip that provides IRQs that can 
> be requested by the consumer.
> 

I'm not sure if this makes sense. Those IRQs are "special" as they 
control the user logic (there are additional IRQs in XDMA used by the 
DMA engine itself). Only the "user IRQs" have this control logic but all 
the IRQs are available as standard MSI/MSI-X IRQs in the kernel. There 
is also the problem with the IRQ numbering as the XDMA HW can be 
configured with a variable number of total IRQs and "user IRQ #X" can be 
a different MSI/MSI-X IRQ depending on the number of configured DMA 
channels. This API ensures that you get the correct user logic "wire" 
independent of the XDMA configuration you have.

Finally, I'm not sure how hard or even if possible it is to integrate 
the special handling of some MSI/MSI-X IRQs into the generic IRQ 
framework as the "IRQ chip" will be some generic PCIe IRQ chip 
(depending on the mainboard). But maybe that's not a problem.

M.
