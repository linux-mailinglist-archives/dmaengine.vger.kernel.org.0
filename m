Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CD2DADD9
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 14:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgLONNr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 08:13:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33790 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgLONNo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 08:13:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BFDCuOB055970;
        Tue, 15 Dec 2020 07:12:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608037976;
        bh=fflVV2euO6GX3p6e7gjWU0e5OJmiwk+o75/SeXICdqY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Itqw8bJIWMQQvNcKS6etI7VOGKWZXkcVT36/MJAeBJkDYvisTHPvNGEvCV5tlVfMx
         InFbUsZQPtYEVdPeh7LCwjtugVQhiEkf2d4qQvGcRjjYWIMgu18iDdW3rzfuU91BW+
         vkETEc7iccaVCTrF3Fu+61UIQ2LXJ0SybBLsU2pI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BFDCtFj099693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 07:12:55 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 07:12:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 07:12:55 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BFDCjkv037808;
        Tue, 15 Dec 2020 07:12:52 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <peter.ujfalusi@gmail.com>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] dt-bindings: dma: ti: Update maintainer and author information
Date:   Tue, 15 Dec 2020 15:13:48 +0200
Message-ID: <20201215131348.11282-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215131348.11282-1-peter.ujfalusi@ti.com>
References: <20201215131348.11282-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

My employment with TI is coming to an end, add the copyright and author comments
as they due and change the maintainer mail address.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml  | 4 +++-
 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml | 4 +++-
 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml   | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index b15f68c499cb..df29d59d13a8 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+# Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/dma/ti/k3-bcdma.yaml#
@@ -7,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments K3 DMSS BCDMA Device Tree Bindings
 
 maintainers:
-  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
 
 description: |
   The Block Copy DMA (BCDMA) is intended to perform similar functions as the TR
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index b13ab60cd740..ea19d12a9337 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+# Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/dma/ti/k3-pktdma.yaml#
@@ -7,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments K3 DMSS PKTDMA Device Tree Bindings
 
 maintainers:
-  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
 
 description: |
   The Packet DMA (PKTDMA) is intended to perform similar functions as the packet
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 9a87fd9041eb..6a09bbf83d46 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+# Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/dma/ti/k3-udma.yaml#
@@ -7,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Texas Instruments K3 NAVSS Unified DMA Device Tree Bindings
 
 maintainers:
-  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
 
 description: |
   The UDMA-P is intended to perform similar (but significantly upgraded)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

