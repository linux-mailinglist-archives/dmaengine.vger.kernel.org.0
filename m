Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0217571173
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2019 07:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfGWFyW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jul 2019 01:54:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4973 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfGWFyW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Jul 2019 01:54:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d36a1140000>; Mon, 22 Jul 2019 22:54:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jul 2019 22:54:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Jul 2019 22:54:21 -0700
Received: from [10.25.75.182] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 05:54:17 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
Date:   Tue, 23 Jul 2019 11:24:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719050459.GM12733@vkoul-mobl.Dlink>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563861268; bh=8xq0wCElAdE83j3AEhbbxZ1vF+Jl8EYfm063kTQk/DE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=hdYJt7hp+LK8bd1qGaqHIFRTwa+ljpwAyvYRTWhvjbiBjcgT7P9ewFTi+I+W8UnjE
         TkXAbmkyw//nwrOctupwST8uIiDZPXhBQOhb6841WmiqQOnlBSFI6KdKCpi0i7Eowc
         uVNrtA+wUXLzm708qn3MttDraeA1YC3WRnOdbh1mtEo2++CLMAyGNI8C+yhJH7gVsH
         Iu2IuRiwRBn3JvhbwQFNsczJ7zhG4e6WQelWyK0qmwKwbG025PGI2RfgvJ+2hLOdHs
         ILclJrVWLv4PcppOYJr3K5/Dd0uA9vKz+BqSWL5g/DxFck7X47jriWwtRHVhDSYbiR
         jhWZNX4500q3A==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 7/19/2019 10:34 AM, Vinod Koul wrote:
> On 05-07-19, 11:45, Sameer Pujar wrote:
>> Hi Vinod,
>>
>> What are your final thoughts regarding this?
> Hi sameer,
>
> Sorry for the delay in replying
>
> On this, I am inclined to think that dma driver should not be involved.
> The ADMAIF needs this configuration and we should take the path of
> dma_router for this piece and add features like this to it

Hi Vinod,

The configuration is needed by both ADMA and ADMAIF. The size is 
configurable
on ADMAIF side. ADMA needs to know this info and program accordingly.
Not sure if dma_router can help to achieve this.

I checked on dma_router. It would have been useful when a configuration 
exported
via ADMA, had to be applied to ADMAIF. Please correct me if I am wrong here.

>> Thanks,
>> Sameer.
>>
>>>> Where does ADMAIF driver reside in kernel, who configures it for normal
>>>> dma txns..?
>>> Not yet, we are in the process of upstreaming ADMAIF driver.
>>> To describe briefly, audio subsystem is using ALSA SoC(ASoC) layer.
>>> ADMAIF is
>>> registered as platform driver and exports DMA functionality. It
>>> registers PCM
>>> devices for each Rx/Tx ADMAIF channel. During PCM playback/capture
>>> operations,
>>> ALSA callbacks configure DMA channel using API dmaengine_slave_config().
>>> RFC patch proposed, is to help populate FIFO_SIZE value as well during
>>> above
>>> call, since ADMA requires it.
>>>> Also it wold have helped the long discussion if that part was made clear
>>>> rather than talking about peripheral all this time :(
>>> Thought it was clear, though should have avoided using 'peripheral' in
>>> the
>>> discussions. Sorry for the confusion.
