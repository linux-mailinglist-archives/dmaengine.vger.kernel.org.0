Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FBC34EF94
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhC3Rem (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:34:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59520 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhC3Re2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:34:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXtnt056809;
        Tue, 30 Mar 2021 12:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125635;
        bh=klDN3SRCgEm92mzhH+b10dVnhg4f/bIDdg6mQxTtm4o=;
        h=From:To:CC:Subject:Date;
        b=DHU9Kl08+poeyMRGZ5LTonGYtO7avzKKZPcvTTCoiUpl9Ktnuu2CYUcLN67MxO0QL
         c+PXjfelxxXwJx/WMkyYUeY9TaFO46ja46uDOiAAch4VTI8+pakFrtBXwEZcgahdv7
         1n+BOxAQcroO2uGMB0Xv+sHyr8gCxw9jq+Jx1qRI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHXtdE031312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:33:55 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:33:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:33:55 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgh125244;
        Tue, 30 Mar 2021 12:33:49 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <dmaengine@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 00/16] CSI2RX support on J721E
Date:   Tue, 30 Mar 2021 23:03:32 +0530
Message-ID: <20210330173348.30135-1-p.yadav@ti.com>
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

Paul Kocialkowski (1):
  phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes

Pratyush Yadav (15):
  phy: cdns-dphy: Prepare for Rx support
  phy: cdns-dphy: Allow setting mode
  phy: cdns-dphy: Add Rx support
  media: cadence: csi2rx: Add external DPHY support
  media: cadence: csi2rx: Soft reset the streams before starting capture
  media: cadence: csi2rx: Set the STOP bit when stopping a stream
  media: cadence: csi2rx: Fix stream data configuration
  media: cadence: csi2rx: Turn subdev power on before starting stream
  media: cadence: csi2rx: Add wrappers for subdev calls
  dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
  dt-bindings: media: Add DT bindings for TI CSI2RX driver
  media: ti-vpe: csi2rx: Add CSI2RX support
  dt-bindings: phy: Convert Cadence DPHY binding to YAML
  dt-bindings: phy: cdns,dphy: make clocks optional
  dt-bindings: phy: cdns,dphy: add power-domains property

 .../devicetree/bindings/media/ti,csi2rx.yaml  |  70 ++
 .../devicetree/bindings/phy/cdns,dphy.txt     |  20 -
 .../devicetree/bindings/phy/cdns,dphy.yaml    |  52 +
 MAINTAINERS                                   |   7 +
 drivers/dma/ti/k3-psil-j721e.c                |  10 +
 drivers/media/platform/Kconfig                |  11 +
 drivers/media/platform/cadence/cdns-csi2rx.c  | 269 ++++-
 drivers/media/platform/ti-vpe/Makefile        |   1 +
 drivers/media/platform/ti-vpe/ti-csi2rx.c     | 964 ++++++++++++++++++
 drivers/phy/cadence/cdns-dphy.c               | 407 +++++++-
 include/linux/phy/phy-mipi-dphy.h             |  13 +
 11 files changed, 1754 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
 create mode 100644 drivers/media/platform/ti-vpe/ti-csi2rx.c

--
2.30.0

