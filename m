Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E3F6EFD
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 08:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKKHXF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 02:23:05 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42950 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfKKHXF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 02:23:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB7Mo9H020255;
        Mon, 11 Nov 2019 01:22:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573456970;
        bh=ARjva5ASHxGvNYQYfpbT0ZrbsWnn8VD961j4MKSYmaA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RceyAqmcB8REiupGn3XULgm076zDGv2sdj5PuU1MR6m6D3yUXswJzj/QkorZEv6j7
         gQoN4SkRYl0IQetYDlzmd1J4k4aCqT0PLqDSSirKRMWjyKMAfZnG2464vzuGRMAS/p
         ekblp5gq32pBxbQewAwziaYcerO46tWp490grLRA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB7Mor9123768;
        Mon, 11 Nov 2019 01:22:50 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 01:22:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 01:22:47 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB7MidJ062267;
        Mon, 11 Nov 2019 01:22:45 -0600
Subject: Re: [PATCH v4 01/15] bindings: soc: ti: add documentation for k3
 ringacc
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-2-peter.ujfalusi@ti.com>
 <20191111040747.GJ952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0cf34ab7-97cf-06e5-b8cb-50a0846a8b97@ti.com>
Date:   Mon, 11 Nov 2019 09:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111040747.GJ952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 6.07, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
>> enable straightforward passing of work between a producer and a consumer.
>> There is one RINGACC module per NAVSS on TI AM65x and j721e.
>>
>> This patch introduces RINGACC device tree bindings.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../devicetree/bindings/soc/ti/k3-ringacc.txt | 59 +++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
>> new file mode 100644
>> index 000000000000..86954cf4fa99
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
>> @@ -0,0 +1,59 @@
>> +* Texas Instruments K3 NavigatorSS Ring Accelerator
>> +
>> +The Ring Accelerator (RA) is a machine which converts read/write accesses
>> +from/to a constant address into corresponding read/write accesses from/to a
>> +circular data structure in memory. The RA eliminates the need for each DMA
>> +controller which needs to access ring elements from having to know the current
>> +state of the ring (base address, current offset). The DMA controller
>> +performs a read or write access to a specific address range (which maps to the
>> +source interface on the RA) and the RA replaces the address for the transaction
>> +with a new address which corresponds to the head or tail element of the ring
>> +(head for reads, tail for writes).
>> +
>> +The Ring Accelerator is a hardware module that is responsible for accelerating
>> +management of the packet queues. The K3 SoCs can have more than one RA instances
>> +
>> +Required properties:
>> +- compatible	: Must be "ti,am654-navss-ringacc";
>> +- reg		: Should contain register location and length of the following
>> +		  named register regions.
>> +- reg-names	: should be
>> +		  "rt" - The RA Ring Real-time Control/Status Registers
>> +		  "fifos" - The RA Queues Registers
>> +		  "proxy_gcfg" - The RA Proxy Global Config Registers
>> +		  "proxy_target" - The RA Proxy Datapath Registers
>> +- ti,num-rings	: Number of rings supported by RA
>> +- ti,sci-rm-range-gp-rings : TI-SCI RM subtype for GP ring range
>> +- ti,sci	: phandle on TI-SCI compatible System controller node
>> +- ti,sci-dev-id	: TI-SCI device id
>> +- msi-parent	: phandle for "ti,sci-inta" interrupt controller
>> +
>> +Optional properties:
>> + -- ti,dma-ring-reset-quirk : enable ringacc / udma ring state interoperability
>> +		  issue software w/a
>> +
>> +Example:
>> +
>> +ringacc: ringacc@3c000000 {
>> +	compatible = "ti,am654-navss-ringacc";
>> +	reg =	<0x0 0x3c000000 0x0 0x400000>,
>> +		<0x0 0x38000000 0x0 0x400000>,
>> +		<0x0 0x31120000 0x0 0x100>,
>> +		<0x0 0x33000000 0x0 0x40000>;
>> +	reg-names = "rt", "fifos",
>> +		    "proxy_gcfg", "proxy_target";
>> +	ti,num-rings = <818>;
>> +	ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
>> +	ti,dma-ring-reset-quirk;
>> +	ti,sci = <&dmsc>;
>> +	ti,sci-dev-id = <187>;
> 
> why do we need dev-id for? doesn't phandle the line above help?

the ti,sci-dev-id is the device ID of the ring accelerator which is
needed for the resource management implemented in sysfw.

This is based on how the ti,sci-inta binding has defined it:
Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt

I'll update the document to make it clear.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
