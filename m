Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959E4384AC
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFGHBz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 03:01:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45988 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfFGHBz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 03:01:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x575ngl4006282;
        Fri, 7 Jun 2019 00:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559886582;
        bh=MEagnH+kxa/s49pg8767gTrJDW79F25A6Ljg2yywMAM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f4Y/Z1dOPufN9GWrG/ITdjZw+4v5bZsUm/7AJAaIo619OzOzhBVvcN2odiJZm8sY/
         QhrE2jn/CsinbMhp47a42n+xS1VDzkj/LadgxyoESHMLtVVWawgGCc9g1lp1btvZMu
         AvSg8JmBOvuHak6DBMnRTm/uQHH/BuYO8hnw4dbE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x575ngto024423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jun 2019 00:49:42 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 7 Jun
 2019 00:49:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 7 Jun 2019 00:49:42 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x575ndR3104523;
        Fri, 7 Jun 2019 00:49:40 -0500
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Jon Hunter <jonathanh@nvidia.com>,
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d0db90e3-3d05-dfba-8768-28511d9ee3ac@ti.com>
Date:   Fri, 7 Jun 2019 08:50:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Jon,

On 06/06/2019 15.37, Jon Hunter wrote:
>> Looking at the drivers/dma/tegra210-adma.c for the
>> TEGRA*_FIFO_CTRL_DEFAULT definition it is still not clear where the
>> remote FIFO size would fit.
>> There are fields for overflow and starvation(?) thresholds and TX/RX
>> size (assuming word length, 3 == 32bits?).
> 
> The TX/RX size are the FIFO size. So 3 equates to a FIFO size of 3 * 64
> bytes.
> 
>> Both threshold is set to one, so I assume currently ADMA is
>> pushing/pulling data word by word.
> 
> That's different. That indicates thresholds when transfers start.
> 
>> Not sure what the burst size is used for, my guess would be that it is
>> used on the memory (DDR) side for optimized, more efficient accesses?
> 
> That is the actual burst size.
> 
>> My guess is that the threshold values are the counter limits, if the DMA
>> request counter reaches it then ADMA would do a threshold limit worth of
>> push/pull to ADMAIF.
>> Or there is another register where the remote FIFO size can be written
>> and ADMA is counting back from there until it reaches the threshold (and
>> pushes/pulling again threshold amount of data) so it keeps the FIFO
>> filled with at least threshold amount of data?
>>
>> I think in both cases the threshold would be the maxburst.
>>
>> I suppose you have the patch for adma on how to use the fifo_size
>> parameter? That would help understand what you are trying to achieve better.
> 
> Its quite simple, we would just use the FIFO size to set the fields
> TEGRAXXX_ADMA_CH_FIFO_CTRL_TXSIZE/RXSIZE in the
> TEGRAXXX_ADMA_CH_FIFO_CTRL register. That's all.

Hrm, it is still not clear how all of these fits together.

What happens if you configure ADMA side:
BURST = 10
TX/RXSIZE = 100 (100 * 64 bytes?) /* FIFO_SIZE? */
*THRES = 5

And if you change the *THRES to 10?
And if you change the TX/RXSIZE to 50 (50 * 64 bytes?)
And if you change the BURST to 5?

In other words what is the relation between all of these?

There must be a rule and constraints around these and if we do really
need a new parameter for ADMA's FIFO_SIZE I'd like it to be defined in a
generic way so others could benefit without 'misusing' a fifo_size
parameter for similar, but not quite fifo_size information.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
