Return-Path: <dmaengine+bounces-4336-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16E8A2CF17
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E862C188EEAF
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58501B87E2;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/C7c3zQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D51AA7BF;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963835; cv=none; b=sXwyhkuRCKjq3qFc8Yr17IaFwBZKVGJsx9Op4yhgqt6Ljs2d8ZkBfdMyWWc/f2G37minWV/K4WG/G3SlC1fuboTIepc3OM3akue8gKPznQtIPpDk+gnm08Qyi8+tbi4Mg6nfJeTVBTASvADifumK6wwLm0szOPjzlRx/cYhr3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963835; c=relaxed/simple;
	bh=5GdUYxP6p/09yhFXkJHwFVSV0BkcjuTdUuLi/3yaqlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ldjy2NlDhHr/nn8WZNgZ040mQU++80p1fUcFC4wwx2iXcyaSNcQxqK/wyAGDvCnutlFbHlzSBd9KlxrEBm+FZkpKtsJ2wAcMHhy6H62P9IB41EE1sIQYy8rF1waRtIyHPJeB1yTdBV4uMNKGCKPmbrk6gQoBMhnAE7dw4Ol+gZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/C7c3zQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 507ECC4CEEF;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963835;
	bh=5GdUYxP6p/09yhFXkJHwFVSV0BkcjuTdUuLi/3yaqlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u/C7c3zQ9TAxCCrolYTB45QcVKM7sOpRFR/OJyUQzu7oqZxbBMut/N2C793GFJZu+
	 vNQEkl8ot+aAqNuy9iwvDs0QSoYammyjK02qc2zmhA33QkDxlWhgRYj96bNnMLXjTT
	 b9w7G5VhmNczUQMIjeNjIXtSiAhQAoittCrJ1Mf4rYG2OLU+WvB2Ls8Y06cSLEm/XK
	 ssRcQWUV/X1J3a3/z2RDxxm2riLQHG6Cg6ZMD5aTBfFKDm2pX+eUj2GD206Bxn6jDd
	 XQbePeMA52ZD/j1ZiHqyLDzuYzLiFJYp0wC6HfwaJeKnNYrhUUt1v1Fmgo+E59EA4X
	 rW5mJJtcijgLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F804C02194;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 07 Feb 2025 22:30:20 +0100
Subject: [PATCH v2 03/12] dt-bindings: crypto: Convert fsl,sec-2.0 to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-ppcyaml-v2-3-8137b0c42526@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=9358;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=+yTRVwl3VkcYahav8JkTXEVtr2bYHRekq+nInu+cROg=;
 b=fEk9M9rQDa1tD+jSDet5rbVxe3FcOFRrFAHu7LNTf0mTG3qF6jgn3SmfgK/yLFHsBT9pqb4SZ
 k5YaOEc/p9aCrYatv/JAtUloZ+0YUvM6ZO651oGft59rqHlXU4tiMn+
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert the Freescale security engine (crypto accelerator) binding from
text form to YAML. The list of compatible strings reflects what was
previously described in prose; not all combinations occur in existing
devicetrees.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

V2:
- several improvements suggested by Rob Herring:
  - remove unnecessary multiline markers
  - constrain fsl,num-channels to enum: [1,4]
  - constrain fsl,channel-fifo-len to plausible limits
  - constrain fsl,exec-units-mask to maximum=0xfff
- trim subject line (remove "binding")
---
 .../devicetree/bindings/crypto/fsl,sec2.0.yaml     | 142 +++++++++++++++++++++
 .../devicetree/bindings/crypto/fsl-sec2.txt        |  65 ----------
 2 files changed, 142 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec2.0.yaml b/Documentation/devicetree/bindings/crypto/fsl,sec2.0.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0b82f3b68b5f82e7fb52d292a623d452c1cdb059
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl,sec2.0.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/fsl,sec2.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SoC SEC Security Engines versions 1.x-2.x-3.x
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net.
+
+properties:
+  compatible:
+    description:
+      Should contain entries for this and backward compatible SEC versions,
+      high to low. Warning - SEC1 and SEC2 are mutually exclusive.
+    oneOf:
+      - items:
+          - const: fsl,sec3.3
+          - const: fsl,sec3.1
+          - const: fsl,sec3.0
+          - const: fsl,sec2.4
+          - const: fsl,sec2.2
+          - const: fsl,sec2.1
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec3.1
+          - const: fsl,sec3.0
+          - const: fsl,sec2.4
+          - const: fsl,sec2.2
+          - const: fsl,sec2.1
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec3.0
+          - const: fsl,sec2.4
+          - const: fsl,sec2.2
+          - const: fsl,sec2.1
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec2.4
+          - const: fsl,sec2.2
+          - const: fsl,sec2.1
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec2.2
+          - const: fsl,sec2.1
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec2.1
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec2.0
+      - items:
+          - const: fsl,sec1.2
+          - const: fsl,sec1.0
+      - items:
+          - const: fsl,sec1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  fsl,num-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 4 ]
+    description: An integer representing the number of channels available.
+
+  fsl,channel-fifo-len:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 100
+    description:
+      An integer representing the number of descriptor pointers each channel
+      fetch fifo can hold.
+
+  fsl,exec-units-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0xfff
+    description: |
+      The bitmask representing what execution units (EUs) are available.
+      EU information should be encoded following the SEC's Descriptor Header
+      Dword EU_SEL0 field documentation, i.e. as follows:
+
+        bit 0  = reserved - should be 0
+        bit 1  = set if SEC has the ARC4 EU (AFEU)
+        bit 2  = set if SEC has the DES/3DES EU (DEU)
+        bit 3  = set if SEC has the message digest EU (MDEU/MDEU-A)
+        bit 4  = set if SEC has the random number generator EU (RNG)
+        bit 5  = set if SEC has the public key EU (PKEU)
+        bit 6  = set if SEC has the AES EU (AESU)
+        bit 7  = set if SEC has the Kasumi EU (KEU)
+        bit 8  = set if SEC has the CRC EU (CRCU)
+        bit 11 = set if SEC has the message digest EU extended alg set (MDEU-B)
+
+      remaining bits are reserved for future SEC EUs.
+
+  fsl,descriptor-types-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The bitmask representing what descriptors are available. Descriptor type
+      information should be encoded following the SEC's Descriptor Header Dword
+      DESC_TYPE field documentation, i.e. as follows:
+
+        bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
+        bit 1  = set if SEC supports the ipsec_esp descriptor type
+        bit 2  = set if SEC supports the common_nonsnoop desc. type
+        bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
+        bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
+        bit 5  = set if SEC supports the srtp descriptor type
+        bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
+        bit 7  = set if SEC supports the pkeu_assemble descriptor type
+        bit 8  = set if SEC supports the aesu_key_expand_output desc.type
+        bit 9  = set if SEC supports the pkeu_ptmul descriptor type
+        bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
+        bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
+
+      ..and so on and so forth.
+
+required:
+  - compatible
+  - reg
+  - fsl,num-channels
+  - fsl,channel-fifo-len
+  - fsl,exec-units-mask
+  - fsl,descriptor-types-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* MPC8548E */
+    crypto@30000 {
+        compatible = "fsl,sec2.1", "fsl,sec2.0";
+        reg = <0x30000 0x10000>;
+        interrupts = <29 2>;
+        interrupt-parent = <&mpic>;
+        fsl,num-channels = <4>;
+        fsl,channel-fifo-len = <24>;
+        fsl,exec-units-mask = <0xfe>;
+        fsl,descriptor-types-mask = <0x12b0ebf>;
+    };
diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec2.txt b/Documentation/devicetree/bindings/crypto/fsl-sec2.txt
deleted file mode 100644
index 125f155d00d052eec7d5093b5c5076cbe720417f..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/crypto/fsl-sec2.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-Freescale SoC SEC Security Engines versions 1.x-2.x-3.x
-
-Required properties:
-
-- compatible : Should contain entries for this and backward compatible
-  SEC versions, high to low, e.g., "fsl,sec2.1", "fsl,sec2.0" (SEC2/3)
-                             e.g., "fsl,sec1.2", "fsl,sec1.0" (SEC1)
-    warning: SEC1 and SEC2 are mutually exclusive
-- reg : Offset and length of the register set for the device
-- interrupts : the SEC's interrupt number
-- fsl,num-channels : An integer representing the number of channels
-  available.
-- fsl,channel-fifo-len : An integer representing the number of
-  descriptor pointers each channel fetch fifo can hold.
-- fsl,exec-units-mask : The bitmask representing what execution units
-  (EUs) are available. It's a single 32-bit cell. EU information
-  should be encoded following the SEC's Descriptor Header Dword
-  EU_SEL0 field documentation, i.e. as follows:
-
-	bit 0  = reserved - should be 0
-	bit 1  = set if SEC has the ARC4 EU (AFEU)
-	bit 2  = set if SEC has the DES/3DES EU (DEU)
-	bit 3  = set if SEC has the message digest EU (MDEU/MDEU-A)
-	bit 4  = set if SEC has the random number generator EU (RNG)
-	bit 5  = set if SEC has the public key EU (PKEU)
-	bit 6  = set if SEC has the AES EU (AESU)
-	bit 7  = set if SEC has the Kasumi EU (KEU)
-	bit 8  = set if SEC has the CRC EU (CRCU)
-	bit 11 = set if SEC has the message digest EU extended alg set (MDEU-B)
-
-remaining bits are reserved for future SEC EUs.
-
-- fsl,descriptor-types-mask : The bitmask representing what descriptors
-  are available. It's a single 32-bit cell. Descriptor type information
-  should be encoded following the SEC's Descriptor Header Dword DESC_TYPE
-  field documentation, i.e. as follows:
-
-	bit 0  = set if SEC supports the aesu_ctr_nonsnoop desc. type
-	bit 1  = set if SEC supports the ipsec_esp descriptor type
-	bit 2  = set if SEC supports the common_nonsnoop desc. type
-	bit 3  = set if SEC supports the 802.11i AES ccmp desc. type
-	bit 4  = set if SEC supports the hmac_snoop_no_afeu desc. type
-	bit 5  = set if SEC supports the srtp descriptor type
-	bit 6  = set if SEC supports the non_hmac_snoop_no_afeu desc.type
-	bit 7  = set if SEC supports the pkeu_assemble descriptor type
-	bit 8  = set if SEC supports the aesu_key_expand_output desc.type
-	bit 9  = set if SEC supports the pkeu_ptmul descriptor type
-	bit 10 = set if SEC supports the common_nonsnoop_afeu desc. type
-	bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor type
-
-  ..and so on and so forth.
-
-Example:
-
-	/* MPC8548E */
-	crypto@30000 {
-		compatible = "fsl,sec2.1", "fsl,sec2.0";
-		reg = <0x30000 0x10000>;
-		interrupts = <29 2>;
-		interrupt-parent = <&mpic>;
-		fsl,num-channels = <4>;
-		fsl,channel-fifo-len = <24>;
-		fsl,exec-units-mask = <0xfe>;
-		fsl,descriptor-types-mask = <0x12b0ebf>;
-	};

-- 
2.48.0.rc1.219.gb6b6757d772



