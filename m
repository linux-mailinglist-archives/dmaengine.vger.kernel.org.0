Return-Path: <dmaengine+bounces-4340-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9652A2CF37
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5116D3F9
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12C1D958E;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7kYzEbF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F31D0F5A;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963836; cv=none; b=ZEiRbdbOF0HrcMqmHS9BWB6nq0XE7ECdOM58pMjPX/adI3SmbrBSw7Z6iy4Z72h6gMslOGkTFr1cp/fKAU0f+6eqGSaYkfQtCOudOH3WJyq1wPAbp6JCDNZX1d24za0vgkpROT35228y4Gk9CO1VuXx+I+od60i21h186qmaHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963836; c=relaxed/simple;
	bh=fqvAh3iKxOl03ArBCkYTvP/GeGQRKw1fc2EwMT7Iylc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eL96fDy1DESYccwdc7KMbdZt/t4nfjZAtuEM1DJS5YiRa56nTcFhHV+RI1d7WKC9k1hFM8H5fzwZAnuwLRnZ+4TmMccyHp8L4vzCV3aDY8XDgh+bzXzpSujeVBJlA7k2WURpcj0PnM0/J0Cndgx9CfFUzZ+k3qOzRWd/q/adC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7kYzEbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE809C116B1;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963835;
	bh=fqvAh3iKxOl03ArBCkYTvP/GeGQRKw1fc2EwMT7Iylc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P7kYzEbFv5XvnqA9e0Aw2hN/mJRZM27jQPH1NC1dLXOY023QXk/rORY52thAt4Mdz
	 IETcYpeRUiFbFi5nhNx5iYFzW6OsssSlEVnUg8NOz6WheSOyOrSQH4fRPJgwKwW/nJ
	 GUnAOxEjOCkKarOkpR4/dMMD9MKp/kyyu15l201GH1QFIgYUSLUeCuylliv+tyBS76
	 PZ3bBRkl3Jlf0aq/SQ22KHDfHe+UFncODbI+oH+5KAH+98cKh8mAVq9OAWv0I8QQuM
	 6d0sdji7khwUHKrFpdHXbdH+OXkYla7EFI9+U0yF4/dv1NRZ7/g9q/udgu16gysYi+
	 567gwgWihYFdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908A2C0219D;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 07 Feb 2025 22:30:23 +0100
Subject: [PATCH v2 06/12] dt-bindings: pci: Convert fsl,mpc83xx-pcie to
 YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=5802;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=jBiH9+MQmhRrwEmLTkNNDzkIkSq8VyyQ3zetJ06KX9U=;
 b=sEBW0totelYgL1en7cVmNkknyNI5Sj/Sspm1mJTetH6lj+iSulPd72CfWDp7mXxTwMSsXTvC8
 CcPFFfl4jGrD9Ji4ICjmccGslMxPc79Ljlsx1zaFK/lzwD1MvefNj68
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Formalise the binding for the PCI controllers in the Freescale MPC8xxx
chip family. Information about PCI-X-specific properties was taken from
fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
xpedite5200_xmon.dts.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- merge fsl,pci.txt into fsl,mpc8xxx-pci.yaml
- regroup compatible strings, list single-item values in one enum
- trim subject line (remove "binding")
- fix property order to comply with dts coding style
---
 .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 115 +++++++++++++++++++++
 Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -----
 2 files changed, 115 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..57c5503cec47e6e90ed2b09835bfad10309db927
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
@@ -0,0 +1,115 @@
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
+      - enum:
+          - fsl,mpc8314-pcie
+          - fsl,mpc8349-pci
+          - fsl,mpc8540-pci
+          - fsl,mpc8548-pcie
+          - fsl,mpc8641-pcie
+      - items:
+          - enum:
+              - fsl,mpc8308-pcie
+              - fsl,mpc8315-pcie
+              - fsl,mpc8377-pcie
+              - fsl,mpc8378-pcie
+          - const: fsl,mpc8314-pcie
+      - items:
+          - const: fsl,mpc8360-pci
+          - const: fsl,mpc8349-pci
+      - items:
+          - const: fsl,mpc8540-pcix
+          - const: fsl,mpc8540-pci
+
+  reg:
+    minItems: 1
+    items:
+      - description: internal registers
+      - description: config space access registers
+
+  clock-frequency: true
+
+  interrupts:
+    items:
+      - description: Consolidated PCI interrupt
+
+  fsl,pci-agent-force-enum:
+    type: boolean
+    description:
+      Typically any Freescale PCI-X bridge hardware strapped into Agent mode is
+      prevented from enumerating the bus. The PrPMC form-factor requires all
+      mezzanines to be PCI-X Agents, but one per system may still enumerate the
+      bus.
+
+      This property allows a PCI-X bridge to be used for bus enumeration
+      despite being strapped into Agent mode.
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
+    pcie@e0009000 {
+        compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+        reg = <0xe0009000 0x00001000>;
+        ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+                  0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        bus-range = <0 255>;
+        interrupt-map-mask = <0xf800 0 0 7>;
+        interrupt-map = <0 0 0 1 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 2 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 3 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 4 &ipic 1 IRQ_TYPE_LEVEL_LOW>;
+        clock-frequency = <0>;
+    };
+
+  - |
+    pci@ef008000 {
+        compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+        reg = <0xef008000 0x1000>;
+        ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+                  0x01000000 0 0x00000000 0xd0000000 0 0x01000000>;
+        #interrupt-cells = <1>;
+        #size-cells = <2>;
+        #address-cells = <3>;
+        device_type = "pci";
+        clock-frequency = <33333333>;
+        interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+        interrupt-map = </* IDSEL */
+                         0xe000 0 0 1 &mpic 2 1
+                         0xe000 0 0 2 &mpic 3 1>;
+        interrupts-extended = <&mpic 24 2>;
+        bus-range = <0 0>;
+        fsl,pci-agent-force-enum;
+    };
+
+
+...
diff --git a/Documentation/devicetree/bindings/pci/fsl,pci.txt b/Documentation/devicetree/bindings/pci/fsl,pci.txt
deleted file mode 100644
index d8ac4a768e7e65b465f83308cc918ec471309dcf..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/pci/fsl,pci.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Bus Enumeration by Freescale PCI-X Agent
-
-Typically any Freescale PCI-X bridge hardware strapped into Agent mode
-is prevented from enumerating the bus. The PrPMC form-factor requires
-all mezzanines to be PCI-X Agents, but one per system may still
-enumerate the bus.
-
-The property defined below will allow a PCI-X bridge to be used for bus
-enumeration despite being strapped into Agent mode.
-
-Required properties:
-- fsl,pci-agent-force-enum : There is no value associated with this
-  property. The property itself is treated as a boolean.
-
-Example:
-
-	/* PCI-X bridge known to be PrPMC Monarch */
-	pci0: pci@ef008000 {
-		fsl,pci-agent-force-enum;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-		device_type = "pci";
-		...
-		...
-	};

-- 
2.48.0.rc1.219.gb6b6757d772



