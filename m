Return-Path: <dmaengine+bounces-4344-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD83A2CF5F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C7116D40C
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7541DF26B;
	Fri,  7 Feb 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBjy4UuM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07B1DED6E;
	Fri,  7 Feb 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963837; cv=none; b=JIhHRM107Gj19fCsRxe9nNFUX1E/Bzd5ztW6V7WEq61q1Rs9ydqdTj/Rp0xHWC83ckQ+RVq1q9ZC9iG2cOW46OaN7xPkXnk7UO868xmEIzAswioXOaKRNRwadIbhS9bdk31FfSscopDGTz6PSucAWqGBeNPPWfrA0oikEbQ8PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963837; c=relaxed/simple;
	bh=U5UemYYck+g6K/d3gcb9OegxZyY2n//O2XiyL7ugTcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJrasy6sFsNNPevJ3yFnasz1zIPad4PRUPFZSHB88Ork5to8R9B6v8FYtYNEKVNK6BD/Q5pve3WwC2AIX/pSi+70L/VKppwoUgk4wStJfYAS2ucJ8wiXdOa0oOyejUKlLUzLv3UYsCxwqmKlsP2+Q/ogkI8ZXaobgllamr9cDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBjy4UuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49856C4CEEB;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963836;
	bh=U5UemYYck+g6K/d3gcb9OegxZyY2n//O2XiyL7ugTcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nBjy4UuM3SUjIdxik6BR5rm/ASIJDNQxPXN6mSjlI/9OhbWm0pZ67xR8x2mMfUhJ2
	 pmCvmwPfQNJr7yMaXgaW3IiGDMuUfwMsP2wZrEiXIdiePG6DyLpOc/jVvLhKwMUvma
	 i+DRou6NNxW1lQyr6j3oepEfzlI7mFHYShrjOEAX3ss/mvHQq7j6TSmzceRed2Kyeg
	 22SUIbA3CvdGchhzow9F3mV0iGlv7y+4IPzE/IFPZ8cxKv37/E4K6uo59XGKcp1WcA
	 Sdb1YkwjH0iM0Dz45WKyVSeHDPyPae/84FQDUuxGixxRDv7L3IWgcuMOxBIVZH3//b
	 0GhrBdgdRLEKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38036C021A0;
	Fri,  7 Feb 2025 21:30:36 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 07 Feb 2025 22:30:28 +0100
Subject: [PATCH v2 11/12] dt-bindings: nand: Add fsl,elbc-fcm-nand
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ppcyaml-v2-11-8137b0c42526@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=2741;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=A7t/u30eqpoJx8jMTUhNPC2EH5W9JFBL9vrCsuCzJiM=;
 b=6cIaRoAnn733LBvmUf6ToU9hIJ7bv+M0rf3gbWNtCLaOwrVFONlFsub9Dce/9cDwwRNLlYNWC
 H/IAes0Q6zqDDWsbACciyF+d+riDCoYn9mhlEeFsw3WbFpHU26/6A9t
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Formalize the binding already supported by the fsl_elbc_nand.c driver
and used in several device trees in arch/powerpc/boot/dts/.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- split out from fsl,elbc binding patch
- constrain #address-cells and #size-cells
- add a general description
- use unevaluatedProperties=false instead of additionalProperties=false
- fix property order to comply with dts coding style
- include raw-nand-chip.yaml instead of nand-chip.yaml
---
 .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1de97bb24fa4a83e2ea5d94ab822dd0e37baa102
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NAND flash attached to Freescale eLBC
+
+description:
+  The Freescale Enhanced Local Bus controller (eLBC) contains logic to
+  interface with NAND flash, called the NAND Flash Control Machine (FCM).
+  This binding describes flash attached to an eLBC using the FCM.
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+allOf:
+  - $ref: raw-nand-chip.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,mpc8313-fcm-nand
+              - fsl,mpc8315-fcm-nand
+              - fsl,mpc8377-fcm-nand
+              - fsl,mpc8378-fcm-nand
+              - fsl,mpc8379-fcm-nand
+              - fsl,mpc8536-fcm-nand
+              - fsl,mpc8569-fcm-nand
+              - fsl,mpc8572-fcm-nand
+              - fsl,p1020-fcm-nand
+              - fsl,p1021-fcm-nand
+              - fsl,p1025-fcm-nand
+              - fsl,p2020-fcm-nand
+          - const: fsl,elbc-fcm-nand
+      - const: fsl,elbc-fcm-nand
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    localbus {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        nand@1,0 {
+            compatible = "fsl,mpc8315-fcm-nand",
+                         "fsl,elbc-fcm-nand";
+            reg = <0x1 0x0 0x2000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+        };
+    };

-- 
2.48.0.rc1.219.gb6b6757d772



