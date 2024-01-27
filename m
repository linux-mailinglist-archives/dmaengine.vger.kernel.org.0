Return-Path: <dmaengine+bounces-838-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90EC83EED5
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B281C2132C
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jan 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903082C6A3;
	Sat, 27 Jan 2024 16:55:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA52576D;
	Sat, 27 Jan 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374536; cv=none; b=gkSO+pz14jx/UBERUXk7q26/04fZ/+8QDm1HHpgUEbkqJja5sjCyBiIOckYaXjIx4ydJNqXuVXyOy9XwSwr23ueIBJ+c4gDebippRGXwNSbhgrlPWdRjhDaaWSUEZr0lPdalZGVtmpjs0/gN7zmJklX2z233AdWLyjAaDbC2Fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374536; c=relaxed/simple;
	bh=UJf8LfIAA2qfS/89s5e5bsmdSscHEaH22ow4zmGKK8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e3QSCfWsbtTEzvc/SnbS8+7qAZj9oobjuKkD3ddZcbhWOmzJzwERXvJ3G3x8NqTP+myHH8P9y3jQOj2mPX1PbdjhKGFLaJBZTJO0xyJz9cJL1CaNPV+Ol8wENMOrNv+4NaZGiQ+oaNkeouchUYOokwK6asg2an678VLk0UA74U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id D1647855D6;
	Sat, 27 Jan 2024 17:55:22 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 27 Jan 2024 17:53:45 +0100
Subject: [PATCH] dt-bindings: mmp-dma: convert to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240127-pxa-dma-yaml-v1-1-573bafe86454@skole.hr>
X-B4-Tracking: v=1; b=H4sIABk1tWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNT3YKKRN2U3ETdysTcHF2DJDOjVEMDCyOTNBMloJaCotS0zAqwcdG
 xtbUA23t0gV4AAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5739;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=UJf8LfIAA2qfS/89s5e5bsmdSscHEaH22ow4zmGKK8s=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBltTVR8l6pIYcroTtyjyjMEx6FofUU+ApvB/KzH
 XvfS2BhdRyJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbU1UQAKCRCaEZ6wQi2W
 4VkEEACJkFd7cQtUpT0G2ulzPw7PJeX0xzLQDL7h437/7HJN+/MqD0h8FFHgJp5uOxbLUGSTzcI
 sDSgWEMJz8xrggEU2BM9A/vmaAN5Htxg1Ll9z8vF3UfjQ67Mo8kRGisk0wjGR2Izxr/GpKrA0ke
 0LEgsSPC6Vx4zVxbbbA2ytzQvXHRSzFp89eZaf1xdnuttf5zvq6SJpsi9RQWYrPmjj/LZs/Tr1C
 tr3+U34Em78q+1y0Ys6dxNu4PCo+HwhqTQ5wb7wbm/kBMicbZ0fgAiSxI8PWCalFrNxP3tpPTP+
 9waZMTWR9iYDB2v2ZXK1VuU5H9gYiq9uBj45NIjN4tnZLCcvoWMtdDHkxA55AILoHQoWct+E5Va
 0nNHoOsU9HcvLgeCZHOezf8kVw5vbeNnTSNKo0xRtaQqZCx9jOkTD44saq1R+FbtsEuGhRDrgIM
 ITukzDMlIp95ibNb3p9KKc5rP+Tg2/7qlcjLGXITCw+sysvNqPNhvuG2gknOsBF7LUsu9U67Zyo
 x0tUvo8WlQ7igvEVd/eaO2ath4C5+XL+lkwL34t6dZfNpml9o80s40s3xkTJ4bltT5vp4nYwuH1
 oEfRxuim1NVrqgo7Q2IaUfkV1FEMMNToWEJ4WiNDW/2VUt5WGZhJnOlVF/gokIyOErpLOZbwnqO
 lW6cunRTrkC9Cmw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Convert the Marvell MMP DMA binding to YAML.

The TXT binding mentions that the controller may have one IRQ per DMA
channel. Examples of this were dropped in the YAML binding because of
dt_binding_check complaints (either too many interrupt cells or
interrupts) and the fact that this is not used in any of the in-tree
device trees.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../devicetree/bindings/dma/marvell,mmp-dma.yaml   | 82 ++++++++++++++++++++++
 Documentation/devicetree/bindings/dma/mmp-dma.txt  | 81 ---------------------
 2 files changed, 82 insertions(+), 81 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
new file mode 100644
index 000000000000..fe94ba9143e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/marvell,mmp-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP DMA controller
+
+maintainers:
+  - Duje Mihanović <duje.mihanovic@skole.hr>
+
+description:
+  Marvell MMP SoCs may have two types of DMA controllers, peripheral and audio.
+
+properties:
+  compatible:
+    enum:
+      - marvell,pdma-1.0
+      - marvell,adma-1.0
+      - marvell,pxa910-squ
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt lines for the controller, may be shared or one per DMA channel
+    minItems: 1
+
+  '#dma-channels':
+    deprecated: true
+
+  '#dma-requests':
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#dma-cells'
+
+allOf:
+  - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,adma-1.0
+              - marvell,pxa910-squ
+    then:
+      properties:
+        asram:
+          description:
+            phandle to the SRAM pool
+          minItems: 1
+          maxItems: 1
+        iram:
+          maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  # Peripheral controller
+  - |
+    pdma0: dma-controller@d4000000 {
+        compatible = "marvell,pdma-1.0";
+        reg = <0xd4000000 0x10000>;
+        interrupts = <47>;
+        #dma-cells = <2>;
+        dma-channels = <16>;
+    };
+
+  # Audio controller
+  - |
+    squ: dma-controller@d42a0800 {
+        compatible = "marvell,pxa910-squ";
+        reg = <0xd42a0800 0x100>;
+        interrupts = <46>;
+        #dma-cells = <2>;
+        dma-channels = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
deleted file mode 100644
index ec18bf0a802a..000000000000
--- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-* MARVELL MMP DMA controller
-
-Marvell Peripheral DMA Controller
-Used platforms: pxa688, pxa910, pxa3xx, etc
-
-Required properties:
-- compatible: Should be "marvell,pdma-1.0"
-- reg: Should contain DMA registers location and length.
-- interrupts: Either contain all of the per-channel DMA interrupts
-		or one irq for pdma device
-
-Optional properties:
-- dma-channels: Number of DMA channels supported by the controller (defaults
-  to 32 when not specified)
-- #dma-channels: deprecated
-- dma-requests: Number of DMA requestor lines supported by the controller
-  (defaults to 32 when not specified)
-- #dma-requests: deprecated
-
-"marvell,pdma-1.0"
-Used platforms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
-
-Examples:
-
-/*
- * Each channel has specific irq
- * ICU parse out irq channel from ICU register,
- * while DMA controller may not able to distinguish the irq channel
- * Using this method, interrupt-parent is required as demuxer
- * For example, pxa688 icu register 0x128, bit 0~15 is PDMA channel irq,
- * 18~21 is ADMA irq
- */
-pdma: dma-controller@d4000000 {
-	      compatible = "marvell,pdma-1.0";
-	      reg = <0xd4000000 0x10000>;
-	      interrupts = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>;
-	      interrupt-parent = <&intcmux32>;
-	      dma-channels = <16>;
-      };
-
-/*
- * One irq for all channels
- * Dmaengine driver (DMA controller) distinguish irq channel via
- * parsing internal register
- */
-pdma: dma-controller@d4000000 {
-	      compatible = "marvell,pdma-1.0";
-	      reg = <0xd4000000 0x10000>;
-	      interrupts = <47>;
-	      dma-channels = <16>;
-      };
-
-
-Marvell Two Channel DMA Controller used specifically for audio
-Used platforms: pxa688, pxa910
-
-Required properties:
-- compatible: Should be "marvell,adma-1.0" or "marvell,pxa910-squ"
-- reg: Should contain DMA registers location and length.
-- interrupts: Either contain all of the per-channel DMA interrupts
-		or one irq for dma device
-
-"marvell,adma-1.0" used on pxa688
-"marvell,pxa910-squ" used on pxa910
-
-Examples:
-
-/* each channel has specific irq */
-adma0: dma-controller@d42a0800 {
-	      compatible = "marvell,adma-1.0";
-	      reg = <0xd42a0800 0x100>;
-	      interrupts = <18 19>;
-	      interrupt-parent = <&intcmux32>;
-      };
-
-/* One irq for all channels */
-squ: dma-controller@d42a0800 {
-	      compatible = "marvell,pxa910-squ";
-	      reg = <0xd42a0800 0x100>;
-	      interrupts = <46>;
-      };

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240125-pxa-dma-yaml-0b62e10824f4

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



