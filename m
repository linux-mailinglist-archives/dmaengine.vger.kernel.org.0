Return-Path: <dmaengine+bounces-576-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA898181F0
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 08:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2FB1F26E34
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF401BDDF;
	Tue, 19 Dec 2023 07:00:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DE1BDCE;
	Tue, 19 Dec 2023 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vyq-RHH_1702969201;
Received: from 30.97.48.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vyq-RHH_1702969201)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 15:00:01 +0800
Message-ID: <1b9a7d11-c91f-4b55-bf27-d7c703ed5c24@linux.alibaba.com>
Date: Tue, 19 Dec 2023 15:00:24 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
To: liu kaiwei <liukaiwei086@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: Kaiwei Liu <kaiwei.liu@unisoc.com>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wenming Wu <wenming.wu@unisoc.com>
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
 <ZWCg9hmfvexyn7xK@matsya>
 <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com>
 <ZXb1RWaFWHVDx1wV@matsya>
 <CAOgAA6FJrJ2kVg4hg3sAE_VAG8SyQ4UzKikU+Ofa=N2w0Q4Ghg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAOgAA6FJrJ2kVg4hg3sAE_VAG8SyQ4UzKikU+Ofa=N2w0Q4Ghg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/2023 1:21 PM, liu kaiwei wrote:
> On Mon, Dec 11, 2023 at 7:41 PM Vinod Koul <vkoul@kernel.org> wrote:
>>
>> On 06-12-23, 17:32, liu kaiwei wrote:
>>> On Fri, Nov 24, 2023 at 9:11 PM Vinod Koul <vkoul@kernel.org> wrote:
>>>>
>>>> On 02-11-23, 20:16, Kaiwei Liu wrote:
>>>>> From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
>>>>
>>>> Typo is subject line
>>>>
>>>>>
>>>>> In the probe of dma, it will allocate device memory and do some
>>>>> initalization settings. All operations are only at the software
>>>>> level and don't need the DMA hardware power on. It doesn't need
>>>>> to resume the device and set the device active as well. here
>>>>> delete unnecessary operation.
>>>>
>>>> Don't you need to read or write to the device? Without enable that wont
>>>> work right?
>>>>
>>>
>>> Yes, it doesn't need to read or write to the device in the probe of DMA.
>>> We will enable the DMA when allocating the DMA channel.
>>
>> So you will probe even if device is not present! I think it makes sense
>> to access device registers in probe!
> 
> There is another reason why we delete enable/disable and not to access
> device in probe. The current driver is applicable to two DMA devices
> in different
> power domain. For some scenes, one of the domain is power off and when you
> probe,  enable the dma with the domain power off may cause crash.
> 
> For example, one case is for audio co-processor and DMA serves for it,
> DMA's power domain is off during initialization since audio is not used
> at that time, so we cannot read/write DMA's register for this kind of cases.
> 
> @Baolin Wang
> Hi baolin，what's your opinion?

Please add your explanation into the commit message.

Moreover, I think Vinod's concern is reasonable, so you can not move the 
pm_runtime_enable() after registering the devices, which means users can 
access the device without powering on.

To solve your problem, I think you can move the pm_runtime_enable() 
before dma_async_device_register(), then if users want to use DMA in 
probe stage, the dma_chan_get()--->sprd_dma_alloc_chan_resources() will 
help to power on it.

