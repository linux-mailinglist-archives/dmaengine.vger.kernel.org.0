Return-Path: <dmaengine+bounces-9831-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGzDCKo0zmk8mAYAu9opvQ
	(envelope-from <dmaengine+bounces-9831-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:19:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF1386BD9
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82135305B364
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0605E36308A;
	Thu,  2 Apr 2026 09:07:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E91936493C;
	Thu,  2 Apr 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120873; cv=none; b=ih4BvocPxBrirzd+3jIEvh7WZob6gl2480oXE7l/P/Owe6iYgL4DbhdQAXhnK9A5MklVkLL5wnxbXjhbI1FNH9MnxirznJrII4QBPGvdDU6keEZCVgfTySEn0CLqGvV0JwlBppOKFzYyymIihDvan3x/kDlNzNLVK2dDX7wnRxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120873; c=relaxed/simple;
	bh=r0szSXzre0lQvz8ZreFkXVHs0155RoES95xCRgWIMSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7FPg/F7ciQOIXL2rlQcYKBVUa7BbuHQSBSXBVeoGUPqKEejFPSn8qtNel84mwhyj5Cc3w+FdqLqwE74cfysEMi8QQEVz+4k3b2t3KMNgy5AuHJsMJju0hC15X7tkYwzlyPDLZR3X5dGUm2kcKSr5bgx9Yc4tzpcR8RIfxNvxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: dFG6N9hrR8ejFWSPOdQpAg==
X-CSE-MsgGUID: +dn9WaTrSkqm1BCQqfKcBA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2026 18:07:50 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.136])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 839E2413E676;
	Thu,  2 Apr 2026 18:07:42 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v2 05/24] ASoC: dt-bindings: renesas,rsnd: Split into generic and SoC-specific parts
Date: Thu,  2 Apr 2026 11:05:04 +0200
Message-ID: <20260402090524.9137-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9831-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.873];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 87EF1386BD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current renesas,rsnd.yaml binding file handles all supported SoCs
in a single schema, resulting in deeply nested if/else/then constructs
that become increasingly difficult to maintain. Each new SoC addition
amplifies this complexity, making reviews harder and diffs noisier than
they need to be.

Refactor the binding by extracting the common properties shared across
all SoCs into a dedicated renesas,rsnd-common.yaml schema, and keeping
only SoC-specific constraints (required nodes, port counts, clock names,
etc.) in per-SoC or per-family files that $ref the common part.

This prepares the ground for upcoming SoCs such as the RZ/G3E, which
introduces a different set of audio resources compared to existing
R-Car Gen variants. With the split in place, adding RZ/G3E support
becomes a self-contained change that neither bloats a monolithic schema
nor buries new constraints inside ever-deeper conditional blocks.

No functional change in validation behaviour for existing device trees.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: New patch

 .../bindings/sound/renesas,rsnd-common.yaml   | 196 +++++++++++
 .../bindings/sound/renesas,rsnd.yaml          | 319 +++++-------------
 2 files changed, 274 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml
new file mode 100644
index 000000000000..ec6bf644d1a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd-common.yaml
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,rsnd-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car/RZ Sound Common Properties
+
+maintainers:
+  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
+description:
+  Common property and subnode definitions shared by Renesas R-Car and RZ
+  sound controller bindings.
+
+select: false
+
+properties:
+  compatible: true
+
+  reg: true
+
+  reg-names: true
+
+  "#sound-dai-cells":
+    description:
+      Must be 0 for a single-DAI system and 1 for a multi-DAI system.
+    enum: [0, 1]
+
+  "#clock-cells":
+    description:
+      Must be 0 when the system has audio_clkout and 1 when it has
+      audio_clkout0/1/2/3.
+    enum: [0, 1]
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  clock-frequency:
+    description: Audio clock output frequency for audio_clkout0/1/2/3.
+
+  clkout-lr-asynchronous:
+    description: audio_clkoutn is asynchronous with lr-clock.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  power-domains: true
+
+  resets: true
+
+  reset-names: true
+
+  clocks: true
+
+  clock-names: true
+
+  port:
+    $ref: audio-graph-port.yaml#/definitions/port-base
+    unevaluatedProperties: false
+    patternProperties:
+      "^endpoint(@[0-9a-f]+)?$":
+        $ref: audio-graph-port.yaml#/definitions/endpoint-base
+        properties:
+          playback:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+          capture:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+        unevaluatedProperties: false
+
+  rcar_sound,dvc:
+    description: DVC subnode.
+    type: object
+    patternProperties:
+      "^dvc-[0-1]$":
+        type: object
+        additionalProperties: false
+        properties:
+          dmas: true
+          dma-names: true
+        required:
+          - dmas
+          - dma-names
+    additionalProperties: false
+
+  rcar_sound,mix:
+    description: MIX subnode.
+    type: object
+    patternProperties:
+      "^mix-[0-1]$":
+        type: object
+        additionalProperties: false
+    additionalProperties: false
+
+  rcar_sound,ctu:
+    description: CTU subnode.
+    type: object
+    patternProperties:
+      "^ctu-[0-7]$":
+        type: object
+        additionalProperties: false
+    additionalProperties: false
+
+  rcar_sound,src:
+    description: SRC subnode.
+    type: object
+    patternProperties:
+      "^src-[0-9]$":
+        type: object
+        additionalProperties: false
+        properties:
+          interrupts:
+            maxItems: 1
+          dmas: true
+          dma-names: true
+    additionalProperties: false
+
+  rcar_sound,ssiu:
+    description: SSIU subnode.
+    type: object
+    patternProperties:
+      "^ssiu-[0-9]+$":
+        type: object
+        additionalProperties: false
+        properties:
+          dmas: true
+          dma-names: true
+        required:
+          - dmas
+          - dma-names
+    additionalProperties: false
+
+  rcar_sound,ssi:
+    description: SSI subnode.
+    type: object
+    patternProperties:
+      "^ssi-[0-9]$":
+        type: object
+        additionalProperties: false
+        properties:
+          interrupts:
+            maxItems: 1
+          dmas: true
+          dma-names: true
+          shared-pin:
+            description: Shared clock pin.
+            $ref: /schemas/types.yaml#/definitions/flag
+          pio-transfer:
+            description: PIO transfer mode.
+            $ref: /schemas/types.yaml#/definitions/flag
+          no-busif:
+            description: BUSIF is not used for the mem-to-SSI via DMA case.
+            $ref: /schemas/types.yaml#/definitions/flag
+        required:
+          - interrupts
+    additionalProperties: false
+
+patternProperties:
+  'rcar_sound,dai(@[0-9a-f]+)?$':
+    description: DAI subnode.
+    type: object
+    patternProperties:
+      "^dai([0-9]+)?$":
+        type: object
+        additionalProperties: false
+        properties:
+          playback:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+          capture:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+        anyOf:
+          - required:
+              - playback
+          - required:
+              - capture
+    additionalProperties: false
+
+  'ports(@[0-9a-f]+)?$':
+    $ref: audio-graph-port.yaml#/definitions/port-base
+    unevaluatedProperties: false
+    patternProperties:
+      '^port(@[0-9a-f]+)?$':
+        $ref: "#/properties/port"
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: dai-common.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index e8a2acb92646..0d989922a5b4 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -9,8 +9,11 @@ title: Renesas R-Car Sound Driver
 maintainers:
   - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
-properties:
+description:
+  Binding for Renesas R-Car Gen1/Gen2/Gen3/Gen4 and RZ/G1/G2 sound
+  controllers using the standard RSND layout.
 
+properties:
   compatible:
     oneOf:
       # for Gen1 SoC
@@ -67,34 +70,6 @@ properties:
     minItems: 1
     maxItems: 5
 
-  "#sound-dai-cells":
-    description: |
-      it must be 0 if your system is using single DAI
-      it must be 1 if your system is using multi  DAIs
-      This is used on simple-audio-card
-    enum: [0, 1]
-
-  "#clock-cells":
-    description: |
-      it must be 0 if your system has audio_clkout
-      it must be 1 if your system has audio_clkout0/1/2/3
-    enum: [0, 1]
-
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 0
-
-  clock-frequency:
-    description: for audio_clkout0/1/2/3
-
-  clkout-lr-asynchronous:
-    description: audio_clkoutn is asynchronizes with lr-clock.
-    $ref: /schemas/types.yaml#/definitions/flag
-
-  power-domains: true
-
   resets:
     minItems: 1
     maxItems: 11
@@ -109,181 +84,45 @@ properties:
     maxItems: 31
 
   clock-names:
-    description: List of necessary clock names.
-    # details are defined below
-
-  # ports is below
-  port:
-    $ref: audio-graph-port.yaml#/definitions/port-base
-    unevaluatedProperties: false
-    patternProperties:
-      "^endpoint(@[0-9a-f]+)?":
-        $ref: audio-graph-port.yaml#/definitions/endpoint-base
-        properties:
-          playback:
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-          capture:
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-        unevaluatedProperties: false
-
-  rcar_sound,dvc:
-    description: DVC subnode.
-    type: object
-    patternProperties:
-      "^dvc-[0-1]$":
-        type: object
-        additionalProperties: false
-
-        properties:
-          dmas:
-            maxItems: 1
-          dma-names:
-            const: tx
-        required:
-          - dmas
-          - dma-names
-    additionalProperties: false
-
-  rcar_sound,mix:
-    description: MIX subnode.
-    type: object
-    patternProperties:
-      "^mix-[0-1]$":
-        type: object
-        additionalProperties: false
-    additionalProperties: false
-
-  rcar_sound,ctu:
-    description: CTU subnode.
-    type: object
-    patternProperties:
-      "^ctu-[0-7]$":
-        type: object
-        additionalProperties: false
-    additionalProperties: false
-
-  rcar_sound,src:
-    description: SRC subnode.
-    type: object
-    patternProperties:
-      "^src-[0-9]$":
-        type: object
-        additionalProperties: false
-
-        properties:
-          interrupts:
-            maxItems: 1
-          dmas:
-            maxItems: 2
-          dma-names:
-            allOf:
-              - items:
-                  enum:
-                    - tx
-                    - rx
-    additionalProperties: false
-
-  rcar_sound,ssiu:
-    description: SSIU subnode.
-    type: object
-    patternProperties:
-      "^ssiu-[0-9]+$":
-        type: object
-        additionalProperties: false
-
-        properties:
-          dmas:
-            maxItems: 2
-          dma-names:
-            allOf:
-              - items:
-                  enum:
-                    - tx
-                    - rx
-        required:
-          - dmas
-          - dma-names
-    additionalProperties: false
-
-  rcar_sound,ssi:
-    description: SSI subnode.
-    type: object
-    patternProperties:
-      "^ssi-[0-9]$":
-        type: object
-        additionalProperties: false
-
-        properties:
-          interrupts:
-            maxItems: 1
-          dmas:
-            minItems: 2
-            maxItems: 4
-          dma-names:
-            allOf:
-              - items:
-                  enum:
-                    - tx
-                    - rx
-                    - txu # if no ssiu node
-                    - rxu # if no ssiu node
-
-          shared-pin:
-            description: shared clock pin
-            $ref: /schemas/types.yaml#/definitions/flag
-          pio-transfer:
-            description: PIO transfer mode
-            $ref: /schemas/types.yaml#/definitions/flag
-          no-busif:
-            description: BUSIF is not used when [mem -> SSI] via DMA case
-            $ref: /schemas/types.yaml#/definitions/flag
-        required:
-          - interrupts
-    additionalProperties: false
+    description: List of clock names.
+    minItems: 1
+    maxItems: 31
+
+  "#sound-dai-cells": true
+
+  "#clock-cells": true
+
+  "#address-cells": true
+
+  "#size-cells": true
+
+  clock-frequency: true
+
+  clkout-lr-asynchronous: true
+
+  power-domains: true
+
+  port: true
+
+  rcar_sound,dvc: true
+
+  rcar_sound,mix: true
+
+  rcar_sound,ctu: true
+
+  rcar_sound,src: true
+
+  rcar_sound,ssiu: true
+
+  rcar_sound,ssi: true
 
 patternProperties:
-  # For DAI base
-  'rcar_sound,dai(@[0-9a-f]+)?$':
-    description: DAI subnode.
-    type: object
-    patternProperties:
-      "^dai([0-9]+)?$":
-        type: object
-        additionalProperties: false
-
-        properties:
-          playback:
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-          capture:
-            $ref: /schemas/types.yaml#/definitions/phandle-array
-        anyOf:
-          - required:
-              - playback
-          - required:
-              - capture
-    additionalProperties: false
-
-  'ports(@[0-9a-f]+)?$':
-    $ref: audio-graph-port.yaml#/definitions/port-base
-    unevaluatedProperties: false
-    patternProperties:
-      '^port(@[0-9a-f]+)?$':
-        $ref: "#/properties/port"
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - clocks
-  - clock-names
+  'rcar_sound,dai(@[0-9a-f]+)?$': true
+  'ports(@[0-9a-f]+)?$': true
 
 allOf:
-  - $ref: dai-common.yaml#
+  - $ref: renesas,rsnd-common.yaml#
 
-  # --------------------
-  # reg/reg-names
-  # --------------------
-  # for Gen1
   - if:
       properties:
         compatible:
@@ -295,11 +134,10 @@ allOf:
           maxItems: 3
         reg-names:
           items:
-            enum:
-              - sru
-              - ssi
-              - adg
-  # for Gen2/Gen3
+            - const: sru
+            - const: ssi
+            - const: adg
+
   - if:
       properties:
         compatible:
@@ -310,16 +148,34 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 5
+          maxItems: 5
         reg-names:
           items:
-            enum:
-              - scu
-              - adg
-              - ssiu
-              - ssi
-              - audmapp
-  # for Gen4
+            - const: scu
+            - const: adg
+            - const: ssiu
+            - const: ssi
+            - const: audmapp
+        resets:
+          maxItems: 11
+        reset-names:
+          items:
+            oneOf:
+              - const: ssi-all
+              - pattern: '^ssi\.[0-9]$'
+        clocks:
+          maxItems: 31
+        clock-names:
+          items:
+            oneOf:
+              - const: ssi-all
+              - pattern: '^ssi\.[0-9]$'
+              - pattern: '^src\.[0-9]$'
+              - pattern: '^mix\.[0-1]$'
+              - pattern: '^ctu\.[0-1]$'
+              - pattern: '^dvc\.[0-1]$'
+              - pattern: '^clk_(a|b|c|i)$'
+
   - if:
       properties:
         compatible:
@@ -336,38 +192,19 @@ allOf:
               - ssiu
               - ssi
               - sdmc
-
-  # --------------------
-  # clock-names
-  # --------------------
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: renesas,rcar_sound-gen4
-    then:
-      properties:
-        clock-names:
-          maxItems: 3
+        resets:
+          maxItems: 2
+        reset-names:
           items:
-            enum:
-              - ssi.0
-              - ssiu.0
-              - clkin
-    else:
-      properties:
+            - const: ssiu.0
+            - const: ssi.0
+        clocks:
+          maxItems: 3
         clock-names:
-          minItems: 1
-          maxItems: 31
           items:
-            oneOf:
-              - const: ssi-all
-              - pattern: '^ssi\.[0-9]$'
-              - pattern: '^src\.[0-9]$'
-              - pattern: '^mix\.[0-1]$'
-              - pattern: '^ctu\.[0-1]$'
-              - pattern: '^dvc\.[0-1]$'
-              - pattern: '^clk_(a|b|c|i)$'
+            - const: ssiu.0
+            - const: ssi.0
+            - const: clkin
 
 unevaluatedProperties: false
 
-- 
2.25.1


