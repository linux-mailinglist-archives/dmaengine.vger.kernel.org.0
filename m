Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA5387E7
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfFGK1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 06:27:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13992 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfFGK1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 06:27:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfa3c180000>; Fri, 07 Jun 2019 03:27:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 03:27:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 03:27:36 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 10:27:34 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <d0db90e3-3d05-dfba-8768-28511d9ee3ac@ti.com>
 <5208a50a-9ca0-8f24-9ad0-d7503ec53f1c@nvidia.com>
Message-ID: <ba845a19-5dfb-a891-719f-43821b2dd412@nvidia.com>
Date:   Fri, 7 Jun 2019 11:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5208a50a-9ca0-8f24-9ad0-d7503ec53f1c@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559903256; bh=1B5CpjPC8JaWeI3jt4KOqjBgU+AR19dwA4hAG3dk/ww=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AKyxjzrUO2oB6BGaYLhBPydo3qXBb10pN6JZ1wsQR7sqIOwsPr9U9SO3W9yBXPUVs
         OTxrL1wqE2NoXu9CtAw6zwjFhNbw2a0jd7yEqeo891kzbfypHjjD5K4dBeC/4U+vCb
         cvd7Z0VEOUpjkrRzmgVqMOuMbh5FxL1lVCN8l07fJDHiOxak9LtXZHnseAhFPjf2+b
         YS3qSEqOT1Y04u+O3deni2OBbMb6XCXSJyfAnWdKlsUt3aMsPlERHWG5Rcihqfs778
         R/pfX/U6rZB3eQb16O3S3hM3tBPkoO0xtoBAbu2Nl7g6wXY+ydTJFmGaSglB/TAadv
         ohnYPSLKF5K6w==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 07/06/2019 10:18, Jon Hunter wrote:
> 
> On 07/06/2019 06:50, Peter Ujfalusi wrote:
>> Jon,
>>
>> On 06/06/2019 15.37, Jon Hunter wrote:
>>>> Looking at the drivers/dma/tegra210-adma.c for the
>>>> TEGRA*_FIFO_CTRL_DEFAULT definition it is still not clear where the
>>>> remote FIFO size would fit.
>>>> There are fields for overflow and starvation(?) thresholds and TX/RX
>>>> size (assuming word length, 3 == 32bits?).
>>>
>>> The TX/RX size are the FIFO size. So 3 equates to a FIFO size of 3 * 64
>>> bytes.
>>>
>>>> Both threshold is set to one, so I assume currently ADMA is
>>>> pushing/pulling data word by word.
>>>
>>> That's different. That indicates thresholds when transfers start.
>>>
>>>> Not sure what the burst size is used for, my guess would be that it is
>>>> used on the memory (DDR) side for optimized, more efficient accesses?
>>>
>>> That is the actual burst size.
>>>
>>>> My guess is that the threshold values are the counter limits, if the DMA
>>>> request counter reaches it then ADMA would do a threshold limit worth of
>>>> push/pull to ADMAIF.
>>>> Or there is another register where the remote FIFO size can be written
>>>> and ADMA is counting back from there until it reaches the threshold (and
>>>> pushes/pulling again threshold amount of data) so it keeps the FIFO
>>>> filled with at least threshold amount of data?
>>>>
>>>> I think in both cases the threshold would be the maxburst.
>>>>
>>>> I suppose you have the patch for adma on how to use the fifo_size
>>>> parameter? That would help understand what you are trying to achieve better.
>>>
>>> Its quite simple, we would just use the FIFO size to set the fields
>>> TEGRAXXX_ADMA_CH_FIFO_CTRL_TXSIZE/RXSIZE in the
>>> TEGRAXXX_ADMA_CH_FIFO_CTRL register. That's all.
>>
>> Hrm, it is still not clear how all of these fits together.
>>
>> What happens if you configure ADMA side:
>> BURST = 10
>> TX/RXSIZE = 100 (100 * 64 bytes?) /* FIFO_SIZE? */
>> *THRES = 5
>>
>> And if you change the *THRES to 10?
>> And if you change the TX/RXSIZE to 50 (50 * 64 bytes?)
>> And if you change the BURST to 5?
>>
>> In other words what is the relation between all of these?
> 
> So the THRES values are only applicable when the FETCHING_POLICY (bit 31
> of the CH_FIFO_CTRL) is set. The FETCHING_POLICY bit defines two modes;
> a threshold based transfer mode or a burst based transfer mode. The
> burst mode transfer data as and when there is room for a burst in the FIFO.
> 
> We use the burst mode and so we really should not be setting the THRES
> fields as they are not applicable. Oh well something else to correct,
> but this is side issue.
> 
>> There must be a rule and constraints around these and if we do really
>> need a new parameter for ADMA's FIFO_SIZE I'd like it to be defined in a
>> generic way so others could benefit without 'misusing' a fifo_size
>> parameter for similar, but not quite fifo_size information.
> 
> Yes I see what you are saying. One option would be to define both a
> src/dst_maxburst and src/dst_minburst size. Then we could use max for
> the FIFO size and min for the actual burst size.

Actually, we don't even need to do that. We only use src_maxburst for
DEV_TO_MEM and dst_maxburst for MEM_TO_DEV. I don't see any reason why
we could not use both the src_maxburst for dst_maxburst for both
DEV_TO_MEM and MEM_TO_DEV, where one represents the FIFO size and one
represents that DMA burst size.

Sorry should have thought of that before. Any objections to using these
this way? Obviously we would document is clearly in the driver.

Cheers
Jon

-- 
nvpublic
