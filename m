Return-Path: <dmaengine+bounces-3214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91348986976
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5421C21118
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2024 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F41A38F2;
	Wed, 25 Sep 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf0TTza1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696F12BEBB;
	Wed, 25 Sep 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306670; cv=none; b=qI2KcHz70sN89WXhbiIzswZ1AT2NvZuVLZzI0/z3A+q6eARt8PgYzjEoigWHlOyK3YyxWSTugDXQprDYPlo56p+EMSChSYRDFekm08dc1ckueSyn37Gozii94qR+dFU6gfxlm1ADO4PR/w6zWMS4Wg6zj42zVcnqg6WNETTZWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306670; c=relaxed/simple;
	bh=g3zNEuACkNKKF7DM2e0wUsD+QK9yDA1CFZXE6cxfm0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxXLqJ/pNN/WxH9zl2KS1VrVK9xkIvwBBpBPSfjiWIZx3m+lVVXQEGWg/2saD2/T3AnLd37zqGlMvhXQGVbq57UvG+8TADNmh9M6MF+SAGkNeP5flGkv1N6PYizDW5y9l0AvoukJcqfeHlofwlPjPy6bTch/1ykzeKFJubL6CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf0TTza1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF87C4CEC3;
	Wed, 25 Sep 2024 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727306670;
	bh=g3zNEuACkNKKF7DM2e0wUsD+QK9yDA1CFZXE6cxfm0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=rf0TTza1S3p1YALqFQOCom6Jm3i4y+VPz/1puW5DS6e880ny5qmARn/pd/8fBs2t1
	 H+kU9g7OoIXdRgMnbqXMAo+xn2K5IUNrX4Um6d5Kx2D1e+tYvFeSWoKQT3bgdXYj9W
	 0v+KcOIMJVKUH7cPijm0cHyM4JbEemZro3q2q5sfvola1hxVqM08tWdooSdOpDAU+3
	 aiJfMwgHXTFKN9GUXQ6RPKAeW/mkp6MDVGOlgzW67u/JFmuwPnvqM1S3qKzAI2Jpn3
	 EENwc0xldR/ocJgJZoovineWQvpe46VBWPrN2Bc4wCqf26JtgRzGd9xNEDw/AIKaA2
	 wRYObDcnba5wg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix array property constraints
Date: Wed, 25 Sep 2024 18:24:06 -0500
Message-ID: <20240925232409.2208515-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Schemas for array properties should only have 1 level of array
constraints (e.g. items, maxItems, minItems). Sometimes the old
encoding of all properties into a matrix leaked into the schema, and
didn't matter for validation. Now the inner constraints are just
silently ignored as json-schema array keywords are ignored on scalar
values.

Generally, keep the inner constraints and drop the outer "items". With
gicv3 "mbi-alias" property, it is more appropriately a uint32 or uint64
as it is an address and size depends on "#address-cells".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/cache/l2c2x0.yaml  |  5 ++---
 .../devicetree/bindings/dma/dma-common.yaml          |  7 +++----
 .../bindings/interrupt-controller/arm,gic-v3.yaml    | 12 +++++-------
 .../devicetree/bindings/media/i2c/thine,thp7312.yaml |  3 +--
 .../bindings/memory-controllers/exynos-srom.yaml     |  5 ++---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       |  5 ++---
 .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml     |  3 +--
 7 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/cache/l2c2x0.yaml b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
index d7840a5c4037..10c1a900202f 100644
--- a/Documentation/devicetree/bindings/cache/l2c2x0.yaml
+++ b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
@@ -100,9 +100,8 @@ properties:
       filter. Addresses in the filter window are directed to the M1 port. Other
       addresses will go to the M0 port.
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    items:
-      minItems: 2
-      maxItems: 2
+    minItems: 2
+    maxItems: 2
 
   arm,io-coherent:
     description: indicates that the system is operating in an hardware
diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
index ea700f8ee6c6..fde5160b5d29 100644
--- a/Documentation/devicetree/bindings/dma/dma-common.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
@@ -32,10 +32,9 @@ properties:
       The first item in the array is for channels 0-31, the second is for
       channels 32-63, etc.
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    items:
-      minItems: 1
-      # Should be enough
-      maxItems: 255
+    minItems: 1
+    # Should be enough
+    maxItems: 255
 
   dma-channels:
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 5f051c666cbe..f3247a47f9ee 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -132,10 +132,9 @@ properties:
       Address property. Base address of an alias of the GICD region containing
       only the {SET,CLR}SPI registers to be used if isolation is required,
       and if supported by the HW.
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    items:
-      minItems: 1
-      maxItems: 2
+    oneOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - $ref: /schemas/types.yaml#/definitions/uint64
 
   ppi-partitions:
     type: object
@@ -223,9 +222,8 @@ patternProperties:
           (u32, u32) tuple describing the untranslated
           address and size of the pre-ITS window.
         $ref: /schemas/types.yaml#/definitions/uint32-array
-        items:
-          minItems: 2
-          maxItems: 2
+        minItems: 2
+        maxItems: 2
 
     required:
       - compatible
diff --git a/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
index 535acf2b88a9..bc339a7374b2 100644
--- a/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml
@@ -135,8 +135,7 @@ properties:
 
           data-lanes:
             $ref: /schemas/media/video-interfaces.yaml#/properties/data-lanes
-            items:
-              maxItems: 4
+            maxItems: 4
             description:
               This property is for lane reordering between the THP7312 and the imaging
               sensor that it is connected to.
diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
index 10a2d97e5f8b..a5598ade399f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
@@ -66,9 +66,8 @@ patternProperties:
 
       samsung,srom-timing:
         $ref: /schemas/types.yaml#/definitions/uint32-array
-        items:
-          minItems: 6
-          maxItems: 6
+        minItems: 6
+        maxItems: 6
         description: |
           Array of 6 integers, specifying bank timings in the following order:
           Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 0925c520195a..2ad1652c2584 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -92,9 +92,8 @@ properties:
       may have two component regions -- base and extended -- so
       this information cannot be deduced from the dma-ranges.
     $ref: /schemas/types.yaml#/definitions/uint64-array
-    items:
-      minItems: 1
-      maxItems: 3
+    minItems: 1
+    maxItems: 3
 
   resets:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
index 141d666dc3f7..1ba1d419e83b 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
@@ -55,8 +55,7 @@ properties:
 
   qcom,smem:
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    items:
-      maxItems: 2
+    maxItems: 2
     description:
       Two identifiers of the inbound and outbound smem items used for this edge.
 
-- 
2.45.2


