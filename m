Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A499520CB
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 04:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfFYC5p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 22:57:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7385 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbfFYC5p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 22:57:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d118da80000>; Mon, 24 Jun 2019 19:57:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Jun 2019 19:57:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Jun 2019 19:57:44 -0700
Received: from [10.24.70.239] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 02:57:32 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
Date:   Tue, 25 Jun 2019 08:27:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624062609.GV2962@vkoul-mobl>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561431464; bh=xP3JA1D905ACqmkL7EENVTky9EKv/D4sESxy0rNMrm0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TJXtb1kFMcDT0637MfairfavEY08XPVvepis7DEdDNmS++WdG2v8gLrIjtv5bbDmJ
         ooAo2eFTBmbhsGYxGfMHPTWieoL1lNJim8DBHGEmSqnJoomi2k85UzLAXm/SiZAa31
         Pj8tqbbDKp97v00DDWhUQI+UL6y8PPbwhsx8A4FdwCBS0NGl9mYNjtRoN+hqc0xLqu
         hBCmnIlq/OwuLXlk20z3155HJw2rVeYaR1NP/fiZje6KPjY5zZRYFVmS7y+akoeIfx
         JRGZXwI6n9SsRRIjfiDRLH2F50laHQy89kyAcDAImbDGfQp9u6iF/Zbb2WJE75MYKU
         80+ROc/qQR/cQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/24/2019 11:56 AM, Vinod Koul wrote:
> On 20-06-19, 15:59, Sameer Pujar wrote:
>
>>>>> So can you explain me what is the difference here that the peripheral
>>>>> cannot configure and use burst size with passing fifo depth?
>>>> Say for example FIFO_THRESHOLD is programmed as 16 WORDS, BURST_SIZE as 8
>>>> WORDS.
>>>> ADMAIF does not push data to AHUB(operation [2]) till threshold of 16 WORDS
>>>> is
>>>> reached in ADMAIF FIFO. Hence 2 burst transfers are needed to reach the
>>>> threshold.
>>>> As mentioned earlier, threshold here is to just indicate when data transfer
>>>> can happen
>>>> to AHUB modules.
>>> So we have ADMA and AHUB and peripheral. You are talking to AHUB and that
>>> is _not_ peripheral and if I have guess right the fifo depth is for AHUB
>>> right?
>> Yes the communication is between ADMA and AHUB. ADMAIF is the interface
>> between
>> ADMA and AHUB. ADMA channel sending data to AHUB pairs with ADMAIF TX
>> channel.
>> Similary ADMA channel receiving data from AHUB pairs with ADMAIF RX channel.
>> FIFO DEPTH we are talking is about each ADMAIF TX/RX channel and it is
>> configurable.
>> DMA transfers happen to/from ADMAIF FIFOs and whenever data(per WORD) is
>> popped/pushed
>> out of ADMAIF to/from AHUB, asseration is made to ADMA. ADMA keeps counters
>> based on
>> these assertions. By knowing FIFO DEPTH and these counters, ADMA knows when
>> to wait or
>> when to transfer data.
> Where does ADMAIF driver reside in kernel, who configures it for normal
> dma txns..?
Not yet, we are in the process of upstreaming ADMAIF driver.
To describe briefly, audio subsystem is using ALSA SoC(ASoC) layer. 
ADMAIF is
registered as platform driver and exports DMA functionality. It 
registers PCM
devices for each Rx/Tx ADMAIF channel. During PCM playback/capture 
operations,
ALSA callbacks configure DMA channel using API dmaengine_slave_config().
RFC patch proposed, is to help populate FIFO_SIZE value as well during above
call, since ADMA requires it.
>
> Also it wold have helped the long discussion if that part was made clear
> rather than talking about peripheral all this time :(
Thought it was clear, though should have avoided using 'peripheral' in the
discussions. Sorry for the confusion.
