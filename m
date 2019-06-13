Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85D44DA8
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFMUkm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 16:40:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57582 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfFMUkm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jun 2019 16:40:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5DKeUoq096121;
        Thu, 13 Jun 2019 15:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560458430;
        bh=FysKhzbKOR7uj5LpXOJJioOxhLSk0M4xDu0X02P9DxY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NfHR0+7sPDQvmtmzgY2D2NVhY+63nsSu9wwwe3vSb0JbciESg2oXlXYIHzC5J4sOq
         hU/72SzuVKOXt4UKJMETuPSWgkaCbflX/RwDgCkJBbNGDMr+DvXb+VcgX3wKg81Lz7
         d9ClHKQal5ZgK6a8ekKyYih680QWQweMbpdt550I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5DKeU0M091536
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jun 2019 15:40:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 13
 Jun 2019 15:40:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 13 Jun 2019 15:40:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5DKeRrZ120151;
        Thu, 13 Jun 2019 15:40:27 -0500
Subject: Re: [PATCH 10/16] dmaengine: ti: New driver for K3 UDMA - split#1:
 defines, structs, io func
To:     Rob Herring <robh@kernel.org>
CC:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
 <20190506123456.6777-11-peter.ujfalusi@ti.com> <20190613184324.GA26206@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7229677c-29c5-8c1f-2218-ff51ed57b8d0@ti.com>
Date:   Thu, 13 Jun 2019 23:40:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613184324.GA26206@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rob,

On 13/06/2019 21.43, Rob Herring wrote:
> On Mon, May 06, 2019 at 03:34:50PM +0300, Peter Ujfalusi wrote:
>> Split patch for review containing: defines, structs, io and low level
>> functions and interrupt callbacks.
> 
> Not a useful comment for upstream.

Vinod asked me to split the patch to smaller pieces for review. This is
just a short note on what this part covers. The real commit message
follows under.

>> DMA driver for
>> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
>>
>> The UDMA-P is intended to perform similar (but significantly upgraded) functions
>> as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
>> supports the transmission and reception of various packet types. The UDMA-P is
>> architected to facilitate the segmentation and reassembly of SoC DMA data
>> structure compliant packets to/from smaller data blocks that are natively
>> compatible with the specific requirements of each connected peripheral. Multiple
>> Tx and Rx channels are provided within the DMA which allow multiple segmentation
>> or reassembly operations to be ongoing. The DMA controller maintains state
>> information for each of the channels which allows packet segmentation and
>> reassembly operations to be time division multiplexed between channels in order
>> to share the underlying DMA hardware. An external DMA scheduler is used to
>> control the ordering and rate at which this multiplexing occurs for Transmit
>> operations. The ordering and rate of Receive operations is indirectly controlled
>> by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
>>
>> The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
>> channels. Channels in the UDMA-P can be configured to be either Packet-Based or
>> Third-Party channels on a channel by channel basis.
>>
>> The initial driver supports:
>> - MEM_TO_MEM (TR mode)
>> - DEV_TO_MEM (Packet / TR mode)
>> - MEM_TO_DEV (Packet / TR mode)
>> - Cyclic (Packet / TR mode)
>> - Metadata for descriptors
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c          | 1008 +++++++++++++++++++++++++++++
>>  drivers/dma/ti/k3-udma.h          |  129 ++++
>>  include/dt-bindings/dma/k3-udma.h |   26 +
> 
> This belongs in the binding patch.

OK, I'll move it.

> 
>>  3 files changed, 1163 insertions(+)
>>  create mode 100644 drivers/dma/ti/k3-udma.c
>>  create mode 100644 drivers/dma/ti/k3-udma.h
>>  create mode 100644 include/dt-bindings/dma/k3-udma.h
> 
>> diff --git a/include/dt-bindings/dma/k3-udma.h b/include/dt-bindings/dma/k3-udma.h
>> new file mode 100644
>> index 000000000000..89ba6a9d4a8f
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/k3-udma.h
>> @@ -0,0 +1,26 @@
>> +#ifndef __DT_TI_UDMA_H
>> +#define __DT_TI_UDMA_H
>> +
>> +#define UDMA_TR_MODE		0
>> +#define UDMA_PKT_MODE		1
>> +
>> +#define UDMA_DIR_TX		0
>> +#define UDMA_DIR_RX		1
>> +
>> +#define PSIL_STATIC_TR_NONE	0
>> +#define PSIL_STATIC_TR_XY	1
>> +#define PSIL_STATIC_TR_MCAN	2
>> +
>> +#define UDMA_PDMA_TR_XY(id)				\
>> +	ti,psil-config##id {				\
>> +		linux,udma-mode = <UDMA_TR_MODE>;	\
>> +		statictr-type = <PSIL_STATIC_TR_XY>;	\
>> +	}
> 
> We don't accept this kind of complex macros in dts files. It obfuscates 
> reading dts files.

I see. I agree that it obfuscates things as you need to look it up in
the header, but as I mentioned regarding to patch 9 we have PDMAs with
22 threads needing 22 psil-config section for the threads. It makes the
reading of the DT a bit hard and also error prone when you populate things.

But I can drop the macro and write all psil-config0...22

Hrm, so we have 23 threads in some PDMA...

Thanks,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
