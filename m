Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C9248C6EA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbiALPP7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 10:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiALPPu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 10:15:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722ECC06175D
        for <dmaengine@vger.kernel.org>; Wed, 12 Jan 2022 07:15:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLj-00031F-QR; Wed, 12 Jan 2022 16:15:43 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLi-009ufK-Ty; Wed, 12 Jan 2022 16:15:42 +0100
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mtr@pengutronix.de>)
        id 1n7fLh-005Zfv-Gt; Wed, 12 Jan 2022 16:15:41 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH 0/3] dt-bindings: dmaengine: zynqmp_dma: Convert binding to YAML
Date:   Wed, 12 Jan 2022 16:15:38 +0100
Message-Id: <20220112151541.1328732-1-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This series converts the ZynqMP dma engine dt bindings to yaml and fixes the
ZynqMP device tree following the stricter yaml bindings.

The series is based on https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt to
avoid conflicts when applying the patches to the zynqmp/dt tree.

Patch 1 converts the binding to yaml, Patches 2 and 3 cleanup the dma engine
nodes in the zynqmp.dtsi that is included by actual board device trees.

Michael

Michael Tretter (3):
  dt-bindings: dmaengine: zynqmp_dma: convert to yaml
  arm64: zynqmp: Add missing #dma-cells property
  arm64: zynqmp: Rename dma to dma-controller

 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 85 +++++++++++++++++++
 .../bindings/dma/xilinx/zynqmp_dma.txt        | 26 ------
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 48 +++++++----
 3 files changed, 117 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt

-- 
2.30.2

