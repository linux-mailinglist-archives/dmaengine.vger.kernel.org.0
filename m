Return-Path: <dmaengine+bounces-4198-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B92A1CDA7
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EFC1884910
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19B18C031;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quQJIISy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127917E00E;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917946; cv=none; b=WWgSlRGr92rlAF/VmwwLTRYhTWPiiFsRgjkyg7r8zpm604pN1UKY/GKTG612e2m3LeEVoqWp2Guy/4eHTjNCGX0CMUj0J72WHlps2jq4DDyHxyY0XXa9YALnwzNTg4HOr4ERfxXjrQI43M612YK1NEmCf89EIl/r8RVqsxoBckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917946; c=relaxed/simple;
	bh=5XCExjbd/gPubOXYpsr7rABeBjCpjSYExLXU0tOI0LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dymU2bne3RVsNXZb4/5E4Rx4ylgjEYwUvMvZoCkn0mHDRn59iV68ZcKTBkIuMSr6m72fQUAYABmdK3Nt3HpIgcGU5SpTVp8OzoGLv8T5BMVZSxgq7r1FIGSUODIQmWinlMG0Uk4jl0iy0UqfWJj+BwurRPgyonBZeFzHV02R8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quQJIISy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B89C4AF1B;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917946;
	bh=5XCExjbd/gPubOXYpsr7rABeBjCpjSYExLXU0tOI0LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=quQJIISy488kggkk/qUhZslV/d1ZmYFeRwALGcQEPbBi2h8W6Sm/5VO6z4kR/Et85
	 awiwKs4/D0MP7E2sSGTcR0+kJ2nQMt33AdJyeLP/TqNEkmn7kXSke/VBKc5yW1uOLa
	 kdO3UDYwEthSI6IVhJ8nGHlCEnQWtfS+py2lNy7qvx3uGROuwhkDgnFZQcOjTAxSyj
	 tqbP92gkkpqCzf/hZGhebqI4AQSglz8eX9qbjHd2exqXDFUaktnmljm0PbiR+X+8Je
	 QuYWxwV3c1jcUPoQ3KCCOY2m+Bt993vviFTXG/NLHI6p+CqVbxjbocJ0ox6FjrTLFe
	 2w1l4UX8HEzXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E2CC0218F;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 26 Jan 2025 19:59:01 +0100
Subject: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
In-Reply-To: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737917943; l=3075;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=FQ86ArTRbtYapZ+OdNjSwmXsUKuvNxgsJkLWcXU8vL4=;
 b=/vrsRJm6P5La8dsDwOVQ6eswy9pjJEMA+/9/xmb7cy6W3UlNGJUHTns1MgAOIJh2MnjMvbm71
 B7AFiUB9fFmCttFV7fseyezhA/JwDM7xbQO09sxNWHowpiclOJskGNT
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Supplement Documentation/devicetree/bindings/pci/fsl,pci.txt with a more
formal binding in YAML format.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..12e86a9c20dfe2362d11f085bd9ae47238c4a37f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/pci/fsl,mpc8xxx-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
+
+description: |
+  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs.
+  See also: Documentation/devicetree/bindings/pci/fsl,pci.txt
+
+maintainers:
+  - J. Neuschäfer <j.neuschaefer@gmx.net>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8308-pcie
+              - fsl,mpc8315-pcie
+              - fsl,mpc8377-pcie
+              - fsl,mpc8378-pcie
+          - const: fsl,mpc8314-pcie
+      - const: fsl,mpc8314-pcie
+      - items:
+          - const: fsl,mpc8360-pci
+          - const: fsl,mpc8349-pci
+      - const: fsl,mpc8349-pci
+      - items:
+          - const: fsl,mpc8540-pcix
+          - const: fsl,mpc8540-pci
+      - const: fsl,mpc8540-pci
+      - items:
+          - const: fsl,mpc8540-pcix
+          - const: fsl,mpc8540-pci
+      - const: fsl,mpc8548-pcie
+      - const: fsl,mpc8548-pcie
+      - const: fsl,mpc8641-pcie
+
+  reg:
+    minItems: 1
+    items:
+      - description: internal registers
+      - description: config space access registers
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - reg
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pci1: pcie@e0009000 {
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+        reg = <0xe0009000 0x00001000>;
+        ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+                  0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+        bus-range = <0 255>;
+        interrupt-map-mask = <0xf800 0 0 7>;
+        interrupt-map = <0 0 0 1 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 2 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 3 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 4 &ipic 1 IRQ_TYPE_LEVEL_LOW>;
+        clock-frequency = <0>;
+    };
+
+...

-- 
2.48.0.rc1.219.gb6b6757d772



