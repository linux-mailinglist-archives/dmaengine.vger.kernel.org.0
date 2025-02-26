Return-Path: <dmaengine+bounces-4579-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555BA4665F
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2025 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDED441452
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A221CC60;
	Wed, 26 Feb 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ro3A6kkU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F62904;
	Wed, 26 Feb 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585441; cv=none; b=V5aMLRv2FIgFJs+Hl1FqBZf9lHXxeFC9nZiWkDUOaXLI/a4Ysg3d9AGkxmks+gDw4DJu9Vf5wzut0Hu5MlkPJ+2WXNMu2Uh6x0Xq4dky3ssX3L3wD/li8rPaTNebdqXX0+h82SHOhNezt8ysv5uQIDH4xmDbDHvDclwrvwMCYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585441; c=relaxed/simple;
	bh=5yWLavvwI0H1epo50arLYjnvxfAKEJczFeAQGpcInyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=skapXRP6InkPLcIFDWThz3iQi4Iz8rCn3CnTbiIsoZ8lMbLqEuJdVZtjZH33gM4cHhA7p3U88N1AR9uV9x44rB3OytcM4uMjTJOYM3lJc5sXfBy0ksDiXvP6CGxHCASvhIeV0RVwdGKRZrYz8kjhBwxMq6hIK7JZMabzQIjys5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ro3A6kkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6191C4CED6;
	Wed, 26 Feb 2025 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740585440;
	bh=5yWLavvwI0H1epo50arLYjnvxfAKEJczFeAQGpcInyY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ro3A6kkUw6+Aq7KaL8SKhGSxTSNsEyiTl9Im+oh/6pVIRShCOPXDUF6C1sZu9yRPp
	 m0BEbZjsrsFQkKxC2yAWnhipoZ9VTnLwprK1JevyJlTBRx6TMktthLJCy7xY76bS05
	 8wr54QCr0zcfUSXqb66Y34JQg4xHUigP+2IvYJbeMz/ZT3RJX8fhUvnRTMijeKiuFM
	 mXq4WZPtzz+fZp4HWtLJFLUk08WvJFQVRaVxT6L7CifN9wnHMESinQe7VEfQs99Rwh
	 NqX8ddiQyx5YXTwl73Q7NpaxO9t/SyvkPGGUnYJ+qOk7rsWw4n1rFAkdEgaa5q8nSF
	 CGBx2WPtq4I8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0795C021B8;
	Wed, 26 Feb 2025 15:57:20 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 26 Feb 2025 16:57:17 +0100
Subject: [PATCH v3] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net>
X-B4-Tracking: v=1; b=H4sIANw5v2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3YKC5MrE3BzdlNxEXQvLFFPLRCMLi2SLJCWgjoKi1LTMCrBp0bG
 1tQDb3RJSXQAAAA==
X-Change-ID: 20250220-ppcyaml-dma-89d59a288c8b
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740585439; l=21305;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=/ZLo7by4FNWQrbI/efbUuyHj+Npnb2fWoWZy+mSq5bU=;
 b=Vbd4AJ2fxM0kPtfdcsl+Yl8vcboPIXXY5clc+geCMJ0kh1IGYGQRzv5UvX3wT4sZpoI6//u3u
 7xKvHfg/zChA87bOtgvxFC+tfcRXEgRuPV/IbUkUVgnYvo7DpIVf9SD
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
I considered referencing dma-controller.yaml, but that requires
the #dma-cells property (via dma-common.yaml), and I'm now sure which
value it should have, if any. Therefore I did not reference
dma-controller.yaml.

V3:
- split out as a single patch
- restructure "description" definitions to use "items:" as much as possible
- remove useless description of interrupts in fsl,elo3-dma
- rename DMA controller nodes to dma-controller@...
- use IRQ_TYPE_* constants in examples
- define unit address format for DMA channel nodes
- drop interrupts-parent properties from examples

V2:
- part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
  Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-5-8137b0c42526@posteo.net/
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
 .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 137 ++++++++++++++
 .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 125 +++++++++++++
 .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 132 +++++++++++++
 .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
 4 files changed, 394 insertions(+), 204 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..628f41355e41598dc24d59e92530d93b7e2bc590
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml
@@ -0,0 +1,137 @@
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
+    items:
+      - description:
+          DMA General Status Register, i.e. DGSR which contains status for
+          all the 4 DMA channels.
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
+  "^dma-channel@[0-9a-f]+$":
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@82a8 {
+        compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
+        reg = <0x82a8 4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x8100 0x1a4>;
+        interrupts = <71 IRQ_TYPE_LEVEL_LOW>;
+        cell-index = <0>;
+
+        dma-channel@0 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0 0x80>;
+            cell-index = <0>;
+            interrupts = <71 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        dma-channel@80 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0x80 0x80>;
+            cell-index = <1>;
+            interrupts = <71 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        dma-channel@100 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0x100 0x80>;
+            cell-index = <2>;
+            interrupts = <71 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        dma-channel@180 {
+            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
+            reg = <0x180 0x80>;
+            cell-index = <3>;
+            interrupts = <71 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/fsl,elo3-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,elo3-dma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6b9615a041f8f3292bc4f033b1b72584883b8941
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,elo3-dma.yaml
@@ -0,0 +1,125 @@
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
+    items:
+      - description:
+          DMA General Status Registers starting from DGSR0, for channel 1~4
+      - description:
+          DMA General Status Registers starting from DGSR1, for channel 5~8
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
+
+patternProperties:
+  "^dma-channel@[0-9a-f]+$":
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@100300 {
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
+            interrupts = <28 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@80 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x80 0x80>;
+            interrupts = <29 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@100 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x100 0x80>;
+            interrupts = <30 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@180 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x180 0x80>;
+            interrupts = <31 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@300 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x300 0x80>;
+            interrupts = <76 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@380 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x380 0x80>;
+            interrupts = <77 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@400 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x400 0x80>;
+            interrupts = <78 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+
+        dma-channel@480 {
+            compatible = "fsl,eloplus-dma-channel";
+            reg = <0x480 0x80>;
+            interrupts = <79 IRQ_TYPE_EDGE_FALLING 0 0>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..62d0e0e78b4f74622cba167a9ba847c4e9fb80c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.yaml
@@ -0,0 +1,132 @@
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
+    items:
+      - description:
+          DMA General Status Register, i.e. DGSR which contains
+          status for all the 4 DMA channels
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
+  "^dma-channel@[0-9a-f]+$":
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@21300 {
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
+            interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
+        };
+
+        dma-channel@80 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0x80 0x80>;
+            cell-index = <1>;
+            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+        };
+
+        dma-channel@100 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0x100 0x80>;
+            cell-index = <2>;
+            interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+        };
+
+        dma-channel@180 {
+            compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
+            reg = <0x180 0x80>;
+            cell-index = <3>;
+            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
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

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-ppcyaml-dma-89d59a288c8b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



