Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB97EFA6
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2019 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404498AbfHBIvb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Aug 2019 04:51:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9624 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfHBIva (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Aug 2019 04:51:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d43f9920000>; Fri, 02 Aug 2019 01:51:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 02 Aug 2019 01:51:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 02 Aug 2019 01:51:29 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Aug
 2019 08:51:26 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>
CC:     Sameer Pujar <spujar@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>
References: <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
 <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
 <20190729061010.GC12733@vkoul-mobl.Dlink>
 <98954eb3-21f1-6008-f8e1-f9f9b82f87fb@nvidia.com>
 <20190731151610.GT12733@vkoul-mobl.Dlink>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c0f4de86-423a-35df-3744-40db89f2fdfe@nvidia.com>
Date:   Fri, 2 Aug 2019 09:51:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731151610.GT12733@vkoul-mobl.Dlink>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564735890; bh=nax2DgzaAlHPRJRFGWdL5FItacr7F1m1EM0UoJ50c+s=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YNva9S8cHTX6x7/kDHvIx5AZm7Y0xkUCrnDBsGEfdcQ9Nfb/HmvB6ygs8nk7mdnfn
         LZclFQOatOHmGwsMb/2RQem/VwN02paSzuf/gjQJuzotmrR4bvjwdwq92Rva5VY3mM
         lLGSiakKAxkhcSsQ71/8qsjelkpAurHhi7C/yBjTO35s2L6i+saTC1NN8SV28L7h3t
         /5P9ago0B6kOwPiHFhm4oxzry22WWZxT/b9X9ny8vTdbcYHEAV7oT0SXKFfaxgp8hM
         8r6ywsVlUXfe3pP+eL5AGTMXLrVUgPzGgAD09BR+UaSGq9h93EouK+w4tC6/s4OYLr
         q1WMJOurs6trw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 31/07/2019 16:16, Vinod Koul wrote:
> On 31-07-19, 10:48, Jon Hunter wrote:
>>
>> On 29/07/2019 07:10, Vinod Koul wrote:
>>> On 23-07-19, 11:24, Sameer Pujar wrote:
>>>>
>>>> On 7/19/2019 10:34 AM, Vinod Koul wrote:
>>>>> On 05-07-19, 11:45, Sameer Pujar wrote:
>>>>>> Hi Vinod,
>>>>>>
>>>>>> What are your final thoughts regarding this?
>>>>> Hi sameer,
>>>>>
>>>>> Sorry for the delay in replying
>>>>>
>>>>> On this, I am inclined to think that dma driver should not be involved.
>>>>> The ADMAIF needs this configuration and we should take the path of
>>>>> dma_router for this piece and add features like this to it
>>>>
>>>> Hi Vinod,
>>>>
>>>> The configuration is needed by both ADMA and ADMAIF. The size is
>>>> configurable
>>>> on ADMAIF side. ADMA needs to know this info and program accordingly.
>>>
>>> Well I would say client decides the settings for both DMA, DMAIF and
>>> sets the peripheral accordingly as well, so client communicates the two
>>> sets of info to two set of drivers
>>
>> That maybe, but I still don't see how the information is passed from the
>> client in the first place. The current problem is that there is no means
>> to pass both a max-burst size and fifo-size to the DMA driver from the
>> client.
> 
> So one thing not clear to me is why ADMA needs fifo-size, I thought it
> was to program ADMAIF and if we have client programme the max-burst
> size to ADMA and fifo-size to ADMAIF we wont need that. Can you please
> confirm if my assumption is valid?

Let me see if I can clarify ...

1. The FIFO we are discussing here resides in the ADMAIF module which is
   a separate hardware block the ADMA (although the naming make this
   unclear).

2. The size of FIFO in the ADMAIF is configurable and it this is
   configured via the ADMAIF registers. This allows different channels
   to use different FIFO sizes. Think of this as a shared memory that is
   divided into n FIFOs shared between all channels.

3. The ADMA, not the ADMAIF, manages the flow to the FIFO and this is
   because the ADMAIF only tells the ADMA when a word has been
   read/written (depending on direction), the ADMAIF does not indicate
   if the FIFO is full, empty, etc. Hence, the ADMA needs to know the
   total FIFO size.

So the ADMA needs to know the FIFO size so that it does not overrun the
FIFO and we can also set a burst size (less than the total FIFO size)
indicating how many words to transfer at a time. Hence, the two parameters.

Even if we were to use some sort of router between the ADMA and ADMAIF,
the client still needs to indicate to the ADMA what FIFO size and burst
size, if I am following you correctly.

Let me know if this is clearer.

Thanks
Jon

-- 
nvpublic
