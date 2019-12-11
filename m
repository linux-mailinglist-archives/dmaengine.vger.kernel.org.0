Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18F311A934
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfLKKoJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 05:44:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59418 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLKKoJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Dec 2019 05:44:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBAhnHT107805;
        Wed, 11 Dec 2019 04:43:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576061029;
        bh=fJw+qg7d5QZT0AdClUYy8aT9oPLJOjFwiGLsvb+11Tk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C+ZbdmfW/Q5hWXkiYcDbacbcc6nXETTxx8gf9i/iNppjQO24iXVFG4qSu/2Ca9/zt
         g0mPJrhVbg5qb2ouS1aQeKGfsLZEO9wEpZSqJB8b8x+dL/gYVKOwqNJ6ARnYSkxqLZ
         D6cF/yhTQdNQ+mg+bkSpQYQbw5wzRd5zDePmCfKY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBAhnMY076128
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 04:43:49 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 04:43:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 04:43:49 -0600
Received: from [10.24.69.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBAhfou070515;
        Wed, 11 Dec 2019 04:43:42 -0600
Subject: Re: [PATCH v7 00/12] dmaengine/soc: Add Texas Instruments UDMA
 support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
From:   Keerthy <j-keerthy@ti.com>
X-Pep-Version: 2.0
Message-ID: <6612f2e2-f25e-47bd-e8d6-1d46f756acaf@ti.com>
Date:   Wed, 11 Dec 2019 16:13:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209094332.4047-1-peter.ujfalusi@ti.com>
Content-Type: multipart/mixed;
        boundary="------------0B3EC23F076E74A147622A00"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------0B3EC23F076E74A147622A00
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 09/12/19 3:13 pm, Peter Ujfalusi wrote:
> Hi,
>=20
> Vinod, Nishanth, Tero, Santosh: the ti_sci patch in this series was sen=
t
> upstream over a month ago:
> https://lore.kernel.org/lkml/20191025084715.25098-1-peter.ujfalusi@ti.c=
om/
>=20
> I'm still waiting on it's fate (Tero has given his r-b).
> The ti_sci patch did not made it to 5.5-rc1, but I included it in the s=
eries and
> let the maintainers decide if it can go via DMAengine for 5.6 or to lat=
er
> releases (5.6 probably for the ti_sci and 5.7 for the UDMA driver patch=
).

Tested this series for sa2ul crypto for AES & 3DES which need the
metadata implementation by this series for sa2ul specific functionalities=
=2E

FWIW: Tested-by: Keerthy <j-keerthy@ti.com>

>=20
> Changes since v6:
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D20=
9455&state=3D*)
>=20
> - UDMAP DMAengine driver:
>  - Squashed the split patches
>  - Squashed the early TX completion handling update
>    (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D=
210713&state=3D*)
>  - Hard reset fix for RX channels to avoid channel lockdown
>  - Correct completed descriptor's residue value
>=20
> Changes since v5:
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D20=
1051&state=3D*)
> - Based on 5.4
>=20
> - cppi5 header
>  - clear the bits before setting new value with '|=3D'
>=20
> - UDMAP DT bindings:
>  - valid compatibles as single enum list
>=20
> - UDMAP DMAengine driver:
>  - Fix udma_is_chan_running()
>  - Use flags for acc32, burst support instead of a bool in udma_match_d=
ata
>    struct
>  - TDTYPE handling (teardown completion handling for j721e) is moved to=
 separate
>    patch as the tisci core patch has not moved for over a month.
>    Both ti_sci and the iterative patch to udma is included in the serie=
s.
>=20
> Changes since v4
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D19=
6619&state=3D*)
> - Based on 5.4-rc7
>=20
> - ringacc DT bindings:
>  - clarify the meaning of ti,sci-dev-id
>=20
> - ringacc driver:
>  - Remove 'default y' from Kconfig
>  - Fix struct comments
>  - Move try_module_get() earlier in k3_ringacc_request_ring()
>=20
> - PSI-L thread database:
>  - Add kernel style struct/enum documentation
>  - Add missing thread description for sa2ul second interface
>  - Change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
>=20
> - UDMAP DT bindings:
>  - move to dual license
>  - change compatible from const to enum
>  - items dropped for ti,sci-rm-ranges-*
>  - description text moved from literal block when it is sensible
>  - example fixed to compile cleanly
>   - added parent to provide correct address-cells
>   - navss is moved to simple-mfd from simple-bus
>=20
> - UDMAP DMAengine driver:
>  - move fd_ring/r_ring under rflow
>  - get rid of unused iomem for rflows
>  - Remove 'default y' from Kconfig
>  - Use defines for rflow src/dst tag selection
>  - Merge the udma_ring_callback() and udma_tr_event_callback() to their=

>    corresponding interrupt handler
>  - Create new defines for tx/rx channel's tisci valid parameter flags
>  - Remove re-initialization to 0 of tisci request struct members
>  - Make sure that vchan tasklets are also stopped when removing the mod=
ule
>  - Additional checkpatch --strict fixes when it made sense
>   - make W=3D1 was clean
>=20
> - UDMAP glue layer:
>  - Remove 'default y' from Kconfig
>  - commit message update for features needing the glue layer
>=20
> Changes since v3
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D18=
0679&state=3D*):
> - Based on 5.4-rc5
> - Fixed typos pointed out by Tero
> - Added reviewed-by tags from Tero
>=20
> - ring accelerator driver
>  - TODO_GS is removed from the header
>  - pm_runtime removed as NAVSS and it's components are always on
>  - Check validity of Message mode setup (element size > 8 bytes must us=
e proxy)
>=20
> - cppi5 header
>  - add commit message
>=20
> - UDMAP DT bindings
>  - Drop the psil-config node use on the remote PSI-L side and use only =
one cell
>    which is the remote threadID:
>=20
>      dmas =3D <&main_udmap 0xc400>, <&main_udmap 0x4400>;
>      dma-names =3D "tx", "rx";
>=20
>  - The PSI-L thread configuration description is moved to kernel as a n=
ew module:
>    k3-psil/k3-psil-am654/k3-psil-j721e
>  - ti,psil-base has been removed and moved to kernel
>  - removed the no longer needed dt-bindings/dma/k3-udma.h
>  - Convert the document to schema (yaml)
>=20
> - NEW PSI-L endpoint configuration database
>  - a simple database holding the remote end's configuration needed for =
UDMAP
>    configuration. All previous parameters from DT has been moved here a=
nd merged
>    with the linux only tr mode channel flag.
>  - Client drivers can update the remote endpoint configuration as it ca=
n be
>    different based on system configuration and the endpoint itself is u=
nder the
>    control of the peripheral driver.
>  - database for am654 and j721e
>=20
> - UDMAP DMAengine driver
>  - pm_runtime removed as NAVSS and it's components are always on
>  - rchan_oes_offset added to MSI dommain allocation
>  - Use the new PSI-L endpoint database for UDMAP configuration
>  - Support for waiting for PDMA teardown completion on j721e instead of=

>    returning right away. depends on:
>    https://lkml.org/lkml/2019/10/25/189
>    Not included in this series, but it is in the branch I have prepared=
=2E
>  - psil-base is moved from DT to be part of udma_match_data
>  - tr_thread maps is removed and using the PSI-L endpoint configuration=
 for it
>=20
> - UDMAP glue layer
>  - pm_runtime removed as NAVSS and it's components are always on
>  - Use the new PSI-L endpoint database for UDMAP configuration
>=20
> Changes since v2
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D15=
2609&state=3D*)
> - Based on 5.4-rc1
> - Support for Flow only data transfer for the glue layer
>=20
> - cppi5 header
>  - comments converted to kernel-doc style
>  - Remove the excessive WARN_ONs and rely on the user for sanity
>  - new macro for checking TearDown Completion Message
>=20
> - ring accelerator driver
>  - fixed up th commit message (SoB, TI-SCI)
>  - fixed ring reset
>  - CONFIG_TI_K3_RINGACC_DEBUG is removed along with the dbg_write/read =
functions
>    and use dev_dbg()
>  - k3_ringacc_ring_dump() is moved to static
>  - step numbering removed from k3_ringacc_ring_reset_dma()
>  - Add clarification comment for shared ring usage in k3_ringacc_ring_c=
fg()
>  - Magic shift values in k3_ringacc_ring_cfg_proxy() got defined
>  - K3_RINGACC_RING_MODE_QM is removed as it is not supported
>=20
> - UDMAP DT bindings
>  - Fix property prefixing: s/pdma,/ti,pdma-
>  - Add ti,notdpkt property to suppress teardown completion message on t=
chan
>  - example updated accordingly
>=20
> - UDMAP DMAengine driver
>  - Change __raw_readl/writel to readl/writel
>  - Split up the udma_tisci_channel_config() into m2m, tx and rx tisci
>    configuration functions for clarity
>  - DT bindings change: s/pdma,/ti,pdma-
>  - Cleanup of udma_tx_status():
>   - residue calculation fix for m2m
>   - no need to read packet counter as it is not used
>   - peer byte counter only available in PDMAs
>   - Proper locking to avoid race with interrupt handler (polled m2m fix=
)
>  - Support for ti,notdpkt
>  - RFLOW management rework to support data movement without channel:
>   - the channel is not controlled by Linux but other core and we only h=
ave
>     rflows and rings to do the DMA transfers.
>     This mode is only supported by the Glue layer for now.
>=20
> - UDMAP glue layer
>  - Debug print improvements
>  - Support for rflow/ring only data movement
>=20
> Changes since v1
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D11=
4105&state=3D*)
> - Added support for j721e
> - Based on 5.3-rc2
> - dropped ti_sci API patch for RM management as it is already upstream
> - dropped dmadev_get_slave_channel() patch, using __dma_request_channel=
()
> - Added Rob's Reviewed-by to ringacc DT binding document patch
> - DT bindings changes:
>  - linux,udma-mode is gone, I have a simple lookup table in the driver =
to flag
>    TR channels.
>  - Support for j721e
> - Fix bug in of_node_put() handling in xlate function
>=20
> Changes since RFC (https://patchwork.kernel.org/cover/10612465/):
> - Based on linux-next (20190506) which now have the ti_sci interrupt su=
pport
> - The series can be applied and the UDMA via DMAengine API will be func=
tional
> - Included in the series: ti_sci Resource management API, cppi5 header =
and
>   driver for the ring accelerator.
> - The DMAengine core patches have been updated as per the review commen=
ts for
>   earlier submittion.
> - The DMAengine driver patch is artificially split up to 6 smaller patc=
hes
>=20
> The k3-udma driver implements the Data Movement Architecture described =
in
> AM65x TRM (http://www.ti.com/lit/pdf/spruid7) and
> j721e TRM (http://www.ti.com/lit/pdf/spruil1)
>=20
> This DMA architecture is a big departure from 'traditional' architectur=
e where
> we had either EDMA or sDMA as system DMA.
>=20
> Packet DMAs were used as dedicated DMAs to service only networking (Kes=
ytone2)
> or USB (am335x) while other peripherals were serviced by EDMA.
>=20
> In AM65x/j721e the UDMA (Unified DMA) is used for all data movment with=
in the
> SoC, tasked to service all peripherals (UART, McSPI, McASP, networking,=
 etc).=20
>=20
> The NAVSS/UDMA is built around CPPI5 (Communications Port Programming I=
nterface)
> and it supports Packet mode (similar to CPPI4.1 in Keystone2 for networ=
king) and
> TR mode (similar to EDMA descriptor).
> The data movement is done within a PSI-L fabric, peripherals (including=
 the
> UDMA-P) are not addressed by their I/O register as with traditional DMA=
s but
> with their PSI-L thread ID.
>=20
> In AM65x/j721e we have two main type of peripherals:
> Legacy: McASP, McSPI, UART, etc.
>  to provide connectivity they are serviced by PDMA (Peripheral DMA)
>  PDMA threads are locked to service a given peripheral, for example PSI=
-L thread
>  0x4400/0xc400 is to service McASP0 rx/tx.
>  The PDMa configuration can be done via the UDMA Real Time Peer registe=
rs.
> Native: Networking, security accelerator
>  these peripherals have native support for PSI-L.
>=20
> To be able to use the DMA the following generic steps need to be taken:=

> - configure a DMA channel (tchan for TX, rchan for RX)
>  - channel mode: Packet or TR mode
>  - for memcpy a tchan and rchan pair is used.
>  - for packet mode RX we also need to configure a receive flow to confi=
gure the
>    packet receiption
> - the source and destination threads must be paired
> - at minimum one pair of rings need to be configured:
>  - tx: transfer ring and transfer completion ring
>  - rx: free descriptor ring and receive ring
> - two interrupts: UDMA-P channel interrupt and ring interrupt for tc_ri=
ng/r_ring
>  - If the channel is in packet mode or configured to memcpy then we onl=
y need
>    one interrupt from the ring, events from UDMAP is not used.
>=20
> When the channel setup is completed we only interract with the rings:
> - TX: push a descriptor to t_ring and wait for it to be pushed to the t=
c_ring by
>   the UDMA-P
> - RX: push a descriptor to the fd_ring and waith for UDMA-P to push it =
back to
>   the r_ring.
>=20
> Since we have FIFOs in the DMA fabric (UDMA-P, PSI-L and PDMA) which wa=
s not the
> case in previous DMAs we need to report the amount of data held in thes=
e FIFOs
> to clients (delay calculation for ALSA, UART FIFO flush support).
>=20
> Metadata support:
> DMAengine user driver was posted upstream based/tested on the v1 of the=
 UDMA
> series: https://lkml.org/lkml/2019/6/28/20
> SA2UL is using the metadata DMAengine API.
>=20
> Note on the last patch:
> In Keystone2 the networking had dedicated DMA (packet DMA) which is not=
 the case
> anymore and the DMAengine API currently missing support for the feature=
s we
> would need to support networking, things like
> - support for receive descriptor 'classification'
>  - we need to support several receive queues for a channel.
>  - the queues are used for packet priority handling for example, but th=
ey can be
>    used to have pools of descriptors for different sizes.
> - out of order completion of descriptors on a channel
>  - when we have several queues to handle different priority packets the=

>    descriptors will be completed 'out-of-order'
> - NAPI type of operation (polling instead of interrupt driven transfer)=

>  - without this we can not sustain gigabit speeds and we need to suppor=
t NAPI
>  - not to limit this to networking, but other high performance operatio=
ns
>=20
> It is my intention to work on these to be able to remove the 'glue' lay=
er and
> switch to DMAengine API - or have an API aside of DMAengine to have gen=
eric way
> to support networking, but given how controversial and not trivial thes=
e changes
> are we need something to support networking.
>=20
> The series (+DT patches to enabled DMA on AM65x and j721e) on top of 5.=
5-rc1 is
> available:
> https://github.com/omap-audio/linux-audio.git peter/udma/series_v7-5.5-=
rc1
>=20
> Regards,
> Peter
> ---
> Grygorii Strashko (3):
>   bindings: soc: ti: add documentation for k3 ringacc
>   soc: ti: k3: add navss ringacc driver
>   dmaengine: ti: k3-udma: Add glue layer for non DMAengine users
>=20
> Peter Ujfalusi (9):
>   dmaengine: doc: Add sections for per descriptor metadata support
>   dmaengine: Add metadata_ops for dma_async_tx_descriptor
>   dmaengine: Add support for reporting DMA cached data amount
>   dmaengine: ti: Add cppi5 header for K3 NAVSS/UDMA
>   dmaengine: ti: k3 PSI-L remote endpoint configuration
>   dt-bindings: dma: ti: Add document for K3 UDMA
>   dmaengine: ti: New driver for K3 UDMA
>   firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx
>     channel
>   dmaengine: ti: k3-udma: Wait for peer teardown completion if supporte=
d
>=20
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   |  185 +
>  .../devicetree/bindings/soc/ti/k3-ringacc.txt |   59 +
>  Documentation/driver-api/dmaengine/client.rst |   75 +
>  .../driver-api/dmaengine/provider.rst         |   46 +
>  drivers/dma/dmaengine.c                       |   73 +
>  drivers/dma/dmaengine.h                       |    8 +
>  drivers/dma/ti/Kconfig                        |   24 +
>  drivers/dma/ti/Makefile                       |    3 +
>  drivers/dma/ti/k3-psil-am654.c                |  175 +
>  drivers/dma/ti/k3-psil-j721e.c                |  222 ++
>  drivers/dma/ti/k3-psil-priv.h                 |   39 +
>  drivers/dma/ti/k3-psil.c                      |   97 +
>  drivers/dma/ti/k3-udma-glue.c                 | 1198 ++++++
>  drivers/dma/ti/k3-udma-private.c              |  133 +
>  drivers/dma/ti/k3-udma.c                      | 3452 +++++++++++++++++=

>  drivers/dma/ti/k3-udma.h                      |  151 +
>  drivers/firmware/ti_sci.c                     |    1 +
>  drivers/firmware/ti_sci.h                     |    7 +
>  drivers/soc/ti/Kconfig                        |   11 +
>  drivers/soc/ti/Makefile                       |    1 +
>  drivers/soc/ti/k3-ringacc.c                   | 1180 ++++++
>  include/linux/dma/k3-psil.h                   |   71 +
>  include/linux/dma/k3-udma-glue.h              |  134 +
>  include/linux/dma/ti-cppi5.h                  | 1061 +++++
>  include/linux/dmaengine.h                     |  110 +
>  include/linux/soc/ti/k3-ringacc.h             |  244 ++
>  include/linux/soc/ti/ti_sci_protocol.h        |    2 +
>  27 files changed, 8762 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.ya=
ml
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc=
=2Etxt
>  create mode 100644 drivers/dma/ti/k3-psil-am654.c
>  create mode 100644 drivers/dma/ti/k3-psil-j721e.c
>  create mode 100644 drivers/dma/ti/k3-psil-priv.h
>  create mode 100644 drivers/dma/ti/k3-psil.c
>  create mode 100644 drivers/dma/ti/k3-udma-glue.c
>  create mode 100644 drivers/dma/ti/k3-udma-private.c
>  create mode 100644 drivers/dma/ti/k3-udma.c
>  create mode 100644 drivers/dma/ti/k3-udma.h
>  create mode 100644 drivers/soc/ti/k3-ringacc.c
>  create mode 100644 include/linux/dma/k3-psil.h
>  create mode 100644 include/linux/dma/k3-udma-glue.h
>  create mode 100644 include/linux/dma/ti-cppi5.h
>  create mode 100644 include/linux/soc/ti/k3-ringacc.h
>=20

--------------0B3EC23F076E74A147622A00
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBF25dUsBEADL8pQoeh8YauTWhoIT64p8i9ImJ0npQJs5inE+hAd1bPTS5fX5
gHOEcFT3NWj7D80O92Z2WAGG74A5hXWkQ4Uioe6622ZiiojTBdKcQv4S+vUURsvw
EFB4qgyC8xrwuOmTPUtKbRW362eypHtPUygwrQVGQpqkbUazUfC6sAGITtpbcbo1
3brdf3sjbPzTX2VomnpzgdQe8OjEzsDQoXYEt1T3FrMIrJQshK2oMJuEAu2+H6Z1
idN3P7skvtxGPIeygHqIjz+WraWwdc19npapoB0w70NLScF4pxI274bNLwDxRerB
IxAA3pmU9HbXtuZZwPpFiBiPHLBDJuxJvC6QJzANtlgGaSX7lTt4kuv3KOxtemvl
dCASLLes/naNlPJzTbkKHjlOe7yAECqSdXwRBLOlyKGPOjhtT0LPx1iG+qk+TsHZ
9BcifgdHTtJRY+g1yKpz7qTD8RuFLOA6uQhoV2gzbufguqebDs9MnFCMXClRw5iH
MMzHHPIZyNJDb/sRUPzMY8VftaLm7rvKzGCjTMRbEG81rYHxefAR5PNizir27wwb
dCzWBdHmq87mtMm+SE2We8SYslfQ1dQavZEaeedEGaGUNL0nfc4c82F9IxCMe4VW
wKwAAcPaXaM10YPrSYETmm9UxliaPawfX9zZEzF6+KuHz7kcKD5dZIRPNQARAQAB
tBpLZWVydGh5IDxqLWtlZXJ0aHlAdGkuY29tPokCVwQTAQoAQQIbAQUJA8JnAAUL
CQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBNm5dn8VWu87So9MgPeF3ucaCl3FBQJd
uXfIAhkBAAoJEPeF3ucaCl3FXusQAL1OlXreAaXR0RCJaPm70s/l0HIgQI46ED7C
anjvyRjy98/+DCYYRrEhLsBC7PGR1p4HAaeeMpG7+3frgTtG0LNBgWHppyJacKEk
GDclbbOyoHpu3HuIC+5mn3XUZn9A8aRuxik6ckI+3w9js/bFmNGFnwIDut/4jDfn
K29aq8r7mnCuwIvSgKrqYLPpCQDswcGE+bEly+YDN1uIkaiCwP7zLyxOVCeVS8cy
sLCVLxxNikOBuvG2Hv/ZU+XTRtwSJF0lNZAcpBBt1PKHaQEsheqEukD2an64QMb1
1l/dblL9AoZ/F3snjgtel//AmgAbptAWRYhhjT9NLquf6gx9cyHQkpm8yJmn+B7N
RjCm/uzKpDjPIM0SneYHAn2QUAX8xJZX96lQ2lMppvlAgs/KxSJ0IWZqTztaMTpE
lnhKGk1uBBk/wrVpXHTLq7eS6/a0Ag5xYB6vP1Zfs8ElM6fzcR4OnVF2Kdg7hA/z
bLTYP8Kyk/5z7i0MfesC1NKT6Kvh7JxrFgMBFIoARsfHi66yKlmxHyeTOL4V2Mum
YKPWPQWVm7fHTWJMRkgYLYBVfq+GhWLY1FLKx4ACUj+VXxCs8CjAtUAgPDf3VLk8
qSw82+/udSUzGDNbeWNZnwTA3HG2I2f4cGDZCGpo4ualvUEkZIKT5G+TO6MOO8YE
DeWvqSyfiQIzBBABCAAdFiEEFp3rbAvDxGAT0sefEacuoBRx13IFAl3B4q0ACgkQ
EacuoBRx13LbZw//aT7uB9RGgq6iyBfzg68HKIZUsxlrTUEtQFazX46QhOhAUuGE
vXJDUSm87tkx0MOCTwpunA2EONGZJ/1orpiYCuYcu3RPMwgqgLZn19xNsCO11y6L
mNU7v+oIsLAEYHFCIMhu+6BY+/Rp0VNxLXAlS+3r+xMdW0G4cuxW1v0DTcsON1y0
hPYSdgigba7k2E/vahKJ0HlzR7/1es5dQQ4L3SsdMHigGvhwcnfQaHr9dfb8AZ0n
GmjnoXVZdw4xjyH9UPQML+/vVrgYVeZBDuhA/sU1qaEX/Eq8fRoDXhvPPFhWoNGQ
uWdbjnbHyUsl5QtNs6kZh4/uispUr5dAQMK0zCS/v4QrXDWqTd9u55mrLwv8YmDp
CW3xd5W5dnV4rtgTiDqrViTWP09qjetzcQh4uvVx40S9kaUD8cnI+a86XleN4m0c
Fzvzk2KXjnLBX7fLRlL/LgqPGTlEvsPBbbmcINIgZB4P5jaP/sqb/oFEi5fROpQS
NIixWoGuUrWoYiN4KM1Ka+Xbuetfj5GdGRRRZebJ6hWqhKFzRAV8pL08+CeLdTvD
hRarTglh40/iZ8n09NOZvH/NjGHnxZZ/zlNjDmi9fzoik0J0vJfJ3TlLSNJGugUL
s73h7ZpJ5EZeu6HA+eityQVPnKB+WEIB4yXOZTbRkVUTKmfI8/o57jseWJaJAjME
EAEKAB0WIQS1DqzMeZ+IFPt+6OTK+r0xeVAaEQUCXcFBPgAKCRDK+r0xeVAaEajt
D/4zOCTMPpSK5gh6WbUX2nezD2ni1qmV0dYx8HVztMCT1sEAM8EZWe2XqGhLffD0
LgVAijYjhhDwVn8bxiUvcyIKQos+FlBSGzn6WULwxggHA2kPi4VbdxI7YjczMKUy
RxBIezkI3YX+zixKtLn5bYRVm7OGxNU9vxrMvCHp/pI0V9OrTbw8OH6l8ooG03Pd
TKUnFudzHdKT0D7Ef0MHkiQSLaPhIIAeYt/lavN9MTq2w8INcs999Qk+hSQmePRc
b3ST1oSDJE1JycFZL4RQB/h9Lrnf6NRgE8h4v773oWg+/r7CGht68IGUrm4T2dU/
lu6sG9QCGcqm+DjEDsA7Zk9gqfNv+xlRSOE0vr5jxASM3ON6LsrMSFaLg28lHV90
DQ9n438gdEb2zgZnrk7ur3Te+P0oHM+yqickNDWwcV5ntaxKBPVhQjf5DjMQya/m
X9GySR02s24fPlIKCOZhGCTjH/jWonS2pyXmWEnlwJGs5z2kd7821Dcq4Qslm+oK
OmTqyEW+EuKXtwyWTePLJkbMPqiJHVQE2uSozjhzeOE8q25nfJIpWiSYs2KLgtRK
WqmPWD7JeF4Fw/t5oILfTKPzd22z9SJhZzOwd9LKLKZaNpBnSl96qBPYX3VDU5/y
9Jxja2PyQGrOuUBlyBFxHspVXyB65gasd9uJD+qN2kSRpYkCMwQQAQoAHRYhBNQm
V/Zb651FoAT8+qbNnwlvZCyzBQJdzrjQAAoJEKbNnwlvZCyzAMQP/1ElN5RmuVzi
Cm++rH/II/uKq5t20aTM75YD4Zfyv3imjxtmKK/I8XtoiQgsR8gHFAJvDuxFNEKB
c74ME64UsG6RtxYqjZa/qza3MoMDapS9WvXm2Xvj0zDRLHg9/JZrxjQfqrCIcHCz
c3MrwKImDq69FtjIFCSDIBfFDHVaKEhSZgMutHzGrT4RGW6ibi1ZvaBGhs1emCGP
+DGiMGb9sgZC9w9G9GQGGE1mhNltNCE6oMGClBjKt6sU7aVV3lBVpT+wdr5mslOD
drsfAlFcODvEPNf2cqG1uV/WurryXUkDwoEQuyizZHmirDl0NdArtq7f5HxSAmBc
KFga014N7nlvZYVIPCFRAPNf6NOT/ualDqSkYOAKP/TU5jg2f2U/Vxqc5BaM6JO9
OPpZQ5H1j0T+DnXG3CW7cYT0TElVN4dkT1ljjifg+dTLSGdLa2H1L52Ee3gTz9YK
o6GqySknO6paECFtsK3Ae/8SNFQrX4IdD1ClzeAO2xzZfBdNec2QCvzwokvbkqs7
lhyOn1NfGFSLr+gRQ89gVzofSM51E2QEp3Qriw1wp8kMYoK5XpOXVPdKGUF6NXQi
Y0SDkDxajniUBZupTdsNXSbehTnoI8ZPMwM6QluOcwAxd1bewdXUkI5W21rkypGo
+48u2yZe+Zsj77HpVrB7639LOgBrvZNouQENBF25eAABCADkpdpp94dZvAS0jI1N
YOaTMwEuI9IbgPyTF3TGAm/DXrjd1JOMbs1tlYcxOmACOh5l6ClGk8S4UDRa5BXa
nRvwEgO6eWcurA4DpFbMW2lWX5oJwZ71KUaHKHDrww3L/aEN3BiwSnZodOtZ2zqi
cwShuEPruFZLSc1aK+XRiSLHJ1vr1TqgewxNn7ZLxSaeEKWjgldx6TIIEe3Ac/mO
v6kyJlniQLgbq6ue7Lf43UuDP+0m9IwkYqpGeVEdEGcT7LXm51ylC4i2N46mRFh/
Fm3KdnHoaxvz8s5B4MqyV+K1WTvjMbyGs+vuq3/qUBm1wbJagD4i7csVttS2oV52
EfxHABEBAAGJAjYEGAEKACAWIQTZuXZ/FVrvO0qPTID3hd7nGgpdxQUCXbl4AAIb
DAAKCRD3hd7nGgpdxRzJD/9o/Pz/iTB87Du9xqPeiivppkMphTS6UxSVhAuQq1X8
KsWo80gAxbU4Rw7yCu6ej99hetuPfSVhwk8oKFtb+tTknv86Ow1PmyfVxNBRLOBl
0DvOYtOGGADxwj+hnLicxLz0cwfkto7GjOAkxP1McK55q7jEpJN8q4Dv1u7gWy8q
vm3icIFFEsrmOLb0RCBymJF7Gss/GFF+zkNqbg9JPIIyzUTMdo6KvT0f+pTpd5bK
wfmNiRgnulpMerh0mMOhQ1Vhaax2WdqPgZe0S6zwm+Fd02nOu4VPhFlHajRkuTOq
VWTSsBD0NeC3/7pINJx2wRzY0evamFGXepjdzvt3ys5ldBBSTEe/etiRJwTONKDf
DHMfdUVcy73b170XOKtR4pcUMwgGSe1MA6Tn74FmqhMCBAwl+KaRsl8Hb5FaEW7I
TGjpkxfaCrhRj8V9Y06ZV68TnkJGTTPLdhjN3AR8FNgRO5DMZ+TtGaG+gcIwT59+
HEBJQ9JAeNP+N1Bdfh70oFTzJBPKdOBWevRjxOYX5EgAUwpCLVLhKlqFsxsexXQy
H7+k+DoAjMK6eAXZIyO+Wye+ihIPOBbGVBhODHW+zLCJZoLyjWFojF7j6Oi/6FVH
CNm3SPWi7L2hHeFrtuoCoobspmnkfhSUZnL0Uf+UDZFzd7x7dCjEGP2l2D1M23qX
DLkBDQRduXgUAQgAweYjNMbU8XDYMCUVxC0Wdpr9g9+8XStUza23LIBlHIhTXA0i
tf6kPAn3dX21TIKBHm3QQSKRTKn5VdJiuS7Vz+z357I7k8xT16MGqsNlCI+ZgYJF
L0TcVm41JdhihPU8pQ+q6C04Bpg0h75sByTmBe9rYb6CMolVhCKd4DJbrk2DTkkM
O3hQWeMMpDikEQ61eozN/rXOQBn6HLN3UCglivkWeHac2O55OuKbXZOpa+k9Zepr
G6hhofl7VyYU3OSLr77xAiGvR1l+DO6ItjD7VxHpHmZ22643ux7R3ukBvFVEHPTQ
dC/320N5X9SpLKvLt+EBe8GuzeYbQpqSLg8IgwARAQABiQI2BBgBCgAgFiEE2bl2
fxVa7ztKj0yA94Xe5xoKXcUFAl25eBQCGwwACgkQ94Xe5xoKXcWIAxAAv3gLrDKU
3HuUitGB/YKNC69zt0+LNSDGD7RP+BRs5YLOfXESfUeVUdFDhBYMlRcD0Lf04C2E
+1RRAOOYjge0kAQb7gnMxJ3FQXJjII+06kAzgscMLJltwezb0l6YNzCRVemTnerY
Y7uecDvs1QiAePBuib/yccKTrXgCjTFM+e8MAcSxU524AHhSzD9co9dz4+3nGC8X
NKjyQ03hwOtzQce0nNdxoqz1OfNyczTOhIFNcUQ6ZMj+UHDQOuv1RFLIByNchRZq
en+2RYqyw+B9T7Bv60rhWJBe9HOqFU2/fL8v/9JKRyJgzcocAodNcx/tvDtziEVJ
Vb3TKNeX4ds/2iBCwdjq/tSi7/JcFIKCvJ7aBxBMtylonPIaFzDWQQ8aCO44ZvAS
BqbFAxtPZM3/YnPZfcCYZiw67A2W9Tro5fYle4C1PD/RrxD5S3Iu6CO03I37Vad5
gTf0Y8yqEOFPO3/pvr9GEhT+mQc1m8pZ4/x0W9UW9B31oIjcSON1H6DEYpyxJOk7
8LJ6qu+HFGqBejbBcttYgocDRQkw7UKG9vHPLX/T5ipGDWmbV3tg6wdwJTEOx46z
k0PVqwppMESJEqhVEk/DrzStXzWeOCR+PCAnTNThuJXif9nVQBdNpUErFa1hz4u2
+5qoalaPUB9XWlwTMwf4uJPHYL1idZde2Na5AQ0EXbl4UwEIALzs1vW88r85QT1a
Obv6NpV0Ft+PdfRV4z1Dp3uOEExRjl36JJAfvwMngXz08nXn+gMMjSfZvOtONeJM
VzTssK7OpqxjsBaPLVj55V3GknSXhGBhFldhi0UfIi3TP4KY5N5FfMl7SiiwwZuk
iwcW554uZQsF8XNZ4L9eqL57n7ty7xtSpr0C5l0rL3xgbGzbnqtpv9DhhLfgfQgG
Cn70PtDpk9eqv1kveaEhKD8aWcg+PS88AxlN7byrJY7X1/fDvXQwmz6KruXDzkMf
mCXpfCgp7Q0x4kLRnPvZYNcvx1YnQ0XjRBz9Uwk0nFOiTRiIlJFTw3b/Spl7ifvm
r8l4MzsAEQEAAYkDbAQYAQoAIBYhBNm5dn8VWu87So9MgPeF3ucaCl3FBQJduXhT
AhsCAUAJEPeF3ucaCl3FwHQgBBkBCgAdFiEES1vbPWUXe7W2hFKzaVeKdsnNjuIF
Al25eFMACgkQaVeKdsnNjuLLLQgAsCIbhWqj2cUEn2hVA+OzxPb1QSBhXataEcQo
KwU3zZP2l/jYTpY2KP3aMneT/C3gjkriEJstzZtvdoXo22bvtWbB1mBVcOkJyNZu
Hv/gr74CZJZfOavW5B2oLg2QdcEZne84Ph3apA5lofNbFCXO0LnI80qAUOKZM1+j
CK5O17VJqx9D52tn1/ooe7aQ6KVsgw/I6m8Q5d5CKX3Quq8RWS6Mpbfotqld3LSL
kilHYKCctgJwZPbirrsd2EtldaTEid4gQSTKxCwb/7TqTdehMqnhlm6x8RIhkoIA
5D9EFKb+fauDC0dpsCO0mDErTC0ZP9p8vQIPxc9SpT15y/W2kOeuEACMTGBExrIa
P/hvEXd1dW56hvD45z8SbL0pdd3T7sUdxR6JXibh7NK4dpd3qggKwM5NapR7NIQd
cqa48bIfJT3jiLPFFqv/nssQifCag2kM5ji2IfIjSO2hNzMhU1tqhaCwyvy/7HKd
2pt7Wk4ni6AKRPJX+3qQXuB/8V6U3lu6kWioF7oPsXfmhqxrg57YErdPKfxk0Mza
+WuU63L8WRxm7Kz8zjxY1r8U40WAXiHMIP0g9/zqeWffpq0C10/X4T42tKc5c9sP
ZkzX9VQ2SI8ZbaW4InclbOKmMMi7YijsTgPlojuDKpws3KDPQCx/bqVXeeRa34js
bJcxqE7Z1lPat+4hL/YLjm+iD9ftQpCxFWjkeh2XUjAgf8CXYB8aH01VywXd/KZI
QQB88obd2TXw3U9CpPN29qsQDrzeD+LsrrwQP0kLofytQcHtdgQ9FDHZcLShwxzQ
AlJHedTo5ohPX/idizf2ZU4LAhopg2Umkb4yLewxvtjN/psSSaNkNfDiWf9lMJR+
5aWbqZrRMt8SxXfZGViBUzCM9/nL9LFex27yBccs8OUir52jn55I4eT0R3MW2UPp
NUOCApnv9kBzOAsoU3SLS/+2z+IVlKrwj3gaNel975QhaUfjUNWBKAZoNO1/emYW
kPgXPpKlf8eCKTBUOtaS2Sme4aWvXjNuPbkBDQRduXknAQgAxA3jC2gUypuj8oK7
0cFTZXunaKJP+gRZ5KgGWV0RcYpM70qfgme9pdalf4b8ajUhLdgVDs3YTybDkJMO
DJCp3/+nbHqMG+0riYRvWIT8g+nFuQofKHU575fZWCz/sLZl5xR5j0DN43uFRKLv
DAqlS4NMNw3otqimXe9A5M+WBKwgKdN77kEc+oGJLXXHBE7wV9AOphdOTHM6ktW2
BeuXsAU+AA6zZXgOlYoqZxmRSsV2pGoyt6mJy5qZ0T1vda3ut7ymh5610iKV5a4P
+URAGX50Qa5wesHOT4RJ/XLe668m1CJfomNH2qsAGP3gPBIFyvnHoy06nWKBL62d
8lq7TwARAQABiQI2BBgBCgAgFiEE2bl2fxVa7ztKj0yA94Xe5xoKXcUFAl25eScC
GyAACgkQ94Xe5xoKXcU0ihAAm0KdP5D8CNngSidQov2isBbQcimG78k/6a8HADBV
n7QXH8by5SGANcabxqN3sPOlCnhRXSWBdlW4pWJR4aiFsnAEhOO6LSUkz33UDH8p
nudBHS/TPSSgA5AdCUIjnfLZW+C18kLFuhTeWtVvLkS9ea80MQlqGpKLjbBDxCB6
x5ufl+OFGvVbwOsGtCzLjqe+g8NVyWRNxDwsxKNg/W1brI2uMPgjxkB+q+uRDsiD
ETZzUgXRG9yuJFe3XysJpA+h/wbVqk40zbDeoeaSXp9vYAirO/gYJn7TzaeWAnVE
GE0Os02x6jRTdXBSJBNkp2bd/flRCuF40FuEFYb89DPg96sWdKoT2EmJH37X5z9i
RjLIYJqEmO+YRUQ4t4qkzOedHJAbDY2TG20UXWPFNnetjyDjgKFJ3bcNcMCydjEy
hqxc/NtmxGmvXKqxHQlf6dT8eYz2BDcz4jBUDd6Kd0gynfC3vkNtkEMGgwblmO/z
SlYm7I90hZjRaMDc/7ws2flV3Vhl0h3XJUiO1xj6PB8wj/s7H79dt4Llw1euP2Lk
6UC/C/gAyNjeY4pqlOjhzMaiDIfNZ/Xv0dKojY+lFGgdnxhwbZkSBii0Qm+3knu8
jwYBreD7Il7Yzl26wDoyIO9oxMu4sqLHwlwa0YSvRVh3y3HuIX4S0OrS+jAWJYCN
Xpo=3D
=3DNfsW
-----END PGP PUBLIC KEY BLOCK-----

--------------0B3EC23F076E74A147622A00--
