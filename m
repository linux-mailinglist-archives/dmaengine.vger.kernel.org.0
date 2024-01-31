Return-Path: <dmaengine+bounces-923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E08449FA
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 22:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559421F231B4
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA6839ACD;
	Wed, 31 Jan 2024 21:27:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68538FB5;
	Wed, 31 Jan 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736425; cv=none; b=K8k9Gog3oYhbq5XziZYWSceJoSaIL3s9eGzBoXp2DOOTEogVGCu7crWnapKecmhWDhxqvxu1Ws0A6Y7sMd8QX+mWS+fmzo3xlyftXMeC20w05/a8dP33ToqsvAsJgWh7M0LvA4DuRCy/mOtN4sAcUJuKD9Z98/ux1toxRquuYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736425; c=relaxed/simple;
	bh=uVGvn5v3uULObvAaf3HZa/wtMRXqXaT8sHbkcl4AM74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnJiZEbTwwrVZdeKmV04KRRHyE6GGcvPjqcF4FIsw9Aax7kaVFJE17XKwY7bxtkcrtfVoZh2caURHqRa2CcalkRwlIgTCZSilLtz0hDTN45oyRcNLwAdDONcgarTbSc+86lPtR6C9w6/N43+UjzmWJrPLLE21e23DzahZ81R79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 2BD3E85458;
	Wed, 31 Jan 2024 22:27:00 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 31 Jan 2024 22:26:03 +0100
Subject: [PATCH v2 2/2] dt-bindings: mmp-dma: convert to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-pxa-dma-yaml-v2-2-9611d0af0edc@skole.hr>
References: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
In-Reply-To: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5281;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=uVGvn5v3uULObvAaf3HZa/wtMRXqXaT8sHbkcl4AM74=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlurr28BlvrjNxs/aFdU/EAgxMD0nSWupIBhMn4
 0Y8td+J3fKJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbq69gAKCRCaEZ6wQi2W
 4Z+FEACklOwkgEUQkLD0n5IeZH3nI12sq64yycJO8TELm84kZdc8b8IBO9M67LOwFQPjHg2CNKX
 nt+QbFSGCoaMQgC8yI6w7+nCUMzKtDL6NVLc2tBMfbZs7l2BfIEiAAL1twS+MAXz7xydwNDx/JD
 +I9OxH4SZCK4UCG0xPr3Tast9Zfzx9sCn9mLXBwN6Q5yqMeiKos3plSc/84HW/RInOvWboxmWYA
 yk4jJQ1GoT2mwKnJXlWKVP3ZZmxYKqmxf8bJkujDklYyIZwOzXO7aai3JKRQnPOmptg6A0K250x
 j+jus28Okw5K3JNFwo06jI1KAxYbP4Dp8YO/5TW5COdXzC49aP3ySK7ybTiPnL1K9x8dC36Zt50
 gyN/MxGWFWvlRJmMRs2rJyEhHwusmMCA3awYdsVLyC9ihVw9Uvxscw+z5m+abZV8CGWtivELH3X
 GxRELzKUE/J0rfRLMqVJp+FHTfd4h6dSq4GntPoeZfHcOItx9um6lgu6ObYwU+aJIfmU/yTTL7U
 pxKLbc3FBUXQAb4WwyUk+zCmlMKqkB8juHRxbwmfGrfoP5oWWgN+fnbTlyuu1r9T6KmBfrjdFPh
 57XiR/dj8qT9z2Yc5wqMlFssfwOFXBkbYfV980lhXY4DlCS3k+6Gfwca9jxai/VUzPM6QbDB2Ia
 rZTNXBYucQc3jNw==
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
 .../devicetree/bindings/dma/marvell,mmp-dma.yaml   | 72 +++++++++++++++++++
 Documentation/devicetree/bindings/dma/mmp-dma.txt  | 81 ----------------------
 2 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
new file mode 100644
index 000000000000..d447d5207be0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
@@ -0,0 +1,72 @@
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
+  asram:
+    description:
+      A phandle to the SRAM pool
+    $ref: /schemas/types.yaml#/definitions/phandle
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
+              - marvell,pdma-1.0
+    then:
+      properties:
+        asram: false
+    else:
+      required:
+        - asram
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dma-controller@d4000000 {
+        compatible = "marvell,pdma-1.0";
+        reg = <0xd4000000 0x10000>;
+        interrupts = <47>;
+        #dma-cells = <2>;
+        dma-channels = <16>;
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

-- 
2.43.0



