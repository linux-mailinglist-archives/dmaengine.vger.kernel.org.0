Return-Path: <dmaengine+bounces-9529-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMeeMNIdvGnzsgIAu9opvQ
	(envelope-from <dmaengine+bounces-9529-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:01:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF92CE31C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92AB53070119
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80713EAC61;
	Thu, 19 Mar 2026 15:55:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331F3E9F98;
	Thu, 19 Mar 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935753; cv=none; b=ECcOCjCIca2VnWyLzKdfogH8+G2ilWLVsFDPdP/iIg0fZYy6IEkS2glJfrtg0cc2hETAaQZHw+jN5RRXzFniHy6yIEf95f2AvW+OjKBucSmqBwASxJ8L8L5qwxOKfpNIDCL3ZgQriEJC7doObmY/ef6ErtsYvwLcVdiV6WRDOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935753; c=relaxed/simple;
	bh=WMGWqBcFvtN0MqdxLGHwwwFXLWkz09suF6r3VyqdT6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8hSZ7UrA4gqt+WvruirVvy2gVK2ujLzDsp6MLa1NPI1u/Y05s5oHVzehFKMzKvlEsQMFm9+gyg4XXdUTNvjgnBK39dY72EXbMhYCtQu6G9AlAk22L4noD97wbwIJe2xYnbOATOIhtr4OvJBiMD4LbapHNxRW9akl0E5A9gPI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: USGzfxtPTtOp4X4fVEVwtg==
X-CSE-MsgGUID: M1oSURy5ThW4E1gGpRs7pA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2026 00:55:50 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.35])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5AD4C401B2FD;
	Fri, 20 Mar 2026 00:55:41 +0900 (JST)
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
Subject: [PATCH 07/22] ASoC: dt-bindings: renesas,rsnd: Add RZ/G3E support
Date: Thu, 19 Mar 2026 16:53:19 +0100
Message-ID: <20260319155334.51278-8-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9529-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.696];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AEFF92CE31C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the RZ/G3E (R9A09G047) SoC audio subsystem.

RZ/G3E has a different audio architecture from R-Car Gen2/Gen3/Gen4,
with additional clocks and resets:
- Per-SSI ADG clocks (adg.ssi.0-9)
- SCU related clocks (scu, scu_x2, scu_supply)
- SSIF supply clock
- AUDMAC peri-peri clock
- ADG clock
- Additional resets for SCU, ADG, and AUDMAC peri-peri

RZ/G3E has 5 DMA controllers that can all be used by audio peripherals.
To allow the DMA core to distribute channels across all available
controllers, increase the maximum number of DMA entries in DVC, SRC,
and SSIU sub-nodes so that multiple providers can be listed with
repeated channel names.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/sound/renesas,rsnd.yaml          | 169 +++++++++++++++---
 1 file changed, 148 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
index e8a2acb92646..bc8885c4fa24 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
@@ -58,6 +58,7 @@ properties:
           - renesas,rcar_sound-gen2
           - renesas,rcar_sound-gen3
           - renesas,rcar_sound-gen4
+          - renesas,rcar_sound-r9a09g047     # RZ/G3E
 
   reg:
     minItems: 1
@@ -97,20 +98,22 @@ properties:
 
   resets:
     minItems: 1
-    maxItems: 11
+    maxItems: 14
 
   reset-names:
     minItems: 1
-    maxItems: 11
+    maxItems: 14
 
   clocks:
     description: References to SSI/SRC/MIX/CTU/DVC/AUDIO_CLK clocks.
     minItems: 1
-    maxItems: 31
+    maxItems: 47
 
   clock-names:
     description: List of necessary clock names.
     # details are defined below
+    minItems: 1
+    maxItems: 47
 
   # ports is below
   port:
@@ -136,9 +139,17 @@ properties:
 
         properties:
           dmas:
-            maxItems: 1
+            description:
+              Must contain unique DMA specifiers, one per available
+              DMAC. On RZ/G3E, up to 5 for transmission.
+            minItems: 1
+            maxItems: 5
           dma-names:
-            const: tx
+            minItems: 1
+            maxItems: 5
+            items:
+              enum:
+                - tx
         required:
           - dmas
           - dma-names
@@ -174,13 +185,19 @@ properties:
           interrupts:
             maxItems: 1
           dmas:
-            maxItems: 2
+            description:
+              Must contain unique DMA specifiers, one per available
+              DMAC, for each transfer direction. On RZ/G3E, up to 5
+              for transmission and up to 5 for reception.
+            minItems: 2
+            maxItems: 10
           dma-names:
-            allOf:
-              - items:
-                  enum:
-                    - tx
-                    - rx
+            minItems: 2
+            maxItems: 10
+            items:
+              enum:
+                - tx
+                - rx
     additionalProperties: false
 
   rcar_sound,ssiu:
@@ -193,13 +210,19 @@ properties:
 
         properties:
           dmas:
-            maxItems: 2
+            description:
+              Must contain unique DMA specifiers, one per available
+              DMAC, for each transfer direction. On RZ/G3E, up to 5
+              for transmission and up to 5 for reception.
+            minItems: 2
+            maxItems: 10
           dma-names:
-            allOf:
-              - items:
-                  enum:
-                    - tx
-                    - rx
+            minItems: 2
+            maxItems: 10
+            items:
+              enum:
+                - tx
+                - rx
         required:
           - dmas
           - dma-names
@@ -299,7 +322,7 @@ allOf:
               - sru
               - ssi
               - adg
-  # for Gen2/Gen3
+  # for Gen2/Gen3/RZ/G3E
   - if:
       properties:
         compatible:
@@ -307,6 +330,7 @@ allOf:
             enum:
               - renesas,rcar_sound-gen2
               - renesas,rcar_sound-gen3
+              - renesas,rcar_sound-r9a09g047
     then:
       properties:
         reg:
@@ -338,7 +362,7 @@ allOf:
               - sdmc
 
   # --------------------
-  # clock-names
+  # clock-names / reset-names
   # --------------------
   - if:
       properties:
@@ -354,10 +378,18 @@ allOf:
               - ssi.0
               - ssiu.0
               - clkin
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar_sound-gen2
+              - renesas,rcar_sound-gen3
+    then:
       properties:
+        clocks:
+          maxItems: 31
         clock-names:
-          minItems: 1
           maxItems: 31
           items:
             oneOf:
@@ -368,6 +400,101 @@ allOf:
               - pattern: '^ctu\.[0-1]$'
               - pattern: '^dvc\.[0-1]$'
               - pattern: '^clk_(a|b|c|i)$'
+        resets:
+          maxItems: 11
+        reset-names:
+          maxItems: 11
+          items:
+            oneOf:
+              - const: ssi-all
+              - pattern: '^ssi\.[0-9]$'
+        rcar_sound,dvc:
+          patternProperties:
+            "^dvc-[0-1]$":
+              properties:
+                dmas:
+                  maxItems: 1
+                dma-names:
+                  maxItems: 1
+        rcar_sound,src:
+          patternProperties:
+            "^src-[0-9]$":
+              properties:
+                dmas:
+                  maxItems: 2
+                dma-names:
+                  maxItems: 2
+        rcar_sound,ssiu:
+          patternProperties:
+            "^ssiu-[0-9]+$":
+              properties:
+                dmas:
+                  maxItems: 2
+                dma-names:
+                  maxItems: 2
+  # for RZ/G3E
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rcar_sound-r9a09g047
+    then:
+      properties:
+        clocks:
+          maxItems: 47
+        clock-names:
+          maxItems: 47
+          items:
+            oneOf:
+              - const: ssi-all
+              - pattern: '^ssi\.[0-9]$'
+              - pattern: '^src\.[0-9]$'
+              - pattern: '^mix\.[0-1]$'
+              - pattern: '^ctu\.[0-1]$'
+              - pattern: '^dvc\.[0-1]$'
+              - pattern: '^clk_(a|b|c|i)$'
+              - const: ssif_supply
+              - const: scu
+              - const: scu_x2
+              - const: scu_supply
+              - pattern: '^adg\.ssi\.[0-9]$'
+              - const: audmac_pp
+              - const: adg
+        resets:
+          maxItems: 14
+        reset-names:
+          maxItems: 14
+          items:
+            oneOf:
+              - const: ssi-all
+              - pattern: '^ssi\.[0-9]$'
+              - const: scu
+              - const: adg
+              - const: audmac_pp
+        rcar_sound,dvc:
+          patternProperties:
+            "^dvc-[0-1]$":
+              properties:
+                dmas:
+                  maxItems: 5
+                dma-names:
+                  maxItems: 5
+        rcar_sound,src:
+          patternProperties:
+            "^src-[0-9]$":
+              properties:
+                dmas:
+                  maxItems: 10
+                dma-names:
+                  maxItems: 10
+        rcar_sound,ssiu:
+          patternProperties:
+            "^ssiu-[0-9]+$":
+              properties:
+                dmas:
+                  maxItems: 10
+                dma-names:
+                  maxItems: 10
 
 unevaluatedProperties: false
 
-- 
2.25.1


