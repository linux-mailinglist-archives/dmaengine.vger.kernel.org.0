Return-Path: <dmaengine+bounces-5025-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158EA9E916
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 09:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72EF3B8071
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAAC1DF265;
	Mon, 28 Apr 2025 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J6Fk5y0X"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D71DE892;
	Mon, 28 Apr 2025 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824891; cv=none; b=gpMvvGLyY4k1cRKN3EFRjRKY0Yj+1BF7lIwcj80CCseBTuU4yIFOgRKt3gAwFAIEPQBIN31wkuWx3ZskBj3hFtdU7tbJDLQ5inKIYqMCFYyWumCBXT/NEVgSI5HzEnsKWKh9ClSGG+ftTlbdp+r1YvX7L7V7Uw7oNtBvCJuYTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824891; c=relaxed/simple;
	bh=e41CFdgQUEAxPvzmXET0SVjM34QoLgMk/Ehiricj41o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufds7rpNT9zOrN0io5LjRr0kAYpfFVwjbtEphdiAVQ7h4sblX37q3HDCzGdmj0wbCjA8lZXSmj2OFDim5IHEMi+Xgz8JH9ZZjtK/oNQIz9HtV89ayIEgtpd2DDJVMWSk1t4dZYHkMx8Us4PqgEc5sqZO6Dkom4tshKUmD9LGW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J6Fk5y0X; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7L3pH2713970
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 02:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745824863;
	bh=rWm00ecZW//noVOBD0ZolXeFNkMKumFFuTm6AnT3FXY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=J6Fk5y0XLegsHh1dF41d7vojDkM91lABDPgLF91MmFeeM3z+OUxejL7sfBDVSXYp4
	 i7AS7nEzJZ++wY6GpWlaofBhm3KsZ1C4zzC0FmcdRCx6oiRwCJ6pKUkc3Iup/dL2xu
	 jEb3LDnOxv58lnmw4MAX5ZG7JHlgBwK85H9KorcI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7L3dh121356
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 02:21:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 02:21:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 02:21:02 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S7KdMb068873;
	Mon, 28 Apr 2025 02:20:58 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
Subject: [PATCH 2/8] dt-bindings: dma: ti: Add document for K3 PKTDMA V2
Date: Mon, 28 Apr 2025 12:50:26 +0530
Message-ID: <20250428072032.946008-3-s-adivi@ti.com>
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
Texas Instruments K3 Packet DMA (PKTDMA) V2.

PKTDMA V2 is introduced as part of AM62L.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 .../bindings/dma/ti/k3-pktdma-v2.yaml         | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.yaml
new file mode 100644
index 0000000000000..a6aae96af44df
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma-v2.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024-2025 Texas Instruments Incorporated
+# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/k3-pktdma-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS PKTDMA V2
+
+maintainers:
+  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
+
+description: |
+  The PKTDMA V2 is intended to perform similar functions as the packet
+  mode channels of K3 UDMA-P.
+  PKTDMA V2 only includes Split channels to service PSI-L based peripherals.
+
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,dmss-pktdma-v2
+
+  "#dma-cells":
+    const: 2
+    description: |
+      cell 1: Channel number for the peripheral
+
+        Please refer to the device documentation for the channel map.
+
+      cell 2: ASEL value for the channel
+
+  reg:
+    items:
+      - description: Packet DMA Control /Status Registers region
+      - description: Channel Realtime Registers region
+      - description: Ring Realtime Registers region
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: chanrt
+      - const: ringrt
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
+      main_pktdma: dma-controller@485c0000 {
+        compatible = "ti,dmss-pktdma-v2";
+        reg = <0x00 0x485c0000 0x00 0x4000>,
+          <0x00 0x48900000 0x00 0x80000>,
+          <0x00 0x47200000 0x00 0x100000>;
+        reg-names = "gcfg", "chanrt", "ringrt";
+        #dma-cells = <2>;
+      };
+    };
-- 
2.34.1


