Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00D712948B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLWLFC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:05:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38924 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfLWLFC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:05:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4iGi031784;
        Mon, 23 Dec 2019 05:04:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099085;
        bh=raSKwiiUYxjoLuY4+NT6kny2GpLANO/tx7HTDpBqk2o=;
        h=From:To:CC:Subject:Date;
        b=pqVXEHdmBUuJlKk3pxTyypXEAWN+AGUCFlcH2IDZln26lwbKDtTdpWk2TMVEgFy2r
         bHq6b4lGwjQjRpYXHXRe4kOLoaGQgMC/NcKscS33Tu5J/iQGyGABRJryfQF6eqt/F4
         /oH+5uuDGkqsauHOcn4zmgIlwUlP/owXis2EOzFk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNB4imv039890
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 05:04:44 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:04:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:04:44 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eM7025693;
        Mon, 23 Dec 2019 05:04:40 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 00/18] dmaengine/soc: Add Texas Instruments UDMA support
Date:   Mon, 23 Dec 2019 13:04:40 +0200
Message-ID: <20191223110458.30766-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Vinod, Nishanth, Tero, Santosh: the ti_sci patch in this series was sent
upstream over a month ago:
https://lore.kernel.org/lkml/20191025084715.25098-1-peter.ujfalusi@ti.com/

I'm still waiting on it's fate (Tero has given his r-b).
The ti_sci patch did not made it to 5.5-rc1, but I included it in the series and
let the maintainers decide if it can go via DMAengine for 5.6 or to later
releases (5.6 probably for the ti_sci and 5.7 for the UDMA driver patch).

Patch 1-11 is the initial DMA support which can be applied as it is.
Patch 12-13 adds support for j721e tdtype for ti_sci and the UDMAP driver
Patch 14-15 exports the currently unexported functions:
		devm_ti_sci_get_of_resource()
		of_msi_get_domain()
Patch 16-18 makes the ringacc, DMAengine and glue layer buildable as module.

Changes since v7:
(https://lore.kernel.org/lkml/20191209094332.4047-1-peter.ujfalusi@ti.com/)

- Added Tested-by from Keerthy
- Added Reviewed-by from Grygorii

- DMAengine:
 - helper function for converting direction value to text

- DMAengine metadata support:
 - Improve documentation and comments inside the code

- ringacc driver:
 - Do not allow it to be built as a module for now as two exports are missing
   from kernel:
    - devm_ti_sci_get_of_resource()
    - of_msi_get_domain()

- cppi5 header
 - Remove cppi5_hdesc_get_psdata32()
 - Define for default flow: CPPI5_INFO1_DESC_FLOWID_DEFAULT

- UDMAP DT bindings:
 - Typo fixes.

- UDMAP DMAengine driver:
 - Do not allow it to be built as a module for now as two exports are missing
   from kernel:
    - devm_ti_sci_get_of_resource()
    - of_msi_get_domain()
 - channel (runtime) configuration moved to a struct and using memset/memcpy on
   it when needed.
 - Corrected the udma_tx_status for pause reporting
 - Use GFP_NOWAIT in prep callback paths
 - Magic number for packet length changed to >= SZ_4M
 - Use define for default flow number (0x3fff)
 - Use the generic of_msi_get_domain()
 - No casting from void *

- UDMAP glue layer:
 - Do not allow it to be built as a module for now as two exports are missing
   from kernel:
    - devm_ti_sci_get_of_resource()
    - of_msi_get_domain()

Changes since v6:
(https://patchwork.kernel.org/project/linux-dmaengine/list/?series=209455&state=*)

- UDMAP DMAengine driver:
 - Squashed the split patches
 - Squashed the early TX completion handling update
   (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=210713&state=*)
 - Hard reset fix for RX channels to avoid channel lockdown
 - Correct completed descriptor's residue value

Changes since v5:
(https://patchwork.kernel.org/project/linux-dmaengine/list/?series=201051&state=*)
- Based on 5.4

- cppi5 header
 - clear the bits before setting new value with '|='

- UDMAP DT bindings:
 - valid compatibles as single enum list

- UDMAP DMAengine driver:
 - Fix udma_is_chan_running()
 - Use flags for acc32, burst support instead of a bool in udma_match_data
   struct
 - TDTYPE handling (teardown completion handling for j721e) is moved to separate
   patch as the tisci core patch has not moved for over a month.
   Both ti_sci and the iterative patch to udma is included in the series.

Changes since v4
(https://patchwork.kernel.org/project/linux-dmaengine/list/?series=196619&state=*)
- Based on 5.4-rc7

- ringacc DT bindings:
 - clarify the meaning of ti,sci-dev-id

- ringacc driver:
 - Remove 'default y' from Kconfig
 - Fix struct comments
 - Move try_module_get() earlier in k3_ringacc_request_ring()

- PSI-L thread database:
 - Add kernel style struct/enum documentation
 - Add missing thread description for sa2ul second interface
 - Change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL

- UDMAP DT bindings:
 - move to dual license
 - change compatible from const to enum
 - items dropped for ti,sci-rm-ranges-*
 - description text moved from literal block when it is sensible
 - example fixed to compile cleanly
  - added parent to provide correct address-cells
  - navss is moved to simple-mfd from simple-bus

- UDMAP DMAengine driver:
 - move fd_ring/r_ring under rflow
 - get rid of unused iomem for rflows
 - Remove 'default y' from Kconfig
 - Use defines for rflow src/dst tag selection
 - Merge the udma_ring_callback() and udma_tr_event_callback() to their
   corresponding interrupt handler
 - Create new defines for tx/rx channel's tisci valid parameter flags
 - Remove re-initialization to 0 of tisci request struct members
 - Make sure that vchan tasklets are also stopped when removing the module
 - Additional checkpatch --strict fixes when it made sense
  - make W=1 was clean

- UDMAP glue layer:
 - Remove 'default y' from Kconfig
 - commit message update for features needing the glue layer

Changes since v3
(https://patchwork.kernel.org/project/linux-dmaengine/list/?series=180679&state=*):
- Based on 5.4-rc5
- Fixed typos pointed out by Tero
- Added reviewed-by tags from Tero

- ring accelerator driver
 - TODO_GS is removed from the header
 - pm_runtime removed as NAVSS and it's components are always on
 - Check validity of Message mode setup (element size > 8 bytes must use proxy)

- cppi5 header
 - add commit message

- UDMAP DT bindings
 - Drop the psil-config node use on the remote PSI-L side and use only one cell
   which is the remote threadID:

     dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
     dma-names = "tx", "rx";

 - The PSI-L thread configuration description is moved to kernel as a new module:
   k3-psil/k3-psil-am654/k3-psil-j721e
 - ti,psil-base has been removed and moved to kernel
 - removed the no longer needed dt-bindings/dma/k3-udma.h
 - Convert the document to schema (yaml)

- NEW PSI-L endpoint configuration database
 - a simple database holding the remote end's configuration needed for UDMAP
   configuration. All previous parameters from DT has been moved here and merged
   with the linux only tr mode channel flag.
 - Client drivers can update the remote endpoint configuration as it can be
   different based on system configuration and the endpoint itself is under the
   control of the peripheral driver.
 - database for am654 and j721e

- UDMAP DMAengine driver
 - pm_runtime removed as NAVSS and it's components are always on
 - rchan_oes_offset added to MSI dommain allocation
 - Use the new PSI-L endpoint database for UDMAP configuration
 - Support for waiting for PDMA teardown completion on j721e instead of
   returning right away. depends on:
   https://lkml.org/lkml/2019/10/25/189
   Not included in this series, but it is in the branch I have prepared.
 - psil-base is moved from DT to be part of udma_match_data
 - tr_thread maps is removed and using the PSI-L endpoint configuration for it

- UDMAP glue layer
 - pm_runtime removed as NAVSS and it's components are always on
 - Use the new PSI-L endpoint database for UDMAP configuration

Changes since v2
(https://patchwork.kernel.org/project/linux-dmaengine/list/?series=152609&state=*)
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

The series (+DT patches to enabled DMA on AM65x and j721e) on top of 5.5-rc3 is
available:
https://github.com/omap-audio/linux-audio.git peter/udma/series_v8-5.5-rc3

Regards,
Peter
---
Grygorii Strashko (3):
  bindings: soc: ti: add documentation for k3 ringacc
  soc: ti: k3: add navss ringacc driver
  dmaengine: ti: k3-udma: Add glue layer for non DMAengine users

Matthias Brugger (1):
  of: irq: Export of_msi_get_domain

Peter Ujfalusi (14):
  dmaengine: doc: Add sections for per descriptor metadata support
  dmaengine: Add metadata_ops for dma_async_tx_descriptor
  dmaengine: Add support for reporting DMA cached data amount
  dmaengine: Add helper function to convert direction value to text
  dmaengine: ti: Add cppi5 header for K3 NAVSS/UDMA
  dmaengine: ti: k3 PSI-L remote endpoint configuration
  dt-bindings: dma: ti: Add document for K3 UDMA
  dmaengine: ti: New driver for K3 UDMA
  firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx
    channel
  dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
  firmware: ti_sci: Export devm_ti_sci_get_of_resource for modules
  dmaengine: ti: k3-udma: Allow the driver to be built as module
  dmaengine: ti: k3-udma-glue: Allow the driver to be built as module
  soc: ti: k3-ringacc: Allow the driver to be built as module

 .../devicetree/bindings/dma/ti/k3-udma.yaml   |  184 +
 .../devicetree/bindings/soc/ti/k3-ringacc.txt |   59 +
 Documentation/driver-api/dmaengine/client.rst |   87 +
 .../driver-api/dmaengine/provider.rst         |   48 +
 drivers/dma/dmaengine.c                       |   73 +
 drivers/dma/dmaengine.h                       |    8 +
 drivers/dma/ti/Kconfig                        |   24 +
 drivers/dma/ti/Makefile                       |    3 +
 drivers/dma/ti/k3-psil-am654.c                |  175 +
 drivers/dma/ti/k3-psil-j721e.c                |  222 ++
 drivers/dma/ti/k3-psil-priv.h                 |   39 +
 drivers/dma/ti/k3-psil.c                      |   93 +
 drivers/dma/ti/k3-udma-glue.c                 | 1200 ++++++
 drivers/dma/ti/k3-udma-private.c              |  133 +
 drivers/dma/ti/k3-udma.c                      | 3465 +++++++++++++++++
 drivers/dma/ti/k3-udma.h                      |  151 +
 drivers/firmware/ti_sci.c                     |    2 +
 drivers/firmware/ti_sci.h                     |    7 +
 drivers/of/irq.c                              |    1 +
 drivers/soc/ti/Kconfig                        |   11 +
 drivers/soc/ti/Makefile                       |    1 +
 drivers/soc/ti/k3-ringacc.c                   | 1180 ++++++
 include/linux/dma/k3-psil.h                   |   71 +
 include/linux/dma/k3-udma-glue.h              |  134 +
 include/linux/dma/ti-cppi5.h                  | 1059 +++++
 include/linux/dmaengine.h                     |  133 +
 include/linux/soc/ti/k3-ringacc.h             |  244 ++
 include/linux/soc/ti/ti_sci_protocol.h        |    2 +
 28 files changed, 8809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 drivers/dma/ti/k3-psil-am654.c
 create mode 100644 drivers/dma/ti/k3-psil-j721e.c
 create mode 100644 drivers/dma/ti/k3-psil-priv.h
 create mode 100644 drivers/dma/ti/k3-psil.c
 create mode 100644 drivers/dma/ti/k3-udma-glue.c
 create mode 100644 drivers/dma/ti/k3-udma-private.c
 create mode 100644 drivers/dma/ti/k3-udma.c
 create mode 100644 drivers/dma/ti/k3-udma.h
 create mode 100644 drivers/soc/ti/k3-ringacc.c
 create mode 100644 include/linux/dma/k3-psil.h
 create mode 100644 include/linux/dma/k3-udma-glue.h
 create mode 100644 include/linux/dma/ti-cppi5.h
 create mode 100644 include/linux/soc/ti/k3-ringacc.h

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

