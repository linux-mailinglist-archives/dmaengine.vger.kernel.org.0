Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE634EFC2
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhC3Rfq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:35:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53404 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhC3Rf3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 13:35:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UHZBR8081000;
        Tue, 30 Mar 2021 12:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617125712;
        bh=MPpPVeVWYZ+8y7/Bl7MCutZCIVpIdePmkSU7nZnIfkY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hDfIqO94uEz7SMUG0tdB1Mz+3+bjUhiL02eEMBnsV2XOg09ENAqu4e7ounaQ6Is5j
         2fKpVpWDaxAKiKurEpuICFUpBgIPvFmHcWr0yucnff62RvLXnTU3amPoFZV4Pa/Toc
         8GEoEf8R/NbRzzMA7yDcLmm/re0R+1vHyFOFqq3g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UHZB1C034207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 12:35:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 12:35:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 12:35:11 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UHXmgt125244;
        Tue, 30 Mar 2021 12:35:05 -0500
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
Subject: [PATCH 12/16] dt-bindings: media: Add DT bindings for TI CSI2RX driver
Date:   Tue, 30 Mar 2021 23:03:44 +0530
Message-ID: <20210330173348.30135-13-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210330173348.30135-1-p.yadav@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
parts together.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 .../devicetree/bindings/media/ti,csi2rx.yaml  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml

diff --git a/Documentation/devicetree/bindings/media/ti,csi2rx.yaml b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
new file mode 100644
index 000000000000..ebd894364391
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/ti,csi2rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI CSI2RX Wrapper Device Tree Bindings
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,csi2rx
+
+  dmas:
+    description: RX DMA Channel 0
+
+  dma-names:
+    items:
+      - const: rx0
+
+  reg:
+    maxItems: 1
+    description: Base address and size of the TI wrapper registers.
+
+  power-domains:
+    maxItems: 1
+    description:
+      PM domain provider node and an args specifier containing
+      the device id value.
+
+  ranges: true
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+patternProperties:
+  "csi-bridge@":
+    type: object
+    description: CSI2 bridge node.
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    ti_csi2rx0: ticsi2rx {
+        compatible = "ti,csi2rx";
+        dmas = <&main_udmap 0x4940>;
+        dma-names = "rx0";
+        reg = <0x0 0x4500000 0x0 0x1000>;
+        power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+    };
-- 
2.30.0

