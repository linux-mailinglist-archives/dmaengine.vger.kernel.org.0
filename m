Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97A094940
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2019 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfHSP45 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Aug 2019 11:56:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15352 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfHSP44 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Aug 2019 11:56:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5ac6c70000>; Mon, 19 Aug 2019 08:56:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 08:56:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 19 Aug 2019 08:56:54 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 15:56:54 +0000
Received: from [10.2.167.147] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Aug
 2019 15:56:53 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>
CC:     Sameer Pujar <spujar@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>
References: <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
 <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
 <20190729061010.GC12733@vkoul-mobl.Dlink>
 <98954eb3-21f1-6008-f8e1-f9f9b82f87fb@nvidia.com>
 <20190731151610.GT12733@vkoul-mobl.Dlink>
 <c0f4de86-423a-35df-3744-40db89f2fdfe@nvidia.com>
 <20190808123833.GX12733@vkoul-mobl.Dlink>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a93a472d-b8f7-973f-6068-607492421472@nvidia.com>
Date:   Mon, 19 Aug 2019 16:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808123833.GX12733@vkoul-mobl.Dlink>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566230215; bh=PuhvZPBAKGFT1rNZtyq++viay+aZnss2mM1vyg8TnK0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mE+HEY9RJIqIcMDX5kiJU6rb8gBm/bR42R+NQ5a6+lQgJdoHfHKXtJpE2uKkQKVsd
         xLxxEhGT9M5o+yd5tZTzWfyLNbx2IGM3zz/uBsZjq0qKjuJnHOlklJQo0VoEBxafgX
         nOFodfExt6tm6qAI1XBVuHQCRcEQrf3RKWRVQMZwWFpSephguedKThyAlGWFED5Gxk
         hBVUbg9QIPtH0iSmgIO3crewJTxGJ68kfhe+ZISHrGg0p7loRQJLYhyBCqT/QtDNVT
         QBnYEyDtYzhswoVunnghEl5mR7uD7yLoBYRfmeBZXLvIkXYmXsWLmvbcqt/WrlMXg6
         SS9hg3lNDgvUw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 08/08/2019 13:38, Vinod Koul wrote:
> On 02-08-19, 09:51, Jon Hunter wrote:
>>
>> On 31/07/2019 16:16, Vinod Koul wrote:
>>> On 31-07-19, 10:48, Jon Hunter wrote:
>>>>
>>>> On 29/07/2019 07:10, Vinod Koul wrote:
>>>>> On 23-07-19, 11:24, Sameer Pujar wrote:
>>>>>>
>>>>>> On 7/19/2019 10:34 AM, Vinod Koul wrote:
>>>>>>> On 05-07-19, 11:45, Sameer Pujar wrote:
>>>>>>>> Hi Vinod,
>>>>>>>>
>>>>>>>> What are your final thoughts regarding this?
>>>>>>> Hi sameer,
>>>>>>>
>>>>>>> Sorry for the delay in replying
>>>>>>>
>>>>>>> On this, I am inclined to think that dma driver should not be involved.
>>>>>>> The ADMAIF needs this configuration and we should take the path of
>>>>>>> dma_router for this piece and add features like this to it
>>>>>>
>>>>>> Hi Vinod,
>>>>>>
>>>>>> The configuration is needed by both ADMA and ADMAIF. The size is
>>>>>> configurable
>>>>>> on ADMAIF side. ADMA needs to know this info and program accordingly.
>>>>>
>>>>> Well I would say client decides the settings for both DMA, DMAIF and
>>>>> sets the peripheral accordingly as well, so client communicates the two
>>>>> sets of info to two set of drivers
>>>>
>>>> That maybe, but I still don't see how the information is passed from the
>>>> client in the first place. The current problem is that there is no means
>>>> to pass both a max-burst size and fifo-size to the DMA driver from the
>>>> client.
>>>
>>> So one thing not clear to me is why ADMA needs fifo-size, I thought it
>>> was to program ADMAIF and if we have client programme the max-burst
>>> size to ADMA and fifo-size to ADMAIF we wont need that. Can you please
>>> confirm if my assumption is valid?
>>
>> Let me see if I can clarify ...
>>
>> 1. The FIFO we are discussing here resides in the ADMAIF module which is
>>    a separate hardware block the ADMA (although the naming make this
>>    unclear).
>>
>> 2. The size of FIFO in the ADMAIF is configurable and it this is
>>    configured via the ADMAIF registers. This allows different channels
>>    to use different FIFO sizes. Think of this as a shared memory that is
>>    divided into n FIFOs shared between all channels.
>>
>> 3. The ADMA, not the ADMAIF, manages the flow to the FIFO and this is
>>    because the ADMAIF only tells the ADMA when a word has been
>>    read/written (depending on direction), the ADMAIF does not indicate
>>    if the FIFO is full, empty, etc. Hence, the ADMA needs to know the
>>    total FIFO size.
>>
>> So the ADMA needs to know the FIFO size so that it does not overrun the
>> FIFO and we can also set a burst size (less than the total FIFO size)
>> indicating how many words to transfer at a time. Hence, the two parameters.
> 
> Thanks, I confirm this is my understanding as well.
> 
> To compare to regular case for example SPI on DMA, SPI driver will
> calculate fifo size & burst to be used and program dma (burst size) and
> its own fifos accordingly
> 
> So, in your case why should the peripheral driver not calculate the fifo
> size for both ADMA and ADMAIF and (if required it's own FIFO) and
> program the two (ADMA and ADMAIF).
> 
> What is the limiting factor in this flow is not clear to me.

The FIFO size that is configured by the ADMAIF driver needs to be given
to the ADMA driver so that it can program its registers accordingly. The
difference here is that both the ADMA and ADMAIF need the FIFO size.

Cheers
Jon

-- 
nvpublic
