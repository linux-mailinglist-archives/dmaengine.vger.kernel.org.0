Return-Path: <dmaengine+bounces-6827-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A23BD65BA
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1666A3BB673
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B921FF30;
	Mon, 13 Oct 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIrSUIuo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8936134BD;
	Mon, 13 Oct 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391046; cv=none; b=u8KoBHSCeaA2JnEsGnMMVzXl7KBBmaHSHI9p89SpSERbjggfAkiWmP2N/uFYYaX9GcAyBoqMZBRFmDmaPmYTMH1PozPbgFEPT8/ro30SUL3fifGlMgYhJq+clhDI7bUshH3ckH7j+9yZeGiUEunmb+Fhog9T8cSgv7XA17rY2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391046; c=relaxed/simple;
	bh=UXRYA9OeTpRlGCWOSO+dL5y9CcocBocJ6aM8A6/dmE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XezzFIsheFuMmkE/eSeVQ3WsEACAJ6WMeqxgpRz+9S8zDWHjynGtVjZ77+z7p01dC2IBwF61LNBSkurnJOdbE2jZpfhmsHWJ5lxUL8+bQWwZ3iVickio98UFPtlqGFcQgcBWGTDGK9/HBcwPpBa9p18UuLTP/8lXZm0JcuLNYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIrSUIuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5D3C4CEE7;
	Mon, 13 Oct 2025 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391045;
	bh=UXRYA9OeTpRlGCWOSO+dL5y9CcocBocJ6aM8A6/dmE8=;
	h=From:To:Cc:Subject:Date:From;
	b=aIrSUIuoRlOnmFKmaS40AJfKwtu0dHdNg8b1UvYq2CtV+D/SiFnpSGY5UnTK6e53H
	 R4mBxcGz2CwaBB/epzuxayWPZJV8zqzDLD8q0kwlQrIafUpwApSo1SW9OxgE4vCREw
	 nt/Qu+iN/FDhiQi9/NnRPGjvqEj9gfTNmSokBg2+jC7cB6YSWX5UzWCWlav4nIyGA/
	 SZXBj95H/6Z71XaBa5wCmpMttXCYGMGV69XU0E5/VtuHJhbcyYOeT3EKntHJ7Tj/9l
	 5bg54weZR9cqrl90fOUw5Irbobq3/Mf5JtUiHKP8lxsk+TS6p8VML3+TWzybOjG4ko
	 VDOEk17CA0gBQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: Convert apm,xgene-storm-dma to DT schema
Date: Mon, 13 Oct 2025 16:30:35 -0500
Message-ID: <20251013213037.684981-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert APM X-Gene Storm DMA binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/apm,xgene-storm-dma.yaml     | 59 +++++++++++++++++++
 .../devicetree/bindings/dma/apm-xgene-dma.txt | 47 ---------------
 2 files changed, 59 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/apm,xgene-storm-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/apm,xgene-storm-dma.yaml b/Documentation/devicetree/bindings/dma/apm,xgene-storm-dma.yaml
new file mode 100644
index 000000000000..9ca5f7848785
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apm,xgene-storm-dma.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/apm,xgene-storm-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene Storm SoC DMA
+
+maintainers:
+  - Khuong Dinh <khuong@os.amperecomputing.com>
+
+properties:
+  compatible:
+    const: apm,xgene-storm-dma
+
+  reg:
+    items:
+      - description: DMA control and status registers
+      - description: Descriptor ring control and status registers
+      - description: Descriptor ring command registers
+      - description: SoC efuse registers
+
+  interrupts:
+    items:
+      - description: DMA error reporting interrupt
+      - description: DMA channel 0 completion interrupt
+      - description: DMA channel 1 completion interrupt
+      - description: DMA channel 2 completion interrupt
+      - description: DMA channel 3 completion interrupt
+
+  clocks:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    dma@1f270000 {
+        compatible = "apm,xgene-storm-dma";
+        reg = <0x1f270000 0x10000>,
+              <0x1f200000 0x10000>,
+              <0x1b000000 0x400000>,
+              <0x1054a000 0x100>;
+        interrupts = <0x0 0x82 0x4>,
+                    <0x0 0xb8 0x4>,
+                    <0x0 0xb9 0x4>,
+                    <0x0 0xba 0x4>,
+                    <0x0 0xbb 0x4>;
+        dma-coherent;
+        clocks = <&dmaclk 0>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt b/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
deleted file mode 100644
index c53e0b08032f..000000000000
--- a/Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Applied Micro X-Gene SoC DMA nodes
-
-DMA nodes are defined to describe on-chip DMA interfaces in
-APM X-Gene SoC.
-
-Required properties for DMA interfaces:
-- compatible: Should be "apm,xgene-dma".
-- device_type: set to "dma".
-- reg: Address and length of the register set for the device.
-  It contains the information of registers in the following order:
-  1st - DMA control and status register address space.
-  2nd - Descriptor ring control and status register address space.
-  3rd - Descriptor ring command register address space.
-  4th - Soc efuse register address space.
-- interrupts: DMA has 5 interrupts sources. 1st interrupt is
-  DMA error reporting interrupt. 2nd, 3rd, 4th and 5th interrupts
-  are completion interrupts for each DMA channels.
-- clocks: Reference to the clock entry.
-
-Optional properties:
-- dma-coherent : Present if dma operations are coherent
-
-Example:
-	dmaclk: dmaclk@1f27c000 {
-		compatible = "apm,xgene-device-clock";
-		#clock-cells = <1>;
-		clocks = <&socplldiv2 0>;
-		reg = <0x0 0x1f27c000 0x0 0x1000>;
-		reg-names = "csr-reg";
-		clock-output-names = "dmaclk";
-	};
-
-	dma: dma@1f270000 {
-			compatible = "apm,xgene-storm-dma";
-			device_type = "dma";
-			reg = <0x0 0x1f270000 0x0 0x10000>,
-			      <0x0 0x1f200000 0x0 0x10000>,
-			      <0x0 0x1b000000 0x0 0x400000>,
-			      <0x0 0x1054a000 0x0 0x100>;
-			interrupts = <0x0 0x82 0x4>,
-				     <0x0 0xb8 0x4>,
-				     <0x0 0xb9 0x4>,
-				     <0x0 0xba 0x4>,
-				     <0x0 0xbb 0x4>;
-			dma-coherent;
-			clocks = <&dmaclk 0>;
-	};
-- 
2.51.0


