Return-Path: <dmaengine+bounces-4337-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E75A2CF25
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12FB188EE9E
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12D1C6FED;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNRibzA0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979F1B85F8;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963836; cv=none; b=OxQE47QTX+Uz9s6ZRfqezYYSHdgqaZF4fyhhUOQol2VLpm8BR6E7rW1v6Lf4pSwyxLFv5A+xi0nJsczXBEFYHzeHbslyaGKuxz1TKV4LoT9nFNpzzj8PbNTaSEtUv2SW/EVmJ+8Zwj8CKewXk3XhRI67+fDng1anHSBuOk3lWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963836; c=relaxed/simple;
	bh=nktEztgiNtX/g4rmdLEVKXUelw39pbboF7CNwlBd40Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukyHjH8WxQYWZKSvavFMT+5p2Nzembrzg7kD30nQkHSJ8fNG5H2jR5Pg/K/Xe+Tr++NLRZ8UT6sGccEwYaZkcM/3/LlIl5UjeltLVjAl9Edh31f7fCjHf5xxQZxsgrwtX7QFxKiPWlNtJ6yLvca3ty4xb6Ux0VUb/9u3UxwbwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNRibzA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DA76C4CEE6;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963835;
	bh=nktEztgiNtX/g4rmdLEVKXUelw39pbboF7CNwlBd40Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kNRibzA0sw2Sw+B0fy2zZdwXVSxYwIYmTwqT33kjPkzxWMOTJkeCi7kZ+St1dYfJ8
	 sDsPsSvzLXHdK7tlUqACRftJt7E2CJ93vVMwrufGvdyalzrNO0up2+sN0gPyW5Bjuk
	 bq/+royUYXCZQ7BsBSVq8+G/SZ/L5oRONDOxcJNfGwws28/ZnwBbpD0jUFXJyyMbGJ
	 sMYQIW3/T7ibAELE7FzHc9n0ROzdEM5tdduEbXhUCz9oMQzTLKvi9eI2Rxjoc4faZN
	 3EUy9pC3HZ8m/nDI6FWey8qNm+N1t10AJzLBMdF3s+XseMSZjzyQDjr6Z9GPXGsJgL
	 YEZOfjytMwkow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2267DC0219D;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 07 Feb 2025 22:30:19 +0100
Subject: [PATCH v2 02/12] dt-bindings: ata: Convert fsl,pq-sata to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ppcyaml-v2-2-8137b0c42526@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=3808;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=UpnIOgI342qJlYPCanJVhpXk4WK6YM5Ksj/vzI9NEeg=;
 b=IMEEL81nsnb2ijBv3LXOcNNng8dQqK5mDCiPuvJw5PIblvynwYV/YQROKecYzJSMsuTEb53Rb
 z5adZJegyg5CeBejUIlBGgfzgjd8CuS7MscsQzisoYwXCU7aFBlh0dZ
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert the Freescale PowerQUICC SATA controller binding from text form
to YAML. The list of compatible strings reflects current usage.

To clarify the description, I changed it to mention "each SATA
controller" instead of each port.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- remove unnecessary multiline marker (|)
- clarified controllers vs. ports in the description
- trim subject line (remove "binding")
---
 .../devicetree/bindings/ata/fsl,pq-sata.yaml       | 59 ++++++++++++++++++++++
 Documentation/devicetree/bindings/ata/fsl-sata.txt | 28 ----------
 2 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..97eea11b4fbbb773487c004abbedcb7bd290605c
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,pq-sata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale 8xxx/3.0 Gb/s SATA nodes
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description:
+  SATA nodes are defined to describe on-chip Serial ATA controllers.
+  Each SATA controller should have its own node.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8377-sata
+              - fsl,mpc8536-sata
+              - fsl,mpc8315-sata
+              - fsl,mpc8379-sata
+          - const: fsl,pq-sata
+      - const: fsl,pq-sata-v2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3, 4]
+    description: |
+      1 for controller @ 0x18000
+      2 for controller @ 0x19000
+      3 for controller @ 0x1a000
+      4 for controller @ 0x1b000
+
+required:
+  - compatible
+  - interrupts
+  - cell-index
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    sata@18000 {
+        compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+        reg = <0x18000 0x1000>;
+        cell-index = <1>;
+        interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-parent = <&ipic>;
+    };
diff --git a/Documentation/devicetree/bindings/ata/fsl-sata.txt b/Documentation/devicetree/bindings/ata/fsl-sata.txt
deleted file mode 100644
index fd63bb3becc9363c520a8fd06629fdc52c4d4299..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/ata/fsl-sata.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Freescale 8xxx/3.0 Gb/s SATA nodes
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA port should have its own node.
-
-Required properties:
-- compatible        : compatible list, contains 2 entries, first is
-		 "fsl,CHIP-sata", where CHIP is the processor
-		 (mpc8315, mpc8379, etc.) and the second is
-		 "fsl,pq-sata"
-- interrupts        : <interrupt mapping for SATA IRQ>
-- cell-index        : controller index.
-                          1 for controller @ 0x18000
-                          2 for controller @ 0x19000
-                          3 for controller @ 0x1a000
-                          4 for controller @ 0x1b000
-
-Optional properties:
-- reg               : <registers mapping>
-
-Example:
-	sata@18000 {
-		compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
-		reg = <0x18000 0x1000>;
-		cell-index = <1>;
-		interrupts = <2c 8>;
-		interrupt-parent = < &ipic >;
-	};

-- 
2.48.0.rc1.219.gb6b6757d772



