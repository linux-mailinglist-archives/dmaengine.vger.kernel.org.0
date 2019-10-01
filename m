Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36C9C2D39
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2019 08:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfJAGQv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Oct 2019 02:16:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57550 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbfJAGQv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Oct 2019 02:16:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x916GKn4055655;
        Tue, 1 Oct 2019 01:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569910580;
        bh=i+/cBuwEhu+kG72RDawA6zSZdhLrW0nih8sfzn+f6n8=;
        h=From:To:CC:Subject:Date;
        b=E5y1WjKsdtzTky4n4XedeGOQjMzWB653ATEultt8/SYRVG/iuI7h16tiW/L3jyaUX
         oPhlZ+FnpKect5GlO6xeSqxRQKeFxLgY46smEyOlAsbjtKr4PSO14tBTPLl+mxmTwP
         ZJX8wjI/yCQpt1EwQEIfe1sR4ToYfe24pTfiA/ks=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x916GK55017804
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Oct 2019 01:16:20 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 1 Oct
 2019 01:16:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 1 Oct 2019 01:16:10 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x916GGX5090310;
        Tue, 1 Oct 2019 01:16:16 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v3 00/14] dmaengine/soc: Add Texas Instruments UDMA support
Date:   Tue, 1 Oct 2019 09:16:50 +0300
Message-ID: <20191001061704.2399-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since v2
)https://patchwork.kernel.org/project/linux-dmaengine/list/?series=152609&state=*)
- Based on 5.4-rc1
- Support for Flow only data transfer for the glue layer

- cppi5 header
 - comments converted to kernel-doc style
 - Remove the excessive WARN_ONs and rely on the user for sanity
 - new macro for checking TearDown Completion Message

- ring accelerator driver
 - fixed up th commit message (SoB, TI-SCI)
 - fixed ring reset
 - CONFIG_TI_K3_RINGACC_DEBUG is removed along with the dbg_write/read functions
   and use dev_dbg()
 - k3_ringacc_ring_dump() is moved to static
 - step numbering removed from k3_ringacc_ring_reset_dma()
 - Add clarification comment for shared ring usage in k3_ringacc_ring_cfg()
 - Magic shift values in k3_ringacc_ring_cfg_proxy() got defined
 - K3_RINGACC_RING_MODE_QM is removed as it is not supported

- UDMAP DT bindings
 - Fix property prefixing: s/pdma,/ti,pdma-
 - Add ti,notdpkt property to suppress teardown completion message on tchan
 - example updated accordingly

- UDMAP DMAengine driver
 - Change __raw_readl/writel to readl/writel
 - Split up the udma_tisci_channel_config() into m2m, tx and rx tisci
   configuration functions for clarity
 - DT bindings change: s/pdma,/ti,pdma-
 - Cleanup of udma_tx_status():
  - residue calculation fix for m2m
  - no need to read packet counter as it is not used
  - peer byte counter only available in PDMAs
  - Proper locking to avoid race with interrupt handler (polled m2m fix)
 - Support for ti,notdpkt
 - RFLOW management rework to support data movement without channel:
  - the channel is not controlled by Linux but other core and we only have
    rflows and rings to do the DMA transfers.
    This mode is only supported by the Glue layer for now.

- UDMAP glue layer
 - Debug print improvements
 - Support for rflow/ring only data movement

Changes since v1
(https://patchwork.kernel.org/project/linux-dmaengine/list/?series=114105&state=*)
- Added support for j721e
- Based on 5.3-rc2
- dropped ti_sci API patch for RM management as it is already upstream
- dropped dmadev_get_slave_channel() patch, using __dma_request_channel()
- Added Rob's Reviewed-by to ringacc DT binding document patch
- DT bindings changes:
 - linux,udma-mode is gone, I have a simple lookup table in the driver to flag
   TR channels.
 - Support for j721e
- Fix bug in of_node_put() handling in xlate function

Changes since RFC (https://patchwork.kernel.org/cover/10612465/):
- Based on linux-next (20190506) which now have the ti_sci interrupt support
- The series can be applied and the UDMA via DMAengine API will be functional
- Included in the series: ti_sci Resource management API, cppi5 header and
  driver for the ring accelerator.
- The DMAengine core patches have been updated as per the review comments for
  earlier submittion.
- The DMAengine driver patch is artificially split up to 6 smaller patches

The k3-udma driver implements the Data Movement Architecture described in
AM65x TRM (http://www.ti.com/lit/pdf/spruid7) and
j721e TRM (http://www.ti.com/lit/pdf/spruil1)

This DMA architecture is a big departure from 'traditional' architecture where
we had either EDMA or sDMA as system DMA.

Packet DMAs were used as dedicated DMAs to service only networking (Kesytone2)
or USB (am335x) while other peripherals were serviced by EDMA.

In AM65x/j721e the UDMA (Unified DMA) is used for all data movment within the
SoC, tasked to service all peripherals (UART, McSPI, McASP, networking, etc). 

The NAVSS/UDMA is built around CPPI5 (Communications Port Programming Interface)
and it supports Packet mode (similar to CPPI4.1 in Keystone2 for networking) and
TR mode (similar to EDMA descriptor).
The data movement is done within a PSI-L fabric, peripherals (including the
UDMA-P) are not addressed by their I/O register as with traditional DMAs but
with their PSI-L thread ID.

In AM65x/j721e we have two main type of peripherals:
Legacy: McASP, McSPI, UART, etc.
 to provide connectivity they are serviced by PDMA (Peripheral DMA)
 PDMA threads are locked to service a given peripheral, for example PSI-L thread
 0x4400/0xc400 is to service McASP0 rx/tx.
 The PDMa configuration can be done via the UDMA Real Time Peer registers.
Native: Networking, security accelerator
 these peripherals have native support for PSI-L.

To be able to use the DMA the following generic steps need to be taken:
- configure a DMA channel (tchan for TX, rchan for RX)
 - channel mode: Packet or TR mode
 - for memcpy a tchan and rchan pair is used.
 - for packet mode RX we also need to configure a receive flow to configure the
   packet receiption
- the source and destination threads must be paired
- at minimum one pair of rings need to be configured:
 - tx: transfer ring and transfer completion ring
 - rx: free descriptor ring and receive ring
- two interrupts: UDMA-P channel interrupt and ring interrupt for tc_ring/r_ring
 - If the channel is in packet mode or configured to memcpy then we only need
   one interrupt from the ring, events from UDMAP is not used.

When the channel setup is completed we only interract with the rings:
- TX: push a descriptor to t_ring and wait for it to be pushed to the tc_ring by
  the UDMA-P
- RX: push a descriptor to the fd_ring and waith for UDMA-P to push it back to
  the r_ring.

Since we have FIFOs in the DMA fabric (UDMA-P, PSI-L and PDMA) which was not the
case in previous DMAs we need to report the amount of data held in these FIFOs
to clients (delay calculation for ALSA, UART FIFO flush support).

Metadata support:
DMAengine user driver was posted upstream based/tested on the v1 of the UDMA
series: https://lkml.org/lkml/2019/6/28/20
SA2UL is using the metadata DMAengine API.

Note on the last patch:
In Keystone2 the networking had dedicated DMA (packet DMA) which is not the case
anymore and the DMAengine API currently missing support for the features we
would need to support networking, things like
- support for receive descriptor 'classification'
 - we need to support several receive queues for a channel.
 - the queues are used for packet priority handling for example, but they can be
   used to have pools of descriptors for different sizes.
- out of order completion of descriptors on a channel
 - when we have several queues to handle different priority packets the
   descriptors will be completed 'out-of-order'
- NAPI type of operation (polling instead of interrupt driven transfer)
 - without this we can not sustain gigabit speeds and we need to support NAPI
 - not to limit this to networking, but other high performance operations

It is my intention to work on these to be able to remove the 'glue' layer and
switch to DMAengine API - or have an API aside of DMAengine to have generic way
to support networking, but given how controversial and not trivial these changes
are we need something to support networking.

The series (+DT patch to enabled UDMA/PDMA on AM65x) on top of 5.4-rc1 is
available:
https://github.com/omap-audio/linux-audio.git peter/udma/series_v3-5.4-rc1

Regards,
Peter
---

Grygorii Strashko (3):
  bindings: soc: ti: add documentation for k3 ringacc
  soc: ti: k3: add navss ringacc driver
  dmaengine: ti: k3-udma: Add glue layer for non DMAengine users

Peter Ujfalusi (11):
  dmaengine: doc: Add sections for per descriptor metadata support
  dmaengine: Add metadata_ops for dma_async_tx_descriptor
  dmaengine: Add support for reporting DMA cached data amount
  dmaengine: ti: Add cppi5 header for UDMA
  dt-bindings: dma: ti: Add document for K3 UDMA
  dmaengine: ti: New driver for K3 UDMA - split#1: defines, structs, io
    func
  dmaengine: ti: New driver for K3 UDMA - split#2: probe/remove, xlate
    and filter_fn
  dmaengine: ti: New driver for K3 UDMA - split#3: alloc/free
    chan_resources
  dmaengine: ti: New driver for K3 UDMA - split#4: dma_device callbacks
    1
  dmaengine: ti: New driver for K3 UDMA - split#5: dma_device callbacks
    2
  dmaengine: ti: New driver for K3 UDMA - split#6: Kconfig and Makefile

 .../devicetree/bindings/dma/ti/k3-udma.txt    |  185 +
 .../devicetree/bindings/soc/ti/k3-ringacc.txt |   59 +
 Documentation/driver-api/dmaengine/client.rst |   75 +
 .../driver-api/dmaengine/provider.rst         |   46 +
 drivers/dma/dmaengine.c                       |   73 +
 drivers/dma/dmaengine.h                       |    8 +
 drivers/dma/ti/Kconfig                        |   22 +
 drivers/dma/ti/Makefile                       |    2 +
 drivers/dma/ti/k3-udma-glue.c                 | 1225 ++++++
 drivers/dma/ti/k3-udma-private.c              |  141 +
 drivers/dma/ti/k3-udma.c                      | 3525 +++++++++++++++++
 drivers/dma/ti/k3-udma.h                      |  161 +
 drivers/soc/ti/Kconfig                        |   12 +
 drivers/soc/ti/Makefile                       |    1 +
 drivers/soc/ti/k3-ringacc.c                   | 1165 ++++++
 include/dt-bindings/dma/k3-udma.h             |   10 +
 include/linux/dma/k3-udma-glue.h              |  134 +
 include/linux/dma/ti-cppi5.h                  | 1049 +++++
 include/linux/dmaengine.h                     |  110 +
 include/linux/soc/ti/k3-ringacc.h             |  245 ++
 20 files changed, 8248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 drivers/dma/ti/k3-udma-glue.c
 create mode 100644 drivers/dma/ti/k3-udma-private.c
 create mode 100644 drivers/dma/ti/k3-udma.c
 create mode 100644 drivers/dma/ti/k3-udma.h
 create mode 100644 drivers/soc/ti/k3-ringacc.c
 create mode 100644 include/dt-bindings/dma/k3-udma.h
 create mode 100644 include/linux/dma/k3-udma-glue.h
 create mode 100644 include/linux/dma/ti-cppi5.h
 create mode 100644 include/linux/soc/ti/k3-ringacc.h

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

