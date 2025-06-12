Return-Path: <dmaengine+bounces-5401-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B9AD68AB
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853F61BC0460
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F0221FB1;
	Thu, 12 Jun 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ww4XG4xs"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9B219A86;
	Thu, 12 Jun 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712603; cv=none; b=WeNGqoJmZBYnSLAa99uoNpEPeNNsIzxPnbHY08NQY3PxcpaxwUbpjgIq9+ko0I/UUcnF8Aqp868LAfwuBjsYEQW6zmb3mXXwO7ZJ3QpGZRzU2Tg9DE1NHcWtl7+jN56izUb99ttzDOsjpvwdVKSyl4aYhgXBdf7MU4LumzPrgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712603; c=relaxed/simple;
	bh=vaKT5fvO5HRo5dkIYaY9tk8gdbYZ0OXqjtujUl532uE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGg+ketONlDMZrXApyOnIHLSlSPOpP4oe9k8nKF3b3Hn0uhiu8aHL6HkyOER1KWTAnzfas57rymNqaTXEahqeFNGa+eMmtINl3Yu3gxUIsSBsUGhSfBxDktUWxkwSYCziZZD9kjfEFN/es/98j+ev07fott+SP2n8ImsiI7ZAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ww4XG4xs; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C7GZiE1594318;
	Thu, 12 Jun 2025 02:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749712595;
	bh=IiZ1f53v0gfsuy70mAFVDiW4T+FR5dYYQLsMlOf4YpU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ww4XG4xszb6JjU+pMDf6B2CioojSiDVcpj3Nns5zssVAvtpuJX8H8Mfy2+gRSs9bo
	 zPeJmTz1WuyuUC0Pr+7M/ct9+hSu+zwKsCaoqjUWP5FNjAmKZp2ezqLhf7O+37xMb1
	 yVYH0nO9YmwYkx2NCRICwuUlmch0sKfGpNcLXosI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C7GZEr2381020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 02:16:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Jun 2025 02:16:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 02:16:34 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C7FTKY1608959;
	Thu, 12 Jun 2025 02:16:29 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Sai Sree Kartheek Adivi <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
        <p-mantena@ti.com>
Subject: [PATCH v2 12/17] dt-bindings: dma: ti: Add document for K3 BCDMA V2
Date: Thu, 12 Jun 2025 12:45:16 +0530
Message-ID: <20250612071521.3116831-13-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612071521.3116831-1-s-adivi@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

New binding document for
Texas Instruments K3 Block Copy DMA (BCDMA) V2.

BCDMA V2 is introduced as part of AM62L.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 .../bindings/dma/ti/k3-bcdma-v2.yaml          | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
new file mode 100644
index 0000000000000..9d86e515bdefb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma-v2.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-2025 Texas Instruments Incorporated
+# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/k3-bcdma-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS BCDMA V2
+
+maintainers:
+  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
+
+description: |
+  The BCDMA V2 is intended to perform similar functions as the TR
+  mode channels of K3 UDMA-P.
+  BCDMA V2 includes block copy channels and Split channels.
+
+  Block copy channels mainly used for memory to memory transfers, but with
+  optional triggers a block copy channel can service peripherals by accessing
+  directly to memory mapped registers or area.
+
+  Split channels can be used to service PSI-L based peripherals.
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am62l-dmss-bcdma
+
+  reg:
+    items:
+      - description: BCDMA Control /Status
+      - description: Block Copy Channel Realtime
+      - description: Channel Realtime
+      - description: Ring Realtime
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: bchanrt
+      - const: chanrt
+      - const: ringrt
+
+  "#dma-cells":
+    const: 4
+    description: |
+      cell 1: Trigger type for the channel
+        0 - disable / no trigger
+        1 - internal channel event
+        2 - external signal
+        3 - timer manager event
+
+      cell 2: parameter for the trigger:
+        if cell 1 is 0 (disable / no trigger):
+          Unused, ignored
+        if cell 1 is 1 (internal channel event):
+          channel number whose TR event should trigger the current channel.
+        if cell 1 is 2 or 3 (external signal or timer manager event):
+          index of global interfaces that come into the DMA.
+
+          Please refer to the device documentation for global interface indexes.
+
+      cell 3: Channel number for the peripheral
+
+        Please refer to the device documentation for the channel map.
+
+      cell 4: ASEL value for the channel
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    cbass_main {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@485c4000 {
+            compatible = "ti,dmss-bcdma-v2";
+            reg = <0x00 0x485c4000 0x00 0x4000>,
+                  <0x00 0x48880000 0x00 0x10000>,
+                  <0x00 0x48800000 0x00 0x80000>,
+                  <0x00 0x47000000 0x00 0x200000>;
+            reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
+            #dma-cells = <4>;
+        };
+    };
-- 
2.34.1


