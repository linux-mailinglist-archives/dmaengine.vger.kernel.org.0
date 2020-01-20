Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4881427FE
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2020 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATKQJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 05:16:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38530 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgATKQJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jan 2020 05:16:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00KAFuIr042476;
        Mon, 20 Jan 2020 04:15:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579515356;
        bh=KyVH3zWSUl96d+3Kz0z4lRV0WTTLoc+PmB9suhnpFow=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qKnpHeZgN9POcSaW/sgFbaPIeo4qWTas1IGF1xF7QzpagKVbebC/8GWA+maeCHoP6
         hPqbriPqABeoroU/c2NUHgPoaSiaw/ONgCZC4PHVZu1C/p8LiRexu971bWe4o0aDAZ
         yx1SRhf2+tTseU1AKMRV3TP9UuuD41xrpHV9rfT4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00KAFumX047513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jan 2020 04:15:56 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 20
 Jan 2020 04:15:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 20 Jan 2020 04:15:55 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00KAFrRn010845;
        Mon, 20 Jan 2020 04:15:53 -0600
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
 <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
Date:   Mon, 20 Jan 2020 12:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 20/01/2020 11.01, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Fri, Jan 17, 2020 at 9:08 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
>>> Currently it is not easy to find out which DMA channels are in use, and
>>> which slave devices are using which channels.
>>>
>>> Fix this by creating two symlinks between the DMA channel and the actual
>>> slave device when a channel is requested:
>>>   1. A "slave" symlink from DMA channel to slave device,
>>
>> Have you considered similar link name as on the slave device:
>> slave:<name>
>>
>> That way it would be easier to grasp which channel is used for what
>> purpose by only looking under /sys/class/dma/ and no need to check the
>> slave device.
> 
> Would this really provide more information?
> The device name is already provided in the target of the symlink:
> 
> root@koelsch:~# readlink
> /sys/devices/platform/soc/e6720000.dma-controller/dma/dma1chan2/slave
> ../../../ee140000.sd

e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd

It is hard to tell which one is the tx and RX channel without looking
under the ee140000.sd:

ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2

Another option would be to not have symlinks, but a debugfs file where
this information can be extracted and would only compiled if debugfs is
enabled.

>>>   2. A "dma:<name>" symlink slave device to DMA channel.
>>> When the channel is released, the symlinks are removed again.
>>> The latter requires keeping track of the slave device and the channel
>>> name in the dma_chan structure.
>>>
>>> Note that this is limited to channel request functions for requesting an
>>> exclusive slave channel that take a device pointer (dma_request_chan()
>>> and dma_request_slave_channel*()).
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> v2:
>>>   - Add DMA_SLAVE_NAME macro,
>>>   - Also handle channels from FIXME,
>>>   - Add backlinks from slave device to DMA channel,
>>>
>>> On r8a7791/koelsch, the following new symlinks are created:
>>>
>>>     /sys/devices/platform/soc/
>>>     ├── e6700000.dma-controller/dma/dma0chan0/slave -> ../../../e6e20000.spi
>>>     ├── e6700000.dma-controller/dma/dma0chan1/slave -> ../../../e6e20000.spi
>>>     ├── e6700000.dma-controller/dma/dma0chan2/slave -> ../../../ee100000.sd
>>>     ├── e6700000.dma-controller/dma/dma0chan3/slave -> ../../../ee100000.sd
>>>     ├── e6700000.dma-controller/dma/dma0chan4/slave -> ../../../ee160000.sd
>>>     ├── e6700000.dma-controller/dma/dma0chan5/slave -> ../../../ee160000.sd
>>>     ├── e6700000.dma-controller/dma/dma0chan6/slave -> ../../../e6e68000.serial
>>>     ├── e6700000.dma-controller/dma/dma0chan7/slave -> ../../../e6e68000.serial
>>>     ├── e6720000.dma-controller/dma/dma1chan0/slave -> ../../../e6b10000.spi
>>>     ├── e6720000.dma-controller/dma/dma1chan1/slave -> ../../../e6b10000.spi
>>>     ├── e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
>>>     ├── e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
>>>     ├── e6b10000.spi/dma:rx -> ../e6720000.dma-controller/dma/dma1chan1
>>>     ├── e6b10000.spi/dma:tx -> ../e6720000.dma-controller/dma/dma1chan0
>>>     ├── e6e20000.spi/dma:rx -> ../e6700000.dma-controller/dma/dma0chan1
>>>     ├── e6e20000.spi/dma:tx -> ../e6700000.dma-controller/dma/dma0chan0
>>>     ├── e6e68000.serial/dma:rx -> ../e6700000.dma-controller/dma/dma0chan7
>>>     ├── e6e68000.serial/dma:tx -> ../e6700000.dma-controller/dma/dma0chan6
>>>     ├── ee100000.sd/dma:rx -> ../e6700000.dma-controller/dma/dma0chan3
>>>     ├── ee100000.sd/dma:tx -> ../e6700000.dma-controller/dma/dma0chan2
>>>     ├── ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
>>>     ├── ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2
>>>     ├── ee160000.sd/dma:rx -> ../e6700000.dma-controller/dma/dma0chan5
>>>     └── ee160000.sd/dma:tx -> ../e6700000.dma-controller/dma/dma0chan4
> 
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
