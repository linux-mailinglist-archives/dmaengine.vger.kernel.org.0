Return-Path: <dmaengine+bounces-5023-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91077A9E90F
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD30E1899403
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 07:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBE1D5AC6;
	Mon, 28 Apr 2025 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wLXUeqfK"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06881D514E;
	Mon, 28 Apr 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824876; cv=none; b=eMiaLcMPhR3HWLIAMIfFR/6+G8jj9eOsUD7CaSPcmp45wKe+t9Tu1rwirRABCVn60Te6d3Vn4sm0nDnoL6j1ltVDvtsz29TV6suS0KaF2gpkY1WX1dwZhEyxsVG2ddp0wBpHEj+Kln+LDtBe31F1mxfxzut3gbvFD2TbN25DZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824876; c=relaxed/simple;
	bh=cVTdVvpTF2b7AcMsFe+HcHyjAgx7BqnnsT6fycHw0/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvJOJq1RjNQgbhPWJMnIFAMb9oypAiDRZGrk4h+a6mOVrPqxVI6D5xC/H1p/kyimkhYFllGsyRZN3X3XVrCpgHgdJ41iuUbnGDD/qv2kMnCDtk11qnJdbSxE6UWgCxXhHEfR+EM5nPLIIml5Wchid+P6kFSTF2EP1qjzq0PmFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wLXUeqfK; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7KuMk2728379
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 02:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745824856;
	bh=hju8e8bkKiVvaXrgWmT1aJHhrIUpIH//AB39ScrzTHE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=wLXUeqfKXwyXJ6Y/Bi35hKwKJj8bUsQ43jK3o0lVEIOPtkyJFKEqgA1Y6q/otZC5a
	 YtCc8K4dbMxI0B0xStqz8y3kbINjDkLZ2NcdHnKRgBuLr7OBTzJ+2VGdFSbA50py7i
	 lwkp8Us4BcEISeUleWseJc/MtRZhlai/mkLU290s=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7KusE073324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 02:20:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 02:20:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 02:20:55 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S7KdMa068873;
	Mon, 28 Apr 2025 02:20:51 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
Subject: [PATCH 1/8] dt-bindings: dma: ti: Add document for K3 BCDMA V2
Date: Mon, 28 Apr 2025 12:50:25 +0530
Message-ID: <20250428072032.946008-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428072032.946008-1-s-adivi@ti.com>
References: <20250428072032.946008-1-s-adivi@ti.com>
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
index 0000000000000..af4aa3839fd66
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
+    const: ti,dmss-bcdma-v2
+
+  reg:
+    items:
+      - description: BCDMA Control /Status Registers region
+      - description: Block Copy Channel Realtime Registers region
+      - description: Channel Realtime Registers region
+      - description: Ring Realtime Registers region
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
+  - "#dma-cells"
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    cbass_main {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+      main_bcdma: dma-controller@485c4000 {
+          compatible = "ti,dmss-bcdma-v2";
+          reg = <0x00 0x485c4000 0x00 0x4000>,
+                <0x00 0x48880000 0x00 0x10000>,
+                <0x00 0x48800000 0x00 0x80000>,
+                <0x00 0x47000000 0x00 0x200000>;
+          reg-names = "gcfg", "bchanrt", "chanrt", "ringrt";
+          #dma-cells = <4>;
+        };
+    };
-- 
2.34.1


