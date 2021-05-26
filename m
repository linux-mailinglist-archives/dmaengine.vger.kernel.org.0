Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC9391B9C
	for <lists+dmaengine@lfdr.de>; Wed, 26 May 2021 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhEZPYz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 May 2021 11:24:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57146 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhEZPYz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 May 2021 11:24:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QFNEAV076732;
        Wed, 26 May 2021 10:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622042594;
        bh=e7aNPnbx8t5mD4FscmZAo6nmG6Wi1zU/gmOIkIkpqQI=;
        h=From:To:CC:Subject:Date;
        b=m6dBZDP0YEtq6gLDOkK4Y8FfONIG8/vbBu8SL8IVGpAtVuYQAvG3osjqtSUTmMJmr
         6tW7E++SH1DfPmHcn2ojpXtCjJZmvyiGYB+TKooCy7FbIRXtsGv0Grzg/eSy7pVs8O
         nZ3Ar22Yl6ps4JWVDYvFHw5bPPqFMncMFuNG7JgE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QFNE6N078106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:23:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:23:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:23:14 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QFN9JY056314;
        Wed, 26 May 2021 10:23:09 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 00/18] CSI2RX support on J721E
Date:   Wed, 26 May 2021 20:52:50 +0530
Message-ID: <20210526152308.16525-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This series adds support for CSI2 capture on J721E. It includes some
fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
driver, and finally adds the TI CSI2RX wrapper driver.

Tested on TI's J721E with OV5640 sensor.

Changes in v2:
- Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
  calls to set PHY mode, etc. to make sure it is ready.
- Add all 64 threads, instead of having only the one thread being
  currently used by the driver.
- Use dmaengine_get_dma_device() instead of directly accessing
  dma->device->dev.
- Do not set dst_addr_width when configuring slave DMA.
- Move to a separate subdir and rename to j721e-csi2rx.c
- Convert compatible to ti,j721e-csi2rx.
- Move to use Media Controller centric APIs.
- Improve cleanup in probe when one of the steps fails.
- Add colorspace to formats database.
- Set hw_revision on media_device.
- Move video device initialization to probe time instead of register time.
- Rename to ti,j721e-csi2rx.yaml
- Add an entry in MAINTAINERS.
- Add a description for the binding.
- Change compatible to ti,j721e-csi2rx to make it SoC specific.
- Remove description from dmas, reg, power-domains.
- Remove a limit of 2 from #address-cells and #size-cells.
- Fix add ^ to csi-bridge subnode regex.
- Make ranges mandatory.
- Add unit address in example.
- Add a reference to cdns,csi2rx in csi-bridge subnode.
- Expand the example to include the csi-bridge subnode as well.
- Re-order subject prefixes.
- Drop reg description.
- Add a description for each DPHY clock.
- Rename dphy@... to phy@... in example.
- Add Laurent's R-by.
- Re-order subject prefixes.
- Re-order subject prefixes.
- Add power-domain to the example.
- Add Laurent's R-by.
- Re-order subject prefixes.
- Convert OV5640 to use runtime PM and drop Cadence CSI2RX s_power patch.
- Drop subdev call wrappers from cdns-csi2rx.
- Move VPE and CAL to a separate subdir.
- Rename ti-csi2rx.c to j721e-csi2rx.c

Paul Kocialkowski (1):
  phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes

Pratyush Yadav (17):
  phy: cdns-dphy: Prepare for Rx support
  phy: cdns-dphy: Allow setting mode
  phy: cdns-dphy: Add Rx support
  media: ov5640: Use runtime PM to control sensor power
  media: cadence: csi2rx: Add external DPHY support
  media: cadence: csi2rx: Soft reset the streams before starting capture
  media: cadence: csi2rx: Set the STOP bit when stopping a stream
  media: cadence: csi2rx: Fix stream data configuration
  media: cadence: csi2rx: Populate subdev devnode
  dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
  media: Re-structure TI platform drivers
  media: ti: Add CSI2RX support for J721E
  media: dt-bindings: Add DT bindings for TI J721E CSI2RX driver
  media: dt-bindings: Convert Cadence CSI2RX binding to YAML
  phy: dt-bindings: Convert Cadence DPHY binding to YAML
  phy: dt-bindings: cdns,dphy: make clocks optional
  phy: dt-bindings: cdns,dphy: add power-domains property

 .../devicetree/bindings/media/cdns,csi2rx.txt | 100 --
 .../bindings/media/cdns,csi2rx.yaml           | 164 ++++
 .../bindings/media/ti,j721e-csi2rx.yaml       | 101 ++
 .../devicetree/bindings/phy/cdns,dphy.txt     |  20 -
 .../devicetree/bindings/phy/cdns,dphy.yaml    |  54 ++
 MAINTAINERS                                   |  10 +-
 drivers/dma/ti/k3-psil-j721e.c                |  73 ++
 drivers/media/i2c/Kconfig                     |   2 +-
 drivers/media/i2c/ov5640.c                    | 124 ++-
 drivers/media/platform/Kconfig                |  12 +
 drivers/media/platform/Makefile               |   2 +-
 drivers/media/platform/cadence/cdns-csi2rx.c  | 196 +++-
 drivers/media/platform/ti/Makefile            |   4 +
 drivers/media/platform/ti/cal/Makefile        |   3 +
 .../{ti-vpe => ti/cal}/cal-camerarx.c         |   0
 .../platform/{ti-vpe => ti/cal}/cal-video.c   |   0
 .../media/platform/{ti-vpe => ti/cal}/cal.c   |   0
 .../media/platform/{ti-vpe => ti/cal}/cal.h   |   0
 .../platform/{ti-vpe => ti/cal}/cal_regs.h    |   0
 .../media/platform/ti/j721e-csi2rx/Makefile   |   2 +
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 884 ++++++++++++++++++
 .../platform/{ti-vpe => ti/vpe}/Makefile      |   4 -
 .../media/platform/{ti-vpe => ti/vpe}/csc.c   |   0
 .../media/platform/{ti-vpe => ti/vpe}/csc.h   |   0
 .../media/platform/{ti-vpe => ti/vpe}/sc.c    |   0
 .../media/platform/{ti-vpe => ti/vpe}/sc.h    |   0
 .../platform/{ti-vpe => ti/vpe}/sc_coeff.h    |   0
 .../media/platform/{ti-vpe => ti/vpe}/vpdma.c |   0
 .../media/platform/{ti-vpe => ti/vpe}/vpdma.h |   0
 .../platform/{ti-vpe => ti/vpe}/vpdma_priv.h  |   0
 .../media/platform/{ti-vpe => ti/vpe}/vpe.c   |   0
 .../platform/{ti-vpe => ti/vpe}/vpe_regs.h    |   0
 drivers/phy/cadence/cdns-dphy.c               | 407 +++++++-
 include/linux/phy/phy-mipi-dphy.h             |  13 +
 34 files changed, 1950 insertions(+), 225 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
 create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
 create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
 create mode 100644 drivers/media/platform/ti/Makefile
 create mode 100644 drivers/media/platform/ti/cal/Makefile
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal-camerarx.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal-video.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/cal}/cal_regs.h (100%)
 create mode 100644 drivers/media/platform/ti/j721e-csi2rx/Makefile
 create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
 rename drivers/media/platform/{ti-vpe => ti/vpe}/Makefile (78%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/csc.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/csc.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc_coeff.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma_priv.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpe.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpe_regs.h (100%)

-- 
2.30.0

