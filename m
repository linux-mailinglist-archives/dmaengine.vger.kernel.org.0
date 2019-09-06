Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5853DABA9F
	for <lists+dmaengine@lfdr.de>; Fri,  6 Sep 2019 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394332AbfIFORz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Sep 2019 10:17:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33864 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394290AbfIFORy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Sep 2019 10:17:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x86EHqm4033766;
        Fri, 6 Sep 2019 09:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567779472;
        bh=+L55aTwWGyUbvaaXfZF0uAs4AUymc3puZPlhVMgEnt8=;
        h=From:To:CC:Subject:Date;
        b=XBgpn3/SQXgbuHcAblOfiMb5pJn2Z9Ecob7dA9FuQSF5UdytHfYfoZuSwy3+cnF11
         WWNmMjDdpMU48ZIGBzkx4DF+RUaCIgG6tKpNtxPxyQ52e+CHF/fXs2SpSsVQ85rVN1
         qh3Aa+LVJPc2ZHKIpukYSSmvsTZPN+68MO39fyfM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x86EHq3J093589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Sep 2019 09:17:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 6 Sep
 2019 09:17:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 6 Sep 2019 09:17:49 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x86EHlOd032723;
        Fri, 6 Sep 2019 09:17:48 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [RFC 0/3] dmaengine: Support for DMA domain controllers
Date:   Fri, 6 Sep 2019 17:18:13 +0300
Message-ID: <20190906141816.24095-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

More and more SoC have more than one DMA controller integrated.

If a device needs none slave DMA channel for operation (block copy from/to
memory mapped regions for example) at the moment when they request a channel it
is going to be taken from the first DMA controller which was registered, but
this might be not optimal for the device.

For example on AM654 we have two DMAs: main_udmap and mcu_udmap.
DDR to DDR memcpy is twice as fast on main_udmap compared to mcu_udmap, while
devices on MCU domain (OSPI for example) are more than twice as fast on
mcu_udmap than with main_udmap.

Because of probing order (mcu_udmap is probing first) modules would use
mcu_udmap instead of the better main_udmap. Currently the only solution is to
make a choice and disable the MEM_TO_MEM functionality on one of them which is
not a great solution.

With the introduction of DMA domain controllers we can utilize the best DMA
controller for the job around the SoC without the need to degrade performance.

If the dma-domain-controller is not present in DT or booted w/o DT the none
slave channel request will work as it does today.

The last patch introduces a new dma_domain_request_chan_by_mask() function and
I have a define for dma_request_chan_by_mask() to avoid breaking users of the
dma_request_chan_by_mask, but looking at the kernel we have small amount of
users:
drivers/gpu/drm/vc4/vc4_dsi.c
drivers/media/platform/omap/omap_vout_vrfb.c
drivers/media/platform/omap3isp/isphist.c
drivers/mtd/spi-nor/cadence-quadspi.c
drivers/spi/spi-ti-qspi.c

If it is acceptable we can modify the parameters of dma_request_chan_by_mask()
to include ther device pointer and at the same time change all of the clients
by giving NULL or in case of the last two their dev.

Regards,
Peter
---
Peter Ujfalusi (3):
  dt-bindings: dma: Add documentation for DMA domains
  dmaengine: of_dma: Function to look up the DMA domain of a client
  dmaengine: Support for requesting channels preferring DMA domain
    controller

 .../devicetree/bindings/dma/dma-domain.yaml   | 59 +++++++++++++++++++
 drivers/dma/dmaengine.c                       | 17 ++++--
 drivers/dma/of-dma.c                          | 42 +++++++++++++
 include/linux/dmaengine.h                     |  9 ++-
 include/linux/of_dma.h                        |  7 +++
 5 files changed, 126 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

