Return-Path: <dmaengine+bounces-4191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C07A1CD8D
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2F18847A3
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6415B984;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlBl+2Me"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DE25A621;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917946; cv=none; b=Sb8ylXpbq/Npw3pK2T1N/yUyLfXW72++OT/gA9YSDaUnsncX00HqJYctsJcBQkcvdVAnFH5lXT/bd4P6Eg8VO9hCx90HoQx8HOnicXcZ9oB5+Dl34LHgIULqB2D8Dxug2lWgK+Babu47QHALKgHWokRbjA04dRU1mnwfLH0u5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917946; c=relaxed/simple;
	bh=PfmNx/8FKpi9tfUAdO7gZEl/uHyfgKgSWW2BXdSdoIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4x/gJwhwDYSFGgzaSQtOgccdsypeI+nbvNywSaKAxDiWDM0V7iMG4icbHmCtM0K9j9l+lXq2mr+ii7F7AP+iau4e4LfuJ8kNhJp8UzyoC9zXw0Kp+qx5lh5/kecmGdhQ9ur8FJ103ae4TFBhX8Xuay2UgzhnuMsyHa5TiBu3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlBl+2Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC328C4CEEA;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917945;
	bh=PfmNx/8FKpi9tfUAdO7gZEl/uHyfgKgSWW2BXdSdoIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hlBl+2Mepw3J0ugLK7PkI8UhzdeeqA/WiddWAV3kijb7ZnCtkPlAyMnYcEBRKzM8i
	 szPVi3M92ZsLsWNMLoZRauZkytz+GVITyoORsXs1LFwgUKIAOBOcRIUeYEWQYIQB5A
	 3eYI/ojthnmUg2xz45MP76X0LM9NAfOUXljfNym5onKAeu0ORIKBMlYvLyLg52/MUk
	 LP3i9Yb0exACSUyS2RblZUbAjiM5bIAdcVQXNSsneEpXLdeRhG/5cYZlCmEpLJjcp8
	 rux3S6W1R4QAF0j7ZLLp6ihPOh92E4FabI0Z7i9XcG/fELKiegSW1Clla/onX+AYxA
	 1R41p4+M9CSFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959D7C0218F;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 26 Jan 2025 19:58:57 +0100
Subject: [PATCH 2/9] dt-bindings: ata: Convert fsl,pq-sata binding to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250126-ppcyaml-v1-2-50649f51c3dd@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737917943; l=3504;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=48lSRCoXCpxIM3oWRMWEs2/wzI+AW7ICjxV1sPl67HM=;
 b=bLScZP/2+P6PR65AL0gqKUI72UMsRCVo5PvGbwA6A20OrYb8mo+L9jUpwnATuOGNgbYUCZiMa
 IDQ1X0kek+XC8PpxrWEqVS4GPZSevrgs3kbZPbmh63BNiFb2AkiKb0p
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert the Freescale PowerQUICC SATA controller binding from text form
to YAML. The list of compatible strings reflects current usage.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 .../devicetree/bindings/ata/fsl,pq-sata.yaml       | 59 ++++++++++++++++++++++
 Documentation/devicetree/bindings/ata/fsl-sata.txt | 28 ----------
 2 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6af31ffbcad5e9cc83118a0bd8eaf45351a2823f
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
+description: |
+  SATA nodes are defined to describe on-chip Serial ATA controllers.
+  Each SATA port should have its own node.
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



