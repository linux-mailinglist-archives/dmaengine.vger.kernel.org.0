Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25C149D8
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEFMfK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:35:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51452 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFMfK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 08:35:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x46CYsSX016802;
        Mon, 6 May 2019 07:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557146094;
        bh=791UZX4gEG7SoDY1IQYcG5T4/BuZV0fdBtg46h2Ksew=;
        h=From:To:CC:Subject:Date;
        b=Zg6iW+m8adp/Z8CF6YAeEypc0rM+mAMKzYiaHdnHZb7E8XbVkLAp8qJUeFf1Heupe
         5n8rHaj5R9cBZG8MOih626AhUVXxQWnvkxr7ymXWQtbv+6hU32p5SZNSZnw6P//3SD
         guCvtY7eyPSJ8m4W+n7yXOCuZn40IaHZTrce0TJk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x46CYsWB022840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 May 2019 07:34:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 6 May
 2019 07:34:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 6 May 2019 07:34:54 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x46CYpU6110286;
        Mon, 6 May 2019 07:34:51 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH 00/16] dmaengine/soc/firmware: Add Texas Instruments UDMA support
Date:   Mon, 6 May 2019 15:34:40 +0300
Message-ID: <20190506123456.6777-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Changes since RFC (https://patchwork.kernel.org/cover/10612465/):
- Based on linux-next (20190506) which now have the ti_sci interrupt support
- The series can be applied and the UDMA via DMAengine API will be functional
- Included in the series: ti_sci Resource management API, cppi5 header and
  driver for the ring accelerator.
- The DMAengine core patches have been updated as per the review comments for
  earlier submittion.
- The DMAengine driver patch is artificially split up to 6 smaller patches

The AM65x TRM (http://www.ti.com/lit/pdf/spruid7) describes the Data Movement
Architecture which is implmented by the k3-udma driver.

This DMA architecture is a big departure from 'traditional' architecture where
we had either EDMA or sDMA as system DMA.

Packet DMAs were used as dedicated DMAs to service only networking (Kesytone2)
or USB (am335x) while other peripherals were serviced by EDMA.

In AM65x the UDMA (Unified DMA) is used for all data movment within the SoC,
tasked to service all peripherals (UART, McSPI, McASP, networking, etc). 

The NAVSS/UDMA is built around CPPI5 (Communications Port Programming Interface)
and it supports Packet mode (similar to CPPI4.1 in Keystone2 for networking) and
TR mode (similar to EDMA descriptor).
The data movement is done within a PSI-L fabric, all peripherals (including the
UDMA-P) are not addressed by their I/O register as with traditional DMAs but
with their PSI-L thread ID.

In AM65x we have two main type of peripherals:
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

- dmadev_get_slave_channel()

I needed a way to request a channel from a specific dma_device which would
invoke the filter function to get the needed parameters prior needed for the
alloc_chan_resources.

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

Regards,
Peter
---
Grygorii Strashko (3):
  bindings: soc: ti: add documentation for k3 ringacc
  soc: ti: k3: add navss ringacc driver
  dmaengine: ti: k3-udma: Add glue layer for non DMAengine users

Peter Ujfalusi (13):
  firmware: ti_sci: Add resource management APIs for ringacc, psi-l and
    udma
  dmaengine: doc: Add sections for per descriptor metadata support
  dmaengine: Add metadata_ops for dma_async_tx_descriptor
  dmaengine: Add support for reporting DMA cached data amount
  dmaengine: Add function to request slave channel from a dma_device
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

 .../devicetree/bindings/dma/ti/k3-udma.txt    |  134 +
 .../devicetree/bindings/soc/ti/k3-ringacc.txt |   59 +
 Documentation/driver-api/dmaengine/client.rst |   75 +
 .../driver-api/dmaengine/provider.rst         |   46 +
 drivers/dma/dmaengine.c                       |   80 +-
 drivers/dma/dmaengine.h                       |    8 +
 drivers/dma/ti/Kconfig                        |   22 +
 drivers/dma/ti/Makefile                       |    2 +
 drivers/dma/ti/k3-udma-glue.c                 | 1039 +++++
 drivers/dma/ti/k3-udma-private.c              |  124 +
 drivers/dma/ti/k3-udma.c                      | 3329 +++++++++++++++++
 drivers/dma/ti/k3-udma.h                      |  159 +
 drivers/firmware/ti_sci.c                     |  439 +++
 drivers/firmware/ti_sci.h                     |  704 ++++
 drivers/soc/ti/Kconfig                        |   17 +
 drivers/soc/ti/Makefile                       |    1 +
 drivers/soc/ti/k3-ringacc.c                   | 1190 ++++++
 include/dt-bindings/dma/k3-udma.h             |   26 +
 include/linux/dma/k3-udma-glue.h              |  123 +
 include/linux/dma/ti-cppi5.h                  |  994 +++++
 include/linux/dmaengine.h                     |  115 +-
 include/linux/soc/ti/k3-ringacc.h             |  258 ++
 include/linux/soc/ti/ti_sci_protocol.h        |  216 ++
 23 files changed, 9156 insertions(+), 4 deletions(-)
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

