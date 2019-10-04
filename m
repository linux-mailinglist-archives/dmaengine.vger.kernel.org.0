Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 496CDCBFD1
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2019 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390059AbfJDPzg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Oct 2019 11:55:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60232 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390031AbfJDPzg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Oct 2019 11:55:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94FtW3e129925;
        Fri, 4 Oct 2019 10:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570204532;
        bh=8o3L4d0zeiEjLNY0+eUZ842h+8xCJbslZYAJnvNjuNE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vRvPnVDWR6OHu1+/fQsmfkvAY1eTuPVgUbm0F9kw1PTTxlw4nAA5N1bSD5iv6mUks
         uYvuiPddCPQXPKC2dlEtLI+FHpEGNzm7hoDWVl1EKKmZN4zS4NrIpX37g6Z0i26yxs
         TYgaUkJYdfNLyH5/zRfUpS12WQyLWou0XYs8zSlo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x94FtW35014479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Oct 2019 10:55:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 10:55:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 10:55:29 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94FtRG2110014;
        Fri, 4 Oct 2019 10:55:28 -0500
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add documentation for DMA domains
To:     Rob Herring <robh@kernel.org>
CC:     Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190910115037.23539-1-peter.ujfalusi@ti.com>
 <20190910115037.23539-2-peter.ujfalusi@ti.com>
 <5d7ba96c.1c69fb81.ee467.32b9@mx.google.com>
 <82254a3e-12fe-14d8-d49a-6627dd1d3559@ti.com>
 <CAL_JsqLZ-fNvFcgTorat=TX9Fmexrw3o3iv=Z5hTb3GX6iKgxg@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ad639d6a-a9d7-7797-310f-dc314600b52a@ti.com>
Date:   Fri, 4 Oct 2019 18:56:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLZ-fNvFcgTorat=TX9Fmexrw3o3iv=Z5hTb3GX6iKgxg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/24/19 5:44 PM, Rob Herring wrote:
> On Mon, Sep 16, 2019 at 6:21 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>
>>
>>
>> On 13/09/2019 17.36, Rob Herring wrote:
>>> On Tue, Sep 10, 2019 at 02:50:35PM +0300, Peter Ujfalusi wrote:
>>>> On systems where multiple DMA controllers available, non Slave (for example
>>>> memcpy operation) users can not be described in DT as there is no device
>>>> involved from the DMA controller's point of view, DMA binding is not usable.
>>>> However in these systems still a peripheral might need to be serviced by or
>>>> it is better to serviced by specific DMA controller.
>>>> When a memcpy is used to/from a memory mapped region for example a DMA in the
>>>> same domain can perform better.
>>>> For generic software modules doing mem 2 mem operations it also matter that
>>>> they will get a channel from a controller which is faster in DDR to DDR mode
>>>> rather then from the first controller happen to be loaded.
>>>>
>>>> This property is inherited, so it may be specified in a device node or in any
>>>> of its parent nodes.
>>>
>>> If a device needs mem2mem dma, I think we should just use the existing
>>> dma binding. The provider will need a way to define cell values which
>>> mean mem2mem.
>>
>> But isn't it going to be an abuse of the binding? Each DMA controller
>> would hack this in different ways, probably using out of range DMA
>> request/trigger number or if they have direction in the binding or some
>> other parameter would be set to something invalid...
> 
> What's in the cells is defined by the provider which can define
> whatever they want. We do standardize that in some cases.

There is a substantiation difference how HW synchronized (slave)
channels and SW triggered (non slave) channels can be described, handled.

For slave channels we have bindings as we can describe the DMA request
line to be used for the DMA channel. In some cases the requests are
locked to DMA channels (TI's EDMA for example), while in other cases any
channel can handle any operation (TI's sDMA, UDMAP).
For EDMA the DMA request == EDMA channel number
For sDMA we give the DMA request number and we pick any free lchan to
handle it.

Non slave channels on the other hand have no identification. They are
channels which can execute SW triggered task.
For EDMA for example we need to mark channels which is not in use and
tell the system that they can be used for non slave mode.
sDMA on the other hand can just pick any free lchan.

Passing 0xffffffff as channel number or DMA request number surely be
something which most likely invalid, but every driver needs to somehow
figure out their invalid parameter and all of them needs to be modified,
generic match helpers can not be used anymore as they will fail in
random ways.

> I think we have some cases where we set the channel priority in the
> cells. What if someone wants to do that for mem2mem as well?

That's a valid point, but even with bindings for non slave channels
clients from modules will need to be handled in a different way as they
don't have presence in DT..
But I would argue that from system point of view the non slave channels
might be better to have the same priority as a group on the given
controller.

> 
>>> For generic s/w, it should be able to query the dma speed or get a
>>> preferred one IMO. It's not a DT problem.
>>>
>>> We measure memcpy speeds at boot time to select the fastest
>>> implementation for a chip, why not do that for mem2mem DMA?
>>
>> It would make an impact on boot time since the tests would need to be
>> done with a large enough copy to be able to see clearly which one is faster.
> 
> Have you measured it? It could be done in parallel and may have little
> to no impact.

Depends on the DMA controller, but for UDMAP I can say it is around 1M
buffer which clearly tells apart the two DMAs.

Still, we should delay all non slave user's probe until we have all
information on all of them and we don't know how many DMAs the HW have.

How can you know that after the testing the first DMA's speed you will
not have another one probing? Or after the second DMA controller there
could be a third coming which can be the fastest?

>> Also we should be able to handle different probing orders:
>> client1 should have mem2mem channel from dma2.
>>
>> - dma1 probes
>> - client1 probes and asks for a mem2mem channel
>> - dma2 probes
>>
>> Here client1 should deffer until dma2 is probed.
> 
> Depending on the driver, don't make the decision in probe, but when
> you start using the driver. For example, serial drivers decide on DMA
> or no DMA in open().

Which is causing a lot of pain as serial is really broken for deferred
probing against DMA.
Also note that dma channel request/release is not 'free' it might be
something which can take time, thus making DMA use for non slave
transfers less tempting.

With adding dma-nonslave-domain (third or fourth name for this?) none of
the DMA drivers have to be modified, the change in core is relatively
small and backwards compatible and it describes the HW.

> 
>> Probably the property should be dma-mem2mem-domain to be more precise on
>> it's purpose and avoid confusion?
>>
>>>
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/dma/dma-domain.yaml   | 88 +++++++++++++++++++
>>>>  1 file changed, 88 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml
>>>
>>> Note that you have several errors in your schema. Run 'make dt_bindings_check'.
>>
>> That does not do anything on my system, but git dt-doc-validate running
>> via https://github.com/robherring/yaml-bindings.git.
> 
> It should do *something*... Do you have libyaml-dev installed?
> 
> BTW, while I still mirror to that repo, use
> https://github.com/devicetree-org/dt-schema instead.

Thanks a lot, got it working now correctly, I belive.

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
