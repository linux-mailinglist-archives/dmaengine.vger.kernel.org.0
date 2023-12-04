Return-Path: <dmaengine+bounces-357-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE3802D11
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 09:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D137E280E15
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE479DDAE;
	Mon,  4 Dec 2023 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ta01uNa1"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B64FE;
	Mon,  4 Dec 2023 00:21:22 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B48LBJQ017952;
	Mon, 4 Dec 2023 02:21:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701678071;
	bh=SrzSEbF1L6Dn1jONiUv1v2MfL73aErTwA8r7OAfU4VE=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=Ta01uNa1P3zno6fimrDN67MrrxU99UqHFioBL9XHLtKkSwLzwYUpTi30VzptqX4TM
	 LjpVHCgBa61kpjeccUJ8mTF2Xi/NRITIatPx5aYyjWZfkWVs3x+lPK7fnlT4r1uiWr
	 QWJbkkKTyhl1H2nE3c2NkT9+UHRa9hPAUaxI3Vu8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B48LB40081234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Dec 2023 02:21:11 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 02:21:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 02:21:10 -0600
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B48L81p021380;
	Mon, 4 Dec 2023 02:21:08 -0600
Message-ID: <a4ca48fb-2e87-494a-bc71-8970d7f8c6a0@ti.com>
Date: Mon, 4 Dec 2023 13:51:07 +0530
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
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ed1d0221-d0ee-4a7d-8955-d5973027d113@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Péter,

On 22/11/23 20:52, Péter Ujfalusi wrote:
> Hi Siddharth,
> 
> On 17/11/2023 07:55, Siddharth Vadapalli wrote:
>>> I would really like to follow a standard binding since what will happen
>>> if the firmware will start to provision channels/flows for DMAengine
>>> users? It is not that simple to hack that around.
>>
>> Please consider the following use-case for which the APIs are being added by
>> this series. I apologize for not explaining the idea behind the APIs in more
>> detail earlier.
>>
>> Firmware running on a remote core is in control of a peripheral (CPSW Ethernet
>> Switch for example) and shares the peripheral across software running on
>> different cores. The control path between the Firmware and the Clients on
>> various cores is via RPMsg, while the data path used by the Clients is the DMA
>> Channels. In the example where Clients send data to the shared peripheral over
>> DMA, the Clients send RPMsg based requests to the Firmware to obtain the
>> allocated thead IDs. Firmware allocates the thread IDs by making a request to
>> TISCI Resource Manager followed by sharing the thread IDs to the Clients.
>>
>> In such use cases, the Linux Client is probed by RPMsg endpoint discovery over
>> the RPMsg bus. Therefore, there is no device-tree corresponding to the Client
>> device. The Client knows the DMA Channel IDs as well as the RX Flow details from
>> the Firmware. Knowing these details, the Client can request the configuration of
>> the TX and RX Channels/Flows by using the DMA APIs which this series adds.
> 
> I see, so the CPSW will be probed in a similar way as USB peripherals
> for example? The CPSW does not have a DT entry at all? Is this correct?

I apologize for the delayed response. Yes, the CPSW instance which shall be in
control of Firmware running on the remote core will not have a DT entry. The
Linux Client driver shall be probed when the Firmware announces its endpoint
over the RPMsg bus, which the Client driver shall register with the RPMsg framework.

> 
>> Please let me know in case of any suggestions for an implementation which shall
>> address the above use-case.
> 
> How does the driver knows how to request a DMA resource from the remote
> core? How that scales with different SoCs and even with changes in the
> firmware?

After getting probed, the Client driver communicates with Firmware via RPMsg,
requesting details of the allocated resources including the TX Channels and RX
Flows. Knowing these parameters, the Client driver can use the newly added DMA
APIs to request TX Channel and RX Flows by IDs. The only dependency here is that
the Client driver needs to know which DMA instance to request these resources
from. That information is hard coded in the driver's data in the form of the
compatible used for the DMA instance, thereby allowing the Client driver to get
a reference to the DMA controller node using the of_find_compatible_node() API.

Since all the resource allocation information comes from Firmware, the
device-specific details will be hard coded in the Firmware while the Client
driver can be used across all K3 SoCs which have the same DMA APIs.

> 
> You are right, this is in a grey area. The DMA channel as it is
> controlled by the remote processor, it lends a thread to clients on
> other cores (like Linux) via RPMsg.
> Well, it is similar to how non DT is working in a way.
> 
> This CPSW type is not yet supported mainline, right?

Yes, it is not yet supported in mainline. This series is a dependency for
upstreaming the Client driver.

-- 
Regards,
Siddharth.

