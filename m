Return-Path: <dmaengine+bounces-434-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDA80C3D5
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 10:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31F51F20FA9
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE171210E3;
	Mon, 11 Dec 2023 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v4biwjQq"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2AAF2;
	Mon, 11 Dec 2023 01:00:38 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BB90PYY053914;
	Mon, 11 Dec 2023 03:00:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702285225;
	bh=fes+2jdnu+cwIMijeZdTMvzhl1D0uYB5n4UdqPCiFzA=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=v4biwjQqh4yHk+hxF5kuE9O9FLHdyyIWt0w28StEmAc2FDOvIEL8CR/6On0YqXbIy
	 o4HucvSfagdygapccICe6/WquECjS3an7Lm9ZBlQahKRbBDdZ7HrimRrwE3OzvnODo
	 R+5g1UcJYWNYNNIMF+HeLvw8nmpCzT/IWCh86DfE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BB90PEe010336
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Dec 2023 03:00:25 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 03:00:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 03:00:25 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BB90M8N004370;
	Mon, 11 Dec 2023 03:00:23 -0600
Message-ID: <08e04ee2-b6e7-4da6-87f4-6d111dc25286@ti.com>
Date: Mon, 11 Dec 2023 14:30:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/4] Add APIs to request TX/RX DMA channels by ID
Content-Language: en-US
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
References: <20231114083906.3143548-1-s-vadapalli@ti.com>
 <9d465de4-3930-4856-9d8e-7deb567a628f@gmail.com>
 <c693efec-ab67-44bb-8871-a40dc408f278@ti.com>
 <ed1d0221-d0ee-4a7d-8955-d5973027d113@gmail.com>
 <a4ca48fb-2e87-494a-bc71-8970d7f8c6a0@ti.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <a4ca48fb-2e87-494a-bc71-8970d7f8c6a0@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

If there are no concerns, may I post the v2 of this series, rebasing it on the
latest linux-next tree with minor code cleanup and reordering of the patches?

On 04/12/23 13:51, Siddharth Vadapalli wrote:
> Hello Péter,
> 
> On 22/11/23 20:52, Péter Ujfalusi wrote:
>> Hi Siddharth,
>>
>> On 17/11/2023 07:55, Siddharth Vadapalli wrote:
>>>> I would really like to follow a standard binding since what will happen
>>>> if the firmware will start to provision channels/flows for DMAengine
>>>> users? It is not that simple to hack that around.
>>>
>>> Please consider the following use-case for which the APIs are being added by
>>> this series. I apologize for not explaining the idea behind the APIs in more
>>> detail earlier.
>>>
>>> Firmware running on a remote core is in control of a peripheral (CPSW Ethernet
>>> Switch for example) and shares the peripheral across software running on
>>> different cores. The control path between the Firmware and the Clients on
>>> various cores is via RPMsg, while the data path used by the Clients is the DMA
>>> Channels. In the example where Clients send data to the shared peripheral over
>>> DMA, the Clients send RPMsg based requests to the Firmware to obtain the
>>> allocated thead IDs. Firmware allocates the thread IDs by making a request to
>>> TISCI Resource Manager followed by sharing the thread IDs to the Clients.
>>>
>>> In such use cases, the Linux Client is probed by RPMsg endpoint discovery over
>>> the RPMsg bus. Therefore, there is no device-tree corresponding to the Client
>>> device. The Client knows the DMA Channel IDs as well as the RX Flow details from
>>> the Firmware. Knowing these details, the Client can request the configuration of
>>> the TX and RX Channels/Flows by using the DMA APIs which this series adds.
>>
>> I see, so the CPSW will be probed in a similar way as USB peripherals
>> for example? The CPSW does not have a DT entry at all? Is this correct?
> 
> I apologize for the delayed response. Yes, the CPSW instance which shall be in
> control of Firmware running on the remote core will not have a DT entry. The
> Linux Client driver shall be probed when the Firmware announces its endpoint
> over the RPMsg bus, which the Client driver shall register with the RPMsg framework.
> 
>>
>>> Please let me know in case of any suggestions for an implementation which shall
>>> address the above use-case.
>>
>> How does the driver knows how to request a DMA resource from the remote
>> core? How that scales with different SoCs and even with changes in the
>> firmware?
> 
> After getting probed, the Client driver communicates with Firmware via RPMsg,
> requesting details of the allocated resources including the TX Channels and RX
> Flows. Knowing these parameters, the Client driver can use the newly added DMA
> APIs to request TX Channel and RX Flows by IDs. The only dependency here is that
> the Client driver needs to know which DMA instance to request these resources
> from. That information is hard coded in the driver's data in the form of the
> compatible used for the DMA instance, thereby allowing the Client driver to get
> a reference to the DMA controller node using the of_find_compatible_node() API.
> 
> Since all the resource allocation information comes from Firmware, the
> device-specific details will be hard coded in the Firmware while the Client
> driver can be used across all K3 SoCs which have the same DMA APIs.
> 
>>
>> You are right, this is in a grey area. The DMA channel as it is
>> controlled by the remote processor, it lends a thread to clients on
>> other cores (like Linux) via RPMsg.
>> Well, it is similar to how non DT is working in a way.
>>
>> This CPSW type is not yet supported mainline, right?
> 
> Yes, it is not yet supported in mainline. This series is a dependency for
> upstreaming the Client driver.
> 

-- 
Regards,
Siddharth.

