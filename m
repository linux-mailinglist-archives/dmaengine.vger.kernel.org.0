Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA627E4A4
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgI3JOK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52980 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3JOI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DxCh067227;
        Wed, 30 Sep 2020 04:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457239;
        bh=oKsXoQZi1nap+gl1sJcH20iCneZiV9es7DXpO/QdHuU=;
        h=From:To:CC:Subject:Date;
        b=VSGFYCSUIw9KWEYc+xkCDWAbRqPXiXb+xRJG3Lw0oSkHy/UWvgTKlZlORBLz6J++o
         nvmGjG3JKFHRL28Y2ZdLFqbYeAKbkiQ/vbwFxvHacjZZBTJWrVbls4tKE5SJAqpXdM
         JqPwvvOl5lgqrivTBPZ6Q0Ti2yEu9CxT7bm4C3aw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DxQD121247;
        Wed, 30 Sep 2020 04:13:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:13:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:13:59 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJX116385;
        Wed, 30 Sep 2020 04:13:56 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 00/18] dmaengine/soc: k3-udma: Add support for BCDMA and PKTDMA
Date:   Wed, 30 Sep 2020 12:13:54 +0300
Message-ID: <20200930091412.8020-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

The series have build dependency on ti_sci/soc series (v1):
https://lore.kernel.org/lkml/20200928083429.17390-1-peter.ujfalusi@ti.com/

The unmapped event handling in INTA is also needed, but it is not a build
dependency (v2):
https://lore.kernel.org/lkml/20200930074559.18028-1-peter.ujfalusi@ti.com/

The DMSS introduced within AM64 as a simplified Data movement engine is built
on similar grounds as the K3 NAVSS and UDMAP, but with significant architectural
changes.

- Rings are built into the DMAs
The DMAs no longer use the general purpose ringacc, all rings has been moved
inside of the DMAs. The new rings within the DMAs are simplified to be dual
directional compared to the uni-directional rings in ringacc.
There is no more of a concept of generic purpose rings, all rings are assigned
to specific channels or flows.

- Per channel coherency support
The DMAs use the 'ASEL' bits to select data and configuration fetch path. The
ASEL bits are placed at the unused parts of any address field used by the
DMAs (pointers to descriptors, addresses in descriptors, ring base addresses).
The ASEL is not part of the address (the DMAs can address 48bits).
Individual channels can be configured to be coherent (via ACP port) or non
coherent individually by configuring the ASEL to appropriate value.

- Two different DMAs (well, three actually)
PKTDMA
Similar to UDMAP channels configured in packet mode.
The flow configuration of the channels has changed significantly in a way that
each channel have at least one flow assigned at design time and each flow is
directly mapped to corresponding ring.
When multiple flows are set, the channel can only use the flows within it's
assigned range.
PKTDMA also introduced multiple tflows which did not existed in UDMAP.

BCDMA
It has two types of channels:
- split channels (tchan/rchan): Similar to UDMAP channels configured in TR mode.
- Block copy channels (bchan): Similar to EDMA or traditional DMA channels, they
  can be used for mem2mem type of transfers or to service peripherals not
  accessible via PSI-L by using external triggers for the TR.
BCDMA channels do not have support for multiple flows

With the introduction of the new DMAs (especially the BCDMA) we also need to
update the resource manager code to support the second range from sysfw for
UDMA channels.

The two outstanding change in the series in my view is
the handling of the DMAs sideband signal of ASEL to select path to provide
coherency or non coherency.

the smaller one is the device_router_config callback to allow the configuration
of the triggers when BCDMA is servicing a triggering peripheral to solve a
chicken-egg situation:
The router needs to know the event number to send which in turn depends on the
channel we got for servicing the peripheral.

I'm sending this series as early as possible to have time for review and
changes.

When all things resolved, it would be nice if Santosh could create an immutable
branch with the ti_sci/soc patches for Vinod to use for this series.

Regards,
Peter
---
Grygorii Strashko (1):
  soc: ti: k3-ringacc: add AM64 DMA rings support.

Peter Ujfalusi (16):
  dmaengine: of-dma: Add support for optional router configuration
    callback
  dmaengine: Add support for per channel coherency handling
  dmaengine: doc: client: Update for dmaengine_get_dma_device() usage
  dmaengine: dmatest: Use dmaengine_get_dma_device
  dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
  dmaengine: ti: k3-udma: Add support for second resource range from
    sysfw
  dmaengine: ti: k3-udma-glue: Add function to get device pointer for
    DMA API
  dmaengine: ti: k3-udma-glue: Configure the dma_dev for rings
  dt-bindings: dma: ti: Add document for K3 BCDMA
  dt-bindings: dma: ti: Add document for K3 PKTDMA
  dmaengine: ti: k3-psil: Extend psil_endpoint_config for K3 PKTDMA
  dmaengine: ti: k3-psil: Add initial map for AM64
  dmaengine: ti: Add support for k3 event routers
  dmaengine: ti: k3-udma: Initial support for K3 BCDMA
  dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling
  dmaengine: ti: k3-udma: Initial support for K3 PKTDMA

Vignesh Raghavendra (1):
  dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  |  183 ++
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml |  189 ++
 Documentation/driver-api/dmaengine/client.rst |    4 +-
 drivers/dma/dmatest.c                         |   13 +-
 drivers/dma/of-dma.c                          |   10 +
 drivers/dma/ti/Makefile                       |    3 +-
 drivers/dma/ti/k3-psil-am64.c                 |   75 +
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    1 +
 drivers/dma/ti/k3-udma-glue.c                 |  294 ++-
 drivers/dma/ti/k3-udma-private.c              |   39 +
 drivers/dma/ti/k3-udma.c                      | 1975 +++++++++++++++--
 drivers/dma/ti/k3-udma.h                      |   27 +-
 drivers/soc/ti/k3-ringacc.c                   |  325 ++-
 include/linux/dma/k3-event-router.h           |   16 +
 include/linux/dma/k3-psil.h                   |   16 +
 include/linux/dma/k3-udma-glue.h              |   12 +
 include/linux/dmaengine.h                     |   14 +
 include/linux/soc/ti/k3-ringacc.h             |   17 +
 19 files changed, 2994 insertions(+), 220 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
 create mode 100644 drivers/dma/ti/k3-psil-am64.c
 create mode 100644 include/linux/dma/k3-event-router.h

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

