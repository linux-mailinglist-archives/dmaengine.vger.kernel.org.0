Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2C27E65B
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgI3KRb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 06:17:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37620 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3KRa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 06:17:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UAHNPb089132;
        Wed, 30 Sep 2020 05:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601461043;
        bh=ZYb+hBaKHc6FtE4XllCT+2zdmmxIQbfBch8zjZIa10I=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=snmWLF475Xm5WZep4rXAVg9agQMzlWjT2TcEITjsgTZRreDog9RotQEOikppRUoji
         HbceqboKX567/O7/832Gqp1TP8Sfg6WyeOEV7ZNb0rWML2A1/Z6sz0ObIcGSD8iM+U
         aAmODTQ45t7A3w41EkZ5IL3tHDdyetvx6oxZ3GXY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UAHMS1016703
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 05:17:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 05:17:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 05:17:22 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UAHJA6101870;
        Wed, 30 Sep 2020 05:17:20 -0500
Subject: Re: [PATCH 00/18] dmaengine/soc: k3-udma: Add support for BCDMA and
 PKTDMA
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <5be85c37-51b8-589c-5c8c-11154342c4f5@ti.com>
Date:   Wed, 30 Sep 2020 13:17:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930091412.8020-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 30/09/2020 12.13, Peter Ujfalusi wrote:
> Hi,

for some reason I have missed Grygorii from the TO, sorry.

Grygorii: the series in lore:
https://lore.kernel.org/lkml/20200930091412.8020-1-peter.ujfalusi@ti.com/=


> The series have build dependency on ti_sci/soc series (v1):
> https://lore.kernel.org/lkml/20200928083429.17390-1-peter.ujfalusi@ti.c=
om/
>=20
> The unmapped event handling in INTA is also needed, but it is not a bui=
ld
> dependency (v2):
> https://lore.kernel.org/lkml/20200930074559.18028-1-peter.ujfalusi@ti.c=
om/
>=20
> The DMSS introduced within AM64 as a simplified Data movement engine is=
 built
> on similar grounds as the K3 NAVSS and UDMAP, but with significant arch=
itectural
> changes.
>=20
> - Rings are built into the DMAs
> The DMAs no longer use the general purpose ringacc, all rings has been =
moved
> inside of the DMAs. The new rings within the DMAs are simplified to be =
dual
> directional compared to the uni-directional rings in ringacc.
> There is no more of a concept of generic purpose rings, all rings are a=
ssigned
> to specific channels or flows.
>=20
> - Per channel coherency support
> The DMAs use the 'ASEL' bits to select data and configuration fetch pat=
h. The
> ASEL bits are placed at the unused parts of any address field used by t=
he
> DMAs (pointers to descriptors, addresses in descriptors, ring base addr=
esses).
> The ASEL is not part of the address (the DMAs can address 48bits).
> Individual channels can be configured to be coherent (via ACP port) or =
non
> coherent individually by configuring the ASEL to appropriate value.
>=20
> - Two different DMAs (well, three actually)
> PKTDMA
> Similar to UDMAP channels configured in packet mode.
> The flow configuration of the channels has changed significantly in a w=
ay that
> each channel have at least one flow assigned at design time and each fl=
ow is
> directly mapped to corresponding ring.
> When multiple flows are set, the channel can only use the flows within =
it's
> assigned range.
> PKTDMA also introduced multiple tflows which did not existed in UDMAP.
>=20
> BCDMA
> It has two types of channels:
> - split channels (tchan/rchan): Similar to UDMAP channels configured in=
 TR mode.
> - Block copy channels (bchan): Similar to EDMA or traditional DMA chann=
els, they
>   can be used for mem2mem type of transfers or to service peripherals n=
ot
>   accessible via PSI-L by using external triggers for the TR.
> BCDMA channels do not have support for multiple flows
>=20
> With the introduction of the new DMAs (especially the BCDMA) we also ne=
ed to
> update the resource manager code to support the second range from sysfw=
 for
> UDMA channels.
>=20
> The two outstanding change in the series in my view is
> the handling of the DMAs sideband signal of ASEL to select path to prov=
ide
> coherency or non coherency.
>=20
> the smaller one is the device_router_config callback to allow the confi=
guration
> of the triggers when BCDMA is servicing a triggering peripheral to solv=
e a
> chicken-egg situation:
> The router needs to know the event number to send which in turn depends=
 on the
> channel we got for servicing the peripheral.
>=20
> I'm sending this series as early as possible to have time for review an=
d
> changes.
>=20
> When all things resolved, it would be nice if Santosh could create an i=
mmutable
> branch with the ti_sci/soc patches for Vinod to use for this series.
>=20
> Regards,
> Peter
> ---
> Grygorii Strashko (1):
>   soc: ti: k3-ringacc: add AM64 DMA rings support.
>=20
> Peter Ujfalusi (16):
>   dmaengine: of-dma: Add support for optional router configuration
>     callback
>   dmaengine: Add support for per channel coherency handling
>   dmaengine: doc: client: Update for dmaengine_get_dma_device() usage
>   dmaengine: dmatest: Use dmaengine_get_dma_device
>   dmaengine: ti: k3-udma: Wait for peer teardown completion if supporte=
d
>   dmaengine: ti: k3-udma: Add support for second resource range from
>     sysfw
>   dmaengine: ti: k3-udma-glue: Add function to get device pointer for
>     DMA API
>   dmaengine: ti: k3-udma-glue: Configure the dma_dev for rings
>   dt-bindings: dma: ti: Add document for K3 BCDMA
>   dt-bindings: dma: ti: Add document for K3 PKTDMA
>   dmaengine: ti: k3-psil: Extend psil_endpoint_config for K3 PKTDMA
>   dmaengine: ti: k3-psil: Add initial map for AM64
>   dmaengine: ti: Add support for k3 event routers
>   dmaengine: ti: k3-udma: Initial support for K3 BCDMA
>   dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling
>   dmaengine: ti: k3-udma: Initial support for K3 PKTDMA
>=20
> Vignesh Raghavendra (1):
>   dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA
>=20
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  |  183 ++
>  .../devicetree/bindings/dma/ti/k3-pktdma.yaml |  189 ++
>  Documentation/driver-api/dmaengine/client.rst |    4 +-
>  drivers/dma/dmatest.c                         |   13 +-
>  drivers/dma/of-dma.c                          |   10 +
>  drivers/dma/ti/Makefile                       |    3 +-
>  drivers/dma/ti/k3-psil-am64.c                 |   75 +
>  drivers/dma/ti/k3-psil-priv.h                 |    1 +
>  drivers/dma/ti/k3-psil.c                      |    1 +
>  drivers/dma/ti/k3-udma-glue.c                 |  294 ++-
>  drivers/dma/ti/k3-udma-private.c              |   39 +
>  drivers/dma/ti/k3-udma.c                      | 1975 +++++++++++++++--=

>  drivers/dma/ti/k3-udma.h                      |   27 +-
>  drivers/soc/ti/k3-ringacc.c                   |  325 ++-
>  include/linux/dma/k3-event-router.h           |   16 +
>  include/linux/dma/k3-psil.h                   |   16 +
>  include/linux/dma/k3-udma-glue.h              |   12 +
>  include/linux/dmaengine.h                     |   14 +
>  include/linux/soc/ti/k3-ringacc.h             |   17 +
>  19 files changed, 2994 insertions(+), 220 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.y=
aml
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.=
yaml
>  create mode 100644 drivers/dma/ti/k3-psil-am64.c
>  create mode 100644 include/linux/dma/k3-event-router.h
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

