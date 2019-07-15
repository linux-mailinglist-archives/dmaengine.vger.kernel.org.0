Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743046987A
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jul 2019 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfGOPnT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Jul 2019 11:43:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10979 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfGOPnT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Jul 2019 11:43:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2c9f140000>; Mon, 15 Jul 2019 08:43:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Jul 2019 08:43:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Jul 2019 08:43:18 -0700
Received: from [10.25.75.158] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Jul
 2019 15:43:15 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
From:   Sameer Pujar <spujar@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
Message-ID: <1ba33e86-5c4d-7bce-5643-c0fca2cf8101@nvidia.com>
Date:   Mon, 15 Jul 2019 21:12:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563205396; bh=b6MucdzZMF78Ie3I9PWKZ0HNIZR7xt7xMQPTn+iKXQY=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=QAHGs5pUGMKAjhmaqwqHXf7/jIUlwGS2q+9eKrVcGfLan1zbdmIic1ngMIVFWreTS
         2+WwDy241YJSIxAdgKlDo5DHIdG4TtsqD/NK1WNLTBesnoAIbLijK9CkpuZRwhE9+E
         yJn20tY4ygs9W7rUGftrC5DbX39g18MGKzhYtra5F/kbvgDag3p8shSX4c/3TcQW83
         CVjfO3KdJmR9w7hH7aslfR0mxgAP7jD+CHqVmaFMzg7y1sjvhbxCj4DPYyinBFGtWz
         QfaT24NaMjUxF4bP0JhzIDg9tME62b6w54ai9p+IzqtO0y2gBgQ7EYVhyDTWrKt/rY
         mhbOmLZmBBkog==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Sorry for writing again.
Can we please conclude on this?

Thanks,
Sameer.

On 7/5/2019 11:45 AM, Sameer Pujar wrote:
> Hi Vinod,
>
> What are your final thoughts regarding this?
>
> Thanks,
> Sameer.
>
>>> Where does ADMAIF driver reside in kernel, who configures it for normal
>>> dma txns..?
>> Not yet, we are in the process of upstreaming ADMAIF driver.
>> To describe briefly, audio subsystem is using ALSA SoC(ASoC) layer. 
>> ADMAIF is
>> registered as platform driver and exports DMA functionality. It 
>> registers PCM
>> devices for each Rx/Tx ADMAIF channel. During PCM playback/capture 
>> operations,
>> ALSA callbacks configure DMA channel using API dmaengine_slave_config().
>> RFC patch proposed, is to help populate FIFO_SIZE value as well 
>> during above
>> call, since ADMA requires it.
>>>
>>> Also it wold have helped the long discussion if that part was made 
>>> clear
>>> rather than talking about peripheral all this time :(
>> Thought it was clear, though should have avoided using 'peripheral' 
>> in the
>> discussions. Sorry for the confusion.
>
