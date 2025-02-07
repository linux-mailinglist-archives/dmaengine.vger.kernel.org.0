Return-Path: <dmaengine+bounces-4339-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F1A2CF32
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95C83A8308
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748D1D79BE;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFtaIUSO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351591C7013;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963836; cv=none; b=VOgpBw2aI8tP/+eaW5C7Wbky8MWDwMV8g7cTImkxzioOZd1UaCd+lFHFzOlVYpqKMEPNnN1DCJHG2Sz7+CKxBTRV1Iahf7FDOlKRBx1SgdzXO7rhHsXdxfgZcIBMr9ISMEREpOnFA7SDSe2FoeeRMcyR3mhozFzg358CyXtccqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963836; c=relaxed/simple;
	bh=h6xL5izEN9fKPQQU4NjratT5cyYtedfsyUrxhR3WmEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiHvJO09TnfsaukIWm8rraVC5tO3Ytpy9fJclB+IVr3PkDwGX/WmOoHXDwcF5YXdz5xMAEpJZemnaznVRCBFYqopReK/P5FBGiLw/fpNrdQOjGWSHRlHDDxB3U3YTGSzj2nGCK6CQhD+JInXOX+ZdvlojMTNk9BXptOFs8eQtas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFtaIUSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82D8EC4CEF7;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963835;
	bh=h6xL5izEN9fKPQQU4NjratT5cyYtedfsyUrxhR3WmEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GFtaIUSOUhKhCvKt6h9LhYwoM5eqRrBKwLNgOGu34gIQfp0oefoqNxVizrJN2KxqB
	 Fm0AoQNHRU1Ogs6xekcL80BbEjYzfBROSs/8n2kYPKmDAOYzZDA+LC5cV9HTVsbqoh
	 OEZ4i2CsyFh/Fu/bdsg/4fgwgKN3te9R2Sy/BDx0XCtNSFkUoDok17t037qnjQG+fU
	 J2FnyWVOiE68cCQfKh/+G92vm7qLP6FIfTZ+dY0AM6DX9pYlnx7DhlK0PU9PJL7RO8
	 xvTkZSu0euUVc8xXNhInzZcBqMcsfGP7KzfOl1z4fbLerHWF3BAWw18gBEeJY7x5OC
	 nHA2eVcfAYttA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77383C02194;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 07 Feb 2025 22:30:22 +0100
Subject: [PATCH v2 05/12] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ppcyaml-v2-5-8137b0c42526@posteo.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
In-Reply-To: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Scott Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=20225;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=0XmxCWb0lxR3LKQhjqLbg3vhSL8R0BymC8p5/QN7IEo=;
 b=05RNsC0s0jckmF9E1/SzvMeR1f0Aoua2535hpLzteasCPplZ91iKphHfoA8GqLJQhjh9GhUEu
 KslD9fSC5kmAqZ1gOgKilLLHddoV7vpz38yDuGspx5agJ6+ujNxgn9q
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The devicetree bindings for Freescale DMA engines have so far existed as
a text file. This patch converts them to YAML, and specifies all the
compatible strings currently in use in arch/powerpc/boot/dts.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- remove unnecessary multiline markers
- fix additionalProperties to always be false
- add description/maxItems to interrupts
- add missing #address-cells/#size-cells properties
- convert "Note on DMA channel compatible properties" to YAML by listing
  fsl,ssi-dma-channel as a valid compatible value
- fix property ordering in examples: compatible and reg come first
- add missing newlines in examples
- trim subject line (remove "bindings")
---
 .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 140 ++++++++++++++
 .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 123 +++++++++++++
 .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 134 ++++++++++++++
 .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
 4 files changed, 397 insertions(+), 204 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3d8be9973fb98891a73cb701c1f983a63f444837
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,elo-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Elo DMA Controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description:
+  This is a little-endian 4-channel DMA controller, used in Freescale mpc83xx
+  series chips such as mpc8315, mpc8349, mpc8379 etc.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8313-dma
+          - fsl,mpc8315-dma
+          - fsl,mpc8323-dma
+          - fsl,mpc8347-dma
+          - fsl,mpc8349-dma
+          - fsl,mpc8360-dma
+          - fsl,mpc8377-dma
+          - fsl,mpc8378-dma
+          - fsl,mpc8379-dma
+      - const: fsl,elo-dma
+
+  reg:
+    maxItems: 1
+    description:
+      DMA General Status Register, i.e. DGSR which contains status for
+      all the 4 DMA channels.
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Controller index. 0 for controller @ 0x8100.
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+    description: Controller interrupt.
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^dma-channel@.*$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        oneOf:
+          # native DMA channel
+          - items:
+              - enum:
+                  - fsl,mpc8315-dma-channel
+                  - fsl,mpc8323-dma-channel
+                  - fsl,mpc8347-dma-channel
+                  - fsl,mpc8349-dma-channel
+                  - fsl,mpc8360-dma-channel
+                  - fsl,mpc8377-dma-channel
+                  - fsl,mpc8378-dma-channel
+                  - fsl,mpc8379-dma-channel
+              - const: fsl,elo-dma-channel
+
+          # audio DMA channel, see fsl,ssi.yaml
+          - const: fsl,ssi-dma-channel
+
+      reg:
+        maxItems: 1
+
+      cell-index:
+        description: DMA channel index starts at 0.
+
+      interrupts:
+        maxItems: 1
+        description:
+          Per-channel interrupt. Only necessary if no controller interrupt has
+          been provided.
+
+additionalProperties: false
+
+examples:
+  - |
+    dma@82a8 {
+        compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+        reg = <0x82a8 4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x8100 0x1a4>;
+        interrupt-parent = <&ipic>;
+        interrupts = <71 8>;
+        cell-index = <0>;
+
+        dma-channel@0 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0 0x80>;
+            cell-index = <0>;
+            interrupt-parent = <&ipic>;
+            interrupts = <71 8>;
+        };
+
+        dma-channel@80 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0x80 0x80>;
+            cell-index = <1>;
+            interrupt-parent = <&ipic>;
+            interrupts = <71 8>;
+        };
+
+        dma-channel@100 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0x100 0x80>;
+            cell-index = <2>;
+            interrupt-parent = <&ipic>;
+            interrupts = <71 8>;
+        };
+
+        dma-channel@180 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0x180 0x80>;
+            cell-index = <3>;
+            interrupt-parent = <&ipic>;
+            interrupts = <71 8>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/fsl,elo3-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,elo3-dma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..36865836b48af78af32d4e11f55a32e32771a23e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,elo3-dma.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,elo3-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Elo3 DMA Controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description:
+  DMA controller which has same function as EloPlus except that Elo3 has 8
+  channels while EloPlus has only 4, it is used in Freescale Txxx and Bxxx
+  series chips, such as t1040, t4240, b4860.
+
+properties:
+  compatible:
+    const: fsl,elo3-dma
+
+  reg:
+    maxItems: 2
+    description:
+      contains two entries for DMA General Status Registers, i.e. DGSR0 which
+      includes status for channel 1~4, and DGSR1 for channel 5~8
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+    description: Controller interrupt.
+
+patternProperties:
+  "^dma-channel@.*$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          # native DMA channel
+          - fsl,eloplus-dma-channel
+
+          # audio DMA channel, see fsl,ssi.yaml
+          - fsl,ssi-dma-channel
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+        description:
+          Per-channel interrupt. Only necessary if no controller interrupt has
+          been provided.
+
+additionalProperties: false
+
+examples:
+  - |
+    dma@100300 {
+        compatible = "fsl,elo3-dma";
+        reg = <0x100300 0x4>,
+              <0x100600 0x4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x100100 0x500>;
+
+        dma-channel@0 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x0 0x80>;
+            interrupts = <28 2 0 0>;
+        };
+
+        dma-channel@80 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x80 0x80>;
+            interrupts = <29 2 0 0>;
+        };
+
+        dma-channel@100 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x100 0x80>;
+            interrupts = <30 2 0 0>;
+        };
+
+        dma-channel@180 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x180 0x80>;
+            interrupts = <31 2 0 0>;
+        };
+
+        dma-channel@300 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x300 0x80>;
+            interrupts = <76 2 0 0>;
+        };
+
+        dma-channel@380 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x380 0x80>;
+            interrupts = <77 2 0 0>;
+        };
+
+        dma-channel@400 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x400 0x80>;
+            interrupts = <78 2 0 0>;
+        };
+
+        dma-channel@480 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x480 0x80>;
+            interrupts = <79 2 0 0>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..513fee051657832dc031d32c1f701bf7c3b89daa
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,eloplus-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale EloPlus DMA Controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description:
+  This is a 4-channel DMA controller with extended addresses and chaining,
+  mainly used in Freescale mpc85xx/86xx, Pxxx and BSC series chips, such as
+  mpc8540, mpc8641 p4080, bsc9131 etc.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8540-dma
+              - fsl,mpc8541-dma
+              - fsl,mpc8548-dma
+              - fsl,mpc8555-dma
+              - fsl,mpc8560-dma
+              - fsl,mpc8572-dma
+              - fsl,mpc8641-dma
+          - const: fsl,eloplus-dma
+      - const: fsl,eloplus-dma
+
+  reg:
+    maxItems: 1
+    description:
+      DMA General Status Register, i.e. DGSR which contains
+      status for all the 4 DMA channels
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      controller index.  0 for controller @ 0x21000, 1 for controller @ 0xc000
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+    description: Controller interrupt.
+
+patternProperties:
+  "^dma-channel@.*$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        oneOf:
+          # native DMA channel
+          - items:
+              - enum:
+                  - fsl,mpc8540-dma-channel
+                  - fsl,mpc8541-dma-channel
+                  - fsl,mpc8548-dma-channel
+                  - fsl,mpc8555-dma-channel
+                  - fsl,mpc8560-dma-channel
+                  - fsl,mpc8572-dma-channel
+              - const: fsl,eloplus-dma-channel
+
+          # audio DMA channel, see fsl,ssi.yaml
+          - const: fsl,ssi-dma-channel
+
+      reg:
+        maxItems: 1
+
+      cell-index:
+        description: DMA channel index starts at 0.
+
+      interrupts:
+        maxItems: 1
+        description:
+          Per-channel interrupt. Only necessary if no controller interrupt has
+          been provided.
+
+additionalProperties: false
+
+examples:
+  - |
+    dma@21300 {
+        compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
+        reg = <0x21300 4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x21100 0x200>;
+        cell-index = <0>;
+
+        dma-channel@0 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0 0x80>;
+            cell-index = <0>;
+            interrupt-parent = <&mpic>;
+            interrupts = <20 2>;
+        };
+
+        dma-channel@80 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0x80 0x80>;
+            cell-index = <1>;
+            interrupt-parent = <&mpic>;
+            interrupts = <21 2>;
+        };
+
+        dma-channel@100 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0x100 0x80>;
+            cell-index = <2>;
+            interrupt-parent = <&mpic>;
+            interrupts = <22 2>;
+        };
+
+        dma-channel@180 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0x180 0x80>;
+            cell-index = <3>;
+            interrupt-parent = <&mpic>;
+            interrupts = <23 2>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
deleted file mode 100644
index c11ad5c6db2190bf38c160632d9997122e169945..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
+++ /dev/null
@@ -1,204 +0,0 @@
-* Freescale DMA Controllers
-
-** Freescale Elo DMA Controller
-   This is a little-endian 4-channel DMA controller, used in Freescale mpc83xx
-   series chips such as mpc8315, mpc8349, mpc8379 etc.
-
-Required properties:
-
-- compatible        : must include "fsl,elo-dma"
-- reg               : DMA General Status Register, i.e. DGSR which contains
-                      status for all the 4 DMA channels
-- ranges            : describes the mapping between the address space of the
-                      DMA channels and the address space of the DMA controller
-- cell-index        : controller index.  0 for controller @ 0x8100
-- interrupts        : interrupt specifier for DMA IRQ
-
-- DMA channel nodes:
-        - compatible        : must include "fsl,elo-dma-channel"
-                              However, see note below.
-        - reg               : DMA channel specific registers
-        - cell-index        : DMA channel index starts at 0.
-
-Optional properties:
-        - interrupts        : interrupt specifier for DMA channel IRQ
-                              (on 83xx this is expected to be identical to
-                              the interrupts property of the parent node)
-
-Example:
-	dma@82a8 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
-		reg = <0x82a8 4>;
-		ranges = <0 0x8100 0x1a4>;
-		interrupt-parent = <&ipic>;
-		interrupts = <71 8>;
-		cell-index = <0>;
-		dma-channel@0 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <0>;
-			reg = <0 0x80>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-		};
-		dma-channel@80 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <1>;
-			reg = <0x80 0x80>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-		};
-		dma-channel@100 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <2>;
-			reg = <0x100 0x80>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-		};
-		dma-channel@180 {
-			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
-			cell-index = <3>;
-			reg = <0x180 0x80>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-		};
-	};
-
-** Freescale EloPlus DMA Controller
-   This is a 4-channel DMA controller with extended addresses and chaining,
-   mainly used in Freescale mpc85xx/86xx, Pxxx and BSC series chips, such as
-   mpc8540, mpc8641 p4080, bsc9131 etc.
-
-Required properties:
-
-- compatible        : must include "fsl,eloplus-dma"
-- reg               : DMA General Status Register, i.e. DGSR which contains
-                      status for all the 4 DMA channels
-- cell-index        : controller index.  0 for controller @ 0x21000,
-                                         1 for controller @ 0xc000
-- ranges            : describes the mapping between the address space of the
-                      DMA channels and the address space of the DMA controller
-
-- DMA channel nodes:
-        - compatible        : must include "fsl,eloplus-dma-channel"
-                              However, see note below.
-        - cell-index        : DMA channel index starts at 0.
-        - reg               : DMA channel specific registers
-        - interrupts        : interrupt specifier for DMA channel IRQ
-
-Example:
-	dma@21300 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
-		reg = <0x21300 4>;
-		ranges = <0 0x21100 0x200>;
-		cell-index = <0>;
-		dma-channel@0 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <0 0x80>;
-			cell-index = <0>;
-			interrupt-parent = <&mpic>;
-			interrupts = <20 2>;
-		};
-		dma-channel@80 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <0x80 0x80>;
-			cell-index = <1>;
-			interrupt-parent = <&mpic>;
-			interrupts = <21 2>;
-		};
-		dma-channel@100 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <0x100 0x80>;
-			cell-index = <2>;
-			interrupt-parent = <&mpic>;
-			interrupts = <22 2>;
-		};
-		dma-channel@180 {
-			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <0x180 0x80>;
-			cell-index = <3>;
-			interrupt-parent = <&mpic>;
-			interrupts = <23 2>;
-		};
-	};
-
-** Freescale Elo3 DMA Controller
-   DMA controller which has same function as EloPlus except that Elo3 has 8
-   channels while EloPlus has only 4, it is used in Freescale Txxx and Bxxx
-   series chips, such as t1040, t4240, b4860.
-
-Required properties:
-
-- compatible        : must include "fsl,elo3-dma"
-- reg               : contains two entries for DMA General Status Registers,
-                      i.e. DGSR0 which includes status for channel 1~4, and
-                      DGSR1 for channel 5~8
-- ranges            : describes the mapping between the address space of the
-                      DMA channels and the address space of the DMA controller
-
-- DMA channel nodes:
-        - compatible        : must include "fsl,eloplus-dma-channel"
-        - reg               : DMA channel specific registers
-        - interrupts        : interrupt specifier for DMA channel IRQ
-
-Example:
-dma@100300 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "fsl,elo3-dma";
-	reg = <0x100300 0x4>,
-	      <0x100600 0x4>;
-	ranges = <0x0 0x100100 0x500>;
-	dma-channel@0 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x0 0x80>;
-		interrupts = <28 2 0 0>;
-	};
-	dma-channel@80 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x80 0x80>;
-		interrupts = <29 2 0 0>;
-	};
-	dma-channel@100 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x100 0x80>;
-		interrupts = <30 2 0 0>;
-	};
-	dma-channel@180 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x180 0x80>;
-		interrupts = <31 2 0 0>;
-	};
-	dma-channel@300 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x300 0x80>;
-		interrupts = <76 2 0 0>;
-	};
-	dma-channel@380 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x380 0x80>;
-		interrupts = <77 2 0 0>;
-	};
-	dma-channel@400 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x400 0x80>;
-		interrupts = <78 2 0 0>;
-	};
-	dma-channel@480 {
-		compatible = "fsl,eloplus-dma-channel";
-		reg = <0x480 0x80>;
-		interrupts = <79 2 0 0>;
-	};
-};
-
-Note on DMA channel compatible properties: The compatible property must say
-"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel" to be used by the Elo DMA
-driver (fsldma).  Any DMA channel used by fsldma cannot be used by another
-DMA driver, such as the SSI sound drivers for the MPC8610.  Therefore, any DMA
-channel that should be used for another driver should not use
-"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel".  For the SSI drivers, for
-example, the compatible property should be "fsl,ssi-dma-channel".  See ssi.txt
-for more information.

-- 
2.48.0.rc1.219.gb6b6757d772



