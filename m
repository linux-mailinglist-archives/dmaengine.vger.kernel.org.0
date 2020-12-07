Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE92D0B1F
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 08:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgLGHaY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 02:30:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58202 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGHaY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Dec 2020 02:30:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B77Sb7T099914;
        Mon, 7 Dec 2020 01:28:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607326117;
        bh=E26GSIN7nbh9QhT/f26Saq/Sje3zJwJEZvIk5wJ8pT0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GVPB+L2y1FoWMi1d9e7HtfhOpan1SpVGu4CZ0/SOn6kXv30G21bacMJS7UQ2Noo6s
         UxLSssuMPdV8OxgsZWFGR0fZnAFMFO+1X25VwCaXZm8s/SDmJoEHWXHLrhTQoQC0q+
         NtHvpyaZXq5leCCK7wroCd7EOhNLFJS1xBLFVFs0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B77SbsG000916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Dec 2020 01:28:37 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Dec
 2020 01:28:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Dec 2020 01:28:36 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B77SXRT084474;
        Mon, 7 Dec 2020 01:28:34 -0600
Subject: Re: [PATCH v2 00/19] dmaengine/soc: k3-udma: Add support for BCDMA
 and PKTDMA
To:     Vinod Koul <vkoul@kernel.org>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     <nm@ti.com>, <robh+dt@kernel.org>, <dan.j.williams@intel.com>,
        <t-kristo@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
 <20201124170856.GR8403@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <54416232-31b4-e866-82e9-0e9314528a81@ti.com>
Date:   Mon, 7 Dec 2020 09:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201124170856.GR8403@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Santosh,

On 24/11/2020 19.08, Vinod Koul wrote:
> On 17-11-20, 12:56, Peter Ujfalusi wrote:
>> Hi,
>>
>> The series have build dependency on ti_sci/soc series (v2):
>> https://lore.kernel.org/lkml/20201008115224.1591-1-peter.ujfalusi@ti.com/
>>
>> Santosh kindly created immutable branch holdinf the series:
>> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_5.11/drivers-soc 
> 
> Santosh, Can I have a signed tag for this please?

Can you please provide a tag for Vinod?

I'm ready to send v3 with few small fixes and waiting for Rob to get to
the binding documents before I do.

Thanks,
- Péter

>>
>> The unmapped event handling in INTA is already mainline.
>>
>> Changes since v1:
>> - Both DT binding document has been updated to address all comments and
>>   suggestions from Rob, all checks are passing on them
>> - included new patch to fix the normal channel start offset when ultra-high
>>   capacity channels are available for the UDMA and updated the BCDMA/PKTDMA
>>   patches along the same line
>> - Re-arranged the patches for Vinod so that the preparational patches and fixes
>>   can be picked up separately (they still have dependency on Santosh's branch):
>>
>>   patch 1-5: Fixes and new features for existing devices using UDMA, but the
>>              the BCDMA/PKTDMA support is building on top of these.
>>              Build dependency on Santosh's branch
>>   patch 6: Optional second stage router configuration callback support in core
>>   patch 7-9: Per channel coherency support in core and use it in dmatest.
>>   patch 10-: Initial AM64 BCDMA and PKTDMA support
>>
>> The DMSS introduced within AM64 as a simplified Data movement engine is built
>> on similar grounds as the K3 NAVSS and UDMAP, but with significant architectural
>> changes.
>>
>> - Rings are built into the DMAs
>> The DMAs no longer use the general purpose ringacc, all rings has been moved
>> inside of the DMAs. The new rings within the DMAs are simplified to be dual
>> directional compared to the uni-directional rings in ringacc.
>> There is no more of a concept of generic purpose rings, all rings are assigned
>> to specific channels or flows.
>>
>> - Per channel coherency support
>> The DMAs use the 'ASEL' bits to select data and configuration fetch path. The
>> ASEL bits are placed at the unused parts of any address field used by the
>> DMAs (pointers to descriptors, addresses in descriptors, ring base addresses).
>> The ASEL is not part of the address (the DMAs can address 48bits).
>> Individual channels can be configured to be coherent (via ACP port) or non
>> coherent individually by configuring the ASEL to appropriate value.
>>
>> - Two different DMAs (well, three actually)
>> PKTDMA
>> Similar to UDMAP channels configured in packet mode.
>> The flow configuration of the channels has changed significantly in a way that
>> each channel have at least one flow assigned at design time and each flow is
>> directly mapped to corresponding ring.
>> When multiple flows are set, the channel can only use the flows within it's
>> assigned range.
>> PKTDMA also introduced multiple tflows which did not existed in UDMAP.
>>
>> BCDMA
>> It has two types of channels:
>> - split channels (tchan/rchan): Similar to UDMAP channels configured in TR mode.
>> - Block copy channels (bchan): Similar to EDMA or traditional DMA channels, they
>>   can be used for mem2mem type of transfers or to service peripherals not
>>   accessible via PSI-L by using external triggers for the TR.
>> BCDMA channels do not have support for multiple flows
>>
>> With the introduction of the new DMAs (especially the BCDMA) we also need to
>> update the resource manager code to support the second range from sysfw for
>> UDMA channels.
>>
>> The two outstanding change in the series in my view is
>> the handling of the DMAs sideband signal of ASEL to select path to provide
>> coherency or non coherency.
>>
>> The smaller one is the device_router_config callback to allow the configuration
>> of the triggers when BCDMA is servicing a triggering peripheral to solve a
>> chicken-egg situation:
>> The router needs to know the event number to send which in turn depends on the
>> channel we got for servicing the peripheral.
>>
>> Regards,
>> Peter
>> ---
>> Grygorii Strashko (1):
>>   soc: ti: k3-ringacc: add AM64 DMA rings support.
>>
>> Peter Ujfalusi (17):
>>   dmaengine: ti: k3-udma: Correct normal channel offset when uchan_cnt
>>     is not 0
>>   dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
>>   dmaengine: ti: k3-udma: Add support for second resource range from
>>     sysfw
>>   dmaengine: ti: k3-udma-glue: Add function to get device pointer for
>>     DMA API
>>   dmaengine: ti: k3-udma-glue: Configure the dma_dev for rings
>>   dmaengine: of-dma: Add support for optional router configuration
>>     callback
>>   dmaengine: Add support for per channel coherency handling
>>   dmaengine: doc: client: Update for dmaengine_get_dma_device() usage
>>   dmaengine: dmatest: Use dmaengine_get_dma_device
>>   dt-bindings: dma: ti: Add document for K3 BCDMA
>>   dt-bindings: dma: ti: Add document for K3 PKTDMA
>>   dmaengine: ti: k3-psil: Extend psil_endpoint_config for K3 PKTDMA
>>   dmaengine: ti: k3-psil: Add initial map for AM64
>>   dmaengine: ti: Add support for k3 event routers
>>   dmaengine: ti: k3-udma: Initial support for K3 BCDMA
>>   dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling
>>   dmaengine: ti: k3-udma: Initial support for K3 PKTDMA
>>
>> Vignesh Raghavendra (1):
>>   dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA
>>
>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  |  175 ++
>>  .../devicetree/bindings/dma/ti/k3-pktdma.yaml |  183 ++
>>  Documentation/driver-api/dmaengine/client.rst |    4 +-
>>  drivers/dma/dmatest.c                         |   13 +-
>>  drivers/dma/of-dma.c                          |   10 +
>>  drivers/dma/ti/Makefile                       |    3 +-
>>  drivers/dma/ti/k3-psil-am64.c                 |   75 +
>>  drivers/dma/ti/k3-psil-priv.h                 |    1 +
>>  drivers/dma/ti/k3-psil.c                      |    1 +
>>  drivers/dma/ti/k3-udma-glue.c                 |  294 ++-
>>  drivers/dma/ti/k3-udma-private.c              |   39 +
>>  drivers/dma/ti/k3-udma.c                      | 1968 +++++++++++++++--
>>  drivers/dma/ti/k3-udma.h                      |   27 +-
>>  drivers/soc/ti/k3-ringacc.c                   |  325 ++-
>>  include/linux/dma/k3-event-router.h           |   16 +
>>  include/linux/dma/k3-psil.h                   |   16 +
>>  include/linux/dma/k3-udma-glue.h              |   12 +
>>  include/linux/dmaengine.h                     |   14 +
>>  include/linux/soc/ti/k3-ringacc.h             |   17 +
>>  19 files changed, 2973 insertions(+), 220 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
>>  create mode 100644 drivers/dma/ti/k3-psil-am64.c
>>  create mode 100644 include/linux/dma/k3-event-router.h
>>
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
