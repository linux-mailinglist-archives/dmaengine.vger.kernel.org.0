Return-Path: <dmaengine+bounces-4199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44AA1CDDF
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 20:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7E83A7715
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959D190052;
	Sun, 26 Jan 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS5bj54U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF416FF44;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917946; cv=none; b=t7hJTk9BcFtb3SnhmfV8GOF5RK3X83Ik/wm5yPHfTZPNEf+Gu4CVryJiT08QlfHEWwrwZSGDBmxILHjzulehXoAcNP8UFEJpZ271AH9Jh1Nfzvfq1TwysVUgzgWNLMsXnl5Ftg1KTlCZk6+ekHrL14RzfoXzHOgGhetT8mCyA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917946; c=relaxed/simple;
	bh=besDC4D0drpNlTcCMCLHyFd/qhP9T8iaGBo3K4aN2OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nn/IEWbZ5U2utUgQyKGgmdaPv25eBUgBa6QlNSKfdRki98Lkra9aKN+4n7vpWIyDKOZudC5gVTCp4/FfOxzymGqwPFwlttj8kqb1aremKWqVFpyxeiBN5areijvNF4UJQ+Rwu8Lxfbrh1CKsXkkK1zbp1KMa+10roMylAZyhodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS5bj54U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26C1EC4AF5F;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917946;
	bh=besDC4D0drpNlTcCMCLHyFd/qhP9T8iaGBo3K4aN2OU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YS5bj54UueHvcLodRMthcuaK5YpHiKvBmwaJNysQBaxINp7cxgs2vtfP9bjibVfbx
	 x8jOsI6cJRQkIcnTFpQwy9BCslxThZb07BRJcNV+PdAAIXITfMdapmRdeSKjYnPP6z
	 oCttv3Uer5rMERkXnu5m0Wr22fY9/woe4YPpbKCGuykQ985dgzQoT8ienE4aU8pwvV
	 e4sjx/O8A/ZrSBePnicE4GTePpk+eJwkk2nuVTjGysbd7Oy2KtPFPxmCBw51695Xve
	 pgcR+bjc4YqV9wYcLnifUVIi3c3qPHO7jBHF+5oc8Ci+L4tQccRks8+3XYyY7dvzY7
	 l0sbZWz5/P+PQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB9C02190;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 26 Jan 2025 19:59:03 +0100
Subject: [PATCH 8/9] dt-bindings: spi: Convert Freescale SPI bindings to
 YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250126-ppcyaml-v1-8-50649f51c3dd@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737917943; l=6825;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=xDa2X5ix7Yz+uUKr7B2an+BkT3tqXXsRwdduIK9iWgc=;
 b=4QCYXX3kpPGMdIqbCZvKPP/cQo3jUJcs6wRQLhb2Owtx6YTpaYDSWzkNBanZH6Dsamu4kpkge
 fyBklNraCwfDQXDyg9Fcfu6YmzGiRTaSu2oLelsxED9beNbs3wG63u6
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

fsl-spi.txt contains the bindings for the fsl,spi and fsl,espi
contollers. Convert them to YAML.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 .../devicetree/bindings/spi/fsl,espi.yaml          | 56 +++++++++++++++++
 Documentation/devicetree/bindings/spi/fsl,spi.yaml | 71 ++++++++++++++++++++++
 Documentation/devicetree/bindings/spi/fsl-spi.txt  | 62 -------------------
 3 files changed, 127 insertions(+), 62 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,espi.yaml b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..350275760210c5763af0c7b1e1522ccbfb97eec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,espi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale eSPI (Enhanced Serial Peripheral Interface) controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    const: fsl,mpc8536-espi
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+  fsl,espi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of the chipselect signals.
+
+  fsl,csbef:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Chip select assertion time in bits before frame starts
+
+  fsl,csaft:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Chip select negation time in bits after frame ends
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - fsl,espi-num-chipselects
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@110000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,mpc8536-espi";
+        reg = <0x110000 0x1000>;
+        interrupts = <53 0x2>;
+        interrupt-parent = <&mpic>;
+        fsl,espi-num-chipselects = <4>;
+        fsl,csbef = <1>;
+        fsl,csaft = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/fsl,spi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8efa971b5954a93665cb624345774f2966bb5648
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SPI (Serial Peripheral Interface) controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    enum:
+      - fsl,spi
+      - aeroflexgaisler,spictrl
+
+  reg:
+    maxItems: 1
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      QE SPI subblock index.
+      0: QE subblock SPI1
+      1: QE subblock SPI2
+
+  mode:
+    description: SPI operation mode
+    enum:
+      - cpu
+      - cpu-qe
+
+  interrupts: true
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: input clock frequency to non FSL_SOC cores
+
+  cs-gpios: true
+
+  fsl,spisel_boot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      For the MPC8306 and MPC8309, specifies that the SPISEL_BOOT signal is used
+      as chip select for a slave device. Use reg = <number of gpios> in the
+      corresponding child node, i.e. 0 if the cs-gpios property is not present.
+
+required:
+  - compatible
+  - reg
+  - mode
+  - interrupts
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@4c0 {
+        cell-index = <0>;
+        compatible = "fsl,spi";
+        reg = <0x4c0 0x40>;
+        interrupts = <82 0>;
+        interrupt-parent = <&intc>;
+        mode = "cpu";
+        cs-gpios = <&gpio 18 1          // device reg=<0>
+                    &gpio 19 1>;        // device reg=<1>
+    };
diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentation/devicetree/bindings/spi/fsl-spi.txt
deleted file mode 100644
index 0654380eb7515d8bda80eea1486e77b939ac38d8..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-* SPI (Serial Peripheral Interface)
-
-Required properties:
-- cell-index : QE SPI subblock index.
-		0: QE subblock SPI1
-		1: QE subblock SPI2
-- compatible : should be "fsl,spi" or "aeroflexgaisler,spictrl".
-- mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
-- reg : Offset and length of the register set for the device
-- interrupts : <a b> where a is the interrupt number and b is a
-  field that represents an encoding of the sense and level
-  information for the interrupt.  This should be encoded based on
-  the information in section 2) depending on the type of interrupt
-  controller you have.
-- clock-frequency : input clock frequency to non FSL_SOC cores
-
-Optional properties:
-- cs-gpios : specifies the gpio pins to be used for chipselects.
-  The gpios will be referred to as reg = <index> in the SPI child nodes.
-  If unspecified, a single SPI device without a chip select can be used.
-- fsl,spisel_boot : for the MPC8306 and MPC8309, specifies that the
-  SPISEL_BOOT signal is used as chip select for a slave device. Use
-  reg = <number of gpios> in the corresponding child node, i.e. 0 if
-  the cs-gpios property is not present.
-
-Example:
-	spi@4c0 {
-		cell-index = <0>;
-		compatible = "fsl,spi";
-		reg = <4c0 40>;
-		interrupts = <82 0>;
-		interrupt-parent = <700>;
-		mode = "cpu";
-		cs-gpios = <&gpio 18 1		// device reg=<0>
-			    &gpio 19 1>;	// device reg=<1>
-	};
-
-
-* eSPI (Enhanced Serial Peripheral Interface)
-
-Required properties:
-- compatible : should be "fsl,mpc8536-espi".
-- reg : Offset and length of the register set for the device.
-- interrupts : should contain eSPI interrupt, the device has one interrupt.
-- fsl,espi-num-chipselects : the number of the chipselect signals.
-
-Optional properties:
-- fsl,csbef: chip select assertion time in bits before frame starts
-- fsl,csaft: chip select negation time in bits after frame ends
-
-Example:
-	spi@110000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "fsl,mpc8536-espi";
-		reg = <0x110000 0x1000>;
-		interrupts = <53 0x2>;
-		interrupt-parent = <&mpic>;
-		fsl,espi-num-chipselects = <4>;
-		fsl,csbef = <1>;
-		fsl,csaft = <1>;
-	};

-- 
2.48.0.rc1.219.gb6b6757d772



