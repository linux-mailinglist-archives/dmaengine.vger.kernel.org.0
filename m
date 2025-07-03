Return-Path: <dmaengine+bounces-5733-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAEDAF7D0B
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jul 2025 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167517B13F2
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jul 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF42EF652;
	Thu,  3 Jul 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFaNZWdK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278642D6605;
	Thu,  3 Jul 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558359; cv=none; b=g87OeH0hJcYYx3ZuKgkA203LGnsWjMW2jV2w27RrLPMYenB7I+IPc0ikWsYVc72Csvn34HKzosnvazuRvQg2uFT6v2bwrwqPqMWRGCDfQpBiI1cSJDqBFrCmGapPUWsofgEAKz2rTo7tjvbBkvcdmys7eb5zF5fnkoPLjdWCLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558359; c=relaxed/simple;
	bh=XUErQvoSfPDh30QxPj+fBHxE2HU7XxKIMeJBfTcPjU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVkbopL+TeGNyFm2bhAEVAJmOl2BI9VICkmXFtaj5qLQ3IfOSBDEJ7kXx/gYxIFlktGcaOtjz91FsO29sR18cvHe4HevWzIkS0JWmvwvRjrQom0z6Zx/7G+j0blOMtMFoDiPgGtObgkBLpyzWEtx+Uv6sXYCuXiqZ2lIwBXYVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFaNZWdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8416CC4CEE3;
	Thu,  3 Jul 2025 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558357;
	bh=XUErQvoSfPDh30QxPj+fBHxE2HU7XxKIMeJBfTcPjU8=;
	h=From:To:Cc:Subject:Date:From;
	b=VFaNZWdKvokc6PGOHwz7Ja9eDg7QYo6ZOOMnsPIRI7ko0mGcbqS2W/fA9A44VVu7B
	 AIBgMUqWCYrFZpn4hojotsquOzvDmDgxnHhKkKYgKmCGr5Rtl0zctKllzIvVYnjYTk
	 xl7uMC+FxNj0oWdt+jfI/Hgjk/V/gx1ftQOp28/M7e7YN4nmzGYQE/VzsDBkUei+s0
	 S+mgxqc1CfNSZu08+CTQgk7X35SiPR5+wMHacQ7hxNVs/Z4kQl1erk+KT0LclF6bl/
	 E/DT+VbQYCq6fGvQ9jbaPq1JMaVBXNuiaYD0eK3cM+XhrkRM6sFUZ77iVUSUQxz/gj
	 yKv1KCl1qW9sw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: Convert marvell,orion-xor to DT schema
Date: Thu,  3 Jul 2025 10:59:10 -0500
Message-ID: <20250703155912.1713518-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Marvell Orion XOR engine binding to schema.

The "clocks" property is optional for some platforms (though not
distinguished by compatble). The child node names used are 'channel' or
'xor'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/dma/marvell,orion-xor.yaml       | 84 +++++++++++++++++++
 .../devicetree/bindings/dma/mv-xor.txt        | 40 ---------
 2 files changed, 84 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,orion-xor.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor.txt

diff --git a/Documentation/devicetree/bindings/dma/marvell,orion-xor.yaml b/Documentation/devicetree/bindings/dma/marvell,orion-xor.yaml
new file mode 100644
index 000000000000..add08257ec59
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/marvell,orion-xor.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/marvell,orion-xor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell XOR engine
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: marvell,armada-380-xor
+          - const: marvell,orion-xor
+      - enum:
+          - marvell,armada-3700-xor
+          - marvell,orion-xor
+
+  reg:
+    items:
+      - description: Low registers for the XOR engine
+      - description: High registers for the XOR engine
+
+  clocks:
+    maxItems: 1
+
+patternProperties:
+  "^(channel|xor)[0-9]+$":
+    description: XOR channel sub-node
+    type: object
+    additionalProperties: false
+
+    properties:
+      interrupts:
+        description: Interrupt specifier for the XOR channel
+        items:
+          - description: Interrupt for this channel
+
+      dmacap,memcpy:
+        type: boolean
+        deprecated: true
+        description:
+          Indicates that the XOR channel is capable of memcpy operations
+
+      dmacap,memset:
+        type: boolean
+        deprecated: true
+        description:
+          Indicates that the XOR channel is capable of memset operations
+
+      dmacap,xor:
+        type: boolean
+        deprecated: true
+        description:
+          Indicates that the XOR channel is capable of xor operations
+
+    required:
+      - interrupts
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    xor@d0060900 {
+        compatible = "marvell,orion-xor";
+        reg = <0xd0060900 0x100>,
+              <0xd0060b00 0x100>;
+        clocks = <&coreclk 0>;
+
+        xor00 {
+            interrupts = <51>;
+        };
+        xor01 {
+            interrupts = <52>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/dma/mv-xor.txt b/Documentation/devicetree/bindings/dma/mv-xor.txt
deleted file mode 100644
index 0ffb4d8766a8..000000000000
--- a/Documentation/devicetree/bindings/dma/mv-xor.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-* Marvell XOR engines
-
-Required properties:
-- compatible: Should be one of the following:
-  - "marvell,orion-xor"
-  - "marvell,armada-380-xor"
-  - "marvell,armada-3700-xor".
-- reg: Should contain registers location and length (two sets)
-    the first set is the low registers, the second set the high
-    registers for the XOR engine.
-- clocks: pointer to the reference clock
-
-The DT node must also contains sub-nodes for each XOR channel that the
-XOR engine has. Those sub-nodes have the following required
-properties:
-- interrupts: interrupt of the XOR channel
-
-The sub-nodes used to contain one or several of the following
-properties, but they are now deprecated:
-- dmacap,memcpy to indicate that the XOR channel is capable of memcpy operations
-- dmacap,memset to indicate that the XOR channel is capable of memset operations
-- dmacap,xor to indicate that the XOR channel is capable of xor operations
-- dmacap,interrupt to indicate that the XOR channel is capable of
-  generating interrupts
-
-Example:
-
-xor@d0060900 {
-	compatible = "marvell,orion-xor";
-	reg = <0xd0060900 0x100
-	       0xd0060b00 0x100>;
-	clocks = <&coreclk 0>;
-
-	xor00 {
-	      interrupts = <51>;
-	};
-	xor01 {
-	      interrupts = <52>;
-	};
-};
-- 
2.47.2


