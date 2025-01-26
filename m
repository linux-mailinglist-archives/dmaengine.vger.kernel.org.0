Return-Path: <dmaengine+bounces-4192-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15AA1CD95
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F293A76FE
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBD17B401;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlfftCyt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373178F39;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917946; cv=none; b=h8SdGjFJE4Ar/WcPJaboUfz/+bYbuYrUtFRpyYRuZHFMsFrsqw45WTEVelnbdeQlXTOMi1nXg1cgvohEwTfcwHuWq14U7L7iNGB4Z6yZ+ZVb56zfTOlv9sPyPxvkOJADUlEqDE6iHh7C1AWF+J8hPuqiLve8+YLoMkV9YKN5zGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917946; c=relaxed/simple;
	bh=O14r1qqxI0QT2llSScJucTEIHKL95nVBwpZogWhGWwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jte3Ab2W8/Mi1rXC1p+P0Y1E33LMreXAuqnogtKJO9bSSAJiDcYK8xiwklONqmHRpZUCNdTLOqNKCVDzgCkj/fo4ujpKCcOP/8ITp/SdFd6aRbQM308lpE6u90pe3WYazjRE74TvNNcRUC1XJFV8VngYwmdi6wXeeHQnEvXCHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlfftCyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 990C9C4CEE3;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917945;
	bh=O14r1qqxI0QT2llSScJucTEIHKL95nVBwpZogWhGWwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jlfftCyto9yufeiQxsS5xRcuoaGifNZZUisROjsaiAnASBvYa0OstRU9lsOEtE0/7
	 JPjMPN3TZaXnCmZ02o4OCE0HhKNFIJkRuVuXj34+JNRLcV0f6iCkTOfFoM2+bPM3GE
	 CNAUID/5p5OAaQV5+yv8ifAQWdPal9IXzLu3Q8D11NcsMHf6KkAXPtt/vHBuorSHFo
	 Yccvir5GVELnWqEtTZLDRgkqr4geflC3RuUGZUhMcs15rBP7GqYCJWanODtF/Mk1k/
	 HevOPUAumHwuzt1FMItH4M10+QWLJRNVdTgNUGFvC54KeU0iM+ybQxbnbFx/CQXROU
	 2XxRWvag0Gm9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCDC0218E;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 26 Jan 2025 19:58:56 +0100
Subject: [PATCH 1/9] dt-bindings: powerpc: Add binding for Freescale/NXP
 MPC83xx SoCs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250126-ppcyaml-v1-1-50649f51c3dd@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737917943; l=2560;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=E5l46pAV8cFDwcEg1WB+Na8IX5nk86e/w9y8E+nF/Rs=;
 b=7Wr9qCpmJvIjC1lyC/O75ZA3WieLQA6qbLwT1LieeCLorQzrlbIXYDMvvtqnRyrQj24Aw3daO
 hPZJLmboPkyDjYCsfo5vaoRG6SUf127m1KfVqBMeMYa2W0PLimeRwsz
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Add a new binding for MPC83xx platforms, describing the board compatible
strings used in currently existing device trees.

Note that the SoC bus is called immr@... in many existing devicetrees,
but this contradicts the simple-bus binding.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 .../bindings/powerpc/fsl/fsl,mpc83xx.yaml          | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml b/Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d51c85b505b0dec3a25d50e2bdc980cd2ee04b7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fsl,mpc83xx.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/fsl/fsl,mpc83xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale PowerQUICC II Pro (MPC83xx) platforms
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: MPC83xx Reference Design Boards
+        items:
+          - enum:
+              - fsl,mpc8308rdb
+              - fsl,mpc8315erdb
+              - fsl,mpc8360rdk
+              - fsl,mpc8377rdb
+              - fsl,mpc8377wlan
+              - fsl,mpc8378rdb
+              - fsl,mpc8379rdb
+
+patternProperties:
+  "^soc@.*$":
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - enum:
+                  - fsl,mpc8315-immr
+                  - fsl,mpc8308-immr
+              - const: simple-bus
+          - items:
+              - const: fsl,mpc8360-immr
+              - const: fsl,immr
+              - const: fsl,soc
+              - const: simple-bus
+          - const: simple-bus
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+        compatible = "fsl,mpc8315erdb";
+        model = "MPC8315E-RDB";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        soc@e0000000 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            device_type = "soc";
+            compatible = "fsl,mpc8315-immr", "simple-bus";
+            ranges = <0 0xe0000000 0x00100000>;
+            reg = <0xe0000000 0x00000200>;
+            bus-frequency = <0>;
+        };
+    };
+
+...

-- 
2.48.0.rc1.219.gb6b6757d772



